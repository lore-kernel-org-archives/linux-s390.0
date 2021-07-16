Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3223C12002
	for <linux-s390@archiver.kernel.org>; Fri, 16 Jul 2021 12:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C611E6128B
	for <linux-s390@archiver.kernel.org>; Fri, 16 Jul 2021 12:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbhGPMW1 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 16 Jul 2021 08:22:27 -0400
Received: from foss.arm.com ([217.140.110.172]:38338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232024AbhGPMW0 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 16 Jul 2021 08:22:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08358D6E;
        Fri, 16 Jul 2021 05:19:31 -0700 (PDT)
Received: from [10.57.36.240] (unknown [10.57.36.240])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF0533F774;
        Fri, 16 Jul 2021 05:19:28 -0700 (PDT)
Subject: Re: [PATCH v1 16/16] dma-mapping: Disallow .map_sg operations from
 returning zero on error
To:     Christoph Hellwig <hch@lst.de>,
        Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org,
        Stephen Bates <sbates@raithlin.com>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20210715164544.6827-1-logang@deltatee.com>
 <20210715164544.6827-17-logang@deltatee.com> <20210716063332.GD13345@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <21b7f2f1-ccac-4567-6933-a258dcad7099@arm.com>
Date:   Fri, 16 Jul 2021 13:19:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716063332.GD13345@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 2021-07-16 07:33, Christoph Hellwig wrote:
> On Thu, Jul 15, 2021 at 10:45:44AM -0600, Logan Gunthorpe wrote:
>> @@ -194,6 +194,8 @@ static int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>>   	else
>>   		ents = ops->map_sg(dev, sg, nents, dir, attrs);
>>   
>> +	WARN_ON_ONCE(ents == 0);
> 
> Turns this into a negative error code while we're at it, just to keep
> the callers sane?

Right, by this point returning the 0 would pass through 
dma_map_sg_attrs() OK, but AFAICS dma_map_sgtable() would now get 
confused and return success but with sgt->nents = 0. Coercing it to an 
error code (which dma_map_sg_attrs() would then just change right back) 
seems sensible for the sake of easy robustness.

Robin.
