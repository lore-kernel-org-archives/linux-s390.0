Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31472 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728276AbgBKK2U (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 11 Feb 2020 05:28:20 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01BAK6Vl021849
        for <linux-s390@vger.kernel.org>; Tue, 11 Feb 2020 05:28:19 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1u56uepn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 11 Feb 2020 05:28:17 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 11 Feb 2020 10:21:25 -0000
Subject: Re: [PATCH 1/1] cio_ignore_proc_seq_next should increase position
 index
References: <d44c53a7-9bc1-15c7-6d4a-0c10cb9dffce@virtuozzo.com>
 <51ac7c33-ea7d-d780-c9de-4858af5e5f18@de.ibm.com>
 <2d65a0ec-2d41-9efa-b2fb-1d6a93aa4800@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 11 Feb 2020 11:21:22 +0100
MIME-Version: 1.0
In-Reply-To: <2d65a0ec-2d41-9efa-b2fb-1d6a93aa4800@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <6bebbac1-79f5-9772-8c06-b6d92e40a46a@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Peter Oberparleiter <oberpar@linux.ibm.com>, Vasily Averin <vvs@virtuozzo.com>, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>



On 11.02.20 11:19, Peter Oberparleiter wrote:
[...]
>> but this code is still fishy:
>>
>> $ cat /proc/cio_ignore 
>> 0.0.fe00-0.0.fefe
>> 0.0.ff00-0.0.ffff
>> $ dd if=/proc/cio_ignore status=none
>> 0.0.fe00-0.0.fefe
>> 0.0.ff00-0.0.ffff
>> $ dd if=/proc/cio_ignore status=none bs=10
>> 0.0.fe00-0.0.fefe
>> 0.0.ff00-0.0.ff01-0.0.ff02-0.0.ff03-0.0.ff04-0.0.ff05-0.0.ff06-0.0.ff07-0.0.ff08-0.0.ffff
>> $ dd if=/proc/cio_ignore status=none bs=10 skip=1
>> .0.fefe
>> 0.0.ff00-0.0.ff01-0.0.ff02-0.0.ff03-0.0.ff04-0.0.ff05-0.0.ff06-0.0.ff07-0.0.ff08-0.0.ffff
>>
>>
>> Peter, any opinions on this?
> 
> A correct implementation of a file read operation must result in the
> same data being read independently of whether the file is read in one
> go, or if it is read byte-by-byte.
> 
> It seems that the current cio_ignore seq-file implementation doesn't
> meet that requirement. I don't think that this patch series is the best
> way to address this problem though.
> 
> My suggestion would be to apply this patch set as is, and then I'll take
> the to-do to fix this seq file implementation at a later time.

Ok, I will will Vasily patch. 
