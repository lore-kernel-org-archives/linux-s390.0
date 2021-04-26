Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BEAC433ED
	for <linux-s390@archiver.kernel.org>; Mon, 26 Apr 2021 14:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 682AB6103E
	for <linux-s390@archiver.kernel.org>; Mon, 26 Apr 2021 14:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbhDZOHw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 26 Apr 2021 10:07:52 -0400
Received: from verein.lst.de ([213.95.11.211]:41417 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232575AbhDZOHv (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 26 Apr 2021 10:07:51 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 539B468C4E; Mon, 26 Apr 2021 16:07:08 +0200 (CEST)
Date:   Mon, 26 Apr 2021 16:07:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Halil Pasic <pasic@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christoph Hellwig <hch@lst.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Tarun Gupta <targupta@nvidia.com>
Subject: Re: [PATCH 06/12] vfio/ap_ops: Convert to use
 vfio_register_group_dev()
Message-ID: <20210426140708.GE15209@lst.de>
References: <0-v1-d88406ed308e+418-vfio3_jgg@nvidia.com> <6-v1-d88406ed308e+418-vfio3_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6-v1-d88406ed308e+418-vfio3_jgg@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Apr 23, 2021 at 08:03:03PM -0300, Jason Gunthorpe wrote:
> This is straightforward conversion, the ap_matrix_mdev is actually serving
> as the vfio_device and we can replace all the mdev_get_drvdata()'s with a
> simple container_of().

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
