Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34252 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726513AbgEOHL7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 May 2020 03:11:59 -0400
Subject: Re: [kvm-unit-tests PATCH v6 07/10] s390x: css: msch, enable test
References: <1587725152-25569-1-git-send-email-pmorel@linux.ibm.com>
 <1587725152-25569-8-git-send-email-pmorel@linux.ibm.com>
 <cff917e0-f7e0-fd48-eda5-0cbe8173ae8a@linux.ibm.com>
 <abafd691-d9ab-33b2-c522-d37fecc3e881@linux.ibm.com>
 <20200514140808.269f6485.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <de18eab3-4d0a-1b86-f6c4-27aaa7bba6bf@linux.ibm.com>
Date: Fri, 15 May 2020 09:11:52 +0200
MIME-Version: 1.0
In-Reply-To: <20200514140808.269f6485.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com



On 2020-05-14 14:08, Cornelia Huck wrote:
> On Tue, 28 Apr 2020 10:27:36 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> On 2020-04-27 15:11, Janosch Frank wrote:
>>> On 4/24/20 12:45 PM, Pierre Morel wrote:
> 
>>>> This is NOT a routine to really enable the channel, no retry is done,
>>>> in case of error, a report is made.
>>>
>>> Would we expect needing retries for the pong device?
>>
>> Yes it can be that we need to retry some instructions if we want them to
>> succeed.
>> This is the case for example if we develop a driver for an operating system.
>> When working with firmware, sometime, things do not work at the first
>> time. Mostly due to races in silicium, firmware or hypervisor or between
>> them all.
>>
>> Since our purpose is to detect such problems we do not retry
>> instructions but report the error.
>>
>> If we detect such problem we may in the future enhance the tests.
> 
> I think I've seen retries needed on z/VM in the past; do you know if
> that still happens?
> 

I did not try the tests under z/VM, nor direct on an LPAR, only under 
QEMU/KVM.
Under QEMU/KVM, I did not encounter any need for retry, 100% of the 
enabled succeeded on first try.

Regards,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
