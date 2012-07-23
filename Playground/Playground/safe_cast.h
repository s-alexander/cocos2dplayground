/*
 *  safe_cast.h
 *
 *  Created by Александр Сергеев on 12/14/10.
 *
 */

// Safe cast returns pointer to a specified type or nil

template<typename T, typename F> T * safe_cast(F * f) {
  if ([f isKindOfClass:[T class]]) {
    return (T*)f;
  }
  return nil;
}
