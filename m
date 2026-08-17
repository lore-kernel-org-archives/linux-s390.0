Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DB84B0497
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 11:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786967308; cv=none; b=fMy+8pgUMGjxICkRc7UVIzKkQulM9xQTKThWz58DN7cd+Cn4DAQ+hNEyZEwogivY1NpvVQSRSUpVs+dffGy84AeTsru/6G4h5fE9gcvGu/dXldkpO9wmy2PJFgMpzepdeH6z0VTo/Pj8C/jg/wnWxdSZQSvODgUbKLqTKOyc5rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786967308; c=relaxed/simple;
	bh=PZ6d4naUCHEl6VjJ15tvvEpJu4AGYImM848v+rPxJUg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z8CHZf9vywvLCg8hcG6jaKXUyQaGGLnqWgOEaOM2INlFJHfQbbu0Hu+TE9dfSK6Eces/j4kaMoOcWC9GqE7XpfgTVaXYNF1QvtUNmb/64612IRj4iuwG0TzhewJTZ/8TK2V0f8rH8FE2pjN5sUsXkyOBRTSdgK9IokdNVTroruU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Guy/FAvX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Guy/FAvX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8A61F000E9;
	Mon, 17 Aug 2026 11:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786967306;
	bh=PZ6d4naUCHEl6VjJ15tvvEpJu4AGYImM848v+rPxJUg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Guy/FAvXWmJh/FEd7eQQLQBn0DaHrEMOoi6EhWrxFI0a1vEUze7TU0ZRo0PLQU0W6
	 iGYarfxTLlosRMHmPqBz7Kp1pIahhmb2lnIBQYR2s30H+mFKiCw7G1q2h54D1D874p
	 gYmyGxM6UFDMKaThv+JOrCANdhA6PVspggwlC7FIrNJ8LrtD6hicVhAc7NbuB2uXP9
	 rj9KmLAV2yNJTHYR5S79L9UvC2f6jDTHpH56z67vvcE+9OxeXj38F7YJZNDLYWoJ5v
	 +jstY42+b4Trm0gl78ods81plgh4cvvU4ZfgRafYMgDRLGlKJBluWl6WJgjM1EXbww
	 D+1d6EwWqp/Sg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/4] s390/mm: Batch PTE updates in lazy MMU mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <d7fd78377a7278108ef501cf76571e80caef5968.1786956464.git.agordeev@linux.ibm.com>
References: <cover.1786956464.git.agordeev@linux.ibm.com>
 <d7fd78377a7278108ef501cf76571e80caef5968.1786956464.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 11:48:25 +0000
Message-Id: <20260817114826.5E8A61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Make use of the IPTE instruction's "Additional Entries" field to
> invalidate multiple PTEs in one go while in lazy MMU mode. This
> is the mode in which many memory-management system calls (like
> mremap(), mprotect(), etc.) update memory attributes.
>=20
> To achieve that, the set_pte() and ptep_get() primitives use a
> per-CPU cache to store and retrieve PTE values and apply the
> cached values to the real page table once lazy MMU mode is left.
>=20
> The same is done for memory-management platform callbacks that
> would otherwise cause intense per-PTE IPTE traffic, reducing the
> number of IPTE instructions from up to PTRS_PER_PTE to a single
> instruction in the best case. The average reduction is of course
> smaller.
>=20
> [ ... ]
> In an extreme case of mprotect() contiguously triggering the
> quiesce state on four LPARs in parallel, measurements show
> ~25x fewer quiesce events.
>=20
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786956464.gi=
t.agordeev@linux.ibm.com?part=3D2

