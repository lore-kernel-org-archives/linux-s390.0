Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3A03655D9
	for <linux-s390@vger.kernel.org>; Fri, 25 Sep 2026 20:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790367717; cv=none; b=bA+ZSm9XL5X2D7pk8f1lbwjUf7Ni8/47aOFutqT8fXYG9vTZroolUzadkO1EHfUVUnsNBQfQ+bz+t5wA9HGIigZM3rXK4A/11VPmRNFL+SjHp44okdxWigW/5pafuLMcKtP25qYB4pSTcZ6f4SufIupBWJofXoWtm8TKCetqYrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790367717; c=relaxed/simple;
	bh=tShn6vWw8bppnQipYlGC5yY3rZRQcflOVJonzit7WV8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t/oI7PZ4baX1qpvEljX7u8d3wneqQfNabyNUxHhvP89yNiokMkaJsWVTdY5SVrVYZUGNMTZ1acQvTfyYwGcKy9Z3wgTQE8QWUgRt/MX2oAXRe4kkQ7McOraP2HiAXfDFRuVZiHaUA6MfjoXW3kNekwysZq+o7OYUPmvbaCtsZtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUFeEVQS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUFeEVQS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE2F1F000FF;
	Fri, 25 Sep 2026 20:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790367715;
	bh=tShn6vWw8bppnQipYlGC5yY3rZRQcflOVJonzit7WV8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZUFeEVQSpWwKwF9tc/EDRgRBWtLaWOCh/DjC8hl2DFQSysdsAcnfPOjl/rpLMHgN7
	 WldcU3JJ2xnPoDGHuHYDMu55OElBML+MTYo1jKWQ+DTfBTGQEFpNPsU7dca0Yy2Zyu
	 Er6Q6oow8VF2Kwt+lUjGnjMRX9uTrCb6EmHVTp8vpJwj1KHPwscLRT4dTh1QRcVgV3
	 K9nOZDyQrf56ACgNnxocyAB6mNaFfH47fEwzv79bLalAc676FI2/RAQNrOMZjDXtv3
	 jD4aZ7WKa6wQClH1NArYef4G7cMFnvxaCutHuoEweilUUtPF+9V0W/u+OMy+SumVHI
	 L1JTagYbreskg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for
 m68k-coldfire
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260925-rcu-pagetable-freeing-v5-7-31e91065fea4@kernel.org>
References: <20260925-rcu-pagetable-freeing-v5-0-31e91065fea4@kernel.org>
 <20260925-rcu-pagetable-freeing-v5-7-31e91065fea4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 20:21:54 +0000
Message-Id: <20260925202155.5DE2F1F000FF@smtp.kernel.org>
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
> Acked-by: Greg Ungerer <gerg@linux-m68k.org>
> Tested-by: Greg Ungerer <gerg@linux-m68k.org>
> Acked-by: Lance Yang <lance.yang@linux.dev>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-rcu-pageta=
ble-freeing-v5-0-31e91065fea4@kernel.org?part=3D7

