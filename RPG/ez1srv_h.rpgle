      /if defined(EZ1SRV_H)          
      /eof          
      /endif          
      /define EZ1SRV_H          

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * employee fake database
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       dcl-c EMP_MAX const(7);

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * base64 images 
      *   <img src="data:image/gif;base64,+ i_smile() + " />
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       dcl-pr i_smile varchar(124000:4);
       end-pr;

       dcl-pr i_suprise varchar(124000:4);
       end-pr;

       dcl-pr i_cool varchar(124000:4);
       end-pr;

       dcl-pr i_grin varchar(124000:4);
       end-pr;

       dcl-pr i_blush varchar(124000:4);
       end-pr;

       dcl-pr i_spock varchar(124000:4);
       end-pr;

       dcl-pr i_sad varchar(124000:4);
       end-pr;

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * employee record 
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       dcl-ds emp_t qualified based(Template);
         EmpId int(10);
         EmpYears packed(5:0);
         EmpName varchar(128:2);
         EmpTitle varchar(512:4);
         EmpSite varchar(512:4);
         EmpDate date(*USA);
         EmpTime time(*USA);
         EmpPic varchar(124000:4);
         EmpTags varchar(124000:4);
       end-ds;

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * employee by id 
      *   id - id number of employee
      * return (emp_t - employee record)
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       dcl-pr empById likeds(emp_t);
         id int(10);
       end-pr;

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * employee by partial name 
      *   search - partial employee name
      *   max    - max records expected
      *   count  - number records found
      *   recs   - records found
      * return (na)
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       dcl-pr empByName;
         search varchar(128:2);
         max int(10);
         count int(10);
         recs likeds(emp_t) dim(EMP_MAX);
       end-pr;

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * employee by partial cloud tag 
      *   search - partial cloud tag interest
      *   max    - max records expected
      *   count  - number records found
      *   recs   - records found
      * return (na)
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       dcl-pr empByTag;
         search varchar(128:2);
         max int(10);
         count int(10);
         recs likeds(emp_t) dim(EMP_MAX);
       end-pr;

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * employee by partial title 
      *   search - partial employee title
      *   max    - max records expected
      *   count  - number records found
      *   recs   - records found
      * return (na)
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       dcl-pr empByTitle;
         search varchar(128:2);
         max int(10);
         count int(10);
         recs likeds(emp_t) dim(EMP_MAX);
       end-pr;

