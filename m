Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 2/2] s390: mm: Fix secure storage access exception
 handling
References: <20210119100402.84734-1-frankja@linux.ibm.com>
 <20210119100402.84734-3-frankja@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <3e1978c6-4462-1de6-e1aa-e664ffa633c1@de.ibm.com>
Date: Tue, 19 Jan 2021 11:25:01 +0100
MIME-Version: 1.0
In-Reply-To: <20210119100402.84734-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, thuth@redhat.com, david@redhat.com, imbrenda@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org, gor@linux.ibm.com, mihajlov@linux.ibm.com



On 19.01.21 11:04, Janosch Frank wrote:
> Turns out that the bit 61 in the TEID is not always 1 and if that's
> the case the address space ID and the address are
> unpredictable. Without an address and it's address space ID we can't
> export memory and hence we can only send a SIGSEGV to the process or
> panic the kernel depending on who caused the exception.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Fixes: 084ea4d611a3d ("s390/mm: add (non)secure page access exceptions handlers")
> Cc: stable@vger.kernel.org

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

some small things to consider (or to reject)

> ---
>  arch/s390/mm/fault.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index e30c7c781172..5442937e5b4b 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -791,6 +791,20 @@ void do_secure_storage_access(struct pt_regs *regs)
>  	struct page *page;
>  	int rc;
>  
> +	/* There are cases where we don't have a TEID. */
> +	if (!(regs->int_parm_long & 0x4)) {
> +		/*
> +		 * Userspace could for example try to execute secure
> +		 * storage and trigger this. We should tell it that it
> +		 * shouldn't do that.

Maybe something like
		/*
		 * when this happens, userspace did something that it
		 * was not supposed to do, e.g. branching into secure
		 * secure memory. Trigger a segmentation fault.
> +		 */
> +		if (user_mode(regs)) {
> +			send_sig(SIGSEGV, current, 0);
> +			return;
> +		} else
> +			panic("Unexpected PGM 0x3d with TEID bit 61=0");

use BUG instead of panic? That would kill this process, but it allows
people to maybe save unaffected data.
