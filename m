Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33024 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725890AbgAUM73 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Jan 2020 07:59:29 -0500
Date: Tue, 21 Jan 2020 13:59:11 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v3 7/9] s390x: smp: Remove unneeded cpu
 loops
Message-ID: <20200121135911.4d41c418.cohuck@redhat.com>
In-Reply-To: <f0f17e60-29b6-12b1-6692-5da745cbe60a@linux.ibm.com>
References: <20200117104640.1983-1-frankja@linux.ibm.com>
        <20200117104640.1983-8-frankja@linux.ibm.com>
        <20200120122956.6879d159.cohuck@redhat.com>
        <97f7f794-e0be-3984-99b2-ba229212fd3e@linux.ibm.com>
        <20200120171113.02a9b807.cohuck@redhat.com>
        <f0f17e60-29b6-12b1-6692-5da745cbe60a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tYO2X2MnfQU=Wv__KgGonT6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com

--Sig_/tYO2X2MnfQU=Wv__KgGonT6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Jan 2020 13:46:51 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 1/20/20 5:11 PM, Cornelia Huck wrote:
> > On Mon, 20 Jan 2020 15:41:52 +0100
> > Janosch Frank <frankja@linux.ibm.com> wrote:
> >  =20
> >> On 1/20/20 12:29 PM, Cornelia Huck wrote: =20
> >>> On Fri, 17 Jan 2020 05:46:38 -0500
> >>> Janosch Frank <frankja@linux.ibm.com> wrote:
> >>>    =20
> >>>> Now that we have a loop which is executed after we return from the
> >>>> main function of a secondary cpu, we can remove the surplus loops.
> >>>>
> >>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> >>>> ---
> >>>>  s390x/smp.c | 8 +-------
> >>>>  1 file changed, 1 insertion(+), 7 deletions(-)
> >>>>
> >>>> diff --git a/s390x/smp.c b/s390x/smp.c
> >>>> index 555ed72..c12a3db 100644
> >>>> --- a/s390x/smp.c
> >>>> +++ b/s390x/smp.c
> >>>> @@ -29,15 +29,9 @@ static void wait_for_flag(void)
> >>>>  =09}
> >>>>  }
> >>>> =20
> >>>> -static void cpu_loop(void)
> >>>> -{
> >>>> -=09for (;;) {}
> >>>> -}
> >>>> -
> >>>>  static void test_func(void)
> >>>>  {
> >>>>  =09testflag =3D 1;
> >>>> -=09cpu_loop();
> >>>>  }
> >>>> =20
> >>>>  static void test_start(void)
> >>>> @@ -234,7 +228,7 @@ int main(void)
> >>>> =20
> >>>>  =09/* Setting up the cpu to give it a stack and lowcore */
> >>>>  =09psw.mask =3D extract_psw_mask();
> >>>> -=09psw.addr =3D (unsigned long)cpu_loop;
> >>>> +=09psw.addr =3D (unsigned long)test_func;   =20
> >>>
> >>> Before, you did not set testflag here... intended change?   =20
> >>
> >> Yes
> >> It is set to 0 before the first test, so it shouldn't matter. =20
> >=20
> > Hm... I got a bit lost in all those changes, so I checked your branch
> > on github, and I don't see it being set to 0 before test_start() is
> > called? =20
>=20
> Well, that's because test_start doesn't care about the flag.

But I see a wait_for_flag() in there? What am I missing?

> ecall and emcall are the first users, and they set it to 0 before using i=
t.
>=20
> >  =20
> >> =20
> >>>    =20
> >>>>  =09smp_cpu_setup(1, psw);
> >>>>  =09smp_cpu_stop(1);
> >>>>     =20
> >>>    =20
> >>
> >> =20
> >  =20
>=20
>=20


--Sig_/tYO2X2MnfQU=Wv__KgGonT6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl4m9Z8ACgkQ3s9rk8bw
L6/dahAAoemU3C4YJFfkSbjLIGaCB3E6rvzlU4ca5ehnSSsra5plAsMn9QOe/8kp
1MNUk45vnN2Eb7vOhudy85NP2cfPD1KP2HcrGalvANBw/ZQRABg67mCep2/Zu4W3
s9hW64lTgpoW1HyP/TUS492qeDeYaC3ZPhq2KdZfhOhzARP9Q6dYSX4BtREjQK4b
YeCL/TdtdWsqBcQA08fJsKupN2rPjEAd2aYAk32Z0nWgB0OehxP/FP+3X+uCK7Zv
QZI//1UDH+s66KOdsRZpckhpLZ6DV+8ij6OHTeWrjkvSdSa/SI9oH1WHbrSgyqxE
D8whbPSZAiq0b8rT/xaty2EzB2p1I4ner0rhQtg/x85GsMydNZ7/157VdLXx5wQQ
cAuk2lhPTjjUxWz2AbkJfI/+LfOyI3X1IXsf8cgTCj92SfW7b7vycYtnZG6PriJQ
nZfnCwzVB8BtAgWWbTeuwJ2B4N4BNapmNr+OwYGDkMD801rGORX99gvPsuZVHsyd
CkMSYfMOuBIavZ4q703+tvatjcc9qnX6n+pPreW5s0xK4h5Vh/L1szbb95QmSP1Q
tSOmJW5XWVjfzIv1QIiHHC6ouXzHxfM+DTsjDFamqkJ1GpyFzH7qZo8c2ZGYd16P
yNqCK6sf0u/iXnsUwEsJ+UUu4jHXh10JOBPLMwPrKACRa9NFFCM=
=hJC1
-----END PGP SIGNATURE-----

--Sig_/tYO2X2MnfQU=Wv__KgGonT6--
