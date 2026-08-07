Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E322853E0
	for <linux-s390@vger.kernel.org>; Fri,  7 Aug 2026 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786113114; cv=none; b=jaVQ/SBTRub5mTlaoQS+HxwYuihBJC6xsYyIMdxftrpotrnvoAwbLSo18iy/Mu+VZVk2UdEwzd9q2P9suF/0vtum563ExkTawAC4M1knN4GqVY/CRv++wZGOOD9XLelWD38RfAcm3KvPP4h3IkOggcf+aUi4CTCQcJk3HEXK120=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786113114; c=relaxed/simple;
	bh=VmM0KT+y74h1a4CB04ldravzghk4LAF96PVg8QofFIM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JXf6wzX+H5W6JZhyKaMFD/0A1wjoUcqk6I109kxdy/REn+SJGvXmybYoTsZYwWTjitnWk4Xn0HlEJ5v2UhbM/NM8GbuvASSMnriByiOaiYqlJUGMfhwgrsefYwom7MtKlLoEg4OO1V5EEI2Zr5ltHg7YcZg6c7D0Db7s4yteMiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEYvkufM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEYvkufM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6244D1F000E9;
	Fri,  7 Aug 2026 14:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786113112;
	bh=JKiB6cSnWgA759K/6kRa34XbswAGzOe3+CINS9TTSPs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WEYvkufMsWlOvbzmADG9pHLxYv/D74yQWH35YlvuOrFCEb2g1rqjbgTY+IFVsbWrm
	 /cTfqDHVoRJcRLl4e0nFk59/9Og1K8IlMiWLz/RuXwrEy4hmoCDvHCEVOITvcXPS1r
	 VZCosO2AcOibG5JUrhbIV7TbxWjueQAHJDrot7inLMhGbYy9tUE96+oUQ41bTueDgb
	 etoSBJ+AMrQXf5Nx+yHqCrJfMewkxrvSijChryZKSQRESveVk4+/v1FW3hBqauQPWj
	 O1zXBDErB1sPSvSRysXBwSbTW2omNWiYB8YkgNfY3gg15/gfLY5AJLNPJErQVQBoKK
	 LCxs9WnLV1qBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] s390/crypto: Rewrite AES ctr mode to be prepared
 for context analysis
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260807135440.35888-4-freude@linux.ibm.com>
References: <20260807135440.35888-1-freude@linux.ibm.com>
 <20260807135440.35888-4-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 14:31:51 +0000
Message-Id: <20260807143152.6244D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The AES ctr implementation produces a warning when used with clang and
> CONTEXT_ANALYIS enabled:
>=20
> arch/s390/crypto/aes_s390.c:585:13: warning: mutex 'ctrblk_lock' is not h=
eld on every path through here [-Wthread-safety-analysis]
>   585 |                 ctrptr =3D (n > AES_BLOCK_SIZE) ? ctrblk : walk.i=
v;
>       |                           ^
> arch/s390/crypto/aes_s390.c:577:11: note: mutex acquired here
>   577 |         locked =3D mutex_trylock(&ctrblk_lock);
>       |                  ^
>=20
> Rewrite and reorganize the code such that the clang compiler's needs
> are fulfilled with keeping the compatibility, performance and
> correctness of the crypto algorithm.
>=20
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807135440.3588=
8-1-freude@linux.ibm.com?part=3D3

