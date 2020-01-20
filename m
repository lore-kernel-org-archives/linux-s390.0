Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29107 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727031AbgATMKQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 20 Jan 2020 07:10:16 -0500
Subject: Re: [kvm-unit-tests PATCH v3 8/9] s390x: smp: Test all CRs on initial
 reset
References: <20200117104640.1983-1-frankja@linux.ibm.com>
 <20200117104640.1983-9-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <15f8b733-1b81-4a1b-22fe-53099878c013@redhat.com>
Date: Mon, 20 Jan 2020 13:10:08 +0100
MIME-Version: 1.0
In-Reply-To: <20200117104640.1983-9-frankja@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, cohuck@redhat.com

On 17.01.20 11:46, Janosch Frank wrote:
> All CRs are set to 0 and CRs 0 and 14 are set to pre-defined values,
> so we also need to test 1-13 and 15 for 0.
> 
> And while we're at it, let's also set some values to cr 1, 7 and 13, so
> we can actually be sure that they will be zeroed.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/smp.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/s390x/smp.c b/s390x/smp.c
> index c12a3db..1385488 100644
> --- a/s390x/smp.c
> +++ b/s390x/smp.c
> @@ -169,16 +169,30 @@ static void test_emcall(void)
>  	report_prefix_pop();
>  }
>  
> +/* Used to dirty registers of cpu #1 before it is reset */
> +static void test_func_initial(void)
> +{
> +	lctlg(1, 0x42000UL);
> +	lctlg(7, 0x43000UL);
> +	lctlg(13, 0x44000UL);
> +	mb();
> +	testflag = 1;
> +}
> +
>  static void test_reset_initial(void)
>  {
>  	struct cpu_status *status = alloc_pages(0);
> +	uint64_t nullp[12] = {};
>  	struct psw psw;
>  
>  	psw.mask = extract_psw_mask();
> -	psw.addr = (unsigned long)test_func;
> +	psw.addr = (unsigned long)test_func_initial;
>  
>  	report_prefix_push("reset initial");
> +	testflag = 0;
> +	mb();

maybe use a  set_flag() function like

mb();
testflag = val;
mb();

and use it everywhere you set the flag? (e.g., in test_func_initial())

Apart from that

Reviewed-by: David Hildenbrand <david@redhat.com>

>  	smp_cpu_start(1, psw);
> +	wait_for_flag();
>  
>  	sigp_retry(1, SIGP_INITIAL_CPU_RESET, 0, NULL);
>  	sigp(1, SIGP_STORE_STATUS_AT_ADDRESS, (uintptr_t)status, NULL);
> @@ -189,6 +203,8 @@ static void test_reset_initial(void)
>  	report(!status->fpc, "fpc");
>  	report(!status->cputm, "cpu timer");
>  	report(!status->todpr, "todpr");
> +	report(!memcmp(&status->crs[1], nullp, sizeof(status->crs[1]) * 12), "cr1-13 == 0");
> +	report(status->crs[15] == 0, "cr15 == 0");
>  	report_prefix_pop();
>  
>  	report_prefix_push("initialized");
> 


-- 
Thanks,

David / dhildenb
