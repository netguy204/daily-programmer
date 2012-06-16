SOURCES = $(wildcard *.lzz)
STANDALONE_HEADERS = prim_mem.h

OBJECTS = $(patsubst %.lzz,%.o,$(SOURCES)) $(patsubst %.lzz,%.moc.o,$(SOURCES))
GENERATED_C = $(patsubst %.lzz,%.cpp,$(SOURCES))
GENERATED_H = $(patsubst %.lzz,%.h,$(SOURCES)) predeclares.h common_gen.h
GENERATED_MOC = $(patsubst %.lzz,%.moc.cpp,$(SOURCES))

HEADERS = $(GENERATED_H) $(STANDALONE_HEADERS)

LZZFLAGS=-Igc-7.2/include -I/usr/include `pkg-config --cflags QtCore`
CXXFLAGS+=$(LZZFLAGS) # -g
LDFLAGS+=`pkg-config --libs QtCore`

LZZHOME = lzz_2_8_2_src_gen
LZZ     = build_tools/lzz
PREPEND = build_tools/prepend.pl
PREDECL = build_tools/predeclares.pl
REPLDIF = build_tools/replace_if_different.sh
LZZDEPS = build_tools/lzz_deps.pl
LZZINLN = build_tools/lzz_inline.pl
LZZPREP = build_tools/lzz_preproc.pl

all: app $(GENERATED_H) $(GENERATED_C) $(GENERATED_MOC)

$(LZZ): $(LZZHOME)/lazycpp
	cp $(LZZHOME)/lazycpp $(LZZ)

$(LZZHOME)/lazycpp:
	cd lzz_2_8_2_src_gen ; make -f Makefile.release

libgc.a: gc-7.2/.libs/libgc.a
	cp gc-7.2/.libs/libgc.a libgc.a

gc-7.2/.libs/libgc.a:
	cd gc-7.2 ; ./configure --enable-cplusplus --enable-parallel-mark ; make

%.P : %.lzz
	$(LZZDEPS) $< $@

include $(SOURCES:.lzz=.P)

predeclares.h: $(SOURCES)
	@echo "Creating predeclares.h" ;\
	$(PREDECL) > pre_temp.h ;\
	$(REPLDIF) predeclares.h pre_temp.h ;\
	rm -f pre_temp.h

common_gen.h: common.h predeclares.h
	@echo "Creating common_gen.h" ;\
	cat common.h predeclares.h > common_gen.h

%.cpp %.h : %.lzz common_gen.h $(LZZ)
	@echo "Preprocessing $(patsubst %.lzz,%,$<)" ;\
	$(LZZ) $< $(CZZFLAGS) -hd -sd -hl -sl -c -DCOMMON_H ;\
	$(PREPEND) $(patsubst %.lzz,%.h,$<) '#include "common_gen.h"'
	$(LZZINLN) $(patsubst %.lzz,%.h,$<)

%.moc.cpp : %.h
	moc $< -o $@

%.o : %.cpp
	$(CXX) -c $< $(CXXFLAGS)

app: $(OBJECTS) main.cpp libgc.a
	$(CXX) -o $@ main.cpp $(CXXFLAGS) $(OBJECTS) libgc.a $(LDFLAGS)

clean:
	rm -f app *.o $(GENERATED_C) $(GENERATED_H) $(GENERATED_MOC) $(LZZ) libgc.a *.P
