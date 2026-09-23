Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7CA549365;
	Wed, 23 Sep 2026 15:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177076; cv=none; b=AxeY9edOKDi/rwTGojKn8DmKNbil09M8lPDZ7T/tZ4fLtbqEW1E7+S+BuIKys5G6XYP9BB3z5BEvhNUBdWVqbZSaho2rzndrO6a1ecXatNF8zJDKMTWYZ7qOFjv2SmcCFjbHjT10+KDu7g/wGqctTN9GAgCtqps9/51KgJ4B+88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177076; c=relaxed/simple;
	bh=42vuhSvBe5+j0EauPTIpEX+X3pMtcFz/th1Ds2wldRo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RMT5TM3s3Eau9MTMk7kpDhN5QldmlD0ObZ6zbpgthghKieDnkdyeNQaBFhCJ9LWcEYWXzMmKiePtX6/h8wUJ5sBiGKqq8etfR9O8baMJ1Xm9ei8tKnRixwLIl2NgYGjZYH8zfPOoDreGD89KtnuRhZiAGP2cchj6rqL/T716SPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqzAnR8p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqzAnR8p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245CF1F00898;
	Wed, 23 Sep 2026 15:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790177074;
	bh=42vuhSvBe5+j0EauPTIpEX+X3pMtcFz/th1Ds2wldRo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HqzAnR8pJfJv5bnArM8/t5yRof2VhnxPvOTJto7LnQZ3h6C7VlZIfzwM3ACMTxRxA
	 OOuHJe1zsqqIDFNtJzktb+LmspCnFdaIv9c7i41shp1Vfaw9VD5m68Lcj8Wnh0KexS
	 StstuQkUFNvYlhJ1bAZRJTi2dcEJLTetUiP+9gpnTo4nMVLWbtTXCBJ+otZ9yfUaWR
	 WcSMs6vNd83ibOMqENmCQBi7vn2XprOQ/VGVzQewQwNePuHbNZiQhn6mx+HsJX27PL
	 uUER8yk+k6VRmw6UZZ53Eq+UMThTT8AiSObzZPxoZ6QEXe7szSTC0ENLhFM+CzELS9
	 4CvR3H4aTMsEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/14] KVM: Allow architectures to disallow pre-fault
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvmarm@lists.linux.dev, "Marc
 Zyngier" <maz@kernel.org>, linux-s390@vger.kernel.org, "Oliver Upton" <oupton@kernel.org>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260923-kvm-arm-prefault-v4-1-d4b0b4dfa8c3@kernel.org>
References: <20260923-kvm-arm-prefault-v4-0-d4b0b4dfa8c3@kernel.org>
 <20260923-kvm-arm-prefault-v4-1-d4b0b4dfa8c3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 15:24:33 +0000
Message-Id: <20260923152434.245CF1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> All existing architectures which implement KVM pre-fault (x86, s390) have
> mechanisms for disallowing pre-faulting.
>=20
> Currently these are open coded as part of kvm_arch_vcpu_pre_fault_memory(=
).
>=20
> Formalise this by moving them into a new kvm_arch_pre_fault_allowed() hoo=
k,
> which every architecture selecting CONFIG_KVM_GENERIC_PRE_FAULT_MEMORY mu=
st
> implement, returning an error code if the operation is disallowed or 0
> otherwise.
>=20
> The hook is called early in the generic code, allowing architectures to
> disallow the operation prior to vCPU load.
>=20
> This is important, as kvm_vcpu_pre_fault_memory() is the only place where
> generic code can call vcpu_load() on a vCPU that has not yet been
> initialised.
>=20
> This lays the foundation for a future change which implements pre-faulting
> for arm64 which needs to disallow the mechanism for uninitialised vCPUs.
>=20
> Suggested-by: Oliver Upton <oupton@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-kvm-arm-pr=
efault-v4-0-d4b0b4dfa8c3@kernel.org?part=3D1

