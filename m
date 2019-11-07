Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727858AbfKGN1m (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 Nov 2019 08:27:42 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA7DMNI9087514
        for <linux-s390@vger.kernel.org>; Thu, 7 Nov 2019 08:27:41 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w4kdm28xs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 07 Nov 2019 08:27:41 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <sth@linux.ibm.com>;
        Thu, 7 Nov 2019 13:27:38 -0000
Subject: Re: [PATCH 5/5] block: remove (__)blkdev_reread_part as an exported
 API
References: <20191106151439.30056-1-hch@lst.de>
 <20191106151439.30056-6-hch@lst.de>
From: Stefan Haberland <sth@linux.ibm.com>
Date: Thu, 7 Nov 2019 14:27:34 +0100
MIME-Version: 1.0
In-Reply-To: <20191106151439.30056-6-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <64b9c358-1815-520b-04ed-3844e2c53c36@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Cc: linux-block@vger.kernel.org, linux-s390@vger.kernel.org

On 06.11.19 16:14, Christoph Hellwig wrote:
> In general drivers should never mess with partition tables directly.
> Unfortunately s390 and loop do for somewhat historic reasons, but they
> can use bdev_disk_changed directly instead when we export it as they
> satisfy the sanity checks we have in __blkdev_reread_part.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Hi,

tested (the whole patchset) with DASD on s390 and for the DASD part:

Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
