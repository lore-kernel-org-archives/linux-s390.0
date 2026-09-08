Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF39534460
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 12:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871856; cv=none; b=QQ+P1uD43X6i2B5cwly/5wLQlC5fBMmMV/shLActwErtLg6Jk7xRA12JyF/f560yglkDmttiY5oCQucBdOTToquxTV08aa+S5A1LGDJNP8UBD6S8jBga7v4JWvj4EqUWJlTHUVMhMC62nQB+ZQQbyI6CsTppSJTtKrgbukrQPp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871856; c=relaxed/simple;
	bh=PyoVmegcO0Ngn4H8opMC+lrbYJtNC9Od+Q7itePp3U0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ILGHDET1vYurMIuGzrPW5/KlFwrrkQWzKCyf/Ge5eZu0Pk5w+psXTilJaf8/3EOIJiyuSp4xNJjOFoztNgBuPOOY1nGl5MT7341O4tM98sHMQJOpppU90/vfKmjrm6kS99lbpZgunRAyVmC9BEI61JXWmhhE5UhQ///7VtvS+JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7yTc7VQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7yTc7VQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCF61F00A3D;
	Tue,  8 Sep 2026 12:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788871855;
	bh=PyoVmegcO0Ngn4H8opMC+lrbYJtNC9Od+Q7itePp3U0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I7yTc7VQzEETKjEpGag93h2+MPh59lIqoJueAoPSvqHmbWQI5segLBi35yS5VRDvR
	 re8U2fsQuflrYbuUe9okAqvTI5ecTToC8zPM1yhjHTqLXCDfnbR1tb3Y3bgT+Kn1s/
	 YoufECkepYbV+CWoHCZ7FArY+3iJVPnM7dC3YeTmuPNwcaUyk2oqUj3N/wnH3+fORa
	 +oQjQ1o4j7BCN0hcaw288NHLDVfwUULhuuJdodFu2/vkLlvI0hZSkhtyFj6Cy5gATf
	 fOSsgVChl/pDu30fXyIFQsC9EHB573LyG0Srgk5vqtksDdbOjfcjNNonYEF31q4xKv
	 Hcs3F+r3aipTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/12] mm: change the contract for free_pgtables(),
 update docs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260908-rcu-pagetable-freeing-v2-12-1f60b64e878e@kernel.org>
References: <20260908-rcu-pagetable-freeing-v2-0-1f60b64e878e@kernel.org>
 <20260908-rcu-pagetable-freeing-v2-12-1f60b64e878e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 12:50:54 +0000
Message-Id: <20260908125055.3DCF61F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Now that page tables are freed after an RCU grace period, it is safe for
> read-only page table walkers to walk page table ranges that are being
> concurrently torn down, provided the mm is kept alive via mmgrab().
>=20
> It is however unsafe for writers to do so, as they must obtain an
> appropriate lock to do so safely.
>=20
> Update the pte_offset_map_lock()'s comment block to reflect this.
>=20
> Similarly update the process addresses documentation.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-rcu-pageta=
ble-freeing-v2-0-1f60b64e878e@kernel.org?part=3D12

