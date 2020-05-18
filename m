Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41284 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726489AbgERINT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 May 2020 04:13:19 -0400
Subject: Re: [PATCH v3 3/3] s390/dasd: remove ioctl_by_bdev calls
References: <20200508131455.55407-1-sth@linux.ibm.com>
 <20200508131455.55407-4-sth@linux.ibm.com> <20200508155342.GC4200@lst.de>
 <6cd6788e-ce3d-7869-307a-9a6723f6eb79@linux.ibm.com>
 <20200516154344.GA16828@lst.de>
From: Stefan Haberland <sth@linux.ibm.com>
Message-ID: <f6e9e3ba-4dac-8a44-456b-0c759f1e0ca4@linux.ibm.com>
Date: Mon, 18 May 2020 10:13:09 +0200
MIME-Version: 1.0
In-Reply-To: <20200516154344.GA16828@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, linux-kernel@vger.kernel.org, borntraeger@de.ibm.com

Am 16.05.20 um 17:43 schrieb Christoph Hellwig:
> On Mon, May 11, 2020 at 06:30:44PM +0200, Stefan Haberland wrote:
>> Am 08.05.20 um 17:53 schrieb Christoph Hellwig:
>>> I think this should use symbol_get instead.
>> Thanks for the Feedback, also for the previous patch.
>> I will incorporate it, run some test cycles and submit the patches
>> again when I am ready.
> Did you manage to get back to this?

Hi, yes. We had some internal discussions about the patch and I am running
some tests.
I need to have a look at virtblk devices with DASD layout and afterwards
I will send the patches again.
