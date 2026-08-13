Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42862F8E93
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 11:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786620340; cv=none; b=Q43UO8kyVxc5F6fGOenCGzUdXIBTr4sQBOfjlAl5eBM77dP9dGcXS64820f3cnVzV/futTTa3kblhNirwjyM4GGTu4b5Ocr93daURQr/sKE6TbszOD3bSqGZlGjI+Ac1jKtLHp5jmVd3mp9A9nCi6tPkga9mHwENgVrRVHrnvbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786620340; c=relaxed/simple;
	bh=yQn/4uQjYE8XsQ2owLrgYev9++SdBjgq4TTdovqmX9o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HRjZW1rZNwZIyVbj0W5bnYl1A47xXoholEjMdgDkLCCFtyJxwrk7gfjvAX9ky3Pe74xigwP72hJBhOnhpRGDZH0WNmZdqHLv7XCLKpDF/AsCuAT0KwJkxTs5qX0WvGlEjprC8fxwIOzx8omBQWbWhL3PPxAt+azriOmc1nSJ6t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5n1peOc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5n1peOc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B841F000E9;
	Thu, 13 Aug 2026 11:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786620334;
	bh=yQn/4uQjYE8XsQ2owLrgYev9++SdBjgq4TTdovqmX9o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m5n1peOcKOfUvfPmaCKgpu5JK9NMRupushCTu0qpRhrOhxrrZg3FV2cKNpL/Lu75Q
	 f6HL2C8UmWOGjC6fHuLXHSoNC6mV/27VgTkloJbee2UcqUNN/EnRqhTNEEKsz9G7li
	 VOiOpZJAKoN5zq/pJLegGZw0SJSyqnWvKSBwKE4ol0dHvOlvYPOB9XQw7hNnUq/ZKW
	 b4sLL79K6iPWr6OwW1EIeSTYaPLNvmG8WuLzJZYeqO/3kRwQD1EHpNu89G4gUBsxcd
	 UWdlsWBXSQPnmHb2L+wuZo8Uvv/HYgHZaiu9NygIFehdov57I/6laCihk3GOlwcFLX
	 O8mBP6ZITxQWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] s390/ipl: Fix NULL deref in dump_reipl without
 re-IPL parm block
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vasily Gorbik" <gor@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <p02-02.g6f5dd41a34f4.ttjpfvt@ub.hpns>
References: <c00-02.ttjpfvt@ub.hpns> <p02-02.g6f5dd41a34f4.ttjpfvt@ub.hpns>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 11:25:34 +0000
Message-Id: <20260813112534.89B841F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Unlike kdump, which passes the re-IPL parameter block through os_info,
> the stand-alone dump passes it through the IPL parm block address and
> checksum in lowcore.
>=20
> Some IPL types, like HMC FTP boot or QEMU direct kernel boot, might not
> provide an IPL parameter block. In this case reipl_type_init() selects
> IPL_TYPE_UNKNOWN and reipl_block_actual remains NULL. Nevertheless,
> dump_reipl_run() unconditionally dereferences it when preparing the
> lowcore fields. This may happen to work by chance when address zero
> contains readable lowcore data. A zero IPL parameter block address is
> then stored in lowcore, causing the stand-alone dumper to enter disabled
> wait after completing the dump.
>=20
> Explicitly store a zero IPL parameter block address and checksum when no
> re-IPL parameter block is available. This does not change the behavior:
> the stand-alone dumper completes the dump and halts, while valid re-IPL
> parameter blocks continue to be handled as before.
>=20
> Fixes: 099b76513992 ("[S390] Automatic IPL after dump")
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/c00-02.ttjpfvt@ub.h=
pns?part=3D2

