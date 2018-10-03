     H AlwNull(*UsrCtl)

      /copy ez1srv_h         

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * EZ1PGM 
      *   EmpId     - input  - employee id
      *   EmpYears  - output - years of service
      *   EmpName   - output - name
      *   EmpTitle  - output - job title
      *   EmpSite   - output - web site
      *   EmpDate   - output - date last updated
      *   EmpTime   - output - time last updated
      *   EmpPic    - output - picture
      *   EmpTags   - output - cloud tags of interest
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D Main            PR                  ExtPgm('EZ1PGM') 
     D  EmpId                        10i 0
     D  EmpYears                      5p 0
     D  EmpName                     128a   varying(2)
     D  EmpTitle                    512a   varying(4)
     D  EmpSite                     512a   varying(4)
     D  EmpDate                        D   datfmt(*USA)
     D  EmpTime                        T   timfmt(*USA)
     D  EmpPic                   124000A   varying(4)
     D  EmpTags                  124000A   varying(4)
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * main(): Control flow
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D Main            PI 
     D  EmpId                        10i 0
     D  EmpYears                      5p 0
     D  EmpName                     128a   varying(2)
     D  EmpTitle                    512a   varying(4)
     D  EmpSite                     512a   varying(4)
     D  EmpDate                        D   datfmt(*USA)
     D  EmpTime                        T   timfmt(*USA)
     D  EmpPic                   124000A   varying(4)
     D  EmpTags                  124000A   varying(4)
      * vars
     D empRec          DS                  likeds(emp_t)
      /free
       empRec = empById(EmpId);
       EmpYears = empRec.EmpYears;
       EmpName = empRec.EmpName;
       EmpTitle = empRec.EmpTitle;
       EmpSite = empRec.EmpSite;
       EmpDate = empRec.EmpDate;
       EmpTime = empRec.EmpTime;
       EmpPic = empRec.EmpPic;
       EmpTags = empRec.EmpTags;
	   // Comment by Bruce Guetzkow 2017-01-18
	   // Hello Bruce, This is Kyle Law from Summit! 10-3-18
       return;
      /end-free

