From: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH] KVM: s390: reset crypto attributes for all vcpus
Date: Fri, 20 Apr 2018 13:59:44 +0200
Message-ID: <870459b4-228d-0be3-5dd3-48ab480b46de@linux.ibm.com>
References: <1524172432-26211-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="n6kp673LA74rEC7tWUKnaqaFFXhqwqKAb"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524172432-26211-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, pbonzini@redhat.com, rkrcmar@redhat.com
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n6kp673LA74rEC7tWUKnaqaFFXhqwqKAb
Content-Type: multipart/mixed; boundary="zDi7kUaLoViTvIsrjxjUh4nfna871sGlG";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, pmorel@linux.vnet.ibm.com,
 pasic@linux.vnet.ibm.com, pbonzini@redhat.com, rkrcmar@redhat.com
Message-ID: <870459b4-228d-0be3-5dd3-48ab480b46de@linux.ibm.com>
Subject: Re: [PATCH] KVM: s390: reset crypto attributes for all vcpus
References: <1524172432-26211-1-git-send-email-akrowiak@linux.vnet.ibm.com>
In-Reply-To: <1524172432-26211-1-git-send-email-akrowiak@linux.vnet.ibm.com>

--zDi7kUaLoViTvIsrjxjUh4nfna871sGlG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Thanks, applied.


On 19.04.2018 23:13, Tony Krowiak wrote:
> Introduces a new function to reset the crypto attributes for all
> vcpus whether they are running or not. Each vcpu in KVM will
> be removed from SIE prior to resetting the crypto attributes in its
> SIE state description. After all vcpus have had their crypto attributes=

> reset the vcpus will be restored to SIE.
>=20
> This function is incorporated into the kvm_s390_vm_set_crypto(kvm)
> function to fix a reported issue whereby the crypto key wrapping
> attributes could potentially get out of synch for running vcpus.
>=20
> Reported-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c |   18 ++++++++++++++----
>  arch/s390/kvm/kvm-s390.h |   13 +++++++++++++
>  2 files changed, 27 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index fa355a6..4fa3037 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -789,6 +789,19 @@ static int kvm_s390_set_mem_control(struct kvm *kv=
m, struct kvm_device_attr *att
>  	return ret;
>  }
>=20
> +void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm)
> + {
> +	int i;
> +	struct kvm_vcpu *vcpu;
> +
> +	kvm_s390_vcpu_block_all(kvm);
> +
> +	kvm_for_each_vcpu(i, vcpu, kvm)
> +	        kvm_s390_vcpu_crypto_setup(vcpu);
> +
> +	kvm_s390_vcpu_unblock_all(kvm);
> +}
> +
>  static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu);
>=20
>  static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_a=
ttr *attr)
> @@ -832,10 +845,7 @@ static int kvm_s390_vm_set_crypto(struct kvm *kvm,=
 struct kvm_device_attr *attr)
>  		return -ENXIO;
>  	}
>=20
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



--zDi7kUaLoViTvIsrjxjUh4nfna871sGlG--

--n6kp673LA74rEC7tWUKnaqaFFXhqwqKAb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJa2dY3AAoJEBcO/8Q8ZEV5QRMP/j2ytqH+wyXbC6is8dKiQd6u
8KlWeoDZ5OprEu3pTuXOpVDv2IVVEBYVTcNhWwTF2KqzhoebcMck877TGNRPgfPq
xBB1IygZ3Fk25301a6jEz7j++cKKpP+XzMDNb+KJPyF18yck/0ZIvD+dQR5Z/nuO
WXiyDR2RWS9tjzc+qVhNjGAxPMPGD1EJMPJBE4aQN6PTz8gyl4ZzhVGhXm8yB93q
jdpg3yclD/i8HvS7b/JRDaEuXdMf2DfdxZh2uBlCp9LXdqZyoGlfo03pnGrRM/la
8q94Fpu4L95rTOPuXzlQP5tKUpZxkXdaGQ2gNzj0EN1Jg4sBpJuAUgRpI9cbQBhV
vn5Knsjih1l2kVYiLz9TvmavDe0juwzF2/4mLtMrpmWchRilVVcbHnNRLdP0sJD4
MVFR6/xcx1bA0A1C59xvoYWPeyO0zftZ7XXtoxz3epybVIm2HLRti00NssevpVIU
Xu2SqVqR9EYo8KVEnQL3eOhEBReYVelcKFH50lV+Y2t/xOJvLho4ixRCVag9MRW7
039bw4t43VI2khi9JeK5Pj7UDgJLVLngzJHvcAGXmfnSI+6GxGg83dJwIRSCkCaj
Ze3kLb2f+MPyRfJVxbFXqrwWdpoRZztx7LPCZhsCD07xzRg+vV5EFROVQRJTfhUe
75XP6mkJnPH0Rkn46pXK
=/GRu
-----END PGP SIGNATURE-----

--n6kp673LA74rEC7tWUKnaqaFFXhqwqKAb--
