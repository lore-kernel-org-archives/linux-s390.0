Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52077 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726808AbfK2Osz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 29 Nov 2019 09:48:55 -0500
Subject: Re: [PATCH] KVM: s390: Add new reset vcpu API
References: <20191129142122.21528-1-frankja@linux.ibm.com>
 <bc1d057f-03a0-b850-dff8-a7156bfe3274@redhat.com>
 <8e1aa1af-d929-e36b-f341-aa7dbe27f6a4@linux.ibm.com>
 <227a8fce-7e14-030e-b0a4-17e4521eed98@redhat.com>
 <dedd1d55-bebb-059e-c8c9-7c2771afa157@linux.ibm.com>
 <708d16c2-fa18-8ab9-afb5-44b5af638cb4@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <487af903-bb8c-a7c5-b81d-dc0ce1bb7b75@redhat.com>
Date: Fri, 29 Nov 2019 15:48:41 +0100
MIME-Version: 1.0
In-Reply-To: <708d16c2-fa18-8ab9-afb5-44b5af638cb4@de.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, mihajlov@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On 29.11.19 15:39, Christian Borntraeger wrote:
> 
> 
> On 29.11.19 15:38, Janosch Frank wrote:
> [...]
>>>>> As we now have two interfaces to achieve the same thing (initial reset),
>>>>> I do wonder if we should simply introduce
>>>>>
>>>>> KVM_S390_NORMAL_RESET
>>>>> KVM_S390_CLEAR_RESET
>>>>>
>>>>> instead ...
>>>>>
>>>>> Then you can do KVM_S390_NORMAL_RESET for the bugfix and
>>>>> KVM_S390_CLEAR_RESET later for PV.
>>>>>
>>>>> Does anything speak against that?
>>>>
>>>> Apart from loosing one more ioctl number probably not
>>>
>>> Do we care? (I think not, but maybe I am missing something :) )
>>>
>>
>> I don't, maybe somebody else does
>> Btw. I'm struggling to find a good name for the capability:
>> KVM_CAP_S390_VCPU_ADDITIONAL_RESETS ?
> 
> KVM_CAP_S390_VCPU_RESETS ?

Either that or two separate ones if you're not going to introduce them
at the same time ...

-- 
Thanks,

David / dhildenb
