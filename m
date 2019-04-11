Return-Path: <SRS0=MvP8=SN=vger.kernel.org=kvm-owner@kernel.org>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH 7/7] s390: vfio-ap: update documentation
Date: Thu, 11 Apr 2019 17:03:24 -0400
In-Reply-To: <1555016604-2008-1-git-send-email-akrowiak@linux.ibm.com>
References: <1555016604-2008-1-git-send-email-akrowiak@linux.ibm.com>
Message-Id: <1555016604-2008-8-git-send-email-akrowiak@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Updates to the documentation to reflect changes introduced by
this patch series. This patch also clarifies the section on
configuring the apmask and aqmask.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 Documentation/s390/vfio-ap.txt | 147 +++++++++++++++++++++++++++++++----------
 1 file changed, 113 insertions(+), 34 deletions(-)

diff --git a/Documentation/s390/vfio-ap.txt b/Documentation/s390/vfio-ap.txt
index 65167cfe4485..aa9ff0b4f9b1 100644
--- a/Documentation/s390/vfio-ap.txt
+++ b/Documentation/s390/vfio-ap.txt
@@ -438,7 +438,33 @@ guest use.
 Example:
 =======
 Let's now provide an example to illustrate how KVM guests may be given
-access to AP facilities. For this example, we will show how to configure
+access to AP facilities. Let's assume that the following AP devices are
+configured for the host:
+
+/sys/bus/ap/devices
+... 04.0004
+... 04.0005
+... 04.0006
+... 04.0047
+... 04.00ab
+... 04.00ff
+... 05.0004
+... 05.0005
+... 05.0006
+... 05.0047
+... 05.00ab
+... 05.00ff
+... 06.0004
+... 06.0005
+... 06.0006
+... 06.0047
+... 06.00ab
+... 06.00ff
+... card04
+... card05
+... card06
+
+For this example, we will show how to configure
 three guests such that executing the lszcrypt command on the guests would
 look like this:
 
@@ -461,7 +487,7 @@ CARD.DOMAIN TYPE  MODE
 05.0047     CEX5A Accelerator
 05.00ff     CEX5A Accelerator
 
-Guest2
+Guest3
 ------
 CARD.DOMAIN TYPE  MODE
 ------------------------------
@@ -538,7 +564,7 @@ These are the steps:
    The APQN of each AP queue device assigned to the linux host is checked by the
    AP bus against the set of APQNs derived from the cross product of APIDs
    and APQIs marked as usable only by the default AP queue device drivers. If a
-   match is detected,  only the default AP queue device drivers will be probed;
+   match is detected, only the default AP queue device drivers will be probed;
    otherwise, the vfio_ap device driver will be probed.
 
    By default, the two masks are set to reserve all APQNs for use by the default
@@ -599,32 +625,72 @@ These are the steps:
             default drivers pool:    adapter 0-15, domain 1
             alternate drivers pool:  adapter 16-255, domains 0, 2-255
 
+   Note:
+
+   * Clearing a bit from the apmask renders all queues associated with
+     the corresponding adapter inaccessible to the host.
+
+   * Clearing a bit from the aqmask renders that queue inaccessible on all
+     adapters reserved for the host.
+
+   * When either mask is changed, the AP bus will reprobe all of the AP devices
+     to ensure each adapter card and queue is bound to the appropriate device
+     driver as specified by the apmask and aqmask. If the change will result in
+     unbinding an AP queue with an APQN that is assigned to an mdev device,
+     the change will be rejected with an EADDRINUSE error.
+
    Securing the APQNs for our example:
    ----------------------------------
    To secure the AP queues 05.0004, 05.0047, 05.00ab, 05.00ff, 06.0004, 06.0047,
-   06.00ab, and 06.00ff for use by the vfio_ap device driver, the corresponding
-   APQNs can either be removed from the default masks:
+   06.00ab, and 06.00ff for use by the vfio_ap device driver, either mask can
+   be edited.
+
+   To reserve all queues for adapters 05 and 06:
 
       echo -5,-6 > /sys/bus/ap/apmask
+      or
+      echo 0xf9ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff \
+      > apmask
 
-      echo -4,-0x47,-0xab,-0xff > /sys/bus/ap/aqmask
+   This would result in binding all available queues for adapters 05 and 06 to
+   the vfio_ap device driver:
 
-   Or the masks can be set as follows:
+   /sys/bus/ap
+   ... [drivers]
+   ...... [vfio_ap]
+   ......... [05.0004]
+   ......... [05.0005]
+   ......... [05.0006]
+   ......... [05.0047]
+   ......... [05.00ab]
+   ......... [05.00ff]
+   ......... [06.0004]
+   ......... [06.0005]
+   ......... [06.0006]
+   ......... [06.0047]
+   ......... [06.00ab]
+   ......... [06.00ff]
 
-      echo 0xf9ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff \
-      > apmask
+   To reserve only the queues (thus allowing the adapters to be shared by the
+   host and guests):
 
+      echo -4,-0x47,-0xab,-0xff > /sys/bus/ap/aqmask
+      or
       echo 0xf7fffffffffffffffeffffffffffffffffffffffffeffffffffffffffffffffe \
       > aqmask
 
-   This will result in AP queues 05.0004, 05.0047, 05.00ab, 05.00ff, 06.0004,
-   06.0047, 06.00ab, and 06.00ff getting bound to the vfio_ap device driver. The
-   sysfs directory for the vfio_ap device driver will now contain symbolic links
-   to the AP queue devices bound to it:
+   Or the masks can be set as follows:
+
+   This would result in binding only queues 4, 71 (0x47), 171 (0xab), and
+   255 (0xff) all available adapters to the vfio_ap device driver:
 
    /sys/bus/ap
    ... [drivers]
    ...... [vfio_ap]
+   ......... [04.0004]
+   ......... [04.0047]
+   ......... [04.00ab]
+   ......... [04.00ff]
    ......... [05.0004]
    ......... [05.0047]
    ......... [05.00ab]
@@ -709,6 +775,16 @@ These are the steps:
 
 4. The administrator now needs to configure the matrixes for the mediated
    devices $uuid1 (for Guest1), $uuid2 (for Guest2) and $uuid3 (for Guest3).
+   The matrix is configured by assigning adapters, domains, and control domains
+   to the mediated matrix device using its sysfs assignment interfaces.
+
+   For example, to assign adapters 4, 5, 6, 22 and 23:
+
+	echo 4 > assign_adapter
+	echo 5 > assign_adapter
+	echo 6 > assign_adapter
+	echo 22 > assign_adapter
+	echo 23 > assign_adapter
 
    This is how the matrix is configured for Guest1:
 
@@ -748,11 +824,9 @@ These are the steps:
      an error (ENODEV).
 
    * All APQNs that can be derived from the adapter ID and the IDs of
-     the previously assigned domains must be bound to the vfio_ap device
-     driver. If no domains have yet been assigned, then there must be at least
-     one APQN with the specified APID bound to the vfio_ap driver. If no such
-     APQNs are bound to the driver, the operation will terminate with an
-     error (EADDRNOTAVAIL).
+     the previously assigned domains must be available for use by the vfio_ap
+     device driver as specified by the bus's apmask and aqmask sysfs interfaces;
+     otherwise, the operation will terminate with an error (EADDRNOTAVAIL).
 
      No APQN that can be derived from the adapter ID and the IDs of the
      previously assigned domains can be assigned to another mediated matrix
@@ -767,11 +841,9 @@ These are the steps:
      an error (ENODEV).
 
    * All APQNs that can be derived from the domain ID and the IDs of
-     the previously assigned adapters must be bound to the vfio_ap device
-     driver. If no domains have yet been assigned, then there must be at least
-     one APQN with the specified APQI bound to the vfio_ap driver. If no such
-     APQNs are bound to the driver, the operation will terminate with an
-     error (EADDRNOTAVAIL).
+     the previously assigned adapters must be available for use by the vfio_ap
+     device driver as specified by the bus's apmask and aqmask sysfs interfaces;
+     otherwise, the operation will terminate with an error (EADDRNOTAVAIL).
 
      No APQN that can be derived from the domain ID and the IDs of the
      previously assigned adapters can be assigned to another mediated matrix
@@ -824,14 +896,21 @@ Using our example again, to remove the mediated matrix device $uuid1:
 
 Limitations
 ===========
-* The KVM/kernel interfaces do not provide a way to prevent restoring an APQN
-  to the default drivers pool of a queue that is still assigned to a mediated
-  device in use by a guest. It is incumbent upon the administrator to
-  ensure there is no mediated device in use by a guest to which the APQN is
-  assigned lest the host be given access to the private data of the AP queue
-  device such as a private key configured specifically for the guest.
-
-* Dynamically modifying the AP matrix for a running guest (which would amount to
-  hot(un)plug of AP devices for the guest) is currently not supported
-
-* Live guest migration is not supported for guests using AP devices.
+* Live guest migration is not supported for guests using AP devices. The
+  AP devices being used by the guest must be unplugged before live migration
+  can be initiated. Hot plug/unplug of adapters, domains and control domains can
+  be done using the mediated matrix device sysfs assignment interfaces. To
+  unplug an adapter from a running guest, simply unassign it. For example, if
+  a guest is using adapters 0 through 15, they can be unplugged as follows:
+
+	echo 0 > unassign_adapter
+	echo 1 > unassign_adapter
+	echo 2 > unassign_adapter
+	...
+	echo 15 > unassign_adapter
+
+  Note that if you unassign an adapter, all of the associated domains will also
+  become inaccessible on the guest, so it is only necessary to unassign
+  the adapters before live migration. After the live migration is complete,
+  the AP resources will have to be re-assigned to the mediated matrix device
+  on the target system.
-- 
2.7.4
