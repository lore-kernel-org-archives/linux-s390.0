Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v2 0/1] s390: vfio_ap: link the vfio_ap devices to the vfio_ap bus subsystem
Date: Mon, 18 Feb 2019 19:08:47 +0100
Message-Id: <1550513328-12646-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: borntraeger@de.ibm.com
Cc: cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

This is the second version of this patch.
The first version was part of a patch series on VFIO AP IRQ.

The goal of this patch is to standardize the device-driver interface
for the VFIO_AP ap_matrix_device to satisfy user-land tools working on
hot-plug (UDEV/LIBVIRT).

Christian Borntraeger reported libvirt looping when a matrix device
was available before the libvirt start.

Marc Hartmayer debugged this and circumvented this in libvirt:
https://www.redhat.com/archives/libvir-list/2019-February/msg00837.html


Pierre Morel (1):
  s390: vfio_ap: link the vfio_ap devices to the vfio_ap bus subsystem

 drivers/s390/crypto/vfio_ap_drv.c     | 48 +++++++++++++++++++++++++++++------
 drivers/s390/crypto/vfio_ap_ops.c     |  4 +--
 drivers/s390/crypto/vfio_ap_private.h |  1 +
 3 files changed, 43 insertions(+), 10 deletions(-)

-- 
2.7.4
