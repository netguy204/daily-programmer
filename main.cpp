#include "common.h"

#include <QtGui>
#include <iostream>

#include "Object.h"

using namespace std;

int main(int argc, char ** argv) {
  GC_INIT();
  GC_enable_incremental();

  QApplication app(argc, argv);
  Object obj;
  obj.show();

  return app.exec();
}
