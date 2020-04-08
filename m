Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:58758 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729686AbgDHQEK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Apr 2020 12:04:10 -0400
Date: Wed, 8 Apr 2020 17:03:24 +0100
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: decruft the vmalloc API
Message-ID: <20200408160324.GS25745@shell.armlinux.org.uk>
References: <20200408115926.1467567-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408115926.1467567-1-hch@lst.de>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, x86@kernel.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Laura Abbott <labbott@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>, Christophe Leroy <christophe.leroy@c-s.fr>, linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-s390@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, bpf@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org

On Wed, Apr 08, 2020 at 01:58:58PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> Peter noticed that with some dumb luck you can toast the kernel address
> space with exported vmalloc symbols.
> 
> I used this as an opportunity to decruft the vmalloc.c API and make it
> much more systematic.  This also removes any chance to create vmalloc
> mappings outside the designated areas or using executable permissions
> from modules.  Besides that it removes more than 300 lines of code.

I haven't read all your patches yet.

Have you tested it on 32-bit ARM, where the module area is located
_below_ PAGE_OFFSET and outside of the vmalloc area?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
