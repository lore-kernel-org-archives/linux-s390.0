Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29291 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfKNOWn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 14 Nov 2019 09:22:43 -0500
Subject: Re: [RFC 18/37] KVM: s390: protvirt: Handle spec exception loops
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-19-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6d1d7c2f-0191-b41f-dbed-146a98c9ec4c@redhat.com>
Date: Thu, 14 Nov 2019 15:22:26 +0100
MIME-Version: 1.0
In-Reply-To: <20191024114059.102802-19-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 24/10/2019 13.40, Janosch Frank wrote:
> SIE intercept code 8 is used only on exception loops for protected
> guests. That means we need stop the guest when we see it.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  arch/s390/kvm/intercept.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
> index acc1710fc472..b013a9c88d43 100644
> --- a/arch/s390/kvm/intercept.c
> +++ b/arch/s390/kvm/intercept.c
> @@ -231,6 +231,13 @@ static int handle_prog(struct kvm_vcpu *vcpu)
> =20
>  =09vcpu->stat.exit_program_interruption++;
> =20
> +=09/*
> +=09 * Intercept 8 indicates a loop of specification exceptions
> +=09 * for protected guests
> +=09 */
> +=09if (kvm_s390_pv_is_protected(vcpu->kvm))
> +=09=09return -EOPNOTSUPP;
> +
>  =09if (guestdbg_enabled(vcpu) && per_event(vcpu)) {
>  =09=09rc =3D kvm_s390_handle_per_event(vcpu);
>  =09=09if (rc)

Reviewed-by: Thomas Huth <thuth@redhat.com>
