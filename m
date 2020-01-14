Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55456 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728809AbgANQqF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 14 Jan 2020 11:46:05 -0500
Subject: Re: [kvm-unit-tests PATCH 2/4] s390x: smp: Only use smp_cpu_setup
 once
References: <20200114153054.77082-1-frankja@linux.ibm.com>
 <20200114153054.77082-3-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9db91398-0371-cd4a-9758-a185b74467a0@redhat.com>
Date: Tue, 14 Jan 2020 17:45:52 +0100
MIME-Version: 1.0
In-Reply-To: <20200114153054.77082-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com

On 14/01/2020 16.30, Janosch Frank wrote:
> Let's stop and start instead of using setup to run a function on a
> cpu.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/smp.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/s390x/smp.c b/s390x/smp.c
> index 4dee43e..767d167 100644
> --- a/s390x/smp.c
> +++ b/s390x/smp.c
> @@ -47,7 +47,7 @@ static void test_start(void)
>  	psw.mask = extract_psw_mask();
>  	psw.addr = (unsigned long)test_func;
>  
> -	smp_cpu_setup(1, psw);
> +	smp_cpu_start(1, psw);
>  	wait_for_flag();
>  	report(1, "start");
>  }
> @@ -131,9 +131,8 @@ static void test_ecall(void)
>  
>  	report_prefix_push("ecall");
>  	testflag = 0;
> -	smp_cpu_destroy(1);
>  
> -	smp_cpu_setup(1, psw);
> +	smp_cpu_start(1, psw);
>  	wait_for_flag();
>  	testflag = 0;
>  	sigp(1, SIGP_EXTERNAL_CALL, 0, NULL);
> @@ -166,9 +165,8 @@ static void test_emcall(void)
>  
>  	report_prefix_push("emcall");
>  	testflag = 0;
> -	smp_cpu_destroy(1);
>  
> -	smp_cpu_setup(1, psw);
> +	smp_cpu_start(1, psw);
>  	wait_for_flag();
>  	testflag = 0;
>  	sigp(1, SIGP_EMERGENCY_SIGNAL, 0, NULL);
> @@ -186,7 +184,7 @@ static void test_reset_initial(void)
>  	psw.addr = (unsigned long)test_func;
>  
>  	report_prefix_push("reset initial");
> -	smp_cpu_setup(1, psw);
> +	smp_cpu_start(1, psw);
>  
>  	sigp_retry(1, SIGP_INITIAL_CPU_RESET, 0, NULL);
>  	sigp(1, SIGP_STORE_STATUS_AT_ADDRESS, (uintptr_t)status, NULL);
> @@ -217,7 +215,7 @@ static void test_reset(void)
>  	psw.addr = (unsigned long)test_func;
>  
>  	report_prefix_push("cpu reset");
> -	smp_cpu_setup(1, psw);
> +	smp_cpu_start(1, psw);

I think this also fixes a memory leak in case the code did not call
smp_cpu_destroy() inbetween (since smp_cpu_setup() allocates new memory
for the low-core). So as far as I can see, this is a good idea:

Reviewed-by: Thomas Huth <thuth@redhat.com>
