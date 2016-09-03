Date: Sat, 3 Sep 2016 12:59:28 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] uprobes: remove function declarations from
 arch/{mips,s390}
References: <1472804384-17830-1-git-send-email-marcin.nowakowski@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1472804384-17830-1-git-send-email-marcin.nowakowski@imgtec.com>
Message-Id: <20160903105928.GB3917@osiris>
Return-Path: <heiko.carstens@de.ibm.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
To: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, ralf@linux-mips.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, Sep 02, 2016 at 10:19:44AM +0200, Marcin Nowakowski wrote:
> The declarations of arch-specific functions have been moved to a common
> header in commit 3820b4d2789f ('uprobes: Move function declarations out of
> arch'), but MIPS and S390 has added them to their own trees later.
> Remove the unnecessary duplicates.
> 
> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
> ---
>  arch/mips/include/asm/uprobes.h | 12 ------------
>  arch/s390/include/asm/uprobes.h | 10 ----------
>  2 files changed, 22 deletions(-)

You may either split this patch into two patches (mips/s390) so it can be
applied to the different architecture trees, or send it as single patch to
Andrew Morton, so he can pick it.

In any case:

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

> 
> diff --git a/arch/mips/include/asm/uprobes.h b/arch/mips/include/asm/uprobes.h
> index 34c325c..28ab364 100644
> --- a/arch/mips/include/asm/uprobes.h
> +++ b/arch/mips/include/asm/uprobes.h
> @@ -43,16 +43,4 @@ struct arch_uprobe_task {
>  	unsigned long saved_trap_nr;
>  };
> 
> -extern int arch_uprobe_analyze_insn(struct arch_uprobe *aup,
> -	struct mm_struct *mm, unsigned long addr);
> -extern int arch_uprobe_pre_xol(struct arch_uprobe *aup, struct pt_regs *regs);
> -extern int arch_uprobe_post_xol(struct arch_uprobe *aup, struct pt_regs *regs);
> -extern bool arch_uprobe_xol_was_trapped(struct task_struct *tsk);
> -extern int arch_uprobe_exception_notify(struct notifier_block *self,
> -	unsigned long val, void *data);
> -extern void arch_uprobe_abort_xol(struct arch_uprobe *aup,
> -	struct pt_regs *regs);
> -extern unsigned long arch_uretprobe_hijack_return_addr(
> -	unsigned long trampoline_vaddr, struct pt_regs *regs);
> -
>  #endif /* __ASM_UPROBES_H */
> diff --git a/arch/s390/include/asm/uprobes.h b/arch/s390/include/asm/uprobes.h
> index 1411dff..658393c 100644
> --- a/arch/s390/include/asm/uprobes.h
> +++ b/arch/s390/include/asm/uprobes.h
> @@ -29,14 +29,4 @@ struct arch_uprobe {
>  struct arch_uprobe_task {
>  };
> 
> -int arch_uprobe_analyze_insn(struct arch_uprobe *aup, struct mm_struct *mm,
> -			     unsigned long addr);
> -int arch_uprobe_pre_xol(struct arch_uprobe *aup, struct pt_regs *regs);
> -int arch_uprobe_post_xol(struct arch_uprobe *aup, struct pt_regs *regs);
> -bool arch_uprobe_xol_was_trapped(struct task_struct *tsk);
> -int arch_uprobe_exception_notify(struct notifier_block *self, unsigned long val,
> -				 void *data);
> -void arch_uprobe_abort_xol(struct arch_uprobe *ap, struct pt_regs *regs);
> -unsigned long arch_uretprobe_hijack_return_addr(unsigned long trampoline,
> -						struct pt_regs *regs);
>  #endif	/* _ASM_UPROBES_H */
> -- 
> 2.7.4
> 
