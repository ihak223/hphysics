from cpython cimport array
import array
from libc.math cimport round

cdef list slope(x1, y1, x2, y2):
  return list([x2-x1, y2-y1])

cpdef list cycle(list dot, list col):
  cdef float x    = dot[0]
  cdef float y    = dot[1]
  cdef float dx   = dot[2]
  cdef float dy   = dot[3]
  cdef float vx   = dot[4]
  cdef float vy   = dot[5]
  cdef float mass = dot[6]

  cdef float gx = 0
  cdef float gy = 0
  
  cdef list sl
  for c in col:
    
    if round(x) == round(c[0]) and round(y) == round(c[1]):
      dx *= -0.01
      dy *= -0.01
    sl = slope(c[0], c[1], x, y)
    gx += ((sl[0]/-1000000)*c[6])/(mass/16)
    gy += ((sl[1]/-1000000)*c[6])/(mass/16)
  
  dx += gx
  dy += gy
  vx = dx/2
  vy = dy/2
  if round(x+vx) < 0 or round(x+vx) > 255:
    dx *= -0.01
    dy *= -0.01
  if round(y+vy) < 0 or round(y+vy) > 255:
    dx *= -0.01
    dy *= -0.01
  x += dx+vx
  y += dy+vy
  dx -= gx
  dy -= gy
  if vx != 0:
    vx -= vx/abs(vx)/10
  if vy != 0:
    vy -= vy/abs(vy)/10
  return list([x, y, dx, dy, vx, vy, mass])