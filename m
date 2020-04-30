Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62618 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728927AbgD3ODh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Apr 2020 10:03:37 -0400
Subject: Re: [PATCH 1/1] s390/dasd: remove ioctl_by_bdev from DASD driver
References: <20200430111754.98508-1-sth@linux.ibm.com>
 <20200430111754.98508-2-sth@linux.ibm.com> <20200430131351.GA24813@lst.de>
From: Stefan Haberland <sth@linux.ibm.com>
Message-ID: <4ab11558-9f2b-02ee-d191-c9a5cc38de0f@linux.ibm.com>
Date: Thu, 30 Apr 2020 16:02:52 +0200
MIME-Version: 1.0
In-Reply-To: <20200430131351.GA24813@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, linux-kernel@vger.kernel.org

Am 30.04.20 um 15:13 schrieb Christoph Hellwig:
> On Thu, Apr 30, 2020 at 01:17:54PM +0200, Stefan Haberland wrote:
>> Remove the calls to ioctl_by_bdev from the DASD partition detection code
>> to enable the removal of the specific code.
>>
>> To do so reuse the gendisk private_data pointer and not only provide a
>> pointer to the devmap but provide a new structure containing a pointer
>> to the devmap as well as all required information for the partition
>> detection. This makes it independent from the dasd_information2_t
>> structure.
> I think sharing the data structure in private data is pretty dangerous.

Thought of this as well. This is why I check for the major number before I
use the private pointer to reference the data structure. Thought this would
be enough checking.
Do you think this is not sufficient?

> In the meantime I thought of another idea - the partition code could
> do a symbol_get of a symbol exported by the dasd driver and use that
> to query the information.

Then I would need to export a lot of DASD internal structures to be
available
in thepartition detection code if I would like to walk down our device
map to
findthe corresponding device for example. Not sure if this is that easy.
