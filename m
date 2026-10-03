Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A113750C9
	for <linux-s390@vger.kernel.org>; Sat,  3 Oct 2026 01:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991190; cv=none; b=My5gTmrxXs106U7fOJ2wVExxID/blt3EZqGsG98r12bKDJQkl7KxbOTLEbUzWT1ndmwSUmUL/0MwDXQZ3L0DDIYL51XI/mJNXOFbGJCVSuY64BS3TGA5qx6r1RcpP5whZw9wWhiYDZd0b+j8QhPfD8MRSMaYHxaIrGln4mqEaow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991190; c=relaxed/simple;
	bh=bwhbLOmnjhOqZ9RnUU6Z55cXHh+OFTMxXStTjjzqoLg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TGoItuALEyrGIxWaX7DeF8MZ3LhZ4lwGOJM658xfDdxr/4cRmT0+oB5spn2+E3j7W+c/RNcvY3baBmXaDEiHqGwsTRbWoD8wzbTXfXWLhpbRFLiTCZ/ySjLhHgkvzZRFWKYmLu4DmqReZXXzvjYrkod/tvx7YENpPwAzWeYXn7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhE/u9xO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhE/u9xO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6DA1F00898;
	Sat,  3 Oct 2026 01:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991188;
	bh=bwhbLOmnjhOqZ9RnUU6Z55cXHh+OFTMxXStTjjzqoLg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DhE/u9xO2sCas/5O3kp3BK+srRGvLBJd2YNiQX62jG9H53po4Awm/aiwUNhhIuxe9
	 eyWJJghp+V3SoSzLIimTK5W+vR1vD/pF5mbVVfGFjjRbo9iM5rcs4wPF8vb5nsjI14
	 RvQcXDXv01fZOsWy3dkv4tvm9a39ZaE7dL7GTrvhdt7tMDN8wxWBSG5yISpIuhNoDJ
	 kBKZuiXP237B7zY5RVyMSf2adX3NvMrfv0g5nfoc8ma8ZzjqRI08fFgsMISdlwqMBz
	 zmeMXToE7X3OZ9T3XJRZPBHfCnm025Qhpm7PSshLn9vLZynyB1/cxFHGnccc+lJv0u
	 cCA/GNXJwLstw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] s390/entry: Save lowcore on invalid kernel stack
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20261002152055.3305184-3-hca@linux.ibm.com>
References: <20261002152055.3305184-1-hca@linux.ibm.com>
 <20261002152055.3305184-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:08 +0000
Message-Id: <20261003013308.8D6DA1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> In case of an invalid kernel stack copy the current CPU's lowcore to
> stack_invalid_lowcore, so it is available to debug tools after a crash.
>=20
> The copy is helpful since the lowcore is modified e.g., when printing
> messages before a dump is taken. Keep it as unmodified as possible and
> as close to the event that caused register corruption.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002152055.3305=
184-1-hca@linux.ibm.com?part=3D2

