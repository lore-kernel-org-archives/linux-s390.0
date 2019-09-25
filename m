Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53170 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbfIYItd (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 25 Sep 2019 04:49:33 -0400
Subject: Re: [kvm-unit-tests PATCH v3 6/6] s390x: SMP test
References: <20190920080356.1948-1-frankja@linux.ibm.com>
 <20190920080356.1948-7-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ddb43c9c-e6d9-fbc0-b7a5-ec440756b0ec@redhat.com>
Date: Wed, 25 Sep 2019 10:49:26 +0200
MIME-Version: 1.0
In-Reply-To: <20190920080356.1948-7-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

On 20/09/2019 10.03, Janosch Frank wrote:
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
>  s390x/Makefile      |   1 +
>  s390x/smp.c         | 242 ++++++++++++++++++++++++++++++++++++++++++++
[...]
> +int main(void)
> +{
> +	report_prefix_push("smp");
> +
> +	if (smp_query_num_cpus() == 1) {
> +		report_abort("need at least 2 cpus for this test");

nit: report_abort() aborts immediately, so the "goto done" below is dead
code. Did you mean report_skip() instead?

> +		goto done;
> +	}
> +
> +	test_start();
> +	test_stop();
> +	test_stop_store_status();
> +	test_store_status();
> +	test_ecall();
> +	test_emcall();
> +	test_reset();
> +	test_reset_initial();
> +
> +done:
> +	report_prefix_pop();
> +	return report_summary();
> +}

Apart from the nit, the patch looks fine to me. Since this is IIRC the
only nit that is left in this series, I can also fix it up when picking
up the patch, if you like - just tell me whether you prefer report_skip
or deletion of the goto.

 Thomas
