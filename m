Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF007429838;
	Fri, 31 Jul 2026 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785505803; cv=none; b=F6CK27DMsi31rNqokdgSKLdvajqOSCwNPIgtS13g1KRG6lQG95PQKBgAfTRqEoM2aI47GjvREW0DkRc3GH6A3DryoA7YKp0hoHo8jfwyt1LO2tLNle5qgoEXPFuC8Mil5HHgaoSCRYYBRbk6Kcko0oLWT3V2gvEOFD12UOO+yA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785505803; c=relaxed/simple;
	bh=pURwjY4+Q8U87H5g+Q4G/tSFMwDhkj9l6M82ikcdqWM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lP4VYWVbA6tLTbCmP+VmouPtmMcnMRmoyr5PSMcki6xVsyT7B5Ou/3qIpqzLf4k6ZrDKtWaTykRU7VOva82hCltFxdN7Oi1OuqMQmwV7TOI6VgVGPeS0yOCBt1Tq3hofS8CREVkTibBTKyRtFuZfseDBFm/oeVwpGqYahVQCNYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lror6LcM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lror6LcM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D2A1F000E9;
	Fri, 31 Jul 2026 13:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785505802;
	bh=pURwjY4+Q8U87H5g+Q4G/tSFMwDhkj9l6M82ikcdqWM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lror6LcMlFlosO5Us04ZBCt+qe6Rs1IDcwJLqkJ5UHNIEm6bjarw5Pm4gk1qU78i5
	 M7CdgH4i2hNA7cHt83MfSYpXcLA1XQWJ2L23nBbYc/ztqWhvlS5qCTok+VvE730XeM
	 nOS50fkblT7Yg3DOj1zdZJZcO+7Xwpv7bEWoKZTKheDFADNwFDC9g/r3dXdrQqeckp
	 mtNm6YZMu4uZ5ow0MMi0VcP4cZ4ToQvOux+hFSr72YrUQ95/MEfkU8u1al8OUtRyMR
	 54pcNiCazdQemjp4lttvc/H68iLRfMUmdLB7EHYRhfDGsSNY8QI7rSMcRZzcxE4FJR
	 ALmFOZcgv55rA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 19/31] KVM: s390: gmap: Move prefix handling to
 kvm/s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Oliver
 Upton" <oupton@kernel.org>, kvmarm@lists.linux.dev, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>, kvm@vger.kernel.org
In-Reply-To: <20260731130902.654679-20-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
 <20260731130902.654679-20-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:50:01 +0000
Message-Id: <20260731135001.B7D2A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Move code handling prefix page tracking from kvm/gmap to kvm/s390. This
> enables other KVM implementations to use gmap without implementing
> prefix handling. The prefix tracking is turned on if
> KVM_S390_GUEST_HAS_PREFIX is defined.
>=20
> No functional changes.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130902.6546=
79-1-seiden@linux.ibm.com?part=3D19

