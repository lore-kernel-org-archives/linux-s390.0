Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EC6572696
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 19:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789156446; cv=none; b=oJ31VT5Vr1as6AOnid4jZstxc88YyVleU1sO9qDxwWni19VuseoDlJanHYMb/XgNR6fF1E/BEMcEMBNXhlO2kyS5lZpDJUsu/Fb8lBiPoor3AvRXdKufbkcoeaEXL8wsX8c4Y4aH3dibsO8NU2Qvhewd1xQLqPhB8myk5a3f0jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789156446; c=relaxed/simple;
	bh=byVQgBuZrgsj5sW/JQOCjdpGezzhnMvdwtfSlRNnjd0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kosoyRtFXWv+EMGCBYGZn+hARAA9Vsh46JutCgEbVSjjmF47n67er9M5gUrRl8NUA0helqLm7CA1PVKSHhOJI62izzU8SY/SRI+7/fMT0eKCCk2rYVhx+iyjbZD82hOfp0evWXWQ3YuDYAAbDNnDuBZMyRAWbCuTvObABFk0b8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISZGmgKg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISZGmgKg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736701F00898;
	Fri, 11 Sep 2026 19:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789156435;
	bh=byVQgBuZrgsj5sW/JQOCjdpGezzhnMvdwtfSlRNnjd0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ISZGmgKgpNUc2oybxTQF2VsTWtlb8TBhaQIZZtkfGbmq+OAowz+hJopscfI2ScWwY
	 uINgIW2PYSFxwLxGyxt+629TM/nSGYDG7jRllI5dMrc9aiDCoA1rjwzj1wAZZyKeL3
	 7bh+c6I46kpbpvwpxLlzkJoK4leljTLCfsfSp7cwf3JZMqpjtaiGjAi84+/kEXfdoi
	 f+0zJRyuJ/X+AO48KqX7YpYOhAbPpx3DpbCJGQ0OJy09pinJKVwsJRjM31Bxlq/tLm
	 XuynByNrs4LAEvGEsnPo26a4YP5GRMiXJy62lKHFhAqTQehZJj8iobhbimxzl/s1gK
	 VR4kvbiU8ej1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for most
 2-level architectures
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260911-rcu-pagetable-freeing-v3-2-7b8c86103821@kernel.org>
References: <20260911-rcu-pagetable-freeing-v3-0-7b8c86103821@kernel.org>
 <20260911-rcu-pagetable-freeing-v3-2-7b8c86103821@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 19:53:54 +0000
Message-Id: <20260911195355.736701F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Commit e3ecf7c7d082 ("mm: pgtable: convert some architectures to use
> tlb_remove_ptdesc()") updated a number of architectures from using
> pagetable_dtor() + tlb_remove_page_ptdesc() to using tlb_remove_ptdesc() =
in
> __pte_free_tlb().
>=20
> This is meaningful as tlb_remove_ptdesc() allows for RCU page table
> freeing if CONFIG_MMU_GATHER_RCU_TABLE_FREE is specified.
>=20
> The csky, hexagon, nios2, openrisc, sh (except X2) and m68k-sun3
> architectures all have 2 levels of page tables, so the only page tables
> ever freed by mmu_gather are PTEs, so this update suffices to ensure that
> every page table freed by the mmu_gather mechanism is freed under RCU.
>=20
> Therefore, update all of these architectures to select
> CONFIG_MMU_GATHER_RCU_TABLE_FREE.
>=20
> This forms part of an overall effort to switch every architecture to this
> mode.
>=20
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-rcu-pageta=
ble-freeing-v3-0-7b8c86103821@kernel.org?part=3D2

