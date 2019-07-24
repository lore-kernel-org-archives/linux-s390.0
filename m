Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6984 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725909AbfGXGo1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 24 Jul 2019 02:44:27 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6O6epkK113527
        for <linux-s390@vger.kernel.org>; Wed, 24 Jul 2019 02:44:26 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2txgyqc3v2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 24 Jul 2019 02:44:25 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 24 Jul 2019 07:44:24 +0100
Subject: Re: [PATCH 1/1] virtio/s390: fix race on airq_areas[]
References: <20190723225817.12800-1-pasic@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 24 Jul 2019 08:44:19 +0200
MIME-Version: 1.0
In-Reply-To: <20190723225817.12800-1-pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <74087255-fdae-01a1-7152-f6fac8e13019@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>, Marc Hartmayer <mhartmay@linux.ibm.com>, virtualization@lists.linux-foundation.org



On 24.07.19 00:58, Halil Pasic wrote:
> The access to airq_areas was racy ever since the adapter interrupts got
> introduced to virtio-ccw, but since commit 39c7dcb15892 ("virtio/s390:
> make airq summary indicators DMA") this became an issue in practice as
> well. Namely before that commit the airq_info that got overwritten was
> still functional. After that commit however the two infos share a
> summary_indicator, which aggravates the situation. Which means
> auto-online mechanism occasionally hangs the boot with virtio_blk.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Fixes: 96b14536d935 ("virtio-ccw: virtio-ccw adapter interrupt support.")
> ---
> * We need definitely this fixed for 5.3. For older stable kernels it is
> to be discussed. @Connie what do you think: do we need a cc stable?

Unless you can prove that the problem could never happen on old version
we absolutely do need cc stable. 

> 
> * I have a variant that does not need the extra mutex but uses cmpxchg().
> Decided to post this one because that one is more complex. But if there
> is interest we can have a look at it as well.

This is slow path (startup) and never called in hot path. Correct? Mutex should be
fine.
> ---
>  drivers/s390/virtio/virtio_ccw.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index 1a55e5942d36..d97742662755 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -145,6 +145,8 @@ struct airq_info {
>  	struct airq_iv *aiv;
>  };
>  static struct airq_info *airq_areas[MAX_AIRQ_AREAS];
> +DEFINE_MUTEX(airq_areas_lock);
> +
>  static u8 *summary_indicators;
>  
>  static inline u8 *get_summary_indicator(struct airq_info *info)
> @@ -265,9 +267,11 @@ static unsigned long get_airq_indicator(struct virtqueue *vqs[], int nvqs,
>  	unsigned long bit, flags;
>  
>  	for (i = 0; i < MAX_AIRQ_AREAS && !indicator_addr; i++) {
> +		mutex_lock(&airq_areas_lock);
>  		if (!airq_areas[i])
>  			airq_areas[i] = new_airq_info(i);
>  		info = airq_areas[i];
> +		mutex_unlock(&airq_areas_lock);
>  		if (!info)
>  			return 0;
>  		write_lock_irqsave(&info->lock, flags);
> 
