From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 15 Aug 2018 14:36:20 +0000
Subject: Re: [bug report] s390/mm: hugetlb pages within a gmap can not be freed
Message-Id: <2473cb94-7806-26ec-484d-a5528d26c483@linux.ibm.com>
In-Reply-To: <20180807165841.2tz3nlkry2xycshg@kili.mountain>
References: <20180807165841.2tz3nlkry2xycshg@kili.mountain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--Qa6N6qVB3Hd7CRpkMFW01twJ6lyBBkAb2"
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Qa6N6qVB3Hd7CRpkMFW01twJ6lyBBkAb2
Content-Type: multipart/mixed; boundary="8FaWR2X1rgxBWeQNUj9iwzOm5f3T1ZNwM";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Dan Carpenter <dan.carpenter@oracle.com>, dingel@linux.vnet.ibm.com
Cc: linux-s390@vger.kernel.org
Message-ID: <2473cb94-7806-26ec-484d-a5528d26c483@linux.ibm.com>
Subject: Re: [bug report] s390/mm: hugetlb pages within a gmap can not be
 freed
References: <20180807165841.2tz3nlkry2xycshg@kili.mountain>
In-Reply-To: <20180807165841.2tz3nlkry2xycshg@kili.mountain>

--8FaWR2X1rgxBWeQNUj9iwzOm5f3T1ZNwM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.08.2018 18:58, Dan Carpenter wrote:
> Hello Dominik Dingel,
>=20
> This is a semi-automatic email about new static checker warnings.

Hi Dan,

while Dominik wrote the patch, he is unfortunately not available anymore
and I take care of that part of s390 mm right now. Sorry I missed this
mail, I do not read on this list often.

>=20
> The patch 7d735b9ae82d: "s390/mm: hugetlb pages within a gmap can not=20
> be freed" from Jul 13, 2018, leads to the following Smatch complaint:
>=20
>     arch/s390/mm/gmap.c:718 gmap_discard()
>      error: we previously assumed 'vma' could be null (see line 715)>
> arch/s390/mm/gmap.c
>    700          for (gaddr =3D from; gaddr < to;
>    701               gaddr =3D (gaddr + PMD_SIZE) & PMD_MASK) {
>    702                  /* Find the vm address for the guest address */=

>    703                  vmaddr =3D (unsigned long)
>    704                          radix_tree_lookup(&gmap->guest_to_host,=

>    705                                            gaddr >> PMD_SHIFT);
>    706                  if (!vmaddr)
>    707                          continue;
>    708                  vmaddr |=3D gaddr & ~PMD_MASK;
>    709                  /* Find vma in the parent mm */
>    710                  vma =3D find_vma(gmap->mm, vmaddr);
>    711                  /*
>    712                   * We do not discard pages that are backed by
>    713                   * hugetlbfs, so we don't have to refault them.=

>    714			 */
>    715			if (vma && is_vm_hugetlb_page(vma))
>                             ^^^
> The patch adds a new check

Theoretically userspace could unmap an area that is mapped by the gmap
to a guest without the gmap unmap calls, hence vmaddr would be valid and
vma =3D=3D NULL.

Thanks for semi-automatically reporting this, I'll provide a fix.

>=20
>    716				continue;
>    717			size =3D min(to - gaddr, PMD_SIZE - (gaddr & ~PMD_MASK));
>    718			zap_page_range(vma, vmaddr, size);
>                                        ^^^
> but if "vma" is NULL we are toasted here anyway.
>=20
>    719		}
>    720		up_read(&gmap->mm->mmap_sem);
>=20
> regards,
> dan carpenter
> --
> To unsubscribe from this list: send the line "unsubscribe linux-s390" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20



--8FaWR2X1rgxBWeQNUj9iwzOm5f3T1ZNwM--

--Qa6N6qVB3Hd7CRpkMFW01twJ6lyBBkAb2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJbdDpkAAoJEBcO/8Q8ZEV5+d0P/03j5pmPmVgaxE4zS2SdSuz8
eGzSj7MIWqwyz1X4BBp30QEz4J7v9iFpbGD76KdsLRT+rDNzpFEzrh85zoPlszYx
LkgLXwb0J22BUOjtG8APesfk/V5B3OUd+IX0C/yEWQJImE9uOjqK6RgszUh9wU4p
UUvoRyor0vhvrFSIucNYZQHN/wlXd9MH/iKz9fRWjwMKfdd45AaKnBiaEtmg7byN
jGruJ9Cbf/t7tKVIpXoqoxpUBpyiLxU2h5OWFqLwjPK9D3FnX9KHV5vcxDp2b0+w
pmxLChjAYewkqTQttFIPhiNH1YZZSeVZN/3BtYNBTnUU7eOD3382bGc0oDEDBOW0
rmZdtcuV3eFP9ijV1kZObevV/ofJ1zKBQfI6TVb8q4q49ACXJDScWy5H1JZKoSS6
QM5g4X9ZD7O1uR5HwUJPf4ophw51cZFipuVdDQp051GAaFrdn9pQrvo87TM7wnv6
5bO1n/Eo2W1cb3Po3Kx7tb8ND1JiU5qg5X0kPSoPz89kfJf3sinq5c5jG2+L3JVU
9Fkm+vGDWzqvGgwJeC2lJCF6UFfAcui8exM4p3t8AxD9sK48wd14VZ4sVFVT2l8M
ROeodAi0NPm/YeHrvNQJnLKFpVcV94gpAVRdGkuGyf+nD6mBXdnClb02XbEP3uYI
d0a7IUPi5b4KoRNhrIkR
=zPP4
-----END PGP SIGNATURE-----

--Qa6N6qVB3Hd7CRpkMFW01twJ6lyBBkAb2--
