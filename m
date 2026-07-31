Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29E92D1913;
	Fri, 31 Jul 2026 13:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504659; cv=none; b=EBuWFaKgn+7ZrSIyqcLR1adtgGWgayL0fnIYPcrGu2MPkOg6Yxxa9994MrLara7sI1k2VnBiebRpM7U0UdKaZQUZ5NbMaynuZA2KkXZPOgwd1+uG4RQ/8dLpfD7ZROQlRP07eIKmGosaxIfzz4lKRsfnU73P3x2ZXTCKvocZzP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504659; c=relaxed/simple;
	bh=fNozuXMQlzAhc5ypn1jLsQROWTnOV9URzp0a1LAPUy8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fz0J5M7HCbmydHiLVRRhR8c8b1KWW2EAaZL0lSExYQUEwpA8vh7bNSybjcfu2ESH70oOpCnppEEGTGgxhxaAVIS6OCDnREoVtybdBPNYtrc+k4IPu8NBJYuEJkzY2lSGPUYgfKfeSmC/dUyanJgalXVQBu7GyT1wPVuLwSNYHMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UENuKQoi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UENuKQoi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CEB1F000E9;
	Fri, 31 Jul 2026 13:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785504658;
	bh=fNozuXMQlzAhc5ypn1jLsQROWTnOV9URzp0a1LAPUy8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UENuKQoixZG7GXPByyvbrl74HSxRuTm9UA84TLOcL+047vP/DR6wfHAHgme8XgaLq
	 gLR1TN/iYkjlUlwfMoeSw9ORyJV4fZZtBtdvHEjikDOhWTeda9JKyfthffWR1xT0u2
	 efNbm30rolaOTvBPcDgwog27aB4XdEqqDzNffq00B/B43B01cT1zk91So3jJW+R16n
	 yl0f1SUeAMIr23CNi8WIjGeVZkguh+niWgRcoNjtqXkFwT1xFmib171pCDbzkrhiGG
	 8K0+LCd3j38//JSyJL6JhOCj4+R2JBIL08MS9BZJhID1xc29cAUy1ljQFUcnk5HOmt
	 5RykiVimiLnUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/31] KVM: arm64: Refactor core-reset into a
 separate function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Marc Zyngier" <maz@kernel.org>, kvmarm@lists.linux.dev, "Oliver
 Upton" <oupton@kernel.org>
In-Reply-To: <20260731130902.654679-10-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
 <20260731130902.654679-10-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:30:57 +0000
Message-Id: <20260731133058.07CEB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Move the reset of the arm core register into a separate function for
> later reuse.
>=20
> No functional change.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130902.6546=
79-1-seiden@linux.ibm.com?part=3D9

