from pydots import cycle
import random
import json
import pygame


print('starting')

dots = []
i = 0 
while i < 255:
  dots.append([i, random.randint(2, 254), 0, 0, 0, 0, random.randint(1, 5)])
  i += 1
dots.append([120, 130, 0, 0, 0, 0, 20])

j = 0

while j < 10:
  dn = dots
  for c in range(len(dots)):
    dn[c] = cycle(dots[c], dots[:c]+dots[c+1:])
  dots = dn
  j += 1



pygame.init()

surf = pygame.display.set_mode((256, 256))
clock = pygame.time.Clock()

running = True

while running:
  for event in pygame.event.get():
    if event.type == pygame.QUIT:
      running = False
    if event.type == pygame.MOUSEBUTTONDOWN:
      x, y = pygame.mouse.get_pos()
      dots.append([x, y, 0, 0, 0, 0, 10])
  surf.fill((0, 0, 0))
  dn = dots
  for c in range(len(dots)):
    dn[c] = cycle(dots[c], dots[:c]+dots[c+1:])
  dots = dn
  for d in dots:
    surf.set_at((round(d[0]), round(d[1])), (255, 255, 255))
  pygame.display.flip()
  clock.tick(30)

print('dumping')
j = json.dumps(dots)
file = open('dump.json', 'w')
print(j)
file.write(j)
file.close()

