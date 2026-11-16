Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794852013;
	b=gH2GtrBXRPvEjVKZewjTPx9IeJk9/YdHEir/iUcxUdR6ZnDxFN4CoiJ3V4pZIHigqrFE
	 f6irikRUJgZxmaY0M7GrcN1qqjosRMGos3ysZnCk85u9gFyQjHm2Xvecl5elmC4DxSoTa
	 Ps2biHZUZGtu0KzOiFpAGXDp4rSfTJPjNRYw2aUEjkEevmkpUS2AnboGjz6mHVfKXZiUP
	 qCCbl134hqsc2LckeP1hesaOKzG/Czb8IGXQywN5/pCCBtmU2ep+wsncxBfh5ONpYceok
	 nAE22LdwXoFVPzMgGt09kthPiBYTHRuxqGNPSSkpdOv9yHyF2H8YPs5GKfQ5szLxrpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794852013;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Vgjpk/56U2QuegTVedNQAgTspsaaBlfOTSY97wcv/WI=;
	b=2aIompgWKxAuNfRNhU2CB71Z+bCB/mI2J9DyQRIuHGBYx5QEeH4CATjBtRSfu8EMlmwc
	 cB4/yrAxaePDz3ueHpwtncxPGTdyb+WKjy+NdKMLz1AmOy4cOvJ/lbmlp/yFew66ZatjB
	 k6T3IRavLcP+7aORspcnzdYswb/q1iXtMc+GSC8+aGe6go8ZE6pad9KkkrgmqR75L6K6S
	 Ukq2u+D8UqPaezrVam10SGI5D40leTQbRCiQ2OyaZ1y2IQkD1L3TLBxixNZ1jPKUpAuRW
	 9oAd1Rl2HW8k3g4880n9wA8/6LnIt7DFrB7AiGbklo/9f5SBLorBYgfr73oz3hKmQSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UY8FYJFS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F623606A32A
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UY8FYJFS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4131F000CE;
	Mon, 16 Nov 2026 18:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794852013;
	bh=Vgjpk/56U2QuegTVedNQAgTspsaaBlfOTSY97wcv/WI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UY8FYJFSRxlJ2ydA/nz+IujmpU6inqbsmg81k9ILegGDxVMmtEeak1apwp33OP2Q5
	 94GFOMLJc2DNnRGBPXlzmktZVF2kSrnYXGZBhXVTDsK/f3rZ2lmoSrubM3myHcWhY4
	 dZhSCwCplvRuphXbF/nOUUNaDsYhLmNUm9o4tgdik5VmAxguOai1ZB0RMIrCe5BxPI
	 oDqC4ZK+ehkPSEAfh//lb2OEXzdnvfLYH2ZS1nv0fxiP4bPJhypV4y5IQjfA8yfD8w
	 Zc6EMr7kMpli/oDXTGYxyckFcSSqMLno805ZspjnHC/6h5A9zXa4rt4GEE1baAOgdU
	 YmRvHujkh2gqw==
Message-ID: <sashiko-outbox-217475@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/15] s390/cert_store: Fix potential use-after-free
 caused by find_cs_keyring()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261116143534.158375-8-hca@linux.ibm.com>
References: <20261116143534.158375-1-hca@linux.ibm.com>
 <20261116143534.158375-8-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 18:00:12 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> find_cs_keyring() drops the refcount of cs_keyring before returning it.
> Which means that callers operate on potentially already freed memory.
>=20
> Let find_cs_keyring() return cs_keyring with a reference. Since
> cleanup_cs_keys() now performs a balanced put via find_cs_keyring(),
> remove the separate cleanup_cs_keyring error label in fill_cs_keyring()
> and drop the reference unconditionally instead.
>=20
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116143534.1583=
75-2-hca@linux.ibm.com?part=3D7

