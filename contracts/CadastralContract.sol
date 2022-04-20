//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./Estoken.sol";

contract CadastralContract {
    mapping(string => EsToken) nowEstateList;

    event eventSplit(
        string parentId,
        string [] childId,
        string changeDate
    );

    event eventCreate(
        string id,
        Data data,
        Polygon polygon
    );

    event eventMerge(
        string childId,
        string [] parentId,
        string changeDate
    );

    function create(
        string memory id,
        Data memory data,
        Polygon memory polygon,
        string [] memory parent
    ) 
        public  
        payable
    {
        EsToken estate = new EsToken(id,data,polygon,parent);
        nowEstateList[id] = estate;
        emit eventCreate(id, data, polygon);
    }

    function split(
        string memory sId,
        string [] memory newIdList,
        Data [] memory newDataList,
        Polygon [] memory polygonList,
        uint numOfnewEstate
    )
        public
        payable
    {
        EsToken estate = nowEstateList[sId];
        estate.setEndDate(newDataList[0].begDate);
        estate.setChildren(newIdList);

        for(uint i = 0;i < numOfnewEstate;i++){
            string[] memory st;
            st[0] = sId; //string to string[]
            create(newIdList[i],newDataList[i],polygonList[i],st);
        }

        emit eventSplit(sId,newIdList,newDataList[0].begDate);
    }

    function merge(
        string [] memory mIdList,
        string memory newId,
        Data memory data,
        Polygon memory polygon
    ) 
        public
        payable
    {
        EsToken estate;
        for(uint i = 0;i < mIdList.length ;i++){
            estate = nowEstateList[mIdList[i]];
            estate.setEndDate(data.begDate);
            string[] memory st;
            st[0] = newId;
            estate.setChildren(st);
        }
        create(newId,data,polygon,mIdList);
        emit eventMerge(newId,mIdList,data.begDate);
    }

    function getEstateData(string memory Id)
        public 
        view 
        returns(
            Data memory,
            Polygon memory,
            string [] memory,
            string [] memory
        )
    {
        EsToken estate = nowEstateList[Id];
        Data memory data = estate.getData();
        Polygon memory polygon = estate.getPolygon();
        string [] memory parent = estate.getParents();
        string [] memory child = estate.getChildren();
        return (
            data,
            polygon,
            parent,
            child
        );
    }    
}
