Return-Path: <linux-kernel-owner+w=401wt.eu-S1756718AbYGNJAg@vger.kernel.org>
Date: Mon, 14 Jul 2008 11:00:12 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [GIT PULL] s390 updates for 2.6.27
Message-ID: <20080714090012.GA4787@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

since Martin is on vacation the first s390 pull request for the 2.6.27
merge window comes from me.

Please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

Besides the usual cleanups and bugfixes it contains new features like
clock synchronization with the server time protocol (stp);
memory-add support (touches common code Kconfig file);
a lot of new stuff in the s390 common I/O layer code which also
touches a few common files for css bus modalias and documentation.
The changes in net/iucv/ are just printk cleanups/removals for the
s390 drivers.

A few patches are currently missing: our new qdio driver depends on
changes in the scsi and net trees and memory hot-remove support depends
on a patch which is currently in -mm. These will follow with a later
pull request.

Thanks.

Shortlog and diffstat:

Akinobu Mita (4):
      [S390] s390/vmcp: use simple_read_from_buffer()
      [S390] s390/cio: use memory_read_from_buffer()
      [S390] s390: use simple_read_from_buffer()
      [S390] s390: use memory_read_from_buffer()

Christian Borntraeger (1):
      [S390] Cleanup vmcp printk messages.

Cornelia Huck (14):
      [S390] cio: Clear correct bit in cio_release_console().
      [S390] cio: Register all subchannels.
      [S390] cio: Introduce modalias for css bus.
      [S390] cio: Rework css driver.
      [S390] cio: Cleanup crw interface.
      [S390] cio: Export some symbols for modular css drivers.
      [S390] cio: Base message subchannel handling.
      [S390] cio: Get rid of css_characteristics_avail.
      [S390] cio: Introduce abstract isc definitions.
      [S390] cio: Allow adapter interrupt handlers per isc.
      [S390] cio: Use isc_{register,unregister}.
      [S390] cio: Repair chpid event handling.
      [S390] css: Use css_device_id for bus matching.
      [S390] cio: Add chsc subchannel driver.

Felix Beck (2):
      [S390] ap: Use high-resolution timer for polling
      [S390] Cleanup zcrypt printk messages.

Frank Blaschka (1):
      [S390] Cleanup qeth print messages.

Gerald Schaefer (3):
      [S390] make appldata compile w/o CONFIG_SWAP
      [S390] Cleanup appldata printk messages.
      [S390] Cleanup monreader printk messages.

Heiko Carstens (12):
      [S390] sclp: keep facility mask up to date.
      [S390] sclp: fix possible deadlock on cpu rescan.
      [S390] Remove ipldelay kernel parameter.
      [S390] initrd vs bss section clearing.
      [S390] idle: remove idle notifier chain.
      [S390] Add sched.h include to asm-s390/pgtable.h.
      [S390] Add support for memory hot-add.
      [S390] Add support for memory hot-add via sclp.
      [S390] Move memory detection code to own file.
      [S390] Remove P390 support.
      [S390] sclp_tty: remove ioctl interface.
      [S390] sclp_tty: Fix scheduling while atomic bug.

Hendrik Brueckner (1):
      [S390] Extra Kernel Parameters via VMPARM

Hongjie Yang (1):
      [S390] Cleanup dcssblk printk messages.

Jan Glauber (1):
      [S390] Cleanup cpacf printk messages.

Julia Lawall (2):
      [S390] arch/s390: Eliminate NULL test and memset after alloc_bootmem
      [S390] drivers/s390: Eliminate NULL test and memset after alloc_bootmem

Klaus-D. Wacker (1):
      [S390] Cleanup lcs printk messages.

Martin Schwidefsky (11):
      [S390] Introduce user_regset accessors for s390
      [S390] stp support.
      [S390] Cleanup vtime printk messages.
      [S390] Cleanup xpram printk messages.
      [S390] Cleanup 3270 printk messages.
      [S390] Cleanup 3215 printk messages.
      [S390] Cleanup sclp printk messages.
      [S390] Cleanup smsgiucv printk messages.
      [S390] Cleanup vmlogrdr printk messages.
      [S390] Cleanup vmwatch printk messages.
      [S390] Cleanup kprobes printk messages.

Michael Ernst (2):
      [S390] cio: Use locks when accessing /sys/firmware/cpi data.
      [S390] Cleanup cio printk messages.

Michael Holzheu (2):
      [S390] Cleanup s390 debug feature print messages.
      [S390] Cleanup zfcp dumper printk messages.

Peter Oberparleiter (6):
      [S390] cio: introduce fcx bit to chsc characteristics
      [S390] cio: introduce fcx enabled scsw format
      [S390] cio: provide functions for fcx enabled I/O
      [S390] cio: provide helper functions for fcx enabled I/O
      [S390] cio: suppress chpid event in case of configure error
      [S390] sclp: simplify vt220 cleanup logic

Ralph Wuerthner (1):
      [S390] zcrypt: Add additional card IDs to CEX2C and CEX2A

Sebastian Ott (3):
      [S390] cio: remove lock from ccw_device_oper_notify.
      [S390] cio: introduce isc_(un)register functions.
      [S390] cio: fix double unregistering of subchannels

Ursula Braun (3):
      [S390] qdio: Repair timeout handling for qdio_shutdown
      [S390] Cleanup iucv printk messages.
      [S390] Cleanup netiucv printk messages.

 Documentation/ABI/testing/sysfs-bus-css |   35 ++
 Documentation/ioctl-number.txt          |    1 +
 arch/s390/Kconfig                       |   21 +
 arch/s390/appldata/appldata.h           |   10 +-
 arch/s390/appldata/appldata_base.c      |   41 +--
 arch/s390/appldata/appldata_mem.c       |   43 +--
 arch/s390/appldata/appldata_net_sum.c   |   39 +--
 arch/s390/appldata/appldata_os.c        |   57 +--
 arch/s390/crypto/prng.c                 |    5 +-
 arch/s390/hypfs/inode.c                 |   29 +-
 arch/s390/kernel/Makefile               |    9 +-
 arch/s390/kernel/binfmt_elf32.c         |  214 --------
 arch/s390/kernel/compat_ptrace.h        |    4 +-
 arch/s390/kernel/debug.c                |    9 -
 arch/s390/kernel/early.c                |  211 ++++-----
 arch/s390/kernel/ipl.c                  |  462 ++++++++++++++---
 arch/s390/kernel/kprobes.c              |    4 +-
 arch/s390/kernel/machine_kexec.c        |    1 -
 arch/s390/kernel/mem_detect.c           |  100 ++++
 arch/s390/kernel/process.c              |   32 +--
 arch/s390/kernel/ptrace.c               |  363 ++++++++++++--
 arch/s390/kernel/setup.c                |   51 +--
 arch/s390/kernel/time.c                 |  634 ++++++++++++++++++------
 arch/s390/kernel/topology.c             |    2 -
 arch/s390/kernel/vtime.c                |   81 +---
 arch/s390/mm/init.c                     |   19 +
 drivers/s390/block/dasd.c               |   18 +-
 drivers/s390/block/dasd_3990_erp.c      |   15 +-
 drivers/s390/block/dasd_eckd.c          |   12 +-
 drivers/s390/block/dasd_fba.c           |   12 +-
 drivers/s390/block/dcssblk.c            |   22 +-
 drivers/s390/block/xpram.c              |   18 +-
 drivers/s390/char/con3215.c             |   38 +--
 drivers/s390/char/con3270.c             |    6 +-
 drivers/s390/char/fs3270.c              |   11 +-
 drivers/s390/char/monreader.c           |   74 +---
 drivers/s390/char/raw3270.c             |   28 +-
 drivers/s390/char/sclp.c                |   12 +-
 drivers/s390/char/sclp_cmd.c            |  343 ++++++++++++-
 drivers/s390/char/sclp_con.c            |    5 +-
 drivers/s390/char/sclp_config.c         |   17 +-
 drivers/s390/char/sclp_cpi_sys.c        |   57 ++-
 drivers/s390/char/sclp_quiesce.c        |    8 +-
 drivers/s390/char/sclp_rw.c             |    2 -
 drivers/s390/char/sclp_sdias.c          |    4 +-
 drivers/s390/char/sclp_tty.c            |  261 ++--------
 drivers/s390/char/sclp_tty.h            |   53 --
 drivers/s390/char/sclp_vt220.c          |   62 +--
 drivers/s390/char/tape_34xx.c           |   12 +-
 drivers/s390/char/tape_3590.c           |   21 +-
 drivers/s390/char/tape_core.c           |   15 +-
 drivers/s390/char/tty3270.c             |    9 +-
 drivers/s390/char/vmcp.c                |   37 +-
 drivers/s390/char/vmlogrdr.c            |   29 +-
 drivers/s390/char/vmur.c                |    5 +-
 drivers/s390/char/vmwatchdog.c          |   16 +-
 drivers/s390/char/zcore.c               |   31 +-
 drivers/s390/cio/Makefile               |    4 +-
 drivers/s390/cio/airq.c                 |   45 +-
 drivers/s390/cio/chp.c                  |  116 ++++--
 drivers/s390/cio/chp.h                  |   15 +-
 drivers/s390/cio/chsc.c                 |  379 ++++++---------
 drivers/s390/cio/chsc.h                 |   26 +-
 drivers/s390/cio/chsc_sch.c             |  820 ++++++++++++++++++++++++++++++
 drivers/s390/cio/chsc_sch.h             |   13 +
 drivers/s390/cio/cio.c                  |  282 +++++++----
 drivers/s390/cio/cio.h                  |   14 +-
 drivers/s390/cio/cmf.c                  |   20 +-
 drivers/s390/cio/css.c                  |  283 +++++------
 drivers/s390/cio/css.h                  |   49 +-
 drivers/s390/cio/device.c               |  476 +++++++++++++-----
 drivers/s390/cio/device.h               |    7 +-
 drivers/s390/cio/device_fsm.c           |  210 +++-----
 drivers/s390/cio/device_id.c            |   16 +-
 drivers/s390/cio/device_ops.c           |  134 +++++-
 drivers/s390/cio/device_pgid.c          |   26 +-
 drivers/s390/cio/device_status.c        |  133 +++---
 drivers/s390/cio/fcx.c                  |  350 +++++++++++++
 drivers/s390/cio/idset.h                |    2 +-
 drivers/s390/cio/io_sch.h               |   48 ++-
 drivers/s390/cio/ioasm.h                |    2 +-
 drivers/s390/cio/isc.c                  |   68 +++
 drivers/s390/cio/itcw.c                 |  327 ++++++++++++
 drivers/s390/cio/qdio.c                 |   35 +-
 drivers/s390/cio/qdio.h                 |    6 +-
 drivers/s390/cio/schid.h                |   26 -
 drivers/s390/cio/scsw.c                 |  843 +++++++++++++++++++++++++++++++
 drivers/s390/crypto/ap_bus.c            |   63 ++-
 drivers/s390/crypto/ap_bus.h            |    2 +
 drivers/s390/crypto/zcrypt_api.c        |   24 +-
 drivers/s390/crypto/zcrypt_api.h        |   28 -
 drivers/s390/crypto/zcrypt_cex2a.c      |    4 +-
 drivers/s390/crypto/zcrypt_error.h      |    6 -
 drivers/s390/crypto/zcrypt_pcica.c      |    3 -
 drivers/s390/crypto/zcrypt_pcicc.c      |   15 +-
 drivers/s390/crypto/zcrypt_pcixcc.c     |   69 +---
 drivers/s390/net/claw.c                 |   77 ++--
 drivers/s390/net/ctcm_fsms.c            |   12 +-
 drivers/s390/net/ctcm_main.c            |   28 +-
 drivers/s390/net/cu3088.c               |    2 -
 drivers/s390/net/cu3088.h               |    3 -
 drivers/s390/net/lcs.c                  |   44 +-
 drivers/s390/net/netiucv.c              |   61 +--
 drivers/s390/net/qeth_core_main.c       |   15 +-
 drivers/s390/net/qeth_l3_main.c         |    9 +-
 drivers/s390/net/smsgiucv.c             |   10 +-
 drivers/s390/s390mach.c                 |  106 ++--
 drivers/s390/s390mach.h                 |   10 +
 include/asm-s390/Kbuild                 |    3 +
 include/asm-s390/airq.h                 |    4 +-
 include/asm-s390/ccwdev.h               |   12 +
 include/asm-s390/chpid.h                |    5 +-
 include/asm-s390/chsc.h                 |  127 +++++
 include/asm-s390/cio.h                  |  114 ++++-
 include/asm-s390/elf.h                  |   51 +--
 include/asm-s390/etr.h                  |   45 ++-
 include/asm-s390/fcx.h                  |  311 ++++++++++++
 include/asm-s390/ipl.h                  |   17 +-
 include/asm-s390/isc.h                  |   25 +
 include/asm-s390/itcw.h                 |   30 ++
 include/asm-s390/pgtable.h              |    1 +
 include/asm-s390/processor.h            |   24 +-
 include/asm-s390/ptrace.h               |   15 +
 include/asm-s390/schid.h                |   28 +
 include/asm-s390/sclp.h                 |    4 +-
 include/asm-s390/setup.h                |   12 +-
 include/asm-s390/sparsemem.h            |    4 +-
 include/asm-s390/timer.h                |   12 +
 include/asm-s390/zcrypt.h               |    2 +-
 include/linux/mod_devicetable.h         |    9 +
 mm/Kconfig                              |    2 +-
 net/iucv/af_iucv.c                      |    8 +-
 net/iucv/iucv.c                         |    9 +-
 scripts/mod/file2alias.c                |   12 +
 134 files changed, 6881 insertions(+), 3101 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-css
 delete mode 100644 arch/s390/kernel/binfmt_elf32.c
 create mode 100644 arch/s390/kernel/mem_detect.c
 create mode 100644 drivers/s390/cio/chsc_sch.c
 create mode 100644 drivers/s390/cio/chsc_sch.h
 create mode 100644 drivers/s390/cio/fcx.c
 create mode 100644 drivers/s390/cio/isc.c
 create mode 100644 drivers/s390/cio/itcw.c
 create mode 100644 drivers/s390/cio/scsw.c
 create mode 100644 include/asm-s390/chsc.h
 create mode 100644 include/asm-s390/fcx.h
 create mode 100644 include/asm-s390/isc.h
 create mode 100644 include/asm-s390/itcw.h
 rename {drivers/s390/cio => include/asm-s390}/schid.h (65%)
