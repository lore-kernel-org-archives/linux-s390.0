Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AD22FDC30;
	Tue, 23 Jun 2026 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230071; cv=none; b=fHJz3tmVq2aCvwg0VCB3Iybus9xEzMvTXOOBdYplqaTjE0uXUvaCDYv2bit44m4eqjKhr8za/pcMrl4Jramv93chR5iKvBtEYO/v/xF2iLQ+RoXOjO0GU92Ja/X2Fkmn+mtEJCJFLVf1L0v7ymoe/D4UdIyGa88TZCLpMON+v4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230071; c=relaxed/simple;
	bh=imVukmgbyVFqiB9cauHJylTnrD8bu7uFNQANyQWmRAk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fj3JbtqiOZZep9/1bDy9fzFgy1HI+3AgYdHQiH9gcRY3ns9W1mgxL0tK7OrpkljHP8R6KkPS2SuHU020iRlrsTuJZgXBkodQ3YjR/qauu1lJ4P3r447tnyGQNTSnx9Wg2c0MVbv9mxA//PKB82Tej06u2FJmthANeNshygq4I0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jO4B5LLa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jO4B5LLa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315F31F000E9;
	Tue, 23 Jun 2026 15:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782230070;
	bh=z+BVXxb+F56wU2x3J6bR7vj0RzTBA1fkXbwVGKrop3U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jO4B5LLaZS69mylqhsMpqKs6RP0s8QZHHsMcIjcsNCbt07xtOdY2V05ha1u8gY4yl
	 KCRo/dHRIIksHZ8VAjeMbXS6TzS9dPRh7P+EhsQIZSSoQSSL2JB0hl728tbH1J6quc
	 bGt9V7cD0s8byRKGHp32sVBpL5EgkMiAwPQNHMMp9SOgjivwmyQoR1SK9BaFdrQ8Aq
	 tbwear1oAYBKC9vbYld5v5cHnGGuOz1V4b7KSW5cx4gJ448ZRLcEQJ2gCmO13xTxAa
	 X7aDbOzMEpLHSSi19bQK8jMYePRYKG6vzF5evLF8IMi32XkZh8us2bnQJUSCmkL8zR
	 1hYs2GeYDHzOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/10] s390/mm: Fix handling of _PAGE_UNUSED pte bit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260623153331.233784-2-imbrenda@linux.ibm.com>
References: <20260623153331.233784-1-imbrenda@linux.ibm.com>
 <20260623153331.233784-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 15:54:29 +0000
Message-Id: <20260623155430.315F31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The patch fails to fully resolve the guest corruption issue be=
cause `_PAGE_UNUSED` is not cleared when a guest re-uses a writable host pa=
ge, since no host page fault occurs to trigger `set_pte()`.
--

commit 5e54edccf96c9de6555009d16a3fc257dbca326f
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

s390/mm: Fix handling of _PAGE_UNUSED pte bit

The _PAGE_UNUSED softbit signals that a page can be discarded instead of be=
ing
moved or swapped. This patch clears the _PAGE_UNUSED bit for present ptes in
set_pte() and gmap_helper_try_set_pte_unused() to prevent used guest pages
from being incorrectly thrown out.

> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgta=
ble.h
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -980,6 +980,8 @@ static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
> =20
>  static inline void set_pte(pte_t *ptep, pte_t pte)
>  {
> +	if (pte_present(pte))
> +		pte =3D clear_pte_bit(pte, __pgprot(_PAGE_UNUSED));
>  	WRITE_ONCE(*ptep, pte);
>  }

[Severity: Critical]
This is a pre-existing issue, but does this approach fully resolve the guest
data corruption?

When KVM unmaps a guest page, it sets _PAGE_UNUSED on the host PTE via
gmap_helper_try_set_pte_unused(). This atomic OR preserves the present and
writable bits.

If the guest subsequently accesses the page, a DAT fault occurs and KVM
resolves it via __kvm_faultin_pfn() and get_user_pages(). Because the host
PTE is already present and writable, get_user_pages() can succeed without
triggering a host page fault.

In this lockless host PTE resolution path, set_pte() is never invoked, so
the _PAGE_UNUSED bit remains set. KVM then links the page into the guest
DAT table, and the guest can write new data.

If host memory pressure later causes try_to_unmap_one() to process this
page, it will see pte_unused() as true. Will this cause the page to still
be silently discarded instead of swapped out, leading to the same guest
corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623153331.2337=
84-1-imbrenda@linux.ibm.com?part=3D1
