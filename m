From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 27 Jul 2018 11:53:13 +0000
Subject: Re: [PATCH] s390: mm: Introduce pmd_map_alloc
Message-Id: <96d080ff-74bc-5c02-95a4-0cddba7fd854@linux.ibm.com>
In-Reply-To: <036a3afc-6342-24ed-f5b7-31ce111f34b2@redhat.com>
References: <036a3afc-6342-24ed-f5b7-31ce111f34b2@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--ptzXfQAJX4IY3IvX6UjPnJAWJ46nkmWJM"
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ptzXfQAJX4IY3IvX6UjPnJAWJ46nkmWJM
Content-Type: multipart/mixed; boundary="XELgl7iKGqstyCO0fhTUDjaDzoLgxIa7j";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: schwidefsky@de.ibm.com
Cc: borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com
Message-ID: <96d080ff-74bc-5c02-95a4-0cddba7fd854@linux.ibm.com>
Subject: Re: [PATCH] s390: mm: Introduce pmd_map_alloc
References: <20180727105551.72804e05@mschwideX1>
 <20180727093737.136714-1-frankja@linux.ibm.com>
In-Reply-To: <20180727093737.136714-1-frankja@linux.ibm.com>

--XELgl7iKGqstyCO0fhTUDjaDzoLgxIa7j
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27.07.2018 11:37, Janosch Frank wrote:
> I'd squash this into the emulation patch.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

And I just removed the mm/hugetlb.h includes from pgtable.c (with v2 of
this patch) and gmap.c (from the dirty sync patch).

I just pushed hlp_vsie on korg, not gonna resend.

@Martin: Getting a rev/ack-by for the skey emulation and faulting would
be nice. I'd push this to devel mid of next week.


--XELgl7iKGqstyCO0fhTUDjaDzoLgxIa7j--

--ptzXfQAJX4IY3IvX6UjPnJAWJ46nkmWJM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJbWwewAAoJEBcO/8Q8ZEV50sMP/3RnsB8A7ai8BUHeu94QabyN
sQO2HIyxkdqBkgVNDWlc6Xo7YpH2tQ5hgY6Ahgdmt3xFw0BMJBss4Q4y+ybnepnY
s43CYKUNfMqpmIAB3/4hW1HLnY9/rCn03sVR1Bd0L+2LFWgqq7Q/Szg/3ofS6EYj
jn0qz2ILKrSro02ayjWQ9jqnLCXuvPMfTDv54n99D3NmHlYbqlICg4rN9khwobUw
Gi66ufDTN5kvbUmry1O0DS47Zciu1XoqF0Jni3a04m5UfSATbQRYi8z15ulFRQV+
JHV9C2Fo2f4hTzhG0ZQ+XCKNC1ejyxm7e3WnBfIey3EuXaBTSDr8+TPnD+3SKm2W
JtvKyRQNAVqa6eMY6ilfnjqn8ZleU6lDd0POr9IOXZCiznApywpIqKLefH0U7yXf
OQqeHrYJTuYuhjoT1Qfp3qOx8whvS3WQtt0uieQjR7WWtyIPfZQ4pRr3DI06M7/E
Kb0QRis/t/vJrCOA/Cig9ZvZMJBKvLGBRw3+MpKgWaPxFpfkdX+/rqgmIplAyN17
evfJ2rO7hKFpZkHwE+QOuTjcgTDOjw/MraMHfyNICoYcxacJsg27qXi0HRdnQqG8
57GqP9XQJGZgCwaHQ1RxEn5ynTQdJAQbE0HhCCshrsneIMRaJo4HXM1f8x46ogbb
d+ESCH2BY3r997xz0KCf
=sqJY
-----END PGP SIGNATURE-----

--ptzXfQAJX4IY3IvX6UjPnJAWJ46nkmWJM--
