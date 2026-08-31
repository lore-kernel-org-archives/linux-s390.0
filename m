Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B2D3B9DAC
	for <linux-s390@vger.kernel.org>; Mon, 31 Aug 2026 08:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788166160; cv=none; b=jo2popx9pGzDpiI/0vXwNJKaist1b2j5jEzF7AB0CfIi2WYlesdskGSVsonHAJVs2vCJwvxfCh3lLB/pBvWXBQg43Xs8XYKlMHhZGSQeFiT35vgk1SHek+FKux6FoKiay/MCgUOSXc3CYH1RKnALhlorpPhsWHoiwvbu6d5DW7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788166160; c=relaxed/simple;
	bh=92OxelfNorOaiS2eu/Gx2svMCeNnc4YaB+R9Hdxn+bg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S9u2nXG3Gisud0nflkjdLe8kiNyygWz4qmIiB3KYzgNHjN8IKk9g4ZeExrbwgN0205Yg6rahlzzRTJbioDHbHU9hOssWWumRKzEw/+cHv5qioN4Ztn4VJQq63wgXbbodvrzyoYqAxZSi/frqWIpYLsuhVcbaxYFImyv38azqltQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LiFH1+d8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LiFH1+d8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7391F000E9;
	Mon, 31 Aug 2026 08:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788166158;
	bh=92OxelfNorOaiS2eu/Gx2svMCeNnc4YaB+R9Hdxn+bg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LiFH1+d85qtpIiPVDLnYqx3RZFdTVHp7p0b0bZMoZLeYqhcxxLdBkHCvxKptoLxWS
	 NjZ+518nhoCsEIpyWw9j6TcXt0i6Ud1b7FPBJh9ZkKlHtY30YgdRQ/QBUbuR+J1CrB
	 Ty2DZzj1I7yUd5vPOcIYv1PE7rsXVtquTGbA1rTDHEpFJbWc8O4Se2tWCmOwR7qvIy
	 7zv1IhmlCf8ov7v2BWX+rUld8uO7b1nLAYicjK6FJXe7n2twB89g2QYDXE7cfUxavM
	 yakpEF2T1V4eGoBjINk157OLcLJSxJiEfNgwgFnQfPjQVpjHxJUzH0UgDWw7nC1Vid
	 DUnANnxZ1febA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] s390/crypto: Fix skcipher_walk return code
 handling in aes_s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260831083735.3625-3-freude@linux.ibm.com>
References: <20260831083735.3625-1-freude@linux.ibm.com>
 <20260831083735.3625-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 08:49:17 +0000
Message-Id: <20260831084918.3A7391F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The return codes from skcipher_walk_virt() were not properly checked
> before entering the processing loops in ecb_aes_crypt() and ctr_aes_crypt=
().
> If skcipher_walk_virt() fails, the walk structure may be in an undefined
> state, and attempting to process data could lead to incorrect behavior
> or accessing uninitialized memory.
>=20
> Add proper return code checking to ensure correct handling of the walk
> initialization and walk advance and eventually return to the caller
> with that return code.
>=20
> Fixes: 7988fb2c03c8 ("crypto: s390/aes - convert to skcipher API")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831083735.3625=
-1-freude@linux.ibm.com?part=3D1

