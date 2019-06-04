Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52424 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727169AbfFDO3W (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Jun 2019 10:29:22 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x54ENosB007761
        for <linux-s390@vger.kernel.org>; Tue, 4 Jun 2019 10:29:21 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2swss7j98r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 04 Jun 2019 10:29:20 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Tue, 4 Jun 2019 15:29:16 +0100
Date: Tue, 4 Jun 2019 16:29:09 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v3 7/8] virtio/s390: use DMA memory for ccw I/O and
 classic notifiers
In-Reply-To: <20190604153625.6c03c232.cohuck@redhat.com>
References: <20190529122657.166148-1-mimu@linux.ibm.com>
        <20190529122657.166148-8-mimu@linux.ibm.com>
        <20190603181716.325101d9.cohuck@redhat.com>
        <20190604150819.1f8707b5.pasic@linux.ibm.com>
        <20190604153625.6c03c232.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190604162909.54de39fb.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Michael Mueller <mimu@linux.ibm.com>, KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, Sebastian Ott <sebott@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S . Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>

On Tue, 4 Jun 2019 15:36:25 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Tue, 4 Jun 2019 15:08:19 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 

[..]

> 
> Two things:
> - The call path goes from the vcdev to the vdev, then back to the vcdev
>   and then to the cdev. Going from the vcdev to the cdev  directly
>   eliminates the roundtrip via the vdev, which I think does not add
>   anything.
> - I prefer
> 	variable = function_returning_a_pointer(...);
>   over
> 	function_setting_a_variable(..., variable);
>   The latter obscures the fact that we change the value of the
>   variable, unless named very obviously.
> 

I understand. Here it's especially bad because what looks like a
function is actually a macro so it ain't even fn(..., &variable) but
just fn(..., variable). I guess I'm a bit desensitized towards the latter
because of my c++ background.


> > 
> > I will change this for v4 as you requested. Again sorry for missing it!
> 
> np, can happen.

Thanks for the explanation. I will use

ccw_device_dma_zalloc() directly in v4.

Regards,
Halil
