Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F692F7EE9
	for <linux-s390@vger.kernel.org>; Tue,  1 Sep 2026 11:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788261509; cv=none; b=g9fB/f65pyJDr2vWMn/et4X/cu6T7ouGju5NHqTSUnR3bdHZpddXOp9ySeq6wtfnFbXDpYr92AS5J0ZNl67CSKzpzpVl/Oqcw+hUM43PzHIKjmfxvl3xbNBLirWg2EvO+Q1CCe4QC+D++R9AIlvXRpwEFRTA/UXRVoOD37ikTzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788261509; c=relaxed/simple;
	bh=3LGIG2ezeQ+0bBcq+JsE8bxqwNnQ4iV10X2o7mpVrek=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D0KX4+uqxvyeNIQjhozuyhLtL9MBov1PGbs5nXvtNovQv+egdYejkXGIcj9srKfvTPzEj/hjapgbkEqN4uhvcfk0HJHZara0YOFRpJht9+PTZn9vCgL7r92OZMM8gshPBnKXQiPFqd3dyJEoNMYkqFooN1SCDpUV84DK8DUiZsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvVbNh+k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvVbNh+k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA161F000E9;
	Tue,  1 Sep 2026 11:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788261508;
	bh=3LGIG2ezeQ+0bBcq+JsE8bxqwNnQ4iV10X2o7mpVrek=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nvVbNh+kNB+/1ZORarOB/Parf7W17PjsglbpS3M3cf56/ZQgsE2MRcZ3iL7Ty3Qc0
	 tGUmBzSpLmOo0R8QnXoGI0Z9bA3pEwI7M2QKLijqdhr4HNYHQ8puksjB+qCi03n1yP
	 uM71+U5MsN4WIGCorp9214iUnZV8GGM4YvYeJE72TYjFruPEOc9uwOzIH6cHuAbEin
	 YXVt0IcslgDxPWmrNv/XJ1//B+ZHjNXy7AsmH0tETQHc0FquwOdZqdSR2iJ8iY4SA6
	 b/d+e9Xp9mpVUtkJaA2DNeUb0FQf0EU+63ZZmJNs+l+JopInGvys/m/mYOjYVwU7HS
	 NSsPpmXKkuNEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/12] mm/huge_memory: zap deposited page tables after
 an RCU grace period
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260901-rcu-pagetable-freeing-v1-1-5456a81c8212@kernel.org>
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
 <20260901-rcu-pagetable-freeing-v1-1-5456a81c8212@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 11:18:27 +0000
Message-Id: <20260901111828.3BA161F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When an anonymous mapping is collapsed for THP, a PTE page table is
> 'deposited' with the installed PMD entry.
>=20
> This is done in order that a split can be performed without needing to
> allocate additional memory.
>=20
> The freeing occurs in zap_deposited_table() and is done directly without
> any delay via pte_free().
>=20
> This is currently not a problem as existing page table walks are protected
> by the mmap or anon rmap lock.
>=20
> However this becomes problematic in a future where RCU-only page table
> walkers exist, as there is nothing to prevent a page table walker that
> started the walk prior to collapse having its PTE table freed underneath
> [ ... ]
> __collapse_huge_page_isolate() determines whether it is safe to proceed by
> checking folio_ref_count() against folio_expected_ref_count(), so the two
> must be mutually excluded.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-rcu-pageta=
ble-freeing-v1-0-5456a81c8212@kernel.org?part=3D1

