Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64956 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727202AbfGXLRr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 24 Jul 2019 07:17:47 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6OBH8V8069581
        for <linux-s390@vger.kernel.org>; Wed, 24 Jul 2019 07:17:46 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2txnw8hcsm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 24 Jul 2019 07:17:45 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Wed, 24 Jul 2019 12:17:43 +0100
Date: Wed, 24 Jul 2019 13:17:37 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 1/1] virtio/s390: fix race on airq_areas[]
In-Reply-To: <4a6d82b5-db9d-ed2e-2d07-e14aee3884af@de.ibm.com>
References: <20190723225817.12800-1-pasic@linux.ibm.com>
        <74087255-fdae-01a1-7152-f6fac8e13019@de.ibm.com>
        <20190724103410.574dd259.cohuck@redhat.com>
        <4a6d82b5-db9d-ed2e-2d07-e14aee3884af@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20190724131737.24347915.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>, Marc Hartmayer <mhartmay@linux.ibm.com>, virtualization@lists.linux-foundation.org

On Wed, 24 Jul 2019 10:39:13 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> 
> 
> On 24.07.19 10:34, Cornelia Huck wrote:
> > On Wed, 24 Jul 2019 08:44:19 +0200
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> > 
> >> On 24.07.19 00:58, Halil Pasic wrote:
> >>> The access to airq_areas was racy ever since the adapter interrupts got
> >>> introduced to virtio-ccw, but since commit 39c7dcb15892 ("virtio/s390:
> >>> make airq summary indicators DMA") this became an issue in practice as
> >>> well. Namely before that commit the airq_info that got overwritten was
> >>> still functional. After that commit however the two infos share a
> >>> summary_indicator, which aggravates the situation. Which means
> >>> auto-online mechanism occasionally hangs the boot with virtio_blk.
> >>>
> >>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> >>> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> >>> Fixes: 96b14536d935 ("virtio-ccw: virtio-ccw adapter interrupt support.")
> >>> ---
> >>> * We need definitely this fixed for 5.3. For older stable kernels it is
> >>> to be discussed. @Connie what do you think: do we need a cc stable?  
> >>
> >> Unless you can prove that the problem could never happen on old version
> >> we absolutely do need cc stable. 
> > 
> > Yes, this needs to be cc:stable.
> > 
> >>
> >>>
> >>> * I have a variant that does not need the extra mutex but uses cmpxchg().
> >>> Decided to post this one because that one is more complex. But if there
> >>> is interest we can have a look at it as well.  
> >>
> >> This is slow path (startup) and never called in hot path. Correct? Mutex should be
> >> fine.
> > 
> > Yes, this is ultimately called through the ->probe functions of virtio
> > drivers.
> > 
> >>> ---
> >>>  drivers/s390/virtio/virtio_ccw.c | 4 ++++
> >>>  1 file changed, 4 insertions(+)
> >>>
> >>> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> >>> index 1a55e5942d36..d97742662755 100644
> >>> --- a/drivers/s390/virtio/virtio_ccw.c
> >>> +++ b/drivers/s390/virtio/virtio_ccw.c
> >>> @@ -145,6 +145,8 @@ struct airq_info {
> >>>  	struct airq_iv *aiv;
> >>>  };
> >>>  static struct airq_info *airq_areas[MAX_AIRQ_AREAS];
> >>> +DEFINE_MUTEX(airq_areas_lock);
> >>> +
> >>>  static u8 *summary_indicators;
> >>>  
> >>>  static inline u8 *get_summary_indicator(struct airq_info *info)
> >>> @@ -265,9 +267,11 @@ static unsigned long get_airq_indicator(struct virtqueue *vqs[], int nvqs,
> >>>  	unsigned long bit, flags;
> >>>  
> >>>  	for (i = 0; i < MAX_AIRQ_AREAS && !indicator_addr; i++) {
> >>> +		mutex_lock(&airq_areas_lock);
> >>>  		if (!airq_areas[i])
> >>>  			airq_areas[i] = new_airq_info(i);
> >>>  		info = airq_areas[i];
> >>> +		mutex_unlock(&airq_areas_lock);
> >>>  		if (!info)
> >>>  			return 0;
> >>>  		write_lock_irqsave(&info->lock, flags);
> >>>   
> >>
> > 
> > Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> > 
> > Should I pick this and send a pull request, or is it quicker to just
> > take this directly?
> 
> I think we can you did via a fast path. Halil, can you push to the s390 tree?

Sure!

Regards,
Halil

> 
