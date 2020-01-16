Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27171 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726370AbgAPOPF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Jan 2020 09:15:05 -0500
Date: Thu, 16 Jan 2020 15:14:53 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v2 4/7] s390x: smp: Rework cpu start and
 active tracking
Message-ID: <20200116151453.186cbf94.cohuck@redhat.com>
In-Reply-To: <20200116120513.2244-5-frankja@linux.ibm.com>
References: <20200116120513.2244-1-frankja@linux.ibm.com>
        <20200116120513.2244-5-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com

On Thu, 16 Jan 2020 07:05:10 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> sigp is not synchronous on all hypervisors, so we need to wait until

"The architecture specifies that processing sigp orders may be
asynchronous, and this is indeed the case on some hypervisors, so..."

? (Or is that overkill?)

> the cpu runs until we return from the setup/start function.

s/until we return/before we return/

> 
> As there was a lot of duplicate code a common function for cpu

s/code/code,/

> restarts has been intropduced.

s/intropduced/introduced/

> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/smp.c | 45 ++++++++++++++++++++++++---------------------
>  1 file changed, 24 insertions(+), 21 deletions(-)
> 
> diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
> index f57f420..f984a34 100644
> --- a/lib/s390x/smp.c
> +++ b/lib/s390x/smp.c
> @@ -104,35 +104,41 @@ int smp_cpu_stop_store_status(uint16_t addr)
>  	return rc;
>  }
>  
> +static int smp_cpu_restart_nolock(uint16_t addr, struct psw *psw)
> +{
> +	int rc;
> +	struct cpu *cpu = smp_cpu_from_addr(addr);
> +
> +	if (!cpu)
> +		return -1;
> +	if (psw) {
> +		cpu->lowcore->restart_new_psw.mask = psw->mask;
> +		cpu->lowcore->restart_new_psw.addr = psw->addr;
> +	}
> +	rc = sigp(addr, SIGP_RESTART, 0, NULL);
> +	if (rc)
> +		return rc;
> +	while (!smp_cpu_running(addr)) { mb(); }

Maybe split this statement? Also, maybe add a comment

/*
 * The order has been accepted, but the actual restart may not
 * have been performed yet, so wait until the cpu is running.
 */

?

> +	cpu->active = true;
> +	return 0;
> +}

The changes look good to me AFAICS.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
