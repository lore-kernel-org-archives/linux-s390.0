Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26900 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726351AbgEDIpo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 May 2020 04:45:44 -0400
From: Stefan Haberland <sth@linux.ibm.com>
References: <20200430111754.98508-1-sth@linux.ibm.com>
 <20200430111754.98508-2-sth@linux.ibm.com> <20200430131351.GA24813@lst.de>
 <4ab11558-9f2b-02ee-d191-c9a5cc38de0f@linux.ibm.com>
Subject: Re: [PATCH 1/1] s390/dasd: remove ioctl_by_bdev from DASD driver
Message-ID: <70f541fe-a678-8952-0753-32707d21e337@linux.ibm.com>
Date: Mon, 4 May 2020 10:45:33 +0200
MIME-Version: 1.0
In-Reply-To: <4ab11558-9f2b-02ee-d191-c9a5cc38de0f@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, linux-kernel@vger.kernel.org, Peter Oberparleiter <oberpar@linux.ibm.com>

Am 30.04.20 um 16:02 schrieb Stefan Haberland:
> Am 30.04.20 um 15:13 schrieb Christoph Hellwig:
>> On Thu, Apr 30, 2020 at 01:17:54PM +0200, Stefan Haberland wrote:
>>> Remove the calls to ioctl_by_bdev from the DASD partition detection code
>>> to enable the removal of the specific code.
>>>
>>> To do so reuse the gendisk private_data pointer and not only provide a
>>> pointer to the devmap but provide a new structure containing a pointer
>>> to the devmap as well as all required information for the partition
>>> detection. This makes it independent from the dasd_information2_t
>>> structure.
>> I think sharing the data structure in private data is pretty dangerous.
> Thought of this as well. This is why I check for the major number before I
> use the private pointer to reference the data structure. Thought this would
> be enough checking.
> Do you think this is not sufficient?
>
>> In the meantime I thought of another idea - the partition code could
>> do a symbol_get of a symbol exported by the dasd driver and use that
>> to query the information.
> Then I would need to export a lot of DASD internal structures to be
> available
> in thepartition detection code if I would like to walk down our device
> map to
> findthe corresponding device for example. Not sure if this is that easy.

I did some additional research on this.
What I could imagine:

The gendisk->private_data pointer currently contains a pointer to
the dasd_devmap structure. This one is also reachable by iterating
over an exported dasd_hashlist.
So I could export the dasd_hashlist symbol, iterate over it and try
to find the dasd_devmap pointer I have from the gendisk->private_data
pointer.
This would ensure that the gendisk belongs to the DASD driver and I
could use the additional information that is somehow reachable through
the gendisk->private_data pointer.

But again, I am not sure if this additional code and effort is needed.
From my point of view checking the gendisk->major for DASD_MAJOR is
OK to ensure that the device belongs to the DASD driver.

What do you think?
