Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38524 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391232AbfIJJnq (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Sep 2019 05:43:46 -0400
Subject: Re: [kvm-unit-tests PATCH v2 6/6] s390x: SMP test
References: <20190905103951.36522-1-frankja@linux.ibm.com>
 <20190905103951.36522-7-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <28304989-f49d-850d-4ec0-98ed0d516969@redhat.com>
Date: Tue, 10 Sep 2019 11:43:40 +0200
MIME-Version: 1.0
In-Reply-To: <20190905103951.36522-7-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

On 05/09/2019 12.39, Janosch Frank wrote:
> Testing SIGP emulation for the following order codes:
> * start
> * stop
> * restart
> * set prefix
> * store status
> * stop and store status
> * reset
> * initial reset
> * external call
> * emegergency call
> 
> restart and set prefix are part of the library and needed to start
> other cpus.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
[...]
> +static void test_store_status(void)
> +{
> +	struct cpu_status *status = alloc_pages(1);
> +	uint32_t r;
> +
> +	report_prefix_push("store status at address");
> +	memset(status, 0, PAGE_SIZE * 2);
> +
> +	report_prefix_push("running");
> +	smp_cpu_restart(1);
> +	sigp(1, SIGP_STORE_STATUS_AT_ADDRESS, (uintptr_t)status, &r);
> +	report("incorrect state", r == SIGP_STATUS_INCORRECT_STATE);
> +	report("status not written", !memcmp(status, (void*)status + PAGE_SIZE, PAGE_SIZE));
> +	report_prefix_pop();
> +
> +	memset(status, 0, PAGE_SIZE);
> +	report_prefix_push("stopped");
> +	smp_cpu_stop(1);
> +	sigp(1, SIGP_STORE_STATUS_AT_ADDRESS, (uintptr_t)status, NULL);
> +	while (!status->prefix) { mb(); }
> +	report("status written", 1);
> +	free_pages(status, PAGE_SIZE);

Shouldn't that be PAGE_SIZE * 2 instead?

> +	report_prefix_pop();
> +
> +	report_prefix_pop();
> +}

The remaining part of the patch looks fine to me.

 Thomas
