Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44250 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726239AbgBRIk0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Feb 2020 03:40:26 -0500
Subject: Re: [PATCH v2 25/42] KVM: s390: protvirt: disallow one_reg
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-26-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <031b7db2-c255-e32d-782d-d4769dcb6ee8@redhat.com>
Date: Tue, 18 Feb 2020 09:40:16 +0100
MIME-Version: 1.0
In-Reply-To: <20200214222658.12946-26-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On 14.02.20 23:26, Christian Borntraeger wrote:
> From: Janosch Frank <frankja@linux.ibm.com>

"KVM: s390: protvirt: disallow KVM_GET_ONE_REG/KVM_SET_ONE_REG"

>=20
> A lot of the registers are controlled by the Ultravisor and never
> visible to KVM. Some fields in the sie control block are overlayed, lik=
e
> gbea. As no known userspace uses the ONE_REG interface on s390 if sync
> regs are available, no functionality is lost if it is disabled for
> protected guests.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  Documentation/virt/kvm/api.rst | 6 ++++--
>  arch/s390/kvm/kvm-s390.c       | 3 +++
>  2 files changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/ap=
i.rst
> index cb58714fe60d..a82166e5f7d9 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -2117,7 +2117,8 @@ Errors:
> =20
>    =3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   =C2=A0ENOENT =C2=A0=C2=A0no such register
> - =C2=A0EINVAL =C2=A0=C2=A0invalid register ID, or no such register
> + =C2=A0EINVAL =C2=A0=C2=A0invalid register ID, or no such register, ON=
E_REG forbidden
> +           for protected guests (s390)

"invalid register ID, no such register, or used with VMs in protected
virtualization mode on s390" ?

>   =C2=A0EPERM =C2=A0=C2=A0=C2=A0(arm64) register access not allowed bef=
ore vcpu finalization
>    =3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> @@ -2552,7 +2553,8 @@ Errors include:
> =20
>    =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   =C2=A0ENOENT =C2=A0=C2=A0no such register
> - =C2=A0EINVAL =C2=A0=C2=A0invalid register ID, or no such register
> + =C2=A0EINVAL =C2=A0=C2=A0invalid register ID, or no such register, ON=
E_REG forbidden
> +           for protected guests (s390)

dito

>   =C2=A0EPERM =C2=A0=C2=A0=C2=A0(arm64) register access not allowed bef=
ore vcpu finalization
>    =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 8db82aaf1275..d20a7fa9d480 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -4638,6 +4638,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  	case KVM_SET_ONE_REG:
>  	case KVM_GET_ONE_REG: {
>  		struct kvm_one_reg reg;
> +		r =3D -EINVAL;
> +		if (kvm_s390_pv_is_protected(vcpu->kvm))
> +			break;

I assume races will be dealt with in your next series.

>  		r =3D -EFAULT;
>  		if (copy_from_user(&reg, argp, sizeof(reg)))
>  			break;
>=20

With the two nits fixed

Reviewed-by: David Hildenbrand <david@redhat.com>

--=20
Thanks,

David / dhildenb
