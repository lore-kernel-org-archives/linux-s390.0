Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49600 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729619AbgBMInl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 13 Feb 2020 03:43:41 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01D8Z1fT017589
        for <linux-s390@vger.kernel.org>; Thu, 13 Feb 2020 03:43:39 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y4qysmyxh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 13 Feb 2020 03:43:39 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 13 Feb 2020 08:43:37 -0000
Subject: Re: [PATCH/RFC] KVM: s390: protvirt: pass-through rc and rrc
References: <62d5cd46-93d7-e272-f9bb-d4ec3c7a1f71@de.ibm.com>
 <20200210114526.134769-1-borntraeger@de.ibm.com>
 <a94f3d09-1474-29d2-a2d3-3118170e494e@de.ibm.com>
 <20200210135040.24f06b8e.cohuck@redhat.com>
 <b99afb71-c8cb-0608-6583-99ac482f8322@de.ibm.com>
 <b1cef696-d5c6-a5f2-0635-99d8bc52fc7f@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 13 Feb 2020 09:43:31 +0100
MIME-Version: 1.0
In-Reply-To: <b1cef696-d5c6-a5f2-0635-99d8bc52fc7f@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <c54e2005-533f-a64d-a347-f4deb213d151@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: thuth@redhat.com, Ulrich.Weigand@de.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, mimu@linux.ibm.com

On 11.02.20 09:48, Janosch Frank wrote:
> On 2/10/20 1:56 PM, Christian Borntraeger wrote:
>>
>>
>> On 10.02.20 13:50, Cornelia Huck wrote:
>>> On Mon, 10 Feb 2020 13:06:19 +0100
>>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>>
>>>> What about the following. I will rip out RC and RRC but add 
>>>> a 32bit flags field (which must be 0) and 3*64 bit reserved.
>>>
>>> Probably dumb question: How are these new fields supposed to be used?
>>
>> This was planned for error handling in QEMU. As we have no user of rc/rrc
>> yet, I have ripped that out and added a flag field + 16 bytes of reserved.
>> Usage is as usual flags must be 0. When flags!=0 the reserved fields will
>> have a new meaning. 
>>
> 
> I want to have the rcs because right now we would only output the return
> value of the ioctl and most UV error codes are mapped to -EINVAL. So if
> an error occurs, admins would need to match up the crashed VM with the
> UV debugfs files which might not even exist if debugfs is not mounted...
> 
> That's also one of the reasons I like having separate create calls for
> VM and VCPUs.

Janosch convinced me that we need rc and rrc for some calls. For example
the set secure configuration parameter passes along the header from the
guest image to the hardware. There are now different errors possible,
for example wrong key, wrong list of requirements etc. Userspace needs 
to know that to provide proper error messages.

I will try to build something as clean as possible.
