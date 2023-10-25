# kmo_provision_pe

Automation for the PE server in 501 renovation.

## Building Images

Make sure that you have Packer installed and updated. You will also need to be
authenticated to a default image provider like Google Cloud. To build the image,
run the following in a terminal:

     packer build pe2021.pkr.hcl

To build the command while logging to a file, you can run:

    packer build pe2021.pkr.hcl >> logs/$(date +"%Y-%m-%d-%H%M%S").build.log

or if you have the `tee` utility installed, you can run the following command
to both log output to a file and to the screen:

    packer build pe2021.pkr.hcl | tee -a "logs/$(date +'%Y-%m-%d-%H%M%S').build.log"
