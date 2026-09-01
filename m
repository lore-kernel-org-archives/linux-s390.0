Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4822931CD
	for <linux-s390@vger.kernel.org>; Tue,  1 Sep 2026 11:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788261281; cv=none; b=ckp9pC5QClbdGqxUNvUO4fQibpzJB0CQntRMMnlpENddRMm1Go+LXX9MSIKUoDm5dNpMBalUp8LlsJqP2H9NOROVrOweeW7zh0JBPvsfKAsdjHUvPRl/755xhSn1gFLSqW3o9YRTYJNqOftRpXzL0gzZHQt+uRpigY5rlk2Pld0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788261281; c=relaxed/simple;
	bh=DFhdRtlpNvH0Vp/3IZNUnu/1thAgh0mVLj5efxG+LCo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TF7f6Aobg1yq9KtP9No5yKDqqfC+g1OGFQTG9nYBzDvtVGLVCzHCx5VQuislV8p7EmZfiU7h1NgXwBOHVUD1wtYcZQ2P4nviq9jto80xQvQV7oZN0r5v5vOYE2PTApkRZpBaD5QPgk2QU5rn4G7Ei3Jz3Avk3K6ypybZR7Pgc4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJ1cx9OI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJ1cx9OI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B9C1F000E9;
	Tue,  1 Sep 2026 11:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788261280;
	bh=DFhdRtlpNvH0Vp/3IZNUnu/1thAgh0mVLj5efxG+LCo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GJ1cx9OIc7wB8CR7kJv5coNUG7MyZZKmZMM7F7SxOLpLZ0h7YIMnc2mhhdBF2HwUO
	 GRf3zHvvX/JUkCPwWjJA8GQ3KbOR+5FZHTP9MdhAZHaUqLAyz885MkvkXyN6CH1NS2
	 MN8PphegXntdbF4YPA5PqWg4vR0YKPUd37BbFHCIcdzD25TAdAXsbvMqIriw2KRp4y
	 A82Of6ObCISgbmZlWVCGHq8xs0QCNSXLs5gaXy7ClIJVpUBU1dz0hVBoOw/C77JlNw
	 by5PYqhg6bQH8mL5aLwkg/SWCIGMDRkNMsLDJ3F+g04F1qsuUQzbc/QwwZxUhmgyA2
	 k+UQaPNtHZoIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for MMU
 riscv
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260901-rcu-pagetable-freeing-v1-3-5456a81c8212@kernel.org>
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
 <20260901-rcu-pagetable-freeing-v1-3-5456a81c8212@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 11:14:39 +0000
Message-Id: <20260901111439.D6B9C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Currently riscv gates MMU_GATHER_RCU_TABLE_FREE on CONFIG_SMP and
> CONFIG_MMU.
>=20
> Commit 69be3fb111e7 ("riscv: enable MMU_GATHER_RCU_TABLE_FREE for SMP &&
> MMU") enabled CONFIG_MMU_GATHER_RCU_TABLE_FREE for CONFIG_SMP, CONFIG_MMU
> riscv builds.
>=20
> This is expressly for the safety of GUP-fast walkers (CONFIG_HAVE_GUP_FAST
> is enabled if CONFIG_MMU is enabled).
>=20
> Naturally a single core system does not encounter issues with software pa=
ge
> table walkers being correctly synchronised across cores, as there is only=
 a
> single core.
>=20
> However, CONFIG_PREEMPT_RCU is still available on a riscv UP system, so f=
or
> a future RCU-only page table walker, this guarantee is required to prevent
> concurrent page table teardown.
>=20
> All page table freeing is already done via tlb_remove_ptdesc() so the
> conditions of CONFIG_MMU_GATHER_RCU_TABLE_FREE are already met.
>=20
> This forms part of an overall effort to switch every architecture to this
> mode.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-rcu-pageta=
ble-freeing-v1-0-5456a81c8212@kernel.org?part=3D3

