Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D41353ED1F
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871569; cv=none; b=THzE575l8mQ47Qguj0wGD2Ze80GZsmuN2SEkOyf9aczM4ujUlcWTY45GvXwqLPODbOBC99b05NhUq6P7aYhjFXTNacVpqbUfwN9x6CfDWdxFs1B4Vl9OddR1O4R5z5x22fEwWuneBGsCSrnwrL3CMMUtYoXuTYBHspJkYs59Qc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871569; c=relaxed/simple;
	bh=SleVZQi22n1CNoWK4LeqBO+7JyfzIHrzuPuJ2Yh/Ijs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ubhL+GVjPPvH2Guh5RUtrOUF89LBAo8k7mcgvYm0akiiE5WcTFydusEIf1yDC5Zea3ff3G3AoZpSoYpZbPJH3xjrpWjORO1kqWQvlYZWm91IGHgsyS0MOyN5FGsKIRIHOBuNcn6pFdzNcEX7P42M3ym25KRVmA3NVolsdLm75LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyIN4Drj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyIN4Drj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457821F00A3A;
	Tue,  8 Sep 2026 12:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788871567;
	bh=SleVZQi22n1CNoWK4LeqBO+7JyfzIHrzuPuJ2Yh/Ijs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oyIN4Drju2m+0B8qI6GnnzSEdMEOk1ybPk7i35/gL6LCqoPNqq3vv30V4DqBy/gt2
	 VxY0tO/MpjevyKbjgUx+ECzACqqXcCYvl+TtnQdF3FLhSDV9FLGkBKI0FjufyR2zRL
	 7pviGltT88NEeeHyI31yNFq5FLkylXM3MS7rStvplTKNW62zFFq2OJhq1tIKMYLQZA
	 UrgoRMeKwIuckR74dMXhb5pLcLy7wjTC8HOuNcbZx/k16/9JzJZlW2iVXNIcQXUJBd
	 ktmSufaKrQGHSFEsu10Jrtu83Ps7NcxCN51DF3z8Kw8OPv/W3gmU19UTm3bpytlBYW
	 j1Wjgewzd9iag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for
 m68k-coldfire
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260908-rcu-pagetable-freeing-v2-7-1f60b64e878e@kernel.org>
References: <20260908-rcu-pagetable-freeing-v2-0-1f60b64e878e@kernel.org>
 <20260908-rcu-pagetable-freeing-v2-7-1f60b64e878e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 12:46:03 +0000
Message-Id: <20260908124607.457821F00A3A@smtp.kernel.org>
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
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-rcu-pageta=
ble-freeing-v2-0-1f60b64e878e@kernel.org?part=3D7

