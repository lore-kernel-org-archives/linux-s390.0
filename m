From: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v8 07/22] KVM: s390: refactor crypto initialization
Date: Thu, 9 Aug 2018 07:58:13 +0200
Message-ID: <169d2a44-34ae-3785-bdac-77018dc2ad13@linux.ibm.com>
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1533739472-7172-8-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aA7KH5SKfwKCjCWTE2SNS5CNdTZqETw6Z"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533739472-7172-8-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aA7KH5SKfwKCjCWTE2SNS5CNdTZqETw6Z
Content-Type: multipart/mixed; boundary="qEDmeonOndwJ9PknMSp0f5Fn5g8xo9EIb";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
 borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
 bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
 alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
 alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
 jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
 berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
 Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <169d2a44-34ae-3785-bdac-77018dc2ad13@linux.ibm.com>
Subject: Re: [PATCH v8 07/22] KVM: s390: refactor crypto initialization
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1533739472-7172-8-git-send-email-akrowiak@linux.vnet.ibm.com>
In-Reply-To: <1533739472-7172-8-git-send-email-akrowiak@linux.vnet.ibm.com>

--qEDmeonOndwJ9PknMSp0f5Fn5g8xo9EIb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08.08.2018 16:44, Tony Krowiak wrote:
> From: Tony Krowiak <akrowiak@linux.ibm.com>
>=20
> This patch refactors the code that initializes and sets up the
> crypto configuration for a guest. The following changes are
> implemented via this patch:
>=20
> 1. Prior to the introduction of AP device virtualization, it
>    was not necessary to provide guest access to the CRYCB
>    unless the MSA extension 3 (MSAX3) facility was installed
>    on the host system. With the introduction of AP device
>    virtualization, the CRYCB must be made accessible to the
>    guest if the AP instructions are installed on the host
>    and are to be provided to the guest.
>=20
> 2. Introduces a flag indicating AP instructions executed on
>    the guest shall be interpreted by the firmware. It is
>    initialized to indicate AP instructions are to be
>    to be interpreted and is used to set the SIE bit for
>    each vcpu during vcpu setup.
>=20
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> Tested-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Acked-by: Janosch Frank <frankja@linux.ibm.com>

> ---
>  arch/s390/include/asm/kvm_host.h |    3 +
>  arch/s390/include/uapi/asm/kvm.h |    1 +
>  arch/s390/kvm/kvm-s390.c         |   86 ++++++++++++++++++++----------=
--------
>  3 files changed, 49 insertions(+), 41 deletions(-)
>=20
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/k=
vm_host.h
> index af39561..0c13f61 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -187,6 +187,7 @@ struct kvm_s390_sie_block {
>  #define ECA_AIV		0x00200000
>  #define ECA_VX		0x00020000
>  #define ECA_PROTEXCI	0x00002000
> +#define ECA_APIE	0x00000008
>  #define ECA_SII		0x00000001
>  	__u32	eca;			/* 0x004c */
>  #define ICPT_INST	0x04
> @@ -256,6 +257,7 @@ struct kvm_s390_sie_block {
>  	__u8	reservede4[4];		/* 0x00e4 */
>  	__u64	tecmc;			/* 0x00e8 */
>  	__u8	reservedf0[12];		/* 0x00f0 */
> +#define CRYCB_FORMAT_MASK 0x00000003
>  #define CRYCB_FORMAT1 0x00000001
>  #define CRYCB_FORMAT2 0x00000003
>  	__u32	crycbd;			/* 0x00fc */
> @@ -714,6 +716,7 @@ struct kvm_s390_crypto {
>  	__u32 crycbd;
>  	__u8 aes_kw;
>  	__u8 dea_kw;
> +	__u8 apie;

In the last review I wanted a comment here to know what they do.

>  static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
>  {
> -	if (!test_kvm_facility(vcpu->kvm, 76))
> +	/*
> +	 * If neither the AP instructions nor the MSAX3 facility are installe=
d
> +	 * on the host, then there is no need for a CRYCB in SIE because the
> +	 * they will not be installed on the guest either.

the they

> +	 */
> +	if (ap_instructions_available() && !test_facility(76))
>  		return;

I know you're not responsible for that one :) but 0 being the wanted
value here is a bit counter-intuitive.

> =20
> -	vcpu->arch.sie_block->ecb3 &=3D ~(ECB3_AES | ECB3_DEA);
> +	vcpu->arch.sie_block->crycbd =3D vcpu->kvm->arch.crypto.crycbd;
> +
> +	vcpu->arch.sie_block->eca &=3D ~ECA_APIE;

The scb is zero allocated, are the ECA and the ECB3s set somewhere
in-between, or is that your way of making sure the controls are
definitely gone for good?

> +	if (vcpu->kvm->arch.crypto.apie &&
> +	    test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_AP))
> +		vcpu->arch.sie_block->eca |=3D ECA_APIE;
> =20
> -	if (vcpu->kvm->arch.crypto.aes_kw)
> -		vcpu->arch.sie_block->ecb3 |=3D ECB3_AES;
> -	if (vcpu->kvm->arch.crypto.dea_kw)
> -		vcpu->arch.sie_block->ecb3 |=3D ECB3_DEA;
> +	/* If MSAX3 is installed on the guest, set up protected key support *=
/
> +	if (test_kvm_facility(vcpu->kvm, 76)) {
> +		vcpu->arch.sie_block->ecb3 &=3D ~(ECB3_AES | ECB3_DEA);
> =20
> -	vcpu->arch.sie_block->crycbd =3D vcpu->kvm->arch.crypto.crycbd;
> +		if (vcpu->kvm->arch.crypto.aes_kw)
> +			vcpu->arch.sie_block->ecb3 |=3D ECB3_AES;
> +		if (vcpu->kvm->arch.crypto.dea_kw)
> +			vcpu->arch.sie_block->ecb3 |=3D ECB3_DEA;
> +	}
>  }
> =20
>  void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu)
>=20



--qEDmeonOndwJ9PknMSp0f5Fn5g8xo9EIb--

--aA7KH5SKfwKCjCWTE2SNS5CNdTZqETw6Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJba9f1AAoJEBcO/8Q8ZEV5okMP/2LGSAqduKIyTLeynwB91p+C
F+Ev84sNUlY2WoQEhH3yeFpRQK8IGTdWHTUGNaxnMA79g97TarK8ceDqy4nRRIy0
uj9thAwt1QiAVcflrNnSELG1Z9TMlQhLvh+nrkKHFOF+jkoocBiFGW/3Aie1xUIW
Yo2Jb5cZCZxZl7b5AnJperH0IDj9cPm8IgTVuovcj+wlYTV5BLbTU6thyJXHCgUv
VFwO+gMraqH2/8wWlr8NJysgFf6v112+5XI3cM24NMhgnAV+S+5f3UIPVd7iv+5w
S4HMawP6pR9vVA0xXexL9hkeGyuCy4vRHjObydYzmFzJLkgp4gxFELasdUhXM6JN
+VpN0GbA9izALUzKC2bRRoXhde9+pxVyRYYCreZtL+0lDk2PFh3P5pXdrMzoHVY6
CsXGlGl3wOICIo355xuUYHfAr7N+PKCubk/mQfKeB1o3v0/NJsEwOXpwWbVHZgqT
SicDTXKUpahMpp/yIPncTc708L7YhjzZBqceBe7OmebQu8AmMhidJWElzaLR2Yx1
XhK+vIWy5YjdI5gUgzcfXgWsi1ZD41qvPKsg3VTOhnRMVQX+RckWBZBPdW1yFzy9
+7XwOUR52D4XXgPjLwBkUgHXTjr4s7aOJsRerHRgP5ymS/8hl7F6B+VQZJ0z9Tc+
j1k2aQiCphGwOIhICQXn
=zeW0
-----END PGP SIGNATURE-----

--aA7KH5SKfwKCjCWTE2SNS5CNdTZqETw6Z--
