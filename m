Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC5D36B93F
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092603; cv=none; b=PAkYietfCsDIieLnuXTgamviZPFUc5cilSicQ+jDPope8T02K60EVBqe+hoaOWKVoinmhXIRurkGmdqtFi2WGJOM1TZ2Elro9vfirSPN8go1WuPMRR6Pjy1j7m47Im3NJf5O/Vj+i4hUy65sx9+st7yd3D0UH4ROyKRtwZpooQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092603; c=relaxed/simple;
	bh=ZXO5WASN2f0bLor3tgE2Xck+c/9/QReFko14Qf6s3ro=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nwYvQitD1XLagVtLaD7Qf7w8og2tvpmoDaJApkHHRcf5ZL78Eqnr3UVPrOvf5BtNqu2uwW+waNpKFSsu9g14TFxQlAoU+2LCe/TUij//3OSC80H/JHPzqhu3MMWgZxYWX+pHGrsmih3XRy8FG8QprxVV4DiCG73N6Ewzinu98+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZR3b5g6r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZR3b5g6r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD841F000FF;
	Tue, 22 Sep 2026 15:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790092601;
	bh=ZXO5WASN2f0bLor3tgE2Xck+c/9/QReFko14Qf6s3ro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZR3b5g6r2q3L2U5JhBiiX+BwtfjHLVYq1DHvrE1aIVsMHNaQ0pPXmj9eQ+5QgZmaQ
	 osO10cyx1ZqfnN3dtADALEYmsWSe5Vrnyiku9Fd0ycZ92FKOjNnUxO9YKsP+7ekzY4
	 BstflJJDT8+mQehnN/h9u0rMDGgvoopT1M+6kdrLqs+pw/AUyKeNWMoYxevuEKf2VZ
	 G2475RfBgqdUk7HP2aP4JPxghVA8UXkTKZKScxOhNeu04DqGCHMlhJpCuYx7zYicGg
	 PUoIPPMwTM43EyAC53uqDDn1kv2LiciOFBO2atHXO0sGSzVwvZBcmjPSPr+4igX7kf
	 /g/EnHy/aawug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for most
 2-level architectures
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-2-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-0-fe1ad1f1e303@kernel.org>
 <20260922-rcu-pagetable-freeing-v4-2-fe1ad1f1e303@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 15:56:40 +0000
Message-Id: <20260922155641.3CD841F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-rcu-pageta=
ble-freeing-v4-0-fe1ad1f1e303@kernel.org?part=3D2

