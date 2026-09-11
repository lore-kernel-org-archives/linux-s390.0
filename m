Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01794519BE
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 19:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789156186; cv=none; b=KMK4SYG87kPEwLCr7DFRpxo1F70AiMbK9YriKGJIOIyKozDE54ZejSz9fLNxY0YBC/YpvX/IOzlxIA4YP77c8gklBFLWZ6huh42nGiQxtqoi480B5jD9u8sXAm7sG3AP7TCbz32xI0nbmO6or9Tj4rjfF8dWx//9xP1WHyvSGYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789156186; c=relaxed/simple;
	bh=RKeFB0A+kImQ7nOuZ968V5ZQk/GSvwUrWVw9u3OlwiM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q5/uJscMcwRlMDvu/G8BRLwd2y28TipfomRUnzzCF/+WlhSMQhp/FOhXFKE/if5wTEUsLZxw7en1aXnsqJ4sZJf9+d1p0OesWYXmtSpVy1sCBQON/kJVTZSBSs6zuW3eOu8Ld91gnYNTKFUcFN8f77i1GDLiBFIqYKPe2otcVJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/yBMkLb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/yBMkLb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145071F0089B;
	Fri, 11 Sep 2026 19:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789156169;
	bh=RKeFB0A+kImQ7nOuZ968V5ZQk/GSvwUrWVw9u3OlwiM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z/yBMkLbOtC3vvAdXk2BBNpIsvh5KlgqWXFJfh6s+TVHXo0igOs+kZPeKGeA8cQ75
	 KT0bMgycf69x8kmg1oAJZl+UTDOUd7KJqQsMq1oNux0uGzQKddaLuo40ePOy5fjJWP
	 +fmXrETqnX/GkhfbQyd8TsNzavkkmjssSlQ1z1Tn9lPbyevvxF30gaoerssDTQI7ra
	 oFl3+dC+oFc84GsBecWhiqUglRZWmmIpVFAyS8bwE5NHrIMVe5PHK7JBH7hSqwwQ1V
	 IrTMRpvOy6y3UcCLfa9Jo793X1/tSvoNnJs+a2Pqsuz0uMpVfPRLp3IgG526OmZhxH
	 tyzvzdsD8fioA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for MMU
 riscv
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260911-rcu-pagetable-freeing-v3-3-7b8c86103821@kernel.org>
References: <20260911-rcu-pagetable-freeing-v3-0-7b8c86103821@kernel.org>
 <20260911-rcu-pagetable-freeing-v3-3-7b8c86103821@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 19:49:28 +0000
Message-Id: <20260911194929.145071F0089B@smtp.kernel.org>
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
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-rcu-pageta=
ble-freeing-v3-0-7b8c86103821@kernel.org?part=3D3

