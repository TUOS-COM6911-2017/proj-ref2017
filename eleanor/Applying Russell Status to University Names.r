# These codes rely on the column containing the uni names to be called Institution, otherwise go willddddd

Russell_Status= function(DatasetName){
  Institution= DatasetName$Institution 
  ifelse(Institution %in% 
           c("Cardiff University","Imperial College London","King's College London","London School of Economics and Political Science","Newcastle University","Queen's University Belfast","Queen Mary University of London","University College London","University of Birmingham","University of Bristol","University of Cambridge","University of Durham","University of Edinburgh","University of Exeter","University of Glasgow","University of Leeds","University of Liverpool","University of Manchester","University of Nottingham","University of Oxford","University of Sheffield","University of Southampton","University of Warwick","University of York"), 
         "Russell", "Non-Russell")
}

Russellfy= function(DatasetName){
  Group= Russell_Status(DatasetName)
  jimmiesrusselled= cbind(DatasetName,Group)
  return(jimmiesrusselled)
}