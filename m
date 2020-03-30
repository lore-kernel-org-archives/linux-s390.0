Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:26184 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729649AbgC3JD0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Mar 2020 05:03:26 -0400
Subject: Re: [kvm-unit-tests 1/2] s390x/smp: fix detection of "running"
References: <20200330084911.34248-1-borntraeger@de.ibm.com>
 <20200330084911.34248-2-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <43aba287-844c-fbe3-50b9-3131c3a6b297@redhat.com>
Date: Mon, 30 Mar 2020 11:03:20 +0200
MIME-Version: 1.0
In-Reply-To: <20200330084911.34248-2-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>

On 30.03.20 10:49, Christian Borntraeger wrote:
> On s390x hosts with a single CPU, the smp test case hangs (loops).
> The check is our restart has finished is wrong.
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
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
