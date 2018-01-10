     H NOMAIN          
     H AlwNull(*UsrCtl)          

      /copy ez1srv_h

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * employee fake database
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       dcl-s emp_ok ind inz(*OFF);
       dcl-ds empRecs likeds(emp_t) dim(EMP_MAX);

       dcl-pr empInit;
       end-pr;

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * employee by any 
      *   flag - type search
      *   search - search partial
      *   max    - max records expected
      *   recs   - records found
      * return (int - nbr records found)
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       dcl-c EMP_BY_ID const(1);
       dcl-c EMP_BY_PARTIAL_NAME const(2);
       dcl-c EMP_BY_PARTIAL_TITLE const(3);
       dcl-c EMP_BY_PARTIAL_TAG const(4);

       dcl-pr empByAny int(12);
         flag int(10) value;
         search varchar(128:2) value;
         max int(10) value;
         recs likeds(emp_t) dim(EMP_MAX);
       end-pr;

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * employee init fake database
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       dcl-proc empInit;
       dcl-pi *N;
       end-pi;

       if emp_ok = *ON;
         empRecs(1).EmpId = 1;
         empRecs(1).EmpYears = 10;
         empRecs(1).EmpName = 'Alan Seiden';
         empRecs(1).EmpTitle = 'Consultant and Author PHP Toolkit.';
         empRecs(1).EmpSite = 'http://www.alanseiden.com/';
         empRecs(1).EmpDate = d'2016-05-31';
         empRecs(1).EmpTime = t'12.07.51';
         empRecs(1).EmpPic = i_smile();
         empRecs(1).EmpTags = 'php zf2 club seiden db2'
                            + ' toolkit';

         empRecs(2).EmpId = 2;
         empRecs(2).EmpYears = 10;
         empRecs(2).EmpName = 'Tony Cairns';
         empRecs(2).EmpTitle = 'Author XMLSERVICE.';
         empRecs(2).EmpSite = 'http://yips.idevcloud.com/';
         empRecs(2).EmpDate = d'2016-05-31';
         empRecs(2).EmpTime = t'12.07.52';
         empRecs(2).EmpPic = i_suprise();
         empRecs(2).EmpTags = 'php python nodejs javascript rpg'
                            + ' c pase open source gcc xlc db2'
                            + ' toolkit';

         empRecs(3).EmpId = 3;
         empRecs(3).EmpYears = 10;
         empRecs(3).EmpName = 'Mike Pavlak';
         empRecs(3).EmpTitle = 'Zend Server for IBM i';
         empRecs(3).EmpSite = 'http://mikepavlak.blogspot.com/';
         empRecs(3).EmpDate = d'2016-05-31';
         empRecs(3).EmpTime = t'12.07.53';
         empRecs(3).EmpPic = i_cool();
         empRecs(3).EmpTags = 'php zf2 mysql maria'
                            + ' toolkit';

         empRecs(4).EmpId = 4;
         empRecs(4).EmpYears = 8;
         empRecs(4).EmpName = 'Clark Everetts';
         empRecs(4).EmpTitle = 'Zend Server for IBM i';
         empRecs(4).EmpSite = 'https://github.com/clarkphp?tab=repositories';
         empRecs(4).EmpDate = d'2016-05-31';
         empRecs(4).EmpTime = t'12.07.54';
         empRecs(4).EmpPic = i_grin();
         empRecs(4).EmpTags = 'php zf2 composer'
                            + ' toolkit';

         empRecs(5).EmpId = 5;
         empRecs(5).EmpYears = 5;
         empRecs(5).EmpName = 'Stephanie Rabbani';
         empRecs(5).EmpTitle = 'Senior Web Developer';
         empRecs(5).EmpSite = 'http://www.bcdsoftware.com/iseries400services/';
         empRecs(5).EmpDate = d'2016-05-31';
         empRecs(5).EmpTime = t'12.07.54';
         empRecs(5).EmpPic = i_blush();
         empRecs(5).EmpTags = 'php zf2 composer rpg nodejs club seiden'
                            + ' toolkit';

         empRecs(6).EmpId = 6;
         empRecs(6).EmpYears = 5;
         empRecs(6).EmpName = 'Chuck Shirley';
         empRecs(6).EmpTitle = 'Sure Consulting';
         empRecs(6).EmpSite = 'http://www.sureconsulting.com/';
         empRecs(6).EmpDate = d'2016-05-31';
         empRecs(6).EmpTime = t'12.07.54';
         empRecs(6).EmpPic = i_spock();
         empRecs(6).EmpTags = 'php zf2 composer ddd club seiden'
                            + ' toolkit';

         empRecs(7).EmpId = EMP_MAX;
         empRecs(7).EmpYears = -1;
         empRecs(7).EmpName = 'Error';
         empRecs(7).EmpTitle = 'Error';
         empRecs(7).EmpSite = 'Error';
         empRecs(7).EmpDate = d'2016-05-31';
         empRecs(7).EmpTime = t'10.10.10';
         empRecs(7).EmpPic = i_sad();
         empRecs(7).EmpTags = 'Error';

         emp_ok = *ON;
       endif;

       end-proc;

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * employee by id 
      *   id - id number of employee
      * return (emp_t - employee record)
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       dcl-proc empById export;
       dcl-pi *N likeds(emp_t);
         id int(10);
       end-pi;

       dcl-ds empRec likeds(emp_t);
       dcl-s count int(10) inz(0);
       dcl-ds empRecSet likeds(emp_t) dim(EMP_MAX);

       count = empByAny(EMP_BY_ID:%char(id):1:empRecSet);
       if count > 0;
         empRec = empRecSet(1);
       else;
         empRec = empRecs(EMP_MAX);
       endif;

       return empRec;
       end-proc;

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * employee by partial name 
      *   search - partial employee name
      *   max    - max records expected
      *   count  - number records found
      *   recs   - records found
      * return (na)
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       dcl-proc empByName export;
       dcl-pi *N;
         search varchar(128:2);
         max int(10);
         count int(10);
         recs likeds(emp_t) dim(EMP_MAX);
       end-pi;
       count = empByAny(EMP_BY_PARTIAL_NAME:search:max:recs);
       if count < 1;
         count = 1;
         recs(1) = empRecs(EMP_MAX);
       endif;
       end-proc;

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * employee by partial cloud tag 
      *   search - partial cloud tag interest
      *   max    - max records expected
      *   count  - number records found
      *   recs   - records found
      * return (na)
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       dcl-proc empByTag export;
       dcl-pi *N;
         search varchar(128:2);
         max int(10);
         count int(10);
         recs likeds(emp_t) dim(EMP_MAX);
       end-pi;
       count = empByAny(EMP_BY_PARTIAL_TAG:search:max:recs);
       if count < 1;
         count = 1;
         recs(1) = empRecs(EMP_MAX);
       endif;
       end-proc;

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * employee by partial Title
      *   search - partial title
      *   max    - max records expected
      *   count  - number records found
      *   recs   - records found
      * return (na)
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       dcl-proc empByTitle export;
       dcl-pi *N;
         search varchar(128:2);
         max int(10);
         count int(10);
         recs likeds(emp_t) dim(EMP_MAX);
       end-pi;
       count = empByAny(EMP_BY_PARTIAL_TITLE:search:max:recs);
       if count < 1;
         count = 1;
         recs(1) = empRecs(EMP_MAX);
       endif;
       end-proc;

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * employee by any 
      *   flag - type search
      *   search - search partial
      *   max    - max records expected
      *   recs   - records found
      * return (int - nbr records found)
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       dcl-proc empByAny;
       dcl-pi *N int(10);
         flag int(10) value;
         search varchar(128:2) value;
         max int(10) value;
         recs likeds(emp_t) dim(EMP_MAX);
       end-pi;

       dcl-s i int(10) inz(0);
       dcl-s j int(10) inz(0);
       dcl-s id int(10) inz(0);

       empInit();

       select;
       when flag = EMP_BY_ID;
         id = %int(%trim(search));
       when flag = EMP_BY_PARTIAL_NAME;
         id = 0;
       when flag = EMP_BY_PARTIAL_TITLE;
         id = 0;
       when flag = EMP_BY_PARTIAL_TAG;
         id = 0;
       other;
         return j;
       endsl;

       for i = 1 to EMP_MAX;
         if max < j + 1;
           leave;
         endif;
         select;
         when flag = EMP_BY_ID and id = empRecs(i).EmpId;
           j += 1;
           recs(j) = empRecs(i);
         when flag = EMP_BY_PARTIAL_NAME;
           id = %scan(%trim(search):empRecs(i).EmpName);
           if id > 0;
             j += 1;
             recs(j) = empRecs(i);
           endif;
         when flag = EMP_BY_PARTIAL_TITLE;
           id = %scan(%trim(search):empRecs(i).EmpTitle);
           if id > 0;
             j += 1;
             recs(j) = empRecs(i);
           endif;
         when flag = EMP_BY_PARTIAL_TAG;
           id = %scan(%trim(search):empRecs(i).EmpTags);
           if id > 0;
             j += 1;
             recs(j) = empRecs(i);
           endif;
         other;
         endsl;
       endfor;
       return j;
       end-proc;

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * base64 images 
      *   <img src="data:image/gif;base64,+ i_smile() + " />
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

       dcl-proc i_smile export;
       dcl-pi *N varchar(124000:4);
       end-pi;
       return   'R0lGODlhEgASAOZ1ADMzmf/lIsvLy5i'
              + 'YmNbW1qSkpG5uboSEhP/lIf/kIP//mf/'
              + 'mIv/mI/vYD/C2AP/jH8rKyoB+ef/kH//'
              + 'iHWhfTPvXDffLAPfMAPzZEf/kIeyrAH9'
              + '9eP7jH/7hHf7gG/C3APK9APfKAPjMAIl'
              + 'sMOmiAO+xAKF+Jv3dF++yAPrTCPbJAPv'
              + 'XDuecAP3fGf7iHY97L/jOAvPBAOq4BYB'
              + 'kMN2TBfbIAPzbE4NrMPvaEYVzMJxxJvC'
              + '4AGlhTPO/AI56MOSmBb6eGN6WBv7iHrR'
              + '9GO3BBuvABrd/F41zMP7fGfbKAMSeF/r'
              + 'SB4FpMPPCAOGjBeq+BvK/AH9+eI97MLi'
              + 'EF9qRBcSjF4pvMPrUCmpiTOy+BvTCAOe'
              + '1Bd+ZBv3cFvzbFOyqALyYGO3HC9iSBra'
              + 'DGKeOJoloMP/nI/HKC2hgTPvZEIhpMNi'
              + 'UBv3eGP7hHO2uAPTDAI53L/7fGo11MGh'
              + 'hTIlpL////wAAAAAAAAAAAAAAAAAAAAA'
              + 'AAAAAAAAAAAAAAAAAACH/C05FVFNDQVB'
              + 'FMi4wAwEAAAAh+QQFCgB1ACwAAAAAEgA'
              + 'SAAAH/4B1goICBQcGBgcFAoONdQQDcz5'
              + 'ARFlgcmgDBI4QETlhFRgYK0shWzcREIM'
              + 'EG2QVXXETEx4nDSIgJlGbdQNSFUgAAA8'
              + 'JCcENFh9WA3UCWGcnAAEBCRkIGQEAKVo'
              + '/FIUvFR4PCgAICNgKHWkqJSOGVRgT4tE'
              + 'L5xI2Fg5Th0XwCeMLDOp5ueBgDaInK9o'
              + 'kkAbQTEAOOJKgEJNISQo21BAAZMAAAYc'
              + 'rbzQYUQQnRIMED8wtWIDABYcLO0jQWcR'
              + 'DhogGDzpIkCCkhQsYPTTQ6MbrCAgLDTq'
              + '0ANCixQUobliUWfZogwkHMWpYuKCiyYc'
              + 'vLHRs2FWnExMnJRw4QKGBBJUZqRYcQaI'
              + 'wYgyXIEPUUNDkaFChQ4kWOQoEACH5BAU'
              + 'KAHUALAcADQADAAEAAAcEgACCgQAh+QQ'
              + 'FCgB1ACwGAA0ABQABAAAHBYAAgoKBACH'
              + '5BAUKAHUALAQACwAJAAIAAAcLgAB1g4R'
              + '1goKFgoEAIfkEBWQAdQAsBAAKAAkAAQA'
              + 'ABwiAAHWDhHUAgQA7'
              + x'00';
       end-proc;

       dcl-proc i_suprise export;
       dcl-pi *N varchar(124000:4);
       end-pi;
       return   'R0lGODlhFAASAOZ2AP/mI//jH//mIvv'
              + 'YD/C2AP/kIPzZEWhfTP/iHYB+efvXDff'
              + 'LAMrKyvvaEffMAP/kIeyrAH99ePfKAPC'
              + '3AOecAP3fGe+xAP7gGvrTCKF+JumiAPK'
              + '9APvXDolsMPjMAP3eGPvZEP/kH/7hHe+'
              + 'yAPrUCv3dF/zbFP7gG/zbE/bJAPTDAOG'
              + 'jBfbKAIBkMIlpL4hpMP7fGfrSB9iUBu3'
              + 'HC9qRBYVzMO2uAL6eGGhhTN2TBf3cFti'
              + 'SBrR9GOq4BeyqAI1zMP7iHf3gGsSjF+3'
              + 'BBraDGIFpMJxxJmpiTIpvMI11MPPCAGl'
              + 'hTPjOAv/nI+y+BvPBAOq+BqeOJt6WBn9'
              + '+eI97L/7hHPC4ALyYGMSeF/HKC+vABue'
              + '1BYNrMLd/F2hgTI56MPTCAI53L/O/AP7'
              + 'jH+SmBd+ZBriEF/bIAPK/AI97MIloMP7'
              + 'fGv/lIaSkpISEhMvLy25ubpiYmNbW1v/'
              + 'lIv//mTMzmf///wAAAAAAAAAAAAAAAAA'
              + 'AAAAAAAAAAAAAAAAAACH/C05FVFNDQVB'
              + 'FMi4wAwEAAAAh+QQJZAB2ACwAAAAAFAA'
              + 'SAAAH/4B2goJvbW5wcG5tb4ONg3JxOF8'
              + '3Q05XSV5xco6CDAk1MwoGBhwxEltcCQy'
              + 'OchFRCjp1CAh1JQMeGxlTm4NxaQowdQE'
              + 'BBQV1FwMLE0hxg29HWSV1c3MFD2wPdRU'
              + 'YYGQHjHZtVAonAXR1bGx1dGwiICkWHW2'
              + 'CbkIGCObTAutzISgLBMy4EQRHy70C5wQ'
              + 'A4BfChAMCMuAQhMKhSgFqCpsAmDOmAYs'
              + 'ROyTacYMFw4cA1xQCAMAmCAkVELoMDBd'
              + 'GwoALAeroFMAGSAMHVjS4mGfnzZIeHgZ'
              + '8EKFTWwMmYiDk+Nbrx4YFA0A0JeEAjQ0'
              + 'Kapo9ipCBwJMzC3QqmeCDgpEIvCYGeSq'
              + 'ywgIBAiMgaKDRQhUnO5AOdCBSRgqPFwc'
              + '0/XVmCJEicI4CAQAh+QQJCgB2ACwAAAA'
              + 'AFAASAAAH/4B2goN2b21ucHBubW+EjnZ'
              + 'ycThfN0NOV0lecXKPdgwJNTMKBgYcMRJ'
              + 'bXAkMjnIRUQo6dQgIdSUDHhsZU5yDcWk'
              + 'KMHUBAQUFdRcDCxNIcYNvR1kldXNzBQ9'
              + 'sD3UVGGBkB412bVQKJwF0dWxsdXRsIiA'
              + 'pFh1tgm5CBgjn1ALscyEoCwiYcSMIjhZ'
              + '8BdAJANAvhAkHBGTAKQiFQ5UC1RY2ATB'
              + 'nTAMWI3ZMtOMGC4YPAbAtBACATRASKiB'
              + '0ISgujIQBFwLU2SmADZAGDqxocEGv0JI'
              + 'eHgZ8ELFzWwMmYiDkAOfrx4YFA0A0JeE'
              + 'AjQ0KapwNcpWBwJMzC3YqmeCDgpEIvSU'
              + 'GfSqywgIBAiMgaKDRYlWnSAc6ECkjhce'
              + 'LA5s6PTuUaFG4QYEAACH5BAkKAHYALAA'
              + 'AAAAUABIAAAf/gHaCgm9tbnBwbm1vg42'
              + 'DcnE4XzdDTldJXnFyjoIMCTUzCgYGHDE'
              + 'SW1wJDI5yEVEKOnUICHUlAx4bGVObg3F'
              + 'pCjB1AQEFBXUXAwsTSHGDb0dZJXVzcwU'
              + 'PbA91FRhgZAeMdm1UCicBdHVsbHV0bCI'
              + 'gKRYdbYJuQgYI5tMC63MhKAsEzLgRBEf'
              + 'LvQLnBADgF8KEAwIy4BCEwqFKAWoKmwC'
              + 'YM6YBixE7JNpxgwXDhwDXFAIAwCYICRU'
              + 'QugwMF0bCgAsB6ugUwAZIAwdWNLiYZ+f'
              + 'Nkh4eBnwQoVNbAyZiIOT41uvHhgUDQDQ'
              + 'l4QCNDQpqmj2KkIHAkzMLdCqZ4IOCkQi'
              + '8JgZ5KrLCAgECIyBooNFCFSc7kA50IFJ'
              + 'GCo8XBzT9dWYIkSJwjgIBACH5BAkKAHY'
              + 'ALAAAAAAUABIAAAf/gHaCg3ZvbW5wcG5'
              + 'tb4SOdnJxOF83Q05XSV5xco92DAk1Mwo'
              + 'GBhwxEltcCQyOchFRCjp1CAh1JQMeGxl'
              + 'TnINxaQowdQEBBQV1FwMLE0hxg29HWSV'
              + '1c3MFD2wPdRUYYGQHjXZtVAonAXR1bGx'
              + '1dGwiICkWHW2CbkIGCOfUAuxzISgLCJh'
              + 'xIwiOFnwF0AkA0C+ECQcEZMApCIVDlQL'
              + 'VFjYBMGdMAxYjdky04wYLhg8BsC0EAIB'
              + 'NEBIqIHQhKC6MhAEXAtTZKYANkAYOrGh'
              + 'wQa/Qkh4eBnwQsXNbAyZiIOQA5+vHhgU'
              + 'DQDQl4QCNDQpqnA1ylYHAkzMLdiqZ4IO'
              + 'CkQi9JQZ9KrLCAgECIyBooNFiVadIBzo'
              + 'QKSOFx4sDmzo9O5RoUbhBgQAAIfkECQo'
              + 'AdgAsAAAAABQAEgAAB/+AdoKCb21ucHB'
              + 'ubW+DjYNycThfN0NOV0lecXKOggwJNTM'
              + 'KBgYcMRJbXAkMjnIRUQo6dQgIdSUDHhs'
              + 'ZU5uDcWkKMHUBAQUFdRcDCxNIcYNvR1k'
              + 'ldXNzBQ9sD3UVGGBkB4x2bVQKJwF0dWx'
              + 'sdXRsIiApFh1tgm5CBgjm0wLrcyEoCwT'
              + 'MuBEER8u9AucEAOAXwoQDAjLgEITCoUo'
              + 'BagqbAJgzpgGLETsk2nGDBcOHANcUAgD'
              + 'AJggJFRC6DAwXRsKACwHq6BTABkgDB1Y'
              + '0uJhn582SHh4GfBChU1sDJmIg5PjW68e'
              + 'GBQNANCXhAI0NCmqaPYqQgcCTMwt0Kpn'
              + 'gg4KRCLwmBnkqssICAQIjIGig0UIVJzu'
              + 'QDnQgUkYKjxcHNP11ZgiRInCOAgEAIfk'
              + 'ECQoAdgAsAAAAABQAEgAAB/+AdoKDdm9'
              + 'tbnBwbm1vhI52cnE4XzdDTldJXnFyj3Y'
              + 'MCTUzCgYGHDESW1wJDI5yEVEKOnUICHU'
              + 'lAx4bGVOcg3FpCjB1AQEFBXUXAwsTSHG'
              + 'Db0dZJXVzcwUPbA91FRhgZAeNdm1UCic'
              + 'BdHVsbHV0bCIgKRYdbYJuQgYI59QC7HM'
              + 'hKAsImHEjCI4WfAXQCQDQL4QJBwRkwCk'
              + 'IhUOVAtUWNgEwZ0wDFiN2TLTjBguGDwG'
              + 'wLQQAgE0QEiogdCEoLoyEARcC1NkpgA2'
              + 'QBg6saHBBr9CSHh4GfBCxc1sDJmIg5AD'
              + 'n68eGBQNANCXhAI0NCmqcDXKVgcCTMwt'
              + '2Kpngg4KRCL0lBn0qssICAQIjIGig0WJ'
              + 'Vp0gHOhApI4XHiwObOj07lGhRuEGBAAA'
              + 'h+QQJCgB2ACwAAAAAFAASAAAH/4B2goJ'
              + 'vbW5wcG5tb4ONg3JxOF83Q05XSV5xco6'
              + 'CDAk1MwoGBhwxEltcCQyOchFRCjp1CAh'
              + '1JQMeGxlTm4NxaQowdQEBBQV1FwMLE0h'
              + 'xg29HWSV1c3MFD2wPdRUYYGQHjHZtVAo'
              + 'nAXR1bGx1dGwiICkWHW2CbkIGCObTAut'
              + 'zISgLBMy4EQRHy70C5wQA4BfChAMCMuA'
              + 'QhMKhSgFqCpsAmDOmAYsROyTacYMFw4c'
              + 'A1xQCAMAmCAkVELoMDBdGwoALAeroFMA'
              + 'GSAMHVjS4mGfnzZIeHgZ8EKFTWwMmYiD'
              + 'k+Nbrx4YFA0A0JeEAjQ0Kapo9ipCBwJM'
              + 'zC3QqmeCDgpEIvCYGeSqywgIBAiMgaKD'
              + 'RQhUnO5AOdCBSRgqPFwc0/XVmCJEicI4'
              + 'CAQAh+QQJCgB2ACwAAAAAFAASAAAH/4B'
              + '2goN2b21ucHBubW+EjnZycThfN0NOV0l'
              + 'ecXKPdgwJNTMKBgYcMRJbXAkMjnIRUQo'
              + '6dQgIdSUDHhsZU5yDcWkKMHUBAQUFdRc'
              + 'DCxNIcYNvR1kldXNzBQ9sD3UVGGBkB41'
              + '2bVQKJwF0dWxsdXRsIiApFh1tgm5CBgj'
              + 'n1ALscyEoCwiYcSMIjhZ8BdAJANAvhAk'
              + 'HBGTAKQiFQ5UC1RY2ATBnTAMWI3ZMtOM'
              + 'GC4YPAbAtBACATRASKiB0ISgujIQBFwL'
              + 'U2SmADZAGDqxocEGv0JIeHgZ8ELFzWwM'
              + 'mYiDkAOfrx4YFA0A0JeEAjQ0KapwNcpW'
              + 'BwJMzC3YqmeCDgpEIvSUGfSqywgIBAiM'
              + 'gaKDRYlWnSAc6ECkjhceLA5s6PTuUaFG'
              + '4QYEAACH5BAkKAHYALAAAAAAUABIAAAf'
              + '/gHaCgm9tbnBwbm1vg42DcnE4XzdDTld'
              + 'JXnFyjoIMCTUzCgYGHDESW1wJDI5yEVE'
              + 'KOnUICHUlAx4bGVObg3FpCjB1AQEFBXU'
              + 'XAwsTSHGDb0dZJXVzcwUPbA91FRhgZAe'
              + 'Mdm1UCicBdHVsbHV0bCIgKRYdbYJuQgY'
              + 'I5tMC63MhKAsEzLgRBEfLvQLnBADgF8K'
              + 'EAwIy4BCEwqFKAWoKmwCYM6YBixE7JNp'
              + 'xgwXDhwDXFAIAwCYICRUQugwMF0bCgAs'
              + 'B6ugUwAZIAwdWNLiYZ+fNkh4eBnwQoVN'
              + 'bAyZiIOT41uvHhgUDQDQl4QCNDQpqmj2'
              + 'KkIHAkzMLdCqZ4IOCkQi8JgZ5KrLCAgE'
              + 'CIyBooNFCFSc7kA50IFJGCo8XBzT9dWY'
              + 'IkSJwjgIBACH5BAkKAHYALAAAAAAUABI'
              + 'AAAf/gHaCg3ZvbW5wcG5tb4SOdnJxOF8'
              + '3Q05XSV5xco92DAk1MwoGBhwxEltcCQy'
              + 'OchFRCjp1CAh1JQMeGxlTnINxaQowdQE'
              + 'BBQV1FwMLE0hxg29HWSV1c3MFD2wPdRU'
              + 'YYGQHjXZtVAonAXR1bGx1dGwiICkWHW2'
              + 'CbkIGCOfUAuxzISgLCJhxIwiOFnwF0Ak'
              + 'A0C+ECQcEZMApCIVDlQLVFjYBMGdMAxY'
              + 'jdky04wYLhg8BsC0EAIBNEBIqIHQhKC6'
              + 'MhAEXAtTZKYANkAYOrGhwQa/Qkh4eBnw'
              + 'QsXNbAyZiIOQA5+vHhgUDQDQl4QCNDQp'
              + 'qnA1ylYHAkzMLdiqZ4IOCkQi9JQZ9KrL'
              + 'CAgECIyBooNFiVadIBzoQKSOFx4sDmzo'
              + '9O5RoUbhBgQAAIfkECQoAdgAsAAAAABQ'
              + 'AEgAAB/+AdoKCb21ucHBubW+DjYNycTh'
              + 'fN0NOV0lecXKOggwJNTMKBgYcMRJbXAk'
              + 'MjnIRUQo6dQgIdSUDHhsZU5uDcWkKMHU'
              + 'BAQUFdRcDCxNIcYNvR1kldXNzBQ9sD3U'
              + 'VGGBkB4x2bVQKJwF0dWxsdXRsIiApFh1'
              + 'tgm5CBgjm0wLrcyEoCwTMuBEER8u9Auc'
              + 'EAOAXwoQDAjLgEITCoUoBagqbAJgzpgG'
              + 'LETsk2nGDBcOHANcUAgDAJggJFRC6DAw'
              + 'XRsKACwHq6BTABkgDB1Y0uJhn582SHh4'
              + 'GfBChU1sDJmIg5PjW68eGBQNANCXhAI0'
              + 'NCmqaPYqQgcCTMwt0Kpngg4KRCLwmBnk'
              + 'qssICAQIjIGig0UIVJzuQDnQgUkYKjxc'
              + 'HNP11ZgiRInCOAgEAIfkECQoAdgAsAAA'
              + 'AABQAEgAAB/+AdoKDdm9tbnBwbm1vhI5'
              + '2cnE4XzdDTldJXnFyj3YMCTUzCgYGHDE'
              + 'SW1wJDI5yEVEKOnUICHUlAx4bGVOcg3F'
              + 'pCjB1AQEFBXUXAwsTSHGDb0dZJXVzcwU'
              + 'PbA91FRhgZAeNdm1UCicBdHVsbHV0bCI'
              + 'gKRYdbYJuQgYI59QC7HMhKAsImHEjCI4'
              + 'WfAXQCQDQL4QJBwRkwCkIhUOVAtUWNgE'
              + 'wZ0wDFiN2TLTjBguGDwGwLQQAgE0QEio'
              + 'gdCEoLoyEARcC1NkpgA2QBg6saHBBr9C'
              + 'SHh4GfBCxc1sDJmIg5ADn68eGBQNANCX'
              + 'hAI0NCmqcDXKVgcCTMwt2Kpngg4KRCL0'
              + 'lBn0qssICAQIjIGig0WJVp0gHOhApI4X'
              + 'HiwObOj07lGhRuEGBAAAh+QQJCgB2ACw'
              + 'AAAAAFAASAAAH/4B2goJvbW5wcG5tb4O'
              + 'Ng3JxOF83Q05XSV5xco6CDAk1MwoGBhw'
              + 'xEltcCQyOchFRCjp1CAh1JQMeGxlTm4N'
              + 'xaQowdQEBBQV1FwMLE0hxg29HWSV1c3M'
              + 'FD2wPdRUYYGQHjHZtVAonAXR1bGx1dGw'
              + 'iICkWHW2CbkIGCObTAutzISgLBMy4EQR'
              + 'Hy70C5wQA4BfChAMCMuAQhMKhSgFqCps'
              + 'AmDOmAYsROyTacYMFw4cA1xQCAMAmCAk'
              + 'VELoMDBdGwoALAeroFMAGSAMHVjS4mGf'
              + 'nzZIeHgZ8EKFTWwMmYiDk+Nbrx4YFA0A'
              + '0JeEAjQ0Kapo9ipCBwJMzC3QqmeCDgpE'
              + 'IvCYGeSqywgIBAiMgaKDRQhUnO5AOdCB'
              + 'SRgqPFwc0/XVmCJEicI4CAQAh+QQJCgB'
              + '2ACwAAAAAFAASAAAH/4B2goN2b21ucHB'
              + 'ubW+EjnZycThfN0NOV0lecXKPdgwJNTM'
              + 'KBgYcMRJbXAkMjnIRUQo6dQgIdSUDHhs'
              + 'ZU5yDcWkKMHUBAQUFdRcDCxNIcYNvR1k'
              + 'ldXNzBQ9sD3UVGGBkB412bVQKJwF0dWx'
              + 'sdXRsIiApFh1tgm5CBgjn1ALscyEoCwi'
              + 'YcSMIjhZ8BdAJANAvhAkHBGTAKQiFQ5U'
              + 'C1RY2ATBnTAMWI3ZMtOMGC4YPAbAtBAC'
              + 'ATRASKiB0ISgujIQBFwLU2SmADZAGDqx'
              + 'ocEGv0JIeHgZ8ELFzWwMmYiDkAOfrx4Y'
              + 'FA0A0JeEAjQ0KapwNcpWBwJMzC3YqmeC'
              + 'DgpEIvSUGfSqywgIBAiMgaKDRYlWnSAc'
              + '6ECkjhceLA5s6PTuUaFG4QYEAACH5BAk'
              + 'KAHYALAAAAAAUABIAAAf/gHaCgm9tbnB'
              + 'wbm1vg42DcnE4XzdDTldJXnFyjoIMCTU'
              + 'zCgYGHDESW1wJDI5yEVEKOnUICHUlAx4'
              + 'bGVObg3FpCjB1AQEFBXUXAwsTSHGDb0d'
              + 'ZJXVzcwUPbA91FRhgZAeMdm1UCicBdHV'
              + 'sbHV0bCIgKRYdbYJuQgYI5tMC63MhKAs'
              + 'EzLgRBEfLvQLnBADgF8KEAwIy4BCEwqF'
              + 'KAWoKmwCYM6YBixE7JNpxgwXDhwDXFAI'
              + 'AwCYICRUQugwMF0bCgAsB6ugUwAZIAwd'
              + 'WNLiYZ+fNkh4eBnwQoVNbAyZiIOT41uv'
              + 'HhgUDQDQl4QCNDQpqmj2KkIHAkzMLdCq'
              + 'Z4IOCkQi8JgZ5KrLCAgECIyBooNFCFSc'
              + '7kA50IFJGCo8XBzT9dWYIkSJwjgIBACH'
              + '5BAUKAHYALAAAAAAUABIAAAf/gHaCg3Z'
              + 'vbW5wcG5tb4SOdnJxOF83Q05XSV5xco9'
              + '2DAk1MwoGBhwxEltcCQyOchFRCjp1CAh'
              + '1JQMeGxlTnINxaQowdQEBBQV1FwMLE0h'
              + 'xg29HWSV1c3MFD2wPdRUYYGQHjXZtVAo'
              + 'nAXR1bGx1dGwiICkWHW2CbkIGCOfUAux'
              + 'zISgLCJhxIwiOFnwF0AkA0C+ECQcEZMA'
              + 'pCIVDlQLVFjYBMGdMAxYjdky04wYLhg8'
              + 'BsC0EAIBNEBIqIHQhKC6MhAEXAtTZKYA'
              + 'NkAYOrGhwQa/Qkh4eBnwQsXNbAyZiIOQ'
              + 'A5+vHhgUDQDQl4QCNDQpqnA1ylYHAkzM'
              + 'LdiqZ4IOCkQi9JQZ9KrLCAgECIyBooNF'
              + 'iVadIBzoQKSOFx4sDmzo9O5RoUbhBgQA'
              + 'AOw=='
              + x'00';
       end-proc;

       dcl-proc i_cool export;
       dcl-pi *N varchar(124000:4);
       end-pi;
       return   'R0lGODlhEgASANU2AGhfTGlhTG5ubn9'
              + '9eDMzmYlpL4BkMINrMIlsMI53L497L4V'
              + 'zMI11MI56MJxxJrd/F7R9GKF+JoB+eba'
              + 'DGLiEF76eGKeOJsSeF96WBt+ZBsSjF+e'
              + 'cAOGjBeSmBemiAO2uAOe1Be+yAOy+BvC'
              + '3APO/AO3BBu3HC/TDAPfMAPjOAvvXDvz'
              + 'bFP3dF/3fGf/kH//nI4SEhJiYmKSkpP/'
              + '/mcvLy9bW1v///wAAAAAAAAAAAAAAAAA'
              + 'AAAAAAAAAAAAAAAAAACH/C05FVFNDQVB'
              + 'FMi4wAwEAAAAh+QQFfQA2ACwAAAAAEgA'
              + 'SAAAGv0CbUEiTwQQCmIw2bNpqsUCjUhJ'
              + 'VGIFYzUmTLEwqVjiFAh0kTGFtYAm3Wq6'
              + 'WOEWKDLa2WEMFd7lefi4qKCMIMTYEiYq'
              + 'LjAQANI0EL5GJRo2TjISJAiWLL5+LLIQ'
              + 'YBAIiKn+fqp8uoiEYSRdhfqufYicfD0o'
              + 'JKHypqi4EhB4FSwEhKCwsfW8EdB8Yj3k'
              + 'MJL2ZJB8bhmoDESPVKOEnI9kOd0NdBxw'
              + 'fIyMh2RgGaE5QAAgTGRgQCABaTuhGkCh'
              + 'JMyQIACH5BAUPADYALAAABAASAAcAAAY'
              + 'tQIJwSCwSbMhk8qVUHmXNKBIVsh01ypm'
              + 'NmWQhKV0XU7u1zVxKQbIlbSu5blsQACH'
              + '5BAkPADYALAAAAgASAA4AAAZAQJtwaFs'
              + 'ZiUSCcslsEpBEF1T4pE2hp47tqSDOXC/'
              + 'iSogYrlzSYfg7FsKE4zS0fZ3SxddWfX8'
              + '98pF3f4JIBlp8QQAh+QQFDwA2ACwAAAA'
              + 'AEgASAAAGo0CbcEgsGo9IIU2yMKlYzxQ'
              + 'KdJDQhrWB5dlquVrQFCkyqNkI6LR6TYi'
              + 'd2S92miaDs1EhNEyjnr3iaSwoIxQEAiU'
              + 'sLnF+fwQzLoIjGAICIiotf5mZkHiTMBd'
              + 'Pipp/UCcfDzAyCSiXopsEgx4FMjQBISg'
              + 'sLF5fLQRiHxgAVzEMJKxrKCQfGwhuNlk'
              + 'RI8Yo1Ccjyw5lQ0sHHB8jIyHLGAZWSef'
              + 'oSEEAIfkECQ8ANgAsAAACABIADgAABkB'
              + 'Am3BoWxmJRIJyyWwSkEQXVPikTaGnju2'
              + 'pIM5cL+JKiBiuXNJh+DsWwoTjNLR9ndL'
              + 'F11Z9fz3ykXd/gkgGWnxBACH5BAkPADY'
              + 'ALAAAAAASABIAAAajQJtwSCwaj0ghTbI'
              + 'wqVjPFAp0kNCGtYHl2Wq5WtAUKTKo2Qj'
              + 'otHpNiJ3ZL3aaJoOzUSE0TKOeveJpLCg'
              + 'jFAQCJSwucX5/BDMugiMYAgIiKi1/mZm'
              + 'QeJMwF0+Kmn9QJx8PMDIJKJeimwSDHgU'
              + 'yNAEhKCwsXl8tBGIfGABXMQwkrGsoJB8'
              + 'bCG42WREjxijUJyPLDmVDSwccHyMjIcs'
              + 'YBlZJ5+hIQQA7'
              + x'00';
       end-proc;

       dcl-proc i_grin export;
       dcl-pi *N varchar(124000:4);
       end-pi;
       return   'R0lGODlhEgASAOZ2AP/jH//kIPvXDcr'
              + 'KymhfTIB+ef/iHfC2AP/lIfzZEX99eHd'
              + '3zP/mIv/mI/fLAP/iHolsMMzM//7gG+e'
              + 'cAOyrAKF+Jv/kH/K9AP/kIe+xAPjMAPC'
              + '3AOmiAPfKAPvXDvfMAPbJAPrTCO+yAP3'
              + 'dF2hgTOe1BdqRBX9+eI56MP7hHdiSBo9'
              + '7L497MLd/F/vZEI11MIVzMINrMLiEF/H'
              + 'KC7R9GNiUBuSmBe3HC9+ZBuy+BmpiTI1'
              + 'zMKeOJoloMLyYGL6eGIhpMP7gGvrSB92'
              + 'TBYBkMLaDGIlpL2lhTN6WBpxxJvzbE+3'
              + 'BBvTCAGhhTIpvMIFpMP3fGY53L+2uAPv'
              + 'YD+yqAOGjBcSjF+q4BfzbFOq+Bv/nI8S'
              + 'eF/O/AOvABvC4APK/AP7jH/PBAPjOAv7'
              + 'hHPbKAPTDAPPCAPvaEfrUCvbIAP3eGP/'
              + 'lIqSkpISEhMvLy25ubpiYmNbW1ru7/1V'
              + 'VzDMzmf//mf///wAAAAAAAAAAAAAAAAA'
              + 'AAAAAAAAAAAAAAAAAACH/C05FVFNDQVB'
              + 'FMi4wAwEAAAAh+QQF+gB2ACwAAAAAEgA'
              + 'SAAAH44B2goJubG1vb21sboONdnFwTSg'
              + '/Szk+LyRwcY4DBTA3AgkJHkIdJTEFA4N'
              + 'xCjwCdHQGBhKwGhcVJ5t2cCyvDwAAAQE'
              + 'AQXQOG05wdm46MyMPdXQBGAh0dVAhTDY'
              + 'EhSsCEgDRCAhr1ikuIBkQhgsLBuF0awz'
              + 'ldRZK7TKHcxFz/f7/++bUQLSvTh05BhE'
              + 'eNMhPRaI5CiMmTDinhaJ9CCUulMPPyKI'
              + 'jcw7KGUlyZJ05Q7jt2hFSI8I5E3ooe6S'
              + 'gAsSJB2EmUaDLTqcnAPuZIJLKESQCEIr'
              + 'gQEIDCAFNjgYVOpRokaNAACH5BAUUAHY'
              + 'ALAEABwAPAAkAAAdlgFYJdoSFhnYOB10'
              + 'JBgEYawwNa5MWWB8HWR5jAZORWpJgZ2Q'
              + 'iWyFqc3MIkQ0NqGhlFFEdU3N1qLe2H14'
              + 'cdlcatHXBwXNiXBSFFw60t3MfX1KHB2F'
              + 'pDh8gZhtUh4RVGQcHIhS8hYEAIfkEBRQ'
              + 'AdgAsAgAJAA0ABgAAByqACwt2hIWFgnN'
              + '1hHOMjIR1c3aJcnV1lJaQhXNynJ1ykYa'
              + 'JmJmGi42ghIEAIfkEBQ8AdgAsAQAIAA8'
              + 'ABwAABzCACwt2hIWGdoJzEXOMjY6KjHJ'
              + '2dXJ1lJaVdnJzdnOSh4WbhZ6gmpyGpIa'
              + 'ioKejhoEAOw=='
              + x'00';
       end-proc;

       dcl-proc i_blush export;
       dcl-pi *N varchar(124000:4);
       end-pi;
       return   'R0lGODlhEgASAPf/APnVFv/0lGhhTIB'
              + '+ef/JJsvKyaWlo/+0Jv3dF/zZEf7UIf/'
              + '5lq2LLP+NK/y5Hv+dKuOZCvC3Af+9J//'
              + 'WJINwRf/cIjwzlaqlnP7jH21kS/zbGv7'
              + 'ZIvi7F//cJP96LffLAO2wCnx4Z/7JINy'
              + 'mHv/YJP6qJvawGv6JJ///mZ2alP7ZHv/'
              + 'MJf/PJf/FJrOFLdbV0v/SJf+sKP91de6'
              + 'qCtiUBvzDFv/eI/K1Be+jCzQzmX9+eP+'
              + 'yKP+4J/6hJoNrMNCwGf9tLvLJEf7WH//'
              + 'gI/2sIP6xJPfLFPfLEP+7JvOpC6V5Jv+'
              + 'YKem1DfKxCPGuCvzDHLaUJv/ii/2UJP/'
              + 'iHfO+FY9tL4B5ZfPFEv+nKf7SIv2eIf/'
              + 'QJfOlD/nQCfnNG/7MIP7cHv3eGP7fHdq'
              + 'sHfnOFZGIe/nJG/nOCo+KfP/GJv/GJP/'
              + 'mjfCsDP+JK/+hKf/gIfnRGv69IP+oKam'
              + 'HLfbFFv3dGfzJGvrLFf7DJPG4BP2gIlE'
              + 'zi6eJLTczl8vLy4SEhKSkpG5ubv/kIP9'
              + 'VVfvXDf/lIf/kIfvYD//lI8rKyv/mIv+'
              + 'BLJeDLmhfTI1uMIlsMPTCAP7fGbyYGPr'
              + 'SB8zKxvrUCbiEF5J1L96dCIWCdI52LvC'
              + '5C/bJEPbLA//kIoWFg/7gG4pqL/K9AOS'
              + 'mBfzcFf7jIPvaGmtiTO+xAI56MI11MIV'
              + 'zMPjMAO3HC8vLyvfNE4mIgL6eGJB8MIO'
              + 'Bd7yJGv/iIv7fGrmBF/LLDOOlC6F+Jop'
              + 'vMOy+BnNwbOe1BaeOJuWnDPvXDsCSGe3'
              + 'BBv9zc3BubvvWGPzdHf/jI//9mP+kKf/'
              + 'kI//gJP/AJv/jH/7jIf/hI/9+LPSfEN6'
              + 'eH//DJv2WI/nIF/S5Ff7kIf+5JfCeDfy'
              + 'TI/mvGf+PK//qj/+sJ//ukf/8l//iIWY'
              + 'zf2UzgP20Hv2wHvuwHve0Gf/jIv7QH/v'
              + 'IFPunIPe+F/KqDf66I/rQFP7HIf7CIv2'
              + 'qH/66JfPCFPXBF/e5GP2nIP3cGpiYmNb'
              + 'W1v/lIv/mIzMzmf///yH/C05FVFNDQVB'
              + 'FMi4wAwEAAAAh+QQFFAD/ACwAAAAAEgA'
              + 'SAAAI/wD/CRToB9CfQIH+APIzsOG/ffo'
              + 'EpIo1jJckVQL07XOYaMCqVoQSJAg26YM'
              + 'vHwMSDdyn4xchUramTAGF4BArUbp0bPy'
              + 'nTxahSP78ORMkKOihDxF26fvnKgOuMP7'
              + '48RNkqJAhfv4qQRrVyI8BRgmmOEPhr1A'
              + 'hfjlQlCLVCdUjQLB+aKhQYUEOfor65Vh'
              + 'gQ8WZCJb+hLgigge9KBY89etnIQqPbDV'
              + 'u0Ahk5VqPRYuUsai1mIUyzFqSTC4z7QQ'
              + 'QIA1aMFvcosHpE9Ju/bngopoHDw9WQFu'
              + '84sHtbdpCAaJEwUSJGC2IIVpMjFqMEtw'
              + 'gnGKYYo41BRWWDdqOrIMCM2yqLD399yI'
              + 'TlCMaMEhV9OyYERBKBuz8V2CWJiacAJg'
              + 'y9moTJpQqNQRRBpcIA0wutDhyikYODVT'
              + 'QH70U88lCDgUEACH5BAUUAP8ALAEABwA'
              + 'PAAcAAAhYAP8JtBFOoEGBYAx+adZszT9'
              + '+BtcwFEilRLduMWAYhBHjIj6BS6JFW0I'
              + 'AmkACIaNJ4fJPT5s2WLbUErgFy0stOP6'
              + 'hK3KAgIyDBA7sQGfwjhAbiA7amGAwIAA'
              + 'h+QQFFAD/ACwAAAYAEAAJAAAIZwD/Cfw'
              + 'naKDBg//y2UD4L9yQf10EBlGXJo23Pga'
              + '9pVGzLo/AAw8e8JiQTuAEHiHNOUEzoke'
              + '3blhY1BLIAstLPQPnLVmyA8ZAGDt2sht'
              + '4750EFgZlrJBA795BFQeXMdvgxQlDg9g'
              + 'OBgQAIfkEBRQA/wAsAQAHAA8ABwAACF8'
              + 'A//178yaZwIP/aiFUsGIFOIR9wDW8869'
              + 'enG8xmpHwJJBEsxjfHDT5V8SNmx0wkAm'
              + 'EscMkEXcMysmRI2GCyn8TJMjBck5gO3k'
              + 'tYCD8B6MFHg4HyfwbghDRvwr/QPwLCAA'
              + 'h+QQFFAD/ACwBAAcADwAHAAAIXgD/1fk'
              + 'n7p/Bg8n+iTkoBAaMAAcNBoCRBd6/K/G'
              + 'QICFQgZ/BDgQ0Pvk3Js6OHc1ILDNIotl'
              + 'JB07+xeHBI02Hlf86pKHpYMY/eyJWTIj'
              + '4b8KKFe0M8vkHphZRp3AMBgQAIfkEBR4'
              + 'A/wAsAQAGAA8ACAAACFkA/wkcONAfQYF'
              + 'hxKU7KNATQRUkNizIcZAECYFB1BEgAMP'
              + 'GQGYwNtq58U8EtRYrOiAS2GFFixZPmvy'
              + 'zkyZNx5X/QNZ8IpBOlgkdDnaYkIUOJoH'
              + 'wxDBE9mZgQAAh+QQFFAD/ACwBAAYADwA'
              + 'IAAAIWQD/CRw4MAdBgXXeiDsosBZBITB'
              + 'gBOhzEEYWgVfiIUFCoMLADgQ2PmnyL86'
              + 'OHc1ILBNIotlJB05K8uCRpsPKfx3SzHQ'
              + 'g0J6IFRMOTlixoh0EgWTAMKzlUWBAACH'
              + '5BAUUAP8ALAEABwAPAAcAAAhgAP/l+/f'
              + 'mn8GD4f6BOahgxQpwBw2Cc3jnX70432I'
              + '0I+HJIIlmMb45+DeiiBs3O2AgMwhjx0k'
              + 'i7v6VkyNHwoSV/yZIkIPlHI5/7eS1gBH'
              + 'xH4wWeDgYnPNPxZCizP55MRgQACH5BAU'
              + 'UAP8ALAEABwAPAAcAAAhcAP/9s2EjnMC'
              + 'D/4YgVJcmjTeEFrylUbPuH5UDDx7wmJB'
              + 'O4AQeGc05+dejWzcsLGoJZIHFpB4uLuY'
              + 'tWbIDhsp/MHbMZCfw3jsJLBD+WyGB3r2'
              + 'DdwYiXPZvw7+RAQEAIfkEBRQA/wAsAAA'
              + 'GABAACQAACGYA/wn852ygwYP/NFRA+G+'
              + 'BjX9nBF750qzZGgsG11SscUNgiW7dYsC'
              + 'oJRBGDJD4kpSZtiRatCUEoAkk0DKalIF'
              + '62rTBsmXgFiw6tQxEV+QAAYPECBzYge6'
              + 'gkIPIbEwww4ahwWcHAwIAIfkEBRQA/wA'
              + 'sAQAHAA8ABwAACFkA/wmssECgQYEqDIr'
              + 'gQS/KP08Go/DIJvBaj0WLlLEwyEIZRi0'
              + 'CTwAB0qAFM4EtGow8Ie1fNQ8eHqyAJnD'
              + 'FA5jbtP0zUSJGC2IHqcUowc2gNQUVlh3'
              + 'soMBgQAAh+QQFDwD/ACwEAAYACQADAAA'
              + 'IGQD/CeL3r6AnT/8C/EtWcGFCcnsaFtw'
              + 'zLiAAIfkEBQoA/wAsBAAGAAkAAwAACBo'
              + 'A/6Hw969gDhT/KvzLUXDhPxv0ojQsGIV'
              + 'HQAAh+QQFDwD/ACwEAAYACQADAAAIGQD'
              + '/CeL3r6AnT/8C/EtWcGFCcnsaFtwzLiA'
              + 'AIfkEBQoA/wAsBAAGAAkAAwAACBoA/6H'
              + 'w969gDhT/KvzLUXDhPxv0ojQsGIVHQAA'
              + 'h+QQFDwD/ACwEAAYACQADAAAIGQD/CeL'
              + '3r6AnT/8C/EtWcGFCcnsaFtwzLiAAOw='
              + '='
              + x'00';
       end-proc;

       dcl-proc i_spock export;
       dcl-pi *N varchar(124000:4);
       end-pi;
       return   'R0lGODlhEgASAOZ4AP/mIv/kIP/mI//'
              + 'jH/C2APvYD/zZEYB+ecrKyv/kH/fMAGh'
              + 'fTP/iHfvXDffLAH99ePvaEeyrAP/kIfC'
              + '3AP/iHv3eGPrTCPrUCvbJAOmiAPfKAPz'
              + 'bE6F+Ju+yAPvXDolsMPvZEO+xAPjMAPK'
              + '9AOecAP3dF/7hHf7gG/7gGo56MKeOJuv'
              + 'ABtiUBtqRBY1zMLiEF+q+BoNrMP7fGfb'
              + 'KAPrSB7d/F39+ePTCALyYGO3HC+GjBfP'
              + 'CAIloMPjOAo53L/HKC/bIAPTDAPO/AOq'
              + '4Bd6WBtiSBsSjF4VzMIFpMP3gGpxxJuS'
              + 'mBYpvMMSeF+3BBue1Bf7fGu2uAP7hHIl'
              + 'pL+y+BuyqAP7iHv7jH2lhTPC4APzbFGh'
              + 'hTGhgTP3cFvPBAI97L7R9GP/nI2piTN+'
              + 'ZBoBkMLaDGI97MN2TBYhpML6eGI11MPK'
              + '/AP3fGf7iHf/lIaSkpISEhMvLy25ubpi'
              + 'YmNbW1v/lIv//mTMzmf///wAAAAAAAAA'
              + 'AAAAAAAAAAAAAAAAAACH/C05FVFNDQVB'
              + 'FMi4wAwEAAAAh+QQFyAB4ACwAAAAAEgA'
              + 'SAAAH/4B4goJxb3BycnBvcYONeHRzWyl'
              + 'pTlQ4alxzdI4IB0c5DQYGHjQaTzEHCIN'
              + '0DyoNXVAMDHe0IiMcNpt4c2YNMhQDAwE'
              + 'BAyh3DhNMc3hxYj8lFLQBEm4SdWwWN0s'
              + 'LhV8NJ3cBdW5udXd2JiAYIR+GRgYMA3Z'
              + '3dQDmdgkbDgQvhyvwAeYBEHAvgRYFBFg'
              + 'gguFBirh6AsIQvAJhRociiZpYqDCA2kA'
              + 'BAtwkuRAkQg1FPjQUQDGgHAAAbu5AUJA'
              + 'lw5RFWIaIKFDBRIIEVmT2EBLhDLddLkY'
              + '4KABiA60LCtZEIcFj2aMHHAh4AeJAAYY'
              + 'dE6qQUPJAF55OSHSEIECgQ4QMLRjIpHI'
              + 'EacGHMmOIgEGzQJOjQYUOJVrkKBAAIfk'
              + 'EBRQAeAAsCQADAAQACQAABxSAJyUFeHh'
              + '3d4SFd4WMjY6PhW14gQAh+QQFZAB4ACw'
              + 'KAAQAAwAJAAAHEoADKHh3d2x1bnd4i4y'
              + 'NjmyLgQAh+QQFFAB4ACwKAAQAAwAJAAA'
              + 'HEYB3d3gSdYJ2JniKi4yNg3iBADs='
              + x'00';
       end-proc;

       dcl-proc i_sad export;
       dcl-pi *N varchar(124000:4);
       end-pi;
       return   'R0lGODlhEgASAOZ3AP/mI//lIfC2APv'
              + 'YD//kIP/jH/zZEcrKyvfLAGhfTPvXDf/'
              + 'iHYB+effMAP/mIn99eOyrAP/kH//kIfv'
              + 'aEemiAPfKAOecAP7gG/zbE/rTCPbJAP7'
              + 'hHfzbFPvXDv3dF/rUCu+yAO+xAKF+Jvv'
              + 'ZEPjMAIlsMPC3APK9AI53L/7jH456MP3'
              + 'gGtqRBf7gGt2TBey+BsSeF/TDAIpvMLy'
              + 'YGPTCAGpiTPrSB4lpL/7fGvHKC+e1Bf7'
              + 'iHmhgTO3HC411MOq4Bf7hHP3fGeGjBfj'
              + 'OAvC4ALiEF7aDGOq+BuvABmlhTNiSBol'
              + 'oMPO/ANiUBv3eGN6WBsSjF//nI6eOJvb'
              + 'KAIBkMOSmBYFpML6eGI97MJxxJu2uAP3'
              + 'cFoVzMLR9GP7iHYNrMH9+ePPCAPPBAP7'
              + 'fGbd/F9+ZBvbIAOyqAI97L+3BBo1zMGh'
              + 'hTPK/AIhpMKSkpISEhMvLy25ubpiYmNb'
              + 'W1v/lIv//mTMzmf///wAAAAAAAAAAAAA'
              + 'AAAAAAAAAAAAAAAAAACH/C05FVFNDQVB'
              + 'FMi4wAwEAAAAh+QQFZAB3ACwAAAAAEgA'
              + 'SAAAH/4B3goJwbm9xcW9ucIONd3Nyayp'
              + 'XaS8zPjxyc44HDFw9CgYGHTYVOl8MB4N'
              + 'zD1IKWzgLCxceAyQnImCbd3JYCmN2dgU'
              + 'EBMEDCCYycndwNTkednR0BBIBEnR2GTR'
              + 'VCYVoChcFdXYBAdh1GyMaISWGUAYL4tE'
              + 'O5xEYCAJFh0jwBOMOAOpxaCCgCaIjHYA'
              + 'QkAYwSsAUE6aAUJIIRgYnBaoBBAAgwIo'
              + 'PMSCQUYSiwoAWBYKp9DKhAREKNxYl+UF'
              + 'igJ0NESLsCGJnCBMILrrxUnMCwYARGDh'
              + 'M+NCAjRYLS5Y9eiBCgBgzCBpoCGPijIU'
              + 'sD3bd6WRFSAgBAkBAoMCCSipHkBQSlDB'
              + 'S5kmXNgk0ORpU6FCiRY4CAQAh+QQFDwB'
              + '3ACwEAAYACQADAAAHFIB3BHR3hXQBd3W'
              + 'JhYt1dnaMhY+BACH5BAUPAHcALAQABgA'
              + 'JAAMAAAcWgHd1dneFdnV3BXeEhncRBIi'
              + 'FhXURgQAh+QQFDwB3ACwEAAYACQADAAA'
              + 'HFIB3BHR3hXQBd3WJhYt1dnaMhY+BADs'
              + '='
              + x'00';
       end-proc;

