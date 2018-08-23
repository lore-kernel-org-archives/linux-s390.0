From: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v3 0/3] KVM: s390: vsie: Consolidate CRYCB validation
Date: Thu, 23 Aug 2018 15:16:07 +0200
Message-ID: <e0ce50d0-81e1-d790-ef15-08eb99576729@linux.ibm.com>
References: <1535019956-23539-1-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4AufDwxOAF4Deib5VEREhQv3Ge5f7DSyp"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1535019956-23539-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, david@redhat.com
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, akrowiak@linux.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4AufDwxOAF4Deib5VEREhQv3Ge5f7DSyp
Content-Type: multipart/mixed; boundary="hQvCgm1dOeyLQsA2n7H7dWQrbJ34mw798";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Pierre Morel <pmorel@linux.ibm.com>, david@redhat.com
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com,
 linux-s390@vger.kernel.org, kvm@vger.kernel.org, akrowiak@linux.ibm.com,
 borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Message-ID: <e0ce50d0-81e1-d790-ef15-08eb99576729@linux.ibm.com>
Subject: Re: [PATCH v3 0/3] KVM: s390: vsie: Consolidate CRYCB validation
References: <1535019956-23539-1-git-send-email-pmorel@linux.ibm.com>
In-Reply-To: <1535019956-23539-1-git-send-email-pmorel@linux.ibm.com>

--hQvCgm1dOeyLQsA2n7H7dWQrbJ34mw798
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/23/18 12:25 PM, Pierre Morel wrote:
> Before adapting the CRYCB shadowing for a guest supporting
> the AP instructions we want to clean the CRYCB shadowing code.
>=20
> First patch seem obvious.
>=20
> Second patch introduce a change in the behavior of
> the virtual machine in that the CRYCB is validated
> whenever we use or not the key masks to mimic the
> real machine.
>=20
> Patch 3 does not correct the compiled code but make
> more clear what is done concerning the formating of
> the CRYCB in the guest original CRYCB and in the
> shadow CRYCB.
>=20

Thanks, applied.


--hQvCgm1dOeyLQsA2n7H7dWQrbJ34mw798--

--4AufDwxOAF4Deib5VEREhQv3Ge5f7DSyp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJbfrOXAAoJEBcO/8Q8ZEV5WO0P/RKEf6WEQ/l3QNRj5glgaGAc
RQNcE4+mwGZbSyINuGr8aoPOwMZTTt/EBMnhYt+tg+wWXS9iJErtvVeyOX7Cfi2Q
4nrfQQsdH8Pb89YqvyjReUSkpcj1+MEOYjH8DTkGc0j9P1+1xAZ2RY49HxgZbzOS
9q8fEGORe2tX0GXnkv0XxHHePzOt/lxycjL51nNT+qf3IFAMtCnnAs+ETp2VBCdu
hgIegzQQAlNFHg17lZRZRGBL8Yyv+fLuiHHtC6miOjtyqEWxjSiZRlWeSm2EDpGZ
fWJXw3ouAo5/ab6gMrLEK7pYmhZb9O/x4dXitpkhP3wNua4IFoHXaXd9/KGW5GON
Pad1pkCTDjMtGPrOCPgLCxL86YMvMz7OQonI1lEL1R+KERGT1j8I5biSOp7Eh7AZ
GaT/PYgJV5vydB1iett6+N6ufA9D2wEvznXFVZs/0O4kHSz+mAjdGTs6DejWbOTX
/cKDUMXlnMPwYj7vBy+Y9NkrJskJ/26+eXlhJoW9lVr85q1Lal78sbajJ6Con/EA
fvk1TEa+EANNc4NNFfvCHneqzDN7Ip6a9UvNGLHC4Y/YwBYNIk9JdM5VulyD5sWx
cLY+SbNO0ArgC4Xmm3vf+wMAC4f14UMirUtXwhiawYGTSuCNTL/29K+IvlVLhvnF
v8E9/HHGOnrFAo17dMXt
=vbBn
-----END PGP SIGNATURE-----

--4AufDwxOAF4Deib5VEREhQv3Ge5f7DSyp--
