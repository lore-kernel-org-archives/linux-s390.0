Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48972 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729054AbgDWPkC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 23 Apr 2020 11:40:02 -0400
Subject: Re: [PATCH v2 01/10] s390x: smp: Test all CRs on initial reset
References: <20200423091013.11587-1-frankja@linux.ibm.com>
 <20200423091013.11587-2-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2ebdf5d6-74ac-d9e5-d329-29611a5f87cd@redhat.com>
Date: Thu, 23 Apr 2020 17:39:53 +0200
MIME-Version: 1.0
In-Reply-To: <20200423091013.11587-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com

On 23.04.20 11:10, Janosch Frank wrote:
> All CRs are set to 0 and CRs 0 and 14 are set to pre-defined values,
> so we also need to test 1-13 and 15 for 0.
> 
> And while we're at it, let's also set some values to cr 1, 7 and 13, so
> we can actually be sure that they will be zeroed.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  s390x/smp.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/s390x/smp.c b/s390x/smp.c
> index fa40753..8c9b98a 100644
> --- a/s390x/smp.c
> +++ b/s390x/smp.c
> @@ -182,16 +182,28 @@ static void test_emcall(void)
>  	report_prefix_pop();
>  }
>  
> +/* Used to dirty registers of cpu #1 before it is reset */
> +static void test_func_initial(void)
> +{
> +	lctlg(1, 0x42000UL);
> +	lctlg(7, 0x43000UL);
> +	lctlg(13, 0x44000UL);
> +	set_flag(1);
> +}
> +
>  static void test_reset_initial(void)
>  {
>  	struct cpu_status *status = alloc_pages(0);
> +	uint64_t nullp[12] = {};

static const uint64_t nullp[12]; ? but see below

>  	struct psw psw;
>  
>  	psw.mask = extract_psw_mask();
> -	psw.addr = (unsigned long)test_func;
> +	psw.addr = (unsigned long)test_func_initial;
>  
>  	report_prefix_push("reset initial");
> +	set_flag(0);
>  	smp_cpu_start(1, psw);
> +	wait_for_flag();
>  
>  	sigp_retry(1, SIGP_INITIAL_CPU_RESET, 0, NULL);
>  	sigp(1, SIGP_STORE_STATUS_AT_ADDRESS, (uintptr_t)status, NULL);
> @@ -202,6 +214,8 @@ static void test_reset_initial(void)
>  	report(!status->fpc, "fpc");
>  	report(!status->cputm, "cpu timer");
>  	report(!status->todpr, "todpr");
> +	report(!memcmp(&status->crs[1], nullp, sizeof(status->crs[1]) * 12), "cr1-13 == 0");

sizeof(nullp) ?

> +	report(status->crs[15] == 0, "cr15 == 0");

I'd actually prefer a simple loop


for (i = 1; i <= 13; i++) {
	report(status->crs[i] == 0, "cr%d == 0", i);
}
report(status->crs[15] == 0, "cr15 == 0");

>  	report_prefix_pop();
>  
>  	report_prefix_push("initialized");
> 

Apart from that looks good to me.


-- 
Thanks,

David / dhildenb
