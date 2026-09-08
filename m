Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9B453D0D3
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871403; cv=none; b=WIN72dKxnIK06tWGE24Tavq8i/mihxaRftIu+X62OxKAntPgRR9u2906hj+jyTIu/otPZtwPYIjsGl6FE5xENV37LDBxoKThNjKCinT/KYt7un29YN0B24ky9rLk6nb3yk7gQvI8ULPSAxn85lGo60RWLYW4s8e+g+zwpK4DEdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871403; c=relaxed/simple;
	bh=3mJ0+Bn5vfFWIBs5jXfsYURqNWiYGKXTBvEzTpgY3cE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SxmdibwkWydB3JRTe2H70eX9c1gqHBSbDAyKaI/wPvywoHIw2SRzCNJ0J4DyqKSgwGTIR3AEok1BIIJZtxyfUCeXbjSlaxPWG2fHe9tUDl5VinxKWkkaB0HR3aC+8P89t4o/g0/4thVXYk5Nnx1Csb/4I59syXHZcpyw45Cpwr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988241F00A3A;
	Tue,  8 Sep 2026 12:43:21 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for
 sparc64
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260908-rcu-pagetable-freeing-v2-6-1f60b64e878e@kernel.org>
References: <20260908-rcu-pagetable-freeing-v2-0-1f60b64e878e@kernel.org>
 <20260908-rcu-pagetable-freeing-v2-6-1f60b64e878e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 12:43:21 +0000
Message-Id: <20260908124321.988241F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Commit 4a0100f7546f ("sparc64: use RCU page table freeing") enabled
> CONFIG_MMU_GATHER_RCU_TABLE_FREE for SMP sparc64 architectures, expressly
> for GUP-fast page table walkers.
>=20
> Naturally, UP systems do not have to worry about concurrent GUP fast
> operations.
>=20
> However, CONFIG_PREEMPT_RCU is also available even on a UP system, so a
> future pure-RCU page table walker requires MMU_GATHER_RCU_TABLE_FREE to be
> enabled on UP, even if concurrent GUP fast is not possible there.
>=20
> To enable future pure-RCU page table walkers, enable
> MMU_GATHER_RCU_TABLE_FREE unconditionally.
>=20
> With this change, it is no longer necessary to have !CONFIG_SMP
> pgtable_free_tlb(), so also remove this now dead code.
>=20
> This forms part of an overall effort to switch every architecture to this
> mode.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-rcu-pageta=
ble-freeing-v2-0-1f60b64e878e@kernel.org?part=3D6

