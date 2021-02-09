Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39670 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231614AbhBIOWo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Feb 2021 09:22:44 -0500
Subject: Re: [kvm-unit-tests PATCH] s390x: Workaround smp stop and store
 status race
References: <20210209141554.22554-1-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <10fd2ab0-3a36-7739-8644-e6e6ad3607f5@redhat.com>
Date: Tue, 9 Feb 2021 15:21:06 +0100
MIME-Version: 1.0
In-Reply-To: <20210209141554.22554-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, imbrenda@linux.ibm.com

On 09/02/2021 15.15, Janosch Frank wrote:
> KVM and QEMU handle a SIGP stop and store status in two steps:
> 1) Stop the CPU by injecting a stop request
> 2) Store when the CPU has left SIE because of the stop request
> 
> The problem is that the SIGP order is already considered completed by
> KVM/QEMU when step 1 has been performed and not once both have
> completed. In addition we currently don't implement the busy CC so a
> kernel has no way of knowing that the store has finished other than
> checking the location for the store.
> 
> This workaround is based on the fact that for a new SIE entry (via the
> added smp restart) a stop with the store status has to be finished
> first.
> 
> Correct handling of this in KVM/QEMU will need some thought and time.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   s390x/smp.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/s390x/smp.c b/s390x/smp.c
> index b0ece491..32f284a2 100644
> --- a/s390x/smp.c
> +++ b/s390x/smp.c
> @@ -102,12 +102,15 @@ static void test_stop_store_status(void)
>   	lc->grs_sa[15] = 0;
>   	smp_cpu_stop_store_status(1);
>   	mb();
> +	report(smp_cpu_stopped(1), "cpu stopped");
> +	/* For the cpu to be started it should have finished storing */
> +	smp_cpu_restart(1);
>   	report(lc->prefix_sa == (uint32_t)(uintptr_t)cpu->lowcore, "prefix");
>   	report(lc->grs_sa[15], "stack");
> -	report(smp_cpu_stopped(1), "cpu stopped");
>   	report_prefix_pop();
>   
>   	report_prefix_push("stopped");
> +	smp_cpu_stop(1);
>   	lc->prefix_sa = 0;
>   	lc->grs_sa[15] = 0;
>   	smp_cpu_stop_store_status(1);

Thanks, this fixes the flaky test for me!

Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
