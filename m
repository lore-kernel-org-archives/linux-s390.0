Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:52526 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731815AbfJNU7J (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 14 Oct 2019 16:59:09 -0400
Date: Mon, 14 Oct 2019 21:59:00 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH RFC 0/5] ARM: Raspberry Pi 4 DMA support
Message-ID: <20191014205859.GA7634@iMac-3.local>
References: <20191014183108.24804-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014183108.24804-1-nsaenzjulienne@suse.de>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-s390@vger.kernel.org, f.fainelli@gmail.com, linux-kernel@vger.kernel.org, hch@infradead.org, mbrugger@suse.com, wahrenst@gmx.net, linuxppc-dev@lists.ozlabs.org

On Mon, Oct 14, 2019 at 08:31:02PM +0200, Nicolas Saenz Julienne wrote:
> the Raspberry Pi 4 offers up to 4GB of memory, of which only the first
> is DMA capable device wide. This forces us to use of bounce buffers,
> which are currently not very well supported by ARM's custom DMA ops.
> Among other things the current mechanism (see dmabounce.c) isn't
> suitable for high memory. Instead of fixing it, this series introduces a
> way of selecting dma-direct as the default DMA ops provider which allows
> for the Raspberry Pi to make use of swiotlb.

I presume these patches go on top of this series:

http://lkml.kernel.org/r/20190911182546.17094-1-nsaenzjulienne@suse.de

which I queued here:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/zone-dma

-- 
Catalin
