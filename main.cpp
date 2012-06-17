#include "common.h"

#include <QtGui>
#include <iostream>

#include "Canvas.h"

using namespace std;

int main(int argc, char ** argv) {
  GC_INIT();
  GC_enable_incremental();

  QApplication app(argc, argv);
  Canvas canvas;
  canvas.show();

  return app.exec();
}
