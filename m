From: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v2] KVM: s390: reset crypto attributes for all vcpus
Date: Mon, 23 Apr 2018 08:18:25 +0200
Message-ID: <55a601d8-8d36-4bd3-ae86-de1134d37d68@linux.ibm.com>
References: <1524411423-18607-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="siUMOUf8pPKFDDloiQ8bqiZWo9WzMbwO3"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524411423-18607-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: rkrcmar@redhat.com, borntraeger@de.ibm.com, david@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--siUMOUf8pPKFDDloiQ8bqiZWo9WzMbwO3
Content-Type: multipart/mixed; boundary="7tFJlKXxNrUrepQIN7REdBkzahNc9OKrB";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: rkrcmar@redhat.com, borntraeger@de.ibm.com, david@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com, pmorel@linux.vnet.ibm.com,
 pasic@linux.vnet.ibm.com
Message-ID: <55a601d8-8d36-4bd3-ae86-de1134d37d68@linux.ibm.com>
Subject: Re: [PATCH v2] KVM: s390: reset crypto attributes for all vcpus
References: <1524411423-18607-1-git-send-email-akrowiak@linux.vnet.ibm.com>
In-Reply-To: <1524411423-18607-1-git-send-email-akrowiak@linux.vnet.ibm.com>

--7tFJlKXxNrUrepQIN7REdBkzahNc9OKrB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.04.2018 17:37, Tony Krowiak wrote:
> Introduces a new function to reset the crypto attributes for all
> vcpus whether they are running or not. Each vcpu in KVM will
> be removed from SIE prior to resetting the crypto attributes in its
> SIE state description. After all vcpus have had their crypto attributes=

> reset the vcpus will be restored to SIE.
>=20
> This function is incorporated into the kvm_s390_vm_set_crypto(kvm)
> function to fix a reported issue whereby the crypto key wrapping
> attributes could potentially get out of synch for running vcpus.

And this time for real: Thanks, applied


>=20
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reported-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
> v2 Changes:
> Fixed compile error, kvm_s390_vcpu_crypto_setup before declaration
>=20
>  arch/s390/kvm/kvm-s390.c |   17 ++++++++++++-----
>  arch/s390/kvm/kvm-s390.h |   13 +++++++++++++
>  2 files changed, 25 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index fa355a6..e629ae1 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -791,11 +791,21 @@ static int kvm_s390_set_mem_control(struct kvm *k=
vm, struct kvm_device_attr *att
> =20
>  static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu);
> =20
> -static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_a=
ttr *attr)
> +void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm)
>  {
>  	struct kvm_vcpu *vcpu;
>  	int i;
> =20
> +	kvm_s390_vcpu_block_all(kvm);
> +
> +	kvm_for_each_vcpu(i, vcpu, kvm)
> +		kvm_s390_vcpu_crypto_setup(vcpu);
> +
> +	kvm_s390_vcpu_unblock_all(kvm);
> +}
> +
> +static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_a=
ttr *attr)
> +{
>  	if (!test_kvm_facility(kvm, 76))
>  		return -EINVAL;
> =20
> @@ -832,10 +842,7 @@ static int kvm_s390_vm_set_crypto(struct kvm *kvm,=
 struct kvm_device_attr *attr)
>  		return -ENXIO;
>  	}
> =20
> -	kvm_for_each_vcpu(i, vcpu, kvm) {
> -		kvm_s390_vcpu_crypto_setup(vcpu);
> -		exit_sie(vcpu);
> -	}
> +	kvm_s390_vcpu_crypto_reset_all(kvm);
>  	mutex_unlock(&kvm->lock);
>  	return 0;
>  }
> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
> index 1b5621f..981e3ba 100644
> --- a/arch/s390/kvm/kvm-s390.h
> +++ b/arch/s390/kvm/kvm-s390.h
> @@ -410,4 +410,17 @@ static inline int kvm_s390_use_sca_entries(void)
>  }
>  void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
>  				     struct mcck_volatile_info *mcck_info);
> +
> +/**
> + * kvm_s390_vcpu_crypto_reset_all
> + *
> + * Reset the crypto attributes for each vcpu. This can be done while t=
he vcpus
> + * are running as each vcpu will be removed from SIE before resetting =
the crypt
> + * attributes and restored to SIE afterward.
> + *
> + * Note: The kvm->lock must be held while calling this function
> + *
> + * @kvm: the KVM guest
> + */
> +void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm);
>  #endif
>=20



--7tFJlKXxNrUrepQIN7REdBkzahNc9OKrB--

--siUMOUf8pPKFDDloiQ8bqiZWo9WzMbwO3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIbBAEBCAAGBQJa3Xq5AAoJEBcO/8Q8ZEV5oUcP+PD37x95pF3J6ls3+gB8vvP0
EnEnhLVgVp8Thx0qK/u/ekIzGFE2anu5n6ARJ3oxPggY9FS+VpPpwAu/JFLs/wl9
QDxlRkiokDe5rew54yg6S735D/YhI6rwuSF2ieyoe/2NEVpE+x5iUIcJ7XkJ6ctW
BeTXJEZzEf0T7VmMPD63B95cerZFudTaQfi6Da9EkQtxvJyH5FfEKIsbLU+s9KIz
/wEc5uwfNP1MJkaaul88TegZY0LG0+HB9vKeYdngoPXgyjAopeunwHxwHTBXHxmg
xvNeOGcjYrJ0AlWrprK1ui6FPNth8e8pUceG0aXyuwxNT/QysKdc5BCZ89sYNWwV
DzqYgftBv7HCdpS9VFFKEdmeMdMfiWYG7vVGk/j51VZ5wZj2UXSjEZ3yETnKz00C
LcCEu9Xzs3RRuevZsr+UoV036HPPyWSvsCYW77EbYRsgsRlrHqsnIMWuzRAu7pJ+
5IDcZK8GbDy0nTsysewZrEDCdHMcasWDmHMmQCPkyQXF3oAI3VUk05cAVQkvJMTp
kNg8mYuUiPeq/1IjwmmrZpATfeSM2PXrT0oUF7mlT9iD+SZYKzShao//JzZ6f28V
6/ImUTCqM1CaU//DO/eeUJI8s4NnxFCFRDxoqVYVbcMLhd3mzXB5NPY0+5QxaEkX
UfgAR7FEze/1MTSuqW8=
=f84s
-----END PGP SIGNATURE-----

--siUMOUf8pPKFDDloiQ8bqiZWo9WzMbwO3--
