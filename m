Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45A7C47E4B
	for <linux-s390@archiver.kernel.org>; Thu, 15 Jul 2021 16:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BFF2613EB
	for <linux-s390@archiver.kernel.org>; Thu, 15 Jul 2021 16:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhGOQ70 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:59:26 -0400
Received: from ale.deltatee.com ([204.191.154.188]:50496 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235390AbhGOQ7P (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 15 Jul 2021 12:59:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=zhc7pzLmZmjUsLXsFnMXewKeUUfUybMjLBdEKzxTgWI=; b=a4eD7Hw2j62J4jmrqG3qM9ka82
        5k5K5mLQB+hZHZqXGBpC8vAokNP0Ip4On3I09UBGqNxaWIRq2dmyriwR06pgFKl9jIT5xqRBf9vsD
        YwuOCb9uZhKtsGIHsKDWUmojgkYI2/2LwIaMUocRxIEBx7IUQ/6yxeiqqZGnSG4a85UbkDOZqICEa
        lG9jcrA6QbuiJkY03RA7uB1x8xSEwzPTD/kmMZHa3L73KtXI/2a8MW52t16HXK3n1ZJYijnMXJyfP
        O/wyAVK1kdSyrErsaIIRyaT5BgNIbq1xTAmZfgnfhUHzVRbyGsOS/vCEnIuD/1MU7ahfhlv+CI82Y
        BmE/J6uw==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1m44eg-0002EB-Nd; Thu, 15 Jul 2021 10:56:11 -0600
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-parisc@vger.kernel.org,
        xen-devel@lists.xenproject.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>
References: <20210715164544.6827-1-logang@deltatee.com>
 <20210715165309.GO22278@shell.armlinux.org.uk>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <aa33d2bf-8324-5647-b800-3a2e3e774e80@deltatee.com>
Date:   Thu, 15 Jul 2021 10:56:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715165309.GO22278@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: martin.oliveira@eideticom.com, sbates@raithlin.com, robin.murphy@arm.com, m.szyprowski@samsung.com, hch@lst.de, xen-devel@lists.xenproject.org, linux-parisc@vger.kernel.org, iommu@lists.linux-foundation.org, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org, linux-ia64@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v1 00/16] .map_sg() error cleanup
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org




On 2021-07-15 10:53 a.m., Russell King (Oracle) wrote:
> On Thu, Jul 15, 2021 at 10:45:28AM -0600, Logan Gunthorpe wrote:
>> Hi,
>>
>> This series is spun out and expanded from my work to add P2PDMA support
>> to DMA map operations[1].
>>
>> The P2PDMA work requires distinguishing different error conditions in
>> a map_sg operation. dma_map_sgtable() already allows for returning an
>> error code (where as dma_map_sg() is only allowed to return zero)
>> however, it currently only returns -EINVAL when a .map_sg() call returns
>> zero.
>>
>> This series cleans up all .map_sg() implementations to return appropriate
>> error codes. After the cleanup, dma_map_sg() will still return zero,
>> however dma_map_sgtable() will pass the error code from the .map_sg()
>> call. Thanks go to Martn Oliveira for doing a lot of the cleanup of the
>> obscure implementations.
>>
>> The patch set is based off of v5.14-rc1 and a git repo can be found
>> here:
> 
> Have all the callers for dma_map_sg() been updated to check for error
> codes? If not, isn't that a pre-requisit to this patch set?

No. Perhaps I wasn't clear enough: This series is changing only
impelemntations of .map_sg(). It does *not* change the return code of
dma_map_sg(). dma_map_sg() will continue to return zero on error for the
foreseeable future. The dma_map_sgtable() call already allows returning
error codes and it will pass the new error code through. This is what
will be used in the P2PDMA work.

Logan
