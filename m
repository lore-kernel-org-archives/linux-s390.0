Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 19 Jan 2021 14:09:50 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH 2/2] s390: mm: Fix secure storage access exception
 handling
Message-ID: <20210119140950.2e41f1bf@ibm-vm>
In-Reply-To: <20210119100402.84734-3-frankja@linux.ibm.com>
References: <20210119100402.84734-1-frankja@linux.ibm.com>
        <20210119100402.84734-3-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org, gor@linux.ibm.com, mihajlov@linux.ibm.com

On Tue, 19 Jan 2021 05:04:02 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Turns out that the bit 61 in the TEID is not always 1 and if that's
> the case the address space ID and the address are
> unpredictable. Without an address and it's address space ID we can't

*its

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> export memory and hence we can only send a SIGSEGV to the process or
> panic the kernel depending on who caused the exception.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Fixes: 084ea4d611a3d ("s390/mm: add (non)secure page access
> exceptions handlers") Cc: stable@vger.kernel.org
> ---
>  arch/s390/mm/fault.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index e30c7c781172..5442937e5b4b 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -791,6 +791,20 @@ void do_secure_storage_access(struct pt_regs
> *regs) struct page *page;
>  	int rc;
>  
> +	/* There are cases where we don't have a TEID. */
> +	if (!(regs->int_parm_long & 0x4)) {
> +		/*
> +		 * Userspace could for example try to execute secure
> +		 * storage and trigger this. We should tell it that
> it
> +		 * shouldn't do that.
> +		 */
> +		if (user_mode(regs)) {
> +			send_sig(SIGSEGV, current, 0);
> +			return;
> +		} else
> +			panic("Unexpected PGM 0x3d with TEID bit
> 61=0");
> +	}
> +
>  	switch (get_fault_type(regs)) {
>  	case USER_FAULT:
>  		mm = current->mm;
