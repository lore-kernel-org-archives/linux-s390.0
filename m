Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976882;
	b=HKiDgMcZdc9gnlVInZAcZf3iJKwR66F79xEh6agphmCaIv7X/YyQnsWcJpOGioznGFMK
	 6UYGmyTBvuNshOZraNRWhhSi2x8O6+ONn1olJbamVCDgXb3sF8Iby/a2Ks/Cpg5N/QWsS
	 +afXg2hI0huY2aVXKUEEkzW+SHBLnglAHT9eibUW7PqvSEiyLuyccP7XDyNZb4tDKWYd8
	 P1vNt8r5XXouy7+VCnKieKt0IH6lJcjbPrEnPANIZCzpAL72hh63YXeg2bLG/u1BDFg8B
	 SvnlJYTBMZOna9R8Q1TBnfDLmk5y8GD6zlyj6VS61jQi4pI8v2mZnzg3BCJ/eKgXl7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976882;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZMdjumYXDl5RgqVJl4+LfUpD2v9DOkyCDQnFVlrFRtU=;
	b=LaGnrw+Uq2TU8o1DTRlg9VlfoJcl+vI2RsARF8SFGpt5TmWgPh3tjy0RnFUSIsp0jB+m
	 SGC1yl59lkRjowzzD00pMLdsd1giw4k47niYnBHnCRuN1M6XQqQ1LNt5PCy/bpcgYqP+p
	 asxvGXaqoYw10lo/vZWAeCVib1c5q7kPBZ2aZh12wCd/X0mEb1qegWI/Zuol18LiAzQ97
	 TzoI+uvJ4WtwobM3OiYl8dQ/0lEc5FUT5OEWbAUgOKGQoANqBIgP3aHFEyLS3xcoJmgfh
	 QChDVNvWD+RYCRRVVVW1gado7+I6xO2xBXlTpUWV2S55nT0MbrXv1cTmTL+LqhauuXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XoOB0nfN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D828606A326
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XoOB0nfN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB371F008A1;
	Fri,  6 Nov 2026 14:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793976882;
	bh=ZMdjumYXDl5RgqVJl4+LfUpD2v9DOkyCDQnFVlrFRtU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XoOB0nfNbj0Oom8ASVItsRveL83TxqFGgZmJX8cXyXoSyWePnr6QBQ+RfKnvOlauT
	 CuuoP7Eal9EQYhngQkYwHYjBXkox0xTzSytJ1CReQUEp/CGlybMp3U1yzZHMD6WsnT
	 Zh8maLOVuE/pQLU5fkqplPpHFlGdBkP8Spiw5HT5HVqllXFkAwozM0k17NGrjMuDjK
	 bcHBZaAxvSthI0KQRczV0Vlxm6ASVk4fqnEM/pZ3cyKb0avwsfC1Hdj3eILFQGHKgm
	 2YGq0ikBJAMLj5L5Ady/lNBaJwFrl7IYNwPRkOAAWOM/Y9Ysrt/HNErtgynwa+/5WH
	 +nfvx/3cKf17w==
Message-ID: <sashiko-outbox-201625@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/15] lib/lz4: switch the HC compressor to the
 vendored sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106-lz4-vendor-upstream-v2-11-ee04c3f0d7dc@samsung.com>
References: <20261106-lz4-vendor-upstream-v2-0-ee04c3f0d7dc@samsung.com>
 <CGME20261106144306eucas1p17d110f5e01991516acd49252f81845b2@eucas1p1.samsung.com>
 <20261106-lz4-vendor-upstream-v2-11-ee04c3f0d7dc@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 14:54:41 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Replace the forked LZ4HC with thin entry points over the vendored
> lz4hc.c.
>=20
> Upstream routes levels 10 and up to its optimal parser, whose ~64K
> workspace the kernel cannot provide. Clamp those levels to 9 rather than
> reject them, so existing f2fs and zram settings keep working, and add
> LZ4HC_CLAMP_CLEVEL to <linux/lz4.h>. Document the clamp in f2fs.rst.
>=20
> Levels 1 and 2 now use upstream's lz4mid: on kernel source they are
> 50-84% faster for 4-9% larger output. Levels 3 to 9 compress the same,
> but at 4K are up to 15% slower on poorly compressible data, including at
> level 9, zram's lz4hc default.
>=20
> LZ4_compress_HC() and LZ4_resetStreamHC() check the state's alignment
> like the compressor's entry points.
>=20
> LZ4_streamHC_t becomes incomplete and the macros that laid out the forked
> structure go. LZ4HC_MEM_COMPRESS grows from 262192 to upstream's 262200,
> static_asserted against LZ4_STREAMHC_MINSIZE. lz4hc.c pulls in lz4.c's
> decoder tables, unused here when the fast decode loop is off, so silence
> -Wunused-const-variable for this object.
>=20
> This retires commit b08918fb3f27 ("lz4: do not export static symbol"):
> the glue exports only the five LZ4HC entry points.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-lz4-vendor=
-upstream-v2-0-ee04c3f0d7dc@samsung.com?part=3D11

