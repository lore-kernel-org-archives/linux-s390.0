Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40780 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729376AbfFMTkX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 13 Jun 2019 15:40:23 -0400
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v4 0/7] s390: vfio-ap: dynamic configuration support
Date: Thu, 13 Jun 2019 15:39:33 -0400
Message-Id: <1560454780-20359-1-git-send-email-akrowiak@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, david@redhat.com, mjrosato@linux.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, Tony Krowiak <akrowiak@linux.ibm.com>

The current design for AP pass-through does not support making dynamic
changes to the AP matrix of a running guest resulting in three deficiencies
this patch series is intended to mitigate:

1. Adapters, domains and control domains can not be added to or removed
   from a running guest. In order to modify a guest's AP configuration,
   the guest must be terminated; only then can AP resources be assigned
   to or unassigned from the guest's matrix mdev. The new AP configuration
   becomes available to the guest when it is subsequently restarted.

2. The AP bus's /sys/bus/ap/apmask and /sys/bus/ap/aqmask interfaces can
   be modified by a root user without any restrictions. A change to either
   mask can result in AP queue devices being unbound from the vfio_ap
   device driver and bound to a zcrypt device driver even if a guest is
   using the queues, thus giving the host access to the guest's private
   crypto data and vice versa.

3. The APQNs derived from the Cartesian product of the APIDs of the
   adapters and APQIs of the domains assigned to a matrix mdev must
   an AP queue device bound to the vfio_ap device driver. 

This patch series introduces the following changes to the current design
to alleviate the shortcomings described above as well as to implement more
of the AP architecture:

1. A root user will be prevented from making changes to the AP bus's
   /sys/bus/ap/apmask or /sys/bus/ap/aqmask if the ownership of an APQN
   changes from the vfio_ap device driver to a zcrypt driver if the APQN is
   assigned to a matrix mdev.

2. The sysfs bind/unbind interfaces will be disabled for the vfio_ap device
   driver.

3. Allow AP resources to be assigned to or removed from a matrix mdev
   while a guest is using it and hot plug the resource into or hot unplug
   the resource from the running guest.

4. Allow assignment of an AP adapter or domain to a matrix mdev even if it
   results in assignment of an APQN that does not reference an AP queue
   device bound to the vfio_ap device driver, as long as the APQN is owned
   by the vfio_ap driver. Allowing over-provisioning of AP resources
   better models the architecture which does not preclude assigning AP
   resources that are not yet available in the system.

1. Rationale for changes to AP bus's apmask/aqmask interfaces:
----------------------------------------------------------
Due to the extremely sensitive nature of cryptographic data, it is
imperative that great care be taken to ensure that such data is secured.
Allowing a root user, either inadvertently or maliciously, to configure
these masks such that a queue is shared between the host and a guest is
not only avoidable, it is advisable. It was suggested that this scenario
is better handled in user space with management software, but that does
not preclude a malicious administrator from using the sysfs interfaces
to gain access to a guest's crypto data. It was also suggested that this
scenario could be avoided by taking access to the adapter away from the
guest and zeroing out the queues prior to the vfio_ap driver releasing the
device; however, stealing an adapter in use from a guest as a by-product
of an operation is bad and will likely cause problems for the guest
unnecessarily. It was decided that the most effective solution with the
least number of negative side effects is to prevent the situation at the
source. It is not out of the ordinary for the kernel to prevent a root
user from performing an action under certain circumstances; for example,
a root user is prevented from removing a module until all references to it
are given up. An even more pertinent example is the device driver bind
interface. Binding a device to a driver that does not meet the match
criteria will be rejected by the kernel.

2. Rationale for disabling bind/unbind interfaces for vfio_ap driver:
-----------------------------------------------------------------
By disabling the bind/unbind interfaces for the vfio_ap device driver, 
the user is forced to use the AP bus's apmask/aqmask interfaces to control
the probing and removing of AP queues. There are two primary reasons for
disabling the bind/unbind interfaces for the vfio_ap device driver:

* The device architecture does not provide a means to prevent unbinding
  a device from a device driver, so an AP queue device can be unbound
  from the vfio_ap driver even the queue is in use by a guest. By
  disabling the unbind interface, the user is forced to use the AP bus's
  apmask/aqmask interfaces which will prevent this.

* Binding of AP queues is controlled by the AP bus /sys/bus/ap/apmask and
  /sys/bus/ap/aqmask interfaces. If the masks indicate that an APQN is
  owned by zcrypt, trying to bind it to the vfio_ap device driver will
  fail; therefore, the bind interface is somewhat redundant and certainly
  unnecessary.        
  
3. Rationale for hot plug/unplug using matrix mdev sysfs interfaces:
----------------------------------------------------------------
Allowing a user to hot plug/unplug AP resources using the matrix mdev
sysfs interfaces circumvents the need to terminate the guest in order to
modify its AP configuration. Allowing dynamic configuration makes 
reconfiguring a guest's AP matrix much less disruptive.

4. Rationale for allowing over-provisioning of AP resources:
----------------------------------------------------------- 
Allowing assignment of AP resources to a matrix mdev and ultimately to a
guest better models the AP architecture. The architecture does not
preclude assignment of unavailable AP resources. If a queue subsequently
becomes available while a guest using the matrix mdev to which its APQN
is assigned, the guest will automatically acquire access to it. If an APQN
is dynamically unassigned from the underlying host system, it will 
automatically become unavailable to the guest.

Note: This patch series is rebased on top of the patch series for
      'vfio: ap: AP Queue Interrupt Control' (v9) to make merging of the
      two series simpler. 
 

Change log v3->v4:
-----------------
* Restored patches preventing root user from changing ownership of
  APQNs from zcrypt drivers to the vfio_ap driver if the APQN is
  assigned to an mdev.

* No longer enforcing requirement restricting guest access to
  queues represented by a queue device bound to the vfio_ap
  device driver.

* Removed shadow CRYCB and now directly updating the guest CRYCB
  from the matrix mdev's matrix.

* Rebased the patch series on top of 'vfio: ap: AP Queue Interrupt
  Control' patches.

* Disabled bind/unbind sysfs interfaces for vfio_ap driver

Change log v2->v3:
-----------------
* Allow guest access to an AP queue only if the queue is bound to
  the vfio_ap device driver.

* Removed the patch to test CRYCB masks before taking the vCPUs
  out of SIE. Now checking the shadow CRYCB in the vfio_ap driver.

Change log v1->v2:
-----------------
* Removed patches preventing root user from unbinding AP queues from 
  the vfio_ap device driver
* Introduced a shadow CRYCB in the vfio_ap driver to manage dynamic 
  changes to the AP guest configuration due to root user interventions
  or hardware anomalies.

Tony Krowiak (7):
  s390: vfio-ap: Refactor vfio_ap driver probe and remove callbacks
  s390: vfio-ap: wait for queue empty on queue reset
  s390: zcrypt: driver callback to indicate resource in use
  s390: vfio-ap: implement in-use callback for vfio_ap driver
  s390: vfio-ap: allow assignment of unavailable AP resources to mdev
    device
  s390: vfio-ap: allow hot plug/unplug of AP resources using mdev device
  s390: vfio-ap: update documentation

 Documentation/s390/vfio-ap.txt        | 292 +++++++++++++++++++--------
 drivers/s390/crypto/ap_bus.c          | 138 ++++++++++++-
 drivers/s390/crypto/ap_bus.h          |   3 +
 drivers/s390/crypto/vfio_ap_drv.c     |  51 +++--
 drivers/s390/crypto/vfio_ap_ops.c     | 370 +++++++++++++---------------------
 drivers/s390/crypto/vfio_ap_private.h |   6 +-
 6 files changed, 526 insertions(+), 334 deletions(-)

-- 
2.7.4
