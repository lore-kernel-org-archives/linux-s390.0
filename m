Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:56431 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbgBUQlz (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Feb 2020 11:41:55 -0500
Date: Fri, 21 Feb 2020 17:41:51 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/2] virtio: decouple protected guest RAM form
 VIRTIO_F_IOMMU_PLATFORM
Message-ID: <20200221164151.GD10054@lst.de>
References: <20200220160606.53156-1-pasic@linux.ibm.com> <20200220163055-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220163055-mutt-send-email-mst@kernel.org>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Wang <jasowang@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Michael Mueller <mimu@linux.ibm.com>

On Thu, Feb 20, 2020 at 04:33:35PM -0500, Michael S. Tsirkin wrote:
> So it sounds like a host issue: the emulation of s390 unnecessarily complicated.
> Working around it by the guest looks wrong ...

Yes.  If your host (and I don't care if you split hypervisor, ultravisor
and megavisor out in your implementation) wants to support a VM
architecture where the host can't access all guest memory you need to
ensure the DMA API is used.  Extra points for simply always setting the
flag and thus future proofing the scheme.
