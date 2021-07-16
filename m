Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AD7C636CB
	for <linux-s390@archiver.kernel.org>; Fri, 16 Jul 2021 16:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F100A61374
	for <linux-s390@archiver.kernel.org>; Fri, 16 Jul 2021 16:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhGPQVJ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 16 Jul 2021 12:21:09 -0400
Received: from ale.deltatee.com ([204.191.154.188]:57206 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhGPQVF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 16 Jul 2021 12:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=BnhY0izzSFVDQcuht2cro6XvHSIBnnpJHK/4w8E4yWs=; b=lHiHBr9UmxsphzyuJXXrFvFkXJ
        nHnU2Aad+t4uXkXpqnoYYQXL8s0VDrTpcUrSa7MBf3lHNc8SwA72FIyA0EFnNsLaMjuY1HyVFc4eY
        86UCMlrgVGkMX16Elm46rVT3dMTeEwZNCX1a+CjIpwSiCKZgO96vmX56LfZWgzS5j7bcdiascYBT7
        QpZUtkyACvD3Bob5Y0jFlifJMDasY0nH1O+2FuN7wP4IsecNoMeLFw+7g7lmwXVQFM8ujekY7qsib
        a39261ZQjmb8njie60hE0kfk/jWrRkVOwj7hryYFQZ5ncmwJY+tyhtISQB4927wPhvb2n8G328kwr
        zFWziVNw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1m4QXJ-0003ky-3C; Fri, 16 Jul 2021 10:18:01 -0600
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-parisc@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>
References: <20210715164544.6827-1-logang@deltatee.com>
 <20210715164544.6827-17-logang@deltatee.com> <20210716063332.GD13345@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <82c0f8d8-9050-dcf7-d68d-93691878a6dd@deltatee.com>
Date:   Fri, 16 Jul 2021 10:17:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716063332.GD13345@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: martin.oliveira@eideticom.com, sbates@raithlin.com, robin.murphy@arm.com, m.szyprowski@samsung.com, xen-devel@lists.xenproject.org, linux-parisc@vger.kernel.org, iommu@lists.linux-foundation.org, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org, linux-ia64@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v1 16/16] dma-mapping: Disallow .map_sg operations from
 returning zero on error
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 2021-07-16 12:33 a.m., Christoph Hellwig wrote:
> On Thu, Jul 15, 2021 at 10:45:44AM -0600, Logan Gunthorpe wrote:
>> @@ -194,6 +194,8 @@ static int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>>  	else
>>  		ents = ops->map_sg(dev, sg, nents, dir, attrs);
>>  
>> +	WARN_ON_ONCE(ents == 0);
> 
> Turns this into a negative error code while we're at it, just to keep
> the callers sane?
> 

Sure thing. All the feedback makes sense, we'll fix it up and send a v2
in due course.

Thanks,

Logan
