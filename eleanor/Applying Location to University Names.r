# Both of these codes work on the assumption that the column with the university names is called "Institution", so if there are any errors that's the first place to look.

# This thing creates a column of the regions corrosponding with the institute.
Location= function(DatasetName){
  Institution= DatasetName$Institution 
  ifelse(Institution %in% 
  c("Queen's University Belfast","St Mary's University College","Stranmillis University College","University of Ulster"), 
  "Northern Ireland", 
  (ifelse(Institution %in% 
  c("Open University"), 
  "Distance Learning", 
  (ifelse(Institution %in%
  c("Anglia Ruskin University" ,"Cranfield University" ,"Norwich University of the Arts" ,"University of Bedfordshire" ,"University of Cambridge" ,"University of East Anglia" ,"University of Essex" ,"University of Hertfordshire" ,"Writtle College" ,"Bishop Grosseteste University" ,"De Montfort University" ,"Loughborough University" ,"Nottingham Trent University" ,"University of Derby" ,"University of Leicester" ,"University of Lincoln" ,"University of Northampton" ,"University of Nottingham"),
  "East England",
  (ifelse(Institution %in%
  c("University of London Institute in Paris"),	
  "France",
  (ifelse(Institution %in%
  c("Birkbeck College","Brunel University London","City University London","Courtauld Institute of Art","Goldsmiths' College","Guildhall School of Music & Drama","Heythrop College","Imperial College London","Institute of Cancer Research","Institute of Zoology","King's College London","Kingston University","London Business School","London Metropolitan University","London School of Economics and Political Science","London School of Hygiene & Tropical Medicine","London South Bank University","Middlesex University","Queen Mary University of London","Roehampton University","Rose Bruford College","Royal Academy of Music","Royal Central School of Speech and Drama","Royal College of Art","Royal College of Music","Royal Holloway, University of London","Royal Veterinary College","School of Oriental and African Studies","St Mary's University, Twickenham","St.George's, University of London","The University of West London","Trinity Laban Conservatoire of Music and Dance","University College London","University of East London","University of Greenwich","University of the Arts, London","University of Westminster"),
  "London",
  (ifelse(Institution %in%
  c("Newcastle University","Teesside University","University of Durham","University of Northumbria at Newcastle","University of Sunderland"),
  "North East England",
  (ifelse(Institution %in%
  c("Edge Hill University","Lancaster University","Liverpool Hope University","Liverpool John Moores University","Liverpool School of Tropical Medicine","Manchester Metropolitan University","Royal Northern College of Music","University of Bolton","University of Central Lancashire","University of Chester","University of Cumbria","University of Liverpool","University of Manchester","University of Salford"),
  "North West England",
  (ifelse(Institution %in%
  c("Edinburgh Napier University","Glasgow Caledonian University","Glasgow School of Art","Heriot-Watt University","Queen Margaret University Edinburgh","Robert Gordon University","Royal Conservatoire of Scotland","SRUC","University of Aberdeen","University of Abertay Dundee","University of Dundee","University of Edinburgh","University of Glasgow","University of St Andrews","University of Stirling","University of Strathclyde","University of the Highlands and Islands","University of the West of Scotland"),
  "Scotland",
  (ifelse(Institution %in%
  c("Buckinghamshire New University","Canterbury Christ Church University","Oxford Brookes University","Southampton Solent University","University for the Creative Arts","University of Brighton","University of Chichester","University of Kent","University of Oxford","University of Portsmouth","University of Reading","University of Southampton","University of Surrey","University of Sussex","University of Winchester"),
  "South East England",
  (ifelse(Institution %in%
  c("Arts University Bournemouth","Bath Spa University","Bournemouth University","Falmouth University","Royal Agricultural University","University of Bath","University of Bristol","University of Exeter","University of Gloucestershire","University of Plymouth","University of the West of England, Bristol"),  
  "South West England",
  (ifelse(Institution %in%
  c("Aberystwyth University","Bangor University","Cardiff Metropolitan University","Cardiff University","Glynd?r University","Swansea University","University of South Wales","University of Wales","University of Wales Trinity Saint David"),
  "Wales",
  (ifelse(Institution %in%
  c("Aston University","Birmingham City University","Coventry University","Harper Adams University","Keele University","Newman University","Staffordshire University","University of Birmingham","University of Warwick","University of Wolverhampton","University of Worcester"),
  "West Midlands",
  (ifelse(Institution %in%
  c("Leeds Beckett University","Leeds Trinity University","Sheffield Hallam University","University of Bradford","University of Huddersfield","University of Hull","University of Leeds","University of Sheffield","University of York","York St John University"),
  "Yorkshire and the Humber",
  "whoops")))))))))))))))))))))))))}
  
# This thing runs the above function and sticks it to the dataset 
Regionfy= function(DatasetName){
  Region= Location(DatasetName)
  RegionsAdded= cbind(DatasetName,Region)
  return(RegionsAdded)
}
