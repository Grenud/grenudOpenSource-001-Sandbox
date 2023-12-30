import { LightningElement } from 'lwc';
export default class Test extends LightningElement {
     openNavbar(event) {
        document.getElementById("sideNavigationBar")
            .style.width = "50%";
    }
     closeNavbar(event) {
        document.getElementById("sideNavigationBar")
            .style.width = "0%";
    }
    
}