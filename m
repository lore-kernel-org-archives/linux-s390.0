Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA2453F6A5;
	Wed, 23 Sep 2026 15:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177247; cv=none; b=Kv2fOnjOOaBWyHiTIeZA0g5TUEDkvDJmPID4cq/amnzVSfxOZIpol7wgyTMMSljMG6iTTR2i5BwxnOhpCHhxrExj+vp1/Scp43uwQkZ26A8g9DdnMWvHBSK6Wa5qh05yX2vQKWJ8na7XsfC3aPE1dfJgZvA0I9HpIrpXCzp5Rkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177247; c=relaxed/simple;
	bh=Y1yMrz9dgeENsDNL1xLjUqTD+3F1wpVwzddaML1dISA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FdUWdaGnSQudAfR1KarRg6AgzGxpuYKJvFvUTXj0vp4F+K7/Cs/5dhNbYFBZMRIiqKLS2h/JIn6GJYKuLqDcZgONP2G7As1j7r770XPolcS1CorxHLFLyw8mv8o6FCh0IyPib6Z0R08G61GZU091RalWvsOQ4dgSxmDuoQhf1QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICUb3N+o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICUb3N+o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63791F00893;
	Wed, 23 Sep 2026 15:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790177239;
	bh=Y1yMrz9dgeENsDNL1xLjUqTD+3F1wpVwzddaML1dISA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ICUb3N+otqpgEEZRLZ35f7TfKmvNVWrNZtt6HZz/BsWxumRVkFTuw3oqhhJGFVjtu
	 DhBdkUntL8fRhCfcXuHgPMEw92/RYHpyV5pfGKmd0ByPEJeuXy/YMeWgHWIAFVELlv
	 J3SA6w3ks4qz8jGCJd5q/MLClxuWUgyui9cGOPTObYdOJa6e5552jPArBLKc8mUqmU
	 KHaCLNLxA7D+lBCyPmpJjrB1bebsetLcaW7kN860/E43PTWMhQ20ixeVMCOquxTrkv
	 MbwHdeoaTu8emzjd33GLzg8mGboeFL2jzSroru/2ReYeF+TVAlvtFYZm4AhEQX1evg
	 cR5SbdHi4yr2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/14] KVM: arm64: Propagate and use
 kvm_s2_fault_result on S2 fault
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Oliver Upton" <oupton@kernel.org>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvmarm@lists.linux.dev, "Marc Zyngier" <maz@kernel.org>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260923-kvm-arm-prefault-v4-6-d4b0b4dfa8c3@kernel.org>
References: <20260923-kvm-arm-prefault-v4-0-d4b0b4dfa8c3@kernel.org>
 <20260923-kvm-arm-prefault-v4-6-d4b0b4dfa8c3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 15:27:18 +0000
Message-Id: <20260923152718.A63791F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When stage 2 page tables fault the net result may either be that a page is
> mapped, an error occurred or the fault should be retried (-EAGAIN).
>=20
> When a fault succeeds it may be upgraded to a PMD size via
> transparent_hugepage_adjust().
>=20
> In order to support KVM pre-faulting the outcome of the fault and the
> mapping size must be recorded.
>=20
> Track the mapping size via new kvm_s2_fault_result struct, which is
> threaded through gmem_abort(), user_mem_abort() and kvm_s2_fault_map().
>=20
> PKVM and SEA aren't relevant to synthetic pre-faulting so neither
> kvm_inject_sea() nor pkvm_mem_abort() are altered.
>=20
> [ ... ]
> No functional change intended.
>=20
> Suggested-by: Vincent Donnefort <vdonnefort@google.com>
> Reviewed-by: Oliver Upton <oupton@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-kvm-arm-pr=
efault-v4-0-d4b0b4dfa8c3@kernel.org?part=3D6

