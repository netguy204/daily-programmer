#ifndef COMMON_H
#define COMMON_H

#include <gc_cpp.h>
#include <gc.h>

#include <string>
#include <map>
#include <stdexcept>
#include <string>

#include <QtGui>
#include "boost/typeof/typeof.hpp"

#define FOREACH(var, coll) for(BOOST_AUTO(var, coll.begin()); var != coll.end(); ++var)
#endif
