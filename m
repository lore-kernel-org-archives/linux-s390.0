From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH 0/3] perf s390: Use syscall.tbl to create the perf syscall table
Date: Thu,  8 Feb 2018 12:47:47 +0100
Message-ID: <1518090470-2899-1-git-send-email-brueckner@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-perf-users/>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

With commit 857f46b "s390/syscalls: add system call table", I have
introduced a syscall.tbl file to generate the system call table for
s390, as well as, respective unistd.h header files for 64-bit and compat
system calls.

Because the unistd.h is now generated, update perf with a copy of the
syscall.tbl file and adapt the script that generates the system call
table for perf trace to support wildcard syscall matches.

The patch set is based on the perf/core branch.

Hendrik Brueckner (3):
  Revert "tools include s390: Grab a copy of
    arch/s390/include/uapi/asm/unistd.h"
  perf s390: Grab a copy of arch/s390/kernel/syscall/syscall.tbl
  perf s390: Rework system call table creation by using syscall.tbl

 tools/arch/s390/include/uapi/asm/unistd.h        | 412 -----------------------
 tools/perf/arch/s390/Makefile                    |  10 +-
 tools/perf/arch/s390/entry/syscalls/mksyscalltbl |  18 +-
 tools/perf/arch/s390/entry/syscalls/syscall.tbl  | 390 +++++++++++++++++++++
 tools/perf/check-headers.sh                      |   1 -
 5 files changed, 404 insertions(+), 427 deletions(-)
 delete mode 100644 tools/arch/s390/include/uapi/asm/unistd.h
 create mode 100644 tools/perf/arch/s390/entry/syscalls/syscall.tbl

-- 
1.8.3.1
