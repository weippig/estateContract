//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

struct Point{
    string x;
    string y;
}

struct Polygon{
    Point [100] pList;
    uint numOfPoint;
}

struct Data{
    string pcno;
    string pmno;
    string scno;
    string county;
    uint townShip;
    string begDate;
    string endDate;
    uint reason;
    uint changeTag;
}

contract EsToken {
    string Id;
    Data data;
    Polygon polygon;
    string [] parents;
    string [] children;

    constructor(string memory id, Data memory d, Polygon memory poly, string [] memory pa) {
        data.pcno = d.pcno;
        data.scno = d.scno;
        data.pmno = d.pmno;
        data.county = d.county;
        data.townShip = d.townShip;
        data.begDate = d.begDate;
        data.endDate = d.endDate;
        data.reason = d.reason;
        data.changeTag = d.changeTag;
        for(uint i = 0;i < poly.numOfPoint;i++){
            polygon.pList[i].x = poly.pList[i].x;
            polygon.pList[i].y = poly.pList[i].y;
        }
        polygon.numOfPoint = poly.numOfPoint;
        parents = pa;
        Id = id;
    }
    function setEndDate(string memory endD) public {
        data.endDate = endD;
    }
    function setChildren(string [] memory chi) public {
        children = chi;
    }

    function getData() public view returns(Data memory){
        return data;
    }
    function getPolygon() public view returns(Polygon memory){
        return polygon;
    }
    function getParents() public view returns(string [] memory){
        return parents;
    }
    function getChildren() public view returns(string [] memory){
        return children;
    }
}