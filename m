Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568A2457E49;
	Wed, 23 Sep 2026 15:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177116; cv=none; b=kQJtZ3TiwA/WrikO0itC8M2NX+WP8q7s/Jjc5TYG4QragK5Lc+tScM65m0nrlRnNzc5LcGodF+Dnsz38ZUNWeNXMPzSuwXN78QFeGmFnVpnrT5aCkRrX6vffZ5+xY76v0K1Wl8GKtL0A/2FQqU3iCYh9xDmJI5TMAQ2hNby/Ztg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177116; c=relaxed/simple;
	bh=yto/mu1421rspllSi0Jb6ltlvW6Dw80Zp1j6j3uErfY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aYg7Rmk8+XiyIiMW7WAYElZ3CCBqTzb3lM1ltBtVwbU3mp9+5+Hy4DbFurVDOCsaZwGEYmpCd96AdM0lpYFtZhaCZaJ8kjbhAMBiVItoDIyuU3ncHaZB1aa4SPSUyntPfI+KcQuMkYH3ep+PyDemddM86JVHwqB2DlmdZndKb3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ow2pJsGi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ow2pJsGi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F331F00893;
	Wed, 23 Sep 2026 15:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790177110;
	bh=yto/mu1421rspllSi0Jb6ltlvW6Dw80Zp1j6j3uErfY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ow2pJsGiEbYCW4ukL4uKCbdmFHokTn6QYeYnEuqQUSjnNIbzd0oNCaA1oIKkD6IzS
	 +DbUXnivapvWmnxA2oi8fxLD4m6963Hy5VZggHsXUdc5+xtMWkrU6tpvJc624Jd35o
	 Zty1bvNuN4rh9gPks/e5pyhD1/FhKFt7X7RipDySnCZ4auAhm8MZQsgMonNYx74KfY
	 zWCFkBcSUMprAIOVBxV6OP2dzYnPhrPhCHsHnov+4WxNshx0x5zNuP6VM8xDKqPzqw
	 EAMgij/WIBQ7kLxMhaqtW24+xTs73n7c+S4bMA46iK5AlG5BVNNEssCICLoBk2pczW
	 OCLT/2124o8ig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/14] KVM: arm64: Size the stage-2 memcache from the
 fault MMU
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvmarm@lists.linux.dev, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>
In-Reply-To: <20260923-kvm-arm-prefault-v4-7-d4b0b4dfa8c3@kernel.org>
References: <20260923-kvm-arm-prefault-v4-0-d4b0b4dfa8c3@kernel.org>
 <20260923-kvm-arm-prefault-v4-7-d4b0b4dfa8c3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 15:25:09 +0000
Message-Id: <20260923152510.37F331F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> topup_mmu_memcache() sizes the page-table cache from
> vcpu->arch.hw_mmu, which is the MMU that faulted.
>=20
> Pass the target s2fd->mmu instead, so the mmu used can be controlled by t=
he
> caller.
>=20
> For a guest abort this is vcpu->arch.hw_mmu, so this commit introduces no
> functional change in practice.
>=20
> However, it's necessary for a future change which introduces stage 2
> pre-faulting which must always target the canonical MMU regardless of the
> vCPU's last-run context.
>=20
> No functional change intended.
>=20
> Reviewed-by: Oliver Upton <oupton@kernel.org>
> Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-kvm-arm-pr=
efault-v4-0-d4b0b4dfa8c3@kernel.org?part=3D7

