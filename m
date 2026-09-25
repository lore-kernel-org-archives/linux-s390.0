Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ED3414A0A
	for <linux-s390@vger.kernel.org>; Fri, 25 Sep 2026 20:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790367763; cv=none; b=X7psTLQS8pQXIhFN3ecvAO0uPRIyAxJjhzebvc7Kx98rN9Bt/zzJIoP9Tmm8e2TPN0Wtb6RP/u70hhAQG4LEO8jyY8CSRIW5IB0Wd5D40gIvSruf1lTLpQvf6Z0SghUlXAATTTzQ4qbk+EHrVdGGUzYiebNKTMrdVpEuobuaAPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790367763; c=relaxed/simple;
	bh=5YaHpOFzWMjiCYca9HBIxRiXhchI4YdW0CuY7VOYceM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kd/JNKmbe2SwvX/PitCvx2F2fQ+igE3APfLbJWWnt3bVtncxIUkIfveXEAU+4YDVFyAjTFgrEQdKuLAFUOkh2bCzZ2/sRQPrbCEy/NU8OUtpCx6bC/YklSvLBbwsYBuNdVyr05DxXTqXQWs2l7mgUGe7OLwYfXXGiezKgEor3Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8EDgw1/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8EDgw1/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565C61F000FF;
	Fri, 25 Sep 2026 20:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790367761;
	bh=5YaHpOFzWMjiCYca9HBIxRiXhchI4YdW0CuY7VOYceM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n8EDgw1/3n/81CboKzVVynsof+ODmU8gf2lelKIUHxfa1D9oRF2rd79qfRGIia0Pv
	 8Vo+iH+p2XZiMD3vCAG5773A7GnjRjwNqbyBC74lzjsl0FAt6ZZrr55qpLImWQgtlX
	 4rskpHXwPeekG2WF5GwGz147ejVmJttAYNkCNV4dJ/h4mf6o8dNDr0me5Ze/uQ3mNq
	 t3/VbtZJ0yq2cQqjFELMiRnbVeKLjtmfmDRGJllHtozScxNA1VC3jonRbGmZFpTYX8
	 8U8uagy1hlVmfO11EtMdSzWHoq6OVhoicnlkheWdpIskhWYzV8WrAL2xPzGc3G8rh5
	 kHEP3vNffxUSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for
 sparc64
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260925-rcu-pagetable-freeing-v5-6-31e91065fea4@kernel.org>
References: <20260925-rcu-pagetable-freeing-v5-0-31e91065fea4@kernel.org>
 <20260925-rcu-pagetable-freeing-v5-6-31e91065fea4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 20:22:40 +0000
Message-Id: <20260925202241.565C61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Commit 4a0100f7546f ("sparc64: use RCU page table freeing") enabled
> CONFIG_MMU_GATHER_RCU_TABLE_FREE for SMP sparc64 architectures, expressly
> for GUP-fast page table walkers.
>=20
> Naturally, UP systems do not have to worry about concurrent GUP fast
> operations.
>=20
> However, CONFIG_PREEMPT_RCU is also available even on a UP system, so a
> future pure-RCU page table walker requires MMU_GATHER_RCU_TABLE_FREE to be
> enabled on UP, even if concurrent GUP fast is not possible there.
>=20
> To enable future pure-RCU page table walkers, enable
> MMU_GATHER_RCU_TABLE_FREE unconditionally.
>=20
> With this change, it is no longer necessary to have !CONFIG_SMP
> pgtable_free_tlb(), so also remove this now dead code.
>=20
> This forms part of an overall effort to switch every architecture to this
> mode.
>=20
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Tested-by: Lance Yang <lance.yang@linux.dev>
> Acked-by: Lance Yang <lance.yang@linux.dev>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-rcu-pageta=
ble-freeing-v5-0-31e91065fea4@kernel.org?part=3D6

