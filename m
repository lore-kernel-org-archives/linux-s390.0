Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9DD4746A8;
	Wed, 12 Aug 2026 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549731; cv=none; b=XhloC19dcRSch+2zzvZ1RlZ/rdX+K6BQL55PP9d9NuRxO6PL0OiE5TrsQFgYmTWm/Fzf5Oyeu9bgx/mqy54pEcKg3AL4yrMmcykkcGDt3gCvdpIy54UGqne20eczt0FGwWyGjhMJCYoKYQ3LJl85raSyaRxc8JNVF/xTXHA6sjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549731; c=relaxed/simple;
	bh=3YmroY536YpKHLPhO2GqpOkaXE3a9OVTSPBN2FbJB/w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XG1UTLjhtHFB+iBrTjzuREAJXXPjJiIz4YgUl54FoMwHTWvjoqK9jX1LBuebJ76mujdcUX1k6Je5WWrtBDysjc/KBaARn9L1WnysT2xSthDQLhfjZLOGEaexYl6Cx3rtU8PRqJuGK6iz4aTNIloUmibvBvhE9J0EZXjmJiqZ8Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Plnjtmwc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Plnjtmwc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309701F000E9;
	Wed, 12 Aug 2026 15:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786549729;
	bh=3YmroY536YpKHLPhO2GqpOkaXE3a9OVTSPBN2FbJB/w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PlnjtmwcNz6M36e5plcSSUi4QzVUjJ8PACceGagZCTxGGA/mdLUN0fs92M/j4bx3y
	 WMeOkKJ24eSJvC4UhesjJakYXnmPrqwzGyyYGJ/rtj2fSkZySx1P/nV6Q+XTfULCCa
	 Bdza3j85vSGmDwMavHcA+y2+B29w+Jzfxcbm6dDQ146/oELpS4dDyZittThzGkHDWn
	 emlCY3gEhrRHuuWKQllOBTCkBDL0yfvX8q3cqxhJ9tfhnTI/nX3uIkxaDbpce31cNc
	 uqVWPGY4+Oxp24yp0Hx7w5tJExPWDhlGnwU82hXMGEfQdPcGu1Up7GP3AgHqOhSnxd
	 m2NnB88RWDH2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/33] KVM: arm64: Access elements of vcpu_gp_regs
 individually
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Oliver
 Upton" <oupton@kernel.org>, kvm@vger.kernel.org, "Marc Zyngier" <maz@kernel.org>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, kvmarm@lists.linux.dev, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260812153631.3376090-8-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-8-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:48:48 +0000
Message-Id: <20260812154849.309701F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> While for arm64 the members of vcpu_gp_regs are allocated continuous
> this is not necessarily true for other architectures implementing ARM.
>=20
> Let vcpu_gp_regs() no longer return the address of the user_pt_regs in
> the vcpu context but the address of the gp-register array field in the
> user_pt_reg struct. Note, this change semantically excludes pc from the
> GPRs.
>=20
> No functional change.
>=20
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153631.3376=
090-1-seiden@linux.ibm.com?part=3D7

