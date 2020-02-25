Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22357 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730187AbgBYNGw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 25 Feb 2020 08:06:52 -0500
Date: Tue, 25 Feb 2020 14:06:29 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 24/36] KVM: s390: protvirt: Do only reset registers
 that are accessible
Message-ID: <20200225140629.7e018f72.cohuck@redhat.com>
In-Reply-To: <4726aa70-7c53-1985-8ada-3bfbea57e72f@linux.ibm.com>
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
        <20200224114107.4646-25-borntraeger@de.ibm.com>
        <20200225133252.479644ea.cohuck@redhat.com>
        <4726aa70-7c53-1985-8ada-3bfbea57e72f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MTkazsgnlZ.7D3NM4.JjOI_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

--Sig_/MTkazsgnlZ.7D3NM4.JjOI_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Feb 2020 13:51:12 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 2/25/20 1:32 PM, Cornelia Huck wrote:
> > On Mon, 24 Feb 2020 06:40:55 -0500
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >  =20
> >> From: Janosch Frank <frankja@linux.ibm.com>
> >>
> >> For protected VMs the hypervisor can not access guest breaking event
> >> address, program parameter, bpbc and todpr. Do not reset those fields
> >> as the control block does not provide access to these fields.
> >>
> >> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> >> Reviewed-by: David Hildenbrand <david@redhat.com>
> >> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> >> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >> ---
> >>  arch/s390/kvm/kvm-s390.c | 10 ++++++----
> >>  1 file changed, 6 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> >> index 6ab4c88f2e1d..c734e89235f9 100644
> >> --- a/arch/s390/kvm/kvm-s390.c
> >> +++ b/arch/s390/kvm/kvm-s390.c
> >> @@ -3499,14 +3499,16 @@ static void kvm_arch_vcpu_ioctl_initial_reset(=
struct kvm_vcpu *vcpu)
> >>  =09kvm_s390_set_prefix(vcpu, 0);
> >>  =09kvm_s390_set_cpu_timer(vcpu, 0);
> >>  =09vcpu->arch.sie_block->ckc =3D 0;
> >> -=09vcpu->arch.sie_block->todpr =3D 0;
> >>  =09memset(vcpu->arch.sie_block->gcr, 0, sizeof(vcpu->arch.sie_block->=
gcr));
> >>  =09vcpu->arch.sie_block->gcr[0] =3D CR0_INITIAL_MASK;
> >>  =09vcpu->arch.sie_block->gcr[14] =3D CR14_INITIAL_MASK;
> >>  =09vcpu->run->s.regs.fpc =3D 0;
> >> -=09vcpu->arch.sie_block->gbea =3D 1;
> >> -=09vcpu->arch.sie_block->pp =3D 0;
> >> -=09vcpu->arch.sie_block->fpf &=3D ~FPF_BPBC;
> >> +=09if (!kvm_s390_pv_cpu_is_protected(vcpu)) {
> >> +=09=09vcpu->arch.sie_block->gbea =3D 1;
> >> +=09=09vcpu->arch.sie_block->pp =3D 0;
> >> +=09=09vcpu->arch.sie_block->fpf &=3D ~FPF_BPBC;
> >> +=09=09vcpu->arch.sie_block->todpr =3D 0; =20
> >=20
> > What happens if we do change those values? Is it just ignored or will
> > we get an exception on the next SIE entry? =20
>=20
> Well, changing gbea is a bad idea because of the sida overlay.
> I don't think that any other is checked, but I'd need to look up the
> todpr changes to be completely sure.

Maybe add a comment

/*
 * Do not reset these registers in the protected case, as some of
 * them are overlayed and they are not accessible in this case
 * anyway.
 */

?

Just to avoid headscratching once this dropped out of our caches.

>=20
> >  =20
> >> +=09}
> >>  }
> >> =20
> >>  static void kvm_arch_vcpu_ioctl_clear_reset(struct kvm_vcpu *vcpu) =
=20
> >  =20
>=20
>=20


--Sig_/MTkazsgnlZ.7D3NM4.JjOI_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl5VG9UACgkQ3s9rk8bw
L69LmA/+L17RLx/DZhc+8zVJzY5xzAT+AblS5hkbeRVfhlFGowp7RdsKfy8iu5Ey
tHNCLY+AqNA21Ks3XYCrU9Ejora8T3p6gbYoAFVk2uSjfx6rVeDekqQkuqCxLAkg
4R6mezr6Nsct8zJtsMfKS7xzJ+x/xRWXkMw8IWrz30d8CP7EoOfgBasyW9dsfSJM
j8+LTJlP7xKFMYw0wq7RlR7wDS6rVXEgcDSb1AySVvVEM/cxRXUxzBeXYmR6G5To
RbwJWRBGEUUEzqpFpBaueiYWwGkUIWx+0zeqYmq6hIdPlVxbOq8+cPMjCaamz/M5
JSdkQxCbsa3NqXLtWsJ5SVO7BiSGfxtQHi6TFubrirau8JhVuuumg6TS4FCF5nxV
QkK4ffh3SAe0+jX0RBUmuwVVp8cVouPwxICMpdaf0rHlIp7b0cUeGIrgCJAcRvCA
hXzav1FinU85f8h//PMZux1VxodffhzeDfnkv+vFsB3AjqslWXtxkrOoGsLBnfNy
VSc/BlG/YNhNSRoOcSExlchJYxG6fiHkt+pMPGXl4z8aKP10Uj6oGOaaiB2zqPFy
9IJ9eSX/W8d31pboWnt8EHrgCxu7c41Abgf0hDbNbo6GQz0Lu0slfiDIYUIOCTTc
CC9yUcOnpmQobLNisHxu/iCPQlT4QRYGwo8cEAF7pUOp6dbj/kw=
=lCO+
-----END PGP SIGNATURE-----

--Sig_/MTkazsgnlZ.7D3NM4.JjOI_--
