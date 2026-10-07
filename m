Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA3A381EB4
	for <linux-s390@vger.kernel.org>; Wed,  7 Oct 2026 12:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791374573; cv=none; b=EX0sfF3ZUQOqN4WujA5iKZKMfiPzXCJgLHZPmX/gyZTAh+ielUmqqWPfgQnHkKEtcXnQk1hvo/nJLgP7N5DXt3mKwsRU0vnAmjq1vNyZ/CQasLvWYS/vw7xwk+5tD2HB/+9hE/4pN/OzkUaL+6NcLwYTclGIhL21632M8Bt7jXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791374573; c=relaxed/simple;
	bh=jgB0fvH3Je8B8XWcUI94Ou5ChdnZtyCNsFcLDB8OAwA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=lD4xcDMPy8+L3X2QoT0zA1qn78Tt++xseJdapu2Ar24AluMtI+N0rgB72sLnqPvmgo21TyBhyzVUMnIUXSGm/LuaM83wvGop68expwls0mjxGgjRAB1Jn+Ss2plgpNyzzTZl87VnxhcNxIWfKZ0UkNY3UAZ0sBlGlQCwKYkmfI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiXsAzcP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiXsAzcP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431761F0089B;
	Wed,  7 Oct 2026 12:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791374561;
	bh=jgB0fvH3Je8B8XWcUI94Ou5ChdnZtyCNsFcLDB8OAwA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QiXsAzcPe6HfyF6ZGDOJAwE9is8Dl7Kgcy5G4GEFrSNGLroM2sF5l391lsBXDuNBu
	 nd4WrF5dhIoZ0w3+vhnS6BtljxOpxDv9065++Wf7VSp4qz0bihSU+l93ep+L549t3e
	 Hi4hrodUAkrdrcwEep2isa1F1CnfW5oyZiVRbkPCqSSruu6EV/oiVXwvri+I6dKEuK
	 DhTG34icRhcaYUZruzFLrGJ4XQuX2LhHoTLOvK6Y/cJh+I6MK+9UFhXTJ99YJWbukp
	 me/f3r8cBRuPiKIO5GsG9O3PzoPOU/oA+YZosX+ikEkiIqqjw2FZQ136cY5D+211v6
	 YJy/Up5ILPqhQ==
Message-ID: <sashiko-outbox-162966@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 03/15] mm: use hw_pte_t for generic PTE table storage
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <9b168d4b1aa81c2488a413665cc388e6a3ca084e.1791365932.git.agordeev@linux.ibm.com>
References: <cover.1791365932.git.agordeev@linux.ibm.com>
 <9b168d4b1aa81c2488a413665cc388e6a3ca084e.1791365932.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 12:02:40 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Muhammad Usama Anjum <usama.anjum@arm.com>
>=20
> Generic page-table interfaces use pte_t * for both pointers to PTE table
> storage and pointers to software PTE values. Convert the generic
> declarations and their MM, fs, and kernel users together so parameters,
> return types, callbacks, and local pointers that designate table storage
> use hw_pte_t *.
>=20
> Include linux/pgtable_types.h from headers that expose the converted
> interfaces. It continues to provide pgprot_t to vmalloc.h through
> asm/page.h.
>=20
> Keep software PTE values as pte_t and retain pte_t * for value interfaces.
>=20
> No architecture selects ARCH_HAS_HW_PTE_T at this point, so hw_pte_t
> remains an alias of pte_t and this changes the interface vocabulary witho=
ut
> changing representation or behavior.
>=20
> Most of this mechanical conversion was generated with the Coccinelle scri=
pt
> included in the cover letter. The script deliberately ignores pte_t *
> pointers named ptentp because they designate software PTE values. The
> result was then audited, and sites the script could not convert were
> updated by hand.
>=20
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791365932.gi=
t.agordeev@linux.ibm.com?part=3D3

