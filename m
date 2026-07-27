Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB1136F8EF
	for <linux-s390@vger.kernel.org>; Mon, 27 Jul 2026 08:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785141934; cv=none; b=ptlgfPD8hHQVk8xLHm7HGOS4yopxS2C2bsKwjcou8vx4aKehPaNlP2fhFsegGXRp91+8bdyM/rGzGWvM/dq9VDuyNqx2cPlTAdjW1sfYqUp5QRgnI1VHyX9DwZI4gioTyZdK3jNRlzqdvj1OdFqqvsQbbX20Gpja4c4H7CbCtZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785141934; c=relaxed/simple;
	bh=3so+I4qz4PB4DXk/DNZDcpI1ObwRPTA1PBvZXN7n1po=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=snhLIH+VBDUrEIuv6eatXONQA4g5D3WEgiPG80AGWiqOal5qrdrDiBcJLIVTYoCGS+y31blbl7cMUHGr4P6vL9pny0F14MKUYaCmNw1CULFLwyIBcZE94s8vnYHWo8UUG0SDAOIGiJrWArhNzaFjEuc54RphuzwICB+OOKZ17TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gisBTkV7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gisBTkV7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF0A1F000E9;
	Mon, 27 Jul 2026 08:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785141932;
	bh=aI+fqmfmcqXQ8Jtj3n50PAqXhmn2rCtwrYrwAIK8/Js=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gisBTkV7fJKXnDlPG1hsdDXDNxienoIfb/xEXH/lmfHDWHujUcrzMmwkwqMlWFs42
	 r2GbQof6pDJORSMC2q90diTJ2nHvhkGFUc/azK4xVxb8ZQ4wFGIkXcLtiug+LwUmkg
	 EqVINS2QYFjZhjMWWeoKQQRbUxBe9oxUCmTnAfRHiytJtzZ9m37ofpwIRP59jrONn9
	 eSvyYC4y0a1kYr+ThaysYe/kdo6iSv3LyOHiRJj0qoZdamiMu03YTn7wWJpa6rE29W
	 Qu9db1IRxajHzSNKSFQiuzQmb5vhQN/Vd6cyKGEky8ZubZdAU3ojGmmJ/mh8L8kYCV
	 pl1N/ipD4ORgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] s390/zcrypt: Improve EP11 CPRB length and
 overflow checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260727083200.151976-3-freude@linux.ibm.com>
References: <20260727083200.151976-1-freude@linux.ibm.com>
 <20260727083200.151976-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 08:45:31 +0000
Message-Id: <20260727084532.6AF0A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The xcrb_msg_to_type6_ep11cprb_msgx() function lacks proper input
> validation, creating security vulnerabilities:
> 1. Missing minimum size validation: The ep11_cprb structure and
>    subsequent payload fields (pld_tag, pld_lenfmt) are copied from
>    userspace without verifying sufficient buffer length.
> 2. Arithmetic overflow in length calculations: CEIL4 alignment could
>    overflow, bypassing size checks and enabling buffer overflows.
> 3. There was a gap between the message size copied from user space and
>    the message buffer sent down to the card. The msg buffer size is
>    rounded up to 4 byte boundary.
>=20
> Fix by using size_t for length calculations, adding U32_MAX boundary
> checks after alignment, and validating minimum request size and
> minimum reply size before copying from userspace. Also pad the gap
> between user space copied message and message buffer sent down to the
> card by zeros.
>=20
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727083200.1519=
76-1-freude@linux.ibm.com?part=3D2

