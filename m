Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58963 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729257AbgDWQEN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 23 Apr 2020 12:04:13 -0400
Subject: Re: [PATCH v2 03/10] s390x: smp: Test stop and store status on a
 running and stopped cpu
References: <20200423091013.11587-1-frankja@linux.ibm.com>
 <20200423091013.11587-4-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9c6c11a1-3ef2-a4b4-6005-6cad06d70ce7@redhat.com>
Date: Thu, 23 Apr 2020 18:03:54 +0200
MIME-Version: 1.0
In-Reply-To: <20200423091013.11587-4-frankja@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com

On 23.04.20 11:10, Janosch Frank wrote:
> Let's also test the stop portion of the "stop and store status" sigp
> order.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Reviewed-by: David Hildenbrand <david@redhat.com>

> ---
>  s390x/smp.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/s390x/smp.c b/s390x/smp.c
> index 95df8c4..8a6cd1d 100644
> --- a/s390x/smp.c
> +++ b/s390x/smp.c
> @@ -76,12 +76,26 @@ static void test_stop_store_status(void)
>  	struct lowcore *lc = (void *)0x0;
>  
>  	report_prefix_push("stop store status");
> +	report_prefix_push("running");
> +	smp_cpu_restart(1);
>  	lc->prefix_sa = 0;
>  	lc->grs_sa[15] = 0;
>  	smp_cpu_stop_store_status(1);
>  	mb();
>  	report(lc->prefix_sa == (uint32_t)(uintptr_t)cpu->lowcore, "prefix");
>  	report(lc->grs_sa[15], "stack");
> +	report(smp_cpu_stopped(1), "cpu stopped");
> +	report_prefix_pop();
> +
> +	report_prefix_push("stopped");
> +	lc->prefix_sa = 0;
> +	lc->grs_sa[15] = 0;
> +	smp_cpu_stop_store_status(1);
> +	mb();
> +	report(lc->prefix_sa == (uint32_t)(uintptr_t)cpu->lowcore, "prefix");
> +	report(lc->grs_sa[15], "stack");
> +	report_prefix_pop();
> +
>  	report_prefix_pop();
>  }
>  
> 


-- 
Thanks,

David / dhildenb
