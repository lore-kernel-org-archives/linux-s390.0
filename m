Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42708 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728499AbfGHIXE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 Jul 2019 04:23:04 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x688MLdU136319
        for <linux-s390@vger.kernel.org>; Mon, 8 Jul 2019 04:23:01 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tm00g4v5p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 08 Jul 2019 04:23:01 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Mon, 8 Jul 2019 09:22:59 +0100
Date: Mon, 8 Jul 2019 10:22:54 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [GIT PULL] s390 patches for the 5.3 merge window
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Message-Id: <your-ad-here.call-01562573328-ext-8139@work.hours>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Hello Linus,

please pull s390 fixes and features for 5.3.
This is my first pull request. My PGP key id is 716A93D7,
key fingerprint: F397 316C 210A 9C03 1205  6691 467C 8ED2 716A 93D7

Please also note the fixup required to avoid s390 build error after you
pull Greg's driver-core changes for 5.3:
http://lkml.kernel.org/r/e9889ea3-0286-df1c-864c-ba67a0286855@de.ibm.com
I'm also including the corresponding patch as a follow up email for your
convenience. So you could either apply the patch after the second tree
was merged or you could simply fixup the code during merging.

Thank you,
Vasily

The following changes since commit f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a:

  Linux 5.2-rc3 (2019-06-02 13:55:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git s390-5.3-1

for you to fetch changes up to 499723d12063aab97dfe6b41c822e9c1c74eff3e:

  docs: s390: s390dbf: typos and formatting, update crash command (2019-07-05 13:42:24 +0200)

----------------------------------------------------------------
s390 updates for the 5.3 merge window

 - Improve stop_machine wait logic: replace cpu_relax_yield call in generic
   stop_machine function with a weak stop_machine_yield function. This is
   overridden on s390, which yields the current cpu to the neighbouring cpu
   after a couple of retries, instead of blindly giving up the cpu to the
   hipervisor. This significantly improves stop_machine performance on s390 in
   overcommitted scenarios.
   This includes common code changes which have been Acked by Peter Zijlstra
   and Thomas Gleixner.

 - Improve jump label transformation speed: transform jump labels without
   using stop_machine.

 - Refactoring of the vfio-ccw cp handling, simplifying the code and
   avoiding unneeded allocating/copying.

 - Various vfio-ccw fixes (ccw translation, state machine).

 - Add support for vfio-ap queue interrupt control in the guest.
   This includes s390 kvm changes which have been Acked by Christian
   Borntraeger.

 - Add protected virtualization support for virtio-ccw.

 - Enforce both CONFIG_SMP and CONFIG_HOTPLUG_CPU, which allows to remove some
   code which most likely isn't working at all, besides that s390 didn't even
   compile for !CONFIG_SMP.

 - Support for special flagged EP11 CPRBs for zcrypt.

 - Handle PCI devices with no support for new MIO instructions.

 - Avoid KASAN false positives in reworked stack unwinder.

 - Couple of fixes for the QDIO layer.

 - Convert s390 specific documentation to ReST format.

 - Let s390 crypto modules return -ENODEV instead of -EOPNOTSUPP if hardware is
   missing. This way our modules behave like most other modules and which is
   also what systemd's systemd-modules-load.service expects.

 - Replace defconfig with performance_defconfig, so there is one config file
   less to maintain.

 - Remove the SCLP call home device driver, which was never useful.

 - Cleanups all over the place.

----------------------------------------------------------------
Alexandre Ghiti (1):
      s390/mm: mmap base does not depend on ADDR_NO_RANDOMIZE personality

Cornelia Huck (2):
      vfio-ccw: make convert_ccw0_to_ccw1 static
      s390/cio: introduce driver_override on the css bus

Dan Carpenter (1):
      s390/dasd: Fix a precision vs width bug in dasd_feature_list()

David Hildenbrand (4):
      s390/pkey: Use -ENODEV instead of -EOPNOTSUPP
      s390/crypto: ghash: Use -ENODEV instead of -EOPNOTSUPP
      s390/crypto: prng: Use -ENODEV instead of -EOPNOTSUPP
      s390/crypto: sha: Use -ENODEV instead of -EOPNOTSUPP

Enrico Weigelt, metux IT consult (1):
      s390/Kconfig: pedantic cleanups

Eric Farman (22):
      s390/cio: Update SCSW if it points to the end of the chain
      s390/cio: Set vfio-ccw FSM state before ioeventfd
      s390/cio: Split pfn_array_alloc_pin into pieces
      s390/cio: Initialize the host addresses in pfn_array
      s390/cio: Don't pin vfio pages for empty transfers
      s390/cio: Allow zero-length CCWs in vfio-ccw
      s390/cio: Remove vfio-ccw checks of command codes
      s390/cio: Squash cp_free() and cp_unpin_free()
      s390/cio: Refactor the routine that handles TIC CCWs
      s390/cio: Generalize the TIC handler
      s390/cio: Use generalized CCW handler in cp_init()
      vfio-ccw: Rearrange pfn_array and pfn_array_table arrays
      vfio-ccw: Adjust the first IDAW outside of the nested loops
      vfio-ccw: Remove pfn_array_table
      vfio-ccw: Rearrange IDAL allocation in direct CCW
      s390/cio: Combine direct and indirect CCW paths
      vfio-ccw: Move guest_cp storage into common struct
      vfio-ccw: Skip second copy of guest cp to host
      vfio-ccw: Copy CCW data outside length calculation
      vfio-ccw: Factor out the ccw0-to-ccw1 transition
      vfio-ccw: Remove copy_ccw_from_iova()
      vfio-ccw: Fix the conversion of Format-0 CCWs to Format-1

Halil Pasic (8):
      s390/mm: force swiotlb for protected virtualization
      s390/cio: introduce DMA pools to cio
      s390/cio: add basic protected virtualization support
      s390/airq: use DMA memory for adapter interrupts
      virtio/s390: use cacheline aligned airq bit vectors
      virtio/s390: add indirection to indicators access
      virtio/s390: use DMA memory for ccw I/O and classic notifiers
      virtio/s390: make airq summary indicators DMA

Harald Freudenberger (1):
      s390/zcrypt: support special flagged EP11 cprbs

Heiko Carstens (11):
      Merge tag 'vfio-ccw-20190603' of https://git.kernel.org/.../kvms390/vfio-ccw into features
      s390: enforce CONFIG_SMP
      s390: enforce CONFIG_HOTPLUG_CPU
      s390/boot: disable address-of-packed-member warning
      s390/jump_label: remove unused structure definition
      s390/kdump: get rid of compile warning
      processor: remove spin_cpu_yield
      processor: get rid of cpu_relax_yield
      s390: replace defconfig with performance_defconfig
      s390/sclp: remove call home support
      s390: fix stfle zero padding

Julian Wiedmann (4):
      s390/qdio: handle PENDING state for QEBSM devices
      s390/cio: move struct node_descriptor to cio.h
      s390/qdio: (re-)initialize tiqdio list entries
      s390/qdio: don't touch the dsci in tiqdio_add_input_queues()

Krzysztof Kozlowski (1):
      s390/configs: remove useless UEVENT_HELPER_PATH

Martin Schwidefsky (4):
      s390/jump_label: replace stop_machine with smp_call_function
      s390/disassembler: update opcode table
      s390: improve wait logic of stop_machine
      Update default configuration

Masahiro Yamada (6):
      s390: do not pass $(LINUXINCLUDE) to gen_opcode_table.c
      s390: drop unneeded -Wall addition from tools Makefile
      s390: drop redundant directory creation from tools Makefile
      s390: drop meaningless 'targets' from tools Makefile
      s390/purgatory: update .gitignore
      s390: fix unrecognized __aligned() in uapi header

Mauro Carvalho Chehab (3):
      docs: Debugging390.txt: convert table to ascii artwork
      docs: s390: convert docs to ReST and rename to *.rst
      s390: include/asm/debug.h add kerneldoc markups

Pierre Morel (4):
      s390: ap: kvm: add PQAP interception for AQIC
      vfio: ap: register IOMMU VFIO notifier
      s390: ap: implement PAPQ AQIC interception in kernel
      s390: ap: kvm: Enable PQAP/AQIC facility for the guest

Sebastian Ott (3):
      s390/cio: fix kdoc for tiqdio_thinint_handler
      s390/pci: deal with devices that have no support for MIO instructions
      s390/pci: correctly handle MIO opt-out

Steffen Maier (3):
      docs: s390: restore important non-kdoc parts of s390dbf.rst
      docs: s390: unify and update s390dbf kdocs at debug.c
      docs: s390: s390dbf: typos and formatting, update crash command

Vasily Gorbik (6):
      RAID/s390: remove invalid 'r' inline asm operand modifier
      s390/traps: simplify data exception handler
      Merge tag 'vfio-ccw-20190621' of https://git.kernel.org/.../kvms390/vfio-ccw into features
      s390/kasan: avoid false positives during stack unwind
      s390/unwind: cleanup unused READ_ONCE_TASK_STACK
      Merge tag 'vfio-ccw-20190705' of https://git.kernel.org/.../kvms390/vfio-ccw into features

xiaolinkui (1):
      s390/idal: use struct_size() in kmalloc()

 Documentation/ABI/testing/sysfs-bus-css            |   23 +
 Documentation/admin-guide/kernel-parameters.txt    |    4 +-
 Documentation/driver-api/s390-drivers.rst          |    4 +-
 Documentation/s390/{3270.txt => 3270.rst}          |   85 +-
 Documentation/s390/Debugging390.txt                | 2142 ----------------
 Documentation/s390/{cds.txt => cds.rst}            |  368 +--
 Documentation/s390/{CommonIO => common_io.rst}     |   49 +-
 Documentation/s390/{DASD => dasd.rst}              |   33 +-
 Documentation/s390/debugging390.rst                | 2613 ++++++++++++++++++++
 .../s390/{driver-model.txt => driver-model.rst}    |  179 +-
 Documentation/s390/index.rst                       |   30 +
 .../s390/{monreader.txt => monreader.rst}          |   85 +-
 Documentation/s390/{qeth.txt => qeth.rst}          |   36 +-
 Documentation/s390/s390dbf.rst                     |  487 ++++
 Documentation/s390/s390dbf.txt                     |  667 -----
 Documentation/s390/text_files.rst                  |   11 +
 Documentation/s390/{vfio-ap.txt => vfio-ap.rst}    |  499 ++--
 Documentation/s390/{vfio-ccw.txt => vfio-ccw.rst}  |   92 +-
 Documentation/s390/{zfcpdump.txt => zfcpdump.rst}  |    2 +
 Documentation/sysctl/kernel.txt                    |   16 -
 MAINTAINERS                                        |    4 +-
 arch/powerpc/include/asm/processor.h               |    2 -
 arch/s390/Kconfig                                  |   41 +-
 arch/s390/Makefile                                 |    1 +
 arch/s390/configs/debug_defconfig                  |    2 +
 arch/s390/configs/defconfig                        |  600 ++++-
 arch/s390/configs/performance_defconfig            |  678 -----
 arch/s390/configs/zfcpdump_defconfig               |    1 -
 arch/s390/crypto/ghash_s390.c                      |    2 +-
 arch/s390/crypto/prng.c                            |    4 +-
 arch/s390/crypto/sha1_s390.c                       |    2 +-
 arch/s390/crypto/sha256_s390.c                     |    2 +-
 arch/s390/crypto/sha512_s390.c                     |    2 +-
 arch/s390/include/asm/airq.h                       |    2 +
 arch/s390/include/asm/ccwdev.h                     |    4 +
 arch/s390/include/asm/cio.h                        |   41 +
 arch/s390/include/asm/ctl_reg.h                    |    9 +-
 arch/s390/include/asm/debug.h                      |  153 +-
 arch/s390/include/asm/facility.h                   |   21 +-
 arch/s390/include/asm/idals.h                      |    3 +-
 arch/s390/include/asm/kvm_host.h                   |    7 +
 arch/s390/include/asm/mem_encrypt.h                |   17 +
 arch/s390/include/asm/pci.h                        |    5 +
 arch/s390/include/asm/percpu.h                     |    2 +-
 arch/s390/include/asm/processor.h                  |    7 +-
 arch/s390/include/asm/smp.h                        |   35 -
 arch/s390/include/asm/spinlock.h                   |    4 -
 arch/s390/include/asm/tlbflush.h                   |   17 -
 arch/s390/include/asm/unwind.h                     |   19 -
 arch/s390/include/uapi/asm/runtime_instr.h         |    2 +-
 arch/s390/kernel/Makefile                          |    2 +-
 arch/s390/kernel/debug.c                           |  105 +-
 arch/s390/kernel/dis.c                             |    5 +-
 arch/s390/kernel/dumpstack.c                       |    2 -
 arch/s390/kernel/entry.S                           |    4 -
 arch/s390/kernel/jump_label.c                      |   23 +-
 arch/s390/kernel/machine_kexec.c                   |    3 +-
 arch/s390/kernel/processor.c                       |   19 +-
 arch/s390/kernel/setup.c                           |    2 -
 arch/s390/kernel/smp.c                             |   21 +-
 arch/s390/kernel/swsusp.S                          |    2 -
 arch/s390/kernel/traps.c                           |   10 +-
 arch/s390/kernel/unwind_bc.c                       |   16 +-
 arch/s390/kvm/kvm-s390.c                           |    3 +
 arch/s390/kvm/priv.c                               |   86 +
 arch/s390/lib/Makefile                             |    3 +-
 arch/s390/mm/init.c                                |   47 +
 arch/s390/mm/maccess.c                             |    9 +-
 arch/s390/mm/mmap.c                                |    2 -
 arch/s390/pci/pci.c                                |   15 +-
 arch/s390/pci/pci_clp.c                            |    2 +-
 arch/s390/purgatory/.gitignore                     |    3 +-
 arch/s390/tools/Makefile                           |    7 +-
 arch/s390/tools/opcodes.txt                        |   51 +-
 drivers/s390/block/Kconfig                         |    2 +-
 drivers/s390/block/dasd_devmap.c                   |    2 +-
 drivers/s390/char/Kconfig                          |   22 -
 drivers/s390/char/Makefile                         |    1 -
 drivers/s390/char/sclp_async.c                     |  189 --
 drivers/s390/char/zcore.c                          |    2 +-
 drivers/s390/cio/airq.c                            |   37 +-
 drivers/s390/cio/ccwreq.c                          |    9 +-
 drivers/s390/cio/chsc.c                            |   30 -
 drivers/s390/cio/cio.h                             |    3 +
 drivers/s390/cio/css.c                             |  187 +-
 drivers/s390/cio/device.c                          |   68 +-
 drivers/s390/cio/device_fsm.c                      |   49 +-
 drivers/s390/cio/device_id.c                       |   20 +-
 drivers/s390/cio/device_ops.c                      |   21 +-
 drivers/s390/cio/device_pgid.c                     |   22 +-
 drivers/s390/cio/device_status.c                   |   24 +-
 drivers/s390/cio/io_sch.h                          |   20 +-
 drivers/s390/cio/qdio_main.c                       |    1 +
 drivers/s390/cio/qdio_setup.c                      |    2 +
 drivers/s390/cio/qdio_thinint.c                    |    6 +-
 drivers/s390/cio/vfio_ccw_cp.c                     |  524 ++--
 drivers/s390/cio/vfio_ccw_cp.h                     |    7 +
 drivers/s390/cio/vfio_ccw_drv.c                    |   13 +-
 drivers/s390/crypto/pkey_api.c                     |    8 +-
 drivers/s390/crypto/vfio_ap_drv.c                  |   34 +-
 drivers/s390/crypto/vfio_ap_ops.c                  |  380 ++-
 drivers/s390/crypto/vfio_ap_private.h              |   15 +
 drivers/s390/crypto/zcrypt_msgtype6.c              |    4 +
 drivers/s390/net/Kconfig                           |    8 +-
 drivers/s390/virtio/virtio_ccw.c                   |  246 +-
 include/linux/processor.h                          |    9 -
 include/linux/sched.h                              |    4 -
 include/linux/stop_machine.h                       |    1 +
 kernel/stop_machine.c                              |   19 +-
 lib/raid6/s390vx.uc                                |    2 +-
 110 files changed, 6308 insertions(+), 5239 deletions(-)
 rename Documentation/s390/{3270.txt => 3270.rst} (90%)
 delete mode 100644 Documentation/s390/Debugging390.txt
 rename Documentation/s390/{cds.txt => cds.rst} (64%)
 rename Documentation/s390/{CommonIO => common_io.rst} (87%)
 rename Documentation/s390/{DASD => dasd.rst} (92%)
 create mode 100644 Documentation/s390/debugging390.rst
 rename Documentation/s390/{driver-model.txt => driver-model.rst} (73%)
 create mode 100644 Documentation/s390/index.rst
 rename Documentation/s390/{monreader.txt => monreader.rst} (81%)
 rename Documentation/s390/{qeth.txt => qeth.rst} (62%)
 create mode 100644 Documentation/s390/s390dbf.rst
 delete mode 100644 Documentation/s390/s390dbf.txt
 create mode 100644 Documentation/s390/text_files.rst
 rename Documentation/s390/{vfio-ap.txt => vfio-ap.rst} (72%)
 rename Documentation/s390/{vfio-ccw.txt => vfio-ccw.rst} (89%)
 rename Documentation/s390/{zfcpdump.txt => zfcpdump.rst} (97%)
 delete mode 100644 arch/s390/configs/performance_defconfig
 create mode 100644 arch/s390/include/asm/mem_encrypt.h
 delete mode 100644 drivers/s390/char/sclp_async.c
