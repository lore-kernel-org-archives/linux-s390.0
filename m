Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26032 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726171AbgKYIwF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 25 Nov 2020 03:52:05 -0500
Subject: Re: [PATCH 4/4] s390/uaccess: remove set_fs() interface
References: <20200915154340.4215-1-hca@linux.ibm.com>
 <20200915154340.4215-5-hca@linux.ibm.com> <20200915160243.GB22056@lst.de>
 <20200915193755.GA8528@osiris> <20200916123603.GC7076@osiris>
 <20201125083808.GB31753@lst.de>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <72753cc5-e9a9-05c5-c465-6dff9fcf679d@de.ibm.com>
Date: Wed, 25 Nov 2020 09:51:47 +0100
In-Reply-To: <20201125083808.GB31753@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, linux-s390@vger.kernel.org



On 25.11.20 09:38, Christoph Hellwig wrote:
> On Wed, Sep 16, 2020 at 02:36:03PM +0200, Heiko Carstens wrote:
>> So, I can think of several ways to fix this (or better: make this
>> robust). However given that I will be away the next two weeks this is
>> not going to happen for the upcoming merge window. I really don't want
>> to rush this, since this has potential for severe subtle bugs... like
>> we had them already several times with our address space and dynamic
>> page table upgrade handling in the past (and like I nearly introduced
>> at least one bug with this patch).
>>
>> Therefore the first three patches of this series are scheduled for the
>> upcoming merge window, while the final set_fs() removal should come
>> one merge later.
> 
> Did you manage to get back to the s390 set_fs removal?
> 

Heiko has queued the following:

https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=features&id=87d5986345219a7e4f204726d9085ea87f3e22d0
