Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5306447F3C1
	for <linux-s390@vger.kernel.org>; Wed,  7 Oct 2026 11:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373888; cv=none; b=tD46SFyJFDcGhw3TeK3WJ4w6RriU3kUGk7mVTou6Wqa2HQXzUFvsXf8aEtsKHolGPewnWLHp6mPE1tJgEZpB8WwDeyDfinf+NLHjmbncGnTvXc189gKJHG7EoiFF30wIx2Wiuc1eUlE+cMwqIXhhmJLKL2dC7SN8mevRF0rlddw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373888; c=relaxed/simple;
	bh=xlo5PtE05QF5dX41MLWEQEwJvvRuNjYCOj/XJ+qq2bI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=KKqj7fVycVW2JFPDTR4n05gvzRAFeoSXs/zSoZnoEF56eOVhKs5nZIIPJz20v/ftijtGTmMV6IsI/FK+1bc96u+sGH/nx654uAPJuqSbWIPXnbVIdi0GE6RQrr3YHf9EvDJInb+BSqn1B67akpXmgTsXiqWUanxDlzczjxC9wRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCGDCCwj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCGDCCwj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C278C1F0089C;
	Wed,  7 Oct 2026 11:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791373879;
	bh=xlo5PtE05QF5dX41MLWEQEwJvvRuNjYCOj/XJ+qq2bI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KCGDCCwj4Qdt05NbKsEHCoHakYs+xTxAWeHnHNZ29lVUIqvZNgnGepkchXfm1bUfu
	 LWgCFnH0hwyi8fSy/mTg2Av48A50Dv5QNoD1Rhc1VabhZLfDWBetpRFt2KUJUZ9Ugc
	 SHrTJqeQIU/8bteqdno1zrkKteERBbTrpxdQK1LW95FXHh9Sfbgvf8vqkOuaUop+C6
	 ca6GHyUqSETC5mwIoEolDVZcg8LYpJ4ZRLVxI+kqkaImBXk1zEFOj1UH0LOafe/hw3
	 ntAqKqIV/0Q1E9n/M2hTpyajx2si8l8uiebBdK6z9po4GFc535+HmMvO7FuPkmw/Qp
	 oo9oMwPJUbIuQ==
Message-ID: <sashiko-outbox-162943@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 08/15] drm/i915: use hw_pte_t for PTE range callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <fec82d136996345f5937cc3a8fac951fdc2ba2f0.1791365932.git.agordeev@linux.ibm.com>
References: <cover.1791365932.git.agordeev@linux.ibm.com>
 <fec82d136996345f5937cc3a8fac951fdc2ba2f0.1791365932.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 11:51:18 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Muhammad Usama Anjum <usama.anjum@arm.com>
>=20
> apply_to_page_range() now passes PTE table storage to its callback as
> hw_pte_t *. Update the i915 remap and selftest callbacks to match the new
> type.
>=20
> Continue to use ptep_get() for software PTE values and set_pte_at() for
> updates.
> The type remains an alias of pte_t on x86 until that architecture opts in.
>=20
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791365932.gi=
t.agordeev@linux.ibm.com?part=3D8

