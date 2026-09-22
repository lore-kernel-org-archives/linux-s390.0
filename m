Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680EC2D12F3
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092140; cv=none; b=o+U+33cc+ljt8l2JD0XsiOell5BOtBNTs87OF/wWLLGZrzHpNSgqpo4jrg1IlT5ZLY472gFJJxZo7CoGLSN6ts4EHoSYuhr96m7UsrDBd+jL/uKhHrsI9J4df8ZrIGchgjwvJPxCfzFgIArUNY6eBtp/bsdD2iZlwwFmgMxFmzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092140; c=relaxed/simple;
	bh=NaUf1tPyhA/Wpk8/V81WaJ7dE6MOUi1FXMZTgJPZo4M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ExFApcwcjt0wLZf+YG+1/fzLiKeiQhszM0u+0oDoMiS7RdK/GmddgokMH0uVenxomXLe5h/KDw6kvNZXF1ILVI9Y4a0XIjLxzxEYrygBg7EITwbWtAy92aX/7pkeVlNraFl1zxmko3S0ih8nvQ3PpDUs/ePwfIDjm0FgbM3cF/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6J0Rxwp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6J0Rxwp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DF41F000FF;
	Tue, 22 Sep 2026 15:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790092139;
	bh=NaUf1tPyhA/Wpk8/V81WaJ7dE6MOUi1FXMZTgJPZo4M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V6J0Rxwp+cLhMNv9Csa5RNE3anEG3iOlE2AwXVFsCDVf0pE0Np3Dh2uY3wDiM4omi
	 8n3NOn1AKJIChRviV/MIDtVuv/fdyv+2I215nFzh6B4V+l4T2KFca9jkoXOz5qDOOR
	 xGXG/QFmyGMcv1MUs79p9qwNY2z0UnaBcF6N7a6FW5OEx19AJZN+kEuz8ONsZvUYMq
	 MK2CuX+/S6vRvo/IeXtBN3aGJpQrXZWcCwMpa6mmOw30xILWLk+quSKNfzKzsiUJU8
	 6hs86AX38MMGDsnFOZYuxbUuExvu+O2+LcGf20sUDNdOZ9ZaqbcY8dvlM2jTesmJn7
	 DQtVK/xI/JeJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for arc,
 microblaze, xtensa
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-5-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-0-fe1ad1f1e303@kernel.org>
 <20260922-rcu-pagetable-freeing-v4-5-fe1ad1f1e303@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 15:48:58 +0000
Message-Id: <20260922154858.B2DF41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Each of these architectures directly free page tables without routing the=
se
> changes through tlb_remove_ptdesc().
>=20
> The use of tlb_remove_ptdesc() is required for
> CONFIG_MMU_GATHER_RCU_TABLE_FREE to correctly free page tables under RCU,
> so simply update these architectures to use these functions.
>=20
> Since none of the architectures share page tables or do anything unusual,
> nothing complicated is required here.
>=20
> Therefore this is simply a mechanical change - convert __pud_free_tlb(),
> __pmd_free_tlb() and __pte_free_tlb() to use tlb_remove_ptdesc() as
> required.
>=20
> At the point this is in place, all mmu_gather page table freeing is
> performed under RCU, and thus MMU_GATHER_RCU_TABLE_FREE is selected for
> each architecture.
>=20
> Note that CONFIG_MMU_GATHER_RCU_TABLE_FREE is dependent on CONFIG_MMU for
> xtensa to reflect the fact that nommu does not implement page table
> gathering.
>=20
> This forms part of an overall effort to switch every architecture to this
> mode.
>=20
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-rcu-pageta=
ble-freeing-v4-0-fe1ad1f1e303@kernel.org?part=3D5

