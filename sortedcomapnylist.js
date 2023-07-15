let q= fetch("https://retoolapi.dev/PNAOH1/data");
q.then((apidata)=>{
  return apidata.json();
}).then((apidata)=>{
let obj = {};
let r=0;
let comparison;
let mystring;
let num;
while(apidata.length!=0)
{
    mystring = apidata[0].Company;
    num = apidata[0].id;
    r=0;
    for(i=0;i<apidata.length;i++)
    {
        comparison = apidata[i].Company;
        if(mystring.localeCompare(comparison)>0)
        {
            mystring = apidata[i].Company;
            num = apidata[i].id;
            r=i;
        }
    }
    obj.id=num;
    obj.Company = mystring;
    console.log(obj)
    apidata.splice(r,1);
}
}).catch(error => console.log('Error:', error))
