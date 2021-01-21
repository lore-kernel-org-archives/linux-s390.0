Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39676 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733185AbhAUPmQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 21 Jan 2021 10:42:16 -0500
Subject: Re: [PATCH v2 2/2] s390: mm: Fix secure storage access exception
 handling
References: <20210121151436.417240-1-frankja@linux.ibm.com>
 <20210121151436.417240-3-frankja@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <a1d228f4-0710-bdaa-a923-d2ca24cff9f7@de.ibm.com>
Date: Thu, 21 Jan 2021 16:41:26 +0100
MIME-Version: 1.0
In-Reply-To: <20210121151436.417240-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, thuth@redhat.com, david@redhat.com, imbrenda@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org, gor@linux.ibm.com, hca@linux.ibm.com, mihajlov@linux.ibm.com


On 21.01.21 16:14, Janosch Frank wrote:
> Turns out that the bit 61 in the TEID is not always 1 and if that's
> the case the address space ID and the address are
> unpredictable. Without an address and its address space ID we can't
> export memory and hence we can only send a SIGSEGV to the process or
> panic the kernel depending on who caused the exception.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Fixes: 084ea4d611a3d ("s390/mm: add (non)secure page access exceptions handlers")
> Cc: stable@vger.kernel.org

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

we should let it run in our CI for some days, though.

> ---
>  arch/s390/mm/fault.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index e30c7c781172..3e8685ad938d 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -791,6 +791,20 @@ void do_secure_storage_access(struct pt_regs *regs)
>  	struct page *page;
>  	int rc;
>  
> +	/* There are cases where we don't have a TEID. */
> +	if (!(regs->int_parm_long & 0x4)) {
> +		/*
> +		 * When this happens, userspace did something that it
> +		 * was not supposed to do, e.g. branching into secure
> +		 * memory. Trigger a segmentation fault.
> +		 */
> +		if (user_mode(regs)) {
> +			send_sig(SIGSEGV, current, 0);
> +			return;
> +		} else
> +			panic("Unexpected PGM 0x3d with TEID bit 61=0");
> +	}
> +
>  	switch (get_fault_type(regs)) {
>  	case USER_FAULT:
>  		mm = current->mm;
> 
