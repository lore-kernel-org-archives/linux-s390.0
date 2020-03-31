Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44568 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730673AbgCaJK1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 31 Mar 2020 05:10:27 -0400
Subject: Re: [kvm-unit-tests PATCH 08/10] s390x: smp: Wait for sigp completion
References: <20200324081251.28810-1-frankja@linux.ibm.com>
 <20200324081251.28810-9-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <91f0c373-f316-2898-4928-fea2e7283df7@redhat.com>
Date: Tue, 31 Mar 2020 11:10:21 +0200
MIME-Version: 1.0
In-Reply-To: <20200324081251.28810-9-frankja@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org

On 24.03.20 09:12, Janosch Frank wrote:
> Sigp orders are not necessarily finished when the processor finished
> the sigp instruction. We need to poll if the order has been finished
> before we continue.
> 
> For (re)start and stop we already use sigp sense running and sigp

Nope, hopefully no longer "sense running".

> sense loops. But we still lack completion checks for stop and store
> status, as well as the cpu resets.
> 
> Let's add them.
> 


[...]

> @@ -75,6 +75,7 @@ static void test_stop_store_status(void)
>  	lc->prefix_sa = 0;
>  	lc->grs_sa[15] = 0;
>  	smp_cpu_stop_store_status(1);
> +	smp_cpu_wait_for_completion(1);
>  	mb();
>  	report(lc->prefix_sa == (uint32_t)(uintptr_t)cpu->lowcore, "prefix");
>  	report(lc->grs_sa[15], "stack");
> @@ -85,6 +86,7 @@ static void test_stop_store_status(void)
>  	lc->prefix_sa = 0;
>  	lc->grs_sa[15] = 0;
>  	smp_cpu_stop_store_status(1);
> +	smp_cpu_wait_for_completion(1);
>  	mb();
>  	report(lc->prefix_sa == (uint32_t)(uintptr_t)cpu->lowcore, "prefix");
>  	report(lc->grs_sa[15], "stack");
> @@ -215,6 +217,7 @@ static void test_reset_initial(void)
>  	wait_for_flag();
>  
>  	sigp_retry(1, SIGP_INITIAL_CPU_RESET, 0, NULL);
> +	smp_cpu_wait_for_completion(1);
>  	sigp(1, SIGP_STORE_STATUS_AT_ADDRESS, (uintptr_t)status, NULL);
>  
>  	report_prefix_push("clear");
> @@ -264,6 +267,7 @@ static void test_reset(void)
>  	smp_cpu_start(1, psw);
>  
>  	sigp_retry(1, SIGP_CPU_RESET, 0, NULL);
> +	smp_cpu_wait_for_completion(1);
>  	report(smp_cpu_stopped(1), "cpu stopped");
>  
>  	set_flag(0);
> 

Looks sane to me.

-- 
Thanks,

David / dhildenb
