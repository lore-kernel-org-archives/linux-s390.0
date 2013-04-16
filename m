From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 3/5] dump_stack: consolidate dump_stack() implementations
 and unify their behaviors
Date: Tue, 16 Apr 2013 15:59:24 +0100
Message-ID: <516D674C.80504@imgtec.com>
References: <1364610428-2074-1-git-send-email-tj@kernel.org> <1364610428-2074-4-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <1364610428-2074-4-git-send-email-tj@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, mingo@redhat.com, x86@kernel.org, rth@twiddle.net, linux@arm.linux.org.uk, msalter@redhat.com, starvik@axis.com, dhowells@redhat.com, tony.luck@intel.com, benh@kernel.crashing.org, takata@linux-m32r.org, geert@linux-m68k.org, monstr@monstr.eu, ralf@linux-mips.org, jonas@southpole.se, rkuo@codeaurora.org, schwidefsky@de.ibm.com, liqin.chen@sunplusct.com, davem@davemloft.net, lethal@linux-sh.org, vgupta@synopsys.com, chris@zankel.net, cmetcalf@tilera.com, ysato@users.sourceforge.jp, gxt@mprc.pku.edu.cn, jdike@addtoit.com, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Mike Frysinger <vapier@gentoo.org>, uclinux-dist-devel@blackfin.uclinux.org
List-ID: <linux-s390.vger.kernel.org>

On 30/03/13 02:27, Tejun Heo wrote:
> Both dump_stack() and show_stack() are currently implemented by each
> architecture.  show_stack(NULL, NULL) dumps the backtrace for the
> current task as does dump_stack().  On some archs, dump_stack() prints
> extra information - pid, utsname and so on - in addition to the
> backtrace while the two are identical on other archs.
> 
> The usages in arch-independent code of the two functions indicate
> show_stack(NULL, NULL) should print out bare backtrace while
> dump_stack() is used for debugging purposes when something went wrong,
> so it does make sense to print additional information on the task
> which triggered dump_stack().
> 
> There's no reason to require archs to implement two separate but
> mostly identical functions.  It leads to unnecessary subtle
> differences among archs and makes it very tedius to add generic debug
> information.
> 
> This patch expands the dummy fallback dump_stack() implementation in
> lib/dump_stack.c such that it prints out debug information (taken from
> x86) and invokes show_stack(NULL, NULL) and drops arch-specific
> dump_stack() implementations in all archs except blackfin and s390.
> Blackfin's dump_stack() does something wonky that I don't understand
> and s390 prints its own debug information which includes fields which
> aren't accessible from arch-indepdent code.
> 
> Debug information can be printed separately by calling
> dump_stack_print_info() so that arch-specific dump_stack()
> implementation can still emit the same debug information.  This is
> used in blackfin.
> 
> This patch brings the following behavior changes.
> 
> * On some archs, an extra level in backtrace for show_stack() could be
>   printed.  This is because the top frame was determined in
>   dump_stack() on those archs while generic dump_stack() can't do that
>   reliably.  It can be compensated by inlining dump_stack() but not
>   sure whether that'd be necessary.
> 
> * Most archs didn't use to print debug info on dump_stack().  They do
>   now.
> 
> An example WARN dump follows.
> 
>  WARNING: at /work/os/work/kernel/workqueue.c:4840 init_workqueues+0x35/0x505()
>  Hardware name: empty
>  Modules linked in:
>  Pid: 1, comm: swapper/0 Not tainted 3.9.0-rc1-work+ #17
>   0000000000000009 ffff88007c861e08 ffffffff81c61545 ffff88007c861e48
>   ffffffff8108f50f ffffffff82228240 0000000000000040 ffffffff8234a03c
>   0000000000000000 0000000000000000 0000000000000000 ffff88007c861e58
>  Call Trace:
>   [<ffffffff81c61545>] dump_stack+0x19/0x1b
>   [<ffffffff8108f50f>] warn_slowpath_common+0x7f/0xc0
>   [<ffffffff8108f56a>] warn_slowpath_null+0x1a/0x20
>   [<ffffffff8234a071>] init_workqueues+0x35/0x505
>   ...
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Cc: Mike Frysinger <vapier@gentoo.org>
> Cc: uclinux-dist-devel@blackfin.uclinux.org

For metag:
Acked-by: James Hogan <james.hogan@imgtec.com>
