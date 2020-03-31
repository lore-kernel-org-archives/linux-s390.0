Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43920 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731290AbgCaJIA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 31 Mar 2020 05:08:00 -0400
Subject: Re: [kvm-unit-tests PATCH 04/10] s390x: smp: Test local interrupts
 after cpu reset
References: <20200324081251.28810-1-frankja@linux.ibm.com>
 <20200324081251.28810-5-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b6f1d06b-aaa5-bdd5-5491-32c8338f9ead@redhat.com>
Date: Tue, 31 Mar 2020 11:07:50 +0200
MIME-Version: 1.0
In-Reply-To: <20200324081251.28810-5-frankja@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org

On 24.03.20 09:12, Janosch Frank wrote:
> Local interrupts (external and emergency call) should be cleared after
> any cpu reset.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/smp.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/s390x/smp.c b/s390x/smp.c
> index 8a6cd1d8b17d76c6..a8e3dd7aac0c788c 100644
> --- a/s390x/smp.c
> +++ b/s390x/smp.c
> @@ -243,6 +243,20 @@ static void test_reset_initial(void)
>  	report_prefix_pop();
>  }
>  
> +static void test_local_ints(void)
> +{
> +	unsigned long mask;
> +
> +	expect_ext_int();
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
> @@ -251,10 +265,18 @@ static void test_reset(void)
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


How can you be sure they were actually cleared/delivered?


-- 
Thanks,

David / dhildenb
