Return-Path: <linux-kselftest-owner@vger.kernel.org>
Subject: Re: [PATCH v1 0/9] KVM selftests for s390x
References: <20190523164309.13345-1-thuth@redhat.com>
 <0ad63449-c329-f38d-b879-6e427e6a8656@de.ibm.com>
 <e6f953be-00af-756e-4c0a-649294efbd91@de.ibm.com>
 <411d4ad9-b43e-d3ae-1b66-65888c894caa@de.ibm.com>
 <e2f1f36b-51b6-30f3-cee5-950b72b6fa67@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 24 May 2019 14:56:37 +0200
MIME-Version: 1.0
In-Reply-To: <e2f1f36b-51b6-30f3-cee5-950b72b6fa67@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f25b27c1-f682-b3f3-1fa8-492a2ef189eb@de.ibm.com>
Sender: linux-kselftest-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Shuah Khan <shuah@kernel.org>, Cornelia Huck <cohuck@redhat.com>, Andrew Jones <drjones@redhat.com>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org



On 24.05.19 14:36, David Hildenbrand wrote:
> On 24.05.19 14:29, Christian Borntraeger wrote:
>>
>>
>> On 24.05.19 14:17, Christian Borntraeger wrote:
>>>
>>>
>>> On 24.05.19 13:11, Christian Borntraeger wrote:
>>>> I do get
>>>>
>>>> [10400.440298] kvm-s390: failed to commit memory region
>>>> [10400.508723] kvm-s390: failed to commit memory region
>>>>
>>>> when running the tests. Will have a look.
>>>
>>> It comes from kvm_vm_free. This calls KVM_SET_USER_MEMORY_REGION with size 0,
>>> which the s390 code does not like.
>>>
>>
>> The doc says about  KVM_SET_USER_MEMORY_REGION:
>>
>> This ioctl allows the user to create or modify a guest physical memory
>> slot.  When changing an existing slot, it may be moved in the guest
>> physical memory space, or its flags may be modified.  --> It may not be
>> resized. <----
> 
> Size 0 is deleting, not resizing AFAIK.

Right this seems to translate to KVM_MR_DELETE, which the s390 code does not handle (we
will simply deliver a page fault as we share the last page table level). 
I will have a look at implementing KVM_MR_DELETE and KVM_MR_MOVE. In fact, we should
have a testcase for that as well.
