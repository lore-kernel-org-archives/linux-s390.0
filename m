From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 31 Oct 2018 08:58:52 +0000
Subject: Re: [PATCH 05/10] KVM: s390: add function unlink_gib_alert_list()
Message-Id: <00721da8-79b1-678c-322e-f0c5ac47028e@linux.ibm.com>
In-Reply-To: <da9d09f3-c488-250f-8eb5-bdac5d609444@linux.ibm.com>
References: <da9d09f3-c488-250f-8eb5-bdac5d609444@linux.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--qt3nJ1uZ9TFZHIGRGDohfSrQepiQ4hfzy"
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qt3nJ1uZ9TFZHIGRGDohfSrQepiQ4hfzy
Content-Type: multipart/mixed; boundary="NljoN4AVzlgUbcsMWiiL6gKdItu2TAv0z";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Michael Mueller <mimu@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Sebastian Ott <sebott@linux.ibm.com>,
 Peter Oberparleiter <oberpar@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>,
 Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <00721da8-79b1-678c-322e-f0c5ac47028e@linux.ibm.com>
Subject: Re: [PATCH 05/10] KVM: s390: add function unlink_gib_alert_list()
References: <20181025123751.48809-1-mimu@linux.ibm.com>
 <20181025123751.48809-6-mimu@linux.ibm.com>
In-Reply-To: <20181025123751.48809-6-mimu@linux.ibm.com>

--NljoN4AVzlgUbcsMWiiL6gKdItu2TAv0z
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.10.18 14:37, Michael Mueller wrote:
> The function atomically returns the address of the first
> GISA of this list and stores a zero address in the origin
> list field of the GIB instead.
>=20
> The GIB alert list contains all GISAs that have pending
> adapter interruptions.
>=20
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>

That's a trivial seven line function, which you start using in patch #9
and you need to add __maybe_unused so it keeps compiling.

Please squash that.

> ---
>  arch/s390/kvm/interrupt.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index ce258d6b7c06..487cad95e2c9 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -2886,6 +2886,14 @@ int kvm_s390_get_irq_state(struct kvm_vcpu *vcpu=
, __u8 __user *buf, int len)
>  	return n;
>  }
> =20
> +static struct kvm_s390_gisa __maybe_unused *unlink_gib_alert_list(void=
)
> +{
> +	if (!gib)
> +		return NULL;
> +
> +	return (void *)(u64) atomic_xchg(&gib->alert_list_origin, 0);
> +}
> +
>  static void nullify_gisa(struct kvm_s390_gisa *gisa)
>  {
>  	memset(gisa, 0, sizeof(struct kvm_s390_gisa));
>=20



--NljoN4AVzlgUbcsMWiiL6gKdItu2TAv0z--

--qt3nJ1uZ9TFZHIGRGDohfSrQepiQ4hfzy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJb2W7MAAoJEONU5rjiOLn4D9wQAKUFV3ao8d4AYutG6gsXrEWy
1JMpczC1MUzRWynXxrnpHeO2KnSy0u//pp4OGp5d4M3tm7FCkSgnLOlcvIZnpjmB
eYJQuhbSojxMB844Ds55IqOW4qrye4hMOj7A/Xf/eg1NMk5WkbUt8+fyjT3WXqb2
IjtkzLfgspJ4lCzmQSWRQtD3rCfCBQdEYi51XB0xY1Mprphzz6fstRFkooeX99yJ
gBQrenTneh0FB4As5AVe/qyM3cKa8glNcmr0ekTKYasEufpHfCq/FG7R8E5yugbs
hSogAH+Skoh+hQA6R9FayCT/+Ixa2RBlT0UErMXu+ksJyZ8S0NyornjT49vBJVEz
gA93C4ROaGAgfXaTWp1c+qF1La4uPOp0HL8kfAz4zyoG++3PHIbuXx/SNiZ9xAzT
h1YQf9r3PuhnTpnxyj2EC7/AuUD89+OD5aa12bF0+0vGevuNfkpa/bXvS7m9EXLM
OugLWnnTVEo5ZTnJa9zqc1vjV4outa5iIfEUYs+nUKWofEk3ULoHe04R5Rln6T/y
dmn1cDIe0zcAFikLW9hM89l/7fQETFc1ETqgChLM/5dx41/8WTyKjX4FU57wwy5p
BRq/p2GlhhjzDsMZ5CPyuxlnWydnyrDKbwFlInyBC5EahHsvV+FOo8ruxsqnlErG
a4ZzJu8PlfqXU0QJRxWL
=ENF3
-----END PGP SIGNATURE-----

--qt3nJ1uZ9TFZHIGRGDohfSrQepiQ4hfzy--
