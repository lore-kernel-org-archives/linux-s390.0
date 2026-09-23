Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D3A56853D;
	Wed, 23 Sep 2026 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177129; cv=none; b=cLQ0uBU9eIvi35jbjQdfJuZIKk4sC2dkOmlfmZYXLsHLNays1Anggc2VGF4LE9B9fkvKLup4yBrOc4hJ2hzV+xDMr8tlE/pvsQMMyv61doJdeqUHrmmlwaLCx5omXUx2SrHMR51MmcjAXVU1sLEvs6swcpt/upZKb1yo0W/1hB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177129; c=relaxed/simple;
	bh=flwnNWej7niYyYwkuya41OOrcGxdDKXX9RChNfUgHJo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mdvZZd7c+z8RfDzsW6/HLRTYYRjf8vFpMU8sUrBqF/ImKTXnIbH1dHDQ4CLISjAgX2tHPFLyPXmtrYyEyXwwWQPIUXxcmmm/unwjBj30qZsopYiQAVNo8y3y0IeQ1uRUd/9RdL4HisJReFJwukbATXQPKnIIWBaSDAQ8bRxqf7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhuYGXX5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhuYGXX5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400E71F000FF;
	Wed, 23 Sep 2026 15:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790177121;
	bh=flwnNWej7niYyYwkuya41OOrcGxdDKXX9RChNfUgHJo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XhuYGXX5DEcrb7Oh5j6qljnUiWLyfybV6u1Enis6BmQUGLnWtWieX05sDVLqq3e/I
	 ji2l59/OpIwOL1qpgLrFrKM+/0eP56rH62hZ8+bqHne/rb5izCQNbkNmN312cJKBov
	 3+RIb3XvvDWCxyYllVGhTNUi2uojmSl6cfYvQOW2EXO8T17PdpYUTc1vJuy3KDjPU8
	 G421pLi+FQ/5H36x2m11kXRBH0lmFFTdsfh3uXIbj9+lgMiQnvvLVdWU/IZAvoYzeK
	 8XISesJ8VLIB5/HyMAqx5PdvSWC116tRz8H6qc3STOLitMzM6OorBbtt0Emm0Op2rJ
	 PNzBl0rcJtPUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/14] arm64: Add ESR fault helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Oliver Upton" <oupton@kernel.org>, "Vasily Gorbik" <gor@linux.ibm.com>, kvmarm@lists.linux.dev, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>
In-Reply-To: <20260923-kvm-arm-prefault-v4-2-d4b0b4dfa8c3@kernel.org>
References: <20260923-kvm-arm-prefault-v4-0-d4b0b4dfa8c3@kernel.org>
 <20260923-kvm-arm-prefault-v4-2-d4b0b4dfa8c3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 15:25:20 +0000
Message-Id: <20260923152521.400E71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add helper functions which operate directly on an ESR value rather than
> trying to access the register itself.
>=20
> These mirror equivalent KVM vCPU wrappers in kvm_emulate.h and allow those
> wrappers and KVM's stage-2 fault handling to operate on a plain ESR value.
>=20
> This is needed to later generate a synthetic fault for the stage-2 page
> table pre-faulting mechanism.
>=20
> No functional change intended.
>=20
> Reviewed-by: Oliver Upton <oupton@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-kvm-arm-pr=
efault-v4-0-d4b0b4dfa8c3@kernel.org?part=3D2

