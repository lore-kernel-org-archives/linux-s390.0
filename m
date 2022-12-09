Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78E6C4332F
	for <linux-s390@archiver.kernel.org>; Fri,  9 Dec 2022 19:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiLIT5l (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 9 Dec 2022 14:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiLIT5j (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 9 Dec 2022 14:57:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FC6C63;
        Fri,  9 Dec 2022 11:57:35 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670615854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=80wTTdM3lWcQJcmXIfadK+PcvLcT1z5Yu3sjTQP3wro=;
        b=PqNkUG89F3vCH15uy5iNjLuBHtcX3sfE/pjRJ9C/TgXJRN/AKDG/8pWBgISSFr27lms3Zm
        wB0CYXx3CMO5B2cYP3Q6MxdqQpK7loHrVXkHpW7WcCt4Ibj0qaUahi/RMdXEgn2r+pdSNo
        G/FtW8teP0I8/hjBj5wIRfJIwJHwmdOCW2bLHfzzfPsC9ow765s+tHqpGUcZ8DLPK1IOl3
        moRKoh7Dms8fotzAQ/cVNuDqogMERKCTUJBGKGN+qLu65ExqCV56l6uGBJM2vadBWNTt/r
        +qKsznycSuLUtlAK0m12CHOUcj12hWpp76jw2YK7N5VjDEwKImu/M3/Eo8rs0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670615854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=80wTTdM3lWcQJcmXIfadK+PcvLcT1z5Yu3sjTQP3wro=;
        b=hgUyw/HxZZ/4scm8iv4e1ZlYgKcOJe1h6eX0PMNhCiABfbaJd6oft4r8ZUir7YwKdWDVwP
        /ZtoHr4L1LzA34BQ==
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Will Deacon <will@kernel.org>
Cc:     Bharat Bhushan <bharat.bhushan@nxp.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH iommufd 0/9] Remove IOMMU_CAP_INTR_REMAP
In-Reply-To: <0-v1-9e466539c244+47b5-secure_msi_jgg@nvidia.com>
References: <0-v1-9e466539c244+47b5-secure_msi_jgg@nvidia.com>
Date:   Fri, 09 Dec 2022 20:57:33 +0100
Message-ID: <87cz8scpua.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Dec 08 2022 at 16:26, Jason Gunthorpe wrote:
> [ This would be for v6.3, the series depends on a bunch of stuff in
> linux-next. I would be happy to merge it through the iommfd tree ]

I'll have a look next week.
