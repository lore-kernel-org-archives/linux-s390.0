Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22854 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725798AbfKSKXm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 19 Nov 2019 05:23:42 -0500
Date: Tue, 19 Nov 2019 11:23:16 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC 36/37] KVM: s390: protvirt: Support cmd 5 operation state
Message-ID: <20191119112316.0a421a01.cohuck@redhat.com>
In-Reply-To: <44b320d8-604d-8497-59a3-defc41472ba5@linux.ibm.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
        <20191024114059.102802-37-frankja@linux.ibm.com>
        <20191118183842.36688a81.cohuck@redhat.com>
        <44b320d8-604d-8497-59a3-defc41472ba5@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/426suMwb8hy2eZjpANtTcZe";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

--Sig_/426suMwb8hy2eZjpANtTcZe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 19 Nov 2019 09:13:11 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 11/18/19 6:38 PM, Cornelia Huck wrote:
> > On Thu, 24 Oct 2019 07:40:58 -0400
> > Janosch Frank <frankja@linux.ibm.com> wrote:
> >  =20
> >> Code 5 for the set cpu state UV call tells the UV to load a PSW from
> >> the SE header (first IPL) or from guest location 0x0 (diag 308 subcode
> >> 0/1). Also it sets the cpu into operating state afterwards, so we can
> >> start it. =20
> >=20
> > I'm a bit confused by the patch description: Does this mean that the UV
> > does the transition to operating state? Does the hypervisor get a
> > notification for that? =20
>=20
> CMD 5 is defined as "load psw and set to operating".
> Currently QEMU will still go out and do a "set to operating" after the
> cmd 5 because our current infrastructure does it and it's basically a
> nop, so I didn't want to put in the effort to remove it.

So, the "it" setting the cpu into operating state is QEMU, via the
mpstate interface, which triggers that call? Or is that implicit, but
it does not hurt to do it again (which would make more sense to me)?

Assuming the latter, what about the following description:

"KVM: s390: protvirt: support setting cpu state 5

Setting code 5 ("load psw and set to operating") in the set cpu state
UV call tells the UV to load a PSW either from the SE header (first
IPL) or from guest location 0x0 (diag 308 subcode 0/1). Subsequently,
the cpu is set into operating state by the UV.

Note that we can still instruct the UV to set the cpu into operating
state explicitly afterwards."

>=20
> >  =20
> >>
> >> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> >> ---
> >>  arch/s390/include/asm/uv.h | 1 +
> >>  arch/s390/kvm/kvm-s390.c   | 4 ++++
> >>  include/uapi/linux/kvm.h   | 1 +
> >>  3 files changed, 6 insertions(+)
> >>
> >> diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
> >> index 33b52ba306af..8d10ae731458 100644
> >> --- a/arch/s390/include/asm/uv.h
> >> +++ b/arch/s390/include/asm/uv.h
> >> @@ -163,6 +163,7 @@ struct uv_cb_unp {
> >>  #define PV_CPU_STATE_OPR=091
> >>  #define PV_CPU_STATE_STP=092
> >>  #define PV_CPU_STATE_CHKSTP=093
> >> +#define PV_CPU_STATE_OPR_LOAD=095
> >> =20
> >>  struct uv_cb_cpu_set_state {
> >>  =09struct uv_cb_header header;
> >> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> >> index cc5feb67f145..5cc9108c94e4 100644
> >> --- a/arch/s390/kvm/kvm-s390.c
> >> +++ b/arch/s390/kvm/kvm-s390.c
> >> @@ -4652,6 +4652,10 @@ static int kvm_s390_handle_pv_vcpu(struct kvm_v=
cpu *vcpu,
> >>  =09=09r =3D kvm_s390_pv_destroy_cpu(vcpu);
> >>  =09=09break;
> >>  =09}
> >> +=09case KVM_PV_VCPU_SET_IPL_PSW: {
> >> +=09=09r =3D kvm_s390_pv_set_cpu_state(vcpu, PV_CPU_STATE_OPR_LOAD);

Also maybe add a comment here that setting into oper state (again) can
be done separately?

> >> +=09=09break;
> >> +=09}
> >>  =09default:
> >>  =09=09r =3D -ENOTTY;
> >>  =09}
> >> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> >> index 2846ed5e5dd9..973007d27d55 100644
> >> --- a/include/uapi/linux/kvm.h
> >> +++ b/include/uapi/linux/kvm.h
> >> @@ -1483,6 +1483,7 @@ enum pv_cmd_id {
> >>  =09KVM_PV_VM_UNSHARE,
> >>  =09KVM_PV_VCPU_CREATE,
> >>  =09KVM_PV_VCPU_DESTROY,
> >> +=09KVM_PV_VCPU_SET_IPL_PSW,
> >>  };
> >> =20
> >>  struct kvm_pv_cmd { =20
> >  =20
>=20
>=20


--Sig_/426suMwb8hy2eZjpANtTcZe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl3TwpQACgkQ3s9rk8bw
L69hRQ/+IkXC55f5pKzsG5NQp7SL8hfIM4pfshIIq3fwfCO00Z/pB6YQJeckXXwr
rpCbP7jJvAj3Mc7ZkTj4k41ekeol3Tvga9Oo8JBGWnxFFrlBEYs8P5Ee1qQNGhnE
gb8+52B9CNwm0m2W5M61+8p/65I66EwiK5sksNnmsSYMSbCb6Za5/+q2xF8CdW6a
2rTNXFvLxJ462N6BgLBC81euXEuJRdoK70YRK8ZUcXnpl/wDk3p9UhTnUUI21KxS
ebwOGrpGfYaGXbQmMATIQiPDkQbnJl0SUpDrCPnod9hEHVt4gkCypjHIdMb8eX5a
nlrbXKF8IAn1jKhhUdfbaJz3FEIRYs1Q4pY+Zt/pkPuzP3/GoA8FYetALc1oF2e+
6Gi25JkqH4cvLfIc5x2ReJB657UzQsxO5mx4+KRmcA5LmqE/e7nBpjcObLrSdhf3
XRtNCW1bMDrByN+FnE1Um36/dN5w44YlHF50b4MLbGMUmyePnkKCpCzCU/AV6TGO
leVSB8txfwD+fVJH9s/dn9dqziFHXqtcLRx9ZlK8pUcKcErVgX3PHQ5iZTtpxWr1
fKQNk5rD+d0PXE6qaSm9DvFvbFIPk7fiPlvj+fCQJsqbhtMGJOMY2cvtDUY0lWdR
GcPu1x4xdbNNKKWb9RFWoYTioIHhMM6nx2xTp7w+fZc9XLeaRKs=
=e9K4
-----END PGP SIGNATURE-----

--Sig_/426suMwb8hy2eZjpANtTcZe--
