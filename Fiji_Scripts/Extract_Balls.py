def run():

  projects = Project.getProjects()
  if projects is None or projects.isEmpty():
    IJ.log('No project open!')
    return
  p = projects.get(0)
  ls = p.getRootLayerSet()
  rpt = p.getRootProjectThing()

  sd = SaveDialog("Save as","ball.txt",".txt")

  fout = open(sd.getDirectory()+sd.getFileName(),"w")

  balls = ls.getZDisplayables(Ball)
  fout.write("\t".join(["Type", "Layer", "x-pos", "y-pos", "Radius", "\n"]))
  for b in balls:
      pt = rpt.findChild(b)
      for sub_ball in b.getWorldBalls():
      	  fout.write("\t".join([str(pt.getParent().getShortTitle()), '%d' %(sub_ball[2]), '%d' %(sub_ball[0]), '%d' %(sub_ball[1]), '%d' %(sub_ball[3]), "\n"]))
  fout.close()
run()
