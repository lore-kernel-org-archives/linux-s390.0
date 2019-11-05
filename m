Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28963 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390519AbfKESL1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Nov 2019 13:11:27 -0500
Date: Tue, 5 Nov 2019 19:11:13 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC 16/37] KVM: s390: protvirt: Implement machine-check
 interruption injection
Message-ID: <20191105191113.655337e0.cohuck@redhat.com>
In-Reply-To: <20191024114059.102802-17-frankja@linux.ibm.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
        <20191024114059.102802-17-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

On Thu, 24 Oct 2019 07:40:38 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> From: Michael Mueller <mimu@linux.ibm.com>
>=20
> Similar to external interrupts, the hypervisor can inject machine
> checks by providing the right data in the interrupt injection controls.
>=20
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---
>  arch/s390/kvm/interrupt.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index c919dfe4dfd3..1f87c7d3fa3e 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -568,6 +568,14 @@ static int __write_machine_check(struct kvm_vcpu *vc=
pu,
>  =09union mci mci;
>  =09int rc;
> =20
> +=09if (kvm_s390_pv_is_protected(vcpu->kvm)) {
> +=09=09vcpu->arch.sie_block->iictl =3D IICTL_CODE_MCHK;
> +=09=09vcpu->arch.sie_block->mcic =3D mchk->mcic;
> +=09=09vcpu->arch.sie_block->faddr =3D mchk->failing_storage_address;
> +=09=09vcpu->arch.sie_block->edc =3D mchk->ext_damage_code;
> +=09=09return 0;
> +=09}
> +

The other stuff this function injects in the !pv case is inaccessible
to the hypervisor in the pv case, right? (Registers, extended save
area, ...) Maybe add a comment?

>  =09mci.val =3D mchk->mcic;
>  =09/* take care of lazy register loading */
>  =09save_fpu_regs();
