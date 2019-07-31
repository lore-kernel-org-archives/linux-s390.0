Return-Path: <linux-kselftest-owner@vger.kernel.org>
Subject: Re: [PATCH 2/2] KVM: selftests: Enable dirty_log_test on s390x
References: <20190730100112.18205-1-thuth@redhat.com>
 <20190730100112.18205-3-thuth@redhat.com>
 <d48ac43b-c960-54af-a145-360a67b4a3d9@de.ibm.com>
 <02c5c7b4-c45e-4573-d2c3-ebfa2cd2c9d1@redhat.com>
 <341c3705-c2cb-9e87-cc03-42e0cefba308@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <03e7f73e-2b21-688b-83c6-c10eaafdebd5@redhat.com>
Date: Wed, 31 Jul 2019 13:06:03 +0200
MIME-Version: 1.0
In-Reply-To: <341c3705-c2cb-9e87-cc03-42e0cefba308@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>

On 30.07.19 20:04, Christian Borntraeger wrote:
> 
> 
> On 30.07.19 19:11, Thomas Huth wrote:
>> On 30/07/2019 16.57, Christian Borntraeger wrote:
>>>
>>>
>>> On 30.07.19 12:01, Thomas Huth wrote:
>>>> To run the dirty_log_test on s390x, we have to make sure that we
>>>> access the dirty log bitmap with little endian byte ordering and
>>>> we have to properly align the memslot of the guest.
>>>> Also all dirty bits of a segment are set once on s390x when one
>>>> of the pages of a segment are written to for the first time, so
>>>> we have to make sure that we touch all pages during the first
>>>> iteration to keep the test in sync here.
>>>
>>> While this fixes the test (and the migration does work fine), it still
>>> means that s390x overindicates the dirty bit for sparsely populated
>>> 1M segments. It is just a performance issue, but maybe we should try 
>>> to get this fixed.
>>
>> I hope you don't expect me to fix this - the gmap code is really not my
>> turf...
> 
> No, this is clearly on our turf. 

FWIW, we share the pagetables with the userspace process. We mark a page
as dirty (PGSTE_UC_BIT) when
- We modify the storage key
- We map a PTE as RW (pgste_set_pte())

I assume all PTEs of the segment are mapped RW (for example, if user
space wrote to such a PTE), that is why we have the PGSTE_UC_BIT bit set.

As PGSTE_UC_BIT also tracks what userspace did, not only KVM via the
GMAP, this might indeed be correct.

-- 

Thanks,

David / dhildenb
