Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678463B42E0
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851227; cv=none; b=ZIawz/uQZLVlU0Bb8QrzEoFNFmto8uUsqJtV4yOPbxRhViMtwxauTPQLIXX1n0RtKEIGsAS9lyd4ZelsXeJM+zkqiWnThaTtnMSbnUIAf7NRpqNrB25iBXGLl57tIvteI7MtN/YbcrQSXfxC4BRfWkJ8YauWTSYj40hyL6yVdvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851227; c=relaxed/simple;
	bh=hDSUblEcch7j2t4iPACNv4n5F1hndvCxhyaXx3DOPAc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p+FhE7+tVIgTOpuNT00SuSnyFsh2csNeyi6NzuWvArDy2an9wC++azH112U/DCca7dNCF2eMcYuR+0UGscPXw4bdt1aHIWUIxG2fnbuaQdF3/wIY2DYM6yQ3Za2agNGHvbZrC5+vyW33EEQid2U9MD1xjOSmQdmF1ZXPwb2NsXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBzINWP+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBzINWP+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F411F00899;
	Thu,  1 Oct 2026 10:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851214;
	bh=hDSUblEcch7j2t4iPACNv4n5F1hndvCxhyaXx3DOPAc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LBzINWP+gCngWiXX6VgpxJHOS+DgOLWoQgSsC4uwnoK06lWjQFNfBUQ16xrZwAErc
	 ROYq6m05+rDHSBCxdhy4oU5GWjubJee3/GGelZovAz9zsUXjOusj8W0eBWEWF4pd93
	 Jri4ueNDtEZ2lR69SxrsppY5toh4B7lHPXq8fXMRpT/k2XY1gSAS8OPFD6NI/4D77F
	 jd795rqdmPc2NGI5C1X06k0BX3SSoHkK5zZ9FDuY6LXr+FrwBUvpvEiAutTXReKa2a
	 CUe/AJZ6ut13YTkbgJi5zSC0+6pK5JHN1VHaulleGG6aRu5oJ8GNXHkeomZB7KEQRH
	 AdL/CAVuLfXOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/32] s390/futex: Convert inline assembly to
 EX_TABLE_INSN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-14-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-14-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:40:13 +0000
Message-Id: <20261001104014.26F411F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert all futex exception table entries to use EX_TABLE_INSN.
> With EX_TABLE_INSN entries always point to the faulting instruction,
> so duplicate entries are removed.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001103247.1989=
111-1-hca@linux.ibm.com?part=3D13

