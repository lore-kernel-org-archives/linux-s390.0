Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B608F23BD02
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 10:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851418; cv=none; b=UmfG+Fz7u+bNMsMMS96GfoNRWtC1N5UpT7Ge+c5b6UxrqSgbybpFv8PFrlYhjIN2hcnPRaumDcIDs5gnjw3zEejSwiWOCBJt0yogzb5cVQd4Ai1/o7ceL3hAkkyfMiDM4LyWOz0Svzj2n1bp5vJwh35kcAzujUUTV+jWLsurj5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851418; c=relaxed/simple;
	bh=g3UkNfJH1CcI+y3EjgsrIsJ+Sk41fqacbZ3wcgFwj6w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iPqSu72mkFgvaiE9sOetR9p81qmyBFcTkXjzkV4bBkSioD4ij/EWGImF8bvoFyrMMTA6tZq7H5LghsLDnKIBamIyX0YqbqO4PAfH+zf4ZjuHtRNjrm8T8ObMHj7OJv3cevX6UU78omU5/GagU8BdHMYwmpD0RP0mSpaFtPLjZDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3y5uX/c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3y5uX/c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF5A1F000FF;
	Thu,  1 Oct 2026 10:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851417;
	bh=g3UkNfJH1CcI+y3EjgsrIsJ+Sk41fqacbZ3wcgFwj6w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m3y5uX/ca/IWVX08nvJcoatQ9VJoJCNhh6CDlwXhjathXuEbiAScMpmBZAZkQ2d9u
	 Xs9QPTgmmAoZZ053akLsUb+4YR3bJemBUcAz6e3cG1hLDX3qX7dG8YFrzD+kzkL7MR
	 xbysAR2dMCs9FpfSsnbTlNlA627rDQXRAOl7QHfW6QAUNUVQ1//mHg4pKSpSm+4c48
	 QKIp3YQb9AhzzTUDHAQCqLmqc3ulHlY78NV6IC4yPvkBnOR4+pQt2lNzm+L92kJRmg
	 /4o/tixby/slt1lRlKP1OSfyw33BgebMLE9YO/oQYBKRmVZvkzS93AsMrXBAC0pvD5
	 4TtY9i/rDwPxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 29/32] s390/diag_ftp: Convert inline assembly to
 EX_TABLE_INSN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-30-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-30-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:43:36 +0000
Message-Id: <20261001104337.0BF5A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert the diag_ftp exception table entry to use EX_TABLE_INSN.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001103247.1989=
111-1-hca@linux.ibm.com?part=3D29

