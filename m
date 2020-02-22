Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42642 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726701AbgBVTII (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 22 Feb 2020 14:08:08 -0500
Received: by mail-wr1-f72.google.com with SMTP id j4so2854257wrs.13
        for <linux-s390@vger.kernel.org>; Sat, 22 Feb 2020 11:08:04 -0800 (PST)
Date: Sat, 22 Feb 2020 14:07:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/2] virtio: let virtio use DMA API when guest RAM is
 protected
Message-ID: <20200222140408-mutt-send-email-mst@kernel.org>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220160606.53156-3-pasic@linux.ibm.com>
 <20200220161309.GB12709@lst.de>
 <20200221153340.4cdcde81.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221153340.4cdcde81.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Jason Wang <jasowang@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Michael Mueller <mimu@linux.ibm.com>

On Fri, Feb 21, 2020 at 03:33:40PM +0100, Halil Pasic wrote:
> AFAIU you have a positive attitude towards the idea, that 
> !F_VIRTIO_PLATFORM implies 'no DMA API is used by virtio' 
> should be scrapped. 
> 
> I would like to accomplish that without adverse effects to virtio-ccw
> (because caring for virtio-ccw is a part of job description).
> 
> Regards,
> Halil

It is possible, in theory. IIRC the main challenge is that DMA API
has overhead of indirect function calls even when all it
does it return back the PA without changes. So that will lead to
a measureable performance degradation. That might be fixable,
possibly using some kind of logic along the lines of
	if (iova is pa)
		return pa
	else
		indirect call

and for unmapping, we might need an API that says "unmap
is a nop, safe to skip" so we don't maintain the
dma address until unmap.


-- 
MST
