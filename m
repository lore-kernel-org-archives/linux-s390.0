Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9772837F739;
	Thu, 30 Jul 2026 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785429849; cv=none; b=K1u6eF8+4dIOzqbtDdZqMZw2Vip97tnfUBQLR1CjHXN4WYTU/KwkiDRUQkMuJbbVm2vcKzHHZxuzInNayGUV08kgU4vmBa6sx/QRNZTEUGjrFOU3v+6ARveG2cEhaiTX40zr31Kuziq/wKxStrbKV2VeG/nz9IXdcFhMWkRBnEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785429849; c=relaxed/simple;
	bh=OBwctwvOMBrTiWRjBccdJbUZ1XOA2c8GhDeTrCud9SQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eQo0oauNEm6IeCw9DyvcDKT/ZpLAx8nEj+l87Bpd+ki6W+PCmHoyhnwaq/ag3nLqGI/9AnxGAra3X22Txtg5u72BfX5RS5xbRbgJzwH5T5R2b5C9yHCae9+8JgFJ6y9mq6834VcB8yeZG3+JQe/jAdCCXYCWANvqTnfdDb73EtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ak8euGv/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ak8euGv/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B631F000E9;
	Thu, 30 Jul 2026 16:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785429848;
	bh=OBwctwvOMBrTiWRjBccdJbUZ1XOA2c8GhDeTrCud9SQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ak8euGv/dABm4oe+DEXujIbtPbA0NQG+B/7Y5/8g4zz+pVo4TdCP+xATSaU07Ac2o
	 yU5aHv6LnoIuDP8Sp6j5SVmPuyIVvsA+ZunQhIO8HSMe86F/s0H/JRA7qe+jFHCKGV
	 VzyuP5eS/caPps0NPQEU79Jw3F3cCL83IJc37yrI51cEE68lLZnXG/yQZOn7l4ObhH
	 XNCzwZIqlm6wpmgWwHX6pNqLUpphbL+xbs3fP8ZFl2cwFh+h5JbLvJ/AkxoPBaot0k
	 Z0v8nFAsQGX3RHby1zPExwOn/DkFUykbdIWBds1OdR1qd/M/ZZzQzgC18Ff24ZE4XQ
	 eFodIPTD0aBAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/14] KVM: s390: Free the mmu cache when
 kvm_arch_vcpu_create() fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260730162714.133327-10-imbrenda@linux.ibm.com>
References: <20260730162714.133327-1-imbrenda@linux.ibm.com>
 <20260730162714.133327-10-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 16:44:07 +0000
Message-Id: <20260730164408.08B631F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The mmu cache is the first thing that is allocated in
> kvm_arch_vcpu_create(), but in case of failure it was not freed.
>=20
> Fix by freeing the mmu cache in case of failure.
>=20
> Refactor kvm_arch_vcpu_create() to use scope-based cleanup instead of
> gotos.
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730162714.1333=
27-1-imbrenda@linux.ibm.com?part=3D9

