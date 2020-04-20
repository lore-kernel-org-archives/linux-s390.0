Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55268 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726164AbgDTGqm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 20 Apr 2020 02:46:42 -0400
Date: Mon, 20 Apr 2020 08:46:24 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] KVM: s390: remove unneeded semicolon in
 gisa_vcpu_kicker()
Message-ID: <20200420084624.1d8a1c13.cohuck@redhat.com>
In-Reply-To: <20200418081926.41666-1-yanaijie@huawei.com>
References: <20200418081926.41666-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jason Yan <yanaijie@huawei.com>
Cc: borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, Ulrich.Weigand@de.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>

On Sat, 18 Apr 2020 16:19:26 +0800
Jason Yan <yanaijie@huawei.com> wrote:

> Fix the following coccicheck warning:
> 
> arch/s390/kvm/interrupt.c:3085:2-3: Unneeded semicolon
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Fixes: 9f30f6216378 ("KVM: s390: add gib_alert_irq_handler()")

> ---
>  arch/s390/kvm/interrupt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 8191106bf7b9..559177123d0f 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -3082,7 +3082,7 @@ static enum hrtimer_restart gisa_vcpu_kicker(struct hrtimer *timer)
>  		__airqs_kick_single_vcpu(kvm, pending_mask);
>  		hrtimer_forward_now(timer, ns_to_ktime(gi->expires));
>  		return HRTIMER_RESTART;
> -	};
> +	}
>  
>  	return HRTIMER_NORESTART;
>  }

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
