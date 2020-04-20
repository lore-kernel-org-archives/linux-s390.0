Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42324 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725815AbgDTHbs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 20 Apr 2020 03:31:48 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03K72JfQ015914
        for <linux-s390@vger.kernel.org>; Mon, 20 Apr 2020 03:31:46 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30ggr10u3s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 20 Apr 2020 03:31:46 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 20 Apr 2020 08:31:11 +0100
Subject: Re: [PATCH] KVM: s390: remove unneeded semicolon in
 gisa_vcpu_kicker()
References: <20200418081926.41666-1-yanaijie@huawei.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 20 Apr 2020 09:31:38 +0200
MIME-Version: 1.0
In-Reply-To: <20200418081926.41666-1-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <0201f3bf-335a-30db-51a2-c8050d92ae92@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jason Yan <yanaijie@huawei.com>, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, Ulrich.Weigand@de.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Hulk Robot <hulkci@huawei.com>

On 18.04.20 10:19, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> arch/s390/kvm/interrupt.c:3085:2-3: Unneeded semicolon
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Thanks applied.

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
> 
