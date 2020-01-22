Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58967 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728811AbgAVMQ2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 22 Jan 2020 07:16:28 -0500
Subject: Re: [kvm-unit-tests PATCH v8 6/6] s390x: SCLP unit test
References: <20200120184256.188698-1-imbrenda@linux.ibm.com>
 <20200120184256.188698-7-imbrenda@linux.ibm.com>
 <35e59971-c09e-2808-1be6-f2ccd555c4f6@redhat.com>
 <42c5b040-733d-4e5b-0276-5b94315336bb@redhat.com>
 <e406268e-7881-f5c3-7b28-70e355765539@redhat.com>
 <997a62b7-7ab7-6119-4948-e8779e639101@redhat.com>
 <4d09b567-c2ae-ec9d-59d0-bd259a86b14d@redhat.com>
 <946e1194-4607-c928-6d66-9e306dc1216a@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d467e614-621b-aca7-4255-dfe5707b5dd7@redhat.com>
Date: Wed, 22 Jan 2020 13:16:18 +0100
MIME-Version: 1.0
In-Reply-To: <946e1194-4607-c928-6d66-9e306dc1216a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Andrew Jones <drjones@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com

On 22/01/2020 11.40, David Hildenbrand wrote:
> On 22.01.20 11:39, Thomas Huth wrote:
>> On 22/01/2020 11.32, David Hildenbrand wrote:
>>> On 22.01.20 11:31, Thomas Huth wrote:
>>>> On 22/01/2020 11.22, David Hildenbrand wrote:
>>>>> On 22.01.20 11:10, David Hildenbrand wrote:
[...]
>>>>>> Doing a fresh ./configure + make on RHEL7 gives me
>>>>>>
>>>>>> [linux1@rhkvm01 kvm-unit-tests]$ make
>>>>>> gcc  -std=gnu99 -ffreestanding -I /home/linux1/git/kvm-unit-tests/lib -I /home/linux1/git/kvm-unit-tests/lib/s390x -I lib -O2 -march=zEC12 -fno-delete-null-pointer-checks -g -MMD -MF s390x/.sclp.d -Wall -Wwrite-strings -Wempty-body -Wuninitialized -Wignored-qualifiers -Werror  -fomit-frame-pointer    -Wno-frame-address   -fno-pic    -Wclobbered  -Wunused-but-set-parameter  -Wmissing-parameter-type  -Wold-style-declaration -Woverride-init -Wmissing-prototypes -Wstrict-prototypes   -c -o s390x/sclp.o s390x/sclp.c
>>>>>> s390x/sclp.c: In function 'test_one_simple':
>>>>>> s390x/sclp.c:121:2: error: dereferencing type-punned pointer will break strict-aliasing rules [-Werror=strict-aliasing]
>>>>>>   ((SCCBHeader *)sccb_template)->length = sccb_len;
>>>>>>   ^
>>>>>> s390x/sclp.c: At top level:
>>>>>> cc1: error: unrecognized command line option "-Wno-frame-address" [-Werror]
>>>>>> cc1: all warnings being treated as errors
>>>>>> make: *** [s390x/sclp.o] Error 1
>>>>>
>>>>> The following makes it work:
>>>>>
>>>>>
>>>>> diff --git a/s390x/sclp.c b/s390x/sclp.c
>>>>> index c13fa60..0b8117a 100644
>>>>> --- a/s390x/sclp.c
>>>>> +++ b/s390x/sclp.c
>>>>> @@ -117,8 +117,10 @@ static bool test_one_ro(uint32_t cmd, uint8_t *addr, uint64_t exp_pgm, uint16_t
>>>>>  static bool test_one_simple(uint32_t cmd, uint8_t *addr, uint16_t sccb_len,
>>>>>                         uint16_t buf_len, uint64_t exp_pgm, uint16_t exp_rc)
>>>>>  {
>>>>> +       SCCBHeader *header = (void *)sccb_template;
>>>>> +
>>>>>         memset(sccb_template, 0, sizeof(sccb_template));
>>>>> -       ((SCCBHeader *)sccb_template)->length = sccb_len;
>>>>> +       header->length = sccb_len;
>>>>
>>>> While that might silence the compiler warning, we still might get
>>>> aliasing problems here, I think.
>>>> The right way to solve this problem is to turn sccb_template into a
>>>> union of the various structs/arrays that you want to use and then access
>>>> the fields through the union instead ("type-punning through union").
>>>
>>> We do have the exact same thing in lib/s390x/sclp.c already, no?
>>
>> Maybe we should carefully check that code, too...
>>
>>> Especially, new compilers don't seem to care?
>>
>> I've seen horrible bugs due to these aliasing problems in the past -
>> without compiler warnings showing up! Certain versions of GCC assume
>> that they can re-order code with pointers that point to types of
>> different sizes, i.e. in the above example, I think they could assume
>> that they could re-order the memset() and the header->length = ... line.
>> I'd feel better if we play safe and use a union here.
> 
> Should we simply allow type-punning?

Maybe yes. The kernel also compiles with "-fno-strict-aliasing", and
since kvm-unit-tests is mainly a "playground" for people who do kernel
development, too, we should maybe also compile the unit tests with
"-fno-strict-aliasing".

Paolo, Andrew, Laurent, what do you think?

 Thomas
