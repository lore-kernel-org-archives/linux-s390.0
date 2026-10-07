Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E28638D3F0
	for <linux-s390@vger.kernel.org>; Wed,  7 Oct 2026 11:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791374160; cv=none; b=dnQP21LjXojv6uUKo/ohEVPDGIUuyr2LnJ5PR6sFfZW3Ipb0Vx8+wJOUJXe67Tr+4i5mfgXFm362kAj5AP9290+XygXnrZzAOupxRsDrvotFafFLDSh5O9MH9+rUTFHBgq1HleyLD+KunOzbPArthryx70vcwLh8eJeUetpg9Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791374160; c=relaxed/simple;
	bh=s+ZmRB5F5Heqg7eeh5FsrOnGDZGVKosjLNqwo6Gz5So=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=f4LyJnt+xPy1gmBwglkQDYr2US07lWP2ydAiVa9ECzsmor6GCTExzqKNLWyJFNXIwUWWiM2kwAjaqmXMuXJBFIR+8/SHk8Oj6w/5YJNWjJ5Y0adp3YGJCdf3oLDtPZHiNZIiKs7n51k6jCo8j09ZcVDiK4A5vDh/X3bKQ7wS7EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuC2Upwu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuC2Upwu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87C81F0089B;
	Wed,  7 Oct 2026 11:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791374150;
	bh=s+ZmRB5F5Heqg7eeh5FsrOnGDZGVKosjLNqwo6Gz5So=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AuC2UpwuUe4yZUagXvoj1gRuWGYRONHo/jjfFsTaWZpNbIMv8gixa8s8BykSEAogv
	 vTKSImpsO6o1zp6Cvu4NkmW0gKJv222U6Rfr8VMn3zZnChz67FWDGXqY8jGvGwlMmL
	 V0zW4vFQhLO3A0lUw21CMbkybDnTylUEwTjzT3aT88FuHGh6LYRVsG+l8LoDKDANfN
	 TTaPv6iBOQIhotPo88ugy/PKADF1gyCSY9fb/yijhGuTPzO4injsuEL9MyquajX2cl
	 y6Osrrh1BWbs/c+FBc3S4FZ++Od1eFv8xITrZoJ1QGTgMv66ilbU0Ai+6HwFXy3RPs
	 CMqru/q+WVhug==
Message-ID: <sashiko-outbox-162952@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 01/15] mm: introduce hw_pte_t for PTE table storage
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <b904864873389b1efb75d84896113e867d8aca69.1791365932.git.agordeev@linux.ibm.com>
References: <cover.1791365932.git.agordeev@linux.ibm.com>
 <b904864873389b1efb75d84896113e867d8aca69.1791365932.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 11:55:49 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Muhammad Usama Anjum <usama.anjum@arm.com>
>=20
> pte_t is used both for software PTE values and for entries stored in a PTE
> table, so pte_t * does not distinguish a pointer to a software PTE
> value from a pointer to table storage.
>=20
> Introduce hw_pte_t as the generic name for a PTE table element. Define it
> as a macro alias of pte_t by default. When an architecture selects
> ARCH_HAS_HW_PTE_T, define it as a structure containing a pte_t instead.
> This preserves the representation while allowing converted architectures
> to enforce the distinction at compile time.
>=20
> Name the generic wrapper structure __hw_pte_t so architectures can
> forward-declare it when pgtable_t must be defined before the generic
> hw_pte_t typedef is visible. This avoids header-order dependencies.
>=20
> Keep the C type definitions behind an __ASSEMBLY__ check because
> architecture assembly sources can include this header indirectly. Include
> asm/page.h so consumers such as linux/vmalloc.h retain the page definitio=
ns
> they previously obtained from that header.
>=20
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791365932.gi=
t.agordeev@linux.ibm.com?part=3D1

