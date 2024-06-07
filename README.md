# mosaico-client

This is the client native application for Mosaico.


## BLE
The app uses BLE to communicate with the matrix, the BLE library used is [ADD]().
For now, only a service is used because I couldn't make multiple services work on the software side, 
so the various characteristics are grouped in a single service.

Services: 
- d34fdcd0-83dd-4abe-9c16-1230e89ad2f2: Main service
  - Characteristics:
    - Runner:
      - UUID: d34fdcd0-83dd-4abe-9c16-1230e89ad2f2
      - Properties: Write, Read



