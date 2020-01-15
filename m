Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44391 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726100AbgAOILc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 15 Jan 2020 03:11:32 -0500
Subject: Re: [kvm-unit-tests PATCH 3/4] s390x: smp: Test all CRs on initial
 reset
References: <20200114153054.77082-1-frankja@linux.ibm.com>
 <20200114153054.77082-4-frankja@linux.ibm.com>
 <2f190b0a-e403-51e6-27da-7f8f1f6289ac@de.ibm.com>
 <f120ad03-aab1-a863-636b-b11898d634f5@redhat.com>
 <3ee92240-56dc-69af-4fca-a4a2156e7749@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <eb8bc589-9efa-f512-34f5-2c4c860106a3@redhat.com>
Date: Wed, 15 Jan 2020 09:11:20 +0100
MIME-Version: 1.0
In-Reply-To: <3ee92240-56dc-69af-4fca-a4a2156e7749@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com

On 15/01/2020 08.57, Janosch Frank wrote:
> On 1/15/20 7:17 AM, Thomas Huth wrote:
>> On 14/01/2020 19.42, Christian Borntraeger wrote:
>>>
>>>
>>> On 14.01.20 16:30, Janosch Frank wrote:
>>>> All CRs are set to 0 and CRs 0 and 14 are set to pre-defined values,
>>>> so we also need to test 1-13 and 15 for 0.
>>>>
>>>> And while we're at it, let's also set some values to cr 1, 7 and 13, so
>>>> we can actually be sure that they will be zeroed.
>>>
>>> While it does not hurt to have it here, I think the register check for the reset
>>> would be better in a kselftest. This allows to check userspace AND guest at the
>>> same time.
>>
>> Agreed. Especially it also allows to test the kernel ioctl on its own,
>> without QEMU in between (which might also clear some registers), so for
>> getting the new reset ioctls right, the selftests are certainly the
>> better place.
> 
> Selftests are in development and will be up for discussion this week if
> all goes well...
> 
> While the selftest leaves QEMU out of the picture, we're still using
> kernel APIs to fetch and reset data, so actually getting guests'
> register values requires some fiddling in the guest code. So I rather
> have a test that tells me if KVM + QEMU are correct at the beginning of
> testing, since that's what most people are using anyways.

Ok, as Christian already said, it certainly can't hurt to test this in
kvm-unit-tests, too - I didn't mean that you should drop this code here,
sorry if that sounded wrong.

 Thomas
