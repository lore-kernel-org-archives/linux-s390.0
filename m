Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60670 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728032AbgBLLtZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Feb 2020 06:49:25 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01CBi9kB137530
        for <linux-s390@vger.kernel.org>; Wed, 12 Feb 2020 06:49:23 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1u1mf98v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 12 Feb 2020 06:49:23 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 12 Feb 2020 11:49:21 -0000
Subject: Re: [PATCH 35/35] DOCUMENTATION: Protected virtual machine
 introduction and IPL
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-36-borntraeger@de.ibm.com>
 <5d8050a6-c730-4325-2d46-2b5c9cdc8408@redhat.com>
 <a2e5f248-4d4d-5650-6f48-174bddd328f9@de.ibm.com>
 <20200212120357.205e9ede.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 12 Feb 2020 12:49:17 +0100
MIME-Version: 1.0
In-Reply-To: <20200212120357.205e9ede.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <0d7e4249-e0cb-b619-a999-941b2ad3e6cd@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>



On 12.02.20 12:03, Cornelia Huck wrote:
> On Tue, 11 Feb 2020 21:03:17 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> On 11.02.20 13:23, Thomas Huth wrote:
>>> On 07/02/2020 12.39, Christian Borntraeger wrote:  
>>>> +The switch into PV mode lets us load encrypted guest executables and  
>>>
>>> Maybe rather: "After the switch into PV mode, the guest can load ..." ?  
>>
>> No its not after the switch. By doing the switch the guest image can be loaded
>> fro anywhere because it is just like a kernel.
>>
>> So I will do:
>>
>> As the guest image is just like an opaque kernel image that does the
>> switch into PV mode itself, the user can load encrypted guest
>> executables and data via every available method (network, dasd, scsi,
>> direct kernel, ...) without the need to change the boot process.
> 
> Sounds good to me.
> 
> (...)
> 
>>>> +All non-decrypted data of the guest before it switches to protected
>>>> +virtualization mode are zero on first access of the PV.  
>>>
>>> Before it switches to protected virtualization mode, all non-decrypted
>>> data of the guest are ... ?  
>>
>> No, this is about the data after the initial import.
>> What about
>>
>> After the initial import of the encrypted data all defined pages will
> 
> s/data/data,/

ack.
> 
>> contain the guest content. All non-specified pages will start out as
>> zero pages on first access.
> 
> Also sounds good to me.
> 
> (...)
> 
