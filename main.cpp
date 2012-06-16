#include "common.h"
#include "Object.h"

#include <iostream>

using namespace std;

int main(int argc, char ** argv) {
  GC_INIT();
  GC_enable_incremental();

  Object *obj = new Object();
  obj->setA(100);

  cout << "wrote some stuff " << obj->getA() << endl;

  QObject * newObj = obj->metaObject()->newInstance();
  cout << newObj->metaObject()->className() << endl;

  GC_gcollect();

  return 0;
}
