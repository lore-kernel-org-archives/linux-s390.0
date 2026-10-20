Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792482926;
	b=gT6poeKVfHA4bNerE6umsgG8oh9yZicElyU5eQ4vSSUBwLxMfvK6tuHDPyLRxoZQSUJC
	 aTd7fKgS5UKFxt4Fk9zDuAkyOMiiOKVV2wOGIohxT/FWI9jxKXWPyeRKgEnfUD7WQdw/3
	 kE/psJIeBVOgJEVQKhZHuj0EU6Gjg14h/V0QRC7k1hOiTlOahJOH/ZEVaBgNkircgHwee
	 s1fNfeROFbrZtRW53In6A1bZpJS4EMzHmEDFAIQmeb3rn22ZJeoMm7wFr2DR3XVB9hbJV
	 usOXW2lOBMBhdmF0W5G0WFzCiqDZ2OFeppU/PNUVaW9sLGKJ1+SfcEwV01UZwluYibQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792482926;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wiYcyYLmidZvaVJOjwXyMAgj6pRDKve8NH/1uX7Y5XE=;
	b=B/eEuS64XcWEVp7dDlTsBT2trix8K/+ocIB1iBgbQKgj4X/LrnDOAVe0kwABPWpii6sp
	 cdA94W8DmwFpWebaMpSukyATQrZczGG6by2huHPMGZqdT4hrjPeVBuMKlIM8Ibnn4ImeE
	 ux9U6X/3+XLULf30It4FbyFw8BA0PveJj7YzKvfH88VnSORR3tObZk+zsXIZnen2WQ4js
	 /ERwJet+/fVagHQAYeoTy1/ZK+iDyyEa1e65Ou2Bxx25nrUwU/08D0wG9mvQ5ML+5kDp3
	 k0kpxQWbUPyOT1ryY4CY59ZZZxFUB+3vM5Ix5p+DQg+WJGVIyroY2uOF3+z/skIr2tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MijKg5Pi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CB0606A31C;
	Tue, 20 Oct 2026 07:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MijKg5Pi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC1C1F000C4;
	Tue, 20 Oct 2026 07:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792482926;
	bh=wiYcyYLmidZvaVJOjwXyMAgj6pRDKve8NH/1uX7Y5XE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MijKg5PiQSN4IeG87vq5Yt3/rVEOVOiaPlYoJcUIm++uXCodktoqH3rFHZJ3vXLg3
	 MbEvGyMVcu8ta0JQAZ/6/CyKJfnVs4NOL4EO+SuFnsyFAQfDFloIovKzTmVtFaywE7
	 5MMyInA6heob1AvwY1YlJuSGSYD2epYDU9VT0CA8ur5h1stMY9++8Pt69cam5D5j34
	 iMie7hxbn7ltrvpnSMwsadaWIPXrdctRpqpTxvJSgyhCjtXz0Swx33L9AsJADIY7qi
	 ei8UsEfMAQ9C9tuXNadnmHWd63vc/UzaTHUiXU8zbmpRzPsHDUkiwnCjZDGuQVEOE7
	 6TBQDsjEdSP2g==
Date: Tue, 20 Oct 2026 09:55:20 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Allison Henderson <achender@kernel.org>, 
	kernel test robot <yi1.lai@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, wireguard@lists.zx2c4.com, 
	rds-devel@oss.oracle.com
Subject: Re: [linus:master] [sysctl]  8d75c338f0:
 BUG:KASAN:slab-use-after-free_in_touch_wq_lockdep_map
Message-ID: <atcS-NKX1TpbklyR@hobbes>
References: <202610190310.9737b2e3-lkp@intel.com>
 <atYB0bm9eEXp8A2g@redhat.com>
 <atYW0K3t57puHeLW@hobbes>
 <atYuE1xnVYe0BDG4@redhat.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a42qtuqnvg7yxrg6"
Content-Disposition: inline
In-Reply-To: <atYuE1xnVYe0BDG4@redhat.com>


--a42qtuqnvg7yxrg6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [linus:master] [sysctl]  8d75c338f0:
 BUG:KASAN:slab-use-after-free_in_touch_wq_lockdep_map
MIME-Version: 1.0

On Mon, Oct 19, 2026 at 04:49:55PM +0200, Oleg Nesterov wrote:
> On 10/19, Joel Granados wrote:
> >
> > On Mon, Oct 19, 2026 at 01:41:05PM +0200, Oleg Nesterov wrote:
> > > On 10/19, kernel test robot wrote:
> > > >
> > > >
> > > > Hello,
> > > >
> > > > kernel test robot noticed "BUG:KASAN:slab-use-after-free_in_touch_w=
q_lockdep_map" on:
> > > >
> > > > commit: 8d75c338f0bcecaa6c9af67f86c176b67b6acf3e ("sysctl: remove C=
ONFIG_PROC_SYSCTL, it just mirrors CONFIG_SYSCTL") https://git.kernel.org/c=
git/linux/kernel/git/torvalds/linux.git master
> > >
> > > I don't think that commit could cause such a problem. Please re-check.
> > >
> > > Oleg.
> >
> > That commit might not be the one that introduces the UAF, but it might
> > be the one that exposes it?
> >
> > You have CONFIG_SYSCTL=3Dn & CONFIG_RDS=3Dy & CONFIG_RDS_RDMA=3Dy.
> > Therefore rds_sysctl_init() returns -ENOMEM  and rds_ib_sysctl_init
> > returns -ENOMEM.
> >
> > If rds_ib_sysctl_init is called after a failed rds_sysctl_init, then
> > rds_ib_sysctl_init would call a flush_workqueue on a rds_wq that has
> > already been freed by the failed rds_sysctl_init. Right?
> >
> > Please let me know if I missed anything.
>=20
> I think you are right...
>=20
> rds_init() does
>=20
> 	rds_threads_init()
> 		rds_wq =3D create_singlethread_workqueue("krdsd");
>=20
> 	rds_sysctl_init()
> 		fails due to CONFIG_SYSCTL=3Dn
>=20
> 	out_threads:
> 		destroy_workqueue(rds_wq);
>=20
> After that any access to rds_wq is wrong.
>=20
> If rds_rdma_init() runs after that, rds_ib_init() will call
> rds_ib_unregister_client() -> flush_workqueue(rds_wq).
>=20
> And this will equally happen before the blamed commit 8d75c338f0bc,
> just you need CONFIG_PROC_SYSCTL=3Dn instead of CONFIG_SYSCTL=3Dn.
>=20
>=20
> But. rds_init() can also fail even if CONFIG_SYSCTL=3Dy, after
> rds_sysctl_init(), so to me this looks like a bug in net/rds/.
>=20
>=20
> In any case, I guess net/rds/ init paths should not fail if
> CONFIG_SYSCTL=3Dn ?

That is up to net/rds.=20

The question is: do you have to fail if a sysctl registration fails? Or
another way to ask it is: Can't it (net/rds or others) run while not
being tuned or queried through sysctl?

If the answer to these questions is that the sysctl path is necessary,
then the failure is reasonable. But if they can work without the sysctl,
the failure is an overreaction (IMO).

Best


>=20
> Oleg.
>=20

--a42qtuqnvg7yxrg6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmrXHlsACgkQupfNUreW
QU912gv/eejjrtoxUgh51UagvsJXA0SMOI6Yaa+uIBcExUpCjVRcUBjhj2jT/GV9
JRJK0zb9dOeEg4yIm/bzf4j3qYwBTqiRdVf5++8HB9yuqIx4w0NlVIbks9Q8YDQh
QRXDBUAUoP6FxYb3jE1U49avWB37mPqj986qpNiwwqXq9nIRDKDf/9sPY/b2Vvyn
RibI+hOi7hfCSUntOsrbN7NmOtV9e1FQtHZxCjHpdz51bQqn1S84/WJ0dDgy+RUT
J1sLIQsUlmxKtJ78VYmaCPUJ+owrm3mFNvzmw2ERplHoA2JqT3r6lY1jP2G5Xi8y
pRSKsCTfoRUgVrXh6yByuK/2ywuqzfTEneUTJ4F97bLgJClP+4FtYcUjnbZOvsrm
l/VWLpeaTxFHDiDWu/rJ+K9YFs8JcsnTtmJqJ/pLJAW/IjvQ5sQsT6P+d04LgWQJ
fRYc1/dcsViZ1Bz/LUpV4NWsMtqP70EPbjuvvPYA5GG5HRM1bj6x4hHL2e9gGsQ5
vMczI+dC
=OX/2
-----END PGP SIGNATURE-----

--a42qtuqnvg7yxrg6--
