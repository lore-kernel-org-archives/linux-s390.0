From: Thomas Huth <thuth@redhat.com>
Date: Fri, 09 Nov 2018 10:15:38 +0000
Subject: Re: [kvm-unit-tests PATCH] s390x: Fixup interrupt psws
Message-Id: <88d03f25-4945-9277-8baa-463da33f0afd@redhat.com>
In-Reply-To: <8a4a0029-b1f8-84a0-5d7a-fc82351660c1@redhat.com>
References: <8a4a0029-b1f8-84a0-5d7a-fc82351660c1@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 2018-11-08 11:00, Janosch Frank wrote:
> Let's use the svc psw instead of the mccheck psw for svc interrupts
> and name it supervisor call. Also we exchange the io int psw for the
> right one.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  lib/s390x/interrupt.c | 2 +-
>  s390x/cstart64.S      | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
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
> index d6d40b7..dc7ddd6 100644
> --- a/s390x/cstart64.S
> +++ b/s390x/cstart64.S
> @@ -33,10 +33,10 @@ init_psw_cont:
>  	larl	%r1, mcck_int_psw
>  	mvc	GEN_LC_MCCK_NEW_PSW(16), 0(%r1)
>  	/* setup io interrupt handler */
> -	larl	%r1, ext_int_psw
> +	larl	%r1, io_int_psw
>  	mvc	GEN_LC_IO_NEW_PSW(16), 0(%r1)
>  	/* setup svc interrupt handler */
> -	larl	%r1, mcck_int_psw
> +	larl	%r1, svc_int_psw
>  	mvc	GEN_LC_SVC_NEW_PSW(16), 0(%r1)
>  	/* setup cr0, enabling e.g. AFP-register control */
>  	larl	%r1, initial_cr0
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
