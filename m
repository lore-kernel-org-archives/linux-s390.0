Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48737 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726642AbgATQLe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 20 Jan 2020 11:11:34 -0500
Date: Mon, 20 Jan 2020 17:11:13 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v3 7/9] s390x: smp: Remove unneeded cpu
 loops
Message-ID: <20200120171113.02a9b807.cohuck@redhat.com>
In-Reply-To: <97f7f794-e0be-3984-99b2-ba229212fd3e@linux.ibm.com>
References: <20200117104640.1983-1-frankja@linux.ibm.com>
        <20200117104640.1983-8-frankja@linux.ibm.com>
        <20200120122956.6879d159.cohuck@redhat.com>
        <97f7f794-e0be-3984-99b2-ba229212fd3e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lQlNoXBwsVuSB1_YPmt0e/f";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com

--Sig_/lQlNoXBwsVuSB1_YPmt0e/f
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Jan 2020 15:41:52 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 1/20/20 12:29 PM, Cornelia Huck wrote:
> > On Fri, 17 Jan 2020 05:46:38 -0500
> > Janosch Frank <frankja@linux.ibm.com> wrote:
> >  =20
> >> Now that we have a loop which is executed after we return from the
> >> main function of a secondary cpu, we can remove the surplus loops.
> >>
> >> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> >> ---
> >>  s390x/smp.c | 8 +-------
> >>  1 file changed, 1 insertion(+), 7 deletions(-)
> >>
> >> diff --git a/s390x/smp.c b/s390x/smp.c
> >> index 555ed72..c12a3db 100644
> >> --- a/s390x/smp.c
> >> +++ b/s390x/smp.c
> >> @@ -29,15 +29,9 @@ static void wait_for_flag(void)
> >>  =09}
> >>  }
> >> =20
> >> -static void cpu_loop(void)
> >> -{
> >> -=09for (;;) {}
> >> -}
> >> -
> >>  static void test_func(void)
> >>  {
> >>  =09testflag =3D 1;
> >> -=09cpu_loop();
> >>  }
> >> =20
> >>  static void test_start(void)
> >> @@ -234,7 +228,7 @@ int main(void)
> >> =20
> >>  =09/* Setting up the cpu to give it a stack and lowcore */
> >>  =09psw.mask =3D extract_psw_mask();
> >> -=09psw.addr =3D (unsigned long)cpu_loop;
> >> +=09psw.addr =3D (unsigned long)test_func; =20
> >=20
> > Before, you did not set testflag here... intended change? =20
>=20
> Yes
> It is set to 0 before the first test, so it shouldn't matter.

Hm... I got a bit lost in all those changes, so I checked your branch
on github, and I don't see it being set to 0 before test_start() is
called?

>=20
> >  =20
> >>  =09smp_cpu_setup(1, psw);
> >>  =09smp_cpu_stop(1);
> >>   =20
> >  =20
>=20
>=20


--Sig_/lQlNoXBwsVuSB1_YPmt0e/f
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl4l0SEACgkQ3s9rk8bw
L6/7/g/7BaNIie/wuhSrCVnh3mvFbOnUGyG8MdBp3hh5/dRo6LLKPvSn78lmhXXA
B62uO4hUtS3hmBbchQ8XDNB1/XOlc020Hl3EufE4AmG7kdmWGZQi27I2jtv67o6y
uqW7Uy544g1lhU/q+UaXwi+/dMMzcQ4svEuvriMX0A7n3WFrU+t/K5YonhBXJsio
4sK1fWJce6V9TU5VvoES4ESkwyROIL+qMVOj/UIMJOh8+SR9Xo4v+h1F5AiFwKI4
GKZlYYgL2K0MdPX61k3M3SN3vzJNdQQrSHmxVn+9vGMxs7be7R1c/6LmlMfnKMVr
WGutFp32s4nEN0c5iWTH6SnyHn+j+IM6VhTpwRUgvVNZ8khIklMfB4AwG/3q3JYr
xF1N56dg3ryorsu7OUXC1OfAKwO7NpGfh/L+wAkeLbq/s4OVjTOIk+N5E26yg5vj
rmtl53GbSj0WpI0klTWmfAHrJyHCGMDhn3WK/ke9GbbRpdT21UcHsBZnZrq9r0+U
ekFBJw1yCLvu0Hu7gHlKxutda+TG0fWuDB8ZRYKyYv93pLRkjz32O9NsbWzZr6hR
icZp+tydoF3fy+wdi2H6nd5iC8EuWQ5PVkSCP56AYMqgQuJuQKO5nDaw+bCsWR52
CFndzm2r5oNueFIJaf8ovbPZlYjJmxlAQJzLXwq6W5RnsqKirvM=
=a9Us
-----END PGP SIGNATURE-----

--Sig_/lQlNoXBwsVuSB1_YPmt0e/f--
