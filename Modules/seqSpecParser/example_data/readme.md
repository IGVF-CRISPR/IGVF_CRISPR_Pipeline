# Guide Lines

- Split your SeqSpec in the different modalities using different files. All the files should be in the same directory.  
- Add your whitelist to the SeqSpec directory without .gz (as a .txt file). 
- Use cdna region to describe the variable region that you want to capture
    Examples
    
   ``` 
    for the single cell RNA we can use :
          - !Region
            parent_id: rna
            region_id: cdna
            region_type: cdna
            name: cdna
            sequence_type: fixed 
            sequence: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
            min_len: 1 
            max_len: 150
            onlist: null
            regions: null
  ```

     ``` 
    for the  GUIDES we can use :
    - !Region
        parent_id: guide
        region_id: cdna
        region_type: cdna
        name: cdna
        sequence_type: fixed
        sequence: NNNNNNNNNNNNNNNNNNNN
        min_len: 20
        max_len: 20
        onlist: null
        regions: null
  ```

     ``` 
    for the MULTISEQ/Hashing BARCODES we can use:
    - !Region
        parent_id: multiseq
        region_id: cdna
        region_type: cdna
        name: cdna
        sequence_type: fixed 
        sequence: NNNNNNNN
        min_len: 8 
        max_len: 8
        onlist: null
        regions: null
  ```
The outputs can be evaluate using the seqspec nextflow command:
```
add the commands to execute the nextflow module to inspect the ouput when generating the seqSpec
```
