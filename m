Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41832 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2408727AbfFLPNA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Jun 2019 11:13:00 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5CFCOnG131262
        for <linux-s390@vger.kernel.org>; Wed, 12 Jun 2019 11:12:58 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t33jk0wxr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 12 Jun 2019 11:12:54 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Wed, 12 Jun 2019 16:11:12 +0100
Date: Wed, 12 Jun 2019 17:11:05 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v5 4/8] s390/airq: use DMA memory for adapter interrupts
In-Reply-To: <20190612163501.45a050b0.cohuck@redhat.com>
References: <20190612111236.99538-1-pasic@linux.ibm.com>
        <20190612111236.99538-5-pasic@linux.ibm.com>
        <20190612163501.45a050b0.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20190612171105.230b976d.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>

On Wed, 12 Jun 2019 16:35:01 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, 12 Jun 2019 13:12:32 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:

[..]

> > --- a/drivers/s390/cio/css.c
> > +++ b/drivers/s390/cio/css.c
> > @@ -1184,6 +1184,7 @@ static int __init css_bus_init(void)
> >  	ret = cio_dma_pool_init();
> >  	if (ret)
> >  		goto out_unregister_pmn;
> > +	airq_init();
> 
> Ignoring the return code here does not really hurt right now, but we
> probably want to change that if we want to consider failures in css
> initialization to be fatal.
> 

Right. I think that would even simplify the code a bit (no rollback).

> >  	css_init_done = 1;
> >  
> >  	/* Enable default isc for I/O subchannels. */
> 
> On the whole, not really anything that needs changes right now, so have
> a
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 

Thank you so much!

Regards,
Halil
