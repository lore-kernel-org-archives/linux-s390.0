From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 31 Oct 2018 08:56:21 +0000
Subject: Re: [PATCH 02/10] KVM: s390: add the GIB and its related life-cyle functions
Message-Id: <95e038f1-8d7b-bc9d-c553-bacbcc6d4410@linux.ibm.com>
In-Reply-To: <9461bcea-b3d2-2bd9-8408-8565d7de067e@de.ibm.com>
References: <9461bcea-b3d2-2bd9-8408-8565d7de067e@de.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--XDjQN55Lte2ZufrDHe7XirFdE1xIorgNl"
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XDjQN55Lte2ZufrDHe7XirFdE1xIorgNl
Content-Type: multipart/mixed; boundary="SjT5KeSPysEhjjRofzUUrumk4oX3hRDaq";
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
Message-ID: <95e038f1-8d7b-bc9d-c553-bacbcc6d4410@linux.ibm.com>
Subject: Re: [PATCH 02/10] KVM: s390: add the GIB and its related life-cyle
 functions
References: <20181025123751.48809-1-mimu@linux.ibm.com>
 <20181025123751.48809-3-mimu@linux.ibm.com>
In-Reply-To: <20181025123751.48809-3-mimu@linux.ibm.com>

--SjT5KeSPysEhjjRofzUUrumk4oX3hRDaq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.10.18 14:37, Michael Mueller wrote:
> The GIB (Guest Information Block) links the GISA of all guests
> that have adapter interrupts pending. These interrupts cannot be
> deliverd because no vcpu of these guests is currently running in
> SIE context. Instead, a GIB alert is issued on the host to schedule
> these guests to run.
>=20
> This mechanism allows to process adapter interrupts for currently
> not running guests.
>=20
> The GIB is created during host initialization and associated with
> the Adapter Interruption Facility in case an Adapter Interruption
> Virtualization Facility is available.
>=20
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---

>  /*
>   * sie_page2 has to be allocated as DMA because fac_list, crycb and
>   * gisa need 31bit addresses in the sie control block.
> @@ -829,6 +838,7 @@ struct kvm_arch{
>  	/* subset of available cpu features enabled by user space */
>  	DECLARE_BITMAP(cpu_feat, KVM_S390_VM_CPU_FEAT_NR_BITS);
>  	struct kvm_s390_gisa *gisa;
> +	int gib_in_use;
>  };

That's a kvm wide value, right? But here we save it per VM.
Is that really necessary or am I missing something?


--SjT5KeSPysEhjjRofzUUrumk4oX3hRDaq--

--XDjQN55Lte2ZufrDHe7XirFdE1xIorgNl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJb2W41AAoJEONU5rjiOLn47IoP/A6WyM3+0TFkzBHrvbX7n/gI
NbaV3+ifH65fIk2vbo1jskoW/Er4AcnhC+3vcMJwkIpKUWfq/8EaoRWzdFUM3xvg
1Jydb0n9RZ9RPnH2mKxTmIZOm5SUrxScicTI0yc0bEO1ktySnJRxU44ZULEQSbrE
pLGVJScg+kfJrM653d0njL0LctanPoxvzE6C1ktWIK9LiL1nsxPkjoVH3YQQDoms
++s/V2QuY4ue2qCBuGBOc5WXt+fNqfvdn52zplTFm07kmVSasApSZ2nwa7Vfbnb5
yoyop1QO68Hd5QAvwYNFX2dL3Qk8uqcnxlx5tV8ejArxfGv3M/wuDQaul7muPQTN
RG7F7zCALDIRmYZK2/CXu85bIINnI9D4P1Lw8NnIxGUBSkw7dYHwoDPPZ7LRZmBb
BhicHtSmOnlJDyHCpMuUPj7Qh55j/UraoblZ5igP2OJMr2OyA04QYyKWNWq0aOIX
nNugzb7KzHDM0OWEyAtfNl5eQNGiE7iJu0xMBLgPKh+WwIHXTzezcLalxDUjX+K6
l1gmyf/E7B5nSlHo4F+O/wGOcS3dHZiO0ua72J7rF8u03tK2QgX4H2KRSdTrOVob
C1uAb0jGWiBQ7dGmafldoH8i8ncsQ+6D56caf0ocX/0DNXMpuLoZS8Rk9NHU3Huc
j80zWt3YOE1djDIvYzbN
=MBPT
-----END PGP SIGNATURE-----

--XDjQN55Lte2ZufrDHe7XirFdE1xIorgNl--
