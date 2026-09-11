Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C43C57C704
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789156238; cv=none; b=DI7BeBS3CGidXTyRCzQLtEDJ0HusI9GHopc3keIc3B9N8mkO2HJR0jAvNUf7A4znL1y440ynKLbNxoOCdlQIMO0qrl62i0r9foTYedcSx6q73YfQG7PIL9xxhkhur4gG9Jm5NCtQ1v5SdF5kT5rgW6veytqwDcQLSqLDIike7Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789156238; c=relaxed/simple;
	bh=NexxmedxvVMOQvDi76K5hWtWl1Ln/KWBkUU5m+FbZTU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s/ZKH1H3I7C4zjTOcaARWnfFKvlrjC8QtQDxLSAhtggwaQLfZCQHDJzzuyVRdhW07SAUs51J/+KtwEB4Qisq35noCOTvOTePMtQpYLV3mq5sq5xFp4yJ+gqTwcZbdLurOyS9UA/J8OjWdEpS0NTWN+nwr6d1YPv8nWPyOIdYTes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yj3U2glP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yj3U2glP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1E11F0089B;
	Fri, 11 Sep 2026 19:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789156225;
	bh=NexxmedxvVMOQvDi76K5hWtWl1Ln/KWBkUU5m+FbZTU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yj3U2glPkP3XVRrrKWaVElpHgJHjJTJCHyrq2zan56UvSngxvV1G0ecfHv72h1Ciw
	 3L2WVyeVgwXe3BIulI2/Zp+fsOdKPVKRMboScrvfsM4d+QseqsnizO2hjH+mF+trvV
	 29hpq8OWTXiYxRgVPDxXVpvru9IVv9VolwKh9OzKn/o7p7OiAPRHgD43ml7BRfA+xh
	 g0tr9EoSMeMMQYWbJHkZuUXBivluLURXwiyuhTGb6rUFaHfDn/EkF35tO84I7TGr3O
	 aFOa79AzSMmYgE8DObbVA0xLpGbwlywKZS1P3R6kQwk4jh5InJdcPA0qFJvChEbtdf
	 EMV2qC1dYa0Jg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/12] mm/huge_memory: zap deposited page tables
 after an RCU grace period
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260911-rcu-pagetable-freeing-v3-1-7b8c86103821@kernel.org>
References: <20260911-rcu-pagetable-freeing-v3-0-7b8c86103821@kernel.org>
 <20260911-rcu-pagetable-freeing-v3-1-7b8c86103821@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 19:50:24 +0000
Message-Id: <20260911195024.EB1E11F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When an anonymous mapping is collapsed for THP, a PTE page table is
> 'deposited' with the installed PMD entry.
>=20
> This is done in order that a split can be performed without needing to
> allocate additional memory.
>=20
> The freeing occurs in zap_deposited_table() and is done directly without
> any delay via pte_free().
>=20
> This is currently not a problem as existing page table walks are protected
> by the mmap or anon rmap lock.
>=20
> However this becomes problematic in a future where RCU-only page table
> walkers exist, as there is nothing to prevent a page table walker that
> started the walk prior to collapse having its PTE table freed underneath
> [ ... ]
> checking folio_ref_count() against folio_expected_ref_count(), so the two
> must be mutually excluded.
>=20
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-rcu-pageta=
ble-freeing-v3-0-7b8c86103821@kernel.org?part=3D1

