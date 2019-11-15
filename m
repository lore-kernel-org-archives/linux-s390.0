Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28904 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727264AbfKOLQG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 Nov 2019 06:16:06 -0500
Subject: Re: [RFC 27/37] KVM: s390: protvirt: SIGP handling
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-28-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <64374089-8c38-e7b3-7ebf-b9da0aa0dfa2@redhat.com>
Date: Fri, 15 Nov 2019 12:15:57 +0100
MIME-Version: 1.0
In-Reply-To: <20191024114059.102802-28-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 24/10/2019 13.40, Janosch Frank wrote:
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  arch/s390/kvm/intercept.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
> index 37cb62bc261b..a89738e4f761 100644
> --- a/arch/s390/kvm/intercept.c
> +++ b/arch/s390/kvm/intercept.c
> @@ -72,7 +72,8 @@ static int handle_stop(struct kvm_vcpu *vcpu)
>  =09if (!stop_pending)
>  =09=09return 0;
> =20
> -=09if (flags & KVM_S390_STOP_FLAG_STORE_STATUS) {
> +=09if (flags & KVM_S390_STOP_FLAG_STORE_STATUS &&
> +=09    !kvm_s390_pv_is_protected(vcpu->kvm)) {
>  =09=09rc =3D kvm_s390_vcpu_store_status(vcpu,
>  =09=09=09=09=09=09KVM_S390_STORE_STATUS_NOADDR);
>  =09=09if (rc)

Can this still happen at all that we get here with
KVM_S390_STOP_FLAG_STORE_STATUS in the protected case? I'd rather expect
that SIGP is completely handled by the UV already, so userspace should
have no need to inject a SIGP_STOP anymore? Or did I get that wrong?

Anyway, I guess it can not hurt to add this check anyway, so:

Reviewed-by: Thomas Huth <thuth@redhat.com>
