Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C0B582B9D
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 19:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789156361; cv=none; b=nWCJN2ZhMQX8d82tRUCI6sa7juKuIlKwWTUaGbqPe6rJ6dp+4V+XzlHndLKPBATX2BxctHiWN2J3DXE2OFuUAvAO9t1Q7bxqEFkjyd9Sfg+LXsQhgMrcvCJQbzPW5K8H4Bh5stDFC2OCu5a1hNnxk6iAzMdZ9Y9wH/jMXJo40Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789156361; c=relaxed/simple;
	bh=xgMBlPykM1hQCIhYJbpIHWnojlKoa75Cumgv00hMUfw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vAZVk/CcnuOqR/dS5qFulo7p2lJIqAXYTAcgHmcpFWnwqH1hL1bpOIeaGFzUhnXhwD+sSTg1E3eGBgB6MdNqamstz35bdjg3iLeTtgDZSFt5VPZA7BvzqB7UAK8kQ2zBT04f+8BmoDkiit33rh+AamJNvSnXkfPFbBN23Vifjww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfVxm3pm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfVxm3pm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B861F0089A;
	Fri, 11 Sep 2026 19:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789156348;
	bh=xgMBlPykM1hQCIhYJbpIHWnojlKoa75Cumgv00hMUfw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gfVxm3pm2blHTzRLZpBkvOHEBSAC4TYHcbXr2HQkWLEmhlDb4gvohWKv0ShqY+/qo
	 2RcbteXu4JCxkZdGApIn5gII0xZFnJIus6a6hHneWhLGLzQ9RhMALhnHK/l6ABrSdx
	 2F3xQEaCPOjzkPwVwvBBOLMa3x8IiwP23GyNchrQYwZzpg2rrBcJFSHaQ+qyK8NWIq
	 dZc5ghB8n43O65le7C5Gpu+OEk7V17tq9YFeNWHlsMMvvjezWlVR9jP+AOXbciXqxY
	 xnAVZ6af24hiMFsWSOQUZ3Cp3RzGE0gXiRLZY7oinnU9Hx1N1YgsE1FnxHWYeFfn+w
	 ieS6OKjK4NW7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for sh-X2
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260911-rcu-pagetable-freeing-v3-8-7b8c86103821@kernel.org>
References: <20260911-rcu-pagetable-freeing-v3-0-7b8c86103821@kernel.org>
 <20260911-rcu-pagetable-freeing-v3-8-7b8c86103821@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 19:52:28 +0000
Message-Id: <20260911195228.90B861F0089A@smtp.kernel.org>
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
> This forms part of an overall effort to switch every architecture to this
> mode.
>=20
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-rcu-pageta=
ble-freeing-v3-0-7b8c86103821@kernel.org?part=3D8

