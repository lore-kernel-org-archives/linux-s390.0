Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 9 Jul 2020 17:23:38 +0200
From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3 07/34] iommu: Add probe_device() and release_device()
 call-backs
Message-ID: <20200709152337.GB27672@8bytes.org>
References: <20200429133712.31431-1-joro@8bytes.org>
 <20200704090957.8892-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200704090957.8892-1-hdanton@sina.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Hillf Danton <hdanton@sina.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, Markus Elfring <Markus.Elfring@web.de>

On Sat, Jul 04, 2020 at 05:09:57PM +0800, Hillf Danton wrote:
> > +	group = iommu_group_get_for_dev(dev);
> > +	if (!IS_ERR(group)) {
> 
> Typo?

Yes, fortunatly it gets fixed again in patch 11 of this series.

Regards,

	Joerg
