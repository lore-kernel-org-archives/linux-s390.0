Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190B93839A1;
	Wed, 12 Aug 2026 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550988; cv=none; b=qc5341t1yGR7Qxa6pKqZCx4x5zcFJpBwlch7+Glw8933tEmAr3Sqh9G5zvYfYKP5dHs0cASwLPwZQuT9MprFfPQ9nSHF4W8jV3/cUn63eAOHqhCiEhWzagcWbUE2m3q0rYX9bEFR57go0hhERSkTGnkw977hwrdaueiKl6keb/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550988; c=relaxed/simple;
	bh=dyj7+NJAOfH6nveNMo38iYyvg9kUOCC51s5TfiHhB4w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rB3Fhgs1AJfYd2oIEDy63F1dzx6/oLMAhnVXwM3R9Adys0OyTlU4tSMEQ8EuqxsipsoJhZh2z61Wu4FzVUeJvOTlH6GY71V5rU1KupO2q8Lr2N51LdpvpYJr6O1Sfel7F99rglbs9PKwYmbKEdbn5c32pjVVS54xCkLMRcb/aio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dH/NDw9Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dH/NDw9Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF481F000E9;
	Wed, 12 Aug 2026 16:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786550986;
	bh=dyj7+NJAOfH6nveNMo38iYyvg9kUOCC51s5TfiHhB4w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dH/NDw9ZHkCRDbikV1mkhfeueVBL1lT7SGeztM6Px28P/0CuqR3z28rggs13ITutU
	 czOt1pPrUcI6DvT0lkslKUP50ShvqAZdojWV9fwB5JkDulaqktPcDkzSKLuviqipUS
	 bWBnt8fxfgYkZXPxJ8pDyha5jodpud2PmSrc+qSfZ1D3yRaj+V2wNqF7IiOEg0Ci/w
	 eANgAcbf+rI2W6DeV+F/I/CfD1gI1YFCSXeBN2t1p+1XHFVZg0Ffkpsj/K+MxZx/vL
	 htGG1D4Wt2Mk6ArWETPwaiVSwm0iAncK/1BQenKvxQBsKeN7lSpp3MIbr4rG2FBAxJ
	 e7cMv33Onjgfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 20/33] KVM: s390: gmap: Make CMMA optional
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Oliver
 Upton" <oupton@kernel.org>, "Vasily Gorbik" <gor@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvmarm@lists.linux.dev, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, kvm@vger.kernel.org
In-Reply-To: <20260812153631.3376090-21-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-21-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 16:09:45 +0000
Message-Id: <20260812160946.0BF481F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Guard guest CMMA behind `KVM_S390_MANAGES_S390_GUEST`. This enables
> other KVM implementations to use gmap without implementing CMMA.
>=20
> No functional changes.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153631.3376=
090-1-seiden@linux.ibm.com?part=3D20

