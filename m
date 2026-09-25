Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A23D40BCB8
	for <linux-s390@vger.kernel.org>; Fri, 25 Sep 2026 20:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790367912; cv=none; b=YRVnEUCmH3Pe6kCp+2xMd5T8rjSteK2AjD0OCYwl0RqxA5ivndhNwXtook63nKv3KkOvc0pzHzc8jImJNqYk9pXmVPTMhxhLudsxVK+POawAYTvyTxZB7ytSlFcrquGYt6CEtDiJoI9Vm2TkuXiwnSFX7rvlU2rg9HWSZXDH/48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790367912; c=relaxed/simple;
	bh=/6GGi0e5G0uyjFchKV2wxI7K0OSjtnHzGB8ri0BhdSY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YIkI5dQ/edGbdqvFcMSodK1B0eKoVBoslYuUivesc9MIAUSea71RNKsetn3+rMCpVtUms64cFR6eMVc9YZl+sJ05MTWzI+XI0JjFNc+ROFutWCiHcPKUE97mU5ssRiZoXC5BCJThoqteKZCdYGrchZJ1c225lXB/CNIta5rMvts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eD3ywe1V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eD3ywe1V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90D01F00898;
	Fri, 25 Sep 2026 20:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790367911;
	bh=/6GGi0e5G0uyjFchKV2wxI7K0OSjtnHzGB8ri0BhdSY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eD3ywe1VzyqjS2qsJxQdVyXn/lgMAPabyxrsQDZcamRMzLniRnE5d5I0xxk+yMTbP
	 psQKUN4MFAWYSf+nP+u79EOICfIz9KL2Ihrc+txl6RsCuDMrDlKdhC/WKz6jLhPiMi
	 pqN1wtdN0LfO4h0TD9QdQXHca0Q9CtZb0yeY6kc8OBY/ewaIbwv4ZYC/pKAih5Th2d
	 Qca1FgRw49bzJd+5cn6n4gNMx0xofGN/EYaf+7xow0hsU5xP0CTgcqQs6FLnmh5iYk
	 2tdKZIjaaAoo/S/7qizRwcE1xcJi6Uf1glB8pIqUdeZXirvk6Z4B+0zpVc7Is5cYQ/
	 E0Jmp6adAS+Jw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for sh-X2
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260925-rcu-pagetable-freeing-v5-8-31e91065fea4@kernel.org>
References: <20260925-rcu-pagetable-freeing-v5-0-31e91065fea4@kernel.org>
 <20260925-rcu-pagetable-freeing-v5-8-31e91065fea4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 20:25:10 +0000
Message-Id: <20260925202510.D90D01F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Currently, non-x2 sh specifies CONFIG_MMU_GATHER_RCU_TABLE_FREE allowing
> RCU page table freeing.
>=20
> sh-X2 is problematic because it utilises slab-allocated PMD page tables,
> and thus tlb_remove_ptdesc() cannot be used in these cases.
>=20
> All other sh variants are fine as commit e3ecf7c7d082 ("mm: pgtable:
> convert some architectures to use tlb_remove_ptdesc()") already converted
> page table freeing to use tlb_remove_ptdesc(), which does so after an RCU
> grace period when CONFIG_MMU_GATHER_RCU_TABLE_FREE is specified.
>=20
> Resolve this issue by firstly specifying CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE
> for sh-X2, so the arch can provide its own __tlb_remove_table()
> implementation (called after the RCU grace period).
>=20
> [ ... ]
> mode.
>=20
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Acked-by: Lance Yang <lance.yang@linux.dev>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-rcu-pageta=
ble-freeing-v5-0-31e91065fea4@kernel.org?part=3D8

