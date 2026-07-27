Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCC43D6CB4;
	Mon, 27 Jul 2026 14:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163155; cv=none; b=uY60geJaBeob/2Np4lR15OdcraeaH+KSdRhip1PC9gqqCtgb036prwAcO9kzMfAB1nl2eQX6RFRUg5TZoDocx24wCApS6+rxjhGswZeojSGgluHKeE1kHE4+AB4+aoICTUvI6kmpQiPwEnI+wcaZbz0+E9rcjvXDXFnzsilrkgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163155; c=relaxed/simple;
	bh=9a0j4XQz1IglaVgjuP3KOLP2YPJ/RuCzqRFRmjfvSUk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oWFugwVtn/7++txhXh1hgCh3ngWqoFlLAwaqgUap3QqYu0lqlKzEJal6/N48iJc0dv+69Uw5eRPE7SnNjXik8EAqWmFz+06OdI8zwn4mYzdrKvY3zDZGDd30A6TIw256OC9tJZNQVK3CN4/mNDgufk370HaScxAwxxBb6ssuySM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mP1TlNZ3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mP1TlNZ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452E51F000E9;
	Mon, 27 Jul 2026 14:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785163153;
	bh=9a0j4XQz1IglaVgjuP3KOLP2YPJ/RuCzqRFRmjfvSUk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mP1TlNZ376hCTQsR6dLYL9y78HzZ9019Dcf8wV08g/B77i0zVs+TEWkqlrFpinGQB
	 RNInpATLmp3QdFVoVE/QOnvraweSFGulyhf446g4vHnAvm9jKhLgVFopftm2/uXdHn
	 72oklpWu6b6OyCXMWDiLrXM2TLeMEYJId0zdn2L//r4it1ygVUulWYki6dnKjHrBO7
	 IWCTvx3kPiXRLobBzUtkADH/Cj2pUb2eO1UQ5vOPNgxGSVI01ja3es3jBn8lLqvJ7w
	 w2Ny+kKau9/Bisho1/KG0r2qaLrdWhUCSVhgHg26zeSXl3ZbiwqzOGgH292tO8E1Wa
	 zVcYIdVvonYpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] s390/Kconfig: Select ARCH_SUPPORTS_CFI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, bpf@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260727140514.116501-7-hca@linux.ibm.com>
References: <20260727140514.116501-1-hca@linux.ibm.com>
 <20260727140514.116501-7-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 14:39:12 +0000
Message-Id: <20260727143913.452E51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> With all prerequisites in place select ARCH_SUPPORTS_CFI.
>=20
> Note that this support is supposed to work with the generic kCFI support
> which is provided by clang. This comes with a couple of limitations:
>=20
> The generic kCFI implementation does not generate a .kcfi_traps section,
> nor is a special instruction used in case a checksum mismatch is detected.
>=20
> This means in case of checksum mismatch the kernel just crashes. It should
> be quite easy to tell by the surrounding code that a crash happened becau=
se
> of a checksum mismatch.
>=20
> If clang and/or gcc provide a .kcfi_traps section it will be possible to
> print proper CFI messages instead of just crashing the kernel (enable
> ARCH_USES_CFI_TRAPS).
> [ ... ]
> itself with two byte offset to execute an illegal instruction, and the
> following basr instruction used for an indirect branch.
>=20
> Reviewed-by: Jens Remus <jremus@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727140514.1165=
01-1-hca@linux.ibm.com?part=3D6

