Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43908 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727053AbgBUNiF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Feb 2020 08:38:05 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LDTcUZ015607
        for <linux-s390@vger.kernel.org>; Fri, 21 Feb 2020 08:38:04 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y9ytrnqnn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 21 Feb 2020 08:38:04 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 21 Feb 2020 13:38:01 -0000
Date: Fri, 21 Feb 2020 14:37:54 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 0/2] virtio: decouple protected guest RAM form
 VIRTIO_F_IOMMU_PLATFORM
In-Reply-To: <20200220162747-mutt-send-email-mst@kernel.org>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
        <20200220162747-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20200221143754.7c5f61ff.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Michael Mueller <mimu@linux.ibm.com>

On Thu, 20 Feb 2020 16:29:50 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Feb 20, 2020 at 05:06:04PM +0100, Halil Pasic wrote:
> > * This usage is not congruent with  standardised semantics of
> > VIRTIO_F_IOMMU_PLATFORM. Guest memory protected is an orthogonal reason
> > for using DMA API in virtio (orthogonal with respect to what is
> > expressed by VIRTIO_F_IOMMU_PLATFORM). 
> 
> Quoting the spec:
> 
>   \item[VIRTIO_F_ACCESS_PLATFORM(33)] This feature indicates that
>   the device can be used on a platform where device access to data
>   in memory is limited and/or translated. E.g. this is the case if the device can be located
>   behind an IOMMU that translates bus addresses from the device into physical
>   addresses in memory, if the device can be limited to only access
>   certain memory addresses or if special commands such as
>   a cache flush can be needed to synchronise data in memory with
>   the device. Whether accesses are actually limited or translated
>   is described by platform-specific means.
>   If this feature bit is set to 0, then the device
>   has same access to memory addresses supplied to it as the
>   driver has.
>   In particular, the device will always use physical addresses
>   matching addresses used by the driver (typically meaning
>   physical addresses used by the CPU)
>   and not translated further, and can access any address supplied to it by
>   the driver. When clear, this overrides any platform-specific description of
>   whether device access is limited or translated in any way, e.g.
>   whether an IOMMU may be present.
> 
> since device can't access encrypted memory,
> this seems to match your case reasonably well.
> 

As David already explained, the device does not have to access encrypted
memory. In fact, we don't have memory encryption but memory protection on
s390. All the device *should* ever see is non-protected memory (one that
was previously shared by the guest).

Our protected guests start as non-protected ones, and may or may not
turn protected during their life-span. From the device perspective,
really, nothing changes. I believe David explained this much better than
I did.

Regards,
Halil
