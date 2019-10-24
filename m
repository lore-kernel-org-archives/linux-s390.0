Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39317 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730061AbfJXNZk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 24 Oct 2019 09:25:40 -0400
Subject: Re: [RFC 02/37] s390/protvirt: introduce host side setup
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-3-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <e1a12cc7-de97-127d-6076-f86b7be6bac1@redhat.com>
Date: Thu, 24 Oct 2019 15:25:31 +0200
MIME-Version: 1.0
In-Reply-To: <20191024114059.102802-3-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 24.10.19 13:40, Janosch Frank wrote:
> From: Vasily Gorbik <gor@linux.ibm.com>
>=20
> Introduce KVM_S390_PROTECTED_VIRTUALIZATION_HOST kbuild option for
> protected virtual machines hosting support code.
>=20
> Add "prot_virt" command line option which controls if the kernel
> protected VMs support is enabled at runtime.
>=20
> Extend ultravisor info definitions and expose it via uv_info struct
> filled in during startup.
>=20
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> ---
>   .../admin-guide/kernel-parameters.txt         |  5 ++
>   arch/s390/boot/Makefile                       |  2 +-
>   arch/s390/boot/uv.c                           | 20 +++++++-
>   arch/s390/include/asm/uv.h                    | 46 ++++++++++++++++--
>   arch/s390/kernel/Makefile                     |  1 +
>   arch/s390/kernel/setup.c                      |  4 --
>   arch/s390/kernel/uv.c                         | 48 +++++++++++++++++++
>   arch/s390/kvm/Kconfig                         |  9 ++++
>   8 files changed, 126 insertions(+), 9 deletions(-)
>   create mode 100644 arch/s390/kernel/uv.c
>=20
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index c7ac2f3ac99f..aa22e36b3105 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3693,6 +3693,11 @@
>   =09=09=09before loading.
>   =09=09=09See Documentation/admin-guide/blockdev/ramdisk.rst.
>  =20
> +=09prot_virt=3D=09[S390] enable hosting protected virtual machines
> +=09=09=09isolated from the hypervisor (if hardware supports
> +=09=09=09that).
> +=09=09=09Format: <bool>

Isn't that a virt driver detail that should come in via KVM module=20
parameters? I don't see quite yet why this has to be a kernel parameter=20
(that can be changed at runtime).

--=20

Thanks,

David / dhildenb
