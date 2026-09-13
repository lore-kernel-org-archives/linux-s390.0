Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240D533FE0A
	for <linux-s390@vger.kernel.org>; Sun, 13 Sep 2026 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789307449; cv=none; b=ZKT5nNOG5C4ZMlTFz5/ihYw2rDPPuTRvilODAhHDIRGHmM1Btma8SVV59Cwq3PmRe52sLGeJwEqgRNiMkMnZ3bRYQF99Lytj1jEMl5H+xAY9+uiZ+iuuFhjn9TilAl+QBEZ3pf8I0tWwoF4D32LVGIITSsb2RKC3w0M/zLzf5Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789307449; c=relaxed/simple;
	bh=Evtt58MuD5zXkJUeguVwxG2MmUzVd/WejoMUgQi+zkU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hympcF4gJiLfplg0Z5J/SOvRsCTC0MPKOPv/0UhfdRW7TCY+1gTL2pLVAA75yEHYqAYyhOoeikPpxK0xVYULVoxclVYN6+LxaSLVe2f3XnCTdBzTlbbRP1XaOIPbwyMAvh/jJReIjMqsEXTRdY1Rb9BPBkPp0gj39X4j4m8BAGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDiRjjR1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDiRjjR1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E231F000FF;
	Sun, 13 Sep 2026 13:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789307447;
	bh=Evtt58MuD5zXkJUeguVwxG2MmUzVd/WejoMUgQi+zkU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iDiRjjR10VuKL7CcblPZPYHXQOUvAxh+gThbbSwHmk1ECbmhA/BZaiv6sfMaweAWg
	 E2E1aVnlk4LZXS+SsdTskJC3jl4N4K9ulNF8fLXpuVthOiJz1QJjAiXBiyv4OjX7u3
	 3esBBLSTm/aWG3wKOhN+9jpu60ASyAYwPg2ky7mlMJt2FKWIj8a00N10UoGxGw2Evj
	 PPNGuP4msB/IGVRzlLCqLVEaHZ//muuX9/28J9ArpDEAWUgPqSvBrkBKAdYxCJwsEr
	 zajjkiph2LYdSeDmHFDzcJH38QxToOFfppL9WHEQOyL7XmwOjPuwxbq2/S6QjAmP+p
	 76XD3yQnnlE0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 1/2] rtnetlink: pass extack to
 ndo_bridge_getlink()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Artem Lytkin" <iprintercanon@gmail.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260912135022.1701-2-iprintercanon@gmail.com>
References: <20260912135022.1701-1-iprintercanon@gmail.com>
 <20260912135022.1701-2-iprintercanon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 13:50:46 +0000
Message-Id: <20260913135047.64E231F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Let the bridge report why it could not fill in the link info for a
> port. rtnl_bridge_getlink() passes the dump extack, rtnl_bridge_notify()
> gets one from its setlink and dellink callers.
>=20
> No functional change.
>=20
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912135022.1701=
-1-iprintercanon@gmail.com?part=3D1

