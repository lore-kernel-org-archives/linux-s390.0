Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50837 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730235AbfJXN1r (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 24 Oct 2019 09:27:47 -0400
Subject: Re: [RFC 02/37] s390/protvirt: introduce host side setup
From: David Hildenbrand <david@redhat.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-3-frankja@linux.ibm.com>
 <e1a12cc7-de97-127d-6076-f86b7be6bac1@redhat.com>
Message-ID: <b78483e0-e438-feb8-8dfa-1d8f0df18c73@redhat.com>
Date: Thu, 24 Oct 2019 15:27:37 +0200
MIME-Version: 1.0
In-Reply-To: <e1a12cc7-de97-127d-6076-f86b7be6bac1@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 24.10.19 15:25, David Hildenbrand wrote:
> On 24.10.19 13:40, Janosch Frank wrote:
>> From: Vasily Gorbik <gor@linux.ibm.com>
>>
>> Introduce KVM_S390_PROTECTED_VIRTUALIZATION_HOST kbuild option for
>> protected virtual machines hosting support code.
>>
>> Add "prot_virt" command line option which controls if the kernel
>> protected VMs support is enabled at runtime.
>>
>> Extend ultravisor info definitions and expose it via uv_info struct
>> filled in during startup.
>>
>> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
>> ---
>>    .../admin-guide/kernel-parameters.txt         |  5 ++
>>    arch/s390/boot/Makefile                       |  2 +-
>>    arch/s390/boot/uv.c                           | 20 +++++++-
>>    arch/s390/include/asm/uv.h                    | 46 ++++++++++++++++--
>>    arch/s390/kernel/Makefile                     |  1 +
>>    arch/s390/kernel/setup.c                      |  4 --
>>    arch/s390/kernel/uv.c                         | 48 ++++++++++++++++++=
+
>>    arch/s390/kvm/Kconfig                         |  9 ++++
>>    8 files changed, 126 insertions(+), 9 deletions(-)
>>    create mode 100644 arch/s390/kernel/uv.c
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documenta=
tion/admin-guide/kernel-parameters.txt
>> index c7ac2f3ac99f..aa22e36b3105 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -3693,6 +3693,11 @@
>>    =09=09=09before loading.
>>    =09=09=09See Documentation/admin-guide/blockdev/ramdisk.rst.
>>   =20
>> +=09prot_virt=3D=09[S390] enable hosting protected virtual machines
>> +=09=09=09isolated from the hypervisor (if hardware supports
>> +=09=09=09that).
>> +=09=09=09Format: <bool>
>=20
> Isn't that a virt driver detail that should come in via KVM module
> parameters? I don't see quite yet why this has to be a kernel parameter
> (that can be changed at runtime).
>=20

I was confused by "runtime" in "which controls if the kernel protected=20
VMs support is enabled at runtime"

So this can't be changed at runtime. Can you clarify why kvm can't=20
initialize that when loaded and why we need a kernel parameter?

--=20

Thanks,

David / dhildenb
