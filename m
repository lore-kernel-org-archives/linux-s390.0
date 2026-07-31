Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBC241B8CE;
	Fri, 31 Jul 2026 14:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785506980; cv=none; b=s8derYgzsmqW5vxzCM0gKHmgBMuFF/aGNjpSpngC5uXUoRpZ8TcgzkRBJlSPXRvwTLMNWKPWcLWn7Txs1EcWSAY0sQr2JYK+i0HQ0UJnl1G3o7jecwiaH1lW5EmyJJj7qSCr67E1BkYAmKjl6qDlsDVvpaQZfickli2D9M/qWps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785506980; c=relaxed/simple;
	bh=HkCEVyIWfclJC24KmEwwKoED4846ao/Fe77xXEM3zus=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QEUXK8xNw0AXDJ9b6Z2QAege1DYwTl7BRHYjV6o/KWGNp4nmriGOqcgFiuYKX8nnuHuNHMC1Yv+IN1WVxwR6gJgYrZvrGBDPmVbE7DeyMmduUqIIXk84g/2Hls1RRlcJ7AsicXCOh7g5pHNs/YC3uAcTvmIJrosdn/Ea+iRnBQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RO64hn+H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RO64hn+H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F047D1F00A3A;
	Fri, 31 Jul 2026 14:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785506978;
	bh=HkCEVyIWfclJC24KmEwwKoED4846ao/Fe77xXEM3zus=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RO64hn+HgXHnHfbL16vx5f8aka2yADAprzru/rB2ix/d4XErl4oF8jrLIXoPxM5zm
	 2Gg98GjPeRtLZYr8/D+9F5rOBUnNeJNMnd7ehrSG9ptiOmjWhleL0VjVZOy6k1P4GH
	 Fj+4DRR9/4PUA5rVLCrL86JcmVFy/LfsWtUq265s7O6YRHanwlOBPDrWCW+WFaYMd8
	 24kNOQBgLi+eIxbPGRDBqDKG//frBr5P6jmEU1kwMwuN44EJze8pUhvzgO6uC/J/xC
	 QOhE0RyVbCGdcx8yDwBEcujvUwmndICP6YThzCBl7+HONjKmERgpth1X//z3jB1XBM
	 WhI1p/PfDklPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 24/31] KVM: s390: arm64: Introduce host definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, kvmarm@lists.linux.dev, "Marc
 Zyngier" <maz@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, "Oliver
 Upton" <oupton@kernel.org>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260731130902.654679-25-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
 <20260731130902.654679-25-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 14:09:37 +0000
Message-Id: <20260731140937.F047D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add all basic definitions the arm on s390 KVM host requires. Including,
> but not limited to, struct kvm*arch definitions, various functions (to
> be implemented in the following patches), and various defines required
> to run arm64 guests.
>=20
> Enlighten asm/kvm_host.h for the new header variant. The new
> header is chosen instead of asm/kvm_host_s390.h if KVM_S390_ARM64
> is defined.
>=20
> Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130902.6546=
79-1-seiden@linux.ibm.com?part=3D24

