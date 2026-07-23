Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A82369D7D;
	Thu, 23 Jul 2026 22:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784845513; cv=none; b=aDX/by+df+9+k2us3l3jzujMh/UiwWTfeisBAQhnFBnBRtxlf4xPlqROitrrZIlP7mNQrLKht/dSI3xvDl3wC9Cp68rI4RfABf+t3Zyc/+tgVBHIh9YXpJLsAwWkNRws96dO9XAR3ijepqbpu+x0UFhkAYT9L3P2jEJXGdhwoGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784845513; c=relaxed/simple;
	bh=s/KlTyC1SsqpWdA3TDzayNAxKg0Ki0qjFiBQCyeKNSE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AqFV+rbbKBT8nUdUsbVcp1nM+ivAOm2sSTn1zAfUdB5+qikPL6CTzk7QfckRjBnHiZLMO1BjsWjEvUp4gCY9BWEtPnvEZcmU0Rm6LPqrlN3rwjU2KMRIxG+aip5N1Rui2jdxihUkdUDxsqTt0uWmtixxgD8D/jc6DwE+VTQjiyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2TuQnyn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2TuQnyn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E631F000E9;
	Thu, 23 Jul 2026 22:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784845510;
	bh=s/KlTyC1SsqpWdA3TDzayNAxKg0Ki0qjFiBQCyeKNSE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j2TuQnynUg1QIXGkbJr+wExhoVhxg2QAX3aH2oTZtOldLjce0zmkw9i1xbKY+wXO/
	 8+Nd7jvOigb16ggNsxoVhl6+f36NZYurWf2tE1NIY+VLUp3uRd2fvZonTC+4DnsR1w
	 u4FYIb73gsMCjWQDp3RRGsItCkLvMUK/JUASHvi5FUGhCtlFmYO0gNpA76KZV7XdoX
	 KBsyYCeFjrryzSUNvzLvp8jlF51K6qW/SBVQxV6C6VgsFhYHasF1itlXF2/sCbSmpu
	 R8i9B4oxHPcY+oKtESJrGM9aaPV+zJPiiDsheZaK8axCwfTjZlqUiGYQYYRmUgp0xf
	 9c7cV/SCt6iYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/6] KVM: s390: pci: Fix resource leak on IRQ
 registration failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260723221409.5874-6-alifm@linux.ibm.com>
References: <20260723221409.5874-1-alifm@linux.ibm.com>
 <20260723221409.5874-6-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 22:25:09 +0000
Message-Id: <20260723222509.C9E631F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Currently if kvm_zpci_set_airq() fails, kvm_s390_pci_aif_enable() returns
> the error code but doesn't do any resource cleanup thus leaking resources.
> Fix this by cleaning up all the resources such as the GAITE, AIBV, AISB a=
nd
> unpinning any pinned pages. While at it, remove dead code that stored FIB
> values that were never referenced.
>=20
> As part of the cleanup, we are also holding the aift_lock a bit longer, as
> we hold the lock while executing the MPCIFC instruction. Though this is n=
ot
> strictly necessary, it means we don't have to drop and re-acquire in the
> error case.
>=20
> Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disab=
ling interrupt forwarding")
> Cc: stable@vger.kernel.org
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723221409.5874=
-1-alifm@linux.ibm.com?part=3D5

