Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48642 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728823AbgDUOSB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Apr 2020 10:18:01 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03LEDwLx130897
        for <linux-s390@vger.kernel.org>; Tue, 21 Apr 2020 10:18:01 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30gfebktf1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 21 Apr 2020 10:18:00 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <sth@linux.ibm.com>;
        Tue, 21 Apr 2020 15:17:06 +0100
References: <20200421061226.33731-1-hch@lst.de>
From: Stefan Haberland <sth@linux.ibm.com>
Subject: Re: stop using ioctl_by_bdev in the s390 DASD driver
Date: Tue, 21 Apr 2020 16:17:53 +0200
MIME-Version: 1.0
In-Reply-To: <20200421061226.33731-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Message-Id: <b4f38eb4-ab32-6713-fb8a-0c8e81efc645@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jan Hoeppner <hoeppner@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Christoph,

thanks for addressing this. But I must say that I do not like this approach.
I get your point why you want this ioctl to be removed and I agree with
that.

Having those implicit partitions at all is really ugly but I fear that this
is widely used int the field. So I can not simply remove this code although
I would like to. Maybe we find a way to deprecate this.
But anyway...

Forcing the driver to be build in may have a lot of implications which we
should at least have a look at and maybe discuss with the distributors.
All major distributions have the driver build as modules and use module
parameters in the initrd for example.

The second thing is that I do not really like this s390-specific blockdevice
operation.

I can imagine some ways to get rid of this ioctl_by_bdev. Maybe having a
udev
rule to add a partition from userspace or having the driver add the implicit
partition at the end. Or maybe something else.

If it is OK I will have a look at this and discuss this issue with my
colleagues and come up with a different approach.

Regards,
Stefan



Am 21.04.20 um 08:12 schrieb Christoph Hellwig:
> Hi Jens and DASD maintainers,
>
> can you take a look at this series, which stops the DASD driver from
> issuing ioctls from kernel space, in preparation of removing
> ioctl_by_bdev.  I don't really like the new s390-only method, but short
> of forcing the dasd driver to be built into the kernel I can't think of
> anything better.  But maybe the s390 maintainers are fine with forcing
> the DASD driver to be built in, in which case we could go down that
> route?
