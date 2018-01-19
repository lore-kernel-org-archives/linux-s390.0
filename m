From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH v2 0/5] perf trace: Introduce arch-specific errno code/name mappings
Date: Fri, 19 Jan 2018 09:56:12 +0100
Message-ID: <1516352177-11106-1-git-send-email-brueckner@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-perf-users/>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Introduce an interface to perf to resolve errno codes to their names.
This is used by perf trace to display the errno name, for example, ENOENT,
for an system call.  The previous implementation used the errno_to_name()
function from the audit library.

With this change, a table of errno codes and their names are created for
each architecture on which perf is supported (others can be easily added
if necessary).  The errno_to_name() function from the audit library is
replaced with an arch-specific one, arch_errno_to_name().

The benefit is that perf trace does not longer have a direct dependency
for the audit library and the perf trace output can be displayed across
architectures.  For example, collect trace output on s390 and display it
on x86.

The audit library dependency can be further reduced and completely removed
for architectures that support system call tables in perf (see last commit).

See also discussion on:
- https://www.spinics.net/lists/linux-perf-users/msg04782.html
- https://www.spinics.net/lists/linux-perf-users/msg05005.html

Please note that this patch set is bases on the perf/core branch.

Changes in v2:
As the arch_errno_to_name() mapping is used by perf trace only,
move all the scripts and generated files from tools/perf/util/
to the tools/perf/trace/beauty/{generated/} directories.
See also https://www.spinics.net/lists/linux-perf-users/msg05037.html


Hendrik Brueckner (5):
  tools include arch: Grab a copy of errno.h for arch's supported by
    perf
  tools include asm-generic: Grab errno.h and errno-base.h
  perf util: Introduce architecture specific errno/name mapping
  perf trace: Obtain errno values by using arch_syscalls__strerrno()
  perf trace: Remove audit-libs dependency if syscall tables are present

 tools/arch/alpha/include/uapi/asm/errno.h   | 128 +++++++++++++++++++++++++++
 tools/arch/mips/include/asm/errno.h         |  17 ++++
 tools/arch/mips/include/uapi/asm/errno.h    | 130 ++++++++++++++++++++++++++++
 tools/arch/parisc/include/uapi/asm/errno.h  | 128 +++++++++++++++++++++++++++
 tools/arch/powerpc/include/uapi/asm/errno.h |  10 +++
 tools/arch/sparc/include/uapi/asm/errno.h   | 118 +++++++++++++++++++++++++
 tools/arch/x86/include/uapi/asm/errno.h     |   1 +
 tools/include/uapi/asm-generic/errno-base.h |  40 +++++++++
 tools/include/uapi/asm-generic/errno.h      | 123 ++++++++++++++++++++++++++
 tools/perf/Makefile.config                  |  10 ++-
 tools/perf/Makefile.perf                    |  13 ++-
 tools/perf/builtin-help.c                   |   2 +-
 tools/perf/builtin-trace.c                  |  14 ++-
 tools/perf/check-headers.sh                 |   9 ++
 tools/perf/perf.c                           |   4 +-
 tools/perf/trace/beauty/arch_errno_names.c  |   1 +
 tools/perf/trace/beauty/arch_errno_names.sh | 100 +++++++++++++++++++++
 tools/perf/trace/beauty/beauty.h            |   2 +
 tools/perf/util/generate-cmdlist.sh         |   2 +-
 19 files changed, 841 insertions(+), 11 deletions(-)
 create mode 100644 tools/arch/alpha/include/uapi/asm/errno.h
 create mode 100644 tools/arch/mips/include/asm/errno.h
 create mode 100644 tools/arch/mips/include/uapi/asm/errno.h
 create mode 100644 tools/arch/parisc/include/uapi/asm/errno.h
 create mode 100644 tools/arch/powerpc/include/uapi/asm/errno.h
 create mode 100644 tools/arch/sparc/include/uapi/asm/errno.h
 create mode 100644 tools/arch/x86/include/uapi/asm/errno.h
 create mode 100644 tools/include/uapi/asm-generic/errno-base.h
 create mode 100644 tools/include/uapi/asm-generic/errno.h
 create mode 100644 tools/perf/trace/beauty/arch_errno_names.c
 create mode 100755 tools/perf/trace/beauty/arch_errno_names.sh

-- 
1.8.3.1
