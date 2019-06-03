Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53594 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726836AbfFCRzF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 3 Jun 2019 13:55:05 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x53HqC8p080647
        for <linux-s390@vger.kernel.org>; Mon, 3 Jun 2019 13:55:04 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sw68x5rvp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 03 Jun 2019 13:55:03 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Mon, 3 Jun 2019 18:55:02 +0100
Date: Mon, 3 Jun 2019 19:54:56 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v3 8/8] virtio/s390: make airq summary indicators DMA
In-Reply-To: <20190603180337.17723bcf.cohuck@redhat.com>
References: <20190529122657.166148-1-mimu@linux.ibm.com>
        <20190529122657.166148-9-mimu@linux.ibm.com>
        <20190603180337.17723bcf.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190603195456.6364fb53.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Michael Mueller <mimu@linux.ibm.com>, KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, Sebastian Ott <sebott@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S . Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>

On Mon, 3 Jun 2019 18:03:37 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, 29 May 2019 14:26:57 +0200
> Michael Mueller <mimu@linux.ibm.com> wrote:
> 
> > From: Halil Pasic <pasic@linux.ibm.com>
> > 
> > Hypervisor needs to interact with the summary indicators, so these
> > need to be DMA memory as well (at least for protected virtualization
> > guests).
> > 
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> > ---
> >  drivers/s390/virtio/virtio_ccw.c | 26 +++++++++++++++++++-------
> >  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> (...)
> 
> > @@ -1501,6 +1508,11 @@ static int __init virtio_ccw_init(void)
> >  {
> >  	/* parse no_auto string before we do anything further */
> >  	no_auto_parse();
> > +
> > +	summary_indicators = cio_dma_zalloc(MAX_AIRQ_AREAS);
> > +	if (!summary_indicators)
> > +		return -ENOMEM;
> > +
> >  	return ccw_driver_register(&virtio_ccw_driver);
> 
> Don't you need to free summary_indicators again if registering the
> driver fails?
> 

We do! BTW as of today I'm back and I intend to handle things
regularly form now on ;).

Regards,
Halil

> >  }
> >  device_initcall(virtio_ccw_init);
> 
