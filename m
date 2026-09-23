Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2476A53E31E;
	Wed, 23 Sep 2026 15:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176868; cv=none; b=AgZKBQYQN/xMgjKFObRh9e/PS8f6Y2HGYsMDLeDJGOBbFfDaQEs1p2EyfmA6TebomEyYuA6/5JSoyNS0tfE8VKxy8AyesQUeE9/bJ34FUapB++6TzCra9D2tlCh2U8wEkDGhujZtTMcQAeTWxzIgb4bnlXZ0vmyNNolRtLdINTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176868; c=relaxed/simple;
	bh=Bmcy9Cv+pPGCm5dDiZBf7hzJdCHteCrdCvSOsbfpdKM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D1h6YJTy5G/77vu3VOuEKrOqERvS2W9y5Xq7fICNRkhEngshy36KmvDLFYJfCk8jEtIArMRMImmLcWzcIGLgeV3vgmOwGBnAQWDmDeRW6526MLSAwo/nSZo+IVa60b7CFOWUKfEPzX+hyvfKwhvRSXjF1XSfMXal9C5vY+CwVjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Shb/qLYs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Shb/qLYs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4B01F000FF;
	Wed, 23 Sep 2026 15:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790176867;
	bh=Bmcy9Cv+pPGCm5dDiZBf7hzJdCHteCrdCvSOsbfpdKM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Shb/qLYsK9dF99N2Yuc43VnJo0OF9MfjzXN4KGo93fdcDr/EutXUKjTn13xUDP9cR
	 hf1tQitXANUC5PjD+pDQLsFOgZBekcHTM0pSYgKRSicy9+U4TOuiotK7NNqS3EGO30
	 dR42IE7ss13W6vN86UvHwM9Ypom2LlSOhZ3SmP9dUYRYFBGsThLoRr+6/da1u2yiaK
	 WoS79GIP9UPS1QZuD8UZ3A9dQTQSo7XlkbONZ+eHErB0Ch4QeU0YLSr2puTx1tj6V3
	 2mqSVsoS3abxQZOtGmZzFM4ZAenToLfr4DNTV/xDA38odQRJQaReKuSx7FqJiyw9ZV
	 HvR5OP9INFlYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/14] KVM: arm64: Pass walk flags to
 kvm_pgtable_get_leaf()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvmarm@lists.linux.dev, kvm@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260923-kvm-arm-prefault-v4-9-d4b0b4dfa8c3@kernel.org>
References: <20260923-kvm-arm-prefault-v4-0-d4b0b4dfa8c3@kernel.org>
 <20260923-kvm-arm-prefault-v4-9-d4b0b4dfa8c3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 15:21:06 +0000
Message-Id: <20260923152106.7F4B01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Jack Thomson <jackabt@amazon.com>
>=20
> Allow callers of kvm_pgtable_get_leaf() to specify the page-table walk
> flags, in preparation for performing walks under the MMU read lock.
>=20
> Reading a stage-2 leaf while only holding the read lock requires
> KVM_PGTABLE_WALK_SHARED: parallel faults (which also only hold the read
> lock) can unlink table pages and free them via RCU, so the walker must
> be inside an RCU read-side critical section, which the shared walk flag
> provides via kvm_pgtable_walk_begin().
>=20
> All existing callers either hold the write lock, walk with interrupts
> disabled, or run at hyp where shared walks are rejected; they keep the
> current behaviour by passing no flags.
>=20
> No functional change intended.
>=20
> Signed-off-by: Jack Thomson <jackabt@amazon.com>
> [ljs: fixup new kvm_pgtable_get_leaf() invocation]
> Reviewed-by: Oliver Upton <oupton@kernel.org>
> Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-kvm-arm-pr=
efault-v4-0-d4b0b4dfa8c3@kernel.org?part=3D9

