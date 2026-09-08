Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0A553D0CE
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 12:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871352; cv=none; b=UBd+teO+9y0aVRWRNWU89QTgD7Ph2rB9EdJtgWy39ya7mvfpTMjblPYXIiD0Bz4rAfGHNg//zKqbruqlWkVV1ZTaBmBdOr/oP0dMYY5ZgKCP1mfzQ1bt/2Qt+ovrdlcULoOaEbTBbHD6hdsvEoXl/5KqawYkzb/HJSkUfoI+S54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871352; c=relaxed/simple;
	bh=KEJoMC1Qi+8T7N+BJf99nyPvPkDgOR2zUMOhqLIa5WU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eyQkR9pZPqgLM8bRTpuAi6mRhywWl1ld67jfT8fxiDjVy1jKlQWefk2wRBLxHxeIauP+zVwaXkCxoHfP37Op/H9LZIetbkYfh4H+ryWupUcVoh4qUU0o1kEUtZdguwPmVNrgX6foE2p4VoNopqygJWZtdde8DL+B5WuWEjcopI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRC7sJum; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRC7sJum"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF59A1F00A3A;
	Tue,  8 Sep 2026 12:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788871351;
	bh=KEJoMC1Qi+8T7N+BJf99nyPvPkDgOR2zUMOhqLIa5WU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HRC7sJumUILIngPhlVAzs3gfx+jMaprDWkf+nlF7eiTy+dKCQrhMCUHvFEXVYxq+P
	 7fzQDyne+p8JT7DWBSr6agsAVbNSPIQjaPg52e2qedSxfi0phr/YIScIeVMEfpCeqJ
	 ZdBgm8fs8jQV9pMf62PazO9knXq8zTFH+CUeX6nWn9twWSh9/FvgGWSXX11reBPmxD
	 TrWZ2lMkh4Ft/0lYdcsWGaUfLDdPHX5dBImCXHvWONuR0uIWQ5GwBqjzvwmUBq96X0
	 azZ2zOnZCb4oE2a7PaBWLBvonVC5gaEmcFEjoXxJoChb64Kwr3zB8RXcdzM4wDs9gV
	 rcJCgKy7bbN/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for MMU
 riscv
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260908-rcu-pagetable-freeing-v2-3-1f60b64e878e@kernel.org>
References: <20260908-rcu-pagetable-freeing-v2-0-1f60b64e878e@kernel.org>
 <20260908-rcu-pagetable-freeing-v2-3-1f60b64e878e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 12:42:30 +0000
Message-Id: <20260908124230.BF59A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Currently riscv gates MMU_GATHER_RCU_TABLE_FREE on CONFIG_SMP and
> CONFIG_MMU.
>=20
> Commit 69be3fb111e7 ("riscv: enable MMU_GATHER_RCU_TABLE_FREE for SMP &&
> MMU") enabled CONFIG_MMU_GATHER_RCU_TABLE_FREE for CONFIG_SMP, CONFIG_MMU
> riscv builds.
>=20
> This is expressly for the safety of GUP-fast walkers (CONFIG_HAVE_GUP_FAST
> is enabled if CONFIG_MMU is enabled).
>=20
> Naturally a single core system does not encounter issues with software pa=
ge
> table walkers being correctly synchronised across cores, as there is only=
 a
> single core.
>=20
> However, CONFIG_PREEMPT_RCU is still available on a riscv UP system, so f=
or
> a future RCU-only page table walker, this guarantee is required to prevent
> concurrent page table teardown.
>=20
> All page table freeing is already done via tlb_remove_ptdesc() so the
> conditions of CONFIG_MMU_GATHER_RCU_TABLE_FREE are already met.
>=20
> This forms part of an overall effort to switch every architecture to this
> mode.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-rcu-pageta=
ble-freeing-v2-0-1f60b64e878e@kernel.org?part=3D3

