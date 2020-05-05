Return-Path: <linux-kernel-owner@vger.kernel.org>
References: <20200430111754.98508-1-sth@linux.ibm.com>
 <20200430111754.98508-2-sth@linux.ibm.com> <20200430131351.GA24813@lst.de>
 <4ab11558-9f2b-02ee-d191-c9a5cc38de0f@linux.ibm.com>
 <70f541fe-a678-8952-0753-32707d21e337@linux.ibm.com>
 <20200505124423.GA26313@lst.de>
From: Stefan Haberland <sth@linux.ibm.com>
Subject: Re: [PATCH 1/1] s390/dasd: remove ioctl_by_bdev from DASD driver
Message-ID: <a6c99eba-44f2-2944-a135-50ed75ef2c55@linux.ibm.com>
Date: Tue, 5 May 2020 17:09:56 +0200
MIME-Version: 1.0
In-Reply-To: <20200505124423.GA26313@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, linux-kernel@vger.kernel.org, Peter Oberparleiter <oberpar@linux.ibm.com>

Am 05.05.20 um 14:44 schrieb Christoph Hellwig:
> On Mon, May 04, 2020 at 10:45:33AM +0200, Stefan Haberland wrote:
>>> findthe corresponding device for example. Not sure if this is that easy.
>> I did some additional research on this.
>> What I could imagine:
>>
>> The gendisk->private_data pointer currently contains a pointer to
>> the dasd_devmap structure. This one is also reachable by iterating
>> over an exported dasd_hashlist.
>> So I could export the dasd_hashlist symbol, iterate over it and try
>> to find the dasd_devmap pointer I have from the gendisk->private_data
>> pointer.
>> This would ensure that the gendisk belongs to the DASD driver and I
>> could use the additional information that is somehow reachable through
>> the gendisk->private_data pointer.
>>
>> But again, I am not sure if this additional code and effort is needed.
>> From my point of view checking the gendisk->major for DASD_MAJOR is
>> OK to ensure that the device belongs to the DASD driver.
> With CONFIG_DEBUG_BLOCK_EXT_DEVT you can't rely on major numbers.

OK, thanks for the hint.I did not have this in mind. And I still have
to look up how this is working at all.
But isn't this only a real issue for devices with more than 16 minors
or partitions? So it should not be a problem for DASDs with our limit
of 3 partitions and the fixed amount of minors, right?

Just tested with CONFIG_DEBUG_BLOCK_EXT_DEVT enabled and about 1000
unlabeled devices. Did not see an issue.

While I see the SCSI devices with MAJOR 259 and quite a random MINOR
all the DASD devices keep their MAJOR 94 and ascending MINOR.

>
> And compared to all the complications I think the biodasdinfo method
> is the least of all those evils.

Are you talking about your first patch suggestion?Then I disagree.
I still do not like to force the driver to be built in if there is an
alternative.

If the major number is an issue also for DASD device than I prefer
to implement the devmap lookup to ensure that the device belongs to
the DASD driver.

But I am open to alternatives as well.

Side note: I am planning to deprecate the implicit DASD partition for
unlabeled devices so we might get rid of this stuff at all at some point
in time. We just have to discuss how this might be done properly.


> Jens, any opinion?
