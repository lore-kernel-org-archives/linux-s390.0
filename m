Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfFZObr (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 26 Jun 2019 10:31:47 -0400
Subject: Re: [PATCH v5 2/2] s390/kvm: diagnose 318 handling
References: <1561475022-18348-1-git-send-email-walling@linux.ibm.com>
 <1561475022-18348-3-git-send-email-walling@linux.ibm.com>
 <19c73246-48dd-ddc6-c5b1-b93f15cbf2f0@redhat.com>
 <17fe3423-91b1-2351-54cb-26cd9e1b0e3f@de.ibm.com>
 <dd1f4c39-9937-b223-adc8-01a764cf9462@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a7f4b3aa-b9d8-59b3-22c4-251acc2ef20f@redhat.com>
Date: Wed, 26 Jun 2019 16:31:45 +0200
MIME-Version: 1.0
In-Reply-To: <dd1f4c39-9937-b223-adc8-01a764cf9462@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Collin Walling <walling@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, cohuck@redhat.com, pbonzini@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org

On 26.06.19 16:30, Collin Walling wrote:
> On 6/26/19 6:28 AM, Christian Borntraeger wrote:
>>
>>
>> On 26.06.19 11:45, David Hildenbrand wrote:
>>
>>>
>>> BTW. there is currently no mechanism to fake absence of diag318. Should
>>> we have one? (in contrast, for CMMA we have, which is also a CPU feature)
>>
>> Yes, we want to be able to disable diag318 via a CPU model feature. That actually
>> means that the kernel must not answer this if we disable it.
>>
> Correct. If the guest specifies diag318=off, then the instruction 
> shouldn't be executed (it is fenced off in the kernel by checking the 
> Read SCP Info bit).

But the guest *could* execute it and not get an exception.

-- 

Thanks,

David / dhildenb
