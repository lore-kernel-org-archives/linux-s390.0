Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F383438BB;
	Wed, 19 Aug 2026 02:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787107185; cv=none; b=qDq9qfl+CmmlfA9vZBB97YEAb92//2/ukXcOL7aoCtfZpuUy9+xSDOhaUFzR62YAN+OA/4Fx+rWP2BeOq2K1XtFhB3NsBRmeazSi71/h0EjSPrPA0YqytTUSEWgbQY5AoG8q+bCSA661tBIqs9yfG9//OwUdkakZ2A1aUSlf56Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787107185; c=relaxed/simple;
	bh=HZbblkYAPbPV4hFB4vHtGtmQYsKX+nZ8rRueF8ia6+U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lRblD/cunQueLSM/NflMiVyefEEHDg5QQOF5sqXW//uq5IrKp8WFXLhe0Psi74HZKArbFw+iYhJW14qgXnVIk1XDS1VAnNGc4Lj0gCdzo8dYNEVqT/lS0kvizoU2Qolzt5FHh5hFzTFOgieTa20MD8RUi9Yr0eMuje3BC3uC7FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jr8Tc1OM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jr8Tc1OM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB6E1F000E9;
	Wed, 19 Aug 2026 02:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787107184;
	bh=HZbblkYAPbPV4hFB4vHtGtmQYsKX+nZ8rRueF8ia6+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jr8Tc1OMba9S7M5asi+QZ4HTBH0bf5XPbqlDVirs0QLpDWK9ShVaVsTePCn62Uv4O
	 UGVpl+kaKN2GTuO1DE6MISCiTDX6OcD5oRsN0cm9zDJ778/xisWapOYldRRJj6s+px
	 75Xww5dYTvGifAhzSGWx8p/SmGkSXXpSPON/rm/65dcjOiZJrtFeLlRqtMsmZwcglq
	 IFtDKASTjs/f6gLH/imD3Vv/YKgqs6hBFjXF2lAYHq9Q4kfG40FeHauzZtFX8TIdhg
	 defqVJ7i7e74obD/Ma7vpPFkL7iDXVAAn0o5OGXAVrxGcTqdP4gIJRVQ6gbiWmg7+S
	 DVvPty6tUPw9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 12/13] modpost: move addend_*_rel() calls into
 addend_rel()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mauricio Faria de Oliveira" <mfo@igalia.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, mptcp@lists.linux.dev, bpf@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260818-sysctl-module-aliases-v2-12-d5a69dae5798@igalia.com>
References: <20260818-sysctl-module-aliases-v2-0-d5a69dae5798@igalia.com>
 <20260818-sysctl-module-aliases-v2-12-d5a69dae5798@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 02:39:43 +0000
Message-Id: <20260819023944.0DB6E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Move the arch-based addend_*_rel() calls into addend_rel() to be reused.
>=20
> Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818-sysctl-mod=
ule-aliases-v2-0-d5a69dae5798@igalia.com?part=3D12

