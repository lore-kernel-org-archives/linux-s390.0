Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9444E359A6B;
	Wed, 12 Aug 2026 16:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550660; cv=none; b=TUDm8gb4uIbP6KiL339zSbXE7BWn+eUHs0cgtXTojopDHQxENNHYtv0rv5bxuCkZJPe8Q0HpdPsi78XImwy3LtxRFyaWJqmqm10/zvsaM57wkIlVBzgmzutK5u+B8mnmd1/tp3uqkR/rt94nkMENRSZAbpuf2TiOh1k+iZBYhO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550660; c=relaxed/simple;
	bh=PWcU/tEUxlN/9vvH5ABxdhwZM9njmGjPNVU81c2rWQg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MTwx+u4orlD9DIDcu9rVRYRkMx0fY5B11SzaaXoSmPSO77LZLX0FYl5Qy8vHW5WwOlma7oyjHJddql52vYkihh2/VFX4O9sLsNzYq85x/zDyR6UcL/BZiG0FLnK/5W6XKvjkEOvXv+6nEo5oR+prJ22pq3QC9ugvBMUzQhhNQtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgaZ56pR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgaZ56pR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA111F000E9;
	Wed, 12 Aug 2026 16:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786550659;
	bh=PWcU/tEUxlN/9vvH5ABxdhwZM9njmGjPNVU81c2rWQg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BgaZ56pRob6iKbUQaTcVZ2keBMOgv9azY9Oi61+rCsIg9LIyeGX/LZ8DdBA4aO+cJ
	 CkUY2hpMvuce4sH4vvrIOrarsdpBq5rsg99M14YHACIGCGxmNySZv/MNnkRObJ7cbq
	 4eJUboH17BrmPEPc8ED/slLH11JNsFbAiuDPoMTwN8bbgZaxUvDt2PmQ9+BvvZaLqO
	 PA101yKdt5g3Qeh8G3niVuqtQwdWgbhdmz4E9g6CwOdi3HMlML7uOjrPVL/Uk4j0rU
	 NI8gsw5O7Om3/HhoWfBePekyjal0a58HeICoBiu9D2yJqA7Diw8yTQi5HQv8Ha/Wrx
	 049KuIKdW30QQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 17/33] KVM: s390: Move PGM code definitions to
 asm/kvm_host.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, kvmarm@lists.linux.dev, "Marc
 Zyngier" <maz@kernel.org>, linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, "Oliver Upton" <oupton@kernel.org>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260812153631.3376090-18-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-18-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 16:04:18 +0000
Message-Id: <20260812160418.EDA111F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Move PGM code definitions from kvm_host_s390.h (back) to the generic
> kvm_host.h. These definitions are needed by multiple KVM implementations
> and should be in a shared location.
>=20
> No functional change.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153631.3376=
090-1-seiden@linux.ibm.com?part=3D17

