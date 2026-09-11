Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7D3584966
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 19:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789156780; cv=none; b=ZDDmy/PgyrObp4EKYOgmm6/0KObMCB27/kYHq29W8+FOpawC632fb1gWeZfL9dGZTKrT68dmkPP50gZQrzDqiO9aiV4UCHW5dxOlHB8XSehX/yWztfPti/LZz3/+DQlrlaYTDlIsW6aAs9ML6VZt618dGUqxZBa+Bn3S6Rgfn0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789156780; c=relaxed/simple;
	bh=rKusOAAtxW8+3T8pol/7JVoH2aIEHJ9BY90ryZx458c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xqo8PkZ36xSp5Kr4N+S76EIrp2JNFjMZ1Z+IH3uR5dcP9JtlJWsoPmmyN5N7+8SnFtptAHPPzGYZ3UFN2pXJHNDKa9mKzwsMSqfSDjNceSaLKO46RC1GYmCZENv8w6Ie5fF2+Gf0k9DfHOlt2p3HNupzCxxZAVZsMdol8SXdVV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhTXqaL0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhTXqaL0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3FC1F000FF;
	Fri, 11 Sep 2026 19:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789156774;
	bh=rKusOAAtxW8+3T8pol/7JVoH2aIEHJ9BY90ryZx458c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fhTXqaL0joBu7RJevxczpZl8+NhwMofd82+H04nP34ss/p4F/Htu+bEtuLdNqUtrb
	 /jVGLieiy8pc5XD0cKkKCJQfM723t+YHXzDrSRncNj8VDmAvr2N4nw/bwHSxWc61OG
	 U25h83oXeUJFfU5+XfYjrHm58/vjfsAauqSXh0f3KPYif9124wVnnrLrJNefHfZESU
	 qZdkX8DPrnzoo90DqjDM7BPcWfQvMpy1Mtzs++GUZ5XSgns80EBsTeYebjzfoEMj/U
	 aZuidk9+pS7tBr7CdI5jPbWtPUaill90tXIaO6+wld59nT/AK9F6ov+IJELVpNttbW
	 YsnzLmo0CxK8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/12] mm: make userland page table freeing RCU-safe
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260911-rcu-pagetable-freeing-v3-11-7b8c86103821@kernel.org>
References: <20260911-rcu-pagetable-freeing-v3-0-7b8c86103821@kernel.org>
 <20260911-rcu-pagetable-freeing-v3-11-7b8c86103821@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 19:59:33 +0000
Message-Id: <20260911195934.2E3FC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Now every architecture has been converted to support
> CONFIG_MMU_GATHER_RCU_TABLE_FREE, this configuration option no longer mak=
es
> any sense to keep around.
>=20
> Therefore remove it, and remove all the dead code that existed for
> !CONFIG_MMU_GATHER_RCU_TABLE_FREE architectures previously.
>=20
> Additionally, CONFIG_MMU_GATHER_TABLE_FREE is no longer necessary, as all
> architectures instead use CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE when a custom
> __tlb_remove_table() is required, so remove this too.
>=20
> A number of architectures only enabled CONFIG_MMU_GATHER_RCU_TABLE_FREE if
> CONFIG_MMU was set, however the mmu_gather logic only actually does
> something meaningful if CONFIG_MMU is set (mmu_gather.c is only compiled =
in
> this case, for instance).
> [ ... ]
> upon page table walkers to ensure that the page table entries are as
> expected.
>=20
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-rcu-pageta=
ble-freeing-v3-0-7b8c86103821@kernel.org?part=3D11

