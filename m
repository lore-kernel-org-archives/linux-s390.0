Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C9B4582F7;
	Wed, 12 Aug 2026 15:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549621; cv=none; b=MLWkFMO0iCvCSMFWy+R24XB2mapG1Kd9zCbN9EyNqPOV0QCyYRZv+E8mFJfeWtg2tlVkBKNHQT1DVfUCjt4GAWo4t9xpOcRd59U7IgnsBcp7R0Erg4ajI1chDPSBqEqZaoWBCifQdNoottAqGIojAhe0kl0ddEZQ7gY5ashsIKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549621; c=relaxed/simple;
	bh=Au0LFK9q7SiaIg07P72ewKLkcR6j+zKsQBP1hduY+v0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iEM8raNzqUzQoqGMV4WFCHbnzLHAHaiKgbOb+K2l4Z6EBVR0ipJQss3ikhTcL/Sv7vy4erA2ADV266BOoSggU7+JoCNs68GGj+i5BDyHZm25VSrolRigjS0UyerPjd1DPOl+g4oRH1xP+jbWXaBZnL0TK4FTHtzNLbxiH55G+sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enYD4H7l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enYD4H7l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CF11F00A3A;
	Wed, 12 Aug 2026 15:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786549620;
	bh=Au0LFK9q7SiaIg07P72ewKLkcR6j+zKsQBP1hduY+v0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=enYD4H7lIIzzrwtogso/bDs6LuHGwe+Y2Zamppnh877muHOPMekWm+ezuqtSmZzig
	 vLhBMcN/BqhFG0JLFu1fryH+jxJrFQ6q53e61Y9tx52Wv4wcH2Fj4xQsqaDbsLbyZB
	 JZSKuhS6yi1aotVWLUibMyvfG3YQhHtXdtl32/W6cdh2Y0pmBX4YAvhoRInmGf1u51
	 eHKFUWiZM+86NZ5X4xWlOqU9DfHF1wOKvKXkItoDMg/CtIgarj/tjiSiK8bX2v+Cod
	 8VlUPeRXFZnT2Vn+ub+nNpuqBPpBG2KLjxdatbMiI4PHHdLM37b6eJYz+8goWF+rRA
	 wSNwOn8aNtnpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/33] arm64: ptrace: Use constants for compat
 register numbers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>, linux-s390@vger.kernel.org, kvmarm@lists.linux.dev, "Heiko
 Carstens" <hca@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>
In-Reply-To: <20260812153631.3376090-6-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-6-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:46:59 +0000
Message-Id: <20260812154659.E0CF11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Define an enum to determine the register number for the mapping from
> AArch32 and AArch64 registers. This allows for a more flexible use of
> the register mappings.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153631.3376=
090-1-seiden@linux.ibm.com?part=3D5

