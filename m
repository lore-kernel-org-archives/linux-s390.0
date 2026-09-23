Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAA455C300;
	Wed, 23 Sep 2026 15:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177398; cv=none; b=IaHMaBMdHZabEaSNfXKrk1yCtkRql6nZXSPvmGxRBQH+onws2anJO/XqF1o3qgVYDGfNnFpNz8asm968BS9TTfseBfQkvAIzxJtboceXG/SUsKxGbufsDei96qKERvqUM8mKUcDFvqunTvnh1rXhN59XzmUZdpm4/dZ+fb7KNqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177398; c=relaxed/simple;
	bh=/bedJ4EkSPqejmfAKA4XpkYnY9ru9k0/AS3QHB+0LVA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R+hLFtEQkQPHuSj7ae5UgWPk3Y5b+rOLv5KuO6TcSG5viKwfEkgjCQPu8SENFLf2UymEqNzkLTC6M1ZmLYpymoz9aZGQ07OvFOaRWqY5HIN6++MqZ0jOSiLhtiw3lcVaIT4mREutIiCXT0qB+X2vGlTUZ51axFssiK4T75rLhBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDVUKuks; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDVUKuks"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DB41F00898;
	Wed, 23 Sep 2026 15:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790177379;
	bh=/bedJ4EkSPqejmfAKA4XpkYnY9ru9k0/AS3QHB+0LVA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BDVUKuks9INopTUGsJh6UFhUj1novrTGeY0DUd/VH+DlORQli1VeaD3PCdC1oZFsH
	 /LrObSHTcl2oLgcBPtJBfcbyEab58ruzr68IGgaBxPCP8XV1CjKpSNxbnLuf+KAc76
	 4kEtQ2NDP9SJ58/Qv07M6oG4i8GQKhzRzUPf8jJLJgNz38IhB2rzyBLHlsy8DOpkaT
	 dhDQdexKvD204YJm3NAbuPU7cW0phbjRO2JZKVgISmUKgk/lhaxrbvu0cEwmzvWS4I
	 tlnuOIFWimNknX2WlPM8kGC1Vp101IpDZSZSWTIG2AeyTn0kOAtoMKXfPbqZIHO1YM
	 RWktSZF2/HGjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/14] KVM: selftests: Add nested pre-fault test for
 arm64
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, kvmarm@lists.linux.dev, "Oliver Upton" <oupton@kernel.org>, linux-s390@vger.kernel.org
In-Reply-To: <20260923-kvm-arm-prefault-v4-14-d4b0b4dfa8c3@kernel.org>
References: <20260923-kvm-arm-prefault-v4-0-d4b0b4dfa8c3@kernel.org>
 <20260923-kvm-arm-prefault-v4-14-d4b0b4dfa8c3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 15:29:38 +0000
Message-Id: <20260923152939.49DB41F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add an arm64 nested-virtualisation selftest for KVM_PRE_FAULT_MEMORY.
>=20
> The guest enters vEL2, sets up its EL2 translation configuration into the
> real EL1 registers then ERETs to vEL1 and exits to userspace so its vCPU
> last-run context is nested backed by a shadow stage 2 MMU.
>=20
> The test then asserts that pre-faulting ignores that and instead targets
> the canonical stage 2 page tables only.
>=20
> Userspace cannot observe a mistargeted pre-fault, so simply assert that t=
he
> pre-faulting works correctly when the last-run context was nested.
>=20
> Based on a patch by Jack Thomson with gratitude. The test here is
> simplified and focused on what can be asserted.
>=20
> Link: https://lore.kernel.org/kvmarm/20260612162354.73378-6-jackabt.amazo=
n@gmail.com/
> Reviewed-by: Oliver Upton <oupton@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-kvm-arm-pr=
efault-v4-0-d4b0b4dfa8c3@kernel.org?part=3D14

