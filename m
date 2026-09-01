Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1D52BD59C
	for <linux-s390@vger.kernel.org>; Tue,  1 Sep 2026 11:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788261823; cv=none; b=uaAkMmz8Td0qBks0DStwiDYJe3Km42FuG5xh8u2LtiaWhNPIiHJO+pV5qpdae6Lh+gdT0RlR/8dIaa5IeAdhvWc7D0yRKZyHImwG5/5sYLZyKD63D8lze37F+17grFXYCnzOfSs5DJytYX2qUXdJSakb+SEoBEadCSfOs6n7Y1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788261823; c=relaxed/simple;
	bh=d1ysD7x82OivgV0ncq7OfH14iu2wnud/MAFodULKGsE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hbwjugKFlbkVQ9Gu+XIKnI7GAs+gvzTdFtequsQdUNKVZg/TPB0b8OzgRx9Nk+3bnnNH1gsIMm+I0xh/AeWik5Q8SyQMLAUltGK6RRA5mAg8wwYnhKY893bTgoDIkyOCZNQyfB2JW9ZvrxgQV40b0qV/MQYeBvuFAkH/dy/vTIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGiY9S4Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGiY9S4Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2A21F000E9;
	Tue,  1 Sep 2026 11:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788261822;
	bh=d1ysD7x82OivgV0ncq7OfH14iu2wnud/MAFodULKGsE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HGiY9S4Yb1fg9xejBJ6y+uiPL9djmlFClJDqbLQ/AP4MIkq1sUauRWdrOkWt0L/zv
	 N6IBm88FtOfEEQZZ9FneBGWp03KVkNhpa3K+M09EpyJQg4ImbX8zntHK+DVCfGO28v
	 NQlbxarWL8nkAXz35rftM994nbt+AkQD6R4mfJMQbIyLrn09r8M/pYQGo3WPKOvKzP
	 HnfbhObbzU6A/qHEQtAj1DKQAeBJ1I2p/RfvC/BDsjUuPWSjTSGZ1fI4dbysRTDFK7
	 ZyLW9hGLe61VmAHSAvlJA8Im115guvczpSqEpxk+tKf7De4jP5Ljd0rerM0dTTZdzp
	 gDeNQVdFRYhfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for sparc64
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260901-rcu-pagetable-freeing-v1-6-5456a81c8212@kernel.org>
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
 <20260901-rcu-pagetable-freeing-v1-6-5456a81c8212@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 11:23:41 +0000
Message-Id: <20260901112342.2F2A21F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-rcu-pageta=
ble-freeing-v1-0-5456a81c8212@kernel.org?part=3D6

