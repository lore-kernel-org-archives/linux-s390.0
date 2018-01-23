From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 4/5] s390: define ISOLATE_BP to run tasks with modified
 branch prediction
Date: Tue, 23 Jan 2018 15:21:21 +0100
Message-ID: <ac891f07-cd8d-83a6-0a16-cb99b69080e0@de.ibm.com>
References: <1516712825-2917-1-git-send-email-schwidefsky@de.ibm.com>
 <1516712825-2917-5-git-send-email-schwidefsky@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1516712825-2917-5-git-send-email-schwidefsky@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim,

this patch not only allows to isolate a userspace process, it also allows us
to add a new interface for KVM that would allow us to isolate a KVM guest CPU
to no longer being able to inject branches in any host or other  guests. (while
at the same time QEMU and host kernel can run with full power). 
We just have to set the TIF bit TIF_ISOLATE_BP_GUEST for the thread that runs a
given CPU. This would certainly be an addon patch on top of this patch at a later
point in time.

Do you think something similar would be useful for other architectures as well?
In that case we should try to come up with a cross-architecture interface to enable
that.

Christian



On 01/23/2018 02:07 PM, Martin Schwidefsky wrote:
> Define the ISOLATE_BP macro to enable the use of the PR_ISOLATE_BP process
> control to switch a task from the standard branch prediction to a modified,
> more secure but slower behaviour.
> 
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> ---
>  arch/s390/include/asm/processor.h   |  3 +++
>  arch/s390/include/asm/thread_info.h |  4 +++
>  arch/s390/kernel/entry.S            | 51 +++++++++++++++++++++++++++++++++----
>  arch/s390/kernel/processor.c        |  8 ++++++
>  4 files changed, 61 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
> index 5f37f9c..99ee222 100644
> --- a/arch/s390/include/asm/processor.h
> +++ b/arch/s390/include/asm/processor.h
> @@ -378,6 +378,9 @@ extern void memcpy_absolute(void *, void *, size_t);
>  	memcpy_absolute(&(dest), &__tmp, sizeof(__tmp));	\
>  } while (0)
> 
> +extern int s390_isolate_bp(void);
> +#define ISOLATE_BP s390_isolate_bp
> +
>  #endif /* __ASSEMBLY__ */
> 
>  #endif /* __ASM_S390_PROCESSOR_H */
> diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
> index 0880a37..301b4f7 100644
> --- a/arch/s390/include/asm/thread_info.h
> +++ b/arch/s390/include/asm/thread_info.h
> @@ -60,6 +60,8 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
>  #define TIF_GUARDED_STORAGE	4	/* load guarded storage control block */
>  #define TIF_PATCH_PENDING	5	/* pending live patching update */
>  #define TIF_PGSTE		6	/* New mm's will use 4K page tables */
> +#define TIF_ISOLATE_BP		8	/* Run process with isolated BP */
> +#define TIF_ISOLATE_BP_GUEST	9	/* Run KVM guests with isolated BP */
> 
>  #define TIF_31BIT		16	/* 32bit process */
>  #define TIF_MEMDIE		17	/* is terminating due to OOM killer */
> @@ -80,6 +82,8 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
>  #define _TIF_UPROBE		_BITUL(TIF_UPROBE)
>  #define _TIF_GUARDED_STORAGE	_BITUL(TIF_GUARDED_STORAGE)
>  #define _TIF_PATCH_PENDING	_BITUL(TIF_PATCH_PENDING)
> +#define _TIF_ISOLATE_BP		_BITUL(TIF_ISOLATE_BP)
> +#define _TIF_ISOLATE_BP_GUEST	_BITUL(TIF_ISOLATE_BP_GUEST)
> 
>  #define _TIF_31BIT		_BITUL(TIF_31BIT)
>  #define _TIF_SINGLE_STEP	_BITUL(TIF_SINGLE_STEP)
> diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
> index dab716b..07e4e46 100644
> --- a/arch/s390/kernel/entry.S
> +++ b/arch/s390/kernel/entry.S
> @@ -107,6 +107,7 @@ _PIF_WORK	= (_PIF_PER_TRAP | _PIF_SYSCALL_RESTART)
>  	aghi	%r15,-(STACK_FRAME_OVERHEAD + __PT_SIZE)
>  	j	3f
>  1:	UPDATE_VTIME %r14,%r15,\timer
> +	BPENTER __TI_flags(%r12),_TIF_ISOLATE_BP
>  2:	lg	%r15,__LC_ASYNC_STACK	# load async stack
>  3:	la	%r11,STACK_FRAME_OVERHEAD(%r15)
>  	.endm
> @@ -187,6 +188,40 @@ _PIF_WORK	= (_PIF_PER_TRAP | _PIF_SYSCALL_RESTART)
>  	.popsection
>  	.endm
> 
> +	.macro BPENTER tif_ptr,tif_mask
> +	.pushsection .altinstr_replacement, "ax"
> +662:	.word	0xc004, 0x0000, 0x0000	# 6 byte nop
> +	.word	0xc004, 0x0000, 0x0000	# 6 byte nop
> +	.popsection
> +664:	TSTMSK	\tif_ptr,\tif_mask
> +	jz	. + 8
> +	.long	0xb2e8d000
> +	.pushsection .altinstructions, "a"
> +	.long 664b - .
> +	.long 662b - .
> +	.word 82
> +	.byte 12
> +	.byte 12
> +	.popsection
> +	.endm
> +
> +	.macro BPEXIT tif_ptr,tif_mask
> +	TSTMSK	\tif_ptr,\tif_mask
> +	.pushsection .altinstr_replacement, "ax"
> +662:	jnz	. + 8
> +	.long	0xb2e8d000
> +	.popsection
> +664:	jz	. + 8
> +	.long	0xb2e8c000
> +	.pushsection .altinstructions, "a"
> +	.long 664b - .
> +	.long 662b - .
> +	.word 82
> +	.byte 8
> +	.byte 8
> +	.popsection
> +	.endm
> +
>  	.section .kprobes.text, "ax"
>  .Ldummy:
>  	/*
> @@ -240,9 +275,11 @@ ENTRY(__switch_to)
>   */
>  ENTRY(sie64a)
>  	stmg	%r6,%r14,__SF_GPRS(%r15)	# save kernel registers
> +	lg	%r12,__LC_CURRENT
>  	stg	%r2,__SF_EMPTY(%r15)		# save control block pointer
>  	stg	%r3,__SF_EMPTY+8(%r15)		# save guest register save area
>  	xc	__SF_EMPTY+16(8,%r15),__SF_EMPTY+16(%r15) # reason code = 0
> +	mvc	__SF_EMPTY+24(8,%r15),__TI_flags(%r12) # copy thread flags
>  	TSTMSK	__LC_CPU_FLAGS,_CIF_FPU		# load guest fp/vx registers ?
>  	jno	.Lsie_load_guest_gprs
>  	brasl	%r14,load_fpu_regs		# load guest fp/vx regs
> @@ -259,11 +296,12 @@ ENTRY(sie64a)
>  	jnz	.Lsie_skip
>  	TSTMSK	__LC_CPU_FLAGS,_CIF_FPU
>  	jo	.Lsie_skip			# exit if fp/vx regs changed
> -	BPON
> +	BPEXIT	__SF_EMPTY+24(%r15),(_TIF_ISOLATE_BP|_TIF_ISOLATE_BP_GUEST)
>  .Lsie_entry:
>  	sie	0(%r14)
>  .Lsie_exit:
>  	BPOFF
> +	BPENTER	__SF_EMPTY+24(%r15),(_TIF_ISOLATE_BP|_TIF_ISOLATE_BP_GUEST)
>  .Lsie_skip:
>  	ni	__SIE_PROG0C+3(%r14),0xfe	# no longer in SIE
>  	lctlg	%c1,%c1,__LC_USER_ASCE		# load primary asce
> @@ -318,6 +356,7 @@ ENTRY(system_call)
>  	la	%r11,STACK_FRAME_OVERHEAD(%r15)	# pointer to pt_regs
>  .Lsysc_vtime:
>  	UPDATE_VTIME %r8,%r9,__LC_SYNC_ENTER_TIMER
> +	BPENTER __TI_flags(%r12),_TIF_ISOLATE_BP
>  	stmg	%r0,%r7,__PT_R0(%r11)
>  	mvc	__PT_R8(64,%r11),__LC_SAVE_AREA_SYNC
>  	mvc	__PT_PSW(16,%r11),__LC_SVC_OLD_PSW
> @@ -354,7 +393,7 @@ ENTRY(system_call)
>  	jnz	.Lsysc_work			# check for work
>  	TSTMSK	__LC_CPU_FLAGS,_CIF_WORK
>  	jnz	.Lsysc_work
> -	BPON
> +	BPEXIT	__TI_flags(%r12),_TIF_ISOLATE_BP
>  .Lsysc_restore:
>  	lg	%r14,__LC_VDSO_PER_CPU
>  	lmg	%r0,%r10,__PT_R0(%r11)
> @@ -589,6 +628,7 @@ ENTRY(pgm_check_handler)
>  	aghi	%r15,-(STACK_FRAME_OVERHEAD + __PT_SIZE)
>  	j	4f
>  2:	UPDATE_VTIME %r14,%r15,__LC_SYNC_ENTER_TIMER
> +	BPENTER __TI_flags(%r12),_TIF_ISOLATE_BP
>  	lg	%r15,__LC_KERNEL_STACK
>  	lgr	%r14,%r12
>  	aghi	%r14,__TASK_thread	# pointer to thread_struct
> @@ -702,7 +742,7 @@ ENTRY(io_int_handler)
>  	mvc	__LC_RETURN_PSW(16),__PT_PSW(%r11)
>  	tm	__PT_PSW+1(%r11),0x01	# returning to user ?
>  	jno	.Lio_exit_kernel
> -	BPON
> +	BPEXIT	__TI_flags(%r12),_TIF_ISOLATE_BP
>  .Lio_exit_timer:
>  	stpt	__LC_EXIT_TIMER
>  	mvc	__VDSO_ECTG_BASE(16,%r14),__LC_EXIT_TIMER
> @@ -1118,7 +1158,7 @@ ENTRY(mcck_int_handler)
>  	mvc	__LC_RETURN_MCCK_PSW(16),__PT_PSW(%r11) # move return PSW
>  	tm	__LC_RETURN_MCCK_PSW+1,0x01 # returning to user ?
>  	jno	0f
> -	BPON
> +	BPEXIT	__TI_flags(%r12),_TIF_ISOLATE_BP
>  	stpt	__LC_EXIT_TIMER
>  	mvc	__VDSO_ECTG_BASE(16,%r14),__LC_EXIT_TIMER
>  0:	lmg	%r11,%r15,__PT_R11(%r11)
> @@ -1245,7 +1285,8 @@ cleanup_critical:
>  	clg     %r9,BASED(.Lsie_crit_mcck_length)
>  	jh      1f
>  	oi      __LC_CPU_FLAGS+7, _CIF_MCCK_GUEST
> -1:	lg	%r9,__SF_EMPTY(%r15)		# get control block pointer
> +1:	BPENTER __SF_EMPTY+24(%r15),(_TIF_ISOLATE_BP|_TIF_ISOLATE_BP_GUEST)
> +	lg	%r9,__SF_EMPTY(%r15)		# get control block pointer
>  	ni	__SIE_PROG0C+3(%r9),0xfe	# no longer in SIE
>  	lctlg	%c1,%c1,__LC_USER_ASCE		# load primary asce
>  	larl	%r9,sie_exit			# skip forward to sie_exit
> diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
> index 5362fd8..5159636 100644
> --- a/arch/s390/kernel/processor.c
> +++ b/arch/s390/kernel/processor.c
> @@ -197,3 +197,11 @@ const struct seq_operations cpuinfo_op = {
>  	.stop	= c_stop,
>  	.show	= show_cpuinfo,
>  };
> +
> +int s390_isolate_bp(void)
> +{
> +	if (!test_facility(82))
> +		return -EOPNOTSUPP;
> +	set_thread_flag(TIF_ISOLATE_BP);
> +	return 0;
> +}
> 
