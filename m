Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57987 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727187AbfKMMXq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 13 Nov 2019 07:23:46 -0500
Subject: Re: [RFC v2] KVM: s390: protvirt: Secure memory is not mergeable
References: <20191024114059.102802-8-frankja@linux.ibm.com>
 <20191025082446.754-1-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <621d0191-1490-d8d3-c7be-11466243f63f@redhat.com>
Date: Wed, 13 Nov 2019 13:23:33 +0100
MIME-Version: 1.0
In-Reply-To: <20191025082446.754-1-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 25/10/2019 10.24, Janosch Frank wrote:
> KSM will not work on secure pages, because when the kernel reads a
> secure page, it will be encrypted and hence no two pages will look the
> same.
>=20
> Let's mark the guest pages as unmergeable when we transition to secure
> mode.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
[...]
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index edcdca97e85e..faecdf81abdb 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -2548,6 +2548,23 @@ int s390_enable_sie(void)
>  }
>  EXPORT_SYMBOL_GPL(s390_enable_sie);
> =20
> +int gmap_mark_unmergeable(void)
> +{
> +=09struct mm_struct *mm =3D current->mm;
> +=09struct vm_area_struct *vma;
> +
> +

Please remove one of the two empty lines.

> +=09for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
> +=09=09if (ksm_madvise(vma, vma->vm_start, vma->vm_end,
> +=09=09=09=09MADV_UNMERGEABLE, &vma->vm_flags))
> +=09=09=09return -ENOMEM;
> +=09}
> +=09mm->def_flags &=3D ~VM_MERGEABLE;
> +
> +=09return 0;
> +}
> +EXPORT_SYMBOL_GPL(gmap_mark_unmergeable);
> +
[...]

Apart from the cosmetic nit, the patch looks fine to me.

Reviewed-by: Thomas Huth <thuth@redhat.com>
