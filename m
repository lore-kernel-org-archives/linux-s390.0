Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60044 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbfIMHnO (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 13 Sep 2019 03:43:14 -0400
Subject: Re: [PATCH] KVM: s390: Do not leak kernel stack data in the
 KVM_S390_INTERRUPT ioctl
References: <20190912090050.20295-1-thuth@redhat.com>
 <6905df78-95f0-3d6d-aaae-910cd2d7a232@redhat.com>
 <253e67f6-0a41-13e8-4ca2-c651d5fcdb69@redhat.com>
 <f9d07b66-a048-6626-e209-9fe455a2bed3@de.ibm.com>
 <239c8d0f-40fb-264a-bc10-445931a3cd9a@redhat.com>
 <20190913092030.373a9254.cohuck@redhat.com>
 <ed0cf9eb-e3dc-f8d5-1eea-9034e5c0498d@redhat.com>
 <1d3f9799-41dd-4f7e-009b-c37610de22f7@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5632e756-ee92-ad8a-8c7c-efc5ee011f52@redhat.com>
Date: Fri, 13 Sep 2019 09:43:09 +0200
MIME-Version: 1.0
In-Reply-To: <1d3f9799-41dd-4f7e-009b-c37610de22f7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On 13/09/2019 09.37, David Hildenbrand wrote:
> On 13.09.19 09:34, Thomas Huth wrote:
>> On 13/09/2019 09.20, Cornelia Huck wrote:
>>> On Thu, 12 Sep 2019 13:23:38 +0200
>>> Thomas Huth <thuth@redhat.com> wrote:
>>>
>>>> Hmm, we already talked about deprecating support for pre-3.15 kernel
>>>> stuff in the past (see
>>>> https://wiki.qemu.org/ChangeLog/2.12#Future_incompatible_changes for
>>>> example),
>>>
>>> Btw: did we ever do that? I don't quite recall what code we were
>>> talking about...
>>
>> We never really did - but we also never fixed the issue: If you run the
>> current QEMU on a kernel before 3.15, it refuses to work due to the
>> missing in-kernel FLIC device:
>>
>> Initialization of device s390-flic-kvm failed: KVM is missing capability
>> KVM_CAP_DEVICE_CTR
>>
>> Since nobody really complained so far that running QEMU with KVM is
>> still required on a kernel < 3.15, I think we could make this also
>> "official" now and improve the error message a little bit, pointing the
>> user to a kernel >= 3.15.
> 
> Didn't we discuss back then to clean up *QEMU* and not the *kernel*?
> Especially, to wait with cleanups until somebody requests to fix
> instead. I mean you could have any user space in the wild that still
> makes use of these interfaces ...

Yes, that error message is part of QEMU, so I was referring to that one.
Sorry for mixing this into a mail thread on the kernel mailing list :-/

 Thomas
