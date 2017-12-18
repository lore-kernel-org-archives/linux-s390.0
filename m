From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH] bpf: fix broken BPF selftest build on s390
Date: Mon, 18 Dec 2017 14:09:57 +0100
Message-ID: <1513602597-12280-1-git-send-email-brueckner@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, netdev@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

With 720f228e8d31 ("bpf: fix broken BPF selftest build") the
inclusion of arch-specific header files changed.  Including the
asm/bpf_perf_event.h on s390, correctly includes the s390 specific
header file.  This header file tries then to include the s390
asm/ptrace.h and the build fails with:

cc -Wall -O2 -I../../../include/uapi -I../../../lib -I../../../../include/generated  -I../../../include    test_verifier.c
+/root/git/linux/tools/testing/selftests/bpf/libbpf.a /root/git/linux/tools/testing/selftests/bpf/cgroup_helpers.c -lcap -lelf -o
+/root/git/linux/tools/testing/selftests/bpf/test_verifier
In file included from ../../../include/uapi/asm/bpf_perf_event.h:4:0,
                 from ../../../include/uapi/linux/bpf_perf_event.h:11,
                 from test_verifier.c:29:
../../../include/uapi/../../arch/s390/include/uapi/asm/bpf_perf_event.h:7:9: error: unknown type name 'user_pt_regs'
 typedef user_pt_regs bpf_user_pt_regs_t;
         ^~~~~~~~~~~~
make: *** [../lib.mk:109: /root/git/linux/tools/testing/selftests/bpf/test_verifier] Error 1

This is caused by a recent update to the s390 asm/ptrace.h file
that is not (yet) available in the local installation.  That means,
the s390 asm/ptrace.h must be included from the tools/arch/s390
directory.

Because there is no proper framework to deal with asm specific
includes in tools/, slightly modify the s390 asm/bpf_perf_event.h
to include the local ptrace.h header file.

See also discussion on
https://marc.info/?l=linux-s390&m=151359424420691&w=2

Please note that this needs to be preserved until tools/ is able to
correctly handle asm specific headers.

References: https://marc.info/?l=linux-s390&m=151359424420691&w=2
Fixes: 720f228e8d31 ("bpf: fix broken BPF selftest build")
Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 tools/arch/s390/include/uapi/asm/bpf_perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/arch/s390/include/uapi/asm/bpf_perf_event.h b/tools/arch/s390/include/uapi/asm/bpf_perf_event.h
index cefe7c7..0a8e37a 100644
--- a/tools/arch/s390/include/uapi/asm/bpf_perf_event.h
+++ b/tools/arch/s390/include/uapi/asm/bpf_perf_event.h
@@ -2,7 +2,7 @@
 #ifndef _UAPI__ASM_BPF_PERF_EVENT_H__
 #define _UAPI__ASM_BPF_PERF_EVENT_H__
 
-#include <asm/ptrace.h>
+#include "ptrace.h"
 
 typedef user_pt_regs bpf_user_pt_regs_t;
 
-- 
1.8.3.1
