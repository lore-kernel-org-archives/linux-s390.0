Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BAD381B0A
	for <linux-s390@vger.kernel.org>; Tue,  1 Sep 2026 11:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788262650; cv=none; b=b6Swtp+efo/xIiBC+FhDbQMmZ1/uxv+dhKmiXkvGBhJwVM6yDq4h6jlGsDcX8nD9DJgsX1LGUczQvG+XU+k62ycLKUYJmmG1SicGRT9oohGt/Tj7L2oIKvzx7s46hC/8Kcy97+d3knM9TYtACpx+lpKRZWaWYglbM/9p9+cN7/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788262650; c=relaxed/simple;
	bh=Fnwx53wLDcFrTacWZCgiegZFilN54Wk0jRW+lNOPRS0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mybcNo4whVOR8iHgqRYO88ETmw4puidHK/bP9qFhkJKG7hK2gUJ3m0hfykjTrwTBJb+gtzVKKMDV4SpyaqLfn1W4Y8tMxZdjIKvvIgtpaz748zAV+lNxaXT78K23xsOI1qpoyuKnO5H9dJr2cFjvJ0egcR5FsZ8dUQgIVLAz9AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3rpCdkd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3rpCdkd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2D81F000E9;
	Tue,  1 Sep 2026 11:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788262648;
	bh=Fnwx53wLDcFrTacWZCgiegZFilN54Wk0jRW+lNOPRS0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k3rpCdkd7f8L/yKFgPL5PGRAwWlfoEnCijhBz928s2KGspmX6jiYzJySD6/tvXaG1
	 6zD7znZStiUtKE4PHHTL5C3wTKTTA7eqKzgT33Ad9XtWH32LQMCqYAIJSjQEhsR8sl
	 WKtfFqGRbfVNotPGm90j/S9TjQ3switDBPPh11S5/zO7Ai3g/cvZtcnL3MkH85bIKg
	 yeMneLG7GfNt5bGjKtcOT+vJKt36YUIqmhQjAuUpGm3HhIdTj5rwwDepQt71BQuqTd
	 yKb6XIF8sB8lxKi1dlAPowVCeARMAOEiYgTg1WQ7I6FlNPsFyUd8lATJetdRdlDlNz
	 v1f8NAgsAALxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/12] mm: change the contract for free_pgtables(),
 update docs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260901-rcu-pagetable-freeing-v1-12-5456a81c8212@kernel.org>
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
 <20260901-rcu-pagetable-freeing-v1-12-5456a81c8212@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 11:37:27 +0000
Message-Id: <20260901113728.7C2D81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Now that page tables are freed after an RCU grace period, it is safe for
> page table walkers to walk page table ranges that are being concurrently
> torn down, provided the mm is kept alive via mmgrab().
>=20
> The comment block before pte_offset_map_lock() established a contract that
> this was unsafe, which was correct prior to these changes. Update it to
> reflect the change.
>=20
> Similarly update the process addresses documentation.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-rcu-pageta=
ble-freeing-v1-0-5456a81c8212@kernel.org?part=3D12

