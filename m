Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41790 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726795AbfJ3S3x (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 30 Oct 2019 14:29:53 -0400
Subject: Re: [RFC 27/37] KVM: s390: protvirt: SIGP handling
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-28-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <37df8c9a-091b-4da6-e1dc-294f432cb743@redhat.com>
Date: Wed, 30 Oct 2019 19:29:45 +0100
MIME-Version: 1.0
In-Reply-To: <20191024114059.102802-28-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 24.10.19 13:40, Janosch Frank wrote:
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Can you add why this is necessary and how handle_stop() is intended to=20
work in prot mode?

How is SIGP handled in general in prot mode? (which intercepts are=20
handled by QEMU)
Would it be valid for user space to inject a STOP interrupt with "flags=20
& KVM_S390_STOP_FLAG_STORE_STATUS" - I think not (legacy QEMU only)

I think we should rather disallow injecting such stop interrupts=20
(KVM_S390_STOP_FLAG_STORE_STATUS) in prot mode in the first place. Also,=20
we should disallow prot virt without user_sigp.

> ---
>   arch/s390/kvm/intercept.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
> index 37cb62bc261b..a89738e4f761 100644
> --- a/arch/s390/kvm/intercept.c
> +++ b/arch/s390/kvm/intercept.c
> @@ -72,7 +72,8 @@ static int handle_stop(struct kvm_vcpu *vcpu)
>   =09if (!stop_pending)
>   =09=09return 0;
>  =20
> -=09if (flags & KVM_S390_STOP_FLAG_STORE_STATUS) {
> +=09if (flags & KVM_S390_STOP_FLAG_STORE_STATUS &&
> +=09    !kvm_s390_pv_is_protected(vcpu->kvm)) {
>   =09=09rc =3D kvm_s390_vcpu_store_status(vcpu,
>   =09=09=09=09=09=09KVM_S390_STORE_STATUS_NOADDR);
>   =09=09if (rc)
>=20

--=20

Thanks,

David / dhildenb
