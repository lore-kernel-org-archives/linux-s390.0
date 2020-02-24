Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7884 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727644AbgBXS7k (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 24 Feb 2020 13:59:40 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01OInlFi069974
        for <linux-s390@vger.kernel.org>; Mon, 24 Feb 2020 13:59:39 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yaxt7gkeu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 24 Feb 2020 13:59:38 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Mon, 24 Feb 2020 18:59:37 -0000
Date: Mon, 24 Feb 2020 19:59:28 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 2/2] virtio: let virtio use DMA API when guest RAM is
 protected
In-Reply-To: <20200221163645.GB10054@lst.de>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
        <20200220160606.53156-3-pasic@linux.ibm.com>
        <20200220161309.GB12709@lst.de>
        <20200221025915.GB2298@umbus.fritz.box>
        <20200221163645.GB10054@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20200224195928.654694fd.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: David Gibson <david@gibson.dropbear.id.au>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Michael Mueller <mimu@linux.ibm.com>

On Fri, 21 Feb 2020 17:36:45 +0100
Christoph Hellwig <hch@lst.de> wrote:

> > By "legacy devices" I assume you mean pre-virtio-1.0 devices, that
> > lack the F_VERSION_1 feature flag.  Is that right?  Because I don't
> > see how being a legacy device or not relates to use of the DMA API.  
> 
> No.   "legacy" is anything that does not set F_ACCESS_PLATFORM.

FYI in virtio-speak the term 'legacy devices' is already taken and it
ain't congruent with your intended semantics. Please look it up
https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html#x1-60001

But with that understood your statement does provide insisting in how do
you see F_ACCESS_PLATFORM. I.e. something that should be enabled in
general, except for legacy reasons. But I'm afraid Michael sees it
differently: i.e. something that should be enabled when necessary, and
otherwise not (because it is likely to cost performance).

Regards,
Halil
