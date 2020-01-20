Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41690 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726573AbgATMGV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 20 Jan 2020 07:06:21 -0500
Subject: Re: [kvm-unit-tests PATCH v3 4/9] s390x: smp: Rework cpu start and
 active tracking
References: <20200117104640.1983-1-frankja@linux.ibm.com>
 <20200117104640.1983-5-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0f9984f0-9768-dba8-5e36-8e667bc05c88@redhat.com>
Date: Mon, 20 Jan 2020 13:06:13 +0100
MIME-Version: 1.0
In-Reply-To: <20200117104640.1983-5-frankja@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, cohuck@redhat.com

On 17.01.20 11:46, Janosch Frank wrote:
> The architecture specifies that processing sigp orders may be
> asynchronous, and this is indeed the case on some hypervisors, so we
> need to wait until the cpu runs before we return from the setup/start
> function.
> 
> As there was a lot of duplicate code, a common function for cpu
> restarts has been introduced.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  lib/s390x/smp.c | 50 ++++++++++++++++++++++++++++---------------------
>  1 file changed, 29 insertions(+), 21 deletions(-)
> 
> diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
> index f57f420..84e681d 100644
> --- a/lib/s390x/smp.c
> +++ b/lib/s390x/smp.c
> @@ -104,35 +104,46 @@ int smp_cpu_stop_store_status(uint16_t addr)
>  	return rc;
>  }
>  
> +static int smp_cpu_restart_nolock(uint16_t addr, struct psw *psw)
> +{
> +	int rc;
> +	struct cpu *cpu = smp_cpu_from_addr(addr);

I'd exchange these two (reverse christmas tree)

> +
> +	if (!cpu)
> +		return -1;

-EINVAL?

> +	if (psw) {
> +		cpu->lowcore->restart_new_psw.mask = psw->mask;
> +		cpu->lowcore->restart_new_psw.addr = psw->addr;
> +	}

Does this make sense to have optional? (the other CPU will execute
random crap if not set, won't it?)

> +	rc = sigp(addr, SIGP_RESTART, 0, NULL);
> +	if (rc)
> +		return rc;
> +	/*
> +	 * The order has been accepted, but the actual restart may not
> +	 * have been performed yet, so wait until the cpu is running.
> +	 */
> +	while (!smp_cpu_running(addr))
> +		mb();

Should you make sure to stop the CPU before issuing the restart?
Otherwise you will get false positives if it is still running (but
hasn't processed the RESTART yet)



-- 
Thanks,

David / dhildenb
