Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F406377AA5
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091944; cv=none; b=EXe8OIQm4DDEsvqrb8nA+zJZDGuv2bpEvQ/LroUY6/xdrfysEvlsTU/pDGxX2EXjmKFmRLkr8sQl60HSVJgBzhAIjdhcK4/OOXezTCDR3aKdkaBwt0uJMKsDNXvmRfwS/T17zbD/JJDYWkFBtaGt0e5gV7CcWHxpW/bIgd9si6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091944; c=relaxed/simple;
	bh=MqIzpojt+/I1XeMCGiVa2Ocs3zllmSi07mu4FmVzEyY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R4QTrAHLXz0d2sDbncFSPbkhb5ZFxlSJmGUvtxFqqAUbH/zT87omo3hsVaISvPWHDuog0L2TT9nH5lDHrvfYAc9fSAx4kXKFYW1XwYf1jkVjLN3Usn/bVekjK+Umx5j61RYIYUsM3TI9GrirLPtvNUkyA9Ann4wbdr3zS6cOB64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaYeUYSB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaYeUYSB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF051F000FF;
	Tue, 22 Sep 2026 15:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790091940;
	bh=MqIzpojt+/I1XeMCGiVa2Ocs3zllmSi07mu4FmVzEyY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eaYeUYSBsZJTLNXJp/e7ZF1aByu8WPpNwcgo9uTRTZftYKMX1IaF2NnPx6stXbV8n
	 lTvYdrR3PBpZVvviplnk1CxXTolchIiyCsnciDaEL63vpG5Y42h90Yel+ntLDwc5Vr
	 yD8Y+/YeZ87ujJ+jTKHE0rF4dAk96wMCkE9EWG1Wom4yuserYO7VcmEgauwYDVNmse
	 1gMf4nuOmf07TRL268l1Xf9vao55RKw8c+i6G9QReHXQtKfcmzP+5vr3ODj0bTl5Vc
	 sfA6Om0nM9q+ecQL5v8xu07po5TzlD9QbSlP+qkHc5QPQPSHBD7YgZZcuqFc8z+oJ9
	 ia9YJKG+rK85Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for MMU
 riscv
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-3-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-0-fe1ad1f1e303@kernel.org>
 <20260922-rcu-pagetable-freeing-v4-3-fe1ad1f1e303@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 15:45:39 +0000
Message-Id: <20260922154540.4EF051F000FF@smtp.kernel.org>
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
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-rcu-pageta=
ble-freeing-v4-0-fe1ad1f1e303@kernel.org?part=3D3

