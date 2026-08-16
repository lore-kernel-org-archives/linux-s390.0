Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BF7233924
	for <linux-s390@vger.kernel.org>; Sun, 16 Aug 2026 11:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786878525; cv=none; b=dkbjmAqBS4i3Up3421LjDDuWJagm0kPVt0frh9ve/cXW2q2qpYlOi7qfb7bDcIB0gUCtgu8RvmkhOgh4NTF8abfQC1Q7p1E8ARpzF9yBymGb/3+GGPj0N+s1x4U+gFh95wvlW5zrDZNpYMnam0TRw6gbTlriXmhJHUw607+JiCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786878525; c=relaxed/simple;
	bh=SULSCbr5Ot8K2X+RBNzVOXit34T2+a1j6+w3DCPx/0w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tKpoKoac3GxxnkHpKTQLDwhdnPJOd/FMG/H9QCQOV7clKdYKSM8G5Oi/MAzfX6GuckPzRBjitGG6H2NQK/SE5bNcfDJme/Ga/lbUYoonoQbmkBbrUUZsWjfix2Tc7dV4SHg2qM3hfLRaBKkF5Byu7MC/hRqBMEKBiZcfx8QsG0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHZSw1El; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHZSw1El"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF251F000E9;
	Sun, 16 Aug 2026 11:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786878523;
	bh=SULSCbr5Ot8K2X+RBNzVOXit34T2+a1j6+w3DCPx/0w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hHZSw1ElQt4d4O12drxKyDhmRnmE93/A8fM1f5UGaB+rOvUY7/TZPcoUCtB0JDCEn
	 +pOZnKFm/oAzf7ieFDbHdGRvrh4v4gArZstFT1/6G/12nMiyNQ3VMZmuVaGNLF+F8F
	 J3Iv2bXw0iiOZqb4ttfjcrDIVjytze3SGD6Y0RuLdMc251CaVTJNF0vJzaOArcC7F/
	 v5nzQAtpAF963ROfHpwdrhwNcy7dblmtHR95ScYxtv7ZP3DiFAIUA9YC9Ph1UIKsGZ
	 bwQHj2NXJQY7QWLX9Y4dU7p42xgx7f5H9CQbl0ora2E/889tttdCPS2Ss0ANQBR6Vx
	 ZHPoR/8231yVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] mm/vmalloc: set area's page_order after allocation
 succeeds
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260816-execmem-set-vm-perms-v0-2-v1-2-90944a3ad43f@kernel.org>
References: <20260816-execmem-set-vm-perms-v0-2-v1-0-90944a3ad43f@kernel.org>
 <20260816-execmem-set-vm-perms-v0-2-v1-2-90944a3ad43f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 11:08:42 +0000
Message-Id: <20260816110843.3FF251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> __vmalloc_area_node() calls set_vm_area_page_order() to set area's
> page_order before actually allocating pages to populate the area.
>=20
> If allocation of large pages in HUGE_VMAP case fails midway, this leaves
> the area with elevated page_order throughout the cleanup path.
>=20
> There is no actual issue with this because the only place that currently
> relies on area->page_order on the cleanup path is the loop calculating
> the direct map alias range in vm_reset_perms() and it anyway skips
> unpopulated pages.
>=20
> But having set_vm_area_page_order() in the middle of __vmalloc_area_node()
> makes things very obscure, hard to reason about and error prone against
> future changes of the cleanup path.
>=20
> Move the call to set_vm_area_page_order() after __vmalloc_area_node()
> succeeded where page order is guaranteed.
>=20
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260816-execmem-se=
t-vm-perms-v0-2-v1-0-90944a3ad43f@kernel.org?part=3D2

