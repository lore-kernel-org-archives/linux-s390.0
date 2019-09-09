Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:4510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728248AbfIIPhW (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 9 Sep 2019 11:37:22 -0400
Subject: Re: [kvm-unit-tests PATCH v2 4/6] s390x: Add initial smp code
References: <20190905103951.36522-1-frankja@linux.ibm.com>
 <20190905103951.36522-5-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <51f23b0f-a928-1cd3-787d-31aed3ab7005@redhat.com>
Date: Mon, 9 Sep 2019 17:37:20 +0200
MIME-Version: 1.0
In-Reply-To: <20190905103951.36522-5-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

On 05/09/2019 12.39, Janosch Frank wrote:
> Let's add a rudimentary SMP library, which will scan for cpus and has
> helper functions that manage the cpu state.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
[...]
> +/*Expected to be called from boot cpu */
> +extern uint64_t *stackptr;
> +void smp_setup(void)
> +{
> +	int i = 0;
> +	unsigned short cpu0_addr = stap();
> +	struct ReadCpuInfo *info = (void *)cpu_info_buffer;
> +
> +	spin_lock(&lock);
> +	sclp_mark_busy();
> +	info->h.length = PAGE_SIZE;
> +	sclp_service_call(SCLP_READ_CPU_INFO, cpu_info_buffer);
> +
> +	if (smp_query_num_cpus() > 1)
> +		printf("SMP: Initializing, found %d cpus\n", info->nr_configured);
> +
> +	cpus = calloc(info->nr_configured, sizeof(cpus));
> +	for (i = 0; i < info->nr_configured; i++) {
> +		if (info->entries[i].address == cpu0_addr) {
> +			cpu0 = &cpus[i];
> +			cpu0->stack = stackptr;
> +			cpu0->lowcore = (void *)0;
> +			cpu0->active = true;

So here cpus[i].active gets set to true ...

> +		}
> +		cpus[i].addr = info->entries[i].address;
> +		cpus[i].active = false;

... but here it is set back to false.

Maybe move the if-statement below this line?

> +	}
> +	spin_unlock(&lock);
> +}
[...]
> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
> index 36f7cab..a45ea8f 100644
> --- a/s390x/cstart64.S
> +++ b/s390x/cstart64.S
> @@ -172,6 +172,13 @@ diag308_load_reset:
>  	lhi	%r2, 1
>  	br	%r14
>  
> +.globl smp_cpu_setup_state
> +smp_cpu_setup_state:
> +	xgr	%r1, %r1
> +	lmg     %r0, %r15, 512(%r1)

Can you use GEN_LC_SW_INT_GRS instead of 512?

> +	lctlg   %c0, %c0, 776(%r1)

... and here GEN_LC_SW_INT_CR0 instead of 776?

Apart from that, the patch looks fine to me.

 Thomas
