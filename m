From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: Re: [PATCH bpf 3/3] bpf: fix broken BPF selftest build
Date: Mon, 18 Dec 2017 10:28:43 +0100
Message-ID: <20171218092843.GA4571@linux.vnet.ibm.com>
References: <20171212012532.30268-1-daniel@iogearbox.net>
 <20171212012532.30268-4-daniel@iogearbox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171212012532.30268-4-daniel@iogearbox.net>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, netdev@vger.kernel.org, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Daniel,

On Tue, Dec 12, 2017 at 02:25:32AM +0100, Daniel Borkmann wrote:
> At least on x86_64, the kernel's BPF selftests seemed to have stopped
> to build due to 618e165b2a8e ("selftests/bpf: sync kernel headers and
> introduce arch support in Makefile"):
> 
>   [...]
>   In file included from test_verifier.c:29:0:
>   ../../../include/uapi/linux/bpf_perf_event.h:11:32:
>      fatal error: asm/bpf_perf_event.h: No such file or directory
>    #include <asm/bpf_perf_event.h>
>                                 ^
>   compilation terminated.
>   [...]
> 
> While pulling in tools/arch/*/include/uapi/asm/bpf_perf_event.h seems
> to work fine, there's no automated fall-back logic right now that would
> do the same out of tools/include/uapi/asm-generic/bpf_perf_event.h. The
> usual convention today is to add a include/[uapi/]asm/ equivalent that
> would pull in the correct arch header or generic one as fall-back, all
> ifdef'ed based on compiler target definition. It's similarly done also
> in other cases such as tools/include/asm/barrier.h, thus adapt the same
> here.
> 
> Fixes: 618e165b2a8e ("selftests/bpf: sync kernel headers and introduce arch support in Makefile")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Acked-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  tools/include/uapi/asm/bpf_perf_event.h |  7 +++++++
>  tools/testing/selftests/bpf/Makefile    | 13 +------------
>  2 files changed, 8 insertions(+), 12 deletions(-)
>  create mode 100644 tools/include/uapi/asm/bpf_perf_event.h
> 
> diff --git a/tools/include/uapi/asm/bpf_perf_event.h b/tools/include/uapi/asm/bpf_perf_event.h
> new file mode 100644
> index 0000000..13a5853
> --- /dev/null
> +++ b/tools/include/uapi/asm/bpf_perf_event.h
> @@ -0,0 +1,7 @@
> +#if defined(__aarch64__)
> +#include "../../arch/arm64/include/uapi/asm/bpf_perf_event.h"
> +#elif defined(__s390__)
> +#include "../../arch/s390/include/uapi/asm/bpf_perf_event.h"
> +#else
> +#include <uapi/asm-generic/bpf_perf_event.h>
> +#endif
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 21a2d76..792af7c 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -1,19 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
> 
> -ifeq ($(srctree),)
> -srctree := $(patsubst %/,%,$(dir $(CURDIR)))
> -srctree := $(patsubst %/,%,$(dir $(srctree)))
> -srctree := $(patsubst %/,%,$(dir $(srctree)))
> -srctree := $(patsubst %/,%,$(dir $(srctree)))
> -endif
> -include $(srctree)/tools/scripts/Makefile.arch
> -
> -$(call detected_var,SRCARCH)
> -
>  LIBDIR := ../../../lib
>  BPFDIR := $(LIBDIR)/bpf
>  APIDIR := ../../../include/uapi
> -ASMDIR:= ../../../arch/$(ARCH)/include/uapi

This is actually necessary on s390:

cc -Wall -O2 -I../../../include/uapi -I../../../lib -I../../../../include/generated  -I../../../include    test_verifier.c /root/git/linux/tools/testing/selftests/bpf/libbpf.a /root/git/linux/tools/testing/selftests/bpf/cgroup_helpers.c -lcap -lelf -o /root/git/linux/tools/testing/selftests/bpf/test_verifier
In file included from ../../../include/uapi/asm/bpf_perf_event.h:4:0,
                 from ../../../include/uapi/linux/bpf_perf_event.h:11,
                 from test_verifier.c:29:
../../../include/uapi/../../arch/s390/include/uapi/asm/bpf_perf_event.h:7:9: error: unknown type name 'user_pt_regs'
 typedef user_pt_regs bpf_user_pt_regs_t;
         ^~~~~~~~~~~~
make: *** [../lib.mk:109: /root/git/linux/tools/testing/selftests/bpf/test_verifier] Error 1


The s390 bpf_perf_event.h header file contains an #include for asm/ptrace.h
that defines the user_pt_regs (introduce with my patch set).  For building,
the ptrace.h header file from the tooling must be used, not the local
installed version.

Including the ptrace.h header file directly solves the issue.  Feel free to
merge below snippet into your patch.

Thanks and kind regards,
  Hendrik

---
diff --git a/tools/arch/s390/include/uapi/asm/bpf_perf_event.h b/tools/arch/s390/include/uapi/asm/bpf_perf_event.h
index cefe7c7cd4f6..0a8e37a519f2 100644
--- a/tools/arch/s390/include/uapi/asm/bpf_perf_event.h
+++ b/tools/arch/s390/include/uapi/asm/bpf_perf_event.h
@@ -2,7 +2,7 @@
 #ifndef _UAPI__ASM_BPF_PERF_EVENT_H__
 #define _UAPI__ASM_BPF_PERF_EVENT_H__
 
-#include <asm/ptrace.h>
+#include "ptrace.h"
 
 typedef user_pt_regs bpf_user_pt_regs_t;
 
