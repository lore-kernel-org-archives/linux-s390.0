Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D9C52ED2A
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 12:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871554; cv=none; b=pKNtsTkSPENdGqACA6CSPcVpbpHtRhUp2kU+pbKig0uZPH7VaE8i/JmfAM4u5NXyesYIU4sCA3cSNE5lqzFYKZMFVlpIZbn14Jh17tZae+WzMll2FZRrXHvkz4YEf5GFhMcHediR5yJAT/VltY2R76oNSdLODKStvFfEKVDch3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871554; c=relaxed/simple;
	bh=g+NHk8DOijly2lUE9iP6mVsYWkCT3aYbE5EMhvgE/mY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jpvt5IYR16TsWhUptEnLnbDvTniH4+DD954mN2bsUtoIiuqhQRN8G7gkn3/4Ppaff0A4eBiBfCpC0IyRDFwR/JQmAxkY5kV5NOE4pRmq3kfntRXv4feYdOwD2Opa/OEDk5QaUFfCl56B4ANqP6cdtZXaLlE05x95o2f7x8/2avM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WiswDAXC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiswDAXC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4C31F00A3A;
	Tue,  8 Sep 2026 12:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788871551;
	bh=g+NHk8DOijly2lUE9iP6mVsYWkCT3aYbE5EMhvgE/mY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WiswDAXCqTObYPenzSVe8VhW7H824uzMk3q85H2k4+14Hqve/ugSiKSS9DrBbwRmq
	 gv29nF5NDp31+f/Yt5LNEVi3oLjT/4fPROtC5fyRUaw9Z++XqajAQUlWb5QPNzEwZ0
	 fy+1jGl+Zjh1SuakPhXpIE9vLa2tWKA+OV67JwlJz5NvtG4fkV3xUiXkaDWzzVkVj2
	 3zFxFIHQMoZbSxQukVNBXT0oIoVJdWCa2kKIq6jf9b7DGun96V3uUv1tiZXMEfZDXF
	 H7sTfeQzt2O1aDxZmvsleEBRKvO0D/tM4eQ5T0hU56H25q7H7/ifxFC0TALn1Lehev
	 v16l94q9kcwdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/12] mm/huge_memory: zap deposited page tables
 after an RCU grace period
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260908-rcu-pagetable-freeing-v2-1-1f60b64e878e@kernel.org>
References: <20260908-rcu-pagetable-freeing-v2-0-1f60b64e878e@kernel.org>
 <20260908-rcu-pagetable-freeing-v2-1-1f60b64e878e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 12:45:50 +0000
Message-Id: <20260908124550.DB4C31F00A3A@smtp.kernel.org>
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
> __collapse_huge_page_isolate() determines whether it is safe to proceed by
> checking folio_ref_count() against folio_expected_ref_count(), so the two
> must be mutually excluded.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-rcu-pageta=
ble-freeing-v2-0-1f60b64e878e@kernel.org?part=3D1

