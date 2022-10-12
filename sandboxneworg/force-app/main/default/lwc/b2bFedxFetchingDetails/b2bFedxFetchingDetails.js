import {  LightningElement} from 'lwc';
import sendRequest from '@salesforce/apex/B2bfedxAuthTracking.sendRequest';
export default class B2bFedxFetchingDetails extends LightningElement 
{   
  ProgressBar = false;
  trackno;
  displayValue;
  tno;
  errors;
  trackingNum;
  trackingNumUniqueId;
        
    handleClick(event)
        {
            this.ProgressBar = true;
            console.log(event.target.label);
            var inp=this.template.querySelector("lightning-input");
            this.trackno=inp.value;
            console.log('trackno-->'+this.trackno);          
            this.fetchTrackingNo();      
        } 
              
    fetchTrackingNo()
        {
           console.log('In fetch tracking no' + this.trackno);
            let trackingno={};
            trackingno.trackingNum = this.trackno;
            console.log('map->' + JSON.stringify(trackingno));
                sendRequest({'trackingno': trackingno})
            .then(result=>{
               // this.tno= result; 
                 this.trackingNum = result.output.completeTrackResults[0].trackResults[0].trackingNumberInfo.trackingNumber;
                 console.log('trackingNum-->'+this.trackingNum);
                 this.trackingNumUniqueId = result.output.completeTrackResults[1].trackResults[0].trackingNumberInfo.trackingNumberUniqueId;
                 console.log('trackingNumUniqueId-->'+this.trackingNumUniqueId);
                 console.log('result==>'+ JSON.stringify(result));        
            })
            .catch(error => {
                this.errors = error;
                console.log('Error-->'+ JSON.stringify(error));
            });
            // this.responseUrl();  
        }

        responseUrl(){
            //window.alert('hello alert');
            window.alert('https://www.fedex.com/fedextrack/?trknbr='+this.trackingNum+'&trkqual=~'+this.trackingNumUniqueId);//+this.tno.trackingNumberUniqueId);
            window.open('https://www.fedex.com/fedextrack/?trknbr='+this.trackingNum+'&trkqual=~'+this.trackingNumUniqueId);
            //window.open("https://www.fedex.com/fedextrack/?"+this.trackno+'&trkqual='+trackingNumberUniqueId,'_blank');
        }
        
        
 }
    
        
        
























        
        // connectedCallback()
        // {
        //     sendRequest({}).then((response) => 
        //     {
        //         console.log("Response : " + (response));
        //             if (!!response)
        //               {
        //                 let res = JSON.parse(response);
        //                 this.trackingId = res.output.completeTrackResults[1].trackingNumber;
        //                 let list = [];
        //                 list = res.output.completeTrackResults[0];
        //                 console.log('list Resp--->'+ JSON.stringify(list));                      
        //               }
        //     });        
        // }         
//}