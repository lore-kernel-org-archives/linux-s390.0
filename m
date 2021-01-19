Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 19 Jan 2021 17:24:48 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 2/2] s390: mm: Fix secure storage access exception
 handling
Message-ID: <20210119172448.7fb3d7df.cohuck@redhat.com>
In-Reply-To: <4de19c74-65dc-5a29-76c7-99c600012fdf@linux.ibm.com>
References: <20210119100402.84734-1-frankja@linux.ibm.com>
        <20210119100402.84734-3-frankja@linux.ibm.com>
        <3e1978c6-4462-1de6-e1aa-e664ffa633c1@de.ibm.com>
        <4de19c74-65dc-5a29-76c7-99c600012fdf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_Ei7KtOMbvWaVZIUWbFuXiz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, thuth@redhat.com, david@redhat.com, imbrenda@linux.ibm.com, linux-s390@vger.kernel.org, gor@linux.ibm.com, mihajlov@linux.ibm.com

--Sig_/_Ei7KtOMbvWaVZIUWbFuXiz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 19 Jan 2021 11:38:10 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 1/19/21 11:25 AM, Christian Borntraeger wrote:
> >=20
> >=20
> > On 19.01.21 11:04, Janosch Frank wrote: =20
> >> Turns out that the bit 61 in the TEID is not always 1 and if that's
> >> the case the address space ID and the address are
> >> unpredictable. Without an address and it's address space ID we can't
> >> export memory and hence we can only send a SIGSEGV to the process or
> >> panic the kernel depending on who caused the exception.
> >>
> >> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> >> Fixes: 084ea4d611a3d ("s390/mm: add (non)secure page access exceptions=
 handlers")
> >> Cc: stable@vger.kernel.org =20
> >=20
> > Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com> =20
>=20
> Thanks!
>=20
> >=20
> > some small things to consider (or to reject)
> >  =20
> >> ---
> >>  arch/s390/mm/fault.c | 14 ++++++++++++++
> >>  1 file changed, 14 insertions(+)
> >>
> >> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> >> index e30c7c781172..5442937e5b4b 100644
> >> --- a/arch/s390/mm/fault.c
> >> +++ b/arch/s390/mm/fault.c
> >> @@ -791,6 +791,20 @@ void do_secure_storage_access(struct pt_regs *reg=
s)
> >>  	struct page *page;
> >>  	int rc;
> >> =20
> >> +	/* There are cases where we don't have a TEID. */
> >> +	if (!(regs->int_parm_long & 0x4)) {
> >> +		/*
> >> +		 * Userspace could for example try to execute secure
> >> +		 * storage and trigger this. We should tell it that it
> >> +		 * shouldn't do that. =20
> >=20
> > Maybe something like
> > 		/*
> > 		 * when this happens, userspace did something that it

s/when/When/ :)

> > 		 * was not supposed to do, e.g. branching into secure
> > 		 * secure memory. Trigger a segmentation fault. =20
> >> +		 */ =20
>=20
> Sounds good
>=20
> >> +		if (user_mode(regs)) {
> >> +			send_sig(SIGSEGV, current, 0);
> >> +			return;
> >> +		} else
> >> +			panic("Unexpected PGM 0x3d with TEID bit 61=3D0"); =20
> >=20
> > use BUG instead of panic? That would kill this process, but it allows
> > people to maybe save unaffected data. =20
>=20
> That would make sense, will do

With BUG():

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

--Sig_/_Ei7KtOMbvWaVZIUWbFuXiz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAmAHB9AACgkQ3s9rk8bw
L68FCQ/8C2reWoIDpqXLM65QwexvAh5qXVMDRCQ4duWhFhOcs71p12CKiG4clZ3N
FFlcEgpcg69EwX44+EId2jVN7n+RE/HSiJiwisrR4U4ykH/xOGPaverhwZu0PVAv
byYX1ifefBWrYIzyiHMbhBSv91mrTg/hlioednAOSGag6ifekvwhloKsgm6vo6Ff
yvicIBjU64NSKBaOaS+g9gQv4RZ/4OlK8kieqh03iD431iC7fI8zZjDr4TTiukTZ
TCGRYm6S9xKvgU25gWpRS2fjtdqtVsLTscBnlvALucw5qunrCpENND/UogKccUfS
YrU8nzh1t5DXSGUiGR6AssnH4jiFjYkrVMFMz3JHdWGTt+28ZAx2PvshLfm4Rl7v
UO2xcpZLzlfBd5Ua6LLWSEqeYKiK62NH6tmnK/NJQyX56wjmkhpObIY7uLr06I89
UzBLuXIYy4PQCRRxm3ItAgtDMmSqhQjtLJDx3tdv+lwoIm4TFT8DJKWSG0L+Hyiw
zdx4a/VtipN1iVF//Juyp9D4NMm+vEl3qELEulgISVkFrENCL7ZjwxrpF5B3HUyJ
cpw+ngdVlR7Q53rNKGzS8wKLB8hTmwPkyAtOItJcCagGsfiwJ8uMx4WaLv/ouh7z
nMQDhzk0JpZcZBY1zLYEi+UgKm75st5SKStsbzKkNDKW1btFyuc=
=4MJ8
-----END PGP SIGNATURE-----

--Sig_/_Ei7KtOMbvWaVZIUWbFuXiz--
