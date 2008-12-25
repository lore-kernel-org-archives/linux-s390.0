Return-Path: <linux-kernel-owner+w=401wt.eu-S1752077AbYLYMuG@vger.kernel.org>
Subject: [GIT PULL] s390 patches for 2.6.29
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
Content-Type: text/plain
Date: Thu, 25 Dec 2008 13:49:02 +0100
Message-Id: <1230209342.22957.1.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Ho ho ho,
Santa Linus brought a present, here is one in return ;-)

please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

Al Viro (1):
      [S390] audit: get s390 ret_from_fork in sync with other architectures

Christian Borntraeger (3):
      [S390] vmcp: remove BKL
      [S390] convert vmcp printks to pr_xxx macros.
      [S390] convert cpcmd printks to pr_xxx macros.

Christian Maaser (1):
      [S390] ap: Minor code beautification.

Christof Schmitt (2):
      [S390] zfcp: Report microcode level through service level interface
      [S390] convert zfcp printks to pr_xxx macros.

Cornelia Huck (8):
      [S390] dasd: Use accessors instead of using driver_data directly.
      [S390] cio: Put referernce on correct device after moving.
      [S390] cio: Fix reference counting for online/offline.
      [S390] cio: Fix I/O subchannel refcounting.
      [S390] cio: Only register ccw_device for registered subchannel.
      [S390] cio: Dont fail probe for I/O subchannels.
      [S390] cio: Dont call ->release directly.
      [S390] cio: Use device_is_registered().

Felix Beck (1):
      [S390] zcrypt: Use of Thin Interrupts

Frank Blaschka (1):
      [S390] convert qeth printks to dev_xxx and pr_xxx macros.

Frank Munzert (1):
      [S390] convert vmur printks to pr_xxx macros.

Gerald Schaefer (2):
      [S390] convert appldata printks to pr_xxx macros.
      [S390] convert monreader printks to pr_xxx macros.

Harvey Harrison (1):
      [S390] s390: use the new byteorder headers

Heiko Carstens (12):
      [S390] cpu topology: fix cpu_core_map initialization
      [S390] cpu topology: dont destroy cpu sets on topology change
      [S390] convert etr/stp to stop_machine interface
      [S390] convert s390 to generic IPI infrastructure
      [S390] Move stfle to header file.
      [S390] ftrace: function tracer backend for s390
      [S390] cio: get rid of compile warning
      [S390] mark disabled_wait as noreturn function
      [S390] sclp vt220: fix compile warning
      [S390] Remove initial kernel stack backchain initialization.
      [S390] cpu topology: introduce kernel parameter
      [S390] cpu topology: remove dead code

Hendrik Brueckner (4):
      [S390] s390/hvc_console: z/VM IUCV hypervisor console support
      [S390] iucv: Locking free version of iucv_message_(receive|send)
      [S390] s390/setup: set default preferred console device "ttyS"
      [S390] provide documentation for hvc_iucv kernel parameter.

Hongjie Yang (1):
      [S390] convert dcssblk and extmem printks messages to pr_xxx macros.

Jan Glauber (7):
      [S390] qdio: fix qeth port count detection
      [S390] qdio: add eqbs/sqbs instruction counters
      [S390] qdio: fix compile warning under 31 bit
      [S390] qdio: rework debug feature logging
      [S390] qdio: improve inbound buffer acknowledgement
      [S390] qdio: fix error reporting for hipersockets
      [S390] convert cpacf printks to pr_xxx macros.

Julia Lawall (2):
      [S390] drivers/s390/crypto: Move dereference to after IS_ERR test
      [S390] s390: Remove redundant test

Kay Sievers (1):
      [S390] struct device - replace bus_id with dev_name(), dev_set_name()

Klaus-D. Wacker (1):
      [S390] convert lcs printks to dev_xxx and pr_xxx macros.

Martin Schwidefsky (19):
      [S390] arch_setup_additional_pages arguments
      [S390] introduce vdso on s390
      [S390] serialize stp/etr work
      [S390] service level interface.
      [S390] __page_to_pfn warnings
      [S390] remove ptrace warning on 31 bit.
      [S390] remove warnings with functions ending in BUG
      [S390] Add processor type march=z10 and a processor type safety check.
      [S390] add new machine types to setup_hwcaps.
      [S390] Remove config options.
      [S390] clear_table inline assembly contraints
      [S390] panic_stack leak in smp_alloc_lowcore
      [S390] convert xpram printks to pr_xxx macros.
      [S390] convert time printks to pr_xxx macros.
      [S390] convert setup printks to pr_xxx macros.
      [S390] convert ap_bus printks to pr_xxx macros.
      [S390] convert sclp printks to pr_xxx macros.
      [S390] convert cpu related printks to pr_xxx macros.
      [S390] convert vmlogrdr printks to pr_xxx macros.

Melissa Howland (1):
      [S390] convert monwriter printks to pr_xxx macros.

Michael Ernst (1):
      [S390] convert cio printks to pr_xxx macros.

Michael Holzheu (3):
      [S390] convert hypfs printks to pr_xxx macros.
      [S390] convert s390 debug feature printks to pr_xxx macros.
      [S390] convert zfcp dumper printks to pr_xxx macros.

Peter Oberparleiter (2):
      [S390] cio: update sac values
      [S390] cio: fix ccwgroup online vs. ungroup race condition

Peter Tiedemann (1):
      [S390] convert ctcm printks to dev_xxx and pr_xxx macros.

Sebastian Ott (5):
      [S390] cio: move irritating comment.
      [S390] cio: introduce cio_update_schib
      [S390] cio: introduce cio_commit_config
      [S390] cio: commit all pmcw changes.
      [S390] cio: use pim to check for multipath.

Stefan Haberland (3):
      [S390] dasd: improve dasd statistics proc interface
      [S390] dasd: correct sense byte condition for SIM
      [S390] dasd: call cleanup_cqr with request_queue_lock

Ursula Braun (1):
      [S390] convert iucv printks to dev_xxx and pr_xxx macros.

 Documentation/kernel-parameters.txt      |   11 +
 arch/powerpc/include/asm/elf.h           |    2 +-
 arch/powerpc/kernel/vdso.c               |    3 +-
 arch/s390/Kconfig                        |   41 +-
 arch/s390/Makefile                       |    1 +
 arch/s390/appldata/appldata.h            |    4 -
 arch/s390/appldata/appldata_base.c       |   12 +-
 arch/s390/appldata/appldata_os.c         |   21 +-
 arch/s390/crypto/aes_s390.c              |   14 +-
 arch/s390/hypfs/hypfs_diag.c             |   10 +-
 arch/s390/hypfs/inode.c                  |   14 +-
 arch/s390/include/asm/auxvec.h           |    2 +
 arch/s390/include/asm/bug.h              |    5 +-
 arch/s390/include/asm/byteorder.h        |   72 +--
 arch/s390/include/asm/elf.h              |   16 +
 arch/s390/include/asm/fcx.h              |    4 +-
 arch/s390/include/asm/ftrace.h           |    8 +
 arch/s390/include/asm/isc.h              |    1 +
 arch/s390/include/asm/mmu.h              |    1 +
 arch/s390/include/asm/page.h             |    2 +
 arch/s390/include/asm/pgalloc.h          |    5 +-
 arch/s390/include/asm/processor.h        |    4 +-
 arch/s390/include/asm/qdio.h             |   16 +-
 arch/s390/include/asm/sigp.h             |    1 +
 arch/s390/include/asm/smp.h              |    5 +-
 arch/s390/include/asm/sysinfo.h          |   11 +
 arch/s390/include/asm/system.h           |   24 +-
 arch/s390/include/asm/timer.h            |    9 -
 arch/s390/include/asm/vdso.h             |   39 ++
 arch/s390/kernel/Makefile                |   18 +-
 arch/s390/kernel/asm-offsets.c           |   15 +
 arch/s390/kernel/cpcmd.c                 |    7 +-
 arch/s390/kernel/debug.c                 |   39 +-
 arch/s390/kernel/entry.S                 |   58 +--
 arch/s390/kernel/entry64.S               |   58 +--
 arch/s390/kernel/head.S                  |   49 ++
 arch/s390/kernel/head31.S                |   28 +-
 arch/s390/kernel/head64.S                |   24 -
 arch/s390/kernel/mcount.S                |   56 ++
 arch/s390/kernel/processor.c             |   98 ++++
 arch/s390/kernel/ptrace.c                |   10 +-
 arch/s390/kernel/s390_ksyms.c            |    5 +
 arch/s390/kernel/setup.c                 |  185 ++-----
 arch/s390/kernel/smp.c                   |  201 +------
 arch/s390/kernel/time.c                  |  278 +++++++----
 arch/s390/kernel/topology.c              |   41 +-
 arch/s390/kernel/vdso.c                  |  234 ++++++++
 arch/s390/kernel/vdso32/Makefile         |   55 ++
 arch/s390/kernel/vdso32/clock_getres.S   |   39 ++
 arch/s390/kernel/vdso32/clock_gettime.S  |  128 +++++
 arch/s390/kernel/vdso32/gettimeofday.S   |   82 +++
 arch/s390/kernel/vdso32/note.S           |   12 +
 arch/s390/kernel/vdso32/vdso32.lds.S     |  138 +++++
 arch/s390/kernel/vdso32/vdso32_wrapper.S |   13 +
 arch/s390/kernel/vdso64/Makefile         |   55 ++
 arch/s390/kernel/vdso64/clock_getres.S   |   39 ++
 arch/s390/kernel/vdso64/clock_gettime.S  |   89 ++++
 arch/s390/kernel/vdso64/gettimeofday.S   |   56 ++
 arch/s390/kernel/vdso64/note.S           |   12 +
 arch/s390/kernel/vdso64/vdso64.lds.S     |  138 +++++
 arch/s390/kernel/vdso64/vdso64_wrapper.S |   13 +
 arch/s390/kernel/vtime.c                 |   11 -
 arch/s390/mm/extmem.c                    |  106 ++---
 arch/sh/include/asm/elf.h                |    2 +-
 arch/sh/kernel/vsyscall/vsyscall.c       |    3 +-
 arch/x86/include/asm/elf.h               |    2 +-
 arch/x86/vdso/vdso32-setup.c             |    2 +-
 arch/x86/vdso/vma.c                      |    2 +-
 drivers/char/Kconfig                     |   10 +
 drivers/char/Makefile                    |    1 +
 drivers/char/hvc_iucv.c                  |  850 ++++++++++++++++++++++++++++++
 drivers/s390/block/dasd.c                |    4 +
 drivers/s390/block/dasd_devmap.c         |   19 +-
 drivers/s390/block/dasd_eckd.c           |    2 +-
 drivers/s390/block/dasd_proc.c           |   28 +-
 drivers/s390/block/dcssblk.c             |   77 ++--
 drivers/s390/block/xpram.c               |   41 +-
 drivers/s390/char/monreader.c            |   41 +-
 drivers/s390/char/monwriter.c            |    5 +-
 drivers/s390/char/sclp_cmd.c             |   29 +-
 drivers/s390/char/sclp_config.c          |   10 +-
 drivers/s390/char/sclp_cpi_sys.c         |   12 +-
 drivers/s390/char/sclp_sdias.c           |   18 +-
 drivers/s390/char/sclp_vt220.c           |   33 +-
 drivers/s390/char/vmcp.c                 |   11 +-
 drivers/s390/char/vmlogrdr.c             |   26 +-
 drivers/s390/char/vmur.c                 |   15 +-
 drivers/s390/char/zcore.c                |   14 +-
 drivers/s390/cio/blacklist.c             |   14 +-
 drivers/s390/cio/ccwgroup.c              |   26 +-
 drivers/s390/cio/chsc.c                  |    8 +-
 drivers/s390/cio/chsc_sch.c              |    2 +-
 drivers/s390/cio/cio.c                   |  245 +++++----
 drivers/s390/cio/cio.h                   |   18 +-
 drivers/s390/cio/cmf.c                   |   63 +--
 drivers/s390/cio/css.c                   |   12 +-
 drivers/s390/cio/device.c                |  237 ++++++---
 drivers/s390/cio/device.h                |    1 +
 drivers/s390/cio/device_fsm.c            |   46 +-
 drivers/s390/cio/device_pgid.c           |    2 +-
 drivers/s390/cio/device_status.c         |    4 +-
 drivers/s390/cio/qdio.h                  |   33 +-
 drivers/s390/cio/qdio_debug.c            |  104 ++--
 drivers/s390/cio/qdio_debug.h            |  112 ++---
 drivers/s390/cio/qdio_main.c             |  648 ++++++++++--------------
 drivers/s390/cio/qdio_perf.c             |    8 +
 drivers/s390/cio/qdio_perf.h             |    5 +
 drivers/s390/cio/qdio_setup.c            |  145 +++---
 drivers/s390/cio/qdio_thinint.c          |   29 +-
 drivers/s390/crypto/ap_bus.c             |  212 +++++++-
 drivers/s390/crypto/ap_bus.h             |    6 +-
 drivers/s390/crypto/zcrypt_cex2a.c       |   10 +-
 drivers/s390/crypto/zcrypt_pcica.c       |   10 +-
 drivers/s390/crypto/zcrypt_pcicc.c       |   10 +-
 drivers/s390/crypto/zcrypt_pcixcc.c      |   10 +-
 drivers/s390/net/ctcm_fsms.c             |   46 +-
 drivers/s390/net/ctcm_main.c             |   72 ++-
 drivers/s390/net/ctcm_main.h             |    6 -
 drivers/s390/net/ctcm_mpc.c              |   15 +-
 drivers/s390/net/ctcm_sysfs.c            |    3 +
 drivers/s390/net/lcs.c                   |   92 ++--
 drivers/s390/net/netiucv.c               |   64 ++-
 drivers/s390/net/qeth_core.h             |    9 +-
 drivers/s390/net/qeth_core_main.c        |  176 ++++---
 drivers/s390/net/qeth_l2_main.c          |   37 +-
 drivers/s390/net/qeth_l3_main.c          |  211 ++++----
 drivers/s390/scsi/zfcp_aux.c             |   28 +-
 drivers/s390/scsi/zfcp_ccw.c             |    3 +
 drivers/s390/scsi/zfcp_cfdc.c            |    3 +
 drivers/s390/scsi/zfcp_dbf.c             |    3 +
 drivers/s390/scsi/zfcp_def.h             |    2 +
 drivers/s390/scsi/zfcp_erp.c             |   10 +-
 drivers/s390/scsi/zfcp_fc.c              |    3 +
 drivers/s390/scsi/zfcp_fsf.c             |    3 +
 drivers/s390/scsi/zfcp_qdio.c            |    3 +
 drivers/s390/scsi/zfcp_scsi.c            |    3 +
 drivers/s390/scsi/zfcp_sysfs.c           |    3 +
 drivers/s390/sysinfo.c                   |  127 +++++-
 fs/binfmt_elf.c                          |    2 +-
 include/asm-generic/memory_model.h       |    2 +-
 include/net/iucv/iucv.h                  |   45 ++
 net/iucv/af_iucv.c                       |   19 +-
 net/iucv/iucv.c                          |  161 +++++--
 143 files changed, 4876 insertions(+), 2300 deletions(-)
 create mode 100644 arch/s390/include/asm/ftrace.h
 create mode 100644 arch/s390/include/asm/vdso.h
 create mode 100644 arch/s390/kernel/mcount.S
 create mode 100644 arch/s390/kernel/processor.c
 create mode 100644 arch/s390/kernel/vdso.c
 create mode 100644 arch/s390/kernel/vdso32/Makefile
 create mode 100644 arch/s390/kernel/vdso32/clock_getres.S
 create mode 100644 arch/s390/kernel/vdso32/clock_gettime.S
 create mode 100644 arch/s390/kernel/vdso32/gettimeofday.S
 create mode 100644 arch/s390/kernel/vdso32/note.S
 create mode 100644 arch/s390/kernel/vdso32/vdso32.lds.S
 create mode 100644 arch/s390/kernel/vdso32/vdso32_wrapper.S
 create mode 100644 arch/s390/kernel/vdso64/Makefile
 create mode 100644 arch/s390/kernel/vdso64/clock_getres.S
 create mode 100644 arch/s390/kernel/vdso64/clock_gettime.S
 create mode 100644 arch/s390/kernel/vdso64/gettimeofday.S
 create mode 100644 arch/s390/kernel/vdso64/note.S
 create mode 100644 arch/s390/kernel/vdso64/vdso64.lds.S
 create mode 100644 arch/s390/kernel/vdso64/vdso64_wrapper.S
 create mode 100644 drivers/char/hvc_iucv.c
