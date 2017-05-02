Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 2 May 2017 09:09:44 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.12 merge window
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170502090944.08c2542f@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

The majority of the s390 patches for the 4.12 merge window:

* Included are three merges for KVM/s390 with changes for vfio-ccw and cpacf.
  The patches are included in the KVM tree as well, let git sort it out.

* Add the new 'trng' random number generator

* Provide the secure key verification API for the pkey interface

* Introduce the z13 cpu counters to perf

* Add a new system call to set up the guarded storage facility

* Simplify TASK_SIZE and arch_get_unmapped_area

* Export the raw STSI data related to CPU topology to user space

* And the usual churn of bug-fixes and cleanups.

On my test pull today there has been a small merge conflict in
arch/s390/Kconfig. HAVE_ARCH_HARDENED_USERCOPY got removed by
git commit 2fefc97b2180518b from Al and HAVE_ARCH_EARLY_PFN_TO_NID
is removed by a patch from Heiko in this pull request.

The shortlog:

Christian Borntraeger (1):
      s390/MAINTAINERS: add gmap.c to kvm maintainers

Claudio Imbrenda (2):
      s390/kvm: Add PGSTE manipulation functions
      s390/kvm: Add use_cmma field to mm_context_t

Dong Jia Shi (18):
      s390: cio: introduce cio_cancel_halt_clear
      s390: cio: export more interfaces
      vfio: ccw: define device_api strings
      vfio: ccw: basic implementation for vfio_ccw driver
      vfio: ccw: introduce channel program interfaces
      vfio: ccw: register vfio_ccw to the mediated device framework
      vfio: ccw: introduce ccw_io_region
      vfio: ccw: handle ccw command request
      vfio: ccw: realize VFIO_DEVICE_GET_REGION_INFO ioctl
      vfio: ccw: realize VFIO_DEVICE_RESET ioctl
      vfio: ccw: realize VFIO_DEVICE_G(S)ET_IRQ_INFO ioctls
      vfio: ccw: return I/O results asynchronously
      vfio: ccw: introduce a finite state machine
      docs: add documentation for vfio-ccw
      vfio: ccw: introduce support for ccw0
      MAINTAINERS: Add vfio-ccw maintainers
      vfio: ccw: remove unnecessary NULL checks of a pointer
      vfio: ccw: improve error handling for vfio_ccw_mdev_remove

Harald Freudenberger (6):
      s390/pkey: Introduce new API for secure key verification
      s390/crypto: Renaming PPNO to PRNO.
      s390/crypto: Add new subfunctions to the cpacf PRNO function.
      s390/crypto: Provide s390 specific arch random functionality.
      s390/trng: Introduce s390 TRNG device driver.
      s390/crypt: use the correct module alias for paes_s390.

Heiko Carstens (19):
      s390/bitops: add for_each_set_bit_inv helper
      s390/cpuinfo: show facilities as reported by stfle
      s390/bitops: remove outdated comment
      s390/topology: get rid of core mask array
      s390/topology: fix typo in early topology code
      s390/sysinfo: allow compiler warnings again
      s390/dump_stack: remove whitespace from arch description
      s390/dump_stack: use control program identification string
      s390/debugfs: introduce top-level 's390' directory
      s390/sysinfo,topology: provide raw stsi 15,1,x data via debugfs
      s390/sysinfo: provide remaining stsi information via debugfs
      s390/facilites: use stfle_fac_list array size for MAX_FACILITY_BIT
      s390/facilities: get rid of __ASSEMBLY__ in facility header file
      s390: remove HAVE_ARCH_EARLY_PFN_TO_NID select statement
      s390: enable ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT
      s390: make MAX_PHYSMEM_BITS configurable
      s390/uapi: use generic headers if possible
      s390: use generic headers if possible
      s390/pageattr: avoid unnecessary page table splitting

Hendrik Brueckner (7):
      s390/cpum_cf: update counter numbers to ecctr limits
      s390/cpum_cf: cleanup event/counter validation
      s390/cpum_cf: add support for the MT-diagnostic counter set (z13)
      s390/cpum_cf: add IBM z13 counter event names
      s390/cpum_cf: correct variable naming (cleanup)
      s390/cpu_mf: remove register variable in __ecctr()
      s390/cpum_cf: make hw_perf_event_update() a void function

Janosch Frank (1):
      s390/mm: Remove double gaddr calculation when notifying

Jason J. Herne (2):
      s390/cpacf: query instructions use unique parameters for compatibility with KMA
      s390/cpacf: Introduce kma instruction

Martin Schwidefsky (8):
      s390: add a system call for guarded storage
      s390: use 64-bit lctlg to load task pid to cr4 on context switch
      s390/cpumf: simplify detection of guest samples
      s390/spinlock: use atomic primitives for spinlocks
      s390/spinlock: remove compare and delay instruction
      s390/gs: add regset for the guarded storage broadcast control block
      s390/mm: make TASK_SIZE independent from the number of page table levels
      s390/mm: simplify arch_get_unmapped_area[_topdown]

Michael Holzheu (2):
      s390/configs//zfcpdump_defconfig: Remove CONFIG_SCSI_SRP_ATTRS
      s390/kdump: Add final note

Michal Hocko (1):
      s390: get rid of superfluous __GFP_REPEAT

Sebastian Ott (5):
      s390/pci: remove unused function
      s390/pci: remove duplicated define
      s390/pci: reduce iomap size (even more)
      s390/pci: increase the PCI_NR_FUNCTIONS default
      s390/pci: remove forward declaration

Stefan Haberland (2):
      s390/dasd: check if query host access feature is supported
      s390/dasd: suppress command reject error for query host access command

 Documentation/s390/00-INDEX                  |   2 +
 Documentation/s390/vfio-ccw.txt              | 303 ++++++++++
 MAINTAINERS                                  |  11 +
 arch/s390/Kbuild                             |   2 +-
 arch/s390/Kconfig                            |  39 +-
 arch/s390/configs/default_defconfig          |   1 +
 arch/s390/configs/gcov_defconfig             |   1 +
 arch/s390/configs/performance_defconfig      |   1 +
 arch/s390/configs/zfcpdump_defconfig         |   1 -
 arch/s390/crypto/Makefile                    |   1 +
 arch/s390/crypto/arch_random.c               |  31 +
 arch/s390/crypto/paes_s390.c                 |   2 +-
 arch/s390/crypto/prng.c                      |  42 +-
 arch/s390/include/asm/Kbuild                 |   6 +
 arch/s390/include/asm/archrandom.h           |  69 +++
 arch/s390/include/asm/atomic_ops.h           |  22 +-
 arch/s390/include/asm/bitops.h               |  13 +-
 arch/s390/include/asm/cio.h                  |  18 +
 arch/s390/include/asm/cpacf.h                |  56 +-
 arch/s390/include/asm/cpu_mf.h               |   6 +-
 arch/s390/include/asm/div64.h                |   1 -
 arch/s390/include/asm/elf.h                  |   1 +
 arch/s390/include/asm/emergency-restart.h    |   6 -
 arch/s390/include/asm/facility.h             |   6 +-
 arch/s390/include/asm/irq_regs.h             |   1 -
 arch/s390/include/asm/isc.h                  |   1 +
 arch/s390/include/asm/kmap_types.h           |   6 -
 arch/s390/include/asm/local.h                |   1 -
 arch/s390/include/asm/local64.h              |   1 -
 arch/s390/include/asm/lowcore.h              |   9 +-
 arch/s390/include/asm/mman.h                 |   4 -
 arch/s390/include/asm/mmu.h                  |   2 +
 arch/s390/include/asm/mmu_context.h          |   1 +
 arch/s390/include/asm/nmi.h                  |  12 +-
 arch/s390/include/asm/page-states.h          |  19 +
 arch/s390/include/asm/perf_event.h           |   4 +-
 arch/s390/include/asm/pgtable.h              |  16 +-
 arch/s390/include/asm/pkey.h                 |  21 +
 arch/s390/include/asm/processor.h            |  14 +-
 arch/s390/include/asm/setup.h                |   6 +-
 arch/s390/include/asm/sparsemem.h            |   2 +-
 arch/s390/include/asm/spinlock.h             |  45 +-
 arch/s390/include/asm/spinlock_types.h       |   6 +-
 arch/s390/include/asm/switch_to.h            |   3 +
 arch/s390/include/asm/sysinfo.h              |  12 +-
 arch/s390/include/asm/thread_info.h          |  12 +-
 arch/s390/include/uapi/asm/Kbuild            |  19 +-
 arch/s390/include/uapi/asm/errno.h           |  11 -
 arch/s390/include/uapi/asm/fcntl.h           |   1 -
 arch/s390/include/uapi/asm/guarded_storage.h |  77 +++
 arch/s390/include/uapi/asm/ioctl.h           |   1 -
 arch/s390/include/uapi/asm/mman.h            |   6 -
 arch/s390/include/uapi/asm/param.h           |   6 -
 arch/s390/include/uapi/asm/pkey.h            |  19 +
 arch/s390/include/uapi/asm/poll.h            |   1 -
 arch/s390/include/uapi/asm/resource.h        |  13 -
 arch/s390/include/uapi/asm/sockios.h         |   6 -
 arch/s390/include/uapi/asm/termbits.h        |   6 -
 arch/s390/include/uapi/asm/unistd.h          |   2 +-
 arch/s390/kernel/Makefile                    |   6 +-
 arch/s390/kernel/asm-offsets.c               |   2 +-
 arch/s390/kernel/compat_wrapper.c            |   1 +
 arch/s390/kernel/crash_dump.c                |  15 +
 arch/s390/kernel/early.c                     |  66 ++-
 arch/s390/kernel/entry.S                     |  28 +-
 arch/s390/kernel/entry.h                     |   2 +
 arch/s390/kernel/guarded_storage.c           | 128 ++++
 arch/s390/kernel/head.S                      |   1 -
 arch/s390/kernel/head64.S                    |   2 +-
 arch/s390/kernel/kdebugfs.c                  |  15 +
 arch/s390/kernel/machine_kexec.c             |  13 +-
 arch/s390/kernel/nmi.c                       |  19 +-
 arch/s390/kernel/perf_cpum_cf.c              | 128 ++--
 arch/s390/kernel/perf_cpum_cf_events.c       | 148 ++++-
 arch/s390/kernel/perf_cpum_sf.c              |   7 +-
 arch/s390/kernel/process.c                   |   7 +-
 arch/s390/kernel/processor.c                 |  16 +-
 arch/s390/kernel/ptrace.c                    | 132 ++++-
 arch/s390/kernel/setup.c                     |  18 +-
 arch/s390/kernel/smp.c                       |  43 +-
 arch/s390/kernel/syscalls.S                  |   2 +-
 arch/s390/kernel/sysinfo.c                   |  98 ++++
 arch/s390/kernel/topology.c                  |   6 +-
 arch/s390/kvm/interrupt.c                    |   4 +-
 arch/s390/kvm/kvm-s390.c                     |   6 +-
 arch/s390/lib/spinlock.c                     |  84 +--
 arch/s390/mm/gmap.c                          |  37 +-
 arch/s390/mm/gup.c                           |   2 +-
 arch/s390/mm/mmap.c                          |  84 +--
 arch/s390/mm/page-states.c                   |   3 +-
 arch/s390/mm/pageattr.c                      |  10 +-
 arch/s390/mm/pgalloc.c                       |   4 +-
 arch/s390/mm/pgtable.c                       | 153 +++++
 arch/s390/pci/pci.c                          |  22 +-
 drivers/char/hw_random/Kconfig               |  14 +
 drivers/char/hw_random/Makefile              |   1 +
 drivers/char/hw_random/s390-trng.c           | 268 +++++++++
 drivers/iommu/Kconfig                        |   8 +
 drivers/s390/block/dasd_3990_erp.c           |   5 +-
 drivers/s390/block/dasd_eckd.c               |  16 +-
 drivers/s390/block/dasd_int.h                |   2 +-
 drivers/s390/cio/Makefile                    |   3 +
 drivers/s390/cio/cio.c                       |  69 +++
 drivers/s390/cio/cio.h                       |   1 +
 drivers/s390/cio/device_fsm.c                |  54 +-
 drivers/s390/cio/vfio_ccw_cp.c               | 842 +++++++++++++++++++++++++++
 drivers/s390/cio/vfio_ccw_cp.h               |  42 ++
 drivers/s390/cio/vfio_ccw_drv.c              | 308 ++++++++++
 drivers/s390/cio/vfio_ccw_fsm.c              | 203 +++++++
 drivers/s390/cio/vfio_ccw_ops.c              | 425 ++++++++++++++
 drivers/s390/cio/vfio_ccw_private.h          |  96 +++
 drivers/s390/crypto/pkey_api.c               |  64 +-
 include/uapi/linux/elf.h                     |   2 +
 include/uapi/linux/vfio.h                    |  18 +
 include/uapi/linux/vfio_ccw.h                |  24 +
 115 files changed, 4223 insertions(+), 561 deletions(-)
 create mode 100644 Documentation/s390/vfio-ccw.txt
 create mode 100644 arch/s390/crypto/arch_random.c
 create mode 100644 arch/s390/include/asm/archrandom.h
 delete mode 100644 arch/s390/include/asm/div64.h
 delete mode 100644 arch/s390/include/asm/emergency-restart.h
 delete mode 100644 arch/s390/include/asm/irq_regs.h
 delete mode 100644 arch/s390/include/asm/kmap_types.h
 delete mode 100644 arch/s390/include/asm/local.h
 delete mode 100644 arch/s390/include/asm/local64.h
 create mode 100644 arch/s390/include/asm/page-states.h
 delete mode 100644 arch/s390/include/uapi/asm/errno.h
 delete mode 100644 arch/s390/include/uapi/asm/fcntl.h
 create mode 100644 arch/s390/include/uapi/asm/guarded_storage.h
 delete mode 100644 arch/s390/include/uapi/asm/ioctl.h
 delete mode 100644 arch/s390/include/uapi/asm/mman.h
 delete mode 100644 arch/s390/include/uapi/asm/param.h
 delete mode 100644 arch/s390/include/uapi/asm/poll.h
 delete mode 100644 arch/s390/include/uapi/asm/resource.h
 delete mode 100644 arch/s390/include/uapi/asm/sockios.h
 delete mode 100644 arch/s390/include/uapi/asm/termbits.h
 create mode 100644 arch/s390/kernel/guarded_storage.c
 create mode 100644 arch/s390/kernel/kdebugfs.c
 create mode 100644 drivers/char/hw_random/s390-trng.c
 create mode 100644 drivers/s390/cio/vfio_ccw_cp.c
 create mode 100644 drivers/s390/cio/vfio_ccw_cp.h
 create mode 100644 drivers/s390/cio/vfio_ccw_drv.c
 create mode 100644 drivers/s390/cio/vfio_ccw_fsm.c
 create mode 100644 drivers/s390/cio/vfio_ccw_ops.c
 create mode 100644 drivers/s390/cio/vfio_ccw_private.h
 create mode 100644 include/uapi/linux/vfio_ccw.h
