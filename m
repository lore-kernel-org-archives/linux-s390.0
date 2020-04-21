Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18672 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725920AbgDUJ6j (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Apr 2020 05:58:39 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03L9Wg8i097307
        for <linux-s390@vger.kernel.org>; Tue, 21 Apr 2020 05:58:38 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30ggr2b130-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 21 Apr 2020 05:58:38 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 21 Apr 2020 10:58:13 +0100
Subject: Re: stop using ioctl_by_bdev in the s390 DASD driver
References: <20200421061226.33731-1-hch@lst.de>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 21 Apr 2020 11:58:31 +0200
MIME-Version: 1.0
In-Reply-To: <20200421061226.33731-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <b7e4a728-1f58-f304-cb5b-1aa2206a6bb4@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org

On 21.04.20 08:12, Christoph Hellwig wrote:
> Hi Jens and DASD maintainers,
> 
> can you take a look at this series, which stops the DASD driver from
> issuing ioctls from kernel space, in preparation of removing
> ioctl_by_bdev.  I don't really like the new s390-only method, but short
> of forcing the dasd driver to be built into the kernel I can't think of
> anything better.  But maybe the s390 maintainers are fine with forcing
> the DASD driver to be built in, in which case we could go down that
> route?

Hmm the defconfig results in dasd built-in anyway. But distros really like
to keep it modular.

Hmm, we do have

obj-$(CONFIG_DASD) += dasd_mod.o
obj-$(CONFIG_DASD_DIAG) += dasd_diag_mod.o
obj-$(CONFIG_DASD_ECKD) += dasd_eckd_mod.o
obj-$(CONFIG_DASD_FBA)  += dasd_fba_mod.o

Would it work to make CONFIG_DASD built-in only and keep the other 3 as modules?
Not sure about the implications. 
