Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9263BBFC7
	for <linux-s390@vger.kernel.org>; Wed,  7 Oct 2026 11:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791374003; cv=none; b=i4NfbBgnILN/bB5ggbKiv5H2R7b2GgzlkFhBAfCjxGIbTppADhTrra0tnAH+n+/zx1zP5CnkkLhny2WO+45KnikR3kK2tHbFiSPSYA1kquUrpW3RiN0uVUTTuohIWxRsNMmRhGlTC5y4pHu0cRHR/x0LhaBi2mc6l79RjrKqchk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791374003; c=relaxed/simple;
	bh=ffzP6lE2mf6mwP3iTpsVEG2m0bzsFlH/sDc4s1zT8ik=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=gN7YyCkDXtn0jOeey351XtCfnyxERZPq1OND7OApn3r7N0nnLNCjMSnl+QQHali8uk+1ODnNzZtibY2eBGWcYvg1Z29kdJ5OUFEcdNGFRHo+LytcrA1zvqGLP80wnYptTY93NUHMoLqmQdfOIvLqZkYEmVrR1iwUK9rhRJmSgds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2eUWaAj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2eUWaAj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DF11F0089B;
	Wed,  7 Oct 2026 11:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791373987;
	bh=ffzP6lE2mf6mwP3iTpsVEG2m0bzsFlH/sDc4s1zT8ik=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W2eUWaAjirM+c1AGCsSB4Je+RTazvUvuN3STLrlKOFVqUVEaEB+sDkeCAgtRJdsOx
	 FOSkTr0Lg34iZDSWmxfPtP7XdSbMhAFFGxna2LRIN7iT+gXHj4hVWUWtdzQxr1mBBO
	 pcUaaaX91bFtojTW3phaS5ADVQv98F0ofBWbG+JeEF71qWzlv5T9DDJ3OP6NyVOJ+F
	 mvawhI//HKlIyzEEvY/KhqPDUQdGO+ChiAH3n7AMVJ4SwuZNUvQqVmc01Sd5kczM9t
	 lWtgD6m5M70531+ufOpK0xeXVDeDnlqQDCJ2i3sjSCjQh/nYpfQmvsIWyF3FmS2UqJ
	 QaVAkcOjG0wPw==
Message-ID: <sashiko-outbox-162948@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 12/15] mm: Make lazy MMU mode context-aware
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <c82c8f523790d431c5eb46f8fda49609458d05dd.1791365932.git.agordeev@linux.ibm.com>
References: <cover.1791365932.git.agordeev@linux.ibm.com>
 <c82c8f523790d431c5eb46f8fda49609458d05dd.1791365932.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 11:53:06 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Lazy MMU mode is assumed to be context-independent, in the sense
> that it does not need any additional information while operating.
> However, the s390 architecture benefits from knowing the exact
> page table entries being modified.
>=20
> Introduce lazy_mmu_mode_enable_with_ptes(), which is provided with
> the process address space and the page table being operated on.
> This information is required to enable s390-specific optimizations.
>=20
> The function takes parameters that are typically passed to page-
> table level walkers, which implies that the span of PTE entries
> never crosses a page table boundary.
>=20
> Architectures that do not require such information simply do not
> need to define the lazy_mmu_mode_enable_with_ptes() callback.
>=20
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791365932.gi=
t.agordeev@linux.ibm.com?part=3D12

