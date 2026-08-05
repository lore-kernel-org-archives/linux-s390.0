Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0022C46EF6A
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785944395; cv=none; b=Tg8gWnuo7zuPYhjmuvUEb3ENbfvl8Gg7+jng4HQnm/PkZeZ3CJai4wgvM8ixIYLj4sbrVPNR2rMNQNmJDF89i1S9KX8crjzs2kNf3fqmzFcDz0PiNM/oM28eDmOtnIDVFc4hgqZ3drHtqNl3046f7QTJrgvn1/74/Lt/G4GvGVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785944395; c=relaxed/simple;
	bh=NTicvKyiBeCt2+SAkU90BiYctU83qfJhwjXjdHmnq+c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PZ+wIQasyk5OJUYk4by6rkaJVkLITHyqMVoUaKKf9lGlz93nCeNYoO6drK6vgVEDqvzrK6yUo04YNevt9a2PI/VKQm9K2vywfFejefPsoDMKdm8vaTAryckGxKBT4INxmFWvgmDxZzqkhhC3YrC+T+zgmKVAFRzQwTqDirhNFAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXIrU3Er; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXIrU3Er"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B0F1F000E9;
	Wed,  5 Aug 2026 15:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785944392;
	bh=NTicvKyiBeCt2+SAkU90BiYctU83qfJhwjXjdHmnq+c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SXIrU3ErAcS7ynoJhUzhL2g0pZd1310iYj9orl7+V+7jJqAO8o6xtg7ef3yZ8LeB4
	 bpYW/PeZvaS0sb3Eu7rIgIk3z33EbbO1CJAvDucVRKrpGYNdb1WK1ahnvGmDdOGpMN
	 Tpo+b1cuIPL12msYeQhhij25vXvBpph2GXetOsW9Msa/sVUqehCP7yzTN7JTA5YT2R
	 iw9VAMTt1zUYvIwxQzc6b8dJAWqmKU9Hxrb5xWPEGNbAMPlIpGYJo+EDecSK1KcOm/
	 +IBZkWUGiKlsoJ3LYFLK2jvr4V+xptz/HPDcJFxUA0nt5f8DeI4HaTqL0ubo5OY0k1
	 CHie7VmDprnog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/19] s390/dasd: Extend prepare_itcw() to support
 WRITE_FULL_TRACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260805111612.1285190-11-sth@linux.ibm.com>
References: <20260805111612.1285190-1-sth@linux.ibm.com>
 <20260805111612.1285190-11-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 15:39:51 +0000
Message-Id: <20260805153951.F2B0F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> prepare_itcw() builds the FCX prefix block (PFX + LRE) for track-mode
> I/O. Extend it to handle DASD_ECKD_CCW_WRITE_FULL_TRACK.
>=20
> WRITE_FULL_TRACK needs two extra bytes appended to the LRE for that
> bitmask. The prefix block is a scratch buffer copied into the TCCB by
> itcw_add_dcw(), so keep it on the stack (sized for the two extra bytes)
> rather than allocating it: this runs in the writeback path and must not
> depend on an allocation that can fail under memory pressure.
>=20
> Reviewed-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805111612.1285=
190-1-sth@linux.ibm.com?part=3D10

