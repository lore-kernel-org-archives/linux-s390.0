Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25213 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726694AbgAJJHn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 10 Jan 2020 04:07:43 -0500
Date: Fri, 10 Jan 2020 10:07:22 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4] KVM: s390: Add new reset vcpu API
Message-ID: <20200110100722.6aad4fdd.cohuck@redhat.com>
In-Reply-To: <90f65536-c2bb-9234-aef4-7941d477369e@linux.ibm.com>
References: <20200109155602.18985-1-frankja@linux.ibm.com>
        <20200109180841.6843cb92.cohuck@redhat.com>
        <f79b523e-f3e8-95b8-c242-1e7ca0083012@linux.ibm.com>
        <f18955c0-4002-c494-b14e-1b9733aad20e@redhat.com>
        <c0049bfb-9516-a382-c69c-0693cb0fbfda@linux.ibm.com>
        <90f65536-c2bb-9234-aef4-7941d477369e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cHU2=gSxrCBM3fdq/da8Dmf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com

--Sig_/cHU2=gSxrCBM3fdq/da8Dmf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 10 Jan 2020 09:43:33 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 1/10/20 8:14 AM, Janosch Frank wrote:
> > On 1/10/20 8:03 AM, Thomas Huth wrote: =20
> >> On 09/01/2020 18.51, Janosch Frank wrote: =20

> >>> Reworded explanation:
> >>> I can't use a fallthrough, because the UV will reject the normal rese=
t
> >>> if we do an initial reset (same goes for the clear reset). To address
> >>> this issue, I added a boolean to the normal and initial reset functio=
ns
> >>> which tells the function if it was called directly or was called beca=
use
> >>> of the fallthrough.
> >>>
> >>> Only if called directly a UV call for the reset is done, that way we =
can
> >>> keep the fallthrough. =20
> >>
> >> Sounds complicated. And do we need the fallthrough stuff here at all?
> >> What about doing something like: =20
> >=20
> > That would work and I thought about it, it just comes down to taste :-)
> > I don't have any strong feelings for a specific implementation. =20

(...)

> +=09if (kvm_s390_pv_handle_cpu(vcpu) && !chain) {

I find this 'chain' thingy a bit unwieldy...

> +=09=09rc =3D uv_cmd_nodata(kvm_s390_pv_handle_cpu(vcpu),
> +=09=09=09=09   UVC_CMD_CPU_RESET, &ret);
> +=09=09VCPU_EVENT(vcpu, 3, "PROTVIRT RESET NORMAL VCPU: cpu %d rc %x rrc =
%x",
> +=09=09=09   vcpu->vcpu_id, ret >> 16, ret & 0x0000ffff);
> +=09}
> +
> +=09return rc;
>  }

(...)

>=20
>  =09case KVM_S390_CLEAR_RESET:
>  =09=09r =3D kvm_arch_vcpu_ioctl_clear_reset(vcpu);
> +=09=09if (r)
> +=09=09=09break;
>  =09=09/* fallthrough */
>  =09case KVM_S390_INITIAL_RESET:
> -=09=09r =3D kvm_arch_vcpu_ioctl_initial_reset(vcpu);
> +=09=09r =3D kvm_arch_vcpu_ioctl_initial_reset(vcpu, ioctl !=3D
> KVM_S390_INITIAL_RESET);
> +=09=09if (r)
> +=09=09=09break;
>  =09=09/* fallthrough */
>  =09case KVM_S390_NORMAL_RESET:
> -=09=09r =3D kvm_arch_vcpu_ioctl_normal_reset(vcpu);
> +=09=09r =3D kvm_arch_vcpu_ioctl_normal_reset(vcpu, ioctl !=3D
> KVM_S390_NORMAL_RESET);

...especially looking at the invocations.

>  =09=09break;
>  =09case KVM_SET_ONE_REG:
>  =09case KVM_GET_ONE_REG: {
>=20

<bikeshed>
What about the following?

static void _do_normal_reset(struct kvm_vcpu *vcpu)
{
=09/* do normal reset */
}

static int kvm_arch_vcpu_ioctl_normal_reset(struct kvm_vcpu *vcpu)
{
=09_do_normal_reset(vcpu);
        if (kvm_s390_pv_handle_cpu(vcpu)) {
=09=09/* do protected virt normal reset */
=09}
}

static void _do_initial_reset(struct kvm_vcpu *vcpu)
{
=09/* do initial reset */
}

static int kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
{
=09_do_initial_reset(vcpu);
=09if (kvm_set_pv_handle_cpu(vcpu)) {
=09=09/* do protected virt initial reset */
=09}
=09_do_normal_reset(vcpu);
}

static void _do_clear_reset(struct kvm_vcpu *vcpu)
{
=09/* do clear reset */
}

static int kvm_arch_vcpu_ioctl_clear_reset(struct kvm_vcpu *vcpu)
{
=09_do_clear_reset(vcpu);
=09if (kvm_set_pv_handle_cpu(vcpu)) {
=09=09/* do protected virt clear reset */
=09}
=09_do_initial_reset(vcpu);
=09_do_normal_reset(vcpu);
}

And call the *_ioctl_* functions directly without fallthrough.

The nice thing about this is that it makes the call chain explicit and
does not require parameters.

The drawback is that we need more functions, and that it looks a bit
overcomplicated before the pv stuff is added.

</bikeshed>

--Sig_/cHU2=gSxrCBM3fdq/da8Dmf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl4YPsoACgkQ3s9rk8bw
L6+/ohAAg+vWecOgEV0vIv9zrzNNs5l7uiu2FW/AIUAelrQpP7FbpNg3GWro7Sjw
BOaLcNtejnkZy7PdfB7V0OrrJUJeLvynbr32h/mgCmNQyhEUvwY99TxFFhzb5d8/
VsLZ0g0z1d1MTo5xDLIIJEDsX65ULXAygj3u3C5sFkh/T01jRmGRkg3hjZCf3xm7
Zz7VwGptEPaUQasoOMOUfi2O7l4bXuotfz8CmE5hehoRbEfMwqpTW85n0IYIj5rz
yS8sd0kA9FSdx0c1E9JC5NiSvnSjHBKII9vtdVf/I7PDhSVGWmVVWtFewN517z0Y
RuKOD0Z2zKX6+w2ABTiR9jggpLJEbwl871odqI6ZD/FBzmBD0N6Dq6ZauiCArwFR
5flhd9Biqh3i0RCEZsCSNZ2q9q2soFn9/r4PR7zt+dP/9HSev4qs9yJphNx5VYCN
kJ0KrRAmhs58VxgApDmA9yF8ZAMjoF+vve5TItuWEbLWjDUn8h0wbdhlwshASAkm
B3tPAlzOcccirjMuSGqKC7+Paqf9NShexxIu9CEnRtDugLgH7EQftlchGQJKySzw
4er3G58WKNHwm61WkqrUQiGC2lAv64x5y13JpKUic2UIlVxZz5JheGapErA9acnj
DEioMavE4/rsPoa7vuBsg01vpQ3eJYivIqmI1borQW/UUe0c2R8=
=FEWI
-----END PGP SIGNATURE-----

--Sig_/cHU2=gSxrCBM3fdq/da8Dmf--
