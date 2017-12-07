From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH 0/3] perf: generate s390 syscall table and remove auditlibs dependency
Date: Thu,  7 Dec 2017 09:27:58 +0100
Message-ID: <1512635281-20733-1-git-send-email-brueckner@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-perf-users/>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

With the perf trace command you can specify system calls with wildcards.
To support this on s390, a system call table must be provided to perf.
Provide a script to create the perf system call table based on the defines
in arch/s390/include/uapi/asm/unistd.h (copied to tools/arch/s390/...).

Note that the first patch can be applied independent of the second and
third patch.  In case they need further discussion, please consider to
integrate the first one.

The second and third patches complete the work to remove the audit library
dependency for perf trace when an architecture supports system call tables.

Inspired by the generation of the system call tables, create a similar
approach to generate errno name mappings.  Introduce the errno_to_name()
function to replace audit_errno_to_name() in perf trace.  The third
patch changes the build process to build and run perf trace without
requiring the audit library anymore (for those architectures that have
system call table support).

Note: The patch set is based on the linux master branch (968edbd93c0cbb).


Hendrik Brueckner (3):
  perf s390: generate system call table from asm/unistd.h
  perf: introduce errno_to_name() function
  perf trace: no longer require auditlibs if syscall tables are present

 tools/arch/s390/include/uapi/asm/unistd.h        | 412 +++++++++++++++++++++++
 tools/perf/.gitignore                            |   1 +
 tools/perf/Makefile.config                       |  22 +-
 tools/perf/Makefile.perf                         |  12 +-
 tools/perf/arch/s390/Makefile                    |  21 ++
 tools/perf/arch/s390/entry/syscalls/mksyscalltbl |  36 ++
 tools/perf/builtin-help.c                        |   2 +-
 tools/perf/builtin-trace.c                       |  17 +-
 tools/perf/check-headers.sh                      |   1 +
 tools/perf/perf.c                                |   4 +-
 tools/perf/util/generate-cmdlist.sh              |   2 +-
 tools/perf/util/generate-errno-names.sh          |  32 ++
 tools/perf/util/syscalltbl.c                     |   4 +
 13 files changed, 553 insertions(+), 13 deletions(-)
 create mode 100644 tools/arch/s390/include/uapi/asm/unistd.h
 create mode 100755 tools/perf/arch/s390/entry/syscalls/mksyscalltbl
 create mode 100755 tools/perf/util/generate-errno-names.sh

-- 
1.8.3.1
