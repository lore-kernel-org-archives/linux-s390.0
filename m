Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38473 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726351AbfKSKS7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 19 Nov 2019 05:18:59 -0500
Subject: Re: [RFC 23/37] KVM: s390: protvirt: Make sure prefix is always
 protected
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-24-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <ded0154c-a9b4-4419-14c8-a34095494d82@redhat.com>
Date: Tue, 19 Nov 2019 11:18:47 +0100
MIME-Version: 1.0
In-Reply-To: <20191024114059.102802-24-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 24.10.19 13:40, Janosch Frank wrote:
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   arch/s390/kvm/kvm-s390.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>=20
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index eddc9508c1b1..17a78774c617 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3646,6 +3646,15 @@ static int kvm_s390_handle_requests(struct kvm_vcp=
u *vcpu)
>   =09=09rc =3D gmap_mprotect_notify(vcpu->arch.gmap,
>   =09=09=09=09=09  kvm_s390_get_prefix(vcpu),
>   =09=09=09=09=09  PAGE_SIZE * 2, PROT_WRITE);
> +=09=09if (!rc && kvm_s390_pv_is_protected(vcpu->kvm)) {
> +=09=09=09rc =3D uv_convert_to_secure(vcpu->arch.gmap,
> +=09=09=09=09=09=09  kvm_s390_get_prefix(vcpu));
> +=09=09=09WARN_ON_ONCE(rc && rc !=3D -EEXIST);
> +=09=09=09rc =3D uv_convert_to_secure(vcpu->arch.gmap,
> +=09=09=09=09=09=09  kvm_s390_get_prefix(vcpu) + PAGE_SIZE);
> +=09=09=09WARN_ON_ONCE(rc && rc !=3D -EEXIST);
> +=09=09=09rc =3D 0;
> +=09=09}

... what if userspace reads the prefix pages just after these calls?=20
validity? :/

>   =09=09if (rc) {
>   =09=09=09kvm_make_request(KVM_REQ_MMU_RELOAD, vcpu);
>   =09=09=09return rc;
>=20

--=20

Thanks,

David / dhildenb
