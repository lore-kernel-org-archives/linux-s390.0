Return-Path: <linux-kernel-owner@vger.kernel.org>
References: <20200430111754.98508-1-sth@linux.ibm.com>
 <20200430111754.98508-2-sth@linux.ibm.com> <20200430131351.GA24813@lst.de>
 <4ab11558-9f2b-02ee-d191-c9a5cc38de0f@linux.ibm.com>
 <70f541fe-a678-8952-0753-32707d21e337@linux.ibm.com>
 <20200505124423.GA26313@lst.de>
 <a6c99eba-44f2-2944-a135-50ed75ef2c55@linux.ibm.com>
 <20200506045258.GB9846@lst.de>
 <10918cd1-a4a9-7872-9672-efcd28ef0751@linux.ibm.com>
 <20200507152906.GA31257@lst.de>
From: Stefan Haberland <sth@linux.ibm.com>
Subject: Re: [PATCH 1/1] s390/dasd: remove ioctl_by_bdev from DASD driver
Message-ID: <35ee027b-7892-23ab-c31d-7c17750da8f4@linux.ibm.com>
Date: Thu, 7 May 2020 17:43:40 +0200
MIME-Version: 1.0
In-Reply-To: <20200507152906.GA31257@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, linux-kernel@vger.kernel.org, Peter Oberparleiter <oberpar@linux.ibm.com>

Am 07.05.20 um 17:29 schrieb Christoph Hellwig:
> On Thu, May 07, 2020 at 05:22:28PM +0200, Stefan Haberland wrote:
>> OK, just thought again about your suggestion and also that
>> you have already been talking about a symbol lookup I just
>> have written a prototype that took your first two patches
>> as base, exports the symbol of dasd_biodasdinfo and in
>> ibm.c I do a kallsyms_lookup_name("dasd_biodasdinfo").
>>
>> So I would not have to define a structure twice or rely on
>> MAJORs. Also we would not have to define an own file
>> operation only for DASD devices.
>>
>> What do you think about this? If you agree I will polish
>> the patches, test them and send them for review.
> How do you figure out a given gendisk is a DASD device?  I guess
> dasd_biodasdinfo could just check the block_device_operations
> pointer first thing.  That's still a little ugly, but seems the
> least bad idea so far, so please at least post it for discussion.

Not checked till now. I just was thinking about the basicapproach.

I could either check the block_device_operations like you suggested
or I could verify that the gendisk pointer is already in our devmap
and therefor belongs to the DASD driver.

Will post a patch shortly.
