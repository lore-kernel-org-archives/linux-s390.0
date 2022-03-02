Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3B0C43217
	for <linux-s390@archiver.kernel.org>; Wed,  2 Mar 2022 08:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiCBIIh (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 2 Mar 2022 03:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240011AbiCBIIg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Mar 2022 03:08:36 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FCF4EF7B;
        Wed,  2 Mar 2022 00:07:52 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F380B68AFE; Wed,  2 Mar 2022 09:07:46 +0100 (CET)
Date:   Wed, 2 Mar 2022 09:07:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        x86@kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-hyperv@vger.kernel.org, tboot-devel@lists.sourceforge.net,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 07/11] x86: remove the IOMMU table infrastructure
Message-ID: <20220302080746.GA23075@lst.de>
References: <20220227143055.335596-1-hch@lst.de> <20220227143055.335596-8-hch@lst.de> <Yh5j5q5n/GyU0/1n@0xbeefdead.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh5j5q5n/GyU0/1n@0xbeefdead.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Mar 01, 2022 at 01:20:22PM -0500, Konrad Rzeszutek Wilk wrote:
> I think you also need to check for IBM Calgary?

The IBM Calgary IOMMU support is long gone.
