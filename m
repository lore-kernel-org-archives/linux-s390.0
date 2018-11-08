From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 08 Nov 2018 09:48:44 +0000
Subject: Re: [kvm-unit-tests PATCH] s390x: Fixup svc handling
Message-Id: <20181108104844.138c6109.cohuck@redhat.com>
In-Reply-To: <1541669224-29953-1-git-send-email-frankja@linux.ibm.com>
References: <1541669224-29953-1-git-send-email-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu,  8 Nov 2018 10:27:04 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> Let's use the svc psw instead of the mccheck psw for svc interrupts
> and name it supervisor call.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/interrupt.c | 2 +-
>  s390x/cstart64.S      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
> index 6d0d4a3..4bcfdd6 100644
> --- a/lib/s390x/interrupt.c
> +++ b/lib/s390x/interrupt.c
> @@ -137,6 +137,6 @@ void handle_io_int(void)
>  
>  void handle_svc_int(void)
>  {
> -	report_abort("Unexpected service call interrupt: at %#lx",
> +	report_abort("Unexpected supervisor call interrupt: at %#lx",
>  		     lc->svc_old_psw.addr);
>  }
> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
> index d6d40b7..fdcd0e7 100644
> --- a/s390x/cstart64.S
> +++ b/s390x/cstart64.S
> @@ -36,7 +36,7 @@ init_psw_cont:
>  	larl	%r1, ext_int_psw

Hm... shouldn't that be io_int_psw here? (The other psws look fine.)

>  	mvc	GEN_LC_IO_NEW_PSW(16), 0(%r1)
>  	/* setup svc interrupt handler */
> -	larl	%r1, mcck_int_psw
> +	larl	%r1, svc_int_psw
>  	mvc	GEN_LC_SVC_NEW_PSW(16), 0(%r1)
>  	/* setup cr0, enabling e.g. AFP-register control */
>  	larl	%r1, initial_cr0

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
