Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23098 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733296AbfJXNkk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 24 Oct 2019 09:40:40 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9ODZS49070169
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 09:40:40 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vucxggaq1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 24 Oct 2019 09:40:39 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 24 Oct 2019 14:40:37 +0100
Subject: Re: [RFC 02/37] s390/protvirt: introduce host side setup
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-3-frankja@linux.ibm.com>
 <e1a12cc7-de97-127d-6076-f86b7be6bac1@redhat.com>
 <b78483e0-e438-feb8-8dfa-1d8f0df18c73@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 24 Oct 2019 15:40:31 +0200
MIME-Version: 1.0
In-Reply-To: <b78483e0-e438-feb8-8dfa-1d8f0df18c73@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <d78f708a-7536-d556-f027-adb7cc7b94f5@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com



On 24.10.19 15:27, David Hildenbrand wrote:
> On 24.10.19 15:25, David Hildenbrand wrote:
>> On 24.10.19 13:40, Janosch Frank wrote:
>>> From: Vasily Gorbik <gor@linux.ibm.com>
>>>
>>> Introduce KVM_S390_PROTECTED_VIRTUALIZATION_HOST kbuild option for
>>> protected virtual machines hosting support code.
>>>
>>> Add "prot_virt" command line option which controls if the kernel
>>> protected VMs support is enabled at runtime.
>>>
>>> Extend ultravisor info definitions and expose it via uv_info struct
>>> filled in during startup.
>>>
>>> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
>>> ---
>>>    .../admin-guide/kernel-parameters.txt         |  5 ++
>>>    arch/s390/boot/Makefile                       |  2 +-
>>>    arch/s390/boot/uv.c                           | 20 +++++++-
>>>    arch/s390/include/asm/uv.h                    | 46 ++++++++++++++++--
>>>    arch/s390/kernel/Makefile                     |  1 +
>>>    arch/s390/kernel/setup.c                      |  4 --
>>>    arch/s390/kernel/uv.c                         | 48 +++++++++++++++++++
>>>    arch/s390/kvm/Kconfig                         |  9 ++++
>>>    8 files changed, 126 insertions(+), 9 deletions(-)
>>>    create mode 100644 arch/s390/kernel/uv.c
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index c7ac2f3ac99f..aa22e36b3105 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -3693,6 +3693,11 @@
>>>                before loading.
>>>                See Documentation/admin-guide/blockdev/ramdisk.rst.
>>>    +    prot_virt=    [S390] enable hosting protected virtual machines
>>> +            isolated from the hypervisor (if hardware supports
>>> +            that).
>>> +            Format: <bool>
>>
>> Isn't that a virt driver detail that should come in via KVM module
>> parameters? I don't see quite yet why this has to be a kernel parameter
>> (that can be changed at runtime).
>>
> 
> I was confused by "runtime" in "which controls if the kernel protected VMs support is enabled at runtime"
> 
> So this can't be changed at runtime. Can you clarify why kvm can't initialize that when loaded and why we need a kernel parameter?

We have to do the opt-in very early for several reasons:
- we have to donate a potentially largish contiguous (in real) range of memory to the ultravisor
- The opt-in will also disable some features in the host that could affect guest integrity (e.g. 
time sync via STP to avoid the host messing with the guest time stepping). Linux is not happy
when you remove features at a later point in time
