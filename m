Received: from e2i605.smtp2go.com (e2i605.smtp2go.com [103.2.142.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7A55FDB0
	for <linux-s390@vger.kernel.org>; Sat, 10 Feb 2024 21:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.142.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707600569; cv=none; b=Si2+Q9DxSl5go2YGx/8W+ZJsNxdqx6yxZxYja3D8zPCtTjNgy5mnQIO4755jiMRTkfIgeGWLvDzVOnvOTPmn5thccIbijcSIbG9UoUecNrE1Zh1jteuI126pw48zb9wQxQ+iFu7QKF1aLs7uB0TruWjodDSac4JyqrFXzax4alI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707600569; c=relaxed/simple;
	bh=2Du69mSeHaxU4Lx7+MOepHIT2fMVUkQRRtGqtvh8tn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHbdH+9UEtQrYNvwtahNI3fUlLDbvPKuPXBV+F4wg+fMUmt7N5Yxbq+HZUfQ6t85/QIgUstrlnBMKM0LBkejHYwG47bPgncHMNAETLkBuJx1iNYTE+41D4+7WxpbZUumNFnjaz78t2ZQ4X/fQUVUZxXYyGyWJRENUL+wjfobQ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=em1174286.fjasle.eu; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=K5xy5MbN; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=TUjuY+an; dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=NY+lAiZu; arc=none smtp.client-ip=103.2.142.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174286.fjasle.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="K5xy5MbN";
	dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="TUjuY+an";
	dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="NY+lAiZu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=mp6320.a1-4.dyn; x=1707601462; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe; bh=/a1NKqeWXcomDM15U7re5KNGNhB+KStNX+Jjw32PO8k=; b=K5xy5MbN
	U5UqlJ2di3ad9z4oC0mu+yJTVmAMCMcOGIbQvLbQxND6lf/5UoGWuzU1ui2xiZF6ecdq5Udvn//2p
	a0r8WUmetTaEM3s2s0MS6Xp+FoI65RlyK3URQyYUCY21DTV7iHnLgA5n8vjkNgYaHOtzFeGkCtaxD
	iJH2bhRey+6zesHOS4RtE0+ljEyzmADMjXeygZhZxO15uU0EU5ZI7BPLNEV4cKhSG+H9Rt1MU4l/h
	WCBYnLCen04/vfVzbEqpILq/pB1H7CcMFo8uRGvaOdXQebOFbzNIKSxW3375oASa5V+QxRUGTR5lU
	djODVcT/06V0yrKOIkmvbOSG0Q==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjasle.eu;
 i=@fjasle.eu; q=dns/txt; s=s1174286; t=1707600562; h=from : subject :
 to : message-id : date;
 bh=/a1NKqeWXcomDM15U7re5KNGNhB+KStNX+Jjw32PO8k=;
 b=TUjuY+anCj1AihVBJ4m8WsvrlaHIyh6+o1Xszy0UsYCszEysgF/sYfrNz75GPQbDRIM6G
 H5GYxz2bMMp0G4aopvQKChTINFROvBhezJqNN6Fhapm0mRuhOkT8Tp349L2dTaZx9tBfNv2
 qquWpnKkTUzFEWVCAGYHHFwsqRVQYcXtM1ifMJ9/4l/D0vgdgnKtU8hzxNwllLs5gm3EVzH
 I80GdlTK1qFoqvGob5uAQSaP5J0NZ8ZXLj9zWuY8hk7zc5nIHX0NQe9xQ3yhrqgNCdlvfJz
 jOhZDG3fQZeuZE/1MJWGo2KAAMG/joTmSG4PVyd1Vsayis3aiG4XTXUngbNw==
Received: from [10.176.58.103] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1rYurb-qt4BXu-QO; Sat, 10 Feb 2024 21:26:21 +0000
Received: from [10.85.249.164] (helo=leknes.fjasle.eu)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.96.1-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1rYurb-9EMoK9-0P; Sat, 10 Feb 2024 21:26:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
 t=1707600370; bh=2Du69mSeHaxU4Lx7+MOepHIT2fMVUkQRRtGqtvh8tn0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NY+lAiZuOqkS5pMrJUpcG65n5ETEJV2Y+6gc5E/FA4KrEooCHnXiFhSd0KsKLU3N/
 3V9msP+z+BGKPowTYSTTNEmBr+1NIrpx57jUGQwQqM9RCQXeavAWqRwKTkQ9w8VmVT
 HYORQqzNDMTLtRrB3rbNgRNY2yBj7YRn9ojD9DtY=
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
 id 07A053E9DC; Sat, 10 Feb 2024 22:26:09 +0100 (CET)
Date: Sat, 10 Feb 2024 22:26:09 +0100
From: Nicolas Schier <nicolas@fjasle.eu>
To: Zhang Bingwu <xtex@envs.net>
Cc: Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Dinh Nguyen <dinguyen@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Zhang Bingwu <xtexchooser@duck.com>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org
Subject: Re: [PATCH 2/2] kbuild: Create INSTALL_PATH directory if it does not
 exist
Message-ID: <Zcfp8fn7o74K08g0@fjasle.eu>
References: <20240210074601.5363-1-xtex@envs.net>
 <20240210074601.5363-3-xtex@envs.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="W0xuwF1M0d/5Cjtp"
Content-Disposition: inline
In-Reply-To: <20240210074601.5363-3-xtex@envs.net>
X-Smtpcorp-Track: 1rYIrP9EuoK90e.xznP1gL1Esa78
Feedback-ID: 1174286m:1174286a9YXZ7r:1174286sDwEn1GXPS
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>


--W0xuwF1M0d/5Cjtp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024 at 03:46:01PM +0800 Zhang Bingwu wrote:
> From: Zhang Bingwu <xtexchooser@duck.com>
>=20
> If INSTALL_PATH is not a valid directory, create it, like what
> modules_install and dtbs_install will do in the same situation.
>=20
> Signed-off-by: Zhang Bingwu <xtexchooser@duck.com>
> ---
>  scripts/install.sh | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/scripts/install.sh b/scripts/install.sh
> index 9bb0fb44f04a..02b845e7ab33 100755
> --- a/scripts/install.sh
> +++ b/scripts/install.sh
> @@ -20,6 +20,10 @@ do
>  	fi
>  done
> =20
> +if [ "${INSTALL_PATH}" !=3D "" ] && ! [ -e "${INSTALL_PATH}" ]; then
> +	mkdir -p "${INSTALL_PATH}"
> +fi
> +
>  # User/arch may have a custom install script
>  for file in "${HOME}/bin/${INSTALLKERNEL}"		\
>  	    "/sbin/${INSTALLKERNEL}"			\
> --=20
> 2.43.0
>=20

Thanks.

Reviewed-by: Nicolas Schier <nicolas@jasle.eu>

--W0xuwF1M0d/5Cjtp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmXH6fEACgkQB1IKcBYm
EmkWwhAApeau8lv5luMtDVI0MRTjPUBISiudGax4Vj5+2kq+lpcurNBfDgb8g6vz
d9eKFrAY4RpiyQA/tfByDJMkOdxjeozILABmF9E/mHAU1ddjG0tdN7dCcoiadZ1C
nRQsrQ0hMPgl/ohv5Gq6uSBNs9iJ76I8VPAUSGVhSEUXPIlZoPMYgvaKWDrUEKoA
6T6PTWoCQZ9rTRIRDzuiiXDVnEtF7Yc8qcdU/GhJTaxXuvO0NAZ2we1D7evgQriK
pvlgl/Z3UEJuoqa7gLW0tP66I1aIoBW89cAmxOMPEbx7ILj2uz94ZmL6qxCh6Ift
JIjvMM6y/6q6XnQf5a9amudS45/dT8F6+2wuPsWB5mUyUu4Jtj+nP6HgLTQsw3MO
TblqqeWBw+OZFmoU/F6R2RLTkoS00OxKrNcVSQ4ztsHmbYJZC4uqx3qTdq296LDt
gfm7Me4IHyqXCpR2TkCNL2L+Y4iABSspsgayVoJMMRdGphz55Aa7tRfpu+M3Su7P
x21blad5Owsw9AgQwY3Eh7SUmh0ooNgFtC2w3hpwj41Whe1IcAQx8iyAaO5UG802
fweAOlp41rdel9LwyfuPqG0nFwTf3+pYdqOCTOF68S3EFav85/UDo6Mg9Zgk11Je
X9KRaCfNIMNh4RXVh5toNthTBAISAYeD8tHQypeyU4J9PunrzFc=
=PO1M
-----END PGP SIGNATURE-----

--W0xuwF1M0d/5Cjtp--
