Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43396 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726516AbgD2PPZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 29 Apr 2020 11:15:25 -0400
Subject: Re: [PATCH v3 08/10] s390x: smp: Wait for sigp completion
References: <20200429143518.1360468-1-frankja@linux.ibm.com>
 <20200429143518.1360468-9-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <6fb43d45-952e-f66b-a0b2-19d8c3f44cd5@redhat.com>
Date: Wed, 29 Apr 2020 17:15:16 +0200
MIME-Version: 1.0
In-Reply-To: <20200429143518.1360468-9-frankja@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com

On 29.04.20 16:35, Janosch Frank wrote:
> Sigp orders are not necessarily finished when the processor finished
> the sigp instruction. We need to poll if the order has been finished
> before we continue.
> 
> For (re)start and stop we already use sigp sense running and sigp
> sense loops. But we still lack completion checks for stop and store
> status, as well as the cpu resets.
> 
> Let's add them.
> 
> KVM currently needs a workaround for the stop and store status test,
> since KVM's SIGP Sense implementation doesn't honor pending SIGPs at
> it should. Hopefully we can fix that in the future.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  lib/s390x/smp.c |  9 +++++++++
>  lib/s390x/smp.h |  1 +
>  s390x/smp.c     | 12 ++++++++++--
>  3 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
> index 6ef0335..8628a3d 100644
> --- a/lib/s390x/smp.c
> +++ b/lib/s390x/smp.c
> @@ -49,6 +49,14 @@ struct cpu *smp_cpu_from_addr(uint16_t addr)
>  	return NULL;
>  }
>  
> +void smp_cpu_wait_for_completion(uint16_t addr)
> +{
> +	uint32_t status;
> +
> +	/* Loops when cc == 2, i.e. when the cpu is busy with a sigp order */
> +	sigp_retry(1, SIGP_SENSE, 0, &status);
> +}
> +
>  bool smp_cpu_stopped(uint16_t addr)
>  {
>  	uint32_t status;
> @@ -100,6 +108,7 @@ int smp_cpu_stop_store_status(uint16_t addr)
>  
>  	spin_lock(&lock);
>  	rc = smp_cpu_stop_nolock(addr, true);
> +	smp_cpu_wait_for_completion(addr);
>  	spin_unlock(&lock);
>  	return rc;
>  }
> diff --git a/lib/s390x/smp.h b/lib/s390x/smp.h
> index ce63a89..a8b98c0 100644
> --- a/lib/s390x/smp.h
> +++ b/lib/s390x/smp.h
> @@ -45,6 +45,7 @@ int smp_cpu_restart(uint16_t addr);
>  int smp_cpu_start(uint16_t addr, struct psw psw);
>  int smp_cpu_stop(uint16_t addr);
>  int smp_cpu_stop_store_status(uint16_t addr);
> +void smp_cpu_wait_for_completion(uint16_t addr);
>  int smp_cpu_destroy(uint16_t addr);
>  int smp_cpu_setup(uint16_t addr, struct psw psw);
>  void smp_teardown(void);
> diff --git a/s390x/smp.c b/s390x/smp.c
> index c7ff0ee..bad2131 100644
> --- a/s390x/smp.c
> +++ b/s390x/smp.c
> @@ -75,7 +75,12 @@ static void test_stop_store_status(void)
>  	lc->prefix_sa = 0;
>  	lc->grs_sa[15] = 0;
>  	smp_cpu_stop_store_status(1);
> -	mb();
> +	/*
> +	 * This loop is workaround for KVM not reporting cc 2 for SIGP
> +	 * sense if a stop and store status is pending.
> +	 */
> +	while (!lc->prefix_sa)
> +		mb();
>  	report(lc->prefix_sa == (uint32_t)(uintptr_t)cpu->lowcore, "prefix");
>  	report(lc->grs_sa[15], "stack");
>  	report(smp_cpu_stopped(1), "cpu stopped");
> @@ -85,7 +90,8 @@ static void test_stop_store_status(void)
>  	lc->prefix_sa = 0;
>  	lc->grs_sa[15] = 0;
>  	smp_cpu_stop_store_status(1);
> -	mb();
> +	while (!lc->prefix_sa)
> +		mb();
>  	report(lc->prefix_sa == (uint32_t)(uintptr_t)cpu->lowcore, "prefix");
>  	report(lc->grs_sa[15], "stack");
>  	report_prefix_pop();
> @@ -215,6 +221,7 @@ static void test_reset_initial(void)
>  	wait_for_flag();
>  
>  	sigp_retry(1, SIGP_INITIAL_CPU_RESET, 0, NULL);
> +	smp_cpu_wait_for_completion(1);

^ is this really helpful? The next order already properly synchronizes, no?

>  	sigp(1, SIGP_STORE_STATUS_AT_ADDRESS, (uintptr_t)status, NULL);
>  
>  	report_prefix_push("clear");
> @@ -265,6 +272,7 @@ static void test_reset(void)
>  	smp_cpu_start(1, psw);
>  
>  	sigp_retry(1, SIGP_CPU_RESET, 0, NULL);
> +	smp_cpu_wait_for_completion(1);

Isn't this racy for KVM as well?

I would have expected a loop until it is actually stopped.

>  	report(smp_cpu_stopped(1), "cpu stopped");
>  
>  	set_flag(0);
> 


-- 
Thanks,

David / dhildenb
