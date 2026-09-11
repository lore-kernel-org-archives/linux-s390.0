Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0FC1A3166;
	Fri, 11 Sep 2026 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138515; cv=none; b=MKLAFNFUnOakhBb9942GfzDcZIDR+caO02W+RmnrYLH2QAZ143ZyGXXlYzv8K8r6fiY8FCBC9JBEnfovOpWwrKPh+k9b4f9rtWgd3D5tGcG5sdr0sQ6fIAYJkS7NPb55ZxJBTtOHdftQGMbCj1DYJ00lHN+l4H0ePyhcac1OhdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138515; c=relaxed/simple;
	bh=ZhmnP4bi6cyNuNeMfS4xcCCWUkcaBmlTFUonXDfqRYA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=niaX18HnpiE5v+4382AJQ5FfNg3w2WIBAXqJRe/1hWCHJC1QUHuj+nU0j8l8aLKqp4TUz4b1HJOdWbQWR88OTqV3nCqzWc1OrPASbRS1HnS2n7JPibXGLNGkMzdW97M3feH1FffMuMaOR8nUjUBjKQn+nTofDukmsXu1D50bG8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fi0pIm/J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fi0pIm/J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30A21F000FF;
	Fri, 11 Sep 2026 14:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789138514;
	bh=ZhmnP4bi6cyNuNeMfS4xcCCWUkcaBmlTFUonXDfqRYA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fi0pIm/JSmA3NHWttIJ8JimtINXjllx/NGDSF0NJLJlW9n9s3s4qwfjO0cBFoDO2D
	 85kMZjx5rIvvxWWh21yQFOYCkX1p3FeUlWwtCVMRPaSKVhGY0N+DUWflMT+6GPybnY
	 KOKD9y4jE9RZjWdvp+sJDzYGv8sisBXQBFrYlu64NoM5PIvjQLf8fsVwbLSD1/GDpz
	 NzTB0revFRk8igvLqbAoXAmqSdmQqUIUa7sTLkHmMyFcCcQr9PJBplsiNbxkMzFSHk
	 0lkveJlKWuP0mb2MeQud24x6omttvOckJueFBbaXsIB7P9mz9PMCI2CeAh1TxJxIaM
	 4ux6shxDGhqjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] module: Limit ELF includes in linux/module.h to
 uapi/linux/elf.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, linux-modules@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260911-module-include-elf-v2-6-954c732975fb@suse.com>
References: <20260911-module-include-elf-v2-0-954c732975fb@suse.com>
 <20260911-module-include-elf-v2-6-954c732975fb@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 14:55:13 +0000
Message-Id: <20260911145513.C30A21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> linux/module.h appears in roughly 15k #include directives across the
> kernel. This makes it a "hot" header, so it should avoid pulling in
> unnecessary definitions.
>=20
> The header currently includes linux/elf.h but this is largely unnecessary
> because it requires only the base ELF structures, such as Elf_Ehdr and
> Elf_Sym, which are declared in uapi/linux/elf.h.
>=20
> Replace the linux/elf.h include with uapi/linux/elf.h. On x86_64_defconfi=
g,
> including linux/module.h alone results in 2.2 MB of preprocessed data. Th=
is
> change reduces that to 1.5 MB.
>=20
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-module-inc=
lude-elf-v2-0-954c732975fb@suse.com?part=3D6

