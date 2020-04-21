Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31546 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728337AbgDUKnN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Apr 2020 06:43:13 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03LAZPij035221
        for <linux-s390@vger.kernel.org>; Tue, 21 Apr 2020 06:43:12 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30gcs48ewe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 21 Apr 2020 06:43:11 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 21 Apr 2020 11:42:46 +0100
Subject: Re: stop using ioctl_by_bdev in the s390 DASD driver
References: <20200421061226.33731-1-hch@lst.de>
 <b7e4a728-1f58-f304-cb5b-1aa2206a6bb4@de.ibm.com>
 <20200421123256.2f5d9dbd.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 21 Apr 2020 12:43:03 +0200
MIME-Version: 1.0
In-Reply-To: <20200421123256.2f5d9dbd.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <427b0095-6a38-5632-8e46-422c7a4a552a@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org



On 21.04.20 12:32, Cornelia Huck wrote:
> On Tue, 21 Apr 2020 11:58:31 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> On 21.04.20 08:12, Christoph Hellwig wrote:
>>> Hi Jens and DASD maintainers,
>>>
>>> can you take a look at this series, which stops the DASD driver from
>>> issuing ioctls from kernel space, in preparation of removing
>>> ioctl_by_bdev.  I don't really like the new s390-only method, but short
>>> of forcing the dasd driver to be built into the kernel I can't think of
>>> anything better.  But maybe the s390 maintainers are fine with forcing
>>> the DASD driver to be built in, in which case we could go down that
>>> route?  
>>
>> Hmm the defconfig results in dasd built-in anyway. But distros really like
>> to keep it modular.
>>
>> Hmm, we do have
>>
>> obj-$(CONFIG_DASD) += dasd_mod.o
>> obj-$(CONFIG_DASD_DIAG) += dasd_diag_mod.o
>> obj-$(CONFIG_DASD_ECKD) += dasd_eckd_mod.o
>> obj-$(CONFIG_DASD_FBA)  += dasd_fba_mod.o
>>
>> Would it work to make CONFIG_DASD built-in only and keep the other 3 as modules?
>> Not sure about the implications. 
>>
> 
> I don't think non-eckd dasd drivers are really useful outside of z/VM
> guests, so keeping at least the disciplines modular would be good.
> 
> Also, what about special purpose environments like the zfcp dumper?
> Would be good to be able to keep these small.
> 
> How big is the dasd code in the end?


  File: drivers/s390/block/dasd_diag_mod.ko
  Size: 519976    	Blocks: 1016       IO Block: 4096   regular file
--
  File: drivers/s390/block/dasd_eckd_mod.ko
  Size: 2125976   	Blocks: 4160       IO Block: 4096   regular file
--
  File: drivers/s390/block/dasd_fba_mod.ko
  Size: 524256    	Blocks: 1024       IO Block: 4096   regular file
--
  File: drivers/s390/block/dasd_mod.ko
  Size: 3273464   	Blocks: 6400       IO Block: 4096   regular file


So 3 MB seems quite a lot for special purpose Linuxes like the zfcp dumper. 
