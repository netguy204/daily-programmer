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

#include <stdarg.h>
inline std::string string_format(const std::string& fmt, ...) {
  char buffer[2048];

  va_list args;
  va_start(args, fmt);

  vsnprintf(buffer, 2048, fmt.c_str(), args);

  va_end(args);

  return std::string(buffer);
}

#endif
