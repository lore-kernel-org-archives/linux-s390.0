From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v2 03/22] s390/mm: add gmap PMD invalidation
 notification
Date: Thu, 21 Dec 2017 10:24:49 +0100
Message-ID: <39bdadc5-422a-84b8-fdd3-6620e4432686@linux.vnet.ibm.com>
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1513169613-13509-4-git-send-email-frankja@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HYPN8ixaUYLi45Ov3hzKQUrE4Kx8iE2MR"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1513169613-13509-4-git-send-email-frankja@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HYPN8ixaUYLi45Ov3hzKQUrE4Kx8iE2MR
Content-Type: multipart/mixed; boundary="bYkNTJ3hwoJ9FJ1SIMXrp85OWQwXY3z64";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com,
 dominik.dingel@gmail.com, linux-s390@vger.kernel.org
Message-ID: <39bdadc5-422a-84b8-fdd3-6620e4432686@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v2 03/22] s390/mm: add gmap PMD invalidation
 notification
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1513169613-13509-4-git-send-email-frankja@linux.vnet.ibm.com>
In-Reply-To: <1513169613-13509-4-git-send-email-frankja@linux.vnet.ibm.com>

--bYkNTJ3hwoJ9FJ1SIMXrp85OWQwXY3z64
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.12.2017 13:53, Janosch Frank wrote:
[...]
>  #define GMAP_NOTIFY_SHADOW	0x2
>  #define GMAP_NOTIFY_MPROT	0x1
>=20
> +/* Status bits in the gmap segment entry. */
> +#define _SEGMENT_ENTRY_GMAP_IN		0x0001	/* invalidation notify bit */
> +
>  /**
>   * struct gmap_struct - guest address space
>   * @list: list head for the mm->context gmap list
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pg=
table.h
> index 57d7bc9..ba3840c 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -269,8 +269,10 @@ static inline int is_module_addr(void *addr)
>  #define _REGION_ENTRY_BITS_LARGE 0xffffffff8000fe2fUL
>=20
>  /* Bits in the segment table entry */
> -#define _SEGMENT_ENTRY_BITS	0xfffffffffffffe33UL
> -#define _SEGMENT_ENTRY_BITS_LARGE 0xfffffffffff0ff33UL
> +#define _SEGMENT_ENTRY_BITS			0xfffffffffffffe33UL
> +#define _SEGMENT_ENTRY_BITS_LARGE 		0xfffffffffff0ff33UL
> +#define _SEGMENT_ENTRY_HARDWARE_BITS		0xfffffffffffffe30UL
> +#define _SEGMENT_ENTRY_HARDWARE_BITS_LARGE 	0xfffffffffff00730UL
>  #define _SEGMENT_ENTRY_ORIGIN_LARGE ~0xfffffUL /* large page address	 =
   */
>  #define _SEGMENT_ENTRY_ORIGIN	~0x7ffUL/* page table origin		    */
>  #define _SEGMENT_ENTRY_PROTECT	0x200	/* segment protection bit	    */

@Martin: Are these constants fine with you?

The whitespace damage that gets fixed in the next patch is already
addressed in the next version :)


--bYkNTJ3hwoJ9FJ1SIMXrp85OWQwXY3z64--

--HYPN8ixaUYLi45Ov3hzKQUrE4Kx8iE2MR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaO33iAAoJEBcO/8Q8ZEV5FaQQALhV9sELcK6qjvbl1dZ4u/Pq
B/mWkD7pGqp5Zi9IC++gQtkKmupJXoYgn4+Cmmz1MxBt4OiL2Nmp5/n5TPe92sYC
XbbTg62NB8O8so7tlgVrTjVXvwt0r3sD/rI/tQTrMj5+GTfEOg3Mb41P0Hyi37Sd
0ebFQK1z42F42tFvAUAtZSi00Ynh8bEoRx7PWjI8Iu6cHcV2d86k8wez0awT7SCO
ZkTKGkO/xwGZi+Q3jjVn1Xovy4NG5uuQRuL9Wok5YdHtHfMUuSjzybC9NIsyQryr
Yi9EngLU7AQCFvYyFmJYw2GfGT6iPNhWEwc4LIN/rF19h6TsN1Q9A4aSeVFsEknc
gBu5AMwCjTECisABhKWD+lI+7ATyYwMBbrIkfbYLkK+bR35ugoN1f2l79ejXRTaI
mBBQkxvGgojM0OJZbmjlkAOQwfWgY1WrNx8ie9xUxLq/D17q0QNyUQZXCRAMGGrh
wE+lHYaU46qTx3tRQ+PFqvI780TVxLb/wBIq3ChYa/Mv+tOBvTBOnB0ixS2vaMBu
EmtNJBFzUFF9ny717OFsCl6FQYSGJH/+1EoIi0PxgOyLq2T6r/nTPI7ldbNp0wJI
blq3EvVGqIf9hLfGxzHOQHwy/3KI/H5OAGGeJ6rEKi8IQIiKcTtMdJbxvDd3biiK
5SZCKv3JDJ3b+mRKPOFa
=B/iD
-----END PGP SIGNATURE-----

--HYPN8ixaUYLi45Ov3hzKQUrE4Kx8iE2MR--
