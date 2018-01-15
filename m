From: Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 1/1] vfio-ccw: update documentation
Date: Mon, 15 Jan 2018 11:43:53 +0100
Message-ID: <20180115104353.27413-2-cohuck@redhat.com>
References: <20180115104353.27413-1-cohuck@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180115104353.27413-1-cohuck@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: bjsdjshi@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, borntraeger@de.ibm.com
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

The vfio-ccw documentation comes from the cover letter of the
original patch submission, which shows in some parts. Give it some
love; in particular:

- Remove/rework statements that make sense in a cover letter, but not
  in regular documentation.
- Fix some typos.
- Describe the current limitations in more detail.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 Documentation/s390/vfio-ccw.txt | 78 +++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 41 deletions(-)

diff --git a/Documentation/s390/vfio-ccw.txt b/Documentation/s390/vfio-ccw.txt
index 90b3dfead81b..c3dfbdcf0c8d 100644
--- a/Documentation/s390/vfio-ccw.txt
+++ b/Documentation/s390/vfio-ccw.txt
@@ -28,7 +28,7 @@ every detail. More information/reference could be found here:
   https://en.wikipedia.org/wiki/Channel_I/O
 - s390 architecture:
   s390 Principles of Operation manual (IBM Form. No. SA22-7832)
-- The existing Qemu code which implements a simple emulated channel
+- The existing QEMU code which implements a simple emulated channel
   subsystem could also be a good reference. It makes it easier to follow
   the flow.
   qemu/hw/s390x/css.c
@@ -39,22 +39,21 @@ For vfio mediated device framework:
 Motivation of vfio-ccw
 ----------------------
 
-Currently, a guest virtualized via qemu/kvm on s390 only sees
+Typically, a guest virtualized via qemu/kvm on s390 only sees
 paravirtualized virtio devices via the "Virtio Over Channel I/O
 (virtio-ccw)" transport. This makes virtio devices discoverable via
 standard operating system algorithms for handling channel devices.
 
 However this is not enough. On s390 for the majority of devices, which
 use the standard Channel I/O based mechanism, we also need to provide
-the functionality of passing through them to a Qemu virtual machine.
+the functionality of passing through them to a QEMU virtual machine.
 This includes devices that don't have a virtio counterpart (e.g. tape
 drives) or that have specific characteristics which guests want to
 exploit.
 
 For passing a device to a guest, we want to use the same interface as
-everybody else, namely vfio. Thus, we would like to introduce vfio
-support for channel devices. And we would like to name this new vfio
-device "vfio-ccw".
+everybody else, namely vfio. We implement this vfio support for channel
+devices via the vfio device "vfio-ccw".
 
 Access patterns of CCW devices
 ------------------------------
@@ -99,7 +98,7 @@ As mentioned above, we realize vfio-ccw with a mdev implementation.
 Channel I/O does not have IOMMU hardware support, so the physical
 vfio-ccw device does not have an IOMMU level translation or isolation.
 
-Sub-channel I/O instructions are all privileged instructions, When
+Subchannel I/O instructions are all privileged instructions. When
 handling the I/O instruction interception, vfio-ccw has the software
 policing and translation how the channel program is programmed before
 it gets sent to hardware.
@@ -121,7 +120,7 @@ devices:
 - The vfio_mdev driver for the mediated vfio ccw device.
   This is provided by the mdev framework. It is a vfio device driver for
   the mdev that created by vfio_ccw.
-  It realize a group of vfio device driver callbacks, adds itself to a
+  It realizes a group of vfio device driver callbacks, adds itself to a
   vfio group, and registers itself to the mdev framework as a mdev
   driver.
   It uses a vfio iommu backend that uses the existing map and unmap
@@ -178,7 +177,7 @@ vfio-ccw I/O region
 
 An I/O region is used to accept channel program request from user
 space and store I/O interrupt result for user space to retrieve. The
-defination of the region is:
+definition of the region is:
 
 struct ccw_io_region {
 #define ORB_AREA_SIZE 12
@@ -198,30 +197,23 @@ irb_area stores the I/O result.
 
 ret_code stores a return code for each access of the region.
 
-vfio-ccw patches overview
--------------------------
+vfio-ccw operation details
+--------------------------
 
-For now, our patches are rebased on the latest mdev implementation.
-vfio-ccw follows what vfio-pci did on the s390 paltform and uses
-vfio-iommu-type1 as the vfio iommu backend. It's a good start to launch
-the code review for vfio-ccw. Note that the implementation is far from
-complete yet; but we'd like to get feedback for the general
-architecture.
+vfio-ccw follows what vfio-pci did on the s390 platform and uses
+vfio-iommu-type1 as the vfio iommu backend.
 
 * CCW translation APIs
-- Description:
-  These introduce a group of APIs (start with 'cp_') to do CCW
-  translation. The CCWs passed in by a user space program are
-  organized with their guest physical memory addresses. These APIs
-  will copy the CCWs into the kernel space, and assemble a runnable
-  kernel channel program by updating the guest physical addresses with
-  their corresponding host physical addresses.
-- Patches:
-  vfio: ccw: introduce channel program interfaces
+  A group of APIs (start with 'cp_') to do CCW translation. The CCWs
+  passed in by a user space program are organized with their guest
+  physical memory addresses. These APIs will copy the CCWs into kernel
+  space, and assemble a runnable kernel channel program by updating the
+  guest physical addresses with their corresponding host physical addresses.
+  Note that we have to use IDALs even for direct-access CCWs, as the
+  referenced memory can be located anywhere, including above 2G.
 
 * vfio_ccw device driver
-- Description:
-  The following patches utilizes the CCW translation APIs and introduce
+  This driver utilizes the CCW translation APIs and introduces
   vfio_ccw, which is the driver for the I/O subchannel devices you want
   to pass through.
   vfio_ccw implements the following vfio ioctls:
@@ -236,20 +228,14 @@ architecture.
   This also provides the SET_IRQ ioctl to setup an event notifier to
   notify the user space program the I/O completion in an asynchronous
   way.
-- Patches:
-  vfio: ccw: basic implementation for vfio_ccw driver
-  vfio: ccw: introduce ccw_io_region
-  vfio: ccw: realize VFIO_DEVICE_GET_REGION_INFO ioctl
-  vfio: ccw: realize VFIO_DEVICE_RESET ioctl
-  vfio: ccw: realize VFIO_DEVICE_G(S)ET_IRQ_INFO ioctls
-
-The user of vfio-ccw is not limited to Qemu, while Qemu is definitely a
+
+The use of vfio-ccw is not limited to QEMU, while QEMU is definitely a
 good example to get understand how these patches work. Here is a little
-bit more detail how an I/O request triggered by the Qemu guest will be
+bit more detail how an I/O request triggered by the QEMU guest will be
 handled (without error handling).
 
 Explanation:
-Q1-Q7: Qemu side process.
+Q1-Q7: QEMU side process.
 K1-K5: Kernel side process.
 
 Q1. Get I/O region info during initialization.
@@ -263,7 +249,7 @@ Q4. Write the guest channel program and ORB to the I/O region.
     K2. Translate the guest channel program to a host kernel space
         channel program, which becomes runnable for a real device.
     K3. With the necessary information contained in the orb passed in
-        by Qemu, issue the ccwchain to the device.
+        by QEMU, issue the ccwchain to the device.
     K4. Return the ssch CC code.
 Q5. Return the CC code to the guest.
 
@@ -271,7 +257,7 @@ Q5. Return the CC code to the guest.
 
     K5. Interrupt handler gets the I/O result and write the result to
         the I/O region.
-    K6. Signal Qemu to retrieve the result.
+    K6. Signal QEMU to retrieve the result.
 Q6. Get the signal and event handler reads out the result from the I/O
     region.
 Q7. Update the irb for the guest.
@@ -289,10 +275,20 @@ More information for DASD and ECKD could be found here:
 https://en.wikipedia.org/wiki/Direct-access_storage_device
 https://en.wikipedia.org/wiki/Count_key_data
 
-Together with the corresponding work in Qemu, we can bring the passed
+Together with the corresponding work in QEMU, we can bring the passed
 through DASD/ECKD device online in a guest now and use it as a block
 device.
 
+While the current code allows the guest to start channel programs via
+START SUBCHANNEL, support for HALT SUBCHANNEL or CLEAR SUBCHANNEL is
+not yet implemented.
+
+vfio-ccw supports classic (command mode) channel I/O only. Transport
+mode (HPF) is not supported.
+
+QDIO subchannels are currently not supported. Classic devices other than
+DASD/ECKD might work, but have not been tested.
+
 Reference
 ---------
 1. ESA/s390 Principles of Operation manual (IBM Form. No. SA22-7832)
-- 
2.13.6
