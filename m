Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40644 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726355AbgD2PMn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 29 Apr 2020 11:12:43 -0400
Subject: Re: [PATCH v3 04/10] s390x: smp: Test local interrupts after cpu
 reset
References: <20200429143518.1360468-1-frankja@linux.ibm.com>
 <20200429143518.1360468-5-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <37d449d6-6d95-2163-8b11-5b582415a5bd@redhat.com>
Date: Wed, 29 Apr 2020 17:12:36 +0200
MIME-Version: 1.0
In-Reply-To: <20200429143518.1360468-5-frankja@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com

On 29.04.20 16:35, Janosch Frank wrote:
> Local interrupts (external and emergency call) should be cleared after
> any cpu reset.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  s390x/smp.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/s390x/smp.c b/s390x/smp.c
> index 4c50183..5e2e517 100644
> --- a/s390x/smp.c
> +++ b/s390x/smp.c
> @@ -245,6 +245,19 @@ static void test_reset_initial(void)
>  	report_prefix_pop();
>  }
>  
> +static void test_local_ints(void)
> +{
> +	unsigned long mask;
> +
> +	/* Open masks for ecall and emcall */
> +	ctl_set_bit(0, 13);
> +	ctl_set_bit(0, 14);
> +	mask = extract_psw_mask();
> +	mask |= PSW_MASK_EXT;
> +	load_psw_mask(mask);
> +	set_flag(1);
> +}
> +
>  static void test_reset(void)
>  {
>  	struct psw psw;
> @@ -253,10 +266,18 @@ static void test_reset(void)
>  	psw.addr = (unsigned long)test_func;
>  
>  	report_prefix_push("cpu reset");
> +	sigp(1, SIGP_EMERGENCY_SIGNAL, 0, NULL);
> +	sigp(1, SIGP_EXTERNAL_CALL, 0, NULL);
>  	smp_cpu_start(1, psw);
>  
>  	sigp_retry(1, SIGP_CPU_RESET, 0, NULL);
>  	report(smp_cpu_stopped(1), "cpu stopped");
> +
> +	set_flag(0);
> +	psw.addr = (unsigned long)test_local_ints;
> +	smp_cpu_start(1, psw);
> +	wait_for_flag();
> +	report(true, "local interrupts cleared");
>  	report_prefix_pop();
>  }
>  
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
