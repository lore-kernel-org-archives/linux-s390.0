From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v2 11/22] s390/mm: Remove superfluous parameter
Date: Thu, 21 Dec 2017 10:22:18 +0100
Message-ID: <cd57a116-dd73-033c-2298-3b78ea6c4f92@linux.vnet.ibm.com>
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1513169613-13509-12-git-send-email-frankja@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uqMjcfXz8huy3NVQ0BwbjO4xT3dj8Uq4V"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1513169613-13509-12-git-send-email-frankja@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uqMjcfXz8huy3NVQ0BwbjO4xT3dj8Uq4V
Content-Type: multipart/mixed; boundary="FxNnl2J37Lah1Ntt7mjtqadYeG3RJfLYc";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com,
 dominik.dingel@gmail.com, linux-s390@vger.kernel.org
Message-ID: <cd57a116-dd73-033c-2298-3b78ea6c4f92@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v2 11/22] s390/mm: Remove superfluous parameter
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1513169613-13509-12-git-send-email-frankja@linux.vnet.ibm.com>
In-Reply-To: <1513169613-13509-12-git-send-email-frankja@linux.vnet.ibm.com>

--FxNnl2J37Lah1Ntt7mjtqadYeG3RJfLYc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.12.2017 13:53, Janosch Frank wrote:
> It seems it hasn't even been used before the last cleanup and was
> overlooked.

This one is an independent cleanup.

Can we move this out of this series and schedule it for earlier
inclusion into mainline?

>=20
> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> ---
>  arch/s390/mm/gmap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index ffc11d8..d396da8 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -2237,7 +2237,7 @@ EXPORT_SYMBOL_GPL(gmap_shadow_page);
>   * Called with sg->parent->shadow_lock.
>   */
>  static void gmap_shadow_notify(struct gmap *sg, unsigned long vmaddr,
> -			       unsigned long gaddr, pte_t *pte)
> +			       unsigned long gaddr)
>  {
>  	struct gmap_rmap *rmap, *rnext, *head;
>  	unsigned long start, end, bits, raddr;
> @@ -2322,7 +2322,7 @@ void ptep_notify(struct mm_struct *mm, unsigned l=
ong vmaddr,
>  			spin_lock(&gmap->shadow_lock);
>  			list_for_each_entry_safe(sg, next,
>  						 &gmap->children, list)
> -				gmap_shadow_notify(sg, vmaddr, gaddr, pte);
> +				gmap_shadow_notify(sg, vmaddr, gaddr);
>  			spin_unlock(&gmap->shadow_lock);
>  		}
>  		if (bits & PGSTE_IN_BIT)
>=20



--FxNnl2J37Lah1Ntt7mjtqadYeG3RJfLYc--

--uqMjcfXz8huy3NVQ0BwbjO4xT3dj8Uq4V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaO31KAAoJEBcO/8Q8ZEV5QLYQAJR2KMSMxteMT/X3lEi4ULdO
oBavjz+/u4H8aQfVnCbzEFYFIQwyF6QSd3R9mrLFkGS+w6uVwgNXOGQudHbCdZZI
y7vUdqQcviXVBHf+Snx3t3NUeqR5eXWq+PN+F2am56fTjv42htd4AUStK0MExkVH
A4wY8hyFFVOd4pBawJCKGQEvC7zjigY+m0RayBKmmj4bXgnJhOIXhzb6cVSfanim
XgRfjxUGfZRikwE6RfBU2VHYbnMKvJp7uw/RVrKy+3tWbpCjKyxuqDzGBnG6voLP
NJISUxPCZ9ipJp4yFubr5uDVBQPuc+C5AKPIR/cnwdmtDbjm3d9Y/1nnMh6joiB5
Qc+D9UT71Qhlbh9zmq6SZ1BNx3qHzuiFCSqTMB3pIQ0VbeMJGMtT7qFTXaNa24je
ngXr/BfYMecjwdpOa6rocaPa03MnP1ymhzFZ3lD5vEWm50muIUusztw26lhpu77q
2m3v8QJf9A/Orpqf6C6d1WjV4CH9LubBH7T3cNOtnQf6GelqtK5vUbEVR/2DLEhZ
fhZRXedNb430+MUSuc/5ZlZp+EGcf0WPNloEWkL19xCVTFuv2ptUALvTLyU5hXw3
4bG0j2EhzyfiqJhjDm/I9lkxMSen/7vCxE/j7/QguLchu+Z8WvMsXBP3WaW4FaNd
aiKZ9EqLIkAPfKo8hSff
=7uXU
-----END PGP SIGNATURE-----

--uqMjcfXz8huy3NVQ0BwbjO4xT3dj8Uq4V--
