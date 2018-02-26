From: Janosch Frank <frankja@linux.vnet.ibm.com>
Date: Mon, 26 Feb 2018 08:06:37 +0000
Subject: Re: [PATCH v2 1/2] KVM: document KVM_CAP_S390_[BPB|PSW|GMAP|COW]
Message-Id: <7eea1d04-40d4-4557-9344-efbc2e2e1269@linux.vnet.ibm.com>
In-Reply-To: <26fb7103-737a-7dcf-7243-4de23555098d@redhat.com>
References: <26fb7103-737a-7dcf-7243-4de23555098d@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--Q5lQsFlNUsqLWF10ZQQcWVOUBxhOD7gi0"
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q5lQsFlNUsqLWF10ZQQcWVOUBxhOD7gi0
Content-Type: multipart/mixed; boundary="wNQZhch9cnuMLb3x0TgYITrRmVxs1aIeY";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>
Message-ID: <7eea1d04-40d4-4557-9344-efbc2e2e1269@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/2] KVM: document KVM_CAP_S390_[BPB|PSW|GMAP|COW]
References: <20180223111025.130315-1-borntraeger@de.ibm.com>
 <20180223111025.130315-2-borntraeger@de.ibm.com>
In-Reply-To: <20180223111025.130315-2-borntraeger@de.ibm.com>

--wNQZhch9cnuMLb3x0TgYITrRmVxs1aIeY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 23.02.2018 12:10, Christian Borntraeger wrote:
> commit 35b3fde6203b ("KVM: s390: wire up bpb feature") has no
> documentation for KVM_CAP_S390_BPB. While adding this let's also add
> other missing capabilities like KVM_CAP_S390_PSW, KVM_CAP_S390_GMAP and=

> KVM_CAP_S390_COW.

Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>

>=20
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  Documentation/virtual/kvm/api.txt | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>=20
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/=
kvm/api.txt
> index e5f1743e0b3e..e48a91ca24b6 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -4419,3 +4419,33 @@ Parameters: none
>  This capability indicates if the flic device will be able to get/set t=
he
>  AIS states for migration via the KVM_DEV_FLIC_AISM_ALL attribute and a=
llows
>  to discover this without having to create a flic device.
> +
> +8.14 KVM_CAP_S390_PSW
> +
> +Architectures: s390
> +
> +This capability indicates that the PSW is exposed via the kvm_run stru=
cture.
> +
> +8.15 KVM_CAP_S390_GMAP
> +
> +Architectures: s390
> +
> +This capability indicates that the user space memory used as guest map=
ping can
> +be anywhere in the user memory address space, as long as the memory sl=
ots are
> +aligned and sized to a segment (1MB) boundary.
> +
> +8.16 KVM_CAP_S390_COW
> +
> +Architectures: s390
> +
> +This capability indicates that the user space memory used as guest map=
ping can
> +use copy-on-write semantics as well as dirty pages tracking via read-o=
nly page
> +tables.
> +
> +8.17 KVM_CAP_S390_BPB
> +
> +Architectures: s390
> +
> +This capability indicates that kvm will implement the interfaces to ha=
ndle
> +reset, migration and nested KVM for branch prediction blocking. The st=
fle
> +facility 82 should not be provided to the guest without this capabilit=
y.
>=20



--wNQZhch9cnuMLb3x0TgYITrRmVxs1aIeY--

--Q5lQsFlNUsqLWF10ZQQcWVOUBxhOD7gi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJak8AVAAoJEBcO/8Q8ZEV5JSoP+wTKA6Q5eYq+bvjq+fECFGmI
lbWJx5qINIu91DhCEMGpM2QOS/A7hbgWr/znXYfpHB2BYxnh93df2gEvUeooFPsf
pAOHcqliVUNEMKw/4hqxn+ab5gmypfwN/9/RsHA8hdcJ4Kez/WXOU7X8EqrNMB1E
KZ8fTnQ+e/6U9Tv0HKSnBWPAQlX8Qfn/zW/Xm+gc5FwK7sZ7v/urBTbISbdnJsoO
POghlUckZDSrxE4wJyNd16tl1ocrkD7bm3ay42+hK6KkEva6ngtXnpWB3EWOXciu
YJ2fUmfmqOsX9Pshv362WVAQjdYBoSGKA362adSkzve5AfmML56jieeWLiCVZG3/
jLIAcjjcUBLlIGzyOfbGwUF5BV7D9XHzVXhcy+poYrEtMtof5bbvYh9AoHzLd9pa
EZqiCVVBVI2odDYTV1nanTN42mCS6Bk/jZC3tyXwnFRzt3dGX2Evf0Taz6PIHPsT
N0KFq+UI2RVsiy+qsoJlqkuDttSE+4pt3tg2Jl17sCTr8OGllf36iw1b0wJyCMPM
ix1ya04RR+VHowYaMBQjA1j7vDig16lGb+M6fhbBu/bvApqDTu9fDwhLlaznwacA
MTQUdCoke9n/2C0hjSBKHLKdKt9KB9Dm1KsCAIgLHNsmDKAHJbuU6HlhKFoWwxDz
kS+1wh2pdSA/oFzpbziH
=fM1A
-----END PGP SIGNATURE-----

--Q5lQsFlNUsqLWF10ZQQcWVOUBxhOD7gi0--
