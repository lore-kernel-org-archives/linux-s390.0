Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E523F4483AC
	for <linux-s390@vger.kernel.org>; Fri, 25 Sep 2026 20:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790367592; cv=none; b=O1LcC6SDanGj3U60yQAastg1muHywd2AC4TEuTgnhyyZBNKX92bIlEw9p7J8kaFPRgM42W+B7IVky+Bk4qhn0GGPG8/pVZ4MICsALKPrQUJgJ1hh1kqfPEW1oC9jJTJPe16cBwn6jhj3nYKBRn003HeT97OKTQluEWXQCUPssoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790367592; c=relaxed/simple;
	bh=DB7l3UbPGe2ta64+GYQBTKDNGJNIRwr3QlZS5qwlLaE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ut6sTGGPj/iVpjAK65rMrNYeC2RxIDSyVLKkSQ7xP5BdEJrc1TTkUyIQbWH1a10qZ8Gd+K49HY8I00xncXSf2SFXTeE5nsQcQuz0W3minHyFSypm6kqhPTqwUkB86zUJ/2I1JsugsiXqTY6BBgOt15tltGym/jL0t8HRO9DQxVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EE4MREHN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EE4MREHN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E921F000FF;
	Fri, 25 Sep 2026 20:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790367587;
	bh=DB7l3UbPGe2ta64+GYQBTKDNGJNIRwr3QlZS5qwlLaE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EE4MREHNbGWC4eFHpFUPV+sVlj9a7uCdjbjfRcLeoQa6z5NLGZDkGL0F0a/5ME8jA
	 jrExlQ9CWbBdVMRiq5o8zzQN48Q4/i1sBhigmWYPBrJX6UGPBifWz8jjkqbb6W4c57
	 umITQ0okZmxVfkuRxk/cX0+rvUjEM1+VMUR6RedFmEu/kqp2LiI2oCi1P+cvbMbu26
	 dqY+tbSetXNsBHeKo+t0bM+grCD/tXbx2HB05ePrbJWv6cJJgktzcQZr4uoR6xj4bN
	 tvpDlw4LvtxJVJ02OgP0zL08RHsX80Vp5RnL4Kq3wBiRmNA7Z80glBKTelAnh29gs4
	 xhRtf/n6ZEDEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for MMU
 riscv
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260925-rcu-pagetable-freeing-v5-3-31e91065fea4@kernel.org>
References: <20260925-rcu-pagetable-freeing-v5-0-31e91065fea4@kernel.org>
 <20260925-rcu-pagetable-freeing-v5-3-31e91065fea4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 20:19:46 +0000
Message-Id: <20260925201947.46E921F000FF@smtp.kernel.org>
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
> Acked-by: Lance Yang <lance.yang@linux.dev>
> Tested-by: Lance Yang <lance.yang@linux.dev>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-rcu-pageta=
ble-freeing-v5-0-31e91065fea4@kernel.org?part=3D3

