Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42638 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729272AbgICOUv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 3 Sep 2020 10:20:51 -0400
Subject: Re: [PATCH 2/2] s390x: Add 3f program exception handler
References: <20200903131435.2535-1-frankja@linux.ibm.com>
 <20200903131435.2535-3-frankja@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <f5b8e157-4d27-591a-781c-febd606e65a8@de.ibm.com>
Date: Thu, 3 Sep 2020 16:20:42 +0200
MIME-Version: 1.0
In-Reply-To: <20200903131435.2535-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, david@redhat.com



On 03.09.20 15:14, Janosch Frank wrote:
> Program exception 3f (secure storage violation) can only be detected
> when the CPU is running in SIE with a format 4 state description,
> e.g. running a protected guest. Because of this and because user
> space partly controls the guest memory mapping and can trigger this
> exception, we want to send a SIGSEGV to the process running the guest
> and not panic the kernel.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> CC: <stable@vger.kernel.org> # 5.7+
> Fixes: 084ea4d611a3 ("s390/mm: add (non)secure page access exceptions handlers")
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

I guess we will pick this up via the s390 tree?

 
> ---
>  arch/s390/kernel/pgm_check.S |  2 +-
>  arch/s390/mm/fault.c         | 23 +++++++++++++++++++++++
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kernel/pgm_check.S b/arch/s390/kernel/pgm_check.S
> index 2c27907a5ffc..9a92638360ee 100644
> --- a/arch/s390/kernel/pgm_check.S
> +++ b/arch/s390/kernel/pgm_check.S
> @@ -80,7 +80,7 @@ PGM_CHECK(do_dat_exception)		/* 3b */
>  PGM_CHECK_DEFAULT			/* 3c */
>  PGM_CHECK(do_secure_storage_access)	/* 3d */
>  PGM_CHECK(do_non_secure_storage_access)	/* 3e */
> -PGM_CHECK_DEFAULT			/* 3f */
> +PGM_CHECK(do_secure_storage_violation)	/* 3f */
>  PGM_CHECK(monitor_event_exception)	/* 40 */
>  PGM_CHECK_DEFAULT			/* 41 */
>  PGM_CHECK_DEFAULT			/* 42 */
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index 4c8c063bce5b..20abb7c5c540 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -859,6 +859,24 @@ void do_non_secure_storage_access(struct pt_regs *regs)
>  }
>  NOKPROBE_SYMBOL(do_non_secure_storage_access);
>  
> +void do_secure_storage_violation(struct pt_regs *regs)
> +{
> +	char buf[TASK_COMM_LEN];
> +
> +	/*
> +	 * Either KVM messed up the secure guest mapping or the same
> +	 * page is mapped into multiple secure guests.
> +	 *
> +	 * This exception is only triggered when a guest 2 is running
> +	 * and can therefore never occur in kernel context.
> +	 */
> +	printk_ratelimited(KERN_WARNING
> +			   "Secure storage violation in task: %s, pid %d\n",
> +			   get_task_comm(buf, current), task_pid_nr(current));
> +	send_sig(SIGSEGV, current, 0);
> +}
> +NOKPROBE_SYMBOL(do_secure_storage_violation);
> +
>  #else
>  void do_secure_storage_access(struct pt_regs *regs)
>  {
> @@ -869,4 +887,9 @@ void do_non_secure_storage_access(struct pt_regs *regs)
>  {
>  	default_trap_handler(regs);
>  }
> +
> +void do_secure_storage_violation(struct pt_regs *regs)
> +{
> +	default_trap_handler(regs);
> +}
>  #endif
> 
