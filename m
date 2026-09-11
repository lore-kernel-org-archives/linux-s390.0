Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BFA57F727
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 19:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789156319; cv=none; b=nffXJRwujtFM1P7O7RtX9SB2vuiBDzCzb2YS5PU3YibEEHRqFnI3EOVSt3XZ9cF7VCC+MCmeop4kA90Jdp5dO9k16lBPaZ0hXS0AThKdKRrkeZz9FTxIXJlwZG0a5Kwx4jnh1rbAJuD5j0TM7Jf+W764DwKwdkD9wN3qxSXnDI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789156319; c=relaxed/simple;
	bh=dPG8D7nQbnSEarJZr4qSsMJjTewM+l/cfZWk2OEqY70=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZITomNAwqZnZnqYIUVzbSnJu/F6WZNC8POL1kNHjVpW1Gz2O8R7WaHWW6SjoO+O+POkOLfwGvzaG83ueRgsdKbEwDr5QCfhaU6tqPXHIUv6JBH893bAoRqqdsSdRGpiZRJjQzykRnPtJBMUGFBYxAFw0LGpZ52NF25Dfl0L66Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1rXrBcW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1rXrBcW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCAC1F0089E;
	Fri, 11 Sep 2026 19:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789156307;
	bh=dPG8D7nQbnSEarJZr4qSsMJjTewM+l/cfZWk2OEqY70=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=o1rXrBcWYSRLVdkzAWrKMUmls9iI+PQQszatkq1BoRFy0ROtDWgK5NUCduC5PeNa6
	 hUximHOppR2iilMKBTeBcO0s+gf29KQFbljozlJOsFA4fPyWvRKLK2nVl1f8YT9mTz
	 GIVH9QkE8GolLRz1xhdBabsEWSFT3TFRkhwOIcKi2sCG3NPpGEbU1sHpkyej5skjZQ
	 3kk/VkgSPDJPn+f5ibv2oPIzW36gebKyyhWwBmjTSMBIA8xf1a42uypOqGBK3LW/mi
	 m+TRPvkvEoVvo49sOYMZ058kOwOHP59rb1/mnI5jyjUakaK9eCPNU0+RUHftxL2laK
	 CDI2mqolnj2aw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for arc,
 microblaze, xtensa
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260911-rcu-pagetable-freeing-v3-5-7b8c86103821@kernel.org>
References: <20260911-rcu-pagetable-freeing-v3-0-7b8c86103821@kernel.org>
 <20260911-rcu-pagetable-freeing-v3-5-7b8c86103821@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 19:51:47 +0000
Message-Id: <20260911195147.8CCAC1F0089E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Each of these architectures directly free page tables without routing the=
se
> changes through tlb_remove_ptdesc().
>=20
> The use of tlb_remove_ptdesc() is required for
> CONFIG_MMU_GATHER_RCU_TABLE_FREE to correctly free page tables under RCU,
> so simply update these architectures to use these functions.
>=20
> Since none of the architectures share page tables or do anything unusual,
> nothing complicated is required here.
>=20
> Therefore this is simply a mechanical change - convert __pud_free_tlb(),
> __pmd_free_tlb() and __pte_free_tlb() to use tlb_remove_ptdesc() as
> required.
>=20
> At the point this is in place, all mmu_gather page table freeing is
> performed under RCU, and thus MMU_GATHER_RCU_TABLE_FREE is selected for
> each architecture.
>=20
> Note that CONFIG_MMU_GATHER_RCU_TABLE_FREE is dependent on CONFIG_MMU for
> xtensa to reflect the fact that nommu does not implement page table
> gathering.
>=20
> This forms part of an overall effort to switch every architecture to this
> mode.
>=20
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-rcu-pageta=
ble-freeing-v3-0-7b8c86103821@kernel.org?part=3D5

