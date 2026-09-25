Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5F943F8C9
	for <linux-s390@vger.kernel.org>; Fri, 25 Sep 2026 20:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790367911; cv=none; b=T0a7RaVttRXazzLmXXkAeD1WZpsWdWY+PMiFoyF1HzRGHoLwFNJIxbrgp/cJVCxuAduMYXdvi8eE8eI34kGRPiKgXkyhEC4zWdsJlI+kA/56fuo/3eTYN8GvEHkwVwzAWM00xB+WezEFVtnIIPx+3daEo44JrDB/CZUm9N8QZFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790367911; c=relaxed/simple;
	bh=Di/hi7fyav3o8a3IPuTsK8viRJi57ENgId4hdrO+gtY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AWXihLMzQOHyyNbowJbwxpTMsprk4lvV1vNyTsZRh5x5THnSRww/K97qob43LJUOfKLPvhSJQcSbhFsg9lJPJiiqmGLOsOiEuKok4ex5BUNwLb08QCEqCYolFn90u6BifpgUwPowo8hEtF+M9UxPBP7sg5YunA0ODhS5nZujk64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvBpCNIl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvBpCNIl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3901F000FF;
	Fri, 25 Sep 2026 20:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790367910;
	bh=Di/hi7fyav3o8a3IPuTsK8viRJi57ENgId4hdrO+gtY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BvBpCNIlu6LwsrL7ze8TbPQifH+5zpdzrhs74yPAF02UCIsb3Jo0UAbmmRohBbXgJ
	 f12vQfb7V2S54Eh4xd/j0MHuK85BtJyVzfxY/fHtGT4kJcyKpj0Pl7sR5FHaQQ2J7t
	 wIIwVL9WMGvzSkLjv1fVORfV/WRbEOFbqG9qmGVwP6Aqmal0F3Ht3WbwKqfzrSehEx
	 3fn3IwUhF8cKV158d0Vi0Fbebtb66GKgJAKmTwCDALXCwS2Gi9TITHtAV2MGnjLu6d
	 OxBjN4gdTOq0NvyGgn+GOJu8EnPHb422RzSB1GZTeNLrn9z2IFBXFTcmXY+MmzV2kE
	 y5QB3T01WjeQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/12] mm/khugepaged: deposit a newly allocated page
 table on collapse
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260925-rcu-pagetable-freeing-v5-1-31e91065fea4@kernel.org>
References: <20260925-rcu-pagetable-freeing-v5-0-31e91065fea4@kernel.org>
 <20260925-rcu-pagetable-freeing-v5-1-31e91065fea4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 20:25:09 +0000
Message-Id: <20260925202510.1E3901F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> collapse_huge_page() deposits a PTE page table on PMD collapse in order
> that it can be utilised for subsequent split operations, meaning that tho=
se
> operations do not need to perform an allocation (as they are in a context
> where it might be unwise).
>=20
> However the PTE page table which is deposited is the one which is current=
ly
> mapped by the PMD entry that is in the process of being collapsed.
>=20
> Once deposited, the PTE page table may be used in a split of any other
> unrelated PMD entry.
>=20
> This is currently not an issue as this operation is performed with VMA/mm=
ap
> write lock + anon rmap locks held, so ordinary page table walkers will
> never accidentally end up walking the wrong thing, and GUP-fast is
> protected by an IPI via tlb_remove_table_sync_one().
> [ ... ]
>=20
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-rcu-pageta=
ble-freeing-v5-0-31e91065fea4@kernel.org?part=3D1

