Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 8 Jun 2020 17:34:39 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [GIT PULL] s390 patches for the 5.8 merge window
Message-ID: <your-ad-here.call-01591630479-ext-3636@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.8. There are some common code changes to
pci code acked by Bjorn Helgaas:
https://lore.kernel.org/linux-pci/20200507155132.GA6568@bjorn-Precision-5520/
As well as MAINTAINERS file touched to add s390 specific pci documentation.

The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.8-1

for you to fetch changes up to bfa50e1427e4608ce6941d3d0855445fcaa7dbb7:

  vfio-ccw: make vfio_ccw_regops variables declarations static (2020-06-04 13:45:51 +0200)

Please note 2 minor merge conflict resolutions below:

diff --cc arch/s390/kernel/smp.c
index 10dbb12eb14d,fc1041257c60..000000000000
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@@ -403,7 -404,12 +404,12 @@@ int smp_find_processor_id(u16 address
  	return -1;
  }
  
+ void schedule_mcck_handler(void)
+ {
+ 	pcpu_ec_call(pcpu_devices + smp_processor_id(), ec_mcck_pending);
+ }
+ 
 -bool arch_vcpu_is_preempted(int cpu)
 +bool notrace arch_vcpu_is_preempted(int cpu)
  {
  	if (test_cpu_flag_of(CIF_ENABLED_WAIT, cpu))
  		return false;
diff --cc arch/s390/kvm/vsie.c
index ef05b4e167fb,4fde24a1856e..000000000000
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@@ -1000,9 -1000,9 +1000,6 @@@ static int do_vsie_run(struct kvm_vcpu 
  
  	handle_last_fault(vcpu, vsie_page);
  
- 	if (test_cpu_flag(CIF_MCCK_PENDING))
- 		s390_handle_mcck();
 -	if (need_resched())
 -		schedule();
--
  	srcu_read_unlock(&vcpu->kvm->srcu, vcpu->srcu_idx);
  
  	/* save current guest state of bp isolation override */

Thank you,
Vasily

----------------------------------------------------------------
s390 updates for the 5.8 merge window

- Add support for multi-function devices in pci code.

- Enable PF-VF linking for architectures using the
  pdev->no_vf_scan flag (currently just s390).

- Add reipl from NVMe support.

- Get rid of critical section cleanup in entry.S.

- Refactor PNSO CHSC (perform network subchannel operation) in cio
  and qeth.

- QDIO interrupts and error handling fixes and improvements, more
  refactoring changes.

- Align ioremap() with generic code.

- Accept requests without the prefetch bit set in vfio-ccw.

- Enable path handling via two new regions in vfio-ccw.

- Other small fixes and improvements all over the code.

----------------------------------------------------------------
Alexander Schmidt (1):
      s390/pci: Expose new port attribute for PCIe functions

Alexandra Winter (1):
      s390/cio, s390/qeth: cleanup PNSO CHSC

Cornelia Huck (1):
      vfio-ccw: document possible errors

David Hildenbrand (1):
      s390: simplify memory notifier for protecting kdump crash kernel area

Eric Farman (3):
      vfio-ccw: Refactor the unregister of the async regions
      vfio-ccw: Refactor IRQ handlers
      vfio-ccw: Add trace for CRW event

Farhan Ali (5):
      vfio-ccw: Introduce new helper functions to free/destroy regions
      vfio-ccw: Register a chp_event callback for vfio-ccw
      vfio-ccw: Introduce a new schib region
      vfio-ccw: Introduce a new CRW region
      vfio-ccw: Wire up the CRW irq and CRW region

Gerald Schaefer (1):
      Documentation/s390: Update / remove developerWorks web links

Harald Freudenberger (1):
      s390/ap: introduce new ap function ap_get_qdev()

Jared Rossi (1):
      vfio-ccw: Enable transparent CCW IPL from DASD

Jason J. Herne (2):
      s390: nvme ipl
      s390: nvme reipl

Julian Wiedmann (14):
      s390/qdio: consistently restore the IRQ handler
      s390/qdio: tear down thinint indicator after early error
      s390/qdio: put thinint indicator after early error
      s390/qdio: consolidate thinint init/exit
      s390/qdio: do more fine-grained allocation roll-back
      s390/qdio: roll-back after queue allocation error
      s390/qdio: keep track of allocated queue count
      s390/qdio: de-duplicate tiqdio_inbound_processing()
      s390/qdio: remove always-true condition
      s390/qdio: simplify overlap calculation on Input refill
      s390/qdio: refactor ACK processing for primed SBALs
      s390/qdio: add IRQ reduction for error SBALs
      s390/qdio: fix up qdio_start_irq() kerneldoc
      s390/qdio: remove q->first_to_kick

Masahiro Yamada (1):
      s390: ptrace: hard-code "s390x" instead of UTS_MACHINE

Niklas Schnelle (3):
      PCI/IOV: Introduce pci_iov_sysfs_link() function
      s390/pci: create links between PFs and VFs
      s390/pci: ioremap() align with generic code

Petr Tesarik (1):
      s390/pci: Log new handle in clp_disable_fh()

Pierre Morel (11):
      s390/pci: adaptation of iommu to multifunction
      s390/pci: define kernel parameters for PCI multifunction
      s390/pci: define RID and RID available
      s390/pci: create zPCI bus
      s390/pci: adapt events for zbus
      s390/pci: Adding bus resource
      s390/pci: Handling multifunctions
      s390/pci: Do not disable PF when VFs exist
      s390/pci: Documentation for zPCI
      s390/pci: removes wrong PCI multifunction assignment
      s390/pci: Documentation update for s390 PCI

Sven Schnelle (2):
      s390: add machine check SIGP
      s390: remove critical section cleanup from entry.S

Vasily Gorbik (2):
      Merge tag 'vfio-ccw-20200603-v2' of https://git.kernel.org/.../kvms390/vfio-ccw into features
      vfio-ccw: make vfio_ccw_regops variables declarations static

YueHaibing (2):
      s390: Remove two unused inline functions
      s390/cio: Remove unused inline function idset_sch_get_first

 Documentation/admin-guide/kernel-parameters.txt |   2 +
 Documentation/s390/index.rst                    |   1 +
 Documentation/s390/pci.rst                      | 125 +++++++
 Documentation/s390/vfio-ccw.rst                 | 100 ++++-
 Documentation/s390/zfcpdump.rst                 |   4 +-
 MAINTAINERS                                     |   1 +
 arch/s390/appldata/appldata_mem.c               |   4 -
 arch/s390/appldata/appldata_net_sum.c           |   4 -
 arch/s390/appldata/appldata_os.c                |   4 -
 arch/s390/include/asm/ccwdev.h                  |   5 +
 arch/s390/include/asm/chsc.h                    |  62 ++++
 arch/s390/include/asm/io.h                      |   2 +-
 arch/s390/include/asm/ipl.h                     |  11 +
 arch/s390/include/asm/nmi.h                     |   2 +-
 arch/s390/include/asm/pci.h                     |  42 ++-
 arch/s390/include/asm/pci_clp.h                 |  13 +-
 arch/s390/include/asm/processor.h               |  20 +-
 arch/s390/include/asm/qdio.h                    |  33 --
 arch/s390/include/asm/smp.h                     |   1 +
 arch/s390/include/uapi/asm/ipl.h                |  25 ++
 arch/s390/kernel/Makefile                       |   5 -
 arch/s390/kernel/entry.S                        | 464 ++++++------------------
 arch/s390/kernel/ftrace.c                       |  16 -
 arch/s390/kernel/idle.c                         |  14 +-
 arch/s390/kernel/ipl.c                          | 209 +++++++++++
 arch/s390/kernel/nmi.c                          |  23 +-
 arch/s390/kernel/ptrace.c                       |   2 +-
 arch/s390/kernel/setup.c                        |  16 +-
 arch/s390/kernel/smp.c                          |   8 +
 arch/s390/kvm/kvm-s390.c                        |   3 -
 arch/s390/kvm/vsie.c                            |   2 -
 arch/s390/lib/delay.c                           |   4 +-
 arch/s390/pci/Makefile                          |   3 +-
 arch/s390/pci/pci.c                             | 225 +++++-------
 arch/s390/pci/pci_bus.c                         | 328 +++++++++++++++++
 arch/s390/pci/pci_bus.h                         |  31 ++
 arch/s390/pci/pci_clp.c                         |   8 +-
 arch/s390/pci/pci_event.c                       |  39 +-
 arch/s390/pci/pci_sysfs.c                       |   4 +-
 drivers/iommu/s390-iommu.c                      |   8 +-
 drivers/pci/hotplug/s390_pci_hpc.c              |  16 +-
 drivers/pci/iov.c                               |  39 +-
 drivers/s390/cio/Makefile                       |   2 +-
 drivers/s390/cio/chsc.c                         |  40 +-
 drivers/s390/cio/chsc.h                         |  50 +--
 drivers/s390/cio/device_ops.c                   |  23 ++
 drivers/s390/cio/idset.c                        |  12 -
 drivers/s390/cio/qdio.h                         |  16 +-
 drivers/s390/cio/qdio_main.c                    | 299 ++++-----------
 drivers/s390/cio/qdio_setup.c                   | 100 +++--
 drivers/s390/cio/qdio_thinint.c                 |  61 ++--
 drivers/s390/cio/vfio_ccw_chp.c                 | 148 ++++++++
 drivers/s390/cio/vfio_ccw_cp.c                  |  19 +-
 drivers/s390/cio/vfio_ccw_drv.c                 | 165 ++++++++-
 drivers/s390/cio/vfio_ccw_ops.c                 |  65 +++-
 drivers/s390/cio/vfio_ccw_private.h             |  16 +
 drivers/s390/cio/vfio_ccw_trace.c               |   1 +
 drivers/s390/cio/vfio_ccw_trace.h               |  30 ++
 drivers/s390/crypto/ap_bus.c                    |  94 +++--
 drivers/s390/crypto/ap_bus.h                    |  25 +-
 drivers/s390/crypto/ap_card.c                   |  47 ++-
 drivers/s390/crypto/ap_queue.c                  |  10 +-
 drivers/s390/net/qeth_l2_main.c                 | 198 +++++-----
 include/linux/pci.h                             |   8 +
 include/uapi/linux/vfio.h                       |   3 +
 include/uapi/linux/vfio_ccw.h                   |  19 +
 66 files changed, 2131 insertions(+), 1248 deletions(-)
 create mode 100644 Documentation/s390/pci.rst
 create mode 100644 arch/s390/include/asm/chsc.h
 create mode 100644 arch/s390/pci/pci_bus.c
 create mode 100644 arch/s390/pci/pci_bus.h
 create mode 100644 drivers/s390/cio/vfio_ccw_chp.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f2a93c8679e8..e6d4fb2e32d0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3669,6 +3669,8 @@
 				may put more devices in an IOMMU group.
 		force_floating	[S390] Force usage of floating interrupts.
 		nomio		[S390] Do not use MIO instructions.
+		norid		[S390] ignore the RID field and force use of
+				one PCI domain per PCI function
 
 	pcie_aspm=	[PCIE] Forcibly enable or disable PCIe Active State Power
 			Management.
diff --git a/Documentation/s390/index.rst b/Documentation/s390/index.rst
index f7af2061e406..cf71df5776b4 100644
--- a/Documentation/s390/index.rst
+++ b/Documentation/s390/index.rst
@@ -15,6 +15,7 @@ s390 Architecture
     vfio-ccw
     zfcpdump
     common_io
+    pci
 
     text_files
 
diff --git a/Documentation/s390/pci.rst b/Documentation/s390/pci.rst
new file mode 100644
index 000000000000..492850bff316
--- /dev/null
+++ b/Documentation/s390/pci.rst
@@ -0,0 +1,125 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========
+S/390 PCI
+=========
+
+Authors:
+        - Pierre Morel
+
+Copyright, IBM Corp. 2020
+
+
+Command line parameters and debugfs entries
+===========================================
+
+Command line parameters
+-----------------------
+
+* nomio
+
+  Do not use PCI Mapped I/O (MIO) instructions.
+
+* norid
+
+  Ignore the RID field and force use of one PCI domain per PCI function.
+
+debugfs entries
+---------------
+
+The S/390 debug feature (s390dbf) generates views to hold various debug results in sysfs directories of the form:
+
+ * /sys/kernel/debug/s390dbf/pci_*/
+
+For example:
+
+  - /sys/kernel/debug/s390dbf/pci_msg/sprintf
+    Holds messages from the processing of PCI events, like machine check handling
+    and setting of global functionality, like UID checking.
+
+  Change the level of logging to be more or less verbose by piping
+  a number between 0 and 6 to  /sys/kernel/debug/s390dbf/pci_*/level. For
+  details, see the documentation on the S/390 debug feature at
+  Documentation/s390/s390dbf.rst.
+
+Sysfs entries
+=============
+
+Entries specific to zPCI functions and entries that hold zPCI information.
+
+* /sys/bus/pci/slots/XXXXXXXX
+
+  The slot entries are set up using the function identifier (FID) of the
+  PCI function.
+
+  - /sys/bus/pci/slots/XXXXXXXX/power
+
+  A physical function that currently supports a virtual function cannot be
+  powered off until all virtual functions are removed with:
+  echo 0 > /sys/bus/pci/devices/XXXX:XX:XX.X/sriov_numvf
+
+* /sys/bus/pci/devices/XXXX:XX:XX.X/
+
+  - function_id
+    A zPCI function identifier that uniquely identifies the function in the Z server.
+
+  - function_handle
+    Low-level identifier used for a configured PCI function.
+    It might be useful for debuging.
+
+  - pchid
+    Model-dependent location of the I/O adapter.
+
+  - pfgid
+    PCI function group ID, functions that share identical functionality
+    use a common identifier.
+    A PCI group defines interrupts, IOMMU, IOTLB, and DMA specifics.
+
+  - vfn
+    The virtual function number, from 1 to N for virtual functions,
+    0 for physical functions.
+
+  - pft
+    The PCI function type
+
+  - port
+    The port corresponds to the physical port the function is attached to.
+    It also gives an indication of the physical function a virtual function
+    is attached to.
+
+  - uid
+    The unique identifier (UID) is defined when configuring an LPAR and is
+    unique in the LPAR.
+
+  - pfip/segmentX
+    The segments determine the isolation of a function.
+    They correspond to the physical path to the function.
+    The more the segments are different, the more the functions are isolated.
+
+Enumeration and hotplug
+=======================
+
+The PCI address consists of four parts: domain, bus, device and function,
+and is of this form: DDDD:BB:dd.f
+
+* When not using multi-functions (norid is set, or the firmware does not
+  support multi-functions):
+
+  - There is only one function per domain.
+
+  - The domain is set from the zPCI function's UID as defined during the
+    LPAR creation.
+
+* When using multi-functions (norid parameter is not set),
+  zPCI functions are addressed differently:
+
+  - There is still only one bus per domain.
+
+  - There can be up to 256 functions per bus.
+
+  - The domain part of the address of all functions for
+    a multi-Function device is set from the zPCI function's UID as defined
+    in the LPAR creation for the function zero.
+
+  - New functions will only be ready for use after the function zero
+    (the function with devfn 0) has been enumerated.
diff --git a/Documentation/s390/vfio-ccw.rst b/Documentation/s390/vfio-ccw.rst
index fca9c4f5bd9c..8aad08a8b8a5 100644
--- a/Documentation/s390/vfio-ccw.rst
+++ b/Documentation/s390/vfio-ccw.rst
@@ -204,15 +204,44 @@ definition of the region is::
 	  __u32   ret_code;
   } __packed;
 
+This region is always available.
+
 While starting an I/O request, orb_area should be filled with the
 guest ORB, and scsw_area should be filled with the SCSW of the Virtual
 Subchannel.
 
 irb_area stores the I/O result.
 
-ret_code stores a return code for each access of the region.
+ret_code stores a return code for each access of the region. The following
+values may occur:
+
+``0``
+  The operation was successful.
+
+``-EOPNOTSUPP``
+  The orb specified transport mode or an unidentified IDAW format, or the
+  scsw specified a function other than the start function.
+
+``-EIO``
+  A request was issued while the device was not in a state ready to accept
+  requests, or an internal error occurred.
+
+``-EBUSY``
+  The subchannel was status pending or busy, or a request is already active.
+
+``-EAGAIN``
+  A request was being processed, and the caller should retry.
+
+``-EACCES``
+  The channel path(s) used for the I/O were found to be not operational.
+
+``-ENODEV``
+  The device was found to be not operational.
+
+``-EINVAL``
+  The orb specified a chain longer than 255 ccws, or an internal error
+  occurred.
 
-This region is always available.
 
 vfio-ccw cmd region
 -------------------
@@ -231,6 +260,64 @@ This region is exposed via region type VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD.
 
 Currently, CLEAR SUBCHANNEL and HALT SUBCHANNEL use this region.
 
+command specifies the command to be issued; ret_code stores a return code
+for each access of the region. The following values may occur:
+
+``0``
+  The operation was successful.
+
+``-ENODEV``
+  The device was found to be not operational.
+
+``-EINVAL``
+  A command other than halt or clear was specified.
+
+``-EIO``
+  A request was issued while the device was not in a state ready to accept
+  requests.
+
+``-EAGAIN``
+  A request was being processed, and the caller should retry.
+
+``-EBUSY``
+  The subchannel was status pending or busy while processing a halt request.
+
+vfio-ccw schib region
+---------------------
+
+The vfio-ccw schib region is used to return Subchannel-Information
+Block (SCHIB) data to userspace::
+
+  struct ccw_schib_region {
+  #define SCHIB_AREA_SIZE 52
+         __u8 schib_area[SCHIB_AREA_SIZE];
+  } __packed;
+
+This region is exposed via region type VFIO_REGION_SUBTYPE_CCW_SCHIB.
+
+Reading this region triggers a STORE SUBCHANNEL to be issued to the
+associated hardware.
+
+vfio-ccw crw region
+---------------------
+
+The vfio-ccw crw region is used to return Channel Report Word (CRW)
+data to userspace::
+
+  struct ccw_crw_region {
+         __u32 crw;
+         __u32 pad;
+  } __packed;
+
+This region is exposed via region type VFIO_REGION_SUBTYPE_CCW_CRW.
+
+Reading this region returns a CRW if one that is relevant for this
+subchannel (e.g. one reporting changes in channel path state) is
+pending, or all zeroes if not. If multiple CRWs are pending (including
+possibly chained CRWs), reading this region again will return the next
+one, until no more CRWs are pending and zeroes are returned. This is
+similar to how STORE CHANNEL REPORT WORD works.
+
 vfio-ccw operation details
 --------------------------
 
@@ -333,7 +420,14 @@ through DASD/ECKD device online in a guest now and use it as a block
 device.
 
 The current code allows the guest to start channel programs via
-START SUBCHANNEL, and to issue HALT SUBCHANNEL and CLEAR SUBCHANNEL.
+START SUBCHANNEL, and to issue HALT SUBCHANNEL, CLEAR SUBCHANNEL,
+and STORE SUBCHANNEL.
+
+Currently all channel programs are prefetched, regardless of the
+p-bit setting in the ORB.  As a result, self modifying channel
+programs are not supported.  For this reason, IPL has to be handled as
+a special case by a userspace/guest program; this has been implemented
+in QEMU's s390-ccw bios as of QEMU 4.1.
 
 vfio-ccw supports classic (command mode) channel I/O only. Transport
 mode (HPF) is not supported.
diff --git a/Documentation/s390/zfcpdump.rst b/Documentation/s390/zfcpdump.rst
index 54e8e7caf7e7..a61de7aa8778 100644
--- a/Documentation/s390/zfcpdump.rst
+++ b/Documentation/s390/zfcpdump.rst
@@ -46,5 +46,5 @@ initramfs with a user space application that writes the dump to a SCSI
 partition.
 
 For more information on how to use zfcpdump refer to the s390 'Using the Dump
-Tools book', which is available from
-http://www.ibm.com/developerworks/linux/linux390.
+Tools' book, which is available from IBM Knowledge Center:
+https://www.ibm.com/support/knowledgecenter/linuxonibm/liaaf/lnz_r_dt.html
diff --git a/MAINTAINERS b/MAINTAINERS
index b816a453b10e..1df86d6cd6c2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14662,6 +14662,7 @@ S:	Supported
 W:	http://www.ibm.com/developerworks/linux/linux390/
 F:	arch/s390/pci/
 F:	drivers/pci/hotplug/s390_pci_hpc.c
+F:	Documentation/s390/pci.rst
 
 S390 VFIO AP DRIVER
 M:	Tony Krowiak <akrowiak@linux.ibm.com>
diff --git a/arch/s390/appldata/appldata_mem.c b/arch/s390/appldata/appldata_mem.c
index e68136c3c23a..21c3147bd92a 100644
--- a/arch/s390/appldata/appldata_mem.c
+++ b/arch/s390/appldata/appldata_mem.c
@@ -29,10 +29,6 @@
  * the structure version (product ID, see appldata_base.c) needs to be changed
  * as well and all documentation and z/VM applications using it must be
  * updated.
- *
- * The record layout is documented in the Linux for zSeries Device Drivers
- * book:
- * http://oss.software.ibm.com/developerworks/opensource/linux390/index.shtml
  */
 struct appldata_mem_data {
 	u64 timestamp;
diff --git a/arch/s390/appldata/appldata_net_sum.c b/arch/s390/appldata/appldata_net_sum.c
index 8bc14b0d1def..59c282ca002f 100644
--- a/arch/s390/appldata/appldata_net_sum.c
+++ b/arch/s390/appldata/appldata_net_sum.c
@@ -25,10 +25,6 @@
  * This is accessed as binary data by z/VM. If changes to it can't be avoided,
  * the structure version (product ID, see appldata_base.c) needs to be changed
  * as well and all documentation and z/VM applications using it must be updated.
- *
- * The record layout is documented in the Linux for zSeries Device Drivers
- * book:
- * http://oss.software.ibm.com/developerworks/opensource/linux390/index.shtml
  */
 struct appldata_net_sum_data {
 	u64 timestamp;
diff --git a/arch/s390/appldata/appldata_os.c b/arch/s390/appldata/appldata_os.c
index 8bf46d705957..5503217366ec 100644
--- a/arch/s390/appldata/appldata_os.c
+++ b/arch/s390/appldata/appldata_os.c
@@ -32,10 +32,6 @@
  * the structure version (product ID, see appldata_base.c) needs to be changed
  * as well and all documentation and z/VM applications using it must be
  * updated.
- *
- * The record layout is documented in the Linux for zSeries Device Drivers
- * book:
- * http://oss.software.ibm.com/developerworks/opensource/linux390/index.shtml
  */
 struct appldata_os_per_cpu {
 	u32 per_cpu_user;	/* timer ticks spent in user mode   */
diff --git a/arch/s390/include/asm/ccwdev.h b/arch/s390/include/asm/ccwdev.h
index 865ce1cb86d5..3cfe1eb89838 100644
--- a/arch/s390/include/asm/ccwdev.h
+++ b/arch/s390/include/asm/ccwdev.h
@@ -11,6 +11,7 @@
 
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
+#include <asm/chsc.h>
 #include <asm/fcx.h>
 #include <asm/irq.h>
 #include <asm/schid.h>
@@ -236,4 +237,8 @@ extern void ccw_device_get_schid(struct ccw_device *, struct subchannel_id *);
 
 struct channel_path_desc_fmt0 *ccw_device_get_chp_desc(struct ccw_device *, int);
 u8 *ccw_device_get_util_str(struct ccw_device *cdev, int chp_idx);
+int ccw_device_pnso(struct ccw_device *cdev,
+		    struct chsc_pnso_area *pnso_area,
+		    struct chsc_pnso_resume_token resume_token,
+		    int cnc);
 #endif /* _S390_CCWDEV_H_ */
diff --git a/arch/s390/include/asm/chsc.h b/arch/s390/include/asm/chsc.h
new file mode 100644
index 000000000000..36ce2d25a5fc
--- /dev/null
+++ b/arch/s390/include/asm/chsc.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright IBM Corp. 2020
+ *
+ * Author(s): Alexandra Winter <wintera@linux.ibm.com>
+ *
+ * Interface for Channel Subsystem Call
+ */
+#ifndef _ASM_S390_CHSC_H
+#define _ASM_S390_CHSC_H
+
+#include <uapi/asm/chsc.h>
+
+/**
+ * struct chsc_pnso_naid_l2 - network address information descriptor
+ * @nit:  Network interface token
+ * @addr_lnid: network address and logical network id (VLAN ID)
+ */
+struct chsc_pnso_naid_l2 {
+	u64 nit;
+	struct { u8 mac[6]; u16 lnid; } addr_lnid;
+} __packed;
+
+struct chsc_pnso_resume_token {
+	u64 t1;
+	u64 t2;
+} __packed;
+
+struct chsc_pnso_naihdr {
+	struct chsc_pnso_resume_token resume_token;
+	u32:32;
+	u32 instance;
+	u32:24;
+	u8 naids;
+	u32 reserved[3];
+} __packed;
+
+struct chsc_pnso_area {
+	struct chsc_header request;
+	u8:2;
+	u8 m:1;
+	u8:5;
+	u8:2;
+	u8 ssid:2;
+	u8 fmt:4;
+	u16 sch;
+	u8:8;
+	u8 cssid;
+	u16:16;
+	u8 oc;
+	u32:24;
+	struct chsc_pnso_resume_token resume_token;
+	u32 n:1;
+	u32:31;
+	u32 reserved[3];
+	struct chsc_header response;
+	u32:32;
+	struct chsc_pnso_naihdr naihdr;
+	struct chsc_pnso_naid_l2 entries[0];
+} __packed __aligned(PAGE_SIZE);
+
+#endif /* _ASM_S390_CHSC_H */
diff --git a/arch/s390/include/asm/io.h b/arch/s390/include/asm/io.h
index 5a16f500515a..da014e4f8113 100644
--- a/arch/s390/include/asm/io.h
+++ b/arch/s390/include/asm/io.h
@@ -26,7 +26,7 @@ void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr);
 
 #define IO_SPACE_LIMIT 0
 
-void __iomem *ioremap(unsigned long offset, unsigned long size);
+void __iomem *ioremap(phys_addr_t addr, size_t size);
 void iounmap(volatile void __iomem *addr);
 
 static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
diff --git a/arch/s390/include/asm/ipl.h b/arch/s390/include/asm/ipl.h
index b63bd66404b8..7d5cfdda5277 100644
--- a/arch/s390/include/asm/ipl.h
+++ b/arch/s390/include/asm/ipl.h
@@ -21,6 +21,7 @@ struct ipl_parameter_block {
 		struct ipl_pb0_common common;
 		struct ipl_pb0_fcp fcp;
 		struct ipl_pb0_ccw ccw;
+		struct ipl_pb0_nvme nvme;
 		char raw[PAGE_SIZE - sizeof(struct ipl_pl_hdr)];
 	};
 } __packed __aligned(PAGE_SIZE);
@@ -30,6 +31,11 @@ struct ipl_parameter_block {
 #define IPL_BP_FCP_LEN (sizeof(struct ipl_pl_hdr) + \
 			      sizeof(struct ipl_pb0_fcp))
 #define IPL_BP0_FCP_LEN (sizeof(struct ipl_pb0_fcp))
+
+#define IPL_BP_NVME_LEN (sizeof(struct ipl_pl_hdr) + \
+			      sizeof(struct ipl_pb0_nvme))
+#define IPL_BP0_NVME_LEN (sizeof(struct ipl_pb0_nvme))
+
 #define IPL_BP_CCW_LEN (sizeof(struct ipl_pl_hdr) + \
 			      sizeof(struct ipl_pb0_ccw))
 #define IPL_BP0_CCW_LEN (sizeof(struct ipl_pb0_ccw))
@@ -59,6 +65,7 @@ enum ipl_type {
 	IPL_TYPE_FCP		= 4,
 	IPL_TYPE_FCP_DUMP	= 8,
 	IPL_TYPE_NSS		= 16,
+	IPL_TYPE_NVME		= 32,
 };
 
 struct ipl_info
@@ -73,6 +80,10 @@ struct ipl_info
 			u64 wwpn;
 			u64 lun;
 		} fcp;
+		struct {
+			u32 fid;
+			u32 nsid;
+		} nvme;
 		struct {
 			char name[NSS_NAME_SIZE + 1];
 		} nss;
diff --git a/arch/s390/include/asm/nmi.h b/arch/s390/include/asm/nmi.h
index b160da8fa14b..5afee80cff58 100644
--- a/arch/s390/include/asm/nmi.h
+++ b/arch/s390/include/asm/nmi.h
@@ -99,7 +99,7 @@ int nmi_alloc_per_cpu(struct lowcore *lc);
 void nmi_free_per_cpu(struct lowcore *lc);
 
 void s390_handle_mcck(void);
-void s390_do_machine_check(struct pt_regs *regs);
+int s390_do_machine_check(struct pt_regs *regs);
 
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_S390_NMI_H */
diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 7485ee561fec..99b92c3e46b0 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -22,12 +22,17 @@ int pci_domain_nr(struct pci_bus *);
 int pci_proc_domain(struct pci_bus *);
 
 #define ZPCI_BUS_NR			0	/* default bus number */
-#define ZPCI_DEVFN			0	/* default device number */
 
 #define ZPCI_NR_DMA_SPACES		1
 #define ZPCI_NR_DEVICES			CONFIG_PCI_NR_FUNCTIONS
 #define ZPCI_DOMAIN_BITMAP_SIZE		(1 << 16)
 
+#ifdef PCI
+#if (ZPCI_NR_DEVICES > ZPCI_DOMAIN_BITMAP_SIZE)
+# error ZPCI_NR_DEVICES can not be bigger than ZPCI_DOMAIN_BITMAP_SIZE
+#endif
+#endif /* PCI */
+
 /* PCI Function Controls */
 #define ZPCI_FC_FN_ENABLED		0x80
 #define ZPCI_FC_ERROR			0x40
@@ -94,10 +99,26 @@ struct zpci_bar_struct {
 
 struct s390_domain;
 
+#define ZPCI_FUNCTIONS_PER_BUS 256
+struct zpci_bus {
+	struct kref		kref;
+	struct pci_bus		*bus;
+	struct zpci_dev		*function[ZPCI_FUNCTIONS_PER_BUS];
+	struct list_head	resources;
+	struct list_head	bus_next;
+	struct resource		bus_resource;
+	int			pchid;
+	int			domain_nr;
+	bool			multifunction;
+	enum pci_bus_speed	max_bus_speed;
+};
+
 /* Private data per function */
 struct zpci_dev {
-	struct pci_bus	*bus;
+	struct zpci_bus *zbus;
 	struct list_head entry;		/* list of all zpci_devices, needed for hotplug, etc. */
+	struct list_head bus_next;
+	struct kref kref;
 	struct hotplug_slot hotplug_slot;
 
 	enum zpci_state state;
@@ -107,7 +128,12 @@ struct zpci_dev {
 	u16		pchid;		/* physical channel ID */
 	u8		pfgid;		/* function group ID */
 	u8		pft;		/* pci function type */
-	u16		domain;
+	u8		port;
+	u8		rid_available	: 1;
+	u8		has_hp_slot	: 1;
+	u8		is_physfn	: 1;
+	u8		reserved	: 5;
+	unsigned int	devfn;		/* DEVFN part of the RID*/
 
 	struct mutex lock;
 	u8 pfip[CLP_PFIP_NR_SEGMENTS];	/* pci function internal path */
@@ -167,6 +193,7 @@ static inline bool zdev_enabled(struct zpci_dev *zdev)
 
 extern const struct attribute_group *zpci_attr_groups[];
 extern unsigned int s390_pci_force_floating __initdata;
+extern unsigned int s390_pci_no_rid;
 
 /* -----------------------------------------------------------------------------
   Prototypes
@@ -227,7 +254,14 @@ static inline void zpci_exit_slot(struct zpci_dev *zdev) {}
 /* Helpers */
 static inline struct zpci_dev *to_zpci(struct pci_dev *pdev)
 {
-	return pdev->sysdata;
+	struct zpci_bus *zbus = pdev->sysdata;
+
+	return zbus->function[pdev->devfn];
+}
+
+static inline struct zpci_dev *to_zpci_dev(struct device *dev)
+{
+	return to_zpci(to_pci_dev(dev));
 }
 
 struct zpci_dev *get_zdev_by_fid(u32);
diff --git a/arch/s390/include/asm/pci_clp.h b/arch/s390/include/asm/pci_clp.h
index bd2cb4ea7d93..eb51272dd2cc 100644
--- a/arch/s390/include/asm/pci_clp.h
+++ b/arch/s390/include/asm/pci_clp.h
@@ -93,7 +93,10 @@ struct clp_req_query_pci {
 struct clp_rsp_query_pci {
 	struct clp_rsp_hdr hdr;
 	u16 vfn;			/* virtual fn number */
-	u16			:  6;
+	u16			:  3;
+	u16 rid_avail		:  1;
+	u16 is_physfn		:  1;
+	u16 reserved1		:  1;
 	u16 mio_addr_avail	:  1;
 	u16 util_str_avail	:  1;	/* utility string available? */
 	u16 pfgid		:  8;	/* pci function group id */
@@ -102,12 +105,16 @@ struct clp_rsp_query_pci {
 	u16 pchid;
 	__le32 bar[PCI_STD_NUM_BARS];
 	u8 pfip[CLP_PFIP_NR_SEGMENTS];	/* pci function internal path */
-	u32			: 16;
+	u16			: 12;
+	u16 port		:  4;
 	u8 fmb_len;
 	u8 pft;				/* pci function type */
 	u64 sdma;			/* start dma as */
 	u64 edma;			/* end dma as */
-	u32 reserved[11];
+#define ZPCI_RID_MASK_DEVFN 0x00ff
+	u16 rid;			/* BUS/DEVFN PCI address */
+	u16 reserved0;
+	u32 reserved[10];
 	u32 uid;			/* user defined id */
 	u8 util_str[CLP_UTIL_STR_LEN];	/* utility string */
 	u32 reserved2[16];
diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 555d148ccf32..962da04234af 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -14,17 +14,15 @@
 
 #include <linux/bits.h>
 
-#define CIF_MCCK_PENDING	0	/* machine check handling is pending */
-#define CIF_ASCE_PRIMARY	1	/* primary asce needs fixup / uaccess */
-#define CIF_ASCE_SECONDARY	2	/* secondary asce needs fixup / uaccess */
-#define CIF_NOHZ_DELAY		3	/* delay HZ disable for a tick */
-#define CIF_FPU			4	/* restore FPU registers */
-#define CIF_IGNORE_IRQ		5	/* ignore interrupt (for udelay) */
-#define CIF_ENABLED_WAIT	6	/* in enabled wait state */
-#define CIF_MCCK_GUEST		7	/* machine check happening in guest */
-#define CIF_DEDICATED_CPU	8	/* this CPU is dedicated */
-
-#define _CIF_MCCK_PENDING	BIT(CIF_MCCK_PENDING)
+#define CIF_ASCE_PRIMARY	0	/* primary asce needs fixup / uaccess */
+#define CIF_ASCE_SECONDARY	1	/* secondary asce needs fixup / uaccess */
+#define CIF_NOHZ_DELAY		2	/* delay HZ disable for a tick */
+#define CIF_FPU			3	/* restore FPU registers */
+#define CIF_IGNORE_IRQ		4	/* ignore interrupt (for udelay) */
+#define CIF_ENABLED_WAIT	5	/* in enabled wait state */
+#define CIF_MCCK_GUEST		6	/* machine check happening in guest */
+#define CIF_DEDICATED_CPU	7	/* this CPU is dedicated */
+
 #define _CIF_ASCE_PRIMARY	BIT(CIF_ASCE_PRIMARY)
 #define _CIF_ASCE_SECONDARY	BIT(CIF_ASCE_SECONDARY)
 #define _CIF_NOHZ_DELAY		BIT(CIF_NOHZ_DELAY)
diff --git a/arch/s390/include/asm/qdio.h b/arch/s390/include/asm/qdio.h
index 86a3796e9be8..e69dbf438f99 100644
--- a/arch/s390/include/asm/qdio.h
+++ b/arch/s390/include/asm/qdio.h
@@ -365,34 +365,6 @@ struct qdio_initialize {
 	struct qdio_outbuf_state *output_sbal_state_array;
 };
 
-/**
- * enum qdio_brinfo_entry_type - type of address entry for qdio_brinfo_desc()
- * @l3_ipv6_addr: entry contains IPv6 address
- * @l3_ipv4_addr: entry contains IPv4 address
- * @l2_addr_lnid: entry contains MAC address and VLAN ID
- */
-enum qdio_brinfo_entry_type {l3_ipv6_addr, l3_ipv4_addr, l2_addr_lnid};
-
-/**
- * struct qdio_brinfo_entry_XXX - Address entry for qdio_brinfo_desc()
- * @nit:  Network interface token
- * @addr: Address of one of the three types
- *
- * The struct is passed to the callback function by qdio_brinfo_desc()
- */
-struct qdio_brinfo_entry_l3_ipv6 {
-	u64 nit;
-	struct { unsigned char _s6_addr[16]; } addr;
-} __packed;
-struct qdio_brinfo_entry_l3_ipv4 {
-	u64 nit;
-	struct { uint32_t _s_addr; } addr;
-} __packed;
-struct qdio_brinfo_entry_l2 {
-	u64 nit;
-	struct { u8 mac[6]; u16 lnid; } addr_lnid;
-} __packed;
-
 #define QDIO_STATE_INACTIVE		0x00000002 /* after qdio_cleanup */
 #define QDIO_STATE_ESTABLISHED		0x00000004 /* after qdio_establish */
 #define QDIO_STATE_ACTIVE		0x00000008 /* after qdio_activate */
@@ -423,10 +395,5 @@ extern int qdio_inspect_queue(struct ccw_device *cdev, unsigned int nr,
 extern int qdio_shutdown(struct ccw_device *, int);
 extern int qdio_free(struct ccw_device *);
 extern int qdio_get_ssqd_desc(struct ccw_device *, struct qdio_ssqd_desc *);
-extern int qdio_pnso_brinfo(struct subchannel_id schid,
-		int cnc, u16 *response,
-		void (*cb)(void *priv, enum qdio_brinfo_entry_type type,
-				void *entry),
-		void *priv);
 
 #endif /* __QDIO_H__ */
diff --git a/arch/s390/include/asm/smp.h b/arch/s390/include/asm/smp.h
index 231a51e870fe..7326f110d48c 100644
--- a/arch/s390/include/asm/smp.h
+++ b/arch/s390/include/asm/smp.h
@@ -58,5 +58,6 @@ extern int smp_rescan_cpus(void);
 extern void __noreturn cpu_die(void);
 extern void __cpu_die(unsigned int cpu);
 extern int __cpu_disable(void);
+extern void schedule_mcck_handler(void);
 
 #endif /* __ASM_SMP_H */
diff --git a/arch/s390/include/uapi/asm/ipl.h b/arch/s390/include/uapi/asm/ipl.h
index 451ba7d08905..d1ecd5d722a0 100644
--- a/arch/s390/include/uapi/asm/ipl.h
+++ b/arch/s390/include/uapi/asm/ipl.h
@@ -27,6 +27,7 @@ enum ipl_pbt {
 	IPL_PBT_FCP = 0,
 	IPL_PBT_SCP_DATA = 1,
 	IPL_PBT_CCW = 2,
+	IPL_PBT_NVME = 4,
 };
 
 /* IPL Parameter Block 0 with common fields */
@@ -67,6 +68,30 @@ struct ipl_pb0_fcp {
 #define IPL_PB0_FCP_OPT_IPL	0x10
 #define IPL_PB0_FCP_OPT_DUMP	0x20
 
+/* IPL Parameter Block 0 for NVMe */
+struct ipl_pb0_nvme {
+	__u32 len;
+	__u8  pbt;
+	__u8  reserved1[3];
+	__u8  loadparm[8];
+	__u8  reserved2[304];
+	__u8  opt;
+	__u8  reserved3[3];
+	__u32 fid;
+	__u8 reserved4[12];
+	__u32 nsid;
+	__u8 reserved5[4];
+	__u32 bootprog;
+	__u8 reserved6[12];
+	__u64 br_lba;
+	__u32 scp_data_len;
+	__u8  reserved7[260];
+	__u8  scp_data[];
+} __packed;
+
+#define IPL_PB0_NVME_OPT_IPL	0x10
+#define IPL_PB0_NVME_OPT_DUMP	0x20
+
 /* IPL Parameter Block 0 for CCW */
 struct ipl_pb0_ccw {
 	__u32 len;
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index 75f26d775027..a8f136943deb 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -33,11 +33,6 @@ CFLAGS_stacktrace.o	+= -fno-optimize-sibling-calls
 CFLAGS_dumpstack.o	+= -fno-optimize-sibling-calls
 CFLAGS_unwind_bc.o	+= -fno-optimize-sibling-calls
 
-#
-# Pass UTS_MACHINE for user_regset definition
-#
-CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
-
 obj-y	:= traps.o time.o process.o base.o early.o setup.o idle.o vtime.o
 obj-y	+= processor.o sys_s390.o ptrace.o signal.o cpcmd.o ebcdic.o nmi.o
 obj-y	+= debug.o irq.o ipl.o dis.o diag.o vdso.o
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 3ae64914bd14..50ff6dd0f995 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -55,14 +55,11 @@ _TIF_WORK	= (_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_NEED_RESCHED | \
 		   _TIF_UPROBE | _TIF_GUARDED_STORAGE | _TIF_PATCH_PENDING)
 _TIF_TRACE	= (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | _TIF_SECCOMP | \
 		   _TIF_SYSCALL_TRACEPOINT)
-_CIF_WORK	= (_CIF_MCCK_PENDING | _CIF_ASCE_PRIMARY | \
-		   _CIF_ASCE_SECONDARY | _CIF_FPU)
+_CIF_WORK	= (_CIF_ASCE_PRIMARY | _CIF_ASCE_SECONDARY | _CIF_FPU)
 _PIF_WORK	= (_PIF_PER_TRAP | _PIF_SYSCALL_RESTART)
 
 _LPP_OFFSET	= __LC_LPP
 
-#define BASED(name) name-cleanup_critical(%r13)
-
 	.macro	TRACE_IRQS_ON
 #ifdef CONFIG_TRACE_IRQFLAGS
 	basr	%r2,%r0
@@ -116,17 +113,39 @@ _LPP_OFFSET	= __LC_LPP
 	.macro	SWITCH_ASYNC savearea,timer
 	tmhh	%r8,0x0001		# interrupting from user ?
 	jnz	2f
+#if IS_ENABLED(CONFIG_KVM)
 	lgr	%r14,%r9
-	cghi	%r14,__LC_RETURN_LPSWE
-	je	0f
-	slg	%r14,BASED(.Lcritical_start)
-	clg	%r14,BASED(.Lcritical_length)
-	jhe	1f
-0:
+	larl	%r13,.Lsie_gmap
+	slgr	%r14,%r13
+	lghi	%r13,.Lsie_done - .Lsie_gmap
+	clgr	%r14,%r13
+	jhe	0f
 	lghi	%r11,\savearea		# inside critical section, do cleanup
-	brasl	%r14,cleanup_critical
-	tmhh	%r8,0x0001		# retest problem state after cleanup
-	jnz	2f
+	brasl	%r14,.Lcleanup_sie
+#endif
+0:	larl	%r13,.Lpsw_idle_exit
+	cgr	%r13,%r9
+	jne	1f
+
+	mvc	__CLOCK_IDLE_EXIT(8,%r2), __LC_INT_CLOCK
+	mvc	__TIMER_IDLE_EXIT(8,%r2), __LC_ASYNC_ENTER_TIMER
+	# account system time going idle
+	ni	__LC_CPU_FLAGS+7,255-_CIF_ENABLED_WAIT
+
+	lg	%r13,__LC_STEAL_TIMER
+	alg	%r13,__CLOCK_IDLE_ENTER(%r2)
+	slg	%r13,__LC_LAST_UPDATE_CLOCK
+	stg	%r13,__LC_STEAL_TIMER
+
+	mvc	__LC_LAST_UPDATE_CLOCK(8),__CLOCK_IDLE_EXIT(%r2)
+
+	lg	%r13,__LC_SYSTEM_TIMER
+	alg	%r13,__LC_LAST_UPDATE_TIMER
+	slg	%r13,__TIMER_IDLE_ENTER(%r2)
+	stg	%r13,__LC_SYSTEM_TIMER
+	mvc	__LC_LAST_UPDATE_TIMER(8),__TIMER_IDLE_EXIT(%r2)
+
+	nihh	%r8,0xfcfd		# clear wait state and irq bits
 1:	lg	%r14,__LC_ASYNC_STACK	# are we already on the target stack?
 	slgr	%r14,%r15
 	srag	%r14,%r14,STACK_SHIFT
@@ -152,12 +171,30 @@ _LPP_OFFSET	= __LC_LPP
 	mvc	__LC_LAST_UPDATE_TIMER(8),\enter_timer
 	.endm
 
-	.macro REENABLE_IRQS
+	.macro RESTORE_SM_CLEAR_PER
 	stg	%r8,__LC_RETURN_PSW
 	ni	__LC_RETURN_PSW,0xbf
 	ssm	__LC_RETURN_PSW
 	.endm
 
+	.macro ENABLE_INTS
+	stosm	__SF_EMPTY(%r15),3
+	.endm
+
+	.macro ENABLE_INTS_TRACE
+	TRACE_IRQS_ON
+	ENABLE_INTS
+	.endm
+
+	.macro DISABLE_INTS
+	stnsm	__SF_EMPTY(%r15),0xfc
+	.endm
+
+	.macro DISABLE_INTS_TRACE
+	DISABLE_INTS
+	TRACE_IRQS_OFF
+	.endm
+
 	.macro STCK savearea
 #ifdef CONFIG_HAVE_MARCH_Z9_109_FEATURES
 	.insn	s,0xb27c0000,\savearea		# store clock fast
@@ -254,8 +291,6 @@ ENTRY(__switch_to)
 	BR_EX	%r14
 ENDPROC(__switch_to)
 
-.L__critical_start:
-
 #if IS_ENABLED(CONFIG_KVM)
 /*
  * sie64a calling convention:
@@ -288,7 +323,6 @@ ENTRY(sie64a)
 	BPEXIT	__SF_SIE_FLAGS(%r15),(_TIF_ISOLATE_BP|_TIF_ISOLATE_BP_GUEST)
 .Lsie_entry:
 	sie	0(%r14)
-.Lsie_exit:
 	BPOFF
 	BPENTER	__SF_SIE_FLAGS(%r15),(_TIF_ISOLATE_BP|_TIF_ISOLATE_BP_GUEST)
 .Lsie_skip:
@@ -341,7 +375,6 @@ EXPORT_SYMBOL(sie_exit)
 
 ENTRY(system_call)
 	stpt	__LC_SYNC_ENTER_TIMER
-.Lsysc_stmg:
 	stmg	%r8,%r15,__LC_SAVE_AREA_SYNC
 	BPOFF
 	lg	%r12,__LC_CURRENT
@@ -350,7 +383,6 @@ ENTRY(system_call)
 .Lsysc_per:
 	lg	%r15,__LC_KERNEL_STACK
 	la	%r11,STACK_FRAME_OVERHEAD(%r15)	# pointer to pt_regs
-.Lsysc_vtime:
 	UPDATE_VTIME %r8,%r9,__LC_SYNC_ENTER_TIMER
 	BPENTER __TI_flags(%r12),_TIF_ISOLATE_BP
 	stmg	%r0,%r7,__PT_R0(%r11)
@@ -358,6 +390,7 @@ ENTRY(system_call)
 	mvc	__PT_PSW(16,%r11),__LC_SVC_OLD_PSW
 	mvc	__PT_INT_CODE(4,%r11),__LC_SVC_ILC
 	stg	%r14,__PT_FLAGS(%r11)
+	ENABLE_INTS
 .Lsysc_do_svc:
 	# clear user controlled register to prevent speculative use
 	xgr	%r0,%r0
@@ -393,26 +426,26 @@ ENTRY(system_call)
 	jnz	.Lsysc_work
 	TSTMSK	__TI_flags(%r12),_TIF_WORK
 	jnz	.Lsysc_work			# check for work
-	TSTMSK	__LC_CPU_FLAGS,_CIF_WORK
+	TSTMSK	__LC_CPU_FLAGS,(_CIF_WORK-_CIF_FPU)
 	jnz	.Lsysc_work
 	BPEXIT	__TI_flags(%r12),_TIF_ISOLATE_BP
 .Lsysc_restore:
+	DISABLE_INTS
+	TSTMSK	__LC_CPU_FLAGS, _CIF_FPU
+	jz	.Lsysc_skip_fpu
+	brasl	%r14,load_fpu_regs
+.Lsysc_skip_fpu:
 	lg	%r14,__LC_VDSO_PER_CPU
-	lmg	%r0,%r10,__PT_R0(%r11)
 	mvc	__LC_RETURN_PSW(16),__PT_PSW(%r11)
-.Lsysc_exit_timer:
 	stpt	__LC_EXIT_TIMER
 	mvc	__VDSO_ECTG_BASE(16,%r14),__LC_EXIT_TIMER
-	lmg	%r11,%r15,__PT_R11(%r11)
-	b	__LC_RETURN_LPSWE(%r0)
-.Lsysc_done:
+	lmg	%r0,%r15,__PT_R0(%r11)
+	b	__LC_RETURN_LPSWE
 
 #
 # One of the work bits is on. Find out which one.
 #
 .Lsysc_work:
-	TSTMSK	__LC_CPU_FLAGS,_CIF_MCCK_PENDING
-	jo	.Lsysc_mcck_pending
 	TSTMSK	__TI_flags(%r12),_TIF_NEED_RESCHED
 	jo	.Lsysc_reschedule
 	TSTMSK	__PT_FLAGS(%r11),_PIF_SYSCALL_RESTART
@@ -436,11 +469,9 @@ ENTRY(system_call)
 	jo	.Lsysc_sigpending
 	TSTMSK	__TI_flags(%r12),_TIF_NOTIFY_RESUME
 	jo	.Lsysc_notify_resume
-	TSTMSK	__LC_CPU_FLAGS,_CIF_FPU
-	jo	.Lsysc_vxrs
 	TSTMSK	__LC_CPU_FLAGS,(_CIF_ASCE_PRIMARY|_CIF_ASCE_SECONDARY)
 	jnz	.Lsysc_asce
-	j	.Lsysc_return		# beware of critical section cleanup
+	j	.Lsysc_return
 
 #
 # _TIF_NEED_RESCHED is set, call schedule
@@ -449,13 +480,6 @@ ENTRY(system_call)
 	larl	%r14,.Lsysc_return
 	jg	schedule
 
-#
-# _CIF_MCCK_PENDING is set, call handler
-#
-.Lsysc_mcck_pending:
-	larl	%r14,.Lsysc_return
-	jg	s390_handle_mcck	# TIF bit will be cleared by handler
-
 #
 # _CIF_ASCE_PRIMARY and/or _CIF_ASCE_SECONDARY set, load user space asce
 #
@@ -475,12 +499,6 @@ ENTRY(system_call)
 	larl	%r14,.Lsysc_return
 	jg	set_fs_fixup
 
-#
-# CIF_FPU is set, restore floating-point controls and floating-point registers.
-#
-.Lsysc_vxrs:
-	larl	%r14,.Lsysc_return
-	jg	load_fpu_regs
 
 #
 # _TIF_SIGPENDING is set, call do_signal
@@ -564,7 +582,6 @@ ENTRY(system_call)
 	jnh	.Lsysc_tracenogo
 	sllg	%r8,%r2,3
 	lg	%r9,0(%r8,%r10)
-.Lsysc_tracego:
 	lmg	%r3,%r7,__PT_R3(%r11)
 	stg	%r7,STACK_FRAME_OVERHEAD(%r15)
 	lg	%r2,__PT_ORIG_GPR2(%r11)
@@ -585,8 +602,6 @@ ENTRY(ret_from_fork)
 	la	%r11,STACK_FRAME_OVERHEAD(%r15)
 	lg	%r12,__LC_CURRENT
 	brasl	%r14,schedule_tail
-	TRACE_IRQS_ON
-	ssm	__LC_SVC_NEW_PSW	# reenable interrupts
 	tm	__PT_PSW+1(%r11),0x01	# forking a kernel thread ?
 	jne	.Lsysc_tracenogo
 	# it's a kernel thread
@@ -620,15 +635,16 @@ ENTRY(pgm_check_handler)
 	lghi	%r10,1
 0:	lg	%r12,__LC_CURRENT
 	lghi	%r11,0
-	larl	%r13,cleanup_critical
 	lmg	%r8,%r9,__LC_PGM_OLD_PSW
 	tmhh	%r8,0x0001		# test problem state bit
 	jnz	3f			# -> fault in user space
 #if IS_ENABLED(CONFIG_KVM)
 	# cleanup critical section for program checks in sie64a
 	lgr	%r14,%r9
-	slg	%r14,BASED(.Lsie_critical_start)
-	clg	%r14,BASED(.Lsie_critical_length)
+	larl	%r13,.Lsie_gmap
+	slgr	%r14,%r13
+	lghi	%r13,.Lsie_done - .Lsie_gmap
+	clgr	%r14,%r13
 	jhe	1f
 	lg	%r14,__SF_SIE_CONTROL(%r15)	# get control block pointer
 	ni	__SIE_PROG0C+3(%r14),0xfe	# no longer in SIE
@@ -680,7 +696,7 @@ ENTRY(pgm_check_handler)
 	mvc	__THREAD_per_address(8,%r14),__LC_PER_ADDRESS
 	mvc	__THREAD_per_cause(2,%r14),__LC_PER_CODE
 	mvc	__THREAD_per_paid(1,%r14),__LC_PER_ACCESS_ID
-6:	REENABLE_IRQS
+6:	RESTORE_SM_CLEAR_PER
 	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
 	larl	%r1,pgm_check_table
 	llgh	%r10,__PT_INT_CODE+2(%r11)
@@ -702,7 +718,7 @@ ENTRY(pgm_check_handler)
 # PER event in supervisor state, must be kprobes
 #
 .Lpgm_kprobe:
-	REENABLE_IRQS
+	RESTORE_SM_CLEAR_PER
 	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
 	lgr	%r2,%r11		# pass pointer to pt_regs
 	brasl	%r14,do_per_trap
@@ -713,11 +729,10 @@ ENTRY(pgm_check_handler)
 #
 .Lpgm_svcper:
 	mvc	__LC_RETURN_PSW(8),__LC_SVC_NEW_PSW
-	lghi	%r13,__TASK_thread
 	larl	%r14,.Lsysc_per
 	stg	%r14,__LC_RETURN_PSW+8
 	lghi	%r14,_PIF_SYSCALL | _PIF_PER_TRAP
-	lpswe	__LC_RETURN_PSW		# branch to .Lsysc_per and enable irqs
+	lpswe	__LC_RETURN_PSW		# branch to .Lsysc_per
 ENDPROC(pgm_check_handler)
 
 /*
@@ -729,7 +744,6 @@ ENTRY(io_int_handler)
 	BPOFF
 	stmg	%r8,%r15,__LC_SAVE_AREA_ASYNC
 	lg	%r12,__LC_CURRENT
-	larl	%r13,cleanup_critical
 	lmg	%r8,%r9,__LC_IO_OLD_PSW
 	SWITCH_ASYNC __LC_SAVE_AREA_ASYNC,__LC_ASYNC_ENTER_TIMER
 	stmg	%r0,%r7,__PT_R0(%r11)
@@ -749,7 +763,12 @@ ENTRY(io_int_handler)
 	xc	__PT_FLAGS(8,%r11),__PT_FLAGS(%r11)
 	TSTMSK	__LC_CPU_FLAGS,_CIF_IGNORE_IRQ
 	jo	.Lio_restore
+#if IS_ENABLED(CONFIG_TRACE_IRQFLAGS)
+	tmhh	%r8,0x300
+	jz	1f
 	TRACE_IRQS_OFF
+1:
+#endif
 	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
 .Lio_loop:
 	lgr	%r2,%r11		# pass pointer to pt_regs
@@ -767,25 +786,27 @@ ENTRY(io_int_handler)
 	j	.Lio_loop
 .Lio_return:
 	LOCKDEP_SYS_EXIT
-	TRACE_IRQS_ON
-.Lio_tif:
 	TSTMSK	__TI_flags(%r12),_TIF_WORK
 	jnz	.Lio_work		# there is work to do (signals etc.)
 	TSTMSK	__LC_CPU_FLAGS,_CIF_WORK
 	jnz	.Lio_work
 .Lio_restore:
+#if IS_ENABLED(CONFIG_TRACE_IRQFLAGS)
+	tm	__PT_PSW(%r11),3
+	jno	0f
+	TRACE_IRQS_ON
+0:
+#endif
 	lg	%r14,__LC_VDSO_PER_CPU
-	lmg	%r0,%r10,__PT_R0(%r11)
 	mvc	__LC_RETURN_PSW(16),__PT_PSW(%r11)
 	tm	__PT_PSW+1(%r11),0x01	# returning to user ?
 	jno	.Lio_exit_kernel
 	BPEXIT	__TI_flags(%r12),_TIF_ISOLATE_BP
-.Lio_exit_timer:
 	stpt	__LC_EXIT_TIMER
 	mvc	__VDSO_ECTG_BASE(16,%r14),__LC_EXIT_TIMER
 .Lio_exit_kernel:
-	lmg	%r11,%r15,__PT_R11(%r11)
-	b	__LC_RETURN_LPSWE(%r0)
+	lmg	%r0,%r15,__PT_R0(%r11)
+	b	__LC_RETURN_LPSWE
 .Lio_done:
 
 #
@@ -813,9 +834,6 @@ ENTRY(io_int_handler)
 	xc	__SF_BACKCHAIN(8,%r1),__SF_BACKCHAIN(%r1)
 	la	%r11,STACK_FRAME_OVERHEAD(%r1)
 	lgr	%r15,%r1
-	# TRACE_IRQS_ON already done at .Lio_return, call
-	# TRACE_IRQS_OFF to keep things symmetrical
-	TRACE_IRQS_OFF
 	brasl	%r14,preempt_schedule_irq
 	j	.Lio_return
 #else
@@ -835,9 +853,6 @@ ENTRY(io_int_handler)
 #
 # One of the work bits is on. Find out which one.
 #
-.Lio_work_tif:
-	TSTMSK	__LC_CPU_FLAGS,_CIF_MCCK_PENDING
-	jo	.Lio_mcck_pending
 	TSTMSK	__TI_flags(%r12),_TIF_NEED_RESCHED
 	jo	.Lio_reschedule
 #ifdef CONFIG_LIVEPATCH
@@ -854,15 +869,6 @@ ENTRY(io_int_handler)
 	jo	.Lio_vxrs
 	TSTMSK	__LC_CPU_FLAGS,(_CIF_ASCE_PRIMARY|_CIF_ASCE_SECONDARY)
 	jnz	.Lio_asce
-	j	.Lio_return		# beware of critical section cleanup
-
-#
-# _CIF_MCCK_PENDING is set, call handler
-#
-.Lio_mcck_pending:
-	# TRACE_IRQS_ON already done at .Lio_return
-	brasl	%r14,s390_handle_mcck	# TIF bit will be cleared by handler
-	TRACE_IRQS_OFF
 	j	.Lio_return
 
 #
@@ -895,23 +901,19 @@ ENTRY(io_int_handler)
 # _TIF_GUARDED_STORAGE is set, call guarded_storage_load
 #
 .Lio_guarded_storage:
-	# TRACE_IRQS_ON already done at .Lio_return
-	ssm	__LC_SVC_NEW_PSW	# reenable interrupts
+	ENABLE_INTS_TRACE
 	lgr	%r2,%r11		# pass pointer to pt_regs
 	brasl	%r14,gs_load_bc_cb
-	ssm	__LC_PGM_NEW_PSW	# disable I/O and ext. interrupts
-	TRACE_IRQS_OFF
+	DISABLE_INTS_TRACE
 	j	.Lio_return
 
 #
 # _TIF_NEED_RESCHED is set, call schedule
 #
 .Lio_reschedule:
-	# TRACE_IRQS_ON already done at .Lio_return
-	ssm	__LC_SVC_NEW_PSW	# reenable interrupts
+	ENABLE_INTS_TRACE
 	brasl	%r14,schedule		# call scheduler
-	ssm	__LC_PGM_NEW_PSW	# disable I/O and ext. interrupts
-	TRACE_IRQS_OFF
+	DISABLE_INTS_TRACE
 	j	.Lio_return
 
 #
@@ -928,24 +930,20 @@ ENTRY(io_int_handler)
 # _TIF_SIGPENDING or is set, call do_signal
 #
 .Lio_sigpending:
-	# TRACE_IRQS_ON already done at .Lio_return
-	ssm	__LC_SVC_NEW_PSW	# reenable interrupts
+	ENABLE_INTS_TRACE
 	lgr	%r2,%r11		# pass pointer to pt_regs
 	brasl	%r14,do_signal
-	ssm	__LC_PGM_NEW_PSW	# disable I/O and ext. interrupts
-	TRACE_IRQS_OFF
+	DISABLE_INTS_TRACE
 	j	.Lio_return
 
 #
 # _TIF_NOTIFY_RESUME or is set, call do_notify_resume
 #
 .Lio_notify_resume:
-	# TRACE_IRQS_ON already done at .Lio_return
-	ssm	__LC_SVC_NEW_PSW	# reenable interrupts
+	ENABLE_INTS_TRACE
 	lgr	%r2,%r11		# pass pointer to pt_regs
 	brasl	%r14,do_notify_resume
-	ssm	__LC_PGM_NEW_PSW	# disable I/O and ext. interrupts
-	TRACE_IRQS_OFF
+	DISABLE_INTS_TRACE
 	j	.Lio_return
 ENDPROC(io_int_handler)
 
@@ -958,7 +956,6 @@ ENTRY(ext_int_handler)
 	BPOFF
 	stmg	%r8,%r15,__LC_SAVE_AREA_ASYNC
 	lg	%r12,__LC_CURRENT
-	larl	%r13,cleanup_critical
 	lmg	%r8,%r9,__LC_EXT_OLD_PSW
 	SWITCH_ASYNC __LC_SAVE_AREA_ASYNC,__LC_ASYNC_ENTER_TIMER
 	stmg	%r0,%r7,__PT_R0(%r11)
@@ -981,7 +978,12 @@ ENTRY(ext_int_handler)
 	xc	__PT_FLAGS(8,%r11),__PT_FLAGS(%r11)
 	TSTMSK	__LC_CPU_FLAGS,_CIF_IGNORE_IRQ
 	jo	.Lio_restore
+#if IS_ENABLED(CONFIG_TRACE_IRQFLAGS)
+	tmhh	%r8,0x300
+	jz	1f
 	TRACE_IRQS_OFF
+1:
+#endif
 	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
 	lgr	%r2,%r11		# pass pointer to pt_regs
 	lghi	%r3,EXT_INTERRUPT
@@ -990,11 +992,11 @@ ENTRY(ext_int_handler)
 ENDPROC(ext_int_handler)
 
 /*
- * Load idle PSW. The second "half" of this function is in .Lcleanup_idle.
+ * Load idle PSW.
  */
 ENTRY(psw_idle)
 	stg	%r3,__SF_EMPTY(%r15)
-	larl	%r1,.Lpsw_idle_lpsw+4
+	larl	%r1,.Lpsw_idle_exit
 	stg	%r1,__SF_EMPTY+8(%r15)
 	larl	%r1,smp_cpu_mtid
 	llgf	%r1,0(%r1)
@@ -1006,10 +1008,9 @@ ENTRY(psw_idle)
 	BPON
 	STCK	__CLOCK_IDLE_ENTER(%r2)
 	stpt	__TIMER_IDLE_ENTER(%r2)
-.Lpsw_idle_lpsw:
 	lpswe	__SF_EMPTY(%r15)
+.Lpsw_idle_exit:
 	BR_EX	%r14
-.Lpsw_idle_end:
 ENDPROC(psw_idle)
 
 /*
@@ -1020,6 +1021,7 @@ ENDPROC(psw_idle)
  * of the register contents at return from io or a system call.
  */
 ENTRY(save_fpu_regs)
+	stnsm	__SF_EMPTY(%r15),0xfc
 	lg	%r2,__LC_CURRENT
 	aghi	%r2,__TASK_thread
 	TSTMSK	__LC_CPU_FLAGS,_CIF_FPU
@@ -1051,6 +1053,7 @@ ENTRY(save_fpu_regs)
 .Lsave_fpu_regs_done:
 	oi	__LC_CPU_FLAGS+7,_CIF_FPU
 .Lsave_fpu_regs_exit:
+	ssm	__SF_EMPTY(%r15)
 	BR_EX	%r14
 .Lsave_fpu_regs_end:
 ENDPROC(save_fpu_regs)
@@ -1102,8 +1105,6 @@ load_fpu_regs:
 .Lload_fpu_regs_end:
 ENDPROC(load_fpu_regs)
 
-.L__critical_end:
-
 /*
  * Machine check handler routines
  */
@@ -1116,7 +1117,6 @@ ENTRY(mcck_int_handler)
 	lam	%a0,%a15,__LC_AREGS_SAVE_AREA-4095(%r1) # validate acrs
 	lmg	%r0,%r15,__LC_GPREGS_SAVE_AREA-4095(%r1)# validate gprs
 	lg	%r12,__LC_CURRENT
-	larl	%r13,cleanup_critical
 	lmg	%r8,%r9,__LC_MCK_OLD_PSW
 	TSTMSK	__LC_MCCK_CODE,MCCK_CODE_SYSTEM_DAMAGE
 	jo	.Lmcck_panic		# yes -> rest of mcck code invalid
@@ -1202,15 +1202,13 @@ ENTRY(mcck_int_handler)
 	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
 	lgr	%r2,%r11		# pass pointer to pt_regs
 	brasl	%r14,s390_do_machine_check
-	tm	__PT_PSW+1(%r11),0x01	# returning to user ?
-	jno	.Lmcck_return
+	cghi	%r2,0
+	je	.Lmcck_return
 	lg	%r1,__LC_KERNEL_STACK	# switch to kernel stack
 	mvc	STACK_FRAME_OVERHEAD(__PT_SIZE,%r1),0(%r11)
 	xc	__SF_BACKCHAIN(8,%r1),__SF_BACKCHAIN(%r1)
 	la	%r11,STACK_FRAME_OVERHEAD(%r1)
 	lgr	%r15,%r1
-	TSTMSK	__LC_CPU_FLAGS,_CIF_MCCK_PENDING
-	jno	.Lmcck_return
 	TRACE_IRQS_OFF
 	brasl	%r14,s390_handle_mcck
 	TRACE_IRQS_ON
@@ -1280,265 +1278,23 @@ ENTRY(stack_overflow)
 ENDPROC(stack_overflow)
 #endif
 
-ENTRY(cleanup_critical)
-	cghi	%r9,__LC_RETURN_LPSWE
-	je	.Lcleanup_lpswe
-#if IS_ENABLED(CONFIG_KVM)
-	clg	%r9,BASED(.Lcleanup_table_sie)	# .Lsie_gmap
-	jl	0f
-	clg	%r9,BASED(.Lcleanup_table_sie+8)# .Lsie_done
-	jl	.Lcleanup_sie
-#endif
-	clg	%r9,BASED(.Lcleanup_table)	# system_call
-	jl	0f
-	clg	%r9,BASED(.Lcleanup_table+8)	# .Lsysc_do_svc
-	jl	.Lcleanup_system_call
-	clg	%r9,BASED(.Lcleanup_table+16)	# .Lsysc_tif
-	jl	0f
-	clg	%r9,BASED(.Lcleanup_table+24)	# .Lsysc_restore
-	jl	.Lcleanup_sysc_tif
-	clg	%r9,BASED(.Lcleanup_table+32)	# .Lsysc_done
-	jl	.Lcleanup_sysc_restore
-	clg	%r9,BASED(.Lcleanup_table+40)	# .Lio_tif
-	jl	0f
-	clg	%r9,BASED(.Lcleanup_table+48)	# .Lio_restore
-	jl	.Lcleanup_io_tif
-	clg	%r9,BASED(.Lcleanup_table+56)	# .Lio_done
-	jl	.Lcleanup_io_restore
-	clg	%r9,BASED(.Lcleanup_table+64)	# psw_idle
-	jl	0f
-	clg	%r9,BASED(.Lcleanup_table+72)	# .Lpsw_idle_end
-	jl	.Lcleanup_idle
-	clg	%r9,BASED(.Lcleanup_table+80)	# save_fpu_regs
-	jl	0f
-	clg	%r9,BASED(.Lcleanup_table+88)	# .Lsave_fpu_regs_end
-	jl	.Lcleanup_save_fpu_regs
-	clg	%r9,BASED(.Lcleanup_table+96)	# load_fpu_regs
-	jl	0f
-	clg	%r9,BASED(.Lcleanup_table+104)	# .Lload_fpu_regs_end
-	jl	.Lcleanup_load_fpu_regs
-0:	BR_EX	%r14,%r11
-ENDPROC(cleanup_critical)
-
-	.align	8
-.Lcleanup_table:
-	.quad	system_call
-	.quad	.Lsysc_do_svc
-	.quad	.Lsysc_tif
-	.quad	.Lsysc_restore
-	.quad	.Lsysc_done
-	.quad	.Lio_tif
-	.quad	.Lio_restore
-	.quad	.Lio_done
-	.quad	psw_idle
-	.quad	.Lpsw_idle_end
-	.quad	save_fpu_regs
-	.quad	.Lsave_fpu_regs_end
-	.quad	load_fpu_regs
-	.quad	.Lload_fpu_regs_end
-
 #if IS_ENABLED(CONFIG_KVM)
-.Lcleanup_table_sie:
-	.quad	.Lsie_gmap
-	.quad	.Lsie_done
-
 .Lcleanup_sie:
-	cghi    %r11,__LC_SAVE_AREA_ASYNC 	#Is this in normal interrupt?
-	je      1f
-	slg     %r9,BASED(.Lsie_crit_mcck_start)
-	clg     %r9,BASED(.Lsie_crit_mcck_length)
-	jh      1f
-	oi      __LC_CPU_FLAGS+7, _CIF_MCCK_GUEST
-1:	BPENTER __SF_SIE_FLAGS(%r15),(_TIF_ISOLATE_BP|_TIF_ISOLATE_BP_GUEST)
+	cghi	%r11,__LC_SAVE_AREA_ASYNC	#Is this in normal interrupt?
+	je	1f
+	larl	%r13,.Lsie_entry
+	slgr	%r9,%r13
+	larl	%r13,.Lsie_skip
+	clgr	%r9,%r13
+	jh	1f
+	oi	__LC_CPU_FLAGS+7, _CIF_MCCK_GUEST
+1:	BPENTER	__SF_SIE_FLAGS(%r15),(_TIF_ISOLATE_BP|_TIF_ISOLATE_BP_GUEST)
 	lg	%r9,__SF_SIE_CONTROL(%r15)	# get control block pointer
 	ni	__SIE_PROG0C+3(%r9),0xfe	# no longer in SIE
 	lctlg	%c1,%c1,__LC_USER_ASCE		# load primary asce
 	larl	%r9,sie_exit			# skip forward to sie_exit
 	BR_EX	%r14,%r11
-#endif
 
-.Lcleanup_system_call:
-	# check if stpt has been executed
-	clg	%r9,BASED(.Lcleanup_system_call_insn)
-	jh	0f
-	mvc	__LC_SYNC_ENTER_TIMER(8),__LC_ASYNC_ENTER_TIMER
-	cghi	%r11,__LC_SAVE_AREA_ASYNC
-	je	0f
-	mvc	__LC_SYNC_ENTER_TIMER(8),__LC_MCCK_ENTER_TIMER
-0:	# check if stmg has been executed
-	clg	%r9,BASED(.Lcleanup_system_call_insn+8)
-	jh	0f
-	mvc	__LC_SAVE_AREA_SYNC(64),0(%r11)
-0:	# check if base register setup + TIF bit load has been done
-	clg	%r9,BASED(.Lcleanup_system_call_insn+16)
-	jhe	0f
-	# set up saved register r12 task struct pointer
-	stg	%r12,32(%r11)
-	# set up saved register r13 __TASK_thread offset
-	mvc	40(8,%r11),BASED(.Lcleanup_system_call_const)
-0:	# check if the user time update has been done
-	clg	%r9,BASED(.Lcleanup_system_call_insn+24)
-	jh	0f
-	lg	%r15,__LC_EXIT_TIMER
-	slg	%r15,__LC_SYNC_ENTER_TIMER
-	alg	%r15,__LC_USER_TIMER
-	stg	%r15,__LC_USER_TIMER
-0:	# check if the system time update has been done
-	clg	%r9,BASED(.Lcleanup_system_call_insn+32)
-	jh	0f
-	lg	%r15,__LC_LAST_UPDATE_TIMER
-	slg	%r15,__LC_EXIT_TIMER
-	alg	%r15,__LC_SYSTEM_TIMER
-	stg	%r15,__LC_SYSTEM_TIMER
-0:	# update accounting time stamp
-	mvc	__LC_LAST_UPDATE_TIMER(8),__LC_SYNC_ENTER_TIMER
-	BPENTER __TI_flags(%r12),_TIF_ISOLATE_BP
-	# set up saved register r11
-	lg	%r15,__LC_KERNEL_STACK
-	la	%r9,STACK_FRAME_OVERHEAD(%r15)
-	stg	%r9,24(%r11)		# r11 pt_regs pointer
-	# fill pt_regs
-	mvc	__PT_R8(64,%r9),__LC_SAVE_AREA_SYNC
-	stmg	%r0,%r7,__PT_R0(%r9)
-	mvc	__PT_PSW(16,%r9),__LC_SVC_OLD_PSW
-	mvc	__PT_INT_CODE(4,%r9),__LC_SVC_ILC
-	xc	__PT_FLAGS(8,%r9),__PT_FLAGS(%r9)
-	mvi	__PT_FLAGS+7(%r9),_PIF_SYSCALL
-	# setup saved register r15
-	stg	%r15,56(%r11)		# r15 stack pointer
-	# set new psw address and exit
-	larl	%r9,.Lsysc_do_svc
-	BR_EX	%r14,%r11
-.Lcleanup_system_call_insn:
-	.quad	system_call
-	.quad	.Lsysc_stmg
-	.quad	.Lsysc_per
-	.quad	.Lsysc_vtime+36
-	.quad	.Lsysc_vtime+42
-.Lcleanup_system_call_const:
-	.quad	__TASK_thread
-
-.Lcleanup_sysc_tif:
-	larl	%r9,.Lsysc_tif
-	BR_EX	%r14,%r11
-
-.Lcleanup_sysc_restore:
-	# check if stpt has been executed
-	clg	%r9,BASED(.Lcleanup_sysc_restore_insn)
-	jh	0f
-	mvc	__LC_EXIT_TIMER(8),__LC_ASYNC_ENTER_TIMER
-	cghi	%r11,__LC_SAVE_AREA_ASYNC
-	je	0f
-	mvc	__LC_EXIT_TIMER(8),__LC_MCCK_ENTER_TIMER
-0:	clg	%r9,BASED(.Lcleanup_sysc_restore_insn+8)
-	je	1f
-	lg	%r9,24(%r11)		# get saved pointer to pt_regs
-	mvc	__LC_RETURN_PSW(16),__PT_PSW(%r9)
-	mvc	0(64,%r11),__PT_R8(%r9)
-	lmg	%r0,%r7,__PT_R0(%r9)
-.Lcleanup_lpswe:
-1:	lmg	%r8,%r9,__LC_RETURN_PSW
-	BR_EX	%r14,%r11
-.Lcleanup_sysc_restore_insn:
-	.quad	.Lsysc_exit_timer
-	.quad	.Lsysc_done - 4
-
-.Lcleanup_io_tif:
-	larl	%r9,.Lio_tif
-	BR_EX	%r14,%r11
-
-.Lcleanup_io_restore:
-	# check if stpt has been executed
-	clg	%r9,BASED(.Lcleanup_io_restore_insn)
-	jh	0f
-	mvc	__LC_EXIT_TIMER(8),__LC_MCCK_ENTER_TIMER
-0:	clg	%r9,BASED(.Lcleanup_io_restore_insn+8)
-	je	1f
-	lg	%r9,24(%r11)		# get saved r11 pointer to pt_regs
-	mvc	__LC_RETURN_PSW(16),__PT_PSW(%r9)
-	mvc	0(64,%r11),__PT_R8(%r9)
-	lmg	%r0,%r7,__PT_R0(%r9)
-1:	lmg	%r8,%r9,__LC_RETURN_PSW
-	BR_EX	%r14,%r11
-.Lcleanup_io_restore_insn:
-	.quad	.Lio_exit_timer
-	.quad	.Lio_done - 4
-
-.Lcleanup_idle:
-	ni	__LC_CPU_FLAGS+7,255-_CIF_ENABLED_WAIT
-	# copy interrupt clock & cpu timer
-	mvc	__CLOCK_IDLE_EXIT(8,%r2),__LC_INT_CLOCK
-	mvc	__TIMER_IDLE_EXIT(8,%r2),__LC_ASYNC_ENTER_TIMER
-	cghi	%r11,__LC_SAVE_AREA_ASYNC
-	je	0f
-	mvc	__CLOCK_IDLE_EXIT(8,%r2),__LC_MCCK_CLOCK
-	mvc	__TIMER_IDLE_EXIT(8,%r2),__LC_MCCK_ENTER_TIMER
-0:	# check if stck & stpt have been executed
-	clg	%r9,BASED(.Lcleanup_idle_insn)
-	jhe	1f
-	mvc	__CLOCK_IDLE_ENTER(8,%r2),__CLOCK_IDLE_EXIT(%r2)
-	mvc	__TIMER_IDLE_ENTER(8,%r2),__TIMER_IDLE_EXIT(%r2)
-1:	# calculate idle cycles
-	clg	%r9,BASED(.Lcleanup_idle_insn)
-	jl	3f
-	larl	%r1,smp_cpu_mtid
-	llgf	%r1,0(%r1)
-	ltgr	%r1,%r1
-	jz	3f
-	.insn	rsy,0xeb0000000017,%r1,5,__SF_EMPTY+80(%r15)
-	larl	%r3,mt_cycles
-	ag	%r3,__LC_PERCPU_OFFSET
-	la	%r4,__SF_EMPTY+16(%r15)
-2:	lg	%r0,0(%r3)
-	slg	%r0,0(%r4)
-	alg	%r0,64(%r4)
-	stg	%r0,0(%r3)
-	la	%r3,8(%r3)
-	la	%r4,8(%r4)
-	brct	%r1,2b
-3:	# account system time going idle
-	lg	%r9,__LC_STEAL_TIMER
-	alg	%r9,__CLOCK_IDLE_ENTER(%r2)
-	slg	%r9,__LC_LAST_UPDATE_CLOCK
-	stg	%r9,__LC_STEAL_TIMER
-	mvc	__LC_LAST_UPDATE_CLOCK(8),__CLOCK_IDLE_EXIT(%r2)
-	lg	%r9,__LC_SYSTEM_TIMER
-	alg	%r9,__LC_LAST_UPDATE_TIMER
-	slg	%r9,__TIMER_IDLE_ENTER(%r2)
-	stg	%r9,__LC_SYSTEM_TIMER
-	mvc	__LC_LAST_UPDATE_TIMER(8),__TIMER_IDLE_EXIT(%r2)
-	# prepare return psw
-	nihh	%r8,0xfcfd		# clear irq & wait state bits
-	lg	%r9,48(%r11)		# return from psw_idle
-	BR_EX	%r14,%r11
-.Lcleanup_idle_insn:
-	.quad	.Lpsw_idle_lpsw
-
-.Lcleanup_save_fpu_regs:
-	larl	%r9,save_fpu_regs
-	BR_EX	%r14,%r11
-
-.Lcleanup_load_fpu_regs:
-	larl	%r9,load_fpu_regs
-	BR_EX	%r14,%r11
-
-/*
- * Integer constants
- */
-	.align	8
-.Lcritical_start:
-	.quad	.L__critical_start
-.Lcritical_length:
-	.quad	.L__critical_end - .L__critical_start
-#if IS_ENABLED(CONFIG_KVM)
-.Lsie_critical_start:
-	.quad	.Lsie_gmap
-.Lsie_critical_length:
-	.quad	.Lsie_done - .Lsie_gmap
-.Lsie_crit_mcck_start:
-	.quad   .Lsie_entry
-.Lsie_crit_mcck_length:
-	.quad   .Lsie_skip - .Lsie_entry
 #endif
 	.section .rodata, "a"
 #define SYSCALL(esame,emu)	.quad __s390x_ ## esame
diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
index 4cd9b1ada834..44e01dd1e624 100644
--- a/arch/s390/kernel/ftrace.c
+++ b/arch/s390/kernel/ftrace.c
@@ -72,22 +72,6 @@ static inline void ftrace_generate_orig_insn(struct ftrace_insn *insn)
 #endif
 }
 
-static inline void ftrace_generate_kprobe_nop_insn(struct ftrace_insn *insn)
-{
-#ifdef CONFIG_KPROBES
-	insn->opc = BREAKPOINT_INSTRUCTION;
-	insn->disp = KPROBE_ON_FTRACE_NOP;
-#endif
-}
-
-static inline void ftrace_generate_kprobe_call_insn(struct ftrace_insn *insn)
-{
-#ifdef CONFIG_KPROBES
-	insn->opc = BREAKPOINT_INSTRUCTION;
-	insn->disp = KPROBE_ON_FTRACE_CALL;
-#endif
-}
-
 int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
 		       unsigned long addr)
 {
diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index 8f8456816d83..0d7fbdfe995a 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -24,19 +24,19 @@ void enabled_wait(void)
 {
 	struct s390_idle_data *idle = this_cpu_ptr(&s390_idle);
 	unsigned long long idle_time;
-	unsigned long psw_mask;
+	unsigned long psw_mask, flags;
 
-	trace_hardirqs_on();
 
 	/* Wait for external, I/O or machine check interrupt. */
 	psw_mask = PSW_KERNEL_BITS | PSW_MASK_WAIT | PSW_MASK_DAT |
 		PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK;
 	clear_cpu_flag(CIF_NOHZ_DELAY);
 
+	local_irq_save(flags);
 	/* Call the assembler magic in entry.S */
 	psw_idle(idle, psw_mask);
+	local_irq_restore(flags);
 
-	trace_hardirqs_off();
 
 	/* Account time spent with enabled wait psw loaded as idle time. */
 	write_seqcount_begin(&idle->seqcount);
@@ -118,22 +118,16 @@ u64 arch_cpu_idle_time(int cpu)
 
 void arch_cpu_idle_enter(void)
 {
-	local_mcck_disable();
 }
 
 void arch_cpu_idle(void)
 {
-	if (!test_cpu_flag(CIF_MCCK_PENDING))
-		/* Halt the cpu and keep track of cpu time accounting. */
-		enabled_wait();
+	enabled_wait();
 	local_irq_enable();
 }
 
 void arch_cpu_idle_exit(void)
 {
-	local_mcck_enable();
-	if (test_cpu_flag(CIF_MCCK_PENDING))
-		s390_handle_mcck();
 }
 
 void arch_cpu_idle_dead(void)
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index 4a71061974fd..ccea9a245867 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -39,6 +39,7 @@
 #define IPL_CCW_STR		"ccw"
 #define IPL_FCP_STR		"fcp"
 #define IPL_FCP_DUMP_STR	"fcp_dump"
+#define IPL_NVME_STR		"nvme"
 #define IPL_NSS_STR		"nss"
 
 #define DUMP_CCW_STR		"ccw"
@@ -93,6 +94,8 @@ static char *ipl_type_str(enum ipl_type type)
 		return IPL_FCP_DUMP_STR;
 	case IPL_TYPE_NSS:
 		return IPL_NSS_STR;
+	case IPL_TYPE_NVME:
+		return IPL_NVME_STR;
 	case IPL_TYPE_UNKNOWN:
 	default:
 		return IPL_UNKNOWN_STR;
@@ -133,6 +136,7 @@ static int reipl_capabilities = IPL_TYPE_UNKNOWN;
 
 static enum ipl_type reipl_type = IPL_TYPE_UNKNOWN;
 static struct ipl_parameter_block *reipl_block_fcp;
+static struct ipl_parameter_block *reipl_block_nvme;
 static struct ipl_parameter_block *reipl_block_ccw;
 static struct ipl_parameter_block *reipl_block_nss;
 static struct ipl_parameter_block *reipl_block_actual;
@@ -261,6 +265,8 @@ static __init enum ipl_type get_ipl_type(void)
 			return IPL_TYPE_FCP_DUMP;
 		else
 			return IPL_TYPE_FCP;
+	case IPL_PBT_NVME:
+		return IPL_TYPE_NVME;
 	}
 	return IPL_TYPE_UNKNOWN;
 }
@@ -317,6 +323,8 @@ static ssize_t sys_ipl_device_show(struct kobject *kobj,
 	case IPL_TYPE_FCP:
 	case IPL_TYPE_FCP_DUMP:
 		return sprintf(page, "0.0.%04x\n", ipl_block.fcp.devno);
+	case IPL_TYPE_NVME:
+		return sprintf(page, "%08ux\n", ipl_block.nvme.fid);
 	default:
 		return 0;
 	}
@@ -345,15 +353,35 @@ static ssize_t ipl_scp_data_read(struct file *filp, struct kobject *kobj,
 
 	return memory_read_from_buffer(buf, count, &off, scp_data, size);
 }
+
+static ssize_t ipl_nvme_scp_data_read(struct file *filp, struct kobject *kobj,
+				 struct bin_attribute *attr, char *buf,
+				 loff_t off, size_t count)
+{
+	unsigned int size = ipl_block.nvme.scp_data_len;
+	void *scp_data = &ipl_block.nvme.scp_data;
+
+	return memory_read_from_buffer(buf, count, &off, scp_data, size);
+}
+
 static struct bin_attribute ipl_scp_data_attr =
 	__BIN_ATTR(scp_data, S_IRUGO, ipl_scp_data_read, NULL, PAGE_SIZE);
 
+static struct bin_attribute ipl_nvme_scp_data_attr =
+	__BIN_ATTR(scp_data, S_IRUGO, ipl_nvme_scp_data_read, NULL, PAGE_SIZE);
+
 static struct bin_attribute *ipl_fcp_bin_attrs[] = {
 	&ipl_parameter_attr,
 	&ipl_scp_data_attr,
 	NULL,
 };
 
+static struct bin_attribute *ipl_nvme_bin_attrs[] = {
+	&ipl_parameter_attr,
+	&ipl_nvme_scp_data_attr,
+	NULL,
+};
+
 /* FCP ipl device attributes */
 
 DEFINE_IPL_ATTR_RO(ipl_fcp, wwpn, "0x%016llx\n",
@@ -365,6 +393,16 @@ DEFINE_IPL_ATTR_RO(ipl_fcp, bootprog, "%lld\n",
 DEFINE_IPL_ATTR_RO(ipl_fcp, br_lba, "%lld\n",
 		   (unsigned long long)ipl_block.fcp.br_lba);
 
+/* NVMe ipl device attributes */
+DEFINE_IPL_ATTR_RO(ipl_nvme, fid, "0x%08llx\n",
+		   (unsigned long long)ipl_block.nvme.fid);
+DEFINE_IPL_ATTR_RO(ipl_nvme, nsid, "0x%08llx\n",
+		   (unsigned long long)ipl_block.nvme.nsid);
+DEFINE_IPL_ATTR_RO(ipl_nvme, bootprog, "%lld\n",
+		   (unsigned long long)ipl_block.nvme.bootprog);
+DEFINE_IPL_ATTR_RO(ipl_nvme, br_lba, "%lld\n",
+		   (unsigned long long)ipl_block.nvme.br_lba);
+
 static ssize_t ipl_ccw_loadparm_show(struct kobject *kobj,
 				     struct kobj_attribute *attr, char *page)
 {
@@ -399,6 +437,24 @@ static struct attribute_group ipl_fcp_attr_group = {
 	.bin_attrs = ipl_fcp_bin_attrs,
 };
 
+static struct attribute *ipl_nvme_attrs[] = {
+	&sys_ipl_type_attr.attr,
+	&sys_ipl_nvme_fid_attr.attr,
+	&sys_ipl_nvme_nsid_attr.attr,
+	&sys_ipl_nvme_bootprog_attr.attr,
+	&sys_ipl_nvme_br_lba_attr.attr,
+	&sys_ipl_ccw_loadparm_attr.attr,
+	&sys_ipl_secure_attr.attr,
+	&sys_ipl_has_secure_attr.attr,
+	NULL,
+};
+
+static struct attribute_group ipl_nvme_attr_group = {
+	.attrs = ipl_nvme_attrs,
+	.bin_attrs = ipl_nvme_bin_attrs,
+};
+
+
 /* CCW ipl device attributes */
 
 static struct attribute *ipl_ccw_attrs_vm[] = {
@@ -474,6 +530,9 @@ static int __init ipl_init(void)
 	case IPL_TYPE_FCP_DUMP:
 		rc = sysfs_create_group(&ipl_kset->kobj, &ipl_fcp_attr_group);
 		break;
+	case IPL_TYPE_NVME:
+		rc = sysfs_create_group(&ipl_kset->kobj, &ipl_nvme_attr_group);
+		break;
 	default:
 		rc = sysfs_create_group(&ipl_kset->kobj,
 					&ipl_unknown_attr_group);
@@ -727,6 +786,93 @@ static struct attribute_group reipl_fcp_attr_group = {
 static struct kobj_attribute sys_reipl_fcp_clear_attr =
 	__ATTR(clear, 0644, reipl_fcp_clear_show, reipl_fcp_clear_store);
 
+/* NVME reipl device attributes */
+
+static ssize_t reipl_nvme_scpdata_read(struct file *filp, struct kobject *kobj,
+				      struct bin_attribute *attr,
+				      char *buf, loff_t off, size_t count)
+{
+	size_t size = reipl_block_nvme->nvme.scp_data_len;
+	void *scp_data = reipl_block_nvme->nvme.scp_data;
+
+	return memory_read_from_buffer(buf, count, &off, scp_data, size);
+}
+
+static ssize_t reipl_nvme_scpdata_write(struct file *filp, struct kobject *kobj,
+				       struct bin_attribute *attr,
+				       char *buf, loff_t off, size_t count)
+{
+	size_t scpdata_len = count;
+	size_t padding;
+
+	if (off)
+		return -EINVAL;
+
+	memcpy(reipl_block_nvme->nvme.scp_data, buf, count);
+	if (scpdata_len % 8) {
+		padding = 8 - (scpdata_len % 8);
+		memset(reipl_block_nvme->nvme.scp_data + scpdata_len,
+		       0, padding);
+		scpdata_len += padding;
+	}
+
+	reipl_block_nvme->hdr.len = IPL_BP_FCP_LEN + scpdata_len;
+	reipl_block_nvme->nvme.len = IPL_BP0_FCP_LEN + scpdata_len;
+	reipl_block_nvme->nvme.scp_data_len = scpdata_len;
+
+	return count;
+}
+
+static struct bin_attribute sys_reipl_nvme_scp_data_attr =
+	__BIN_ATTR(scp_data, (S_IRUGO | S_IWUSR), reipl_nvme_scpdata_read,
+		   reipl_nvme_scpdata_write, DIAG308_SCPDATA_SIZE);
+
+static struct bin_attribute *reipl_nvme_bin_attrs[] = {
+	&sys_reipl_nvme_scp_data_attr,
+	NULL,
+};
+
+DEFINE_IPL_ATTR_RW(reipl_nvme, fid, "0x%08llx\n", "%llx\n",
+		   reipl_block_nvme->nvme.fid);
+DEFINE_IPL_ATTR_RW(reipl_nvme, nsid, "0x%08llx\n", "%llx\n",
+		   reipl_block_nvme->nvme.nsid);
+DEFINE_IPL_ATTR_RW(reipl_nvme, bootprog, "%lld\n", "%lld\n",
+		   reipl_block_nvme->nvme.bootprog);
+DEFINE_IPL_ATTR_RW(reipl_nvme, br_lba, "%lld\n", "%lld\n",
+		   reipl_block_nvme->nvme.br_lba);
+
+/* nvme wrapper */
+static ssize_t reipl_nvme_loadparm_show(struct kobject *kobj,
+				       struct kobj_attribute *attr, char *page)
+{
+	return reipl_generic_loadparm_show(reipl_block_nvme, page);
+}
+
+static ssize_t reipl_nvme_loadparm_store(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					const char *buf, size_t len)
+{
+	return reipl_generic_loadparm_store(reipl_block_nvme, buf, len);
+}
+
+static struct kobj_attribute sys_reipl_nvme_loadparm_attr =
+	__ATTR(loadparm, S_IRUGO | S_IWUSR, reipl_nvme_loadparm_show,
+					    reipl_nvme_loadparm_store);
+
+static struct attribute *reipl_nvme_attrs[] = {
+	&sys_reipl_nvme_fid_attr.attr,
+	&sys_reipl_nvme_nsid_attr.attr,
+	&sys_reipl_nvme_bootprog_attr.attr,
+	&sys_reipl_nvme_br_lba_attr.attr,
+	&sys_reipl_nvme_loadparm_attr.attr,
+	NULL,
+};
+
+static struct attribute_group reipl_nvme_attr_group = {
+	.attrs = reipl_nvme_attrs,
+	.bin_attrs = reipl_nvme_bin_attrs
+};
+
 /* CCW reipl device attributes */
 DEFINE_IPL_CCW_ATTR_RW(reipl_ccw, device, reipl_block_ccw->ccw);
 
@@ -891,6 +1037,9 @@ static int reipl_set_type(enum ipl_type type)
 	case IPL_TYPE_FCP:
 		reipl_block_actual = reipl_block_fcp;
 		break;
+	case IPL_TYPE_NVME:
+		reipl_block_actual = reipl_block_nvme;
+		break;
 	case IPL_TYPE_NSS:
 		reipl_block_actual = reipl_block_nss;
 		break;
@@ -917,6 +1066,8 @@ static ssize_t reipl_type_store(struct kobject *kobj,
 		rc = reipl_set_type(IPL_TYPE_CCW);
 	else if (strncmp(buf, IPL_FCP_STR, strlen(IPL_FCP_STR)) == 0)
 		rc = reipl_set_type(IPL_TYPE_FCP);
+	else if (strncmp(buf, IPL_NVME_STR, strlen(IPL_NVME_STR)) == 0)
+		rc = reipl_set_type(IPL_TYPE_NVME);
 	else if (strncmp(buf, IPL_NSS_STR, strlen(IPL_NSS_STR)) == 0)
 		rc = reipl_set_type(IPL_TYPE_NSS);
 	return (rc != 0) ? rc : len;
@@ -927,6 +1078,7 @@ static struct kobj_attribute reipl_type_attr =
 
 static struct kset *reipl_kset;
 static struct kset *reipl_fcp_kset;
+static struct kset *reipl_nvme_kset;
 
 static void __reipl_run(void *unused)
 {
@@ -945,6 +1097,10 @@ static void __reipl_run(void *unused)
 		else
 			diag308(DIAG308_LOAD_NORMAL, NULL);
 		break;
+	case IPL_TYPE_NVME:
+		diag308(DIAG308_SET, reipl_block_nvme);
+		diag308(DIAG308_LOAD_CLEAR, NULL);
+		break;
 	case IPL_TYPE_NSS:
 		diag308(DIAG308_SET, reipl_block_nss);
 		diag308(DIAG308_LOAD_CLEAR, NULL);
@@ -1093,6 +1249,49 @@ static int __init reipl_fcp_init(void)
 	return rc;
 }
 
+static int __init reipl_nvme_init(void)
+{
+	int rc;
+
+	reipl_block_nvme = (void *) get_zeroed_page(GFP_KERNEL);
+	if (!reipl_block_nvme)
+		return -ENOMEM;
+
+	/* sysfs: create kset for mixing attr group and bin attrs */
+	reipl_nvme_kset = kset_create_and_add(IPL_NVME_STR, NULL,
+					     &reipl_kset->kobj);
+	if (!reipl_nvme_kset) {
+		free_page((unsigned long) reipl_block_nvme);
+		return -ENOMEM;
+	}
+
+	rc = sysfs_create_group(&reipl_nvme_kset->kobj, &reipl_nvme_attr_group);
+	if (rc) {
+		kset_unregister(reipl_nvme_kset);
+		free_page((unsigned long) reipl_block_nvme);
+		return rc;
+	}
+
+	if (ipl_info.type == IPL_TYPE_NVME) {
+		memcpy(reipl_block_nvme, &ipl_block, sizeof(ipl_block));
+		/*
+		 * Fix loadparm: There are systems where the (SCSI) LOADPARM
+		 * is invalid in the IPL parameter block, so take it
+		 * always from sclp_ipl_info.
+		 */
+		memcpy(reipl_block_nvme->nvme.loadparm, sclp_ipl_info.loadparm,
+		       LOADPARM_LEN);
+	} else {
+		reipl_block_nvme->hdr.len = IPL_BP_NVME_LEN;
+		reipl_block_nvme->hdr.version = IPL_PARM_BLOCK_VERSION;
+		reipl_block_nvme->nvme.len = IPL_BP0_NVME_LEN;
+		reipl_block_nvme->nvme.pbt = IPL_PBT_NVME;
+		reipl_block_nvme->nvme.opt = IPL_PB0_NVME_OPT_IPL;
+	}
+	reipl_capabilities |= IPL_TYPE_NVME;
+	return 0;
+}
+
 static int __init reipl_type_init(void)
 {
 	enum ipl_type reipl_type = ipl_info.type;
@@ -1108,6 +1307,9 @@ static int __init reipl_type_init(void)
 	if (reipl_block->pb0_hdr.pbt == IPL_PBT_FCP) {
 		memcpy(reipl_block_fcp, reipl_block, size);
 		reipl_type = IPL_TYPE_FCP;
+	} else if (reipl_block->pb0_hdr.pbt == IPL_PBT_NVME) {
+		memcpy(reipl_block_nvme, reipl_block, size);
+		reipl_type = IPL_TYPE_NVME;
 	} else if (reipl_block->pb0_hdr.pbt == IPL_PBT_CCW) {
 		memcpy(reipl_block_ccw, reipl_block, size);
 		reipl_type = IPL_TYPE_CCW;
@@ -1132,6 +1334,9 @@ static int __init reipl_init(void)
 	if (rc)
 		return rc;
 	rc = reipl_fcp_init();
+	if (rc)
+		return rc;
+	rc = reipl_nvme_init();
 	if (rc)
 		return rc;
 	rc = reipl_nss_init();
@@ -1750,6 +1955,10 @@ void __init setup_ipl(void)
 		ipl_info.data.fcp.wwpn = ipl_block.fcp.wwpn;
 		ipl_info.data.fcp.lun = ipl_block.fcp.lun;
 		break;
+	case IPL_TYPE_NVME:
+		ipl_info.data.nvme.fid = ipl_block.nvme.fid;
+		ipl_info.data.nvme.nsid = ipl_block.nvme.nsid;
+		break;
 	case IPL_TYPE_NSS:
 	case IPL_TYPE_UNKNOWN:
 		/* We have no info to copy */
diff --git a/arch/s390/kernel/nmi.c b/arch/s390/kernel/nmi.c
index 0a487fae763e..86c8d5370e7f 100644
--- a/arch/s390/kernel/nmi.c
+++ b/arch/s390/kernel/nmi.c
@@ -148,7 +148,6 @@ void s390_handle_mcck(void)
 	local_mcck_disable();
 	mcck = *this_cpu_ptr(&cpu_mcck);
 	memset(this_cpu_ptr(&cpu_mcck), 0, sizeof(mcck));
-	clear_cpu_flag(CIF_MCCK_PENDING);
 	local_mcck_enable();
 	local_irq_restore(flags);
 
@@ -333,7 +332,7 @@ NOKPROBE_SYMBOL(s390_backup_mcck_info);
 /*
  * machine check handler.
  */
-void notrace s390_do_machine_check(struct pt_regs *regs)
+int notrace s390_do_machine_check(struct pt_regs *regs)
 {
 	static int ipd_count;
 	static DEFINE_SPINLOCK(ipd_lock);
@@ -342,6 +341,7 @@ void notrace s390_do_machine_check(struct pt_regs *regs)
 	unsigned long long tmp;
 	union mci mci;
 	unsigned long mcck_dam_code;
+	int mcck_pending = 0;
 
 	nmi_enter();
 	inc_irq_stat(NMI_NMI);
@@ -400,7 +400,7 @@ void notrace s390_do_machine_check(struct pt_regs *regs)
 		 */
 		mcck->kill_task = 1;
 		mcck->mcck_code = mci.val;
-		set_cpu_flag(CIF_MCCK_PENDING);
+		mcck_pending = 1;
 	}
 
 	/*
@@ -420,8 +420,7 @@ void notrace s390_do_machine_check(struct pt_regs *regs)
 			mcck->stp_queue |= stp_sync_check();
 		if (S390_lowcore.external_damage_code & (1U << ED_STP_ISLAND))
 			mcck->stp_queue |= stp_island_check();
-		if (mcck->stp_queue)
-			set_cpu_flag(CIF_MCCK_PENDING);
+		mcck_pending = 1;
 	}
 
 	/*
@@ -442,12 +441,12 @@ void notrace s390_do_machine_check(struct pt_regs *regs)
 	if (mci.cp) {
 		/* Channel report word pending */
 		mcck->channel_report = 1;
-		set_cpu_flag(CIF_MCCK_PENDING);
+		mcck_pending = 1;
 	}
 	if (mci.w) {
 		/* Warning pending */
 		mcck->warning = 1;
-		set_cpu_flag(CIF_MCCK_PENDING);
+		mcck_pending = 1;
 	}
 
 	/*
@@ -462,7 +461,17 @@ void notrace s390_do_machine_check(struct pt_regs *regs)
 		*((long *)(regs->gprs[15] + __SF_SIE_REASON)) = -EINTR;
 	}
 	clear_cpu_flag(CIF_MCCK_GUEST);
+
+	if (user_mode(regs) && mcck_pending) {
+		nmi_exit();
+		return 1;
+	}
+
+	if (mcck_pending)
+		schedule_mcck_handler();
+
 	nmi_exit();
+	return 0;
 }
 NOKPROBE_SYMBOL(s390_do_machine_check);
 
diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index 58faa12542a1..994a8b86edae 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -1416,7 +1416,7 @@ static const struct user_regset s390_regsets[] = {
 };
 
 static const struct user_regset_view user_s390_view = {
-	.name = UTS_MACHINE,
+	.name = "s390x",
 	.e_machine = EM_S390,
 	.regsets = s390_regsets,
 	.n = ARRAY_SIZE(s390_regsets)
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 36445dd40fdb..f432b57438f9 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -384,8 +384,7 @@ static void __init setup_lowcore_dat_off(void)
 	lc->restart_psw.addr = (unsigned long) restart_int_handler;
 	lc->external_new_psw.mask = PSW_KERNEL_BITS | PSW_MASK_MCHECK;
 	lc->external_new_psw.addr = (unsigned long) ext_int_handler;
-	lc->svc_new_psw.mask = PSW_KERNEL_BITS |
-		PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK;
+	lc->svc_new_psw.mask = PSW_KERNEL_BITS | PSW_MASK_MCHECK;
 	lc->svc_new_psw.addr = (unsigned long) system_call;
 	lc->program_new_psw.mask = PSW_KERNEL_BITS | PSW_MASK_MCHECK;
 	lc->program_new_psw.addr = (unsigned long) pgm_check_handler;
@@ -597,9 +596,10 @@ static void __init setup_memory_end(void)
 #ifdef CONFIG_CRASH_DUMP
 
 /*
- * When kdump is enabled, we have to ensure that no memory from
- * the area [0 - crashkernel memory size] and
- * [crashk_res.start - crashk_res.end] is set offline.
+ * When kdump is enabled, we have to ensure that no memory from the area
+ * [0 - crashkernel memory size] is set offline - it will be exchanged with
+ * the crashkernel memory region when kdump is triggered. The crashkernel
+ * memory region can never get offlined (pages are unmovable).
  */
 static int kdump_mem_notifier(struct notifier_block *nb,
 			      unsigned long action, void *data)
@@ -610,11 +610,7 @@ static int kdump_mem_notifier(struct notifier_block *nb,
 		return NOTIFY_OK;
 	if (arg->start_pfn < PFN_DOWN(resource_size(&crashk_res)))
 		return NOTIFY_BAD;
-	if (arg->start_pfn > PFN_DOWN(crashk_res.end))
-		return NOTIFY_OK;
-	if (arg->start_pfn + arg->nr_pages - 1 < PFN_DOWN(crashk_res.start))
-		return NOTIFY_OK;
-	return NOTIFY_BAD;
+	return NOTIFY_OK;
 }
 
 static struct notifier_block kdump_mem_nb = {
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 7eaabbab2213..fc1041257c60 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -61,6 +61,7 @@ enum {
 	ec_schedule = 0,
 	ec_call_function_single,
 	ec_stop_cpu,
+	ec_mcck_pending,
 };
 
 enum {
@@ -403,6 +404,11 @@ int smp_find_processor_id(u16 address)
 	return -1;
 }
 
+void schedule_mcck_handler(void)
+{
+	pcpu_ec_call(pcpu_devices + smp_processor_id(), ec_mcck_pending);
+}
+
 bool arch_vcpu_is_preempted(int cpu)
 {
 	if (test_cpu_flag_of(CIF_ENABLED_WAIT, cpu))
@@ -497,6 +503,8 @@ static void smp_handle_ext_call(void)
 		scheduler_ipi();
 	if (test_bit(ec_call_function_single, &bits))
 		generic_smp_call_function_single_interrupt();
+	if (test_bit(ec_mcck_pending, &bits))
+		s390_handle_mcck();
 }
 
 static void do_ext_call_interrupt(struct ext_code ext_code,
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 19a81024fe16..5722daf0b603 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3995,9 +3995,6 @@ static int vcpu_pre_run(struct kvm_vcpu *vcpu)
 	if (need_resched())
 		schedule();
 
-	if (test_cpu_flag(CIF_MCCK_PENDING))
-		s390_handle_mcck();
-
 	if (!kvm_is_ucontrol(vcpu->kvm)) {
 		rc = kvm_s390_deliver_pending_interrupts(vcpu);
 		if (rc)
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 4f6c22d72072..4fde24a1856e 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -1002,8 +1002,6 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 
 	if (need_resched())
 		schedule();
-	if (test_cpu_flag(CIF_MCCK_PENDING))
-		s390_handle_mcck();
 
 	srcu_read_unlock(&vcpu->kvm->srcu, vcpu->srcu_idx);
 
diff --git a/arch/s390/lib/delay.c b/arch/s390/lib/delay.c
index d4aa10795605..daca7bad66de 100644
--- a/arch/s390/lib/delay.c
+++ b/arch/s390/lib/delay.c
@@ -33,7 +33,7 @@ EXPORT_SYMBOL(__delay);
 
 static void __udelay_disabled(unsigned long long usecs)
 {
-	unsigned long cr0, cr0_new, psw_mask;
+	unsigned long cr0, cr0_new, psw_mask, flags;
 	struct s390_idle_data idle;
 	u64 end;
 
@@ -45,7 +45,9 @@ static void __udelay_disabled(unsigned long long usecs)
 	psw_mask = __extract_psw() | PSW_MASK_EXT | PSW_MASK_WAIT;
 	set_clock_comparator(end);
 	set_cpu_flag(CIF_IGNORE_IRQ);
+	local_irq_save(flags);
 	psw_idle(&idle, psw_mask);
+	local_irq_restore(flags);
 	clear_cpu_flag(CIF_IGNORE_IRQ);
 	set_clock_comparator(S390_lowcore.clock_comparator);
 	__ctl_load(cr0, 0, 0);
diff --git a/arch/s390/pci/Makefile b/arch/s390/pci/Makefile
index 748626a33028..b4e3c84772a1 100644
--- a/arch/s390/pci/Makefile
+++ b/arch/s390/pci/Makefile
@@ -4,4 +4,5 @@
 #
 
 obj-$(CONFIG_PCI)	+= pci.o pci_irq.o pci_dma.o pci_clp.o pci_sysfs.o \
-			   pci_event.o pci_debug.o pci_insn.o pci_mmio.o
+			   pci_event.o pci_debug.o pci_insn.o pci_mmio.o \
+			   pci_bus.o
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 94ca121933de..3902c9f6f2d6 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -36,18 +36,21 @@
 #include <asm/pci_clp.h>
 #include <asm/pci_dma.h>
 
+#include "pci_bus.h"
+
 /* list of all detected zpci devices */
 static LIST_HEAD(zpci_list);
 static DEFINE_SPINLOCK(zpci_list_lock);
 
 static DECLARE_BITMAP(zpci_domain, ZPCI_DOMAIN_BITMAP_SIZE);
 static DEFINE_SPINLOCK(zpci_domain_lock);
-static unsigned int zpci_num_domains_allocated;
 
 #define ZPCI_IOMAP_ENTRIES						\
 	min(((unsigned long) ZPCI_NR_DEVICES * PCI_STD_NUM_BARS / 2),	\
 	    ZPCI_IOMAP_MAX_ENTRIES)
 
+unsigned int s390_pci_no_rid;
+
 static DEFINE_SPINLOCK(zpci_iomap_lock);
 static unsigned long *zpci_iomap_bitmap;
 struct zpci_iomap_entry *zpci_iomap_start;
@@ -88,17 +91,12 @@ void zpci_remove_reserved_devices(void)
 	spin_unlock(&zpci_list_lock);
 
 	list_for_each_entry_safe(zdev, tmp, &remove, entry)
-		zpci_remove_device(zdev);
-}
-
-static struct zpci_dev *get_zdev_by_bus(struct pci_bus *bus)
-{
-	return (bus && bus->sysdata) ? (struct zpci_dev *) bus->sysdata : NULL;
+		zpci_zdev_put(zdev);
 }
 
 int pci_domain_nr(struct pci_bus *bus)
 {
-	return ((struct zpci_dev *) bus->sysdata)->domain;
+	return ((struct zpci_bus *) bus->sysdata)->domain_nr;
 }
 EXPORT_SYMBOL_GPL(pci_domain_nr);
 
@@ -228,28 +226,29 @@ void __iowrite64_copy(void __iomem *to, const void *from, size_t count)
        zpci_memcpy_toio(to, from, count);
 }
 
-void __iomem *ioremap(unsigned long ioaddr, unsigned long size)
+void __iomem *ioremap(phys_addr_t addr, size_t size)
 {
+	unsigned long offset, vaddr;
 	struct vm_struct *area;
-	unsigned long offset;
+	phys_addr_t last_addr;
 
-	if (!size)
+	last_addr = addr + size - 1;
+	if (!size || last_addr < addr)
 		return NULL;
 
 	if (!static_branch_unlikely(&have_mio))
-		return (void __iomem *) ioaddr;
+		return (void __iomem *) addr;
 
-	offset = ioaddr & ~PAGE_MASK;
-	ioaddr &= PAGE_MASK;
+	offset = addr & ~PAGE_MASK;
+	addr &= PAGE_MASK;
 	size = PAGE_ALIGN(size + offset);
 	area = get_vm_area(size, VM_IOREMAP);
 	if (!area)
 		return NULL;
 
-	if (ioremap_page_range((unsigned long) area->addr,
-			       (unsigned long) area->addr + size,
-			       ioaddr, PAGE_KERNEL)) {
-		vunmap(area->addr);
+	vaddr = (unsigned long) area->addr;
+	if (ioremap_page_range(vaddr, vaddr + size, addr, PAGE_KERNEL)) {
+		free_vm_area(area);
 		return NULL;
 	}
 	return (void __iomem *) ((unsigned long) area->addr + offset);
@@ -373,29 +372,17 @@ EXPORT_SYMBOL(pci_iounmap);
 static int pci_read(struct pci_bus *bus, unsigned int devfn, int where,
 		    int size, u32 *val)
 {
-	struct zpci_dev *zdev = get_zdev_by_bus(bus);
-	int ret;
+	struct zpci_dev *zdev = get_zdev_by_bus(bus, devfn);
 
-	if (!zdev || devfn != ZPCI_DEVFN)
-		ret = -ENODEV;
-	else
-		ret = zpci_cfg_load(zdev, where, val, size);
-
-	return ret;
+	return (zdev) ? zpci_cfg_load(zdev, where, val, size) : -ENODEV;
 }
 
 static int pci_write(struct pci_bus *bus, unsigned int devfn, int where,
 		     int size, u32 val)
 {
-	struct zpci_dev *zdev = get_zdev_by_bus(bus);
-	int ret;
+	struct zpci_dev *zdev = get_zdev_by_bus(bus, devfn);
 
-	if (!zdev || devfn != ZPCI_DEVFN)
-		ret = -ENODEV;
-	else
-		ret = zpci_cfg_store(zdev, where, val, size);
-
-	return ret;
+	return (zdev) ? zpci_cfg_store(zdev, where, val, size) : -ENODEV;
 }
 
 static struct pci_ops pci_root_ops = {
@@ -506,15 +493,15 @@ static struct resource *__alloc_res(struct zpci_dev *zdev, unsigned long start,
 	return r;
 }
 
-static int zpci_setup_bus_resources(struct zpci_dev *zdev,
-				    struct list_head *resources)
+int zpci_setup_bus_resources(struct zpci_dev *zdev,
+			     struct list_head *resources)
 {
 	unsigned long addr, size, flags;
 	struct resource *res;
 	int i, entry;
 
 	snprintf(zdev->res_name, sizeof(zdev->res_name),
-		 "PCI Bus %04x:%02x", zdev->domain, ZPCI_BUS_NR);
+		 "PCI Bus %04x:%02x", zdev->uid, ZPCI_BUS_NR);
 
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		if (!zdev->bars[i].size)
@@ -608,98 +595,53 @@ void pcibios_disable_device(struct pci_dev *pdev)
 	zpci_debug_exit_device(zdev);
 }
 
-static int zpci_alloc_domain(struct zpci_dev *zdev)
+static int __zpci_register_domain(int domain)
 {
 	spin_lock(&zpci_domain_lock);
-	if (zpci_num_domains_allocated > (ZPCI_NR_DEVICES - 1)) {
+	if (test_bit(domain, zpci_domain)) {
 		spin_unlock(&zpci_domain_lock);
-		pr_err("Adding PCI function %08x failed because the configured limit of %d is reached\n",
-			zdev->fid, ZPCI_NR_DEVICES);
-		return -ENOSPC;
+		pr_err("Domain %04x is already assigned\n", domain);
+		return -EEXIST;
 	}
+	set_bit(domain, zpci_domain);
+	spin_unlock(&zpci_domain_lock);
+	return domain;
+}
 
-	if (zpci_unique_uid) {
-		zdev->domain = (u16) zdev->uid;
-		if (zdev->domain == 0) {
-			pr_warn("UID checking is active but no UID is set for PCI function %08x, so automatic domain allocation is used instead\n",
-				zdev->fid);
-			update_uid_checking(false);
-			goto auto_allocate;
-		}
+static int __zpci_alloc_domain(void)
+{
+	int domain;
 
-		if (test_bit(zdev->domain, zpci_domain)) {
-			spin_unlock(&zpci_domain_lock);
-			pr_err("Adding PCI function %08x failed because domain %04x is already assigned\n",
-				zdev->fid, zdev->domain);
-			return -EEXIST;
-		}
-		set_bit(zdev->domain, zpci_domain);
-		zpci_num_domains_allocated++;
-		spin_unlock(&zpci_domain_lock);
-		return 0;
-	}
-auto_allocate:
+	spin_lock(&zpci_domain_lock);
 	/*
 	 * We can always auto allocate domains below ZPCI_NR_DEVICES.
 	 * There is either a free domain or we have reached the maximum in
 	 * which case we would have bailed earlier.
 	 */
-	zdev->domain = find_first_zero_bit(zpci_domain, ZPCI_NR_DEVICES);
-	set_bit(zdev->domain, zpci_domain);
-	zpci_num_domains_allocated++;
+	domain = find_first_zero_bit(zpci_domain, ZPCI_NR_DEVICES);
+	set_bit(domain, zpci_domain);
 	spin_unlock(&zpci_domain_lock);
-	return 0;
+	return domain;
 }
 
-static void zpci_free_domain(struct zpci_dev *zdev)
+int zpci_alloc_domain(int domain)
 {
-	spin_lock(&zpci_domain_lock);
-	clear_bit(zdev->domain, zpci_domain);
-	zpci_num_domains_allocated--;
-	spin_unlock(&zpci_domain_lock);
+	if (zpci_unique_uid) {
+		if (domain)
+			return __zpci_register_domain(domain);
+		pr_warn("UID checking was active but no UID is provided: switching to automatic domain allocation\n");
+		update_uid_checking(false);
+	}
+	return __zpci_alloc_domain();
 }
 
-void pcibios_remove_bus(struct pci_bus *bus)
+void zpci_free_domain(int domain)
 {
-	struct zpci_dev *zdev = get_zdev_by_bus(bus);
-
-	zpci_exit_slot(zdev);
-	zpci_cleanup_bus_resources(zdev);
-	zpci_destroy_iommu(zdev);
-	zpci_free_domain(zdev);
-
-	spin_lock(&zpci_list_lock);
-	list_del(&zdev->entry);
-	spin_unlock(&zpci_list_lock);
-
-	zpci_dbg(3, "rem fid:%x\n", zdev->fid);
-	kfree(zdev);
+	spin_lock(&zpci_domain_lock);
+	clear_bit(domain, zpci_domain);
+	spin_unlock(&zpci_domain_lock);
 }
 
-static int zpci_scan_bus(struct zpci_dev *zdev)
-{
-	LIST_HEAD(resources);
-	int ret;
-
-	ret = zpci_setup_bus_resources(zdev, &resources);
-	if (ret)
-		goto error;
-
-	zdev->bus = pci_scan_root_bus(NULL, ZPCI_BUS_NR, &pci_root_ops,
-				      zdev, &resources);
-	if (!zdev->bus) {
-		ret = -EIO;
-		goto error;
-	}
-	zdev->bus->max_bus_speed = zdev->max_bus_speed;
-	pci_bus_add_devices(zdev->bus);
-	return 0;
-
-error:
-	zpci_cleanup_bus_resources(zdev);
-	pci_free_resource_list(&resources);
-	return ret;
-}
 
 int zpci_enable_device(struct zpci_dev *zdev)
 {
@@ -734,13 +676,15 @@ int zpci_create_device(struct zpci_dev *zdev)
 {
 	int rc;
 
-	rc = zpci_alloc_domain(zdev);
-	if (rc)
-		goto out;
+	kref_init(&zdev->kref);
+
+	spin_lock(&zpci_list_lock);
+	list_add_tail(&zdev->entry, &zpci_list);
+	spin_unlock(&zpci_list_lock);
 
 	rc = zpci_init_iommu(zdev);
 	if (rc)
-		goto out_free;
+		goto out;
 
 	mutex_init(&zdev->lock);
 	if (zdev->state == ZPCI_FN_STATE_CONFIGURED) {
@@ -748,36 +692,59 @@ int zpci_create_device(struct zpci_dev *zdev)
 		if (rc)
 			goto out_destroy_iommu;
 	}
-	rc = zpci_scan_bus(zdev);
+
+	rc = zpci_bus_device_register(zdev, &pci_root_ops);
 	if (rc)
 		goto out_disable;
 
-	spin_lock(&zpci_list_lock);
-	list_add_tail(&zdev->entry, &zpci_list);
-	spin_unlock(&zpci_list_lock);
-
-	zpci_init_slot(zdev);
-
 	return 0;
 
 out_disable:
 	if (zdev->state == ZPCI_FN_STATE_ONLINE)
 		zpci_disable_device(zdev);
+
 out_destroy_iommu:
 	zpci_destroy_iommu(zdev);
-out_free:
-	zpci_free_domain(zdev);
 out:
+	spin_lock(&zpci_list_lock);
+	list_del(&zdev->entry);
+	spin_unlock(&zpci_list_lock);
 	return rc;
 }
 
-void zpci_remove_device(struct zpci_dev *zdev)
+void zpci_release_device(struct kref *kref)
 {
-	if (!zdev->bus)
-		return;
+	struct zpci_dev *zdev = container_of(kref, struct zpci_dev, kref);
+
+	if (zdev->zbus->bus) {
+		struct pci_dev *pdev;
+
+		pdev = pci_get_slot(zdev->zbus->bus, zdev->devfn);
+		if (pdev)
+			pci_stop_and_remove_bus_device_locked(pdev);
+	}
+
+	switch (zdev->state) {
+	case ZPCI_FN_STATE_ONLINE:
+	case ZPCI_FN_STATE_CONFIGURED:
+		zpci_disable_device(zdev);
+		fallthrough;
+	case ZPCI_FN_STATE_STANDBY:
+		if (zdev->has_hp_slot)
+			zpci_exit_slot(zdev);
+		zpci_cleanup_bus_resources(zdev);
+		zpci_bus_device_unregister(zdev);
+		zpci_destroy_iommu(zdev);
+		fallthrough;
+	default:
+		break;
+	}
 
-	pci_stop_root_bus(zdev->bus);
-	pci_remove_root_bus(zdev->bus);
+	spin_lock(&zpci_list_lock);
+	list_del(&zdev->entry);
+	spin_unlock(&zpci_list_lock);
+	zpci_dbg(3, "rem fid:%x\n", zdev->fid);
+	kfree(zdev);
 }
 
 int zpci_report_error(struct pci_dev *pdev,
@@ -844,6 +811,10 @@ char * __init pcibios_setup(char *str)
 		s390_pci_force_floating = 1;
 		return NULL;
 	}
+	if (!strcmp(str, "norid")) {
+		s390_pci_no_rid = 1;
+		return NULL;
+	}
 	return str;
 }
 
diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
new file mode 100644
index 000000000000..642a99384688
--- /dev/null
+++ b/arch/s390/pci/pci_bus.c
@@ -0,0 +1,328 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright IBM Corp. 2020
+ *
+ * Author(s):
+ *   Pierre Morel <pmorel@linux.ibm.com>
+ *
+ */
+
+#define KMSG_COMPONENT "zpci"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/delay.h>
+#include <linux/seq_file.h>
+#include <linux/jump_label.h>
+#include <linux/pci.h>
+#include <linux/printk.h>
+
+#include <asm/pci_clp.h>
+#include <asm/pci_dma.h>
+
+#include "pci_bus.h"
+
+static LIST_HEAD(zbus_list);
+static DEFINE_SPINLOCK(zbus_list_lock);
+static int zpci_nb_devices;
+
+/* zpci_bus_scan
+ * @zbus: the zbus holding the zdevices
+ * @ops: the pci operations
+ *
+ * The domain number must be set before pci_scan_root_bus is called.
+ * This function can be called once the domain is known, hence
+ * when the function_0 is dicovered.
+ */
+static int zpci_bus_scan(struct zpci_bus *zbus, int domain, struct pci_ops *ops)
+{
+	struct pci_bus *bus;
+	int rc;
+
+	rc = zpci_alloc_domain(domain);
+	if (rc < 0)
+		return rc;
+	zbus->domain_nr = rc;
+
+	bus = pci_scan_root_bus(NULL, ZPCI_BUS_NR, ops, zbus, &zbus->resources);
+	if (!bus) {
+		zpci_free_domain(zbus->domain_nr);
+		return -EFAULT;
+	}
+
+	zbus->bus = bus;
+	pci_bus_add_devices(bus);
+	return 0;
+}
+
+static void zpci_bus_release(struct kref *kref)
+{
+	struct zpci_bus *zbus = container_of(kref, struct zpci_bus, kref);
+
+	if (zbus->bus) {
+		pci_lock_rescan_remove();
+		pci_stop_root_bus(zbus->bus);
+
+		zpci_free_domain(zbus->domain_nr);
+		pci_free_resource_list(&zbus->resources);
+
+		pci_remove_root_bus(zbus->bus);
+		pci_unlock_rescan_remove();
+	}
+
+	spin_lock(&zbus_list_lock);
+	list_del(&zbus->bus_next);
+	spin_unlock(&zbus_list_lock);
+	kfree(zbus);
+}
+
+static void zpci_bus_put(struct zpci_bus *zbus)
+{
+	kref_put(&zbus->kref, zpci_bus_release);
+}
+
+static struct zpci_bus *zpci_bus_get(int pchid)
+{
+	struct zpci_bus *zbus;
+
+	spin_lock(&zbus_list_lock);
+	list_for_each_entry(zbus, &zbus_list, bus_next) {
+		if (pchid == zbus->pchid) {
+			kref_get(&zbus->kref);
+			goto out_unlock;
+		}
+	}
+	zbus = NULL;
+out_unlock:
+	spin_unlock(&zbus_list_lock);
+	return zbus;
+}
+
+static struct zpci_bus *zpci_bus_alloc(int pchid)
+{
+	struct zpci_bus *zbus;
+
+	zbus = kzalloc(sizeof(*zbus), GFP_KERNEL);
+	if (!zbus)
+		return NULL;
+
+	zbus->pchid = pchid;
+	INIT_LIST_HEAD(&zbus->bus_next);
+	spin_lock(&zbus_list_lock);
+	list_add_tail(&zbus->bus_next, &zbus_list);
+	spin_unlock(&zbus_list_lock);
+
+	kref_init(&zbus->kref);
+	INIT_LIST_HEAD(&zbus->resources);
+
+	zbus->bus_resource.start = 0;
+	zbus->bus_resource.end = ZPCI_BUS_NR;
+	zbus->bus_resource.flags = IORESOURCE_BUS;
+	pci_add_resource(&zbus->resources, &zbus->bus_resource);
+
+	return zbus;
+}
+
+#ifdef CONFIG_PCI_IOV
+static int zpci_bus_link_virtfn(struct pci_dev *pdev,
+		struct pci_dev *virtfn, int vfid)
+{
+	int rc;
+
+	virtfn->physfn = pci_dev_get(pdev);
+	rc = pci_iov_sysfs_link(pdev, virtfn, vfid);
+	if (rc) {
+		pci_dev_put(pdev);
+		virtfn->physfn = NULL;
+		return rc;
+	}
+	return 0;
+}
+
+static int zpci_bus_setup_virtfn(struct zpci_bus *zbus,
+		struct pci_dev *virtfn, int vfn)
+{
+	int i, cand_devfn;
+	struct zpci_dev *zdev;
+	struct pci_dev *pdev;
+	int vfid = vfn - 1; /* Linux' vfid's start at 0 vfn at 1*/
+	int rc = 0;
+
+	virtfn->is_virtfn = 1;
+	virtfn->multifunction = 0;
+	WARN_ON(vfid < 0);
+	/* If the parent PF for the given VF is also configured in the
+	 * instance, it must be on the same zbus.
+	 * We can then identify the parent PF by checking what
+	 * devfn the VF would have if it belonged to that PF using the PF's
+	 * stride and offset. Only if this candidate devfn matches the
+	 * actual devfn will we link both functions.
+	 */
+	for (i = 0; i < ZPCI_FUNCTIONS_PER_BUS; i++) {
+		zdev = zbus->function[i];
+		if (zdev && zdev->is_physfn) {
+			pdev = pci_get_slot(zbus->bus, zdev->devfn);
+			cand_devfn = pci_iov_virtfn_devfn(pdev, vfid);
+			if (cand_devfn == virtfn->devfn) {
+				rc = zpci_bus_link_virtfn(pdev, virtfn, vfid);
+				break;
+			}
+		}
+	}
+	return rc;
+}
+#else
+static inline int zpci_bus_setup_virtfn(struct zpci_bus *zbus,
+		struct pci_dev *virtfn, int vfn)
+{
+	virtfn->is_virtfn = 1;
+	virtfn->multifunction = 0;
+	return 0;
+}
+#endif
+
+static int zpci_bus_add_device(struct zpci_bus *zbus, struct zpci_dev *zdev)
+{
+	struct pci_bus *bus;
+	struct resource_entry *window, *n;
+	struct resource *res;
+	struct pci_dev *pdev;
+	int rc;
+
+	bus = zbus->bus;
+	if (!bus)
+		return -EINVAL;
+
+	pdev = pci_get_slot(bus, zdev->devfn);
+	if (pdev) {
+		/* Device is already known. */
+		pci_dev_put(pdev);
+		return 0;
+	}
+
+	rc = zpci_init_slot(zdev);
+	if (rc)
+		return rc;
+	zdev->has_hp_slot = 1;
+
+	resource_list_for_each_entry_safe(window, n, &zbus->resources) {
+		res = window->res;
+		pci_bus_add_resource(bus, res, 0);
+	}
+
+	pdev = pci_scan_single_device(bus, zdev->devfn);
+	if (pdev) {
+		if (!zdev->is_physfn) {
+			rc = zpci_bus_setup_virtfn(zbus, pdev, zdev->vfn);
+			if (rc)
+				goto failed_with_pdev;
+		}
+		pci_bus_add_device(pdev);
+	}
+	return 0;
+
+failed_with_pdev:
+	pci_stop_and_remove_bus_device(pdev);
+	pci_dev_put(pdev);
+	return rc;
+}
+
+static void zpci_bus_add_devices(struct zpci_bus *zbus)
+{
+	int i;
+
+	for (i = 1; i < ZPCI_FUNCTIONS_PER_BUS; i++)
+		if (zbus->function[i])
+			zpci_bus_add_device(zbus, zbus->function[i]);
+
+	pci_lock_rescan_remove();
+	pci_bus_add_devices(zbus->bus);
+	pci_unlock_rescan_remove();
+}
+
+int zpci_bus_device_register(struct zpci_dev *zdev, struct pci_ops *ops)
+{
+	struct zpci_bus *zbus = NULL;
+	int rc = -EBADF;
+
+	if (zpci_nb_devices == ZPCI_NR_DEVICES) {
+		pr_warn("Adding PCI function %08x failed because the configured limit of %d is reached\n",
+			zdev->fid, ZPCI_NR_DEVICES);
+		return -ENOSPC;
+	}
+	zpci_nb_devices++;
+
+	if (zdev->devfn >= ZPCI_FUNCTIONS_PER_BUS)
+		return -EINVAL;
+
+	if (!s390_pci_no_rid && zdev->rid_available)
+		zbus = zpci_bus_get(zdev->pchid);
+
+	if (!zbus) {
+		zbus = zpci_bus_alloc(zdev->pchid);
+		if (!zbus)
+			return -ENOMEM;
+	}
+
+	zdev->zbus = zbus;
+	if (zbus->function[zdev->devfn]) {
+		pr_err("devfn %04x is already assigned\n", zdev->devfn);
+		goto error; /* rc already set */
+	}
+	zbus->function[zdev->devfn] = zdev;
+
+	zpci_setup_bus_resources(zdev, &zbus->resources);
+
+	if (zbus->bus) {
+		if (!zbus->multifunction) {
+			WARN_ONCE(1, "zbus is not multifunction\n");
+			goto error_bus;
+		}
+		if (!zdev->rid_available) {
+			WARN_ONCE(1, "rid_available not set for multifunction\n");
+			goto error_bus;
+		}
+		rc = zpci_bus_add_device(zbus, zdev);
+		if (rc)
+			goto error_bus;
+	} else if (zdev->devfn == 0) {
+		if (zbus->multifunction && !zdev->rid_available) {
+			WARN_ONCE(1, "rid_available not set on function 0 for multifunction\n");
+			goto error_bus;
+		}
+		rc = zpci_bus_scan(zbus, (u16)zdev->uid, ops);
+		if (rc)
+			goto error_bus;
+		zpci_bus_add_devices(zbus);
+		rc = zpci_init_slot(zdev);
+		if (rc)
+			goto error_bus;
+		zdev->has_hp_slot = 1;
+		zbus->multifunction = zdev->rid_available;
+		zbus->max_bus_speed = zdev->max_bus_speed;
+	} else {
+		zbus->multifunction = 1;
+	}
+
+	return 0;
+
+error_bus:
+	zpci_nb_devices--;
+	zbus->function[zdev->devfn] = NULL;
+error:
+	pr_err("Adding PCI function %08x failed\n", zdev->fid);
+	zpci_bus_put(zbus);
+	return rc;
+}
+
+void zpci_bus_device_unregister(struct zpci_dev *zdev)
+{
+	struct zpci_bus *zbus = zdev->zbus;
+
+	zpci_nb_devices--;
+	zbus->function[zdev->devfn] = NULL;
+	zpci_bus_put(zbus);
+}
diff --git a/arch/s390/pci/pci_bus.h b/arch/s390/pci/pci_bus.h
new file mode 100644
index 000000000000..89be3c354b7b
--- /dev/null
+++ b/arch/s390/pci/pci_bus.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright IBM Corp. 2020
+ *
+ * Author(s):
+ *   Pierre Morel <pmorel@linux.ibm.com>
+ *
+ */
+
+int zpci_bus_device_register(struct zpci_dev *zdev, struct pci_ops *ops);
+void zpci_bus_device_unregister(struct zpci_dev *zdev);
+int zpci_bus_init(void);
+
+void zpci_release_device(struct kref *kref);
+static inline void zpci_zdev_put(struct zpci_dev *zdev)
+{
+	kref_put(&zdev->kref, zpci_release_device);
+}
+
+int zpci_alloc_domain(int domain);
+void zpci_free_domain(int domain);
+int zpci_setup_bus_resources(struct zpci_dev *zdev,
+			     struct list_head *resources);
+
+static inline struct zpci_dev *get_zdev_by_bus(struct pci_bus *bus,
+					       unsigned int devfn)
+{
+	struct zpci_bus *zbus = bus->sysdata;
+
+	return (devfn >= ZPCI_FUNCTIONS_PER_BUS) ? NULL : zbus->function[devfn];
+}
diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
index ea794ae755ae..7e735f41a0a6 100644
--- a/arch/s390/pci/pci_clp.c
+++ b/arch/s390/pci/pci_clp.c
@@ -155,8 +155,13 @@ static int clp_store_query_pci_fn(struct zpci_dev *zdev,
 	zdev->pfgid = response->pfgid;
 	zdev->pft = response->pft;
 	zdev->vfn = response->vfn;
+	zdev->port = response->port;
 	zdev->uid = response->uid;
 	zdev->fmb_length = sizeof(u32) * response->fmb_len;
+	zdev->rid_available = response->rid_avail;
+	zdev->is_physfn = response->is_physfn;
+	if (!s390_pci_no_rid && zdev->rid_available)
+		zdev->devfn = response->rid & ZPCI_RID_MASK_DEVFN;
 
 	memcpy(zdev->pfip, response->pfip, sizeof(zdev->pfip));
 	if (response->util_str_avail) {
@@ -309,14 +314,13 @@ int clp_enable_fh(struct zpci_dev *zdev, u8 nr_dma_as)
 
 int clp_disable_fh(struct zpci_dev *zdev)
 {
-	u32 fh = zdev->fh;
 	int rc;
 
 	if (!zdev_enabled(zdev))
 		return 0;
 
 	rc = clp_set_pci_fn(zdev, 0, CLP_SET_DISABLE_PCI_FN);
-	zpci_dbg(3, "dis fid:%x, fh:%x, rc:%d\n", zdev->fid, fh, rc);
+	zpci_dbg(3, "dis fid:%x, fh:%x, rc:%d\n", zdev->fid, zdev->fh, rc);
 	return rc;
 }
 
diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index 8d6ee4af4230..08e1d619398e 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -14,6 +14,8 @@
 #include <asm/pci_debug.h>
 #include <asm/sclp.h>
 
+#include "pci_bus.h"
+
 /* Content Code Description for PCI Function Error */
 struct zpci_ccdf_err {
 	u32 reserved1;
@@ -53,7 +55,7 @@ static void __zpci_event_error(struct zpci_ccdf_err *ccdf)
 	zpci_err_hex(ccdf, sizeof(*ccdf));
 
 	if (zdev)
-		pdev = pci_get_slot(zdev->bus, ZPCI_DEVFN);
+		pdev = pci_get_slot(zdev->zbus->bus, zdev->devfn);
 
 	pr_err("%s: Event 0x%x reports an error for PCI function 0x%x\n",
 	       pdev ? pci_name(pdev) : "n/a", ccdf->pec, ccdf->fid);
@@ -78,36 +80,28 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 	enum zpci_state state;
 	int ret;
 
-	if (zdev)
-		pdev = pci_get_slot(zdev->bus, ZPCI_DEVFN);
+	if (zdev && zdev->zbus && zdev->zbus->bus)
+		pdev = pci_get_slot(zdev->zbus->bus, zdev->devfn);
 
-	pr_info("%s: Event 0x%x reconfigured PCI function 0x%x\n",
-		pdev ? pci_name(pdev) : "n/a", ccdf->pec, ccdf->fid);
 	zpci_err("avail CCDF:\n");
 	zpci_err_hex(ccdf, sizeof(*ccdf));
 
 	switch (ccdf->pec) {
 	case 0x0301: /* Reserved|Standby -> Configured */
 		if (!zdev) {
-			ret = clp_add_pci_device(ccdf->fid, ccdf->fh, 0);
-			if (ret)
-				break;
-			zdev = get_zdev_by_fid(ccdf->fid);
-		}
-		if (!zdev || zdev->state != ZPCI_FN_STATE_STANDBY)
+			ret = clp_add_pci_device(ccdf->fid, ccdf->fh, 1);
 			break;
-		zdev->state = ZPCI_FN_STATE_CONFIGURED;
+		}
 		zdev->fh = ccdf->fh;
-		ret = zpci_enable_device(zdev);
-		if (ret)
-			break;
-		pci_lock_rescan_remove();
-		pci_rescan_bus(zdev->bus);
-		pci_unlock_rescan_remove();
+		zdev->state = ZPCI_FN_STATE_CONFIGURED;
+		zpci_create_device(zdev);
 		break;
 	case 0x0302: /* Reserved -> Standby */
-		if (!zdev)
+		if (!zdev) {
 			clp_add_pci_device(ccdf->fid, ccdf->fh, 0);
+			break;
+		}
+		zdev->fh = ccdf->fh;
 		break;
 	case 0x0303: /* Deconfiguration requested */
 		if (!zdev)
@@ -135,12 +129,10 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 			pci_stop_and_remove_bus_device_locked(pdev);
 		}
 
-		zdev->fh = ccdf->fh;
-		zpci_disable_device(zdev);
 		zdev->state = ZPCI_FN_STATE_STANDBY;
 		if (!clp_get_state(ccdf->fid, &state) &&
 		    state == ZPCI_FN_STATE_RESERVED) {
-			zpci_remove_device(zdev);
+			zpci_zdev_put(zdev);
 		}
 		break;
 	case 0x0306: /* 0x308 or 0x302 for multiple devices */
@@ -149,12 +141,11 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
 	case 0x0308: /* Standby -> Reserved */
 		if (!zdev)
 			break;
-		zpci_remove_device(zdev);
+		zpci_zdev_put(zdev);
 		break;
 	default:
 		break;
 	}
-	pci_dev_put(pdev);
 }
 
 void zpci_event_availability(void *data)
diff --git a/arch/s390/pci/pci_sysfs.c b/arch/s390/pci/pci_sysfs.c
index 215f17437a4f..5c028bee91b9 100644
--- a/arch/s390/pci/pci_sysfs.c
+++ b/arch/s390/pci/pci_sysfs.c
@@ -33,6 +33,7 @@ zpci_attr(pchid, "0x%04x\n", pchid);
 zpci_attr(pfgid, "0x%02x\n", pfgid);
 zpci_attr(vfn, "0x%04x\n", vfn);
 zpci_attr(pft, "0x%02x\n", pft);
+zpci_attr(port, "%d\n", port);
 zpci_attr(uid, "0x%x\n", uid);
 zpci_attr(segment0, "0x%02x\n", pfip[0]);
 zpci_attr(segment1, "0x%02x\n", pfip[1]);
@@ -88,7 +89,7 @@ static ssize_t recover_store(struct device *dev, struct device_attribute *attr,
 		ret = zpci_enable_device(zdev);
 		if (ret)
 			goto out;
-		pci_rescan_bus(zdev->bus);
+		pci_rescan_bus(zdev->zbus->bus);
 	}
 out:
 	pci_unlock_rescan_remove();
@@ -142,6 +143,7 @@ static struct attribute *zpci_dev_attrs[] = {
 	&dev_attr_pchid.attr,
 	&dev_attr_pfgid.attr,
 	&dev_attr_pft.attr,
+	&dev_attr_port.attr,
 	&dev_attr_vfn.attr,
 	&dev_attr_uid.attr,
 	&dev_attr_recover.attr,
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 1137f3ddcb85..c60d5c776fc6 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -87,7 +87,7 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 				    struct device *dev)
 {
 	struct s390_domain *s390_domain = to_s390_domain(domain);
-	struct zpci_dev *zdev = to_pci_dev(dev)->sysdata;
+	struct zpci_dev *zdev = to_zpci_dev(dev);
 	struct s390_domain_device *domain_device;
 	unsigned long flags;
 	int rc;
@@ -139,7 +139,7 @@ static void s390_iommu_detach_device(struct iommu_domain *domain,
 				     struct device *dev)
 {
 	struct s390_domain *s390_domain = to_s390_domain(domain);
-	struct zpci_dev *zdev = to_pci_dev(dev)->sysdata;
+	struct zpci_dev *zdev = to_zpci_dev(dev);
 	struct s390_domain_device *domain_device, *tmp;
 	unsigned long flags;
 	int found = 0;
@@ -169,7 +169,7 @@ static void s390_iommu_detach_device(struct iommu_domain *domain,
 static int s390_iommu_add_device(struct device *dev)
 {
 	struct iommu_group *group = iommu_group_get_for_dev(dev);
-	struct zpci_dev *zdev = to_pci_dev(dev)->sysdata;
+	struct zpci_dev *zdev = to_zpci_dev(dev);
 
 	if (IS_ERR(group))
 		return PTR_ERR(group);
@@ -182,7 +182,7 @@ static int s390_iommu_add_device(struct device *dev)
 
 static void s390_iommu_remove_device(struct device *dev)
 {
-	struct zpci_dev *zdev = to_pci_dev(dev)->sysdata;
+	struct zpci_dev *zdev = to_zpci_dev(dev);
 	struct iommu_domain *domain;
 
 	/*
diff --git a/drivers/pci/hotplug/s390_pci_hpc.c b/drivers/pci/hotplug/s390_pci_hpc.c
index 39295d88f670..b59f84918fe0 100644
--- a/drivers/pci/hotplug/s390_pci_hpc.c
+++ b/drivers/pci/hotplug/s390_pci_hpc.c
@@ -52,6 +52,7 @@ static int enable_slot(struct hotplug_slot *hotplug_slot)
 {
 	struct zpci_dev *zdev = container_of(hotplug_slot, struct zpci_dev,
 					     hotplug_slot);
+	struct zpci_bus *zbus = zdev->zbus;
 	int rc;
 
 	if (zdev->state != ZPCI_FN_STATE_STANDBY)
@@ -65,9 +66,9 @@ static int enable_slot(struct hotplug_slot *hotplug_slot)
 	if (rc)
 		goto out_deconfigure;
 
-	pci_scan_slot(zdev->bus, ZPCI_DEVFN);
+	pci_scan_slot(zbus->bus, zdev->devfn);
 	pci_lock_rescan_remove();
-	pci_bus_add_devices(zdev->bus);
+	pci_bus_add_devices(zbus->bus);
 	pci_unlock_rescan_remove();
 
 	return rc;
@@ -82,13 +83,17 @@ static int disable_slot(struct hotplug_slot *hotplug_slot)
 	struct zpci_dev *zdev = container_of(hotplug_slot, struct zpci_dev,
 					     hotplug_slot);
 	struct pci_dev *pdev;
+	struct zpci_bus *zbus = zdev->zbus;
 	int rc;
 
 	if (!zpci_fn_configured(zdev->state))
 		return -EIO;
 
-	pdev = pci_get_slot(zdev->bus, ZPCI_DEVFN);
+	pdev = pci_get_slot(zbus->bus, zdev->devfn);
 	if (pdev) {
+		if (pci_num_vf(pdev))
+			return -EBUSY;
+
 		pci_stop_and_remove_bus_device_locked(pdev);
 		pci_dev_put(pdev);
 	}
@@ -133,12 +138,13 @@ static const struct hotplug_slot_ops s390_hotplug_slot_ops = {
 int zpci_init_slot(struct zpci_dev *zdev)
 {
 	char name[SLOT_NAME_SIZE];
+	struct zpci_bus *zbus = zdev->zbus;
 
 	zdev->hotplug_slot.ops = &s390_hotplug_slot_ops;
 
 	snprintf(name, SLOT_NAME_SIZE, "%08x", zdev->fid);
-	return pci_hp_register(&zdev->hotplug_slot, zdev->bus,
-			       ZPCI_DEVFN, name);
+	return pci_hp_register(&zdev->hotplug_slot, zbus->bus,
+			       zdev->devfn, name);
 }
 
 void zpci_exit_slot(struct zpci_dev *zdev)
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 4d1f392b05f9..b37e08c4f9d1 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -133,12 +133,35 @@ static void pci_read_vf_config_common(struct pci_dev *virtfn)
 			     &physfn->sriov->subsystem_device);
 }
 
+int pci_iov_sysfs_link(struct pci_dev *dev,
+		struct pci_dev *virtfn, int id)
+{
+	char buf[VIRTFN_ID_LEN];
+	int rc;
+
+	sprintf(buf, "virtfn%u", id);
+	rc = sysfs_create_link(&dev->dev.kobj, &virtfn->dev.kobj, buf);
+	if (rc)
+		goto failed;
+	rc = sysfs_create_link(&virtfn->dev.kobj, &dev->dev.kobj, "physfn");
+	if (rc)
+		goto failed1;
+
+	kobject_uevent(&virtfn->dev.kobj, KOBJ_CHANGE);
+
+	return 0;
+
+failed1:
+	sysfs_remove_link(&dev->dev.kobj, buf);
+failed:
+	return rc;
+}
+
 int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 {
 	int i;
 	int rc = -ENOMEM;
 	u64 size;
-	char buf[VIRTFN_ID_LEN];
 	struct pci_dev *virtfn;
 	struct resource *res;
 	struct pci_sriov *iov = dev->sriov;
@@ -182,23 +205,14 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 	}
 
 	pci_device_add(virtfn, virtfn->bus);
-
-	sprintf(buf, "virtfn%u", id);
-	rc = sysfs_create_link(&dev->dev.kobj, &virtfn->dev.kobj, buf);
+	rc = pci_iov_sysfs_link(dev, virtfn, id);
 	if (rc)
 		goto failed1;
-	rc = sysfs_create_link(&virtfn->dev.kobj, &dev->dev.kobj, "physfn");
-	if (rc)
-		goto failed2;
-
-	kobject_uevent(&virtfn->dev.kobj, KOBJ_CHANGE);
 
 	pci_bus_add_device(virtfn);
 
 	return 0;
 
-failed2:
-	sysfs_remove_link(&dev->dev.kobj, buf);
 failed1:
 	pci_stop_and_remove_bus_device(virtfn);
 	pci_dev_put(dev);
@@ -557,9 +571,6 @@ static void sriov_del_vfs(struct pci_dev *dev)
 	struct pci_sriov *iov = dev->sriov;
 	int i;
 
-	if (dev->no_vf_scan)
-		return;
-
 	for (i = 0; i < iov->num_VFs; i++)
 		pci_iov_remove_virtfn(dev, i);
 }
diff --git a/drivers/s390/cio/Makefile b/drivers/s390/cio/Makefile
index 23eae4188876..a9235f111e79 100644
--- a/drivers/s390/cio/Makefile
+++ b/drivers/s390/cio/Makefile
@@ -21,5 +21,5 @@ qdio-objs := qdio_main.o qdio_thinint.o qdio_debug.o qdio_setup.o
 obj-$(CONFIG_QDIO) += qdio.o
 
 vfio_ccw-objs += vfio_ccw_drv.o vfio_ccw_cp.o vfio_ccw_ops.o vfio_ccw_fsm.o \
-	vfio_ccw_async.o vfio_ccw_trace.o
+	vfio_ccw_async.o vfio_ccw_trace.o vfio_ccw_chp.o
 obj-$(CONFIG_VFIO_CCW) += vfio_ccw.o
diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
index 1ca73c2e5a8f..c314e9495c1b 100644
--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -57,6 +57,7 @@ int chsc_error_from_response(int response)
 	case 0x0104:
 		return -EINVAL;
 	case 0x0004:
+	case 0x0106:		/* "Wrong Channel Parm" for the op 0x003d */
 		return -EOPNOTSUPP;
 	case 0x000b:
 	case 0x0107:		/* "Channel busy" for the op 0x003d */
@@ -1336,36 +1337,35 @@ int chsc_scm_info(struct chsc_scm_info *scm_area, u64 token)
 EXPORT_SYMBOL_GPL(chsc_scm_info);
 
 /**
- * chsc_pnso_brinfo() - Perform Network-Subchannel Operation, Bridge Info.
+ * chsc_pnso() - Perform Network-Subchannel Operation
  * @schid:		id of the subchannel on which PNSO is performed
- * @brinfo_area:	request and response block for the operation
+ * @pnso_area:		request and response block for the operation
  * @resume_token:	resume token for multiblock response
  * @cnc:		Boolean change-notification control
  *
- * brinfo_area must be allocated by the caller with get_zeroed_page(GFP_KERNEL)
+ * pnso_area must be allocated by the caller with get_zeroed_page(GFP_KERNEL)
  *
  * Returns 0 on success.
  */
-int chsc_pnso_brinfo(struct subchannel_id schid,
-		struct chsc_pnso_area *brinfo_area,
-		struct chsc_brinfo_resume_token resume_token,
-		int cnc)
+int chsc_pnso(struct subchannel_id schid,
+	      struct chsc_pnso_area *pnso_area,
+	      struct chsc_pnso_resume_token resume_token,
+	      int cnc)
 {
-	memset(brinfo_area, 0, sizeof(*brinfo_area));
-	brinfo_area->request.length = 0x0030;
-	brinfo_area->request.code = 0x003d; /* network-subchannel operation */
-	brinfo_area->m	   = schid.m;
-	brinfo_area->ssid  = schid.ssid;
-	brinfo_area->sch   = schid.sch_no;
-	brinfo_area->cssid = schid.cssid;
-	brinfo_area->oc    = 0; /* Store-network-bridging-information list */
-	brinfo_area->resume_token = resume_token;
-	brinfo_area->n	   = (cnc != 0);
-	if (chsc(brinfo_area))
+	memset(pnso_area, 0, sizeof(*pnso_area));
+	pnso_area->request.length = 0x0030;
+	pnso_area->request.code = 0x003d; /* network-subchannel operation */
+	pnso_area->m	   = schid.m;
+	pnso_area->ssid  = schid.ssid;
+	pnso_area->sch	 = schid.sch_no;
+	pnso_area->cssid = schid.cssid;
+	pnso_area->oc	 = 0; /* Store-network-bridging-information list */
+	pnso_area->resume_token = resume_token;
+	pnso_area->n	   = (cnc != 0);
+	if (chsc(pnso_area))
 		return -EIO;
-	return chsc_error_from_response(brinfo_area->response.code);
+	return chsc_error_from_response(pnso_area->response.code);
 }
-EXPORT_SYMBOL_GPL(chsc_pnso_brinfo);
 
 int chsc_sgib(u32 origin)
 {
diff --git a/drivers/s390/cio/chsc.h b/drivers/s390/cio/chsc.h
index 34de6d77442c..7ecf7e4c402e 100644
--- a/drivers/s390/cio/chsc.h
+++ b/drivers/s390/cio/chsc.h
@@ -205,52 +205,10 @@ struct chsc_scm_info {
 
 int chsc_scm_info(struct chsc_scm_info *scm_area, u64 token);
 
-struct chsc_brinfo_resume_token {
-	u64 t1;
-	u64 t2;
-} __packed;
-
-struct chsc_brinfo_naihdr {
-	struct chsc_brinfo_resume_token resume_token;
-	u32:32;
-	u32 instance;
-	u32:24;
-	u8 naids;
-	u32 reserved[3];
-} __packed;
-
-struct chsc_pnso_area {
-	struct chsc_header request;
-	u8:2;
-	u8 m:1;
-	u8:5;
-	u8:2;
-	u8 ssid:2;
-	u8 fmt:4;
-	u16 sch;
-	u8:8;
-	u8 cssid;
-	u16:16;
-	u8 oc;
-	u32:24;
-	struct chsc_brinfo_resume_token resume_token;
-	u32 n:1;
-	u32:31;
-	u32 reserved[3];
-	struct chsc_header response;
-	u32:32;
-	struct chsc_brinfo_naihdr naihdr;
-	union {
-		struct qdio_brinfo_entry_l3_ipv6 l3_ipv6[0];
-		struct qdio_brinfo_entry_l3_ipv4 l3_ipv4[0];
-		struct qdio_brinfo_entry_l2	 l2[0];
-	} entries;
-} __packed __aligned(PAGE_SIZE);
-
-int chsc_pnso_brinfo(struct subchannel_id schid,
-		struct chsc_pnso_area *brinfo_area,
-		struct chsc_brinfo_resume_token resume_token,
-		int cnc);
+int chsc_pnso(struct subchannel_id schid,
+	      struct chsc_pnso_area *pnso_area,
+	      struct chsc_pnso_resume_token resume_token,
+	      int cnc);
 
 int __init chsc_get_cssid(int idx);
 
diff --git a/drivers/s390/cio/device_ops.c b/drivers/s390/cio/device_ops.c
index ccecf6b9504e..963fcc9054c6 100644
--- a/drivers/s390/cio/device_ops.c
+++ b/drivers/s390/cio/device_ops.c
@@ -710,6 +710,29 @@ void ccw_device_get_schid(struct ccw_device *cdev, struct subchannel_id *schid)
 }
 EXPORT_SYMBOL_GPL(ccw_device_get_schid);
 
+/**
+ * ccw_device_pnso() - Perform Network-Subchannel Operation
+ * @cdev:		device on which PNSO is performed
+ * @pnso_area:		request and response block for the operation
+ * @resume_token:	resume token for multiblock response
+ * @cnc:		Boolean change-notification control
+ *
+ * pnso_area must be allocated by the caller with get_zeroed_page(GFP_KERNEL)
+ *
+ * Returns 0 on success.
+ */
+int ccw_device_pnso(struct ccw_device *cdev,
+		    struct chsc_pnso_area *pnso_area,
+		    struct chsc_pnso_resume_token resume_token,
+		    int cnc)
+{
+	struct subchannel_id schid;
+
+	ccw_device_get_schid(cdev, &schid);
+	return chsc_pnso(schid, pnso_area, resume_token, cnc);
+}
+EXPORT_SYMBOL_GPL(ccw_device_pnso);
+
 /*
  * Allocate zeroed dma coherent 31 bit addressable memory using
  * the subchannels dma pool. Maximal size of allocation supported
diff --git a/drivers/s390/cio/idset.c b/drivers/s390/cio/idset.c
index 77d0ea7b381b..45f9c0736be4 100644
--- a/drivers/s390/cio/idset.c
+++ b/drivers/s390/cio/idset.c
@@ -59,18 +59,6 @@ static inline int idset_contains(struct idset *set, int ssid, int id)
 	return test_bit(ssid * set->num_id + id, set->bitmap);
 }
 
-static inline int idset_get_first(struct idset *set, int *ssid, int *id)
-{
-	int bitnum;
-
-	bitnum = find_first_bit(set->bitmap, set->num_ssid * set->num_id);
-	if (bitnum >= set->num_ssid * set->num_id)
-		return 0;
-	*ssid = bitnum / set->num_id;
-	*id = bitnum % set->num_id;
-	return 1;
-}
-
 struct idset *idset_sch_new(void)
 {
 	return idset_new(max_ssid + 1, __MAX_SUBCHANNEL + 1);
diff --git a/drivers/s390/cio/qdio.h b/drivers/s390/cio/qdio.h
index b8453b594679..eb13c479e11d 100644
--- a/drivers/s390/cio/qdio.h
+++ b/drivers/s390/cio/qdio.h
@@ -221,9 +221,6 @@ struct qdio_q {
 	 */
 	int first_to_check;
 
-	/* beginning position for calling the program */
-	int first_to_kick;
-
 	/* number of buffers in use by the adapter */
 	atomic_t nr_buf_used;
 
@@ -292,6 +289,8 @@ struct qdio_irq {
 
 	struct qdio_q *input_qs[QDIO_MAX_QUEUES_PER_IRQ];
 	struct qdio_q *output_qs[QDIO_MAX_QUEUES_PER_IRQ];
+	unsigned int max_input_qs;
+	unsigned int max_output_qs;
 
 	void (*irq_poll)(struct ccw_device *cdev, unsigned long data);
 	unsigned long poll_state;
@@ -364,16 +363,13 @@ static inline int multicast_outbound(struct qdio_q *q)
 extern u64 last_ai_time;
 
 /* prototypes for thin interrupt */
-void qdio_setup_thinint(struct qdio_irq *irq_ptr);
 int qdio_establish_thinint(struct qdio_irq *irq_ptr);
 void qdio_shutdown_thinint(struct qdio_irq *irq_ptr);
 void tiqdio_add_device(struct qdio_irq *irq_ptr);
 void tiqdio_remove_device(struct qdio_irq *irq_ptr);
 void tiqdio_inbound_processing(unsigned long q);
-int tiqdio_allocate_memory(void);
-void tiqdio_free_memory(void);
-int tiqdio_register_thinints(void);
-void tiqdio_unregister_thinints(void);
+int qdio_thinint_init(void);
+void qdio_thinint_exit(void);
 int test_nonshared_ind(struct qdio_irq *);
 
 /* prototypes for setup */
@@ -389,8 +385,10 @@ int qdio_setup_get_ssqd(struct qdio_irq *irq_ptr,
 			struct subchannel_id *schid,
 			struct qdio_ssqd_desc *data);
 int qdio_setup_irq(struct qdio_irq *irq_ptr, struct qdio_initialize *init_data);
+void qdio_shutdown_irq(struct qdio_irq *irq);
 void qdio_print_subchannel_info(struct qdio_irq *irq_ptr);
-void qdio_release_memory(struct qdio_irq *irq_ptr);
+void qdio_free_queues(struct qdio_irq *irq_ptr);
+void qdio_free_async_data(struct qdio_irq *irq_ptr);
 int qdio_setup_init(void);
 void qdio_setup_exit(void);
 int qdio_enable_async_operation(struct qdio_output_q *q);
diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
index bcc3ab14e72d..610c05f59589 100644
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -143,7 +143,7 @@ static int qdio_do_eqbs(struct qdio_q *q, unsigned char *state,
 		DBF_ERROR("%4x EQBS ERROR", SCH_NO(q));
 		DBF_ERROR("%3d%3d%2d", count, tmp_count, nr);
 		q->handler(q->irq_ptr->cdev, QDIO_ERROR_GET_BUF_STATE, q->nr,
-			   q->first_to_kick, count, q->irq_ptr->int_parm);
+			   q->first_to_check, count, q->irq_ptr->int_parm);
 		return 0;
 	}
 }
@@ -191,7 +191,7 @@ static int qdio_do_sqbs(struct qdio_q *q, unsigned char state, int start,
 		DBF_ERROR("%4x SQBS ERROR", SCH_NO(q));
 		DBF_ERROR("%3d%3d%2d", count, tmp_count, nr);
 		q->handler(q->irq_ptr->cdev, QDIO_ERROR_SET_BUF_STATE, q->nr,
-			   q->first_to_kick, count, q->irq_ptr->int_parm);
+			   q->first_to_check, count, q->irq_ptr->int_parm);
 		return 0;
 	}
 }
@@ -438,15 +438,12 @@ static void process_buffer_error(struct qdio_q *q, unsigned int start,
 		  q->sbal[start]->element[15].sflags);
 }
 
-static inline void inbound_primed(struct qdio_q *q, unsigned int start,
-				  int count)
+static inline void inbound_handle_work(struct qdio_q *q, unsigned int start,
+				       int count, bool auto_ack)
 {
 	int new;
 
-	DBF_DEV_EVENT(DBF_INFO, q->irq_ptr, "in prim:%1d %02x", q->nr, count);
-
-	/* for QEBSM the ACK was already set by EQBS */
-	if (is_qebsm(q)) {
+	if (auto_ack) {
 		if (!q->u.in.ack_count) {
 			q->u.in.ack_count = count;
 			q->u.in.ack_start = start;
@@ -466,15 +463,14 @@ static inline void inbound_primed(struct qdio_q *q, unsigned int start,
 	 * or by the next inbound run.
 	 */
 	new = add_buf(start, count - 1);
-	if (q->u.in.ack_count) {
-		/* reset the previous ACK but first set the new one */
-		set_buf_state(q, new, SLSB_P_INPUT_ACK);
-		set_buf_state(q, q->u.in.ack_start, SLSB_P_INPUT_NOT_INIT);
-	} else {
-		q->u.in.ack_count = 1;
-		set_buf_state(q, new, SLSB_P_INPUT_ACK);
-	}
+	set_buf_state(q, new, SLSB_P_INPUT_ACK);
+
+	/* delete the previous ACKs */
+	if (q->u.in.ack_count)
+		set_buf_states(q, q->u.in.ack_start, SLSB_P_INPUT_NOT_INIT,
+			       q->u.in.ack_count);
 
+	q->u.in.ack_count = 1;
 	q->u.in.ack_start = new;
 	count--;
 	if (!count)
@@ -508,19 +504,21 @@ static int get_inbound_buffer_frontier(struct qdio_q *q, unsigned int start)
 
 	switch (state) {
 	case SLSB_P_INPUT_PRIMED:
-		inbound_primed(q, start, count);
+		DBF_DEV_EVENT(DBF_INFO, q->irq_ptr, "in prim:%1d %02x", q->nr,
+			      count);
+
+		inbound_handle_work(q, start, count, is_qebsm(q));
 		if (atomic_sub_return(count, &q->nr_buf_used) == 0)
 			qperf_inc(q, inbound_queue_full);
 		if (q->irq_ptr->perf_stat_enabled)
 			account_sbals(q, count);
 		return count;
 	case SLSB_P_INPUT_ERROR:
+		DBF_DEV_EVENT(DBF_INFO, q->irq_ptr, "in err:%1d %02x", q->nr,
+			      count);
+
 		process_buffer_error(q, start, count);
-		/*
-		 * Interrupts may be avoided as long as the error is present
-		 * so change the buffer state immediately to avoid starvation.
-		 */
-		set_buf_states(q, start, SLSB_P_INPUT_NOT_INIT, count);
+		inbound_handle_work(q, start, count, false);
 		if (atomic_sub_return(count, &q->nr_buf_used) == 0)
 			qperf_inc(q, inbound_queue_full);
 		if (q->irq_ptr->perf_stat_enabled)
@@ -624,10 +622,9 @@ static inline unsigned long qdio_aob_for_buffer(struct qdio_output_q *q,
 	return phys_aob;
 }
 
-static void qdio_kick_handler(struct qdio_q *q, unsigned int count)
+static void qdio_kick_handler(struct qdio_q *q, unsigned int start,
+			      unsigned int count)
 {
-	int start = q->first_to_kick;
-
 	if (unlikely(q->irq_ptr->state != QDIO_IRQ_STATE_ACTIVE))
 		return;
 
@@ -644,7 +641,6 @@ static void qdio_kick_handler(struct qdio_q *q, unsigned int count)
 		   q->irq_ptr->int_parm);
 
 	/* for the next time */
-	q->first_to_kick = add_buf(start, count);
 	q->qdio_error = 0;
 }
 
@@ -668,9 +664,9 @@ static void __qdio_inbound_processing(struct qdio_q *q)
 	if (count == 0)
 		return;
 
+	qdio_kick_handler(q, start, count);
 	start = add_buf(start, count);
 	q->first_to_check = start;
-	qdio_kick_handler(q, count);
 
 	if (!qdio_inbound_q_done(q, start)) {
 		/* means poll time is not yet over */
@@ -826,7 +822,7 @@ static void __qdio_outbound_processing(struct qdio_q *q)
 	count = qdio_outbound_q_moved(q, start);
 	if (count) {
 		q->first_to_check = add_buf(start, count);
-		qdio_kick_handler(q, count);
+		qdio_kick_handler(q, start, count);
 	}
 
 	if (queue_type(q) == QDIO_ZFCP_QFMT && !pci_out_supported(q->irq_ptr) &&
@@ -880,47 +876,17 @@ static inline void qdio_check_outbound_pci_queues(struct qdio_irq *irq)
 			qdio_tasklet_schedule(out);
 }
 
-static void __tiqdio_inbound_processing(struct qdio_q *q)
+void tiqdio_inbound_processing(unsigned long data)
 {
-	unsigned int start = q->first_to_check;
-	int count;
+	struct qdio_q *q = (struct qdio_q *)data;
 
-	qperf_inc(q, tasklet_inbound);
 	if (need_siga_sync(q) && need_siga_sync_after_ai(q))
 		qdio_sync_queues(q);
 
 	/* The interrupt could be caused by a PCI request: */
 	qdio_check_outbound_pci_queues(q->irq_ptr);
 
-	count = qdio_inbound_q_moved(q, start);
-	if (count == 0)
-		return;
-
-	start = add_buf(start, count);
-	q->first_to_check = start;
-	qdio_kick_handler(q, count);
-
-	if (!qdio_inbound_q_done(q, start)) {
-		qperf_inc(q, tasklet_inbound_resched);
-		if (!qdio_tasklet_schedule(q))
-			return;
-	}
-
-	qdio_stop_polling(q);
-	/*
-	 * We need to check again to not lose initiative after
-	 * resetting the ACK state.
-	 */
-	if (!qdio_inbound_q_done(q, start)) {
-		qperf_inc(q, tasklet_inbound_resched2);
-		qdio_tasklet_schedule(q);
-	}
-}
-
-void tiqdio_inbound_processing(unsigned long data)
-{
-	struct qdio_q *q = (struct qdio_q *)data;
-	__tiqdio_inbound_processing(q);
+	__qdio_inbound_processing(q);
 }
 
 static inline void qdio_set_state(struct qdio_irq *irq_ptr,
@@ -977,7 +943,6 @@ static void qdio_handle_activate_check(struct ccw_device *cdev,
 {
 	struct qdio_irq *irq_ptr = cdev->private->qdio_data;
 	struct qdio_q *q;
-	int count;
 
 	DBF_ERROR("%4x ACT CHECK", irq_ptr->schid.sch_no);
 	DBF_ERROR("intp :%lx", intparm);
@@ -992,9 +957,8 @@ static void qdio_handle_activate_check(struct ccw_device *cdev,
 		goto no_handler;
 	}
 
-	count = sub_buf(q->first_to_check, q->first_to_kick);
 	q->handler(q->irq_ptr->cdev, QDIO_ERROR_ACTIVATE,
-		   q->nr, q->first_to_kick, count, irq_ptr->int_parm);
+		   q->nr, q->first_to_check, 0, irq_ptr->int_parm);
 no_handler:
 	qdio_set_state(irq_ptr, QDIO_IRQ_STATE_STOPPED);
 	/*
@@ -1154,35 +1118,27 @@ int qdio_shutdown(struct ccw_device *cdev, int how)
 
 	/* cleanup subchannel */
 	spin_lock_irq(get_ccwdev_lock(cdev));
-
+	qdio_set_state(irq_ptr, QDIO_IRQ_STATE_CLEANUP);
 	if (how & QDIO_FLAG_CLEANUP_USING_CLEAR)
 		rc = ccw_device_clear(cdev, QDIO_DOING_CLEANUP);
 	else
 		/* default behaviour is halt */
 		rc = ccw_device_halt(cdev, QDIO_DOING_CLEANUP);
+	spin_unlock_irq(get_ccwdev_lock(cdev));
 	if (rc) {
 		DBF_ERROR("%4x SHUTD ERR", irq_ptr->schid.sch_no);
 		DBF_ERROR("rc:%4d", rc);
 		goto no_cleanup;
 	}
 
-	qdio_set_state(irq_ptr, QDIO_IRQ_STATE_CLEANUP);
-	spin_unlock_irq(get_ccwdev_lock(cdev));
 	wait_event_interruptible_timeout(cdev->private->wait_q,
 		irq_ptr->state == QDIO_IRQ_STATE_INACTIVE ||
 		irq_ptr->state == QDIO_IRQ_STATE_ERR,
 		10 * HZ);
-	spin_lock_irq(get_ccwdev_lock(cdev));
 
 no_cleanup:
 	qdio_shutdown_thinint(irq_ptr);
-
-	/* restore interrupt handler */
-	if ((void *)cdev->handler == (void *)qdio_int_handler) {
-		cdev->handler = irq_ptr->orig_handler;
-		cdev->private->intparm = 0;
-	}
-	spin_unlock_irq(get_ccwdev_lock(cdev));
+	qdio_shutdown_irq(irq_ptr);
 
 	qdio_set_state(irq_ptr, QDIO_IRQ_STATE_INACTIVE);
 	mutex_unlock(&irq_ptr->setup_mutex);
@@ -1213,7 +1169,11 @@ int qdio_free(struct ccw_device *cdev)
 	cdev->private->qdio_data = NULL;
 	mutex_unlock(&irq_ptr->setup_mutex);
 
-	qdio_release_memory(irq_ptr);
+	qdio_free_async_data(irq_ptr);
+	qdio_free_queues(irq_ptr);
+	free_page((unsigned long) irq_ptr->qdr);
+	free_page(irq_ptr->chsc_page);
+	free_page((unsigned long) irq_ptr);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(qdio_free);
@@ -1229,6 +1189,7 @@ int qdio_allocate(struct ccw_device *cdev, unsigned int no_input_qs,
 {
 	struct subchannel_id schid;
 	struct qdio_irq *irq_ptr;
+	int rc = -ENOMEM;
 
 	ccw_device_get_schid(cdev, &schid);
 	DBF_EVENT("qallocate:%4x", schid.sch_no);
@@ -1240,12 +1201,12 @@ int qdio_allocate(struct ccw_device *cdev, unsigned int no_input_qs,
 	/* irq_ptr must be in GFP_DMA since it contains ccw1.cda */
 	irq_ptr = (void *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!irq_ptr)
-		goto out_err;
+		return -ENOMEM;
 
 	irq_ptr->cdev = cdev;
 	mutex_init(&irq_ptr->setup_mutex);
 	if (qdio_allocate_dbf(irq_ptr))
-		goto out_rel;
+		goto err_dbf;
 
 	DBF_DEV_EVENT(DBF_ERR, irq_ptr, "alloc niq:%1u noq:%1u", no_input_qs,
 		      no_output_qs);
@@ -1258,24 +1219,30 @@ int qdio_allocate(struct ccw_device *cdev, unsigned int no_input_qs,
 	 */
 	irq_ptr->chsc_page = get_zeroed_page(GFP_KERNEL);
 	if (!irq_ptr->chsc_page)
-		goto out_rel;
+		goto err_chsc;
 
 	/* qdr is used in ccw1.cda which is u32 */
 	irq_ptr->qdr = (struct qdr *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!irq_ptr->qdr)
-		goto out_rel;
+		goto err_qdr;
 
-	if (qdio_allocate_qs(irq_ptr, no_input_qs, no_output_qs))
-		goto out_rel;
+	rc = qdio_allocate_qs(irq_ptr, no_input_qs, no_output_qs);
+	if (rc)
+		goto err_queues;
 
 	INIT_LIST_HEAD(&irq_ptr->entry);
 	cdev->private->qdio_data = irq_ptr;
 	qdio_set_state(irq_ptr, QDIO_IRQ_STATE_INACTIVE);
 	return 0;
-out_rel:
-	qdio_release_memory(irq_ptr);
-out_err:
-	return -ENOMEM;
+
+err_queues:
+	free_page((unsigned long) irq_ptr->qdr);
+err_qdr:
+	free_page(irq_ptr->chsc_page);
+err_chsc:
+err_dbf:
+	free_page((unsigned long) irq_ptr);
+	return rc;
 }
 EXPORT_SYMBOL_GPL(qdio_allocate);
 
@@ -1338,6 +1305,10 @@ int qdio_establish(struct ccw_device *cdev,
 	if (!irq_ptr)
 		return -ENODEV;
 
+	if (init_data->no_input_qs > irq_ptr->max_input_qs ||
+	    init_data->no_output_qs > irq_ptr->max_output_qs)
+		return -EINVAL;
+
 	if ((init_data->no_input_qs && !init_data->input_handler) ||
 	    (init_data->no_output_qs && !init_data->output_handler))
 		return -EINVAL;
@@ -1352,8 +1323,8 @@ int qdio_establish(struct ccw_device *cdev,
 
 	rc = qdio_establish_thinint(irq_ptr);
 	if (rc) {
+		qdio_shutdown_irq(irq_ptr);
 		mutex_unlock(&irq_ptr->setup_mutex);
-		qdio_shutdown(cdev, QDIO_FLAG_CLEANUP_USING_CLEAR);
 		return rc;
 	}
 
@@ -1371,8 +1342,9 @@ int qdio_establish(struct ccw_device *cdev,
 	if (rc) {
 		DBF_ERROR("%4x est IO ERR", irq_ptr->schid.sch_no);
 		DBF_ERROR("rc:%4x", rc);
+		qdio_shutdown_thinint(irq_ptr);
+		qdio_shutdown_irq(irq_ptr);
 		mutex_unlock(&irq_ptr->setup_mutex);
-		qdio_shutdown(cdev, QDIO_FLAG_CLEANUP_USING_CLEAR);
 		return rc;
 	}
 
@@ -1460,25 +1432,6 @@ int qdio_activate(struct ccw_device *cdev)
 }
 EXPORT_SYMBOL_GPL(qdio_activate);
 
-static inline int buf_in_between(int bufnr, int start, int count)
-{
-	int end = add_buf(start, count);
-
-	if (end > start) {
-		if (bufnr >= start && bufnr < end)
-			return 1;
-		else
-			return 0;
-	}
-
-	/* wrap-around case */
-	if ((bufnr >= start && bufnr <= QDIO_MAX_BUFFERS_PER_Q) ||
-	    (bufnr < end))
-		return 1;
-	else
-		return 0;
-}
-
 /**
  * handle_inbound - reset processed input buffers
  * @q: queue containing the buffers
@@ -1489,36 +1442,18 @@ static inline int buf_in_between(int bufnr, int start, int count)
 static int handle_inbound(struct qdio_q *q, unsigned int callflags,
 			  int bufnr, int count)
 {
-	int diff;
+	int overlap;
 
 	qperf_inc(q, inbound_call);
 
-	if (!q->u.in.ack_count)
-		goto set;
-
-	/* protect against stop polling setting an ACK for an emptied slsb */
-	if (count == QDIO_MAX_BUFFERS_PER_Q) {
-		/* overwriting everything, just delete polling status */
-		q->u.in.ack_count = 0;
-		goto set;
-	} else if (buf_in_between(q->u.in.ack_start, bufnr, count)) {
-		if (is_qebsm(q)) {
-			/* partial overwrite, just update ack_start */
-			diff = add_buf(bufnr, count);
-			diff = sub_buf(diff, q->u.in.ack_start);
-			q->u.in.ack_count -= diff;
-			if (q->u.in.ack_count <= 0) {
-				q->u.in.ack_count = 0;
-				goto set;
-			}
-			q->u.in.ack_start = add_buf(q->u.in.ack_start, diff);
-		} else {
-			/* the only ACK will be deleted */
-			q->u.in.ack_count = 0;
-		}
+	/* If any ACKed SBALs are returned to HW, adjust ACK tracking: */
+	overlap = min(count - sub_buf(q->u.in.ack_start, bufnr),
+		      q->u.in.ack_count);
+	if (overlap > 0) {
+		q->u.in.ack_start = add_buf(q->u.in.ack_start, overlap);
+		q->u.in.ack_count -= overlap;
 	}
 
-set:
 	count = set_buf_states(q, bufnr, SLSB_CU_INPUT_EMPTY, count);
 	atomic_add(count, &q->nr_buf_used);
 
@@ -1627,7 +1562,7 @@ int do_QDIO(struct ccw_device *cdev, unsigned int callflags,
 EXPORT_SYMBOL_GPL(do_QDIO);
 
 /**
- * qdio_start_irq - process input buffers
+ * qdio_start_irq - enable interrupt processing for the device
  * @cdev: associated ccw_device for the qdio subchannel
  *
  * Return codes
@@ -1770,94 +1705,6 @@ int qdio_stop_irq(struct ccw_device *cdev)
 }
 EXPORT_SYMBOL(qdio_stop_irq);
 
-/**
- * qdio_pnso_brinfo() - perform network subchannel op #0 - bridge info.
- * @schid:		Subchannel ID.
- * @cnc:		Boolean Change-Notification Control
- * @response:		Response code will be stored at this address
- * @cb: 		Callback function will be executed for each element
- *			of the address list
- * @priv:		Pointer to pass to the callback function.
- *
- * Performs "Store-network-bridging-information list" operation and calls
- * the callback function for every entry in the list. If "change-
- * notification-control" is set, further changes in the address list
- * will be reported via the IPA command.
- */
-int qdio_pnso_brinfo(struct subchannel_id schid,
-		int cnc, u16 *response,
-		void (*cb)(void *priv, enum qdio_brinfo_entry_type type,
-				void *entry),
-		void *priv)
-{
-	struct chsc_pnso_area *rr;
-	int rc;
-	u32 prev_instance = 0;
-	int isfirstblock = 1;
-	int i, size, elems;
-
-	rr = (struct chsc_pnso_area *)get_zeroed_page(GFP_KERNEL);
-	if (rr == NULL)
-		return -ENOMEM;
-	do {
-		/* on the first iteration, naihdr.resume_token will be zero */
-		rc = chsc_pnso_brinfo(schid, rr, rr->naihdr.resume_token, cnc);
-		if (rc != 0 && rc != -EBUSY)
-			goto out;
-		if (rr->response.code != 1) {
-			rc = -EIO;
-			continue;
-		} else
-			rc = 0;
-
-		if (cb == NULL)
-			continue;
-
-		size = rr->naihdr.naids;
-		elems = (rr->response.length -
-				sizeof(struct chsc_header) -
-				sizeof(struct chsc_brinfo_naihdr)) /
-				size;
-
-		if (!isfirstblock && (rr->naihdr.instance != prev_instance)) {
-			/* Inform the caller that they need to scrap */
-			/* the data that was already reported via cb */
-				rc = -EAGAIN;
-				break;
-		}
-		isfirstblock = 0;
-		prev_instance = rr->naihdr.instance;
-		for (i = 0; i < elems; i++)
-			switch (size) {
-			case sizeof(struct qdio_brinfo_entry_l3_ipv6):
-				(*cb)(priv, l3_ipv6_addr,
-						&rr->entries.l3_ipv6[i]);
-				break;
-			case sizeof(struct qdio_brinfo_entry_l3_ipv4):
-				(*cb)(priv, l3_ipv4_addr,
-						&rr->entries.l3_ipv4[i]);
-				break;
-			case sizeof(struct qdio_brinfo_entry_l2):
-				(*cb)(priv, l2_addr_lnid,
-						&rr->entries.l2[i]);
-				break;
-			default:
-				WARN_ON_ONCE(1);
-				rc = -EIO;
-				goto out;
-			}
-	} while (rr->response.code == 0x0107 ||  /* channel busy */
-		  (rr->response.code == 1 && /* list stored */
-		   /* resume token is non-zero => list incomplete */
-		   (rr->naihdr.resume_token.t1 || rr->naihdr.resume_token.t2)));
-	(*response) = rr->response.code;
-
-out:
-	free_page((unsigned long)rr);
-	return rc;
-}
-EXPORT_SYMBOL_GPL(qdio_pnso_brinfo);
-
 static int __init init_QDIO(void)
 {
 	int rc;
@@ -1868,16 +1715,11 @@ static int __init init_QDIO(void)
 	rc = qdio_setup_init();
 	if (rc)
 		goto out_debug;
-	rc = tiqdio_allocate_memory();
+	rc = qdio_thinint_init();
 	if (rc)
 		goto out_cache;
-	rc = tiqdio_register_thinints();
-	if (rc)
-		goto out_ti;
 	return 0;
 
-out_ti:
-	tiqdio_free_memory();
 out_cache:
 	qdio_setup_exit();
 out_debug:
@@ -1887,8 +1729,7 @@ static int __init init_QDIO(void)
 
 static void __exit exit_QDIO(void)
 {
-	tiqdio_unregister_thinints();
-	tiqdio_free_memory();
+	qdio_thinint_exit();
 	qdio_setup_exit();
 	qdio_debug_exit();
 }
diff --git a/drivers/s390/cio/qdio_setup.c b/drivers/s390/cio/qdio_setup.c
index 3083edd61f0c..2c5cc6ec668e 100644
--- a/drivers/s390/cio/qdio_setup.c
+++ b/drivers/s390/cio/qdio_setup.c
@@ -135,6 +135,27 @@ static void set_impl_params(struct qdio_irq *irq_ptr,
 	}
 }
 
+static void __qdio_free_queues(struct qdio_q **queues, unsigned int count)
+{
+	struct qdio_q *q;
+	unsigned int i;
+
+	for (i = 0; i < count; i++) {
+		q = queues[i];
+		free_page((unsigned long) q->slib);
+		kmem_cache_free(qdio_q_cache, q);
+	}
+}
+
+void qdio_free_queues(struct qdio_irq *irq_ptr)
+{
+	__qdio_free_queues(irq_ptr->input_qs, irq_ptr->max_input_qs);
+	irq_ptr->max_input_qs = 0;
+
+	__qdio_free_queues(irq_ptr->output_qs, irq_ptr->max_output_qs);
+	irq_ptr->max_output_qs = 0;
+}
+
 static int __qdio_allocate_qs(struct qdio_q **irq_ptr_qs, int nr_queues)
 {
 	struct qdio_q *q;
@@ -142,12 +163,15 @@ static int __qdio_allocate_qs(struct qdio_q **irq_ptr_qs, int nr_queues)
 
 	for (i = 0; i < nr_queues; i++) {
 		q = kmem_cache_zalloc(qdio_q_cache, GFP_KERNEL);
-		if (!q)
+		if (!q) {
+			__qdio_free_queues(irq_ptr_qs, i);
 			return -ENOMEM;
+		}
 
 		q->slib = (struct slib *) __get_free_page(GFP_KERNEL);
 		if (!q->slib) {
 			kmem_cache_free(qdio_q_cache, q);
+			__qdio_free_queues(irq_ptr_qs, i);
 			return -ENOMEM;
 		}
 		irq_ptr_qs[i] = q;
@@ -162,8 +186,16 @@ int qdio_allocate_qs(struct qdio_irq *irq_ptr, int nr_input_qs, int nr_output_qs
 	rc = __qdio_allocate_qs(irq_ptr->input_qs, nr_input_qs);
 	if (rc)
 		return rc;
+
 	rc = __qdio_allocate_qs(irq_ptr->output_qs, nr_output_qs);
-	return rc;
+	if (rc) {
+		__qdio_free_queues(irq_ptr->input_qs, nr_input_qs);
+		return rc;
+	}
+
+	irq_ptr->max_input_qs = nr_input_qs;
+	irq_ptr->max_output_qs = nr_output_qs;
+	return 0;
 }
 
 static void setup_queues_misc(struct qdio_q *q, struct qdio_irq *irq_ptr,
@@ -347,45 +379,28 @@ void qdio_setup_ssqd_info(struct qdio_irq *irq_ptr)
 	DBF_EVENT("3:%4x qib:%4x", irq_ptr->ssqd_desc.qdioac3, irq_ptr->qib.ac);
 }
 
-void qdio_release_memory(struct qdio_irq *irq_ptr)
+void qdio_free_async_data(struct qdio_irq *irq_ptr)
 {
 	struct qdio_q *q;
 	int i;
 
-	/*
-	 * Must check queue array manually since irq_ptr->nr_input_queues /
-	 * irq_ptr->nr_input_queues may not yet be set.
-	 */
-	for (i = 0; i < QDIO_MAX_QUEUES_PER_IRQ; i++) {
-		q = irq_ptr->input_qs[i];
-		if (q) {
-			free_page((unsigned long) q->slib);
-			kmem_cache_free(qdio_q_cache, q);
-		}
-	}
-	for (i = 0; i < QDIO_MAX_QUEUES_PER_IRQ; i++) {
+	for (i = 0; i < irq_ptr->max_output_qs; i++) {
 		q = irq_ptr->output_qs[i];
-		if (q) {
-			if (q->u.out.use_cq) {
-				int n;
-
-				for (n = 0; n < QDIO_MAX_BUFFERS_PER_Q; ++n) {
-					struct qaob *aob = q->u.out.aobs[n];
-					if (aob) {
-						qdio_release_aob(aob);
-						q->u.out.aobs[n] = NULL;
-					}
-				}
+		if (q->u.out.use_cq) {
+			unsigned int n;
+
+			for (n = 0; n < QDIO_MAX_BUFFERS_PER_Q; n++) {
+				struct qaob *aob = q->u.out.aobs[n];
 
-				qdio_disable_async_operation(&q->u.out);
+				if (aob) {
+					qdio_release_aob(aob);
+					q->u.out.aobs[n] = NULL;
+				}
 			}
-			free_page((unsigned long) q->slib);
-			kmem_cache_free(qdio_q_cache, q);
+
+			qdio_disable_async_operation(&q->u.out);
 		}
 	}
-	free_page((unsigned long) irq_ptr->qdr);
-	free_page(irq_ptr->chsc_page);
-	free_page((unsigned long) irq_ptr);
 }
 
 static void __qdio_allocate_fill_qdr(struct qdio_irq *irq_ptr,
@@ -480,7 +495,6 @@ int qdio_setup_irq(struct qdio_irq *irq_ptr, struct qdio_initialize *init_data)
 	}
 
 	setup_qib(irq_ptr, init_data);
-	qdio_setup_thinint(irq_ptr);
 	set_impl_params(irq_ptr, init_data->qib_param_field_format,
 			init_data->qib_param_field,
 			init_data->input_slib_elements,
@@ -491,6 +505,12 @@ int qdio_setup_irq(struct qdio_irq *irq_ptr, struct qdio_initialize *init_data)
 
 	/* qdr, qib, sls, slsbs, slibs, sbales are filled now */
 
+	/* set our IRQ handler */
+	spin_lock_irq(get_ccwdev_lock(cdev));
+	irq_ptr->orig_handler = cdev->handler;
+	cdev->handler = qdio_int_handler;
+	spin_unlock_irq(get_ccwdev_lock(cdev));
+
 	/* get qdio commands */
 	ciw = ccw_device_get_ciw(cdev, CIW_TYPE_EQUEUE);
 	if (!ciw) {
@@ -506,12 +526,18 @@ int qdio_setup_irq(struct qdio_irq *irq_ptr, struct qdio_initialize *init_data)
 	}
 	irq_ptr->aqueue = *ciw;
 
-	/* set new interrupt handler */
+	return 0;
+}
+
+void qdio_shutdown_irq(struct qdio_irq *irq)
+{
+	struct ccw_device *cdev = irq->cdev;
+
+	/* restore IRQ handler */
 	spin_lock_irq(get_ccwdev_lock(cdev));
-	irq_ptr->orig_handler = cdev->handler;
-	cdev->handler = qdio_int_handler;
+	cdev->handler = irq->orig_handler;
+	cdev->private->intparm = 0;
 	spin_unlock_irq(get_ccwdev_lock(cdev));
-	return 0;
 }
 
 void qdio_print_subchannel_info(struct qdio_irq *irq_ptr)
diff --git a/drivers/s390/cio/qdio_thinint.c b/drivers/s390/cio/qdio_thinint.c
index ae50373617cd..7a440e4328cd 100644
--- a/drivers/s390/cio/qdio_thinint.c
+++ b/drivers/s390/cio/qdio_thinint.c
@@ -197,47 +197,21 @@ static int set_subchannel_ind(struct qdio_irq *irq_ptr, int reset)
 	return rc;
 }
 
-/* allocate non-shared indicators and shared indicator */
-int __init tiqdio_allocate_memory(void)
-{
-	q_indicators = kcalloc(TIQDIO_NR_INDICATORS,
-			       sizeof(struct indicator_t),
-			       GFP_KERNEL);
-	if (!q_indicators)
-		return -ENOMEM;
-	return 0;
-}
-
-void tiqdio_free_memory(void)
-{
-	kfree(q_indicators);
-}
-
-int __init tiqdio_register_thinints(void)
+int qdio_establish_thinint(struct qdio_irq *irq_ptr)
 {
 	int rc;
 
-	rc = register_adapter_interrupt(&tiqdio_airq);
-	if (rc) {
-		DBF_EVENT("RTI:%x", rc);
-		return rc;
-	}
-	return 0;
-}
-
-int qdio_establish_thinint(struct qdio_irq *irq_ptr)
-{
 	if (!is_thinint_irq(irq_ptr))
 		return 0;
-	return set_subchannel_ind(irq_ptr, 0);
-}
 
-void qdio_setup_thinint(struct qdio_irq *irq_ptr)
-{
-	if (!is_thinint_irq(irq_ptr))
-		return;
 	irq_ptr->dsci = get_indicator();
 	DBF_HEX(&irq_ptr->dsci, sizeof(void *));
+
+	rc = set_subchannel_ind(irq_ptr, 0);
+	if (rc)
+		put_indicator(irq_ptr->dsci);
+
+	return rc;
 }
 
 void qdio_shutdown_thinint(struct qdio_irq *irq_ptr)
@@ -250,8 +224,27 @@ void qdio_shutdown_thinint(struct qdio_irq *irq_ptr)
 	put_indicator(irq_ptr->dsci);
 }
 
-void __exit tiqdio_unregister_thinints(void)
+int __init qdio_thinint_init(void)
+{
+	int rc;
+
+	q_indicators = kcalloc(TIQDIO_NR_INDICATORS, sizeof(struct indicator_t),
+			       GFP_KERNEL);
+	if (!q_indicators)
+		return -ENOMEM;
+
+	rc = register_adapter_interrupt(&tiqdio_airq);
+	if (rc) {
+		DBF_EVENT("RTI:%x", rc);
+		kfree(q_indicators);
+		return rc;
+	}
+	return 0;
+}
+
+void __exit qdio_thinint_exit(void)
 {
 	WARN_ON(!list_empty(&tiq_list));
 	unregister_adapter_interrupt(&tiqdio_airq);
+	kfree(q_indicators);
 }
diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_chp.c
new file mode 100644
index 000000000000..a646fc81c872
--- /dev/null
+++ b/drivers/s390/cio/vfio_ccw_chp.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Channel path related status regions for vfio_ccw
+ *
+ * Copyright IBM Corp. 2020
+ *
+ * Author(s): Farhan Ali <alifm@linux.ibm.com>
+ *            Eric Farman <farman@linux.ibm.com>
+ */
+
+#include <linux/vfio.h>
+#include "vfio_ccw_private.h"
+
+static ssize_t vfio_ccw_schib_region_read(struct vfio_ccw_private *private,
+					  char __user *buf, size_t count,
+					  loff_t *ppos)
+{
+	unsigned int i = VFIO_CCW_OFFSET_TO_INDEX(*ppos) - VFIO_CCW_NUM_REGIONS;
+	loff_t pos = *ppos & VFIO_CCW_OFFSET_MASK;
+	struct ccw_schib_region *region;
+	int ret;
+
+	if (pos + count > sizeof(*region))
+		return -EINVAL;
+
+	mutex_lock(&private->io_mutex);
+	region = private->region[i].data;
+
+	if (cio_update_schib(private->sch)) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	memcpy(region, &private->sch->schib, sizeof(*region));
+
+	if (copy_to_user(buf, (void *)region + pos, count)) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	ret = count;
+
+out:
+	mutex_unlock(&private->io_mutex);
+	return ret;
+}
+
+static ssize_t vfio_ccw_schib_region_write(struct vfio_ccw_private *private,
+					   const char __user *buf, size_t count,
+					   loff_t *ppos)
+{
+	return -EINVAL;
+}
+
+
+static void vfio_ccw_schib_region_release(struct vfio_ccw_private *private,
+					  struct vfio_ccw_region *region)
+{
+
+}
+
+static const struct vfio_ccw_regops vfio_ccw_schib_region_ops = {
+	.read = vfio_ccw_schib_region_read,
+	.write = vfio_ccw_schib_region_write,
+	.release = vfio_ccw_schib_region_release,
+};
+
+int vfio_ccw_register_schib_dev_regions(struct vfio_ccw_private *private)
+{
+	return vfio_ccw_register_dev_region(private,
+					    VFIO_REGION_SUBTYPE_CCW_SCHIB,
+					    &vfio_ccw_schib_region_ops,
+					    sizeof(struct ccw_schib_region),
+					    VFIO_REGION_INFO_FLAG_READ,
+					    private->schib_region);
+}
+
+static ssize_t vfio_ccw_crw_region_read(struct vfio_ccw_private *private,
+					char __user *buf, size_t count,
+					loff_t *ppos)
+{
+	unsigned int i = VFIO_CCW_OFFSET_TO_INDEX(*ppos) - VFIO_CCW_NUM_REGIONS;
+	loff_t pos = *ppos & VFIO_CCW_OFFSET_MASK;
+	struct ccw_crw_region *region;
+	struct vfio_ccw_crw *crw;
+	int ret;
+
+	if (pos + count > sizeof(*region))
+		return -EINVAL;
+
+	crw = list_first_entry_or_null(&private->crw,
+				       struct vfio_ccw_crw, next);
+
+	if (crw)
+		list_del(&crw->next);
+
+	mutex_lock(&private->io_mutex);
+	region = private->region[i].data;
+
+	if (crw)
+		memcpy(&region->crw, &crw->crw, sizeof(region->crw));
+
+	if (copy_to_user(buf, (void *)region + pos, count))
+		ret = -EFAULT;
+	else
+		ret = count;
+
+	region->crw = 0;
+
+	mutex_unlock(&private->io_mutex);
+
+	kfree(crw);
+
+	/* Notify the guest if more CRWs are on our queue */
+	if (!list_empty(&private->crw) && private->crw_trigger)
+		eventfd_signal(private->crw_trigger, 1);
+
+	return ret;
+}
+
+static ssize_t vfio_ccw_crw_region_write(struct vfio_ccw_private *private,
+					 const char __user *buf, size_t count,
+					 loff_t *ppos)
+{
+	return -EINVAL;
+}
+
+static void vfio_ccw_crw_region_release(struct vfio_ccw_private *private,
+					struct vfio_ccw_region *region)
+{
+
+}
+
+static const struct vfio_ccw_regops vfio_ccw_crw_region_ops = {
+	.read = vfio_ccw_crw_region_read,
+	.write = vfio_ccw_crw_region_write,
+	.release = vfio_ccw_crw_region_release,
+};
+
+int vfio_ccw_register_crw_dev_regions(struct vfio_ccw_private *private)
+{
+	return vfio_ccw_register_dev_region(private,
+					    VFIO_REGION_SUBTYPE_CCW_CRW,
+					    &vfio_ccw_crw_region_ops,
+					    sizeof(struct ccw_crw_region),
+					    VFIO_REGION_INFO_FLAG_READ,
+					    private->crw_region);
+}
diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 3645d1720c4b..b9febc581b1f 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -8,6 +8,7 @@
  *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
  */
 
+#include <linux/ratelimit.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/iommu.h>
@@ -625,23 +626,27 @@ static int ccwchain_fetch_one(struct ccwchain *chain,
  * the target channel program from @orb->cmd.iova to the new ccwchain(s).
  *
  * Limitations:
- * 1. Supports only prefetch enabled mode.
- * 2. Supports idal(c64) ccw chaining.
- * 3. Supports 4k idaw.
+ * 1. Supports idal(c64) ccw chaining.
+ * 2. Supports 4k idaw.
  *
  * Returns:
  *   %0 on success and a negative error value on failure.
  */
 int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
 {
+	/* custom ratelimit used to avoid flood during guest IPL */
+	static DEFINE_RATELIMIT_STATE(ratelimit_state, 5 * HZ, 1);
 	int ret;
 
 	/*
-	 * XXX:
-	 * Only support prefetch enable mode now.
+	 * We only support prefetching the channel program. We assume all channel
+	 * programs executed by supported guests likewise support prefetching.
+	 * Executing a channel program that does not specify prefetching will
+	 * typically not cause an error, but a warning is issued to help identify
+	 * the problem if something does break.
 	 */
-	if (!orb->cmd.pfch)
-		return -EOPNOTSUPP;
+	if (!orb->cmd.pfch && __ratelimit(&ratelimit_state))
+		dev_warn(mdev, "Prefetching channel program even though prefetch not specified in ORB");
 
 	INIT_LIST_HEAD(&cp->ccwchain_list);
 	memcpy(&cp->orb, orb, sizeof(*orb));
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 339a6bc0339b..8c625b530035 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -19,6 +19,7 @@
 
 #include <asm/isc.h>
 
+#include "chp.h"
 #include "ioasm.h"
 #include "css.h"
 #include "vfio_ccw_private.h"
@@ -26,6 +27,8 @@
 struct workqueue_struct *vfio_ccw_work_q;
 static struct kmem_cache *vfio_ccw_io_region;
 static struct kmem_cache *vfio_ccw_cmd_region;
+static struct kmem_cache *vfio_ccw_schib_region;
+static struct kmem_cache *vfio_ccw_crw_region;
 
 debug_info_t *vfio_ccw_debug_msg_id;
 debug_info_t *vfio_ccw_debug_trace_id;
@@ -105,6 +108,16 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 		eventfd_signal(private->io_trigger, 1);
 }
 
+static void vfio_ccw_crw_todo(struct work_struct *work)
+{
+	struct vfio_ccw_private *private;
+
+	private = container_of(work, struct vfio_ccw_private, crw_work);
+
+	if (!list_empty(&private->crw) && private->crw_trigger)
+		eventfd_signal(private->crw_trigger, 1);
+}
+
 /*
  * Css driver callbacks
  */
@@ -116,6 +129,18 @@ static void vfio_ccw_sch_irq(struct subchannel *sch)
 	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_INTERRUPT);
 }
 
+static void vfio_ccw_free_regions(struct vfio_ccw_private *private)
+{
+	if (private->crw_region)
+		kmem_cache_free(vfio_ccw_crw_region, private->crw_region);
+	if (private->schib_region)
+		kmem_cache_free(vfio_ccw_schib_region, private->schib_region);
+	if (private->cmd_region)
+		kmem_cache_free(vfio_ccw_cmd_region, private->cmd_region);
+	if (private->io_region)
+		kmem_cache_free(vfio_ccw_io_region, private->io_region);
+}
+
 static int vfio_ccw_sch_probe(struct subchannel *sch)
 {
 	struct pmcw *pmcw = &sch->schib.pmcw;
@@ -147,6 +172,18 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 	if (!private->cmd_region)
 		goto out_free;
 
+	private->schib_region = kmem_cache_zalloc(vfio_ccw_schib_region,
+						  GFP_KERNEL | GFP_DMA);
+
+	if (!private->schib_region)
+		goto out_free;
+
+	private->crw_region = kmem_cache_zalloc(vfio_ccw_crw_region,
+						GFP_KERNEL | GFP_DMA);
+
+	if (!private->crw_region)
+		goto out_free;
+
 	private->sch = sch;
 	dev_set_drvdata(&sch->dev, private);
 	mutex_init(&private->io_mutex);
@@ -159,7 +196,9 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 	if (ret)
 		goto out_free;
 
+	INIT_LIST_HEAD(&private->crw);
 	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
+	INIT_WORK(&private->crw_work, vfio_ccw_crw_todo);
 	atomic_set(&private->avail, 1);
 	private->state = VFIO_CCW_STATE_STANDBY;
 
@@ -181,10 +220,7 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 	cio_disable_subchannel(sch);
 out_free:
 	dev_set_drvdata(&sch->dev, NULL);
-	if (private->cmd_region)
-		kmem_cache_free(vfio_ccw_cmd_region, private->cmd_region);
-	if (private->io_region)
-		kmem_cache_free(vfio_ccw_io_region, private->io_region);
+	vfio_ccw_free_regions(private);
 	kfree(private->cp.guest_cp);
 	kfree(private);
 	return ret;
@@ -193,15 +229,20 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 static int vfio_ccw_sch_remove(struct subchannel *sch)
 {
 	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
+	struct vfio_ccw_crw *crw, *temp;
 
 	vfio_ccw_sch_quiesce(sch);
 
+	list_for_each_entry_safe(crw, temp, &private->crw, next) {
+		list_del(&crw->next);
+		kfree(crw);
+	}
+
 	vfio_ccw_mdev_unreg(sch);
 
 	dev_set_drvdata(&sch->dev, NULL);
 
-	kmem_cache_free(vfio_ccw_cmd_region, private->cmd_region);
-	kmem_cache_free(vfio_ccw_io_region, private->io_region);
+	vfio_ccw_free_regions(private);
 	kfree(private->cp.guest_cp);
 	kfree(private);
 
@@ -258,6 +299,83 @@ static int vfio_ccw_sch_event(struct subchannel *sch, int process)
 	return rc;
 }
 
+static void vfio_ccw_queue_crw(struct vfio_ccw_private *private,
+			       unsigned int rsc,
+			       unsigned int erc,
+			       unsigned int rsid)
+{
+	struct vfio_ccw_crw *crw;
+
+	/*
+	 * If unable to allocate a CRW, just drop the event and
+	 * carry on.  The guest will either see a later one or
+	 * learn when it issues its own store subchannel.
+	 */
+	crw = kzalloc(sizeof(*crw), GFP_ATOMIC);
+	if (!crw)
+		return;
+
+	/*
+	 * Build the CRW based on the inputs given to us.
+	 */
+	crw->crw.rsc = rsc;
+	crw->crw.erc = erc;
+	crw->crw.rsid = rsid;
+
+	list_add_tail(&crw->next, &private->crw);
+	queue_work(vfio_ccw_work_q, &private->crw_work);
+}
+
+static int vfio_ccw_chp_event(struct subchannel *sch,
+			      struct chp_link *link, int event)
+{
+	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
+	int mask = chp_ssd_get_mask(&sch->ssd_info, link);
+	int retry = 255;
+
+	if (!private || !mask)
+		return 0;
+
+	trace_vfio_ccw_chp_event(private->sch->schid, mask, event);
+	VFIO_CCW_MSG_EVENT(2, "%pUl (%x.%x.%04x): mask=0x%x event=%d\n",
+			   mdev_uuid(private->mdev), sch->schid.cssid,
+			   sch->schid.ssid, sch->schid.sch_no,
+			   mask, event);
+
+	if (cio_update_schib(sch))
+		return -ENODEV;
+
+	switch (event) {
+	case CHP_VARY_OFF:
+		/* Path logically turned off */
+		sch->opm &= ~mask;
+		sch->lpm &= ~mask;
+		if (sch->schib.pmcw.lpum & mask)
+			cio_cancel_halt_clear(sch, &retry);
+		break;
+	case CHP_OFFLINE:
+		/* Path is gone */
+		if (sch->schib.pmcw.lpum & mask)
+			cio_cancel_halt_clear(sch, &retry);
+		vfio_ccw_queue_crw(private, CRW_RSC_CPATH, CRW_ERC_PERRN,
+				   link->chpid.id);
+		break;
+	case CHP_VARY_ON:
+		/* Path logically turned on */
+		sch->opm |= mask;
+		sch->lpm |= mask;
+		break;
+	case CHP_ONLINE:
+		/* Path became available */
+		sch->lpm |= mask & sch->opm;
+		vfio_ccw_queue_crw(private, CRW_RSC_CPATH, CRW_ERC_INIT,
+				   link->chpid.id);
+		break;
+	}
+
+	return 0;
+}
+
 static struct css_device_id vfio_ccw_sch_ids[] = {
 	{ .match_flags = 0x1, .type = SUBCHANNEL_TYPE_IO, },
 	{ /* end of list */ },
@@ -275,6 +393,7 @@ static struct css_driver vfio_ccw_sch_driver = {
 	.remove = vfio_ccw_sch_remove,
 	.shutdown = vfio_ccw_sch_shutdown,
 	.sch_event = vfio_ccw_sch_event,
+	.chp_event = vfio_ccw_chp_event,
 };
 
 static int __init vfio_ccw_debug_init(void)
@@ -304,6 +423,14 @@ static void vfio_ccw_debug_exit(void)
 	debug_unregister(vfio_ccw_debug_trace_id);
 }
 
+static void vfio_ccw_destroy_regions(void)
+{
+	kmem_cache_destroy(vfio_ccw_crw_region);
+	kmem_cache_destroy(vfio_ccw_schib_region);
+	kmem_cache_destroy(vfio_ccw_cmd_region);
+	kmem_cache_destroy(vfio_ccw_io_region);
+}
+
 static int __init vfio_ccw_sch_init(void)
 {
 	int ret;
@@ -336,6 +463,26 @@ static int __init vfio_ccw_sch_init(void)
 		goto out_err;
 	}
 
+	vfio_ccw_schib_region = kmem_cache_create_usercopy("vfio_ccw_schib_region",
+					sizeof(struct ccw_schib_region), 0,
+					SLAB_ACCOUNT, 0,
+					sizeof(struct ccw_schib_region), NULL);
+
+	if (!vfio_ccw_schib_region) {
+		ret = -ENOMEM;
+		goto out_err;
+	}
+
+	vfio_ccw_crw_region = kmem_cache_create_usercopy("vfio_ccw_crw_region",
+					sizeof(struct ccw_crw_region), 0,
+					SLAB_ACCOUNT, 0,
+					sizeof(struct ccw_crw_region), NULL);
+
+	if (!vfio_ccw_crw_region) {
+		ret = -ENOMEM;
+		goto out_err;
+	}
+
 	isc_register(VFIO_CCW_ISC);
 	ret = css_driver_register(&vfio_ccw_sch_driver);
 	if (ret) {
@@ -346,8 +493,7 @@ static int __init vfio_ccw_sch_init(void)
 	return ret;
 
 out_err:
-	kmem_cache_destroy(vfio_ccw_cmd_region);
-	kmem_cache_destroy(vfio_ccw_io_region);
+	vfio_ccw_destroy_regions();
 	destroy_workqueue(vfio_ccw_work_q);
 	vfio_ccw_debug_exit();
 	return ret;
@@ -357,8 +503,7 @@ static void __exit vfio_ccw_sch_exit(void)
 {
 	css_driver_unregister(&vfio_ccw_sch_driver);
 	isc_unregister(VFIO_CCW_ISC);
-	kmem_cache_destroy(vfio_ccw_io_region);
-	kmem_cache_destroy(vfio_ccw_cmd_region);
+	vfio_ccw_destroy_regions();
 	destroy_workqueue(vfio_ccw_work_q);
 	vfio_ccw_debug_exit();
 }
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index f0d71ab77c50..8b3ed5b45277 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -172,8 +172,22 @@ static int vfio_ccw_mdev_open(struct mdev_device *mdev)
 
 	ret = vfio_ccw_register_async_dev_regions(private);
 	if (ret)
-		vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
-					 &private->nb);
+		goto out_unregister;
+
+	ret = vfio_ccw_register_schib_dev_regions(private);
+	if (ret)
+		goto out_unregister;
+
+	ret = vfio_ccw_register_crw_dev_regions(private);
+	if (ret)
+		goto out_unregister;
+
+	return ret;
+
+out_unregister:
+	vfio_ccw_unregister_dev_regions(private);
+	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
+				 &private->nb);
 	return ret;
 }
 
@@ -181,7 +195,6 @@ static void vfio_ccw_mdev_release(struct mdev_device *mdev)
 {
 	struct vfio_ccw_private *private =
 		dev_get_drvdata(mdev_parent_dev(mdev));
-	int i;
 
 	if ((private->state != VFIO_CCW_STATE_NOT_OPER) &&
 	    (private->state != VFIO_CCW_STATE_STANDBY)) {
@@ -191,15 +204,9 @@ static void vfio_ccw_mdev_release(struct mdev_device *mdev)
 	}
 
 	cp_free(&private->cp);
+	vfio_ccw_unregister_dev_regions(private);
 	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
 				 &private->nb);
-
-	for (i = 0; i < private->num_regions; i++)
-		private->region[i].ops->release(private, &private->region[i]);
-
-	private->num_regions = 0;
-	kfree(private->region);
-	private->region = NULL;
 }
 
 static ssize_t vfio_ccw_mdev_read_io_region(struct vfio_ccw_private *private,
@@ -384,17 +391,22 @@ static int vfio_ccw_mdev_get_region_info(struct vfio_region_info *info,
 
 static int vfio_ccw_mdev_get_irq_info(struct vfio_irq_info *info)
 {
-	if (info->index != VFIO_CCW_IO_IRQ_INDEX)
+	switch (info->index) {
+	case VFIO_CCW_IO_IRQ_INDEX:
+	case VFIO_CCW_CRW_IRQ_INDEX:
+		info->count = 1;
+		info->flags = VFIO_IRQ_INFO_EVENTFD;
+		break;
+	default:
 		return -EINVAL;
-
-	info->count = 1;
-	info->flags = VFIO_IRQ_INFO_EVENTFD;
+	}
 
 	return 0;
 }
 
 static int vfio_ccw_mdev_set_irqs(struct mdev_device *mdev,
 				  uint32_t flags,
+				  uint32_t index,
 				  void __user *data)
 {
 	struct vfio_ccw_private *private;
@@ -404,7 +416,17 @@ static int vfio_ccw_mdev_set_irqs(struct mdev_device *mdev,
 		return -EINVAL;
 
 	private = dev_get_drvdata(mdev_parent_dev(mdev));
-	ctx = &private->io_trigger;
+
+	switch (index) {
+	case VFIO_CCW_IO_IRQ_INDEX:
+		ctx = &private->io_trigger;
+		break;
+	case VFIO_CCW_CRW_IRQ_INDEX:
+		ctx = &private->crw_trigger;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	switch (flags & VFIO_IRQ_SET_DATA_TYPE_MASK) {
 	case VFIO_IRQ_SET_DATA_NONE:
@@ -482,6 +504,17 @@ int vfio_ccw_register_dev_region(struct vfio_ccw_private *private,
 	return 0;
 }
 
+void vfio_ccw_unregister_dev_regions(struct vfio_ccw_private *private)
+{
+	int i;
+
+	for (i = 0; i < private->num_regions; i++)
+		private->region[i].ops->release(private, &private->region[i]);
+	private->num_regions = 0;
+	kfree(private->region);
+	private->region = NULL;
+}
+
 static ssize_t vfio_ccw_mdev_ioctl(struct mdev_device *mdev,
 				   unsigned int cmd,
 				   unsigned long arg)
@@ -565,7 +598,7 @@ static ssize_t vfio_ccw_mdev_ioctl(struct mdev_device *mdev,
 			return ret;
 
 		data = (void __user *)(arg + minsz);
-		return vfio_ccw_mdev_set_irqs(mdev, hdr.flags, data);
+		return vfio_ccw_mdev_set_irqs(mdev, hdr.flags, hdr.index, data);
 	}
 	case VFIO_DEVICE_RESET:
 		return vfio_ccw_mdev_reset(mdev);
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index 9b9bb4982972..8723156b29ea 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -17,6 +17,7 @@
 #include <linux/eventfd.h>
 #include <linux/workqueue.h>
 #include <linux/vfio_ccw.h>
+#include <asm/crw.h>
 #include <asm/debug.h>
 
 #include "css.h"
@@ -53,8 +54,16 @@ int vfio_ccw_register_dev_region(struct vfio_ccw_private *private,
 				 unsigned int subtype,
 				 const struct vfio_ccw_regops *ops,
 				 size_t size, u32 flags, void *data);
+void vfio_ccw_unregister_dev_regions(struct vfio_ccw_private *private);
 
 int vfio_ccw_register_async_dev_regions(struct vfio_ccw_private *private);
+int vfio_ccw_register_schib_dev_regions(struct vfio_ccw_private *private);
+int vfio_ccw_register_crw_dev_regions(struct vfio_ccw_private *private);
+
+struct vfio_ccw_crw {
+	struct list_head	next;
+	struct crw		crw;
+};
 
 /**
  * struct vfio_ccw_private
@@ -68,6 +77,8 @@ int vfio_ccw_register_async_dev_regions(struct vfio_ccw_private *private);
  * @io_mutex: protect against concurrent update of I/O regions
  * @region: additional regions for other subchannel operations
  * @cmd_region: MMIO region for asynchronous I/O commands other than START
+ * @schib_region: MMIO region for SCHIB information
+ * @crw_region: MMIO region for getting channel report words
  * @num_regions: number of additional regions
  * @cp: channel program for the current I/O operation
  * @irb: irb info received from interrupt
@@ -86,14 +97,19 @@ struct vfio_ccw_private {
 	struct mutex		io_mutex;
 	struct vfio_ccw_region *region;
 	struct ccw_cmd_region	*cmd_region;
+	struct ccw_schib_region *schib_region;
+	struct ccw_crw_region	*crw_region;
 	int num_regions;
 
 	struct channel_program	cp;
 	struct irb		irb;
 	union scsw		scsw;
+	struct list_head	crw;
 
 	struct eventfd_ctx	*io_trigger;
+	struct eventfd_ctx	*crw_trigger;
 	struct work_struct	io_work;
+	struct work_struct	crw_work;
 } __aligned(8);
 
 extern int vfio_ccw_mdev_reg(struct subchannel *sch);
diff --git a/drivers/s390/cio/vfio_ccw_trace.c b/drivers/s390/cio/vfio_ccw_trace.c
index 8c671d2519f6..4a0205905afc 100644
--- a/drivers/s390/cio/vfio_ccw_trace.c
+++ b/drivers/s390/cio/vfio_ccw_trace.c
@@ -9,6 +9,7 @@
 #define CREATE_TRACE_POINTS
 #include "vfio_ccw_trace.h"
 
+EXPORT_TRACEPOINT_SYMBOL(vfio_ccw_chp_event);
 EXPORT_TRACEPOINT_SYMBOL(vfio_ccw_fsm_async_request);
 EXPORT_TRACEPOINT_SYMBOL(vfio_ccw_fsm_event);
 EXPORT_TRACEPOINT_SYMBOL(vfio_ccw_fsm_io_request);
diff --git a/drivers/s390/cio/vfio_ccw_trace.h b/drivers/s390/cio/vfio_ccw_trace.h
index f5d31887d413..62fb30598d47 100644
--- a/drivers/s390/cio/vfio_ccw_trace.h
+++ b/drivers/s390/cio/vfio_ccw_trace.h
@@ -17,6 +17,36 @@
 
 #include <linux/tracepoint.h>
 
+TRACE_EVENT(vfio_ccw_chp_event,
+	TP_PROTO(struct subchannel_id schid,
+		 int mask,
+		 int event),
+	TP_ARGS(schid, mask, event),
+
+	TP_STRUCT__entry(
+		__field(u8, cssid)
+		__field(u8, ssid)
+		__field(u16, sch_no)
+		__field(int, mask)
+		__field(int, event)
+	),
+
+	TP_fast_assign(
+		__entry->cssid = schid.cssid;
+		__entry->ssid = schid.ssid;
+		__entry->sch_no = schid.sch_no;
+		__entry->mask = mask;
+		__entry->event = event;
+	),
+
+	TP_printk("schid=%x.%x.%04x mask=0x%x event=%d",
+		  __entry->cssid,
+		  __entry->ssid,
+		  __entry->sch_no,
+		  __entry->mask,
+		  __entry->event)
+);
+
 TRACE_EVENT(vfio_ccw_fsm_async_request,
 	TP_PROTO(struct subchannel_id schid,
 		 int command,
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 35064443e748..e71ca4a719a5 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -62,8 +62,10 @@ MODULE_PARM_DESC(aqmask, "AP bus domain mask.");
 
 static struct device *ap_root_device;
 
-DEFINE_SPINLOCK(ap_list_lock);
-LIST_HEAD(ap_card_list);
+/* Hashtable of all queue devices on the AP bus */
+DEFINE_HASHTABLE(ap_queues, 8);
+/* lock used for the ap_queues hashtable */
+DEFINE_SPINLOCK(ap_queues_lock);
 
 /* Default permissions (ioctl, card and domain masking) */
 struct ap_perms ap_perms;
@@ -414,7 +416,7 @@ static void ap_interrupt_handler(struct airq_struct *airq, bool floating)
  */
 static void ap_tasklet_fn(unsigned long dummy)
 {
-	struct ap_card *ac;
+	int bkt;
 	struct ap_queue *aq;
 	enum ap_wait wait = AP_WAIT_NONE;
 
@@ -425,34 +427,30 @@ static void ap_tasklet_fn(unsigned long dummy)
 	if (ap_using_interrupts())
 		xchg(ap_airq.lsi_ptr, 0);
 
-	spin_lock_bh(&ap_list_lock);
-	for_each_ap_card(ac) {
-		for_each_ap_queue(aq, ac) {
-			spin_lock_bh(&aq->lock);
-			wait = min(wait, ap_sm_event_loop(aq, AP_EVENT_POLL));
-			spin_unlock_bh(&aq->lock);
-		}
+	spin_lock_bh(&ap_queues_lock);
+	hash_for_each(ap_queues, bkt, aq, hnode) {
+		spin_lock_bh(&aq->lock);
+		wait = min(wait, ap_sm_event_loop(aq, AP_EVENT_POLL));
+		spin_unlock_bh(&aq->lock);
 	}
-	spin_unlock_bh(&ap_list_lock);
+	spin_unlock_bh(&ap_queues_lock);
 
 	ap_wait(wait);
 }
 
 static int ap_pending_requests(void)
 {
-	struct ap_card *ac;
+	int bkt;
 	struct ap_queue *aq;
 
-	spin_lock_bh(&ap_list_lock);
-	for_each_ap_card(ac) {
-		for_each_ap_queue(aq, ac) {
-			if (aq->queue_count == 0)
-				continue;
-			spin_unlock_bh(&ap_list_lock);
-			return 1;
-		}
+	spin_lock_bh(&ap_queues_lock);
+	hash_for_each(ap_queues, bkt, aq, hnode) {
+		if (aq->queue_count == 0)
+			continue;
+		spin_unlock_bh(&ap_queues_lock);
+		return 1;
 	}
-	spin_unlock_bh(&ap_list_lock);
+	spin_unlock_bh(&ap_queues_lock);
 	return 0;
 }
 
@@ -683,24 +681,20 @@ static int ap_device_probe(struct device *dev)
 	}
 
 	/* Add queue/card to list of active queues/cards */
-	spin_lock_bh(&ap_list_lock);
-	if (is_card_dev(dev))
-		list_add(&to_ap_card(dev)->list, &ap_card_list);
-	else
-		list_add(&to_ap_queue(dev)->list,
-			 &to_ap_queue(dev)->card->queues);
-	spin_unlock_bh(&ap_list_lock);
+	spin_lock_bh(&ap_queues_lock);
+	if (is_queue_dev(dev))
+		hash_add(ap_queues, &to_ap_queue(dev)->hnode,
+			 to_ap_queue(dev)->qid);
+	spin_unlock_bh(&ap_queues_lock);
 
 	ap_dev->drv = ap_drv;
 	rc = ap_drv->probe ? ap_drv->probe(ap_dev) : -ENODEV;
 
 	if (rc) {
-		spin_lock_bh(&ap_list_lock);
-		if (is_card_dev(dev))
-			list_del_init(&to_ap_card(dev)->list);
-		else
-			list_del_init(&to_ap_queue(dev)->list);
-		spin_unlock_bh(&ap_list_lock);
+		spin_lock_bh(&ap_queues_lock);
+		if (is_queue_dev(dev))
+			hash_del(&to_ap_queue(dev)->hnode);
+		spin_unlock_bh(&ap_queues_lock);
 		ap_dev->drv = NULL;
 	}
 
@@ -725,16 +719,33 @@ static int ap_device_remove(struct device *dev)
 		ap_queue_remove(to_ap_queue(dev));
 
 	/* Remove queue/card from list of active queues/cards */
-	spin_lock_bh(&ap_list_lock);
-	if (is_card_dev(dev))
-		list_del_init(&to_ap_card(dev)->list);
-	else
-		list_del_init(&to_ap_queue(dev)->list);
-	spin_unlock_bh(&ap_list_lock);
+	spin_lock_bh(&ap_queues_lock);
+	if (is_queue_dev(dev))
+		hash_del(&to_ap_queue(dev)->hnode);
+	spin_unlock_bh(&ap_queues_lock);
 
 	return 0;
 }
 
+struct ap_queue *ap_get_qdev(ap_qid_t qid)
+{
+	int bkt;
+	struct ap_queue *aq;
+
+	spin_lock_bh(&ap_queues_lock);
+	hash_for_each(ap_queues, bkt, aq, hnode) {
+		if (aq->qid == qid) {
+			get_device(&aq->ap_dev.device);
+			spin_unlock_bh(&ap_queues_lock);
+			return aq;
+		}
+	}
+	spin_unlock_bh(&ap_queues_lock);
+
+	return NULL;
+}
+EXPORT_SYMBOL(ap_get_qdev);
+
 int ap_driver_register(struct ap_driver *ap_drv, struct module *owner,
 		       char *name)
 {
@@ -1506,6 +1517,9 @@ static int __init ap_module_init(void)
 		return -ENODEV;
 	}
 
+	/* init ap_queue hashtable */
+	hash_init(ap_queues);
+
 	/* set up the AP permissions (ioctls, ap and aq masks) */
 	ap_perms_init();
 
diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index 8e8e37b6c0ee..053cc34d2ca2 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -15,6 +15,7 @@
 
 #include <linux/device.h>
 #include <linux/types.h>
+#include <linux/hashtable.h>
 #include <asm/isc.h>
 #include <asm/ap.h>
 
@@ -27,8 +28,8 @@
 
 extern int ap_domain_index;
 
-extern spinlock_t ap_list_lock;
-extern struct list_head ap_card_list;
+extern DECLARE_HASHTABLE(ap_queues, 8);
+extern spinlock_t ap_queues_lock;
 
 static inline int ap_test_bit(unsigned int *ptr, unsigned int nr)
 {
@@ -152,8 +153,6 @@ struct ap_device {
 
 struct ap_card {
 	struct ap_device ap_dev;
-	struct list_head list;		/* Private list of AP cards. */
-	struct list_head queues;	/* List of assoc. AP queues */
 	void *private;			/* ap driver private pointer. */
 	int raw_hwtype;			/* AP raw hardware type. */
 	unsigned int functions;		/* AP device function bitfield. */
@@ -166,7 +165,7 @@ struct ap_card {
 
 struct ap_queue {
 	struct ap_device ap_dev;
-	struct list_head list;		/* Private list of AP queues. */
+	struct hlist_node hnode;	/* Node for the ap_queues hashtable */
 	struct ap_card *card;		/* Ptr to assoc. AP card. */
 	spinlock_t lock;		/* Per device lock. */
 	void *private;			/* ap driver private pointer. */
@@ -223,12 +222,6 @@ static inline void ap_release_message(struct ap_message *ap_msg)
 	kzfree(ap_msg->private);
 }
 
-#define for_each_ap_card(_ac) \
-	list_for_each_entry(_ac, &ap_card_list, list)
-
-#define for_each_ap_queue(_aq, _ac) \
-	list_for_each_entry(_aq, &(_ac)->queues, list)
-
 /*
  * Note: don't use ap_send/ap_recv after using ap_queue_message
  * for the first time. Otherwise the ap message queue will get
@@ -269,6 +262,16 @@ struct ap_perms {
 extern struct ap_perms ap_perms;
 extern struct mutex ap_perms_mutex;
 
+/*
+ * Get ap_queue device for this qid.
+ * Returns ptr to the struct ap_queue device or NULL if there
+ * was no ap_queue device with this qid found. When something is
+ * found, the reference count of the embedded device is increased.
+ * So the caller has to decrease the reference count after use
+ * with a call to put_device(&aq->ap_dev.device).
+ */
+struct ap_queue *ap_get_qdev(ap_qid_t qid);
+
 /*
  * check APQN for owned/reserved by ap bus and default driver(s).
  * Checks if this APQN is or will be in use by the ap bus
diff --git a/drivers/s390/crypto/ap_card.c b/drivers/s390/crypto/ap_card.c
index 0a39dfdb6a1d..6588713319ba 100644
--- a/drivers/s390/crypto/ap_card.c
+++ b/drivers/s390/crypto/ap_card.c
@@ -66,9 +66,9 @@ static ssize_t request_count_show(struct device *dev,
 	u64 req_cnt;
 
 	req_cnt = 0;
-	spin_lock_bh(&ap_list_lock);
+	spin_lock_bh(&ap_queues_lock);
 	req_cnt = atomic64_read(&ac->total_request_count);
-	spin_unlock_bh(&ap_list_lock);
+	spin_unlock_bh(&ap_queues_lock);
 	return scnprintf(buf, PAGE_SIZE, "%llu\n", req_cnt);
 }
 
@@ -76,13 +76,15 @@ static ssize_t request_count_store(struct device *dev,
 				   struct device_attribute *attr,
 				   const char *buf, size_t count)
 {
-	struct ap_card *ac = to_ap_card(dev);
+	int bkt;
 	struct ap_queue *aq;
+	struct ap_card *ac = to_ap_card(dev);
 
-	spin_lock_bh(&ap_list_lock);
-	for_each_ap_queue(aq, ac)
-		aq->total_request_count = 0;
-	spin_unlock_bh(&ap_list_lock);
+	spin_lock_bh(&ap_queues_lock);
+	hash_for_each(ap_queues, bkt, aq, hnode)
+		if (ac == aq->card)
+			aq->total_request_count = 0;
+	spin_unlock_bh(&ap_queues_lock);
 	atomic64_set(&ac->total_request_count, 0);
 
 	return count;
@@ -93,15 +95,17 @@ static DEVICE_ATTR_RW(request_count);
 static ssize_t requestq_count_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	struct ap_card *ac = to_ap_card(dev);
+	int bkt;
 	struct ap_queue *aq;
 	unsigned int reqq_cnt;
+	struct ap_card *ac = to_ap_card(dev);
 
 	reqq_cnt = 0;
-	spin_lock_bh(&ap_list_lock);
-	for_each_ap_queue(aq, ac)
-		reqq_cnt += aq->requestq_count;
-	spin_unlock_bh(&ap_list_lock);
+	spin_lock_bh(&ap_queues_lock);
+	hash_for_each(ap_queues, bkt, aq, hnode)
+		if (ac == aq->card)
+			reqq_cnt += aq->requestq_count;
+	spin_unlock_bh(&ap_queues_lock);
 	return scnprintf(buf, PAGE_SIZE, "%d\n", reqq_cnt);
 }
 
@@ -110,15 +114,17 @@ static DEVICE_ATTR_RO(requestq_count);
 static ssize_t pendingq_count_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	struct ap_card *ac = to_ap_card(dev);
+	int bkt;
 	struct ap_queue *aq;
 	unsigned int penq_cnt;
+	struct ap_card *ac = to_ap_card(dev);
 
 	penq_cnt = 0;
-	spin_lock_bh(&ap_list_lock);
-	for_each_ap_queue(aq, ac)
-		penq_cnt += aq->pendingq_count;
-	spin_unlock_bh(&ap_list_lock);
+	spin_lock_bh(&ap_queues_lock);
+	hash_for_each(ap_queues, bkt, aq, hnode)
+		if (ac == aq->card)
+			penq_cnt += aq->pendingq_count;
+	spin_unlock_bh(&ap_queues_lock);
 	return scnprintf(buf, PAGE_SIZE, "%d\n", penq_cnt);
 }
 
@@ -163,11 +169,6 @@ static void ap_card_device_release(struct device *dev)
 {
 	struct ap_card *ac = to_ap_card(dev);
 
-	if (!list_empty(&ac->list)) {
-		spin_lock_bh(&ap_list_lock);
-		list_del_init(&ac->list);
-		spin_unlock_bh(&ap_list_lock);
-	}
 	kfree(ac);
 }
 
@@ -179,8 +180,6 @@ struct ap_card *ap_card_create(int id, int queue_depth, int raw_type,
 	ac = kzalloc(sizeof(*ac), GFP_KERNEL);
 	if (!ac)
 		return NULL;
-	INIT_LIST_HEAD(&ac->list);
-	INIT_LIST_HEAD(&ac->queues);
 	ac->ap_dev.device.release = ap_card_device_release;
 	ac->ap_dev.device.type = &ap_card_type;
 	ac->ap_dev.device_type = comp_type;
diff --git a/drivers/s390/crypto/ap_queue.c b/drivers/s390/crypto/ap_queue.c
index 0eaf1d04e8df..73b077dca3e6 100644
--- a/drivers/s390/crypto/ap_queue.c
+++ b/drivers/s390/crypto/ap_queue.c
@@ -568,11 +568,10 @@ static void ap_queue_device_release(struct device *dev)
 {
 	struct ap_queue *aq = to_ap_queue(dev);
 
-	if (!list_empty(&aq->list)) {
-		spin_lock_bh(&ap_list_lock);
-		list_del_init(&aq->list);
-		spin_unlock_bh(&ap_list_lock);
-	}
+	spin_lock_bh(&ap_queues_lock);
+	hash_del(&aq->hnode);
+	spin_unlock_bh(&ap_queues_lock);
+
 	kfree(aq);
 }
 
@@ -590,7 +589,6 @@ struct ap_queue *ap_queue_create(ap_qid_t qid, int device_type)
 	aq->state = AP_STATE_UNBOUND;
 	aq->interrupt = AP_INTR_DISABLED;
 	spin_lock_init(&aq->lock);
-	INIT_LIST_HEAD(&aq->list);
 	INIT_LIST_HEAD(&aq->pendingq);
 	INIT_LIST_HEAD(&aq->requestq);
 	timer_setup(&aq->timeout, ap_request_timeout, 0);
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 0bd5b09e7a22..f60b865c73ad 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -20,6 +20,7 @@
 #include <linux/list.h>
 #include <linux/hash.h>
 #include <linux/hashtable.h>
+#include <asm/chsc.h>
 #include <asm/setup.h>
 #include "qeth_core.h"
 #include "qeth_l2.h"
@@ -27,8 +28,8 @@
 static void qeth_bridgeport_query_support(struct qeth_card *card);
 static void qeth_bridge_state_change(struct qeth_card *card,
 					struct qeth_ipa_cmd *cmd);
-static void qeth_bridge_host_event(struct qeth_card *card,
-					struct qeth_ipa_cmd *cmd);
+static void qeth_addr_change_event(struct qeth_card *card,
+				   struct qeth_ipa_cmd *cmd);
 static void qeth_l2_vnicc_set_defaults(struct qeth_card *card);
 static void qeth_l2_vnicc_init(struct qeth_card *card);
 static bool qeth_l2_vnicc_recover_timeout(struct qeth_card *card, u32 vnicc,
@@ -628,6 +629,72 @@ static void qeth_l2_set_rx_mode(struct net_device *dev)
 	schedule_work(&card->rx_mode_work);
 }
 
+/**
+ *	qeth_l2_pnso() - perform network subchannel operation
+ *	@card: qeth_card structure pointer
+ *	@cnc: Boolean Change-Notification Control
+ *	@cb: Callback function will be executed for each element
+ *		of the address list
+ *	@priv: Pointer to pass to the callback function.
+ *
+ *	Collects network information in a network address list and calls the
+ *	callback function for every entry in the list. If "change-notification-
+ *	control" is set, further changes in the address list will be reported
+ *	via the IPA command.
+ */
+static int qeth_l2_pnso(struct qeth_card *card, int cnc,
+			void (*cb)(void *priv, struct chsc_pnso_naid_l2 *entry),
+			void *priv)
+{
+	struct ccw_device *ddev = CARD_DDEV(card);
+	struct chsc_pnso_area *rr;
+	u32 prev_instance = 0;
+	int isfirstblock = 1;
+	int i, size, elems;
+	int rc;
+
+	QETH_CARD_TEXT(card, 2, "PNSO");
+	rr = (struct chsc_pnso_area *)get_zeroed_page(GFP_KERNEL);
+	if (rr == NULL)
+		return -ENOMEM;
+	do {
+		/* on the first iteration, naihdr.resume_token will be zero */
+		rc = ccw_device_pnso(ddev, rr, rr->naihdr.resume_token, cnc);
+		if (rc)
+			continue;
+		if (cb == NULL)
+			continue;
+
+		size = rr->naihdr.naids;
+		if (size != sizeof(struct chsc_pnso_naid_l2)) {
+			WARN_ON_ONCE(1);
+			continue;
+		}
+
+		elems = (rr->response.length - sizeof(struct chsc_header) -
+			 sizeof(struct chsc_pnso_naihdr)) / size;
+
+		if (!isfirstblock && (rr->naihdr.instance != prev_instance)) {
+			/* Inform the caller that they need to scrap */
+			/* the data that was already reported via cb */
+			rc = -EAGAIN;
+			break;
+		}
+		isfirstblock = 0;
+		prev_instance = rr->naihdr.instance;
+		for (i = 0; i < elems; i++)
+			(*cb)(priv, &rr->entries[i]);
+	} while ((rc == -EBUSY) || (!rc && /* list stored */
+		   /* resume token is non-zero => list incomplete */
+		   (rr->naihdr.resume_token.t1 || rr->naihdr.resume_token.t2)));
+
+	if (rc)
+		QETH_CARD_TEXT_(card, 2, "PNrp%04x", rr->response.code);
+
+	free_page((unsigned long)rr);
+	return rc;
+}
+
 static const struct net_device_ops qeth_l2_netdev_ops = {
 	.ndo_open		= qeth_open,
 	.ndo_stop		= qeth_stop,
@@ -854,7 +921,7 @@ static int qeth_l2_control_event(struct qeth_card *card,
 		} else
 			return 1;
 	case IPA_CMD_ADDRESS_CHANGE_NOTIF:
-		qeth_bridge_host_event(card, cmd);
+		qeth_addr_change_event(card, cmd);
 		return 0;
 	default:
 		return 1;
@@ -971,8 +1038,10 @@ enum qeth_an_event_type {anev_reg_unreg, anev_abort, anev_reset};
  * for all currently registered addresses.
  */
 static void qeth_bridge_emit_host_event(struct qeth_card *card,
-	enum qeth_an_event_type evtype,
-	u8 code, struct net_if_token *token, struct mac_addr_lnid *addr_lnid)
+					enum qeth_an_event_type evtype,
+					u8 code,
+					struct net_if_token *token,
+					struct mac_addr_lnid *addr_lnid)
 {
 	char str[7][32];
 	char *env[8];
@@ -1089,74 +1158,76 @@ static void qeth_bridge_state_change(struct qeth_card *card,
 	queue_work(card->event_wq, &data->worker);
 }
 
-struct qeth_bridge_host_data {
+struct qeth_addr_change_data {
 	struct work_struct worker;
 	struct qeth_card *card;
-	struct qeth_ipacmd_addr_change hostevs;
+	struct qeth_ipacmd_addr_change ac_event;
 };
 
-static void qeth_bridge_host_event_worker(struct work_struct *work)
+static void qeth_addr_change_event_worker(struct work_struct *work)
 {
-	struct qeth_bridge_host_data *data =
-		container_of(work, struct qeth_bridge_host_data, worker);
+	struct qeth_addr_change_data *data =
+		container_of(work, struct qeth_addr_change_data, worker);
 	int i;
 
-	if (data->hostevs.lost_event_mask) {
+	QETH_CARD_TEXT(data->card, 4, "adrchgew");
+	if (data->ac_event.lost_event_mask) {
 		dev_info(&data->card->gdev->dev,
-"Address notification from the Bridge Port stopped %s (%s)\n",
-			data->card->dev->name,
-			(data->hostevs.lost_event_mask == 0x01)
+			 "Address change notification stopped on %s (%s)\n",
+			 data->card->dev->name,
+			(data->ac_event.lost_event_mask == 0x01)
 			? "Overflow"
-			: (data->hostevs.lost_event_mask == 0x02)
+			: (data->ac_event.lost_event_mask == 0x02)
 			? "Bridge port state change"
 			: "Unknown reason");
 		mutex_lock(&data->card->sbp_lock);
 		data->card->options.sbp.hostnotification = 0;
 		mutex_unlock(&data->card->sbp_lock);
 		qeth_bridge_emit_host_event(data->card, anev_abort,
-			0, NULL, NULL);
+					    0, NULL, NULL);
 	} else
-		for (i = 0; i < data->hostevs.num_entries; i++) {
+		for (i = 0; i < data->ac_event.num_entries; i++) {
 			struct qeth_ipacmd_addr_change_entry *entry =
-					&data->hostevs.entry[i];
+					&data->ac_event.entry[i];
 			qeth_bridge_emit_host_event(data->card,
-					anev_reg_unreg,
-					entry->change_code,
-					&entry->token, &entry->addr_lnid);
+						    anev_reg_unreg,
+						    entry->change_code,
+						    &entry->token,
+						    &entry->addr_lnid);
 		}
 	kfree(data);
 }
 
-static void qeth_bridge_host_event(struct qeth_card *card,
-					struct qeth_ipa_cmd *cmd)
+static void qeth_addr_change_event(struct qeth_card *card,
+				   struct qeth_ipa_cmd *cmd)
 {
 	struct qeth_ipacmd_addr_change *hostevs =
 		 &cmd->data.addrchange;
-	struct qeth_bridge_host_data *data;
+	struct qeth_addr_change_data *data;
 	int extrasize;
 
-	QETH_CARD_TEXT(card, 2, "brhostev");
+	QETH_CARD_TEXT(card, 4, "adrchgev");
 	if (cmd->hdr.return_code != 0x0000) {
 		if (cmd->hdr.return_code == 0x0010) {
 			if (hostevs->lost_event_mask == 0x00)
 				hostevs->lost_event_mask = 0xff;
 		} else {
-			QETH_CARD_TEXT_(card, 2, "BPHe%04x",
+			QETH_CARD_TEXT_(card, 2, "ACHN%04x",
 				cmd->hdr.return_code);
 			return;
 		}
 	}
 	extrasize = sizeof(struct qeth_ipacmd_addr_change_entry) *
 						hostevs->num_entries;
-	data = kzalloc(sizeof(struct qeth_bridge_host_data) + extrasize,
-		GFP_ATOMIC);
+	data = kzalloc(sizeof(struct qeth_addr_change_data) + extrasize,
+		       GFP_ATOMIC);
 	if (!data) {
-		QETH_CARD_TEXT(card, 2, "BPHalloc");
+		QETH_CARD_TEXT(card, 2, "ACNalloc");
 		return;
 	}
-	INIT_WORK(&data->worker, qeth_bridge_host_event_worker);
+	INIT_WORK(&data->worker, qeth_addr_change_event_worker);
 	data->card = card;
-	memcpy(&data->hostevs, hostevs,
+	memcpy(&data->ac_event, hostevs,
 			sizeof(struct qeth_ipacmd_addr_change) + extrasize);
 	queue_work(card->event_wq, &data->worker);
 }
@@ -1446,63 +1517,18 @@ int qeth_bridgeport_setrole(struct qeth_card *card, enum qeth_sbp_roles role)
 	return qeth_send_ipa_cmd(card, iob, qeth_bridgeport_set_cb, NULL);
 }
 
-/**
- * qeth_anset_makerc() - derive "traditional" error from hardware codes.
- * @card:		      qeth_card structure pointer, for debug messages.
- *
- * Returns negative errno-compatible error indication or 0 on success.
- */
-static int qeth_anset_makerc(struct qeth_card *card, int pnso_rc, u16 response)
-{
-	int rc;
-
-	if (pnso_rc == 0)
-		switch (response) {
-		case 0x0001:
-			rc = 0;
-			break;
-		case 0x0004:
-		case 0x0100:
-		case 0x0106:
-			rc = -EOPNOTSUPP;
-			dev_err(&card->gdev->dev,
-				"Setting address notification failed\n");
-			break;
-		case 0x0107:
-			rc = -EAGAIN;
-			break;
-		default:
-			rc = -EIO;
-		}
-	else
-		rc = -EIO;
-
-	if (rc) {
-		QETH_CARD_TEXT_(card, 2, "SBPp%04x", pnso_rc);
-		QETH_CARD_TEXT_(card, 2, "SBPr%04x", response);
-	}
-	return rc;
-}
-
 static void qeth_bridgeport_an_set_cb(void *priv,
-		enum qdio_brinfo_entry_type type, void *entry)
+				      struct chsc_pnso_naid_l2 *entry)
 {
 	struct qeth_card *card = (struct qeth_card *)priv;
-	struct qdio_brinfo_entry_l2 *l2entry;
 	u8 code;
 
-	if (type != l2_addr_lnid) {
-		WARN_ON_ONCE(1);
-		return;
-	}
-
-	l2entry = (struct qdio_brinfo_entry_l2 *)entry;
 	code = IPA_ADDR_CHANGE_CODE_MACADDR;
-	if (l2entry->addr_lnid.lnid < VLAN_N_VID)
+	if (entry->addr_lnid.lnid < VLAN_N_VID)
 		code |= IPA_ADDR_CHANGE_CODE_VLANID;
 	qeth_bridge_emit_host_event(card, anev_reg_unreg, code,
-		(struct net_if_token *)&l2entry->nit,
-		(struct mac_addr_lnid *)&l2entry->addr_lnid);
+				    (struct net_if_token *)&entry->nit,
+				    (struct mac_addr_lnid *)&entry->addr_lnid);
 }
 
 /**
@@ -1518,22 +1544,16 @@ static void qeth_bridgeport_an_set_cb(void *priv,
 int qeth_bridgeport_an_set(struct qeth_card *card, int enable)
 {
 	int rc;
-	u16 response;
-	struct ccw_device *ddev;
-	struct subchannel_id schid;
 
 	if (!card->options.sbp.supported_funcs)
 		return -EOPNOTSUPP;
-	ddev = CARD_DDEV(card);
-	ccw_device_get_schid(ddev, &schid);
 
 	if (enable) {
 		qeth_bridge_emit_host_event(card, anev_reset, 0, NULL, NULL);
-		rc = qdio_pnso_brinfo(schid, 1, &response,
-			qeth_bridgeport_an_set_cb, card);
+		rc = qeth_l2_pnso(card, 1, qeth_bridgeport_an_set_cb, card);
 	} else
-		rc = qdio_pnso_brinfo(schid, 0, &response, NULL, NULL);
-	return qeth_anset_makerc(card, rc, response);
+		rc = qeth_l2_pnso(card, 0, NULL, NULL);
+	return rc;
 }
 
 static bool qeth_bridgeport_is_in_use(struct qeth_card *card)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 83ce1cdf5676..93a063a7d7f9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2048,6 +2048,8 @@ int pci_iov_virtfn_devfn(struct pci_dev *dev, int id);
 
 int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn);
 void pci_disable_sriov(struct pci_dev *dev);
+
+int pci_iov_sysfs_link(struct pci_dev *dev, struct pci_dev *virtfn, int id);
 int pci_iov_add_virtfn(struct pci_dev *dev, int id);
 void pci_iov_remove_virtfn(struct pci_dev *dev, int id);
 int pci_num_vf(struct pci_dev *dev);
@@ -2073,6 +2075,12 @@ static inline int pci_iov_virtfn_devfn(struct pci_dev *dev, int id)
 }
 static inline int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn)
 { return -ENODEV; }
+
+static inline int pci_iov_sysfs_link(struct pci_dev *dev,
+				     struct pci_dev *virtfn, int id)
+{
+	return -ENODEV;
+}
 static inline int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 {
 	return -ENOSYS;
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 015516bcfaa3..907758cf6d60 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -378,6 +378,8 @@ struct vfio_region_gfx_edid {
 
 /* sub-types for VFIO_REGION_TYPE_CCW */
 #define VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD	(1)
+#define VFIO_REGION_SUBTYPE_CCW_SCHIB		(2)
+#define VFIO_REGION_SUBTYPE_CCW_CRW		(3)
 
 /*
  * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
@@ -577,6 +579,7 @@ enum {
 
 enum {
 	VFIO_CCW_IO_IRQ_INDEX,
+	VFIO_CCW_CRW_IRQ_INDEX,
 	VFIO_CCW_NUM_IRQS
 };
 
diff --git a/include/uapi/linux/vfio_ccw.h b/include/uapi/linux/vfio_ccw.h
index cbecbf0cd54f..aa04f3aa6db0 100644
--- a/include/uapi/linux/vfio_ccw.h
+++ b/include/uapi/linux/vfio_ccw.h
@@ -34,4 +34,23 @@ struct ccw_cmd_region {
 	__u32 ret_code;
 } __packed;
 
+/*
+ * Used for processing commands that read the subchannel-information block
+ * Reading this region triggers a stsch() to hardware
+ * Note: this is controlled by a capability
+ */
+struct ccw_schib_region {
+#define SCHIB_AREA_SIZE 52
+	__u8 schib_area[SCHIB_AREA_SIZE];
+} __packed;
+
+/*
+ * Used for returning a Channel Report Word to userspace.
+ * Note: this is controlled by a capability
+ */
+struct ccw_crw_region {
+	__u32 crw;
+	__u32 pad;
+} __packed;
+
 #endif
