Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF7041A565;
	Wed, 12 Aug 2026 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786531831; cv=none; b=J9bNJQ9PTMdGJt2ttVNc1HSHLhR2Bm/GRY++Asrzifqzu8dnbeEmZ+djrVKw4/rrnOA4MHv0Hl+Y1lDJEkPnqUu15WLWC1pySluZZdmlkv5ctO7602r0XjhL4/u40++l4Y7X5qT/kxdGOTTbpAT+f78jodBtq0vKnY0bQWUOjIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786531831; c=relaxed/simple;
	bh=aMkydKd0/PV8V3r2TrDP21c9vPOgLJ26CakzXAC3OeQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hc4PafrAg+j7Y0ylQ4GScaxqG9Nmn6T/UtJelO/w0CUsEQhC8uF5uJaibjM7HVdgHcNGZhCi2712D0ftBVAEc9l0O0c3+1INUi5FByFapAeqhgwuExET+hADzmf2JHwrS/kyWlpzGYxH5UaAVo5DlA64FxUvlb69tfxJIZFSOxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYkL62f0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYkL62f0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6EF1F00A3A;
	Wed, 12 Aug 2026 10:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786531829;
	bh=aMkydKd0/PV8V3r2TrDP21c9vPOgLJ26CakzXAC3OeQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eYkL62f0ivCS8aG/te3Wnf7GvlwtexlXiaMrQn12Kc/elBcOx/ks70gpvhsvDMDPn
	 qtsT5nQfqXuT77aKvD2rsHR6tbW32J5qi/UWBEuw5nHHB/bmbJ5ZnT8KGyP5+99I3A
	 uIdnjFNbGrQKfGadj6z4ymZZwxZgxNV7M914WyL/vCWvhJnPpkv8wKjm9sisbqKDpk
	 hTLM0b/Tgw57giY69HQZrhamzcXW+G1m5THZllZVGa1wMCqPcLJGKDU0OaqhB1yY39
	 GZnShkZKu0xqPEHTW8aP/pnjYzej9QQGFwtSJs9xGN1UfkPkhbQw3qUNxipGpXYl8U
	 thfw1qRH9fk4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/9] KVM: s390: Fix pgste_get_trylock_multiple()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>
In-Reply-To: <20260812104436.109741-6-imbrenda@linux.ibm.com>
References: <20260812104436.109741-1-imbrenda@linux.ibm.com>
 <20260812104436.109741-6-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 10:50:29 +0000
Message-Id: <20260812105029.5E6EF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> In case of failure, pgste_get_trylock_multiple() will attempt to unlock
> the locked PGSTEs based on whether the PCL is set. In some
> circumstances this can lead to unlocking PGSTEs that were locked by
> other threads.
>=20
> Fix by unlocking the amount of PGSTEs that were actually locked,
> ignoring the PCL bit in the array.
>=20
> Fixes: 94fd9b16cc67 ("KVM: s390: KVM page table management functions: lif=
ecycle management")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812104436.1097=
41-1-imbrenda@linux.ibm.com?part=3D5

