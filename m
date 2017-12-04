Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 4 Dec 2017 09:34:42 +0100
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/5] bpf: correct broken uapi for
 BPF_PROG_TYPE_PERF_EVENT program type
References: <1512137948-31729-1-git-send-email-brueckner@linux.vnet.ibm.com>
 <1512137948-31729-2-git-send-email-brueckner@linux.vnet.ibm.com>
 <20171203175108.oo75sszrmpdvtukz@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171203175108.oo75sszrmpdvtukz@ast-mbp>
Message-Id: <20171204083442.GA3952@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Alexei,

On Sun, Dec 03, 2017 at 09:51:10AM -0800, Alexei Starovoitov wrote:
> On Fri, Dec 01, 2017 at 03:19:04PM +0100, Hendrik Brueckner wrote:
> > --- a/include/uapi/linux/bpf_perf_event.h
> > +++ b/include/uapi/linux/bpf_perf_event.h
> > @@ -8,11 +8,10 @@
> >  #ifndef _UAPI__LINUX_BPF_PERF_EVENT_H__
> >  #define _UAPI__LINUX_BPF_PERF_EVENT_H__
> >  
> > -#include <linux/types.h>
> > -#include <linux/ptrace.h>
> > +#include <asm/bpf_perf_event.h>
> >  
> >  struct bpf_perf_event_data {
> > -	struct pt_regs regs;
> > +	bpf_user_pt_regs_t regs;
> >  	__u64 sample_period;
> >  };
> 
> Thank you for working on this problem.
> The fix looks great to me.

Thank you.

> While applying it I noticed few nits:
> Applying: selftests/bpf: sync kernel headers and introduce arch support in Makefile
> /w/bpf/.git/rebase-apply/patch:253: trailing whitespace.
>         freg_t  fprs[NUM_FPRS];
> /w/bpf/.git/rebase-apply/patch:262: trailing whitespace.
> typedef struct
> /w/bpf/.git/rebase-apply/patch:439: trailing whitespace.
>         } lowcore;
> /w/bpf/.git/rebase-apply/patch:490: trailing whitespace.
> } ptprot_area;
> warning: 4 lines add whitespace errors.
> 
> Could you please fix those and resubmit ?

Sure will do.  For that I have to add a clean-up patch for the s390 ptrace.h
uapi header.

> With that fixed feel free to add my
> Acked-by: Alexei Starovoitov <ast@kernel.org>
> to the patches.

Thank you very much, will do!

> I've tested it on arm64 and don't see any issues.

I got a nice message from the build bot, I have some more work on that.
So will respin the series, add you Acked-by, and sent a v2 around.

> When resubmitting could you please reduce cc-list, since this set
> went into spam folder for me and I noticed it only in patchworks.

Will do... I just used what get_maintainers.pl told me :)
