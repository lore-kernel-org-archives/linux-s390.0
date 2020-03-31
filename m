Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26878 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726216AbgCaGt2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 31 Mar 2020 02:49:28 -0400
Date: Tue, 31 Mar 2020 08:49:17 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests 1/2] s390x/smp: fix detection of "running"
Message-ID: <20200331084917.4ab3f405.cohuck@redhat.com>
In-Reply-To: <20200330084911.34248-2-borntraeger@de.ibm.com>
References: <20200330084911.34248-1-borntraeger@de.ibm.com>
        <20200330084911.34248-2-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>

On Mon, 30 Mar 2020 04:49:10 -0400
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On s390x hosts with a single CPU, the smp test case hangs (loops).
> The check is our restart has finished is wrong.

s/is/if/

> Sigp sense running status checks if the CPU is currently backed by a
> real CPU. This means that on single CPU hosts a sigp sense running
> will never claim that a target is running. We need to check for not
> being stopped instead.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  lib/s390x/smp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
> index 2555bf4..5ed8b7b 100644
> --- a/lib/s390x/smp.c
> +++ b/lib/s390x/smp.c
> @@ -128,7 +128,7 @@ static int smp_cpu_restart_nolock(uint16_t addr, struct psw *psw)
>  	 * The order has been accepted, but the actual restart may not
>  	 * have been performed yet, so wait until the cpu is running.
>  	 */
> -	while (!smp_cpu_running(addr))
> +	while (smp_cpu_stopped(addr))
>  		mb();
>  	cpu->active = true;
>  	return 0;

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
