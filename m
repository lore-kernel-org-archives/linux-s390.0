Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60826 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404567AbgJPLAt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 16 Oct 2020 07:00:49 -0400
Date: Fri, 16 Oct 2020 13:00:38 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [GIT PULL] s390 patches for the 5.10 merge window
Message-ID: <your-ad-here.call-01602846038-ext-6012@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.10.

The following changes since commit d012a7190fc1fd72ed48911e77ca97ba4521bccd:

  Linux 5.9-rc2 (2020-08-23 14:08:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.10-1

for you to fetch changes up to 10e5afb3d260f2d2521889d87ebdefb7fc3d4087:

  s390/uaccess: fix indentation (2020-10-09 23:45:30 +0200)

Please note 2 minor merge conflict resolutions below:

diff --cc arch/s390/include/asm/checksum.h
index 6813bfa1eeb7,c401a5fd3ad2..a8c02cfbc712
--- a/arch/s390/include/asm/checksum.h
+++ b/arch/s390/include/asm/checksum.h
@@@ -39,8 -39,15 +39,8 @@@ static inline __wsum csum_partial(cons
  	return sum;
  }
  
 -static inline __wsum csum_partial_copy_nocheck(const void *src, void *dst,
 -					       int len, __wsum sum)
 -{
 -	memcpy(dst, src, len);
 -	return csum_partial(dst, len, sum);
 -}
 -
  /*
-  *      Fold a partial checksum without adding pseudo headers
+  * Fold a partial checksum without adding pseudo headers.
   */
  static inline __sum16 csum_fold(__wsum sum)
  {

The second potential one is with the vfio tree:

diff --cc arch/s390/pci/pci_bus.c
index c93486a9989b,0c0db7c3a404..755b46f4c595
--- a/arch/s390/pci/pci_bus.c
+++ b/arch/s390/pci/pci_bus.c
@@@ -197,10 -135,9 +135,10 @@@ void pcibios_bus_add_device(struct pci_
  	 * With pdev->no_vf_scan the common PCI probing code does not
  	 * perform PF/VF linking.
  	 */
 -	if (zdev->vfn)
 +	if (zdev->vfn) {
- 		zpci_bus_setup_virtfn(zdev->zbus, pdev, zdev->vfn);
+ 		zpci_iov_setup_virtfn(zdev->zbus, pdev, zdev->vfn);
 -
 +		pdev->no_command_memory = 1;
 +	}
  }
  
  static int zpci_bus_add_device(struct zpci_bus *zbus, struct zpci_dev *zdev)

Thank you,
Vasily

----------------------------------------------------------------
s390 updates for the 5.10 merge window

- Remove address space overrides using set_fs().

- Convert to generic vDSO.

- Convert to generic page table dumper.

- Add ARCH_HAS_DEBUG_WX support.

- Add leap seconds handling support.

- Add NVMe firmware-assisted kernel dump support.

- Extend NVMe boot support with memory clearing control and addition of
  kernel parameters.

- AP bus and zcrypt api code rework. Add adapter configure/deconfigure
  interface. Extend debug features. Add failure injection support.

- Add ECC secure private keys support.

- Add KASan support for running protected virtualization host with
  4-level paging.

- Utilize destroy page ultravisor call to speed up secure guests shutdown.

- Implement ioremap_wc() and ioremap_prot() with MIO in PCI code.

- Various checksum improvements.

- Other small various fixes and improvements all over the code.

----------------------------------------------------------------
Alexander Egorenkov (3):
      s390/boot: enable .bss section for compressed kernel
      s390/ipl: support NVMe IPL kernel parameters
      s390/nvme: support firmware-assisted dump to NVMe disks

Gerald Schaefer (1):
      s390/ipl: add support to control memory clearing for nvme re-IPL

Harald Freudenberger (15):
      s390/zcrypt: simplify cca_findcard2 loop code
      s390/zcrypt: remove set_fs() invocation in zcrypt device driver
      s390/zcrypt: Support for CCA APKA master keys
      s390/pkey: support CCA and EP11 secure ECC private keys
      s390/zcrypt: introduce msg tracking in zcrypt functions
      s390/zcrypt: New config switch CONFIG_ZCRYPT_DEBUG
      s390/ap: split ap queue state machine state from device state
      s390/ap: add error response code field for ap queue devices
      s390/ap: add card/queue deconfig state
      s390/sclp: Add support for SCLP AP adapter config/deconfig
      s390/ap: Support AP card SCLP config and deconfig operations
      s390/ap/zcrypt: revisit ap and zcrypt error handling
      s390/zcrypt: move ap_msg param one level up the call chain
      s390/zcrypt: Introduce Failure Injection feature
      s390/zcrypt: fix wrong format specifications

Heiko Carstens (17):
      s390/checksum: provide csum_ipv6_magic()
      s390/checksum: rewrite csum_tcpudp_nofold()
      s390/checksum: make ip_fast_csum() faster
      s390/checksum: have consistent calculations
      s390/checksum: coding style changes
      s390/mm,ptdump: convert to generic page table dumper
      s390/mm,ptdump: hold memory hotplug lock while walking for kernel page table dump
      s390/mm,ptdump: hold cpa mutex while walking for kernel page table dump
      s390/kprobes: make insn pages read-only
      s390/mm,ptdump: make page table dumping seq_file optional
      s390: add ARCH_HAS_DEBUG_WX support
      s390/mm,ptdump: add proper ifdefs
      s390/dis: get rid of set_fs() usage
      s390/uaccess: add HAVE_GET_KERNEL_NOFAULT support
      s390/kprobes: move insn_page to text segment
      s390/uaccess: add default cases for __put_user_fn()/__get_user_fn()
      s390/uaccess: fix indentation

Janosch Frank (1):
      s390/uv: add destroy page call

Jason J. Herne (1):
      s390: nvme dump support

Julian Wiedmann (5):
      s390/qdio: make qdio_handle_aobs() more robust
      s390/qdio: clean up QDR setup
      s390/qdio: always use dev_name() for device name in QIB
      s390/lib: fix kernel doc for memcmp()
      s390/sie: fix typo in SIGP code description

Liu Shixin (1):
      s390/diag: convert to use DEFINE_SEQ_ATTRIBUTE macro

Niklas Schnelle (6):
      s390/pci: Implement ioremap_wc/prot() with MIO
      s390/pci: consolidate SR-IOV specific code
      s390/pci: remove unused function zpci_rescan()
      s390/pci: remove clp_rescan_pci_devices()
      s390/pci: remove clp_rescan_pci_devices_simple()
      s390/pci: add missing pci_iov.h include

Qinglang Miao (2):
      s390/ap: remove unnecessary spin_lock_init()
      s390/3215: simplify the return expression of tty3215_open()

Sven Schnelle (9):
      s390: convert to GENERIC_VDSO
      s390: disable branch profiling for vdso
      s390/stp: add locking to sysfs functions
      s390/stp: use __packed
      s390/stp: use u32 instead of unsigned int
      s390/stp: add support for leap seconds
      s390/stp: add sysfs file to show scheduled leap seconds
      s390/stp: unify stp_work_mutex and clock_sync_mutex
      s390: remove cad commandline option

Vasily Gorbik (24):
      s390/kasan: make shadow memory noexec
      s390/mm,ptdump: add couple of additional markers
      s390/mm,ptdump: sort markers
      s390/kasan: avoid unnecessary moving of vmemmap
      s390/protvirt: parse prot_virt option in the decompressor
      s390/protvirt: support ultravisor without secure storage limit
      s390/kasan: support protvirt with 4-level paging
      s390/boot: avoid unnecessary zeroing of .bss section
      s390/sclp: clean up unneeded .data section usage
      s390/sclp: remove unused sclp_early_printk_forced
      s390/kaslr: avoid mixing valid random value and an error code
      s390/kaslr: correct and explain randomization base generation
      s390: remove unused _swsusp_reset_dma
      s390/startup: avoid save_area_sync overflow
      s390/cio: remove unused channel_subsystem_reinit
      s390/vdso: remove orphaned declarations
      s390/startup: correct "dfltcc" option parsing
      s390/sclp_sdias: remove unused sclp_sdias_exit
      s390/sclp: remove orphaned sclp_set_columns and sclp_set_htab
      s390/startup: add kaslr_offset to pgm check info print
      s390: remove orphaned function declarations
      s390/kasan: make sure int handler always run with DAT on
      s390: remove orphaned extern variables declarations
      s390/startup: correct early pgm check info formatting

 .../features/vm/ioremap_prot/arch-support.txt      |   2 +-
 arch/s390/Kconfig                                  |   5 +
 arch/s390/Kconfig.debug                            |  12 -
 arch/s390/boot/Makefile                            |   4 -
 arch/s390/boot/compressed/Makefile                 |   4 -
 arch/s390/boot/compressed/decompressor.c           |   1 -
 arch/s390/boot/compressed/vmlinux.lds.S            |  22 +-
 arch/s390/boot/head.S                              |  21 +-
 arch/s390/boot/ipl_parm.c                          |  60 ++-
 arch/s390/boot/kaslr.c                             | 138 ++++---
 arch/s390/boot/pgm_check_info.c                    |  11 +-
 arch/s390/boot/startup.c                           |   5 +-
 arch/s390/boot/text_dma.S                          |  17 -
 arch/s390/boot/uv.c                                |   3 +
 arch/s390/configs/debug_defconfig                  |   3 +-
 arch/s390/configs/defconfig                        |   3 +-
 arch/s390/include/asm/checksum.h                   | 111 +++---
 arch/s390/include/asm/cio.h                        |   2 +-
 arch/s390/include/asm/clocksource.h                |   7 +
 arch/s390/include/asm/clp.h                        |   3 +
 arch/s390/include/asm/gmap.h                       |   2 -
 arch/s390/include/asm/io.h                         |   8 +
 arch/s390/include/asm/ipl.h                        |   7 +
 arch/s390/include/asm/kasan.h                      |   1 +
 arch/s390/include/asm/pci.h                        |   6 +-
 arch/s390/include/asm/pci_clp.h                    |  19 +
 arch/s390/include/asm/pgalloc.h                    |   2 -
 arch/s390/include/asm/pgtable.h                    |  10 +-
 arch/s390/include/asm/ptdump.h                     |  14 +
 arch/s390/include/asm/qdio.h                       |  10 +-
 arch/s390/include/asm/sclp.h                       |   5 +-
 arch/s390/include/asm/set_memory.h                 |   4 +
 arch/s390/include/asm/setup.h                      |   7 +-
 arch/s390/include/asm/smp.h                        |   1 -
 arch/s390/include/asm/stp.h                        | 100 +++--
 arch/s390/include/asm/tlbflush.h                   |   2 -
 arch/s390/include/asm/uaccess.h                    | 126 ++++++-
 arch/s390/include/asm/uv.h                         |   7 +
 arch/s390/include/asm/vdso.h                       |  27 +-
 arch/s390/include/asm/vdso/clocksource.h           |   8 +
 arch/s390/include/asm/vdso/data.h                  |  13 +
 arch/s390/include/asm/vdso/gettimeofday.h          |  71 ++++
 arch/s390/include/asm/vdso/processor.h             |   7 +
 arch/s390/include/asm/vdso/vdso.h                  |   0
 arch/s390/include/asm/vdso/vsyscall.h              |  26 ++
 arch/s390/include/asm/vtimer.h                     |   2 -
 arch/s390/include/uapi/asm/pkey.h                  |  77 +++-
 arch/s390/include/uapi/asm/sie.h                   |   2 +-
 arch/s390/kernel/Makefile                          |   1 +
 arch/s390/kernel/asm-offsets.c                     |  20 -
 arch/s390/kernel/crash_dump.c                      |  16 +-
 arch/s390/kernel/diag.c                            |  13 +-
 arch/s390/kernel/dis.c                             |  22 +-
 arch/s390/kernel/early.c                           |  13 -
 arch/s390/kernel/early_printk.c                    |   2 +-
 arch/s390/kernel/entry.S                           |   6 -
 arch/s390/kernel/entry.h                           |   6 +-
 arch/s390/kernel/ipl.c                             | 119 +++++-
 arch/s390/kernel/kprobes.c                         |  59 ++-
 arch/s390/kernel/kprobes_insn_page.S               |  22 ++
 arch/s390/kernel/setup.c                           |  62 +--
 arch/s390/kernel/smp.c                             |  12 +-
 arch/s390/kernel/time.c                            | 318 ++++++++++------
 arch/s390/kernel/uv.c                              |  66 ++--
 arch/s390/kernel/vdso.c                            |  29 +-
 arch/s390/kernel/vdso64/Makefile                   |  21 +-
 arch/s390/kernel/vdso64/clock_getres.S             |  50 ---
 arch/s390/kernel/vdso64/clock_gettime.S            | 163 --------
 arch/s390/kernel/vdso64/gettimeofday.S             |  71 ----
 arch/s390/kernel/vdso64/vdso64_generic.c           |  18 +
 arch/s390/kernel/vdso64/vdso_user_wrapper.S        |  38 ++
 arch/s390/lib/string.c                             |   2 +-
 arch/s390/mm/Makefile                              |   2 +-
 arch/s390/mm/dump_pagetables.c                     | 360 +++++++++---------
 arch/s390/mm/gmap.c                                |   2 +-
 arch/s390/mm/init.c                                |   2 +
 arch/s390/mm/kasan_init.c                          |  44 ++-
 arch/s390/mm/pageattr.c                            |   2 +-
 arch/s390/mm/pgtable.c                             |  20 +
 arch/s390/pci/Makefile                             |   1 +
 arch/s390/pci/pci.c                                |  59 +--
 arch/s390/pci/pci_bus.c                            |  66 +---
 arch/s390/pci/pci_bus.h                            |  13 -
 arch/s390/pci/pci_clp.c                            |  85 +++--
 arch/s390/pci/pci_event.c                          |   3 +-
 arch/s390/pci/pci_iov.c                            |  99 +++++
 arch/s390/pci/pci_iov.h                            |  30 ++
 arch/s390/scripts/Makefile.chkbss                  |  20 -
 drivers/crypto/Kconfig                             |  24 +-
 drivers/s390/char/Makefile                         |   2 +
 drivers/s390/char/con3215.c                        |   7 +-
 drivers/s390/char/raw3270.h                        |   1 -
 drivers/s390/char/sclp.h                           |   4 +-
 drivers/s390/char/sclp_ap.c                        |  63 ++++
 drivers/s390/char/sclp_early_core.c                |  15 +-
 drivers/s390/char/sclp_rw.c                        |  18 -
 drivers/s390/char/sclp_rw.h                        |   2 -
 drivers/s390/char/sclp_sdias.c                     |   8 +-
 drivers/s390/char/tape.h                           |   3 -
 drivers/s390/char/tape_std.h                       |  12 -
 drivers/s390/char/zcore.c                          |  17 +-
 drivers/s390/cio/chsc.c                            |  21 ++
 drivers/s390/cio/css.c                             |  14 -
 drivers/s390/cio/device.h                          |   1 -
 drivers/s390/cio/qdio_main.c                       |  43 +--
 drivers/s390/cio/qdio_setup.c                      |  38 +-
 drivers/s390/crypto/ap_bus.c                       | 411 +++++++++++++-------
 drivers/s390/crypto/ap_bus.h                       |  54 ++-
 drivers/s390/crypto/ap_card.c                      |  34 ++
 drivers/s390/crypto/ap_debug.h                     |   8 +
 drivers/s390/crypto/ap_queue.c                     | 252 ++++++++++---
 drivers/s390/crypto/pkey_api.c                     | 262 +++++++++++--
 drivers/s390/crypto/zcrypt_api.c                   | 416 +++++++++++++++------
 drivers/s390/crypto/zcrypt_api.h                   |  49 ++-
 drivers/s390/crypto/zcrypt_card.c                  |  12 +-
 drivers/s390/crypto/zcrypt_ccamisc.c               | 411 ++++++++++++++------
 drivers/s390/crypto/zcrypt_ccamisc.h               |  74 +++-
 drivers/s390/crypto/zcrypt_cex2a.c                 |   6 +-
 drivers/s390/crypto/zcrypt_cex2c.c                 |  45 ++-
 drivers/s390/crypto/zcrypt_cex4.c                  |  97 +++--
 drivers/s390/crypto/zcrypt_debug.h                 |   8 +
 drivers/s390/crypto/zcrypt_ep11misc.c              | 312 ++++++++++++----
 drivers/s390/crypto/zcrypt_ep11misc.h              |  63 +++-
 drivers/s390/crypto/zcrypt_error.h                 |  88 ++---
 drivers/s390/crypto/zcrypt_msgtype50.c             | 131 ++++---
 drivers/s390/crypto/zcrypt_msgtype6.c              | 264 +++++++------
 drivers/s390/crypto/zcrypt_msgtype6.h              |   4 +-
 drivers/s390/crypto/zcrypt_queue.c                 |  11 +-
 drivers/s390/scsi/zfcp_qdio.c                      |   2 -
 129 files changed, 4097 insertions(+), 2165 deletions(-)
 create mode 100644 arch/s390/include/asm/clocksource.h
 create mode 100644 arch/s390/include/asm/ptdump.h
 create mode 100644 arch/s390/include/asm/vdso/clocksource.h
 create mode 100644 arch/s390/include/asm/vdso/data.h
 create mode 100644 arch/s390/include/asm/vdso/gettimeofday.h
 create mode 100644 arch/s390/include/asm/vdso/processor.h
 create mode 100644 arch/s390/include/asm/vdso/vdso.h
 create mode 100644 arch/s390/include/asm/vdso/vsyscall.h
 create mode 100644 arch/s390/kernel/kprobes_insn_page.S
 delete mode 100644 arch/s390/kernel/vdso64/clock_getres.S
 delete mode 100644 arch/s390/kernel/vdso64/clock_gettime.S
 delete mode 100644 arch/s390/kernel/vdso64/gettimeofday.S
 create mode 100644 arch/s390/kernel/vdso64/vdso64_generic.c
 create mode 100644 arch/s390/kernel/vdso64/vdso_user_wrapper.S
 create mode 100644 arch/s390/pci/pci_iov.c
 create mode 100644 arch/s390/pci/pci_iov.h
 delete mode 100644 arch/s390/scripts/Makefile.chkbss
 create mode 100644 drivers/s390/char/sclp_ap.c
