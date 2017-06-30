From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Fri, 30 Jun 2017 18:31:35 +0000
Subject: [CRIU][PATCH v3 00/15] Add architecture support for s390x
Message-Id: <20170630183150.76021-1-holzheu@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hello CRIU mailing list,

This set of patches (version 3) adds the s390x (64 bit mainframe) backend
support to the CRIU checkpoint/restore tool.

The patches apply to the "criu-dev" branch on top of commit 843761066071cf
("criu/pie/parasite-vdso: Handle also systems without VVAR").

The patches are also available in the "ibm_criu-dev-v3" branch under:

 * https://github.com/michael-holzheu/criu/tree/ibm_criu-dev-v3

Travis run for this branch:

 * https://travis-ci.org/michael-holzheu/criu/builds/248889146

Patch set history
-----------------
v2->v3:

 * Squash patches for issues found in v2 review:
   - s390: Consolidate -msoft-float into Makefile.compel
   - Fix ARCH check for -msoft-float in Makefiles
   - Fix big endian byte order checks
 * Remove patch (because already upstream):
   - criu/pie/parasite-vdso: Handle also systems without VVAR
 * Add Dimitry's Reviewed-by tags (thanks for that)

v1->v2:

 * Split first monster patch into more parts as suggested by Mike Rapoport
 * Fix toplevel Makefile patch damage

Patch set description
---------------------
The s390x platform is is a 64 bit big endian CISC architecture.

This patch set does not include:

 * Support for 31 bit compat tasks
 * Support for processes that use s390 runtime instrumentation

Some parts of the patch have been contributed by:

 * Alice Frosi <alice@linux.vnet.ibm.com>

On s390 all tests of the zdtm testsuite succeed on Ubuntu 16.04 with kernel
4.8.0-34-generic execpt for the following:

 - zdtm/static/del_standalone_un
 - zdtm/static/deleted_unix_sock
 - zdtm/static/mnt_ext_dev
 - zdtm/static/overmount_dev
 - zdtm/static/overmount_fifo
 - zdtm/static/overmount_file
 - zdtm/static/overmount_sock
 - zdtm/static/pthread02
 - zdtm/static/ptrace_sig
 - zdtm/static/tempfs_overmounted
 - zdtm/static/unlink_fstat01+
 - zdtm/static/unlink_largefile
 - zdtm/static/unlink_regular00
 - zdtm/static/vfork00
 - zdtm/transition/thread-bomb

We have not analyzed the failures yet because for us those tests also failed on
Ubuntu for x86_64.

Best Regards,
Michael

Alice Frosi (1):
  zdtm/static/sem: Use "union semun" instead of int

Michael Holzheu (14):
  s390:compel/arch/s390: Add architecture support to compel tool and
    libraries
  s390:compel: Enable s390 in compel/
  s390:proto: Add s390 to protocol buffer files
  s390:criu/arch/s390: Add s390 parts to criu
  s390:criu: Enable s390 in criu
  s390:zdtm: Enable zdtm for s390
  s390: Fix clone() syscall parameters for s390
  s390: Enable s390 build in Makefile
  s390:zdtm: Add test for tasks > 4TB
  s390:criu: Add support for s390 consoles
  s390:criu: Add TASK_SIZE check for dump and restore
  criu/files: Fix wait_fds_event() for 64 bit platforms
  criu/mount: Fix flags cast and sizeof(sflags)
  zdtm/static/fdt_shared: Fix buffer size

 Makefile                                           |   9 +-
 Makefile.compel                                    |   8 +
 compel/.gitignore                                  |   1 +
 compel/arch/s390/plugins/include/asm/prologue.h    |   1 +
 .../arch/s390/plugins/include/asm/syscall-types.h  |  34 ++
 compel/arch/s390/plugins/std/parasite-head.S       |  26 +
 .../s390/plugins/std/syscalls/Makefile.syscalls    |  58 +++
 .../plugins/std/syscalls/syscall-common-s390.S     |  37 ++
 .../s390/plugins/std/syscalls/syscall-s390.tbl     | 108 ++++
 .../arch/s390/plugins/std/syscalls/syscalls-s390.c |  26 +
 compel/arch/s390/scripts/compel-pack.lds.S         |  40 ++
 compel/arch/s390/src/lib/cpu.c                     |  42 ++
 compel/arch/s390/src/lib/handle-elf-host.c         |   1 +
 compel/arch/s390/src/lib/handle-elf.c              |  22 +
 compel/arch/s390/src/lib/include/handle-elf.h      |  13 +
 compel/arch/s390/src/lib/include/syscall.h         |   8 +
 .../s390/src/lib/include/uapi/asm/breakpoints.h    |  15 +
 compel/arch/s390/src/lib/include/uapi/asm/cpu.h    |  10 +
 compel/arch/s390/src/lib/include/uapi/asm/fpu.h    |  14 +
 .../s390/src/lib/include/uapi/asm/infect-types.h   |  75 +++
 .../arch/s390/src/lib/include/uapi/asm/sigframe.h  |  75 +++
 compel/arch/s390/src/lib/infect.c                  | 559 +++++++++++++++++++++
 compel/src/lib/handle-elf.c                        |  25 +
 compel/src/main.c                                  |   3 +
 criu/arch/s390/Makefile                            |  10 +
 criu/arch/s390/cpu.c                               | 158 ++++++
 criu/arch/s390/crtools.c                           | 341 +++++++++++++
 criu/arch/s390/include/asm/dump.h                  |  12 +
 criu/arch/s390/include/asm/int.h                   |   6 +
 criu/arch/s390/include/asm/parasite-syscall.h      |   6 +
 criu/arch/s390/include/asm/parasite.h              |   7 +
 criu/arch/s390/include/asm/restore.h               |  29 ++
 criu/arch/s390/include/asm/restorer.h              |  65 +++
 criu/arch/s390/include/asm/types.h                 |  37 ++
 criu/arch/s390/include/asm/vdso.h                  |  23 +
 criu/arch/s390/restorer.c                          |  37 ++
 criu/arch/s390/sigframe.c                          |  20 +
 criu/arch/s390/vdso-pie.c                          |  65 +++
 criu/files.c                                       |   5 +-
 criu/mem.c                                         |  19 +
 criu/mount.c                                       |   5 +-
 criu/pie/Makefile                                  |   7 +
 criu/pie/Makefile.library                          |   6 +
 criu/pie/util-vdso.c                               |  25 +-
 criu/proc_parse.c                                  |  19 +
 criu/sk-netlink.c                                  |  16 +
 criu/tty.c                                         |  11 +
 criu/util.c                                        |   5 +
 images/Makefile                                    |   1 +
 images/core-s390.proto                             |  39 ++
 images/core.proto                                  |   3 +
 images/cpuinfo.proto                               |   5 +
 include/common/arch/s390/asm/atomic.h              |  67 +++
 include/common/arch/s390/asm/atomic_ops.h          |  74 +++
 include/common/arch/s390/asm/bitops.h              | 164 ++++++
 include/common/arch/s390/asm/bitsperlong.h         |   6 +
 include/common/arch/s390/asm/linkage.h             |  22 +
 include/common/arch/s390/asm/page.h                |  19 +
 test/zdtm/lib/arch/s390/include/asm/atomic.h       |  66 +++
 test/zdtm/lib/test.c                               |   5 +
 test/zdtm/static/Makefile                          |   1 +
 test/zdtm/static/fanotify00.c                      |   3 +
 test/zdtm/static/fdt_shared.c                      |   4 +-
 test/zdtm/static/mntns-deleted-dst                 |   0
 test/zdtm/static/netns-nf.desc                     |   2 +-
 test/zdtm/static/rtc.desc                          |   2 +-
 test/zdtm/static/s390x_mmap_high.c                 |  64 +++
 test/zdtm/static/s390x_mmap_high.desc              |   1 +
 test/zdtm/static/sem.c                             |  20 +-
 test/zdtm/static/socket-tcp-closed-last-ack.desc   |   4 +-
 test/zdtm/static/vt.c                              |   8 +-
 71 files changed, 2696 insertions(+), 28 deletions(-)
 create mode 120000 compel/arch/s390/plugins/include/asm/prologue.h
 create mode 100644 compel/arch/s390/plugins/include/asm/syscall-types.h
 create mode 100644 compel/arch/s390/plugins/std/parasite-head.S
 create mode 100644 compel/arch/s390/plugins/std/syscalls/Makefile.syscalls
 create mode 100644 compel/arch/s390/plugins/std/syscalls/syscall-common-s390.S
 create mode 100644 compel/arch/s390/plugins/std/syscalls/syscall-s390.tbl
 create mode 100644 compel/arch/s390/plugins/std/syscalls/syscalls-s390.c
 create mode 100644 compel/arch/s390/scripts/compel-pack.lds.S
 create mode 100644 compel/arch/s390/src/lib/cpu.c
 create mode 120000 compel/arch/s390/src/lib/handle-elf-host.c
 create mode 100644 compel/arch/s390/src/lib/handle-elf.c
 create mode 100644 compel/arch/s390/src/lib/include/handle-elf.h
 create mode 100644 compel/arch/s390/src/lib/include/syscall.h
 create mode 100644 compel/arch/s390/src/lib/include/uapi/asm/breakpoints.h
 create mode 100644 compel/arch/s390/src/lib/include/uapi/asm/cpu.h
 create mode 100644 compel/arch/s390/src/lib/include/uapi/asm/fpu.h
 create mode 100644 compel/arch/s390/src/lib/include/uapi/asm/infect-types.h
 create mode 100644 compel/arch/s390/src/lib/include/uapi/asm/sigframe.h
 create mode 100644 compel/arch/s390/src/lib/infect.c
 create mode 100644 criu/arch/s390/Makefile
 create mode 100644 criu/arch/s390/cpu.c
 create mode 100644 criu/arch/s390/crtools.c
 create mode 100644 criu/arch/s390/include/asm/dump.h
 create mode 100644 criu/arch/s390/include/asm/int.h
 create mode 100644 criu/arch/s390/include/asm/parasite-syscall.h
 create mode 100644 criu/arch/s390/include/asm/parasite.h
 create mode 100644 criu/arch/s390/include/asm/restore.h
 create mode 100644 criu/arch/s390/include/asm/restorer.h
 create mode 100644 criu/arch/s390/include/asm/types.h
 create mode 100644 criu/arch/s390/include/asm/vdso.h
 create mode 100644 criu/arch/s390/restorer.c
 create mode 100644 criu/arch/s390/sigframe.c
 create mode 100644 criu/arch/s390/vdso-pie.c
 create mode 100644 images/core-s390.proto
 create mode 100644 include/common/arch/s390/asm/atomic.h
 create mode 100644 include/common/arch/s390/asm/atomic_ops.h
 create mode 100644 include/common/arch/s390/asm/bitops.h
 create mode 100644 include/common/arch/s390/asm/bitsperlong.h
 create mode 100644 include/common/arch/s390/asm/linkage.h
 create mode 100644 include/common/arch/s390/asm/page.h
 create mode 100644 test/zdtm/lib/arch/s390/include/asm/atomic.h
 create mode 100644 test/zdtm/static/mntns-deleted-dst
 create mode 100644 test/zdtm/static/s390x_mmap_high.c
 create mode 100644 test/zdtm/static/s390x_mmap_high.desc

-- 
2.7.4
