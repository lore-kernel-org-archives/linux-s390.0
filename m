Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30282 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726082AbgAPMSu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Jan 2020 07:18:50 -0500
Subject: Re: [kvm-unit-tests PATCH v2 2/7] s390x: smp: Only use smp_cpu_setup
 once
References: <20200116120513.2244-1-frankja@linux.ibm.com>
 <20200116120513.2244-3-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9847c5e8-2950-add1-e86b-0d14f0aca0bd@redhat.com>
Date: Thu, 16 Jan 2020 13:18:43 +0100
MIME-Version: 1.0
In-Reply-To: <20200116120513.2244-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, cohuck@redhat.com

On 16.01.20 13:05, Janosch Frank wrote:
> Let's stop and start instead of using setup to run a function on a
> cpu.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  s390x/smp.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/s390x/smp.c b/s390x/smp.c
> index 02204fd..d430638 100644
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
> @@ -132,9 +132,8 @@ static void test_ecall(void)
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
> @@ -167,9 +166,8 @@ static void test_emcall(void)
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
> @@ -187,7 +185,7 @@ static void test_reset_initial(void)
>  	psw.addr = (unsigned long)test_func;
>  
>  	report_prefix_push("reset initial");
> -	smp_cpu_setup(1, psw);
> +	smp_cpu_start(1, psw);
>  
>  	sigp_retry(1, SIGP_INITIAL_CPU_RESET, 0, NULL);
>  	sigp(1, SIGP_STORE_STATUS_AT_ADDRESS, (uintptr_t)status, NULL);
> @@ -218,7 +216,7 @@ static void test_reset(void)
>  	psw.addr = (unsigned long)test_func;
>  
>  	report_prefix_push("cpu reset");
> -	smp_cpu_setup(1, psw);
> +	smp_cpu_start(1, psw);
>  
>  	sigp_retry(1, SIGP_CPU_RESET, 0, NULL);
>  	report(smp_cpu_stopped(1), "cpu stopped");
> @@ -227,6 +225,7 @@ static void test_reset(void)
>  
>  int main(void)
>  {
> +	struct psw psw;
>  	report_prefix_push("smp");
>  
>  	if (smp_query_num_cpus() == 1) {
> @@ -234,6 +233,12 @@ int main(void)
>  		goto done;
>  	}
>  
> +	/* Setting up the cpu to give it a stack and lowcore */
> +	psw.mask = extract_psw_mask();
> +	psw.addr = (unsigned long)cpu_loop;
> +	smp_cpu_setup(1, psw);
> +	smp_cpu_stop(1);
> +
>  	test_start();
>  	test_stop();
>  	test_stop_store_status();
> @@ -242,6 +247,7 @@ int main(void)
>  	test_emcall();
>  	test_reset();
>  	test_reset_initial();
> +	smp_cpu_destroy(1);
>  
>  done:
>  	report_prefix_pop();
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
