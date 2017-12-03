Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 3 Dec 2017 09:51:10 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH 1/5] bpf: correct broken uapi for
 BPF_PROG_TYPE_PERF_EVENT program type
Message-ID: <20171203175108.oo75sszrmpdvtukz@ast-mbp>
References: <1512137948-31729-1-git-send-email-brueckner@linux.vnet.ibm.com>
 <1512137948-31729-2-git-send-email-brueckner@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1512137948-31729-2-git-send-email-brueckner@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Dec 01, 2017 at 03:19:04PM +0100, Hendrik Brueckner wrote:
> Commit 0515e5999a466dfe ("bpf: introduce BPF_PROG_TYPE_PERF_EVENT
> program type") introduced the bpf_perf_event_data structure which
> exports the pt_regs structure.  This is OK for multiple architectures
> but fail for s390 and arm64 which do not export pt_regs.  Programs
> using them, for example, the bpf selftest fail to compile on these
> architectures.
> 
> For s390, exporting the pt_regs is not an option because s390 wants
> to allow changes to it.  For arm64, there is a user_pt_regs structure
> that covers parts of the pt_regs structure for use by user space.
> 
> To solve the broken uapi for s390 and arm64, introduce an abstract
> type for pt_regs and add an asm/bpf_perf_event.h file that concretes
> the type.  An asm-generic header file covers the architectures that
> export pt_regs today.
> 
> The arch-specific enablement for s390 and arm64 follows in separate
> commits.
> 
> Reported-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
> Fixes: 0515e5999a466dfe ("bpf: introduce BPF_PROG_TYPE_PERF_EVENT program type")
> Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> Reviewed-and-tested-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  include/linux/perf_event.h                | 6 +++++-
>  include/uapi/asm-generic/bpf_perf_event.h | 9 +++++++++
>  include/uapi/linux/bpf_perf_event.h       | 5 ++---
>  kernel/events/core.c                      | 2 +-
>  4 files changed, 17 insertions(+), 5 deletions(-)
>  create mode 100644 include/uapi/asm-generic/bpf_perf_event.h
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 2c9c87d..7546822 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -15,6 +15,7 @@
>  #define _LINUX_PERF_EVENT_H
>  
>  #include <uapi/linux/perf_event.h>
> +#include <uapi/linux/bpf_perf_event.h>
>  
>  /*
>   * Kernel-internal data types and definitions:
> @@ -787,7 +788,7 @@ struct perf_output_handle {
>  };
>  
>  struct bpf_perf_event_data_kern {
> -	struct pt_regs *regs;
> +	bpf_user_pt_regs_t *regs;
>  	struct perf_sample_data *data;
>  	struct perf_event *event;
>  };
> @@ -1177,6 +1178,9 @@ extern void perf_tp_event(u16 event_type, u64 count, void *record,
>  		(user_mode(regs) ? PERF_RECORD_MISC_USER : PERF_RECORD_MISC_KERNEL)
>  # define perf_instruction_pointer(regs)	instruction_pointer(regs)
>  #endif
> +#ifndef perf_arch_bpf_user_pt_regs
> +# define perf_arch_bpf_user_pt_regs(regs) regs
> +#endif
>  
>  static inline bool has_branch_stack(struct perf_event *event)
>  {
> diff --git a/include/uapi/asm-generic/bpf_perf_event.h b/include/uapi/asm-generic/bpf_perf_event.h
> new file mode 100644
> index 0000000..53815d2
> --- /dev/null
> +++ b/include/uapi/asm-generic/bpf_perf_event.h
> @@ -0,0 +1,9 @@
> +#ifndef _UAPI__ASM_GENERIC_BPF_PERF_EVENT_H__
> +#define _UAPI__ASM_GENERIC_BPF_PERF_EVENT_H__
> +
> +#include <linux/ptrace.h>
> +
> +/* Export kernel pt_regs structure */
> +typedef struct pt_regs bpf_user_pt_regs_t;
> +
> +#endif /* _UAPI__ASM_GENERIC_BPF_PERF_EVENT_H__ */
> diff --git a/include/uapi/linux/bpf_perf_event.h b/include/uapi/linux/bpf_perf_event.h
> index af549d4..8f95303 100644
> --- a/include/uapi/linux/bpf_perf_event.h
> +++ b/include/uapi/linux/bpf_perf_event.h
> @@ -8,11 +8,10 @@
>  #ifndef _UAPI__LINUX_BPF_PERF_EVENT_H__
>  #define _UAPI__LINUX_BPF_PERF_EVENT_H__
>  
> -#include <linux/types.h>
> -#include <linux/ptrace.h>
> +#include <asm/bpf_perf_event.h>
>  
>  struct bpf_perf_event_data {
> -	struct pt_regs regs;
> +	bpf_user_pt_regs_t regs;
>  	__u64 sample_period;
>  };

Thank you for working on this problem.
The fix looks great to me.
While applying it I noticed few nits:
Applying: selftests/bpf: sync kernel headers and introduce arch support in Makefile
/w/bpf/.git/rebase-apply/patch:253: trailing whitespace.
        freg_t  fprs[NUM_FPRS];
/w/bpf/.git/rebase-apply/patch:262: trailing whitespace.
typedef struct
/w/bpf/.git/rebase-apply/patch:439: trailing whitespace.
        } lowcore;
/w/bpf/.git/rebase-apply/patch:490: trailing whitespace.
} ptprot_area;
warning: 4 lines add whitespace errors.

Could you please fix those and resubmit ?
With that fixed feel free to add my
Acked-by: Alexei Starovoitov <ast@kernel.org>
to the patches.
I've tested it on arm64 and don't see any issues.

When resubmitting could you please reduce cc-list, since this set
went into spam folder for me and I noticed it only in patchworks.
Thanks
