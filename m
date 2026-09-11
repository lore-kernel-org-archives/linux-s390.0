Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CA93CBE6E
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 19:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789156260; cv=none; b=NEyd9kIcep10PxAyuVwByibhhpHPDN+IMHo+ZngdBP8EaGsMwVdkv8DQWGEk1uAxTEZCZpCwHusmj5G+YHbBhBpzERdrJ47y8ZvgFBKB0HR8vwzJRY4H5cQAtqOdNUWd3Mg1xMsdj3x3azvBAPGdy+wIOwL0bCz6OHTne4Fxpio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789156260; c=relaxed/simple;
	bh=PVwLwogdaUnsvqXyRP8LadhWCD3jo0mmmK4qF5DkNNs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aPKdrk/+O/5jYfRt73X9E+38a86tH7ZLO7b65H9ninHmEyOo93ql3k6PEA4+lWdnn5AdaaYwEZgZNhQngCXgljS9p7RuvNWVZoqYm+S54BHvYKBXogyyYAZcWC+o6tn8q4UpiBO//X+zt8b3T+Rltp3lzMcTptPRCceBc4bGDyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5nYlHqJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5nYlHqJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A901F0089B;
	Fri, 11 Sep 2026 19:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789156246;
	bh=PVwLwogdaUnsvqXyRP8LadhWCD3jo0mmmK4qF5DkNNs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f5nYlHqJpV6jV+9Q6KotdL3aE6xgPGGzficVKhXVQWWx4wmdCgGshRcZ7NyU1aSPk
	 EZCWzNZypHBe/VpxrdcTMq/VOvE/Hdi1RWctyC/QM2Z+t+HmcRQhAYHui/SpRxSUCR
	 vpD0uOEJd7eS9Bh9t44hzw5+dupLahIGT8U4oXaTqyuTilnugJxVRIqF1JXj4dOPMG
	 8qsyd2HJrTpYSrqlnOQbmkUwTHEWJ03YXkSUblbj6gB3wzxoXMhRd2CqX9AZn0GtwT
	 AFvW+rYnlrCYj46h++rxYt6eEQAieKv1KCl17GkDq3F9KeCinWtrH2VYNgeq0iWdIW
	 m9ffzSKbfLPrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for
 m68k-coldfire
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260911-rcu-pagetable-freeing-v3-7-7b8c86103821@kernel.org>
References: <20260911-rcu-pagetable-freeing-v3-0-7b8c86103821@kernel.org>
 <20260911-rcu-pagetable-freeing-v3-7-7b8c86103821@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 19:50:45 +0000
Message-Id: <20260911195045.C4A901F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Similar to sun3, the coldfire variant of m68k uses 2-level page tables.
>=20
> Update its __pte_free_tlb() function to use tlb_remove_ptdesc() in order
> that, with CONFIG_MMU_GATHER_RCU_TABLE_FREE, page tables are freed under
> RCU.
>=20
> The page tables occupy a page each and have no odd semantics, so this
> change suffices to allow enabling of CONFIG_MMU_GATHER_RCU_TABLE_FREE for
> m68k-coldfire, so do so.
>=20
> This forms part of an overall effort to switch every architecture to this
> mode.
>=20
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-rcu-pageta=
ble-freeing-v3-0-7b8c86103821@kernel.org?part=3D7

