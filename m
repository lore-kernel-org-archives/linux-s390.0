Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C62423E9F
	for <linux-s390@vger.kernel.org>; Fri, 25 Sep 2026 11:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336629; cv=none; b=rlo9XUmhyJnGvbJMK2pUlZeDGUQFKf9GL+BWW989IEeXswWSBJ1Z0Y3mOTaLh5SuiG5c5JS4DdIdP8SoraalMrBTPCSwt2IXMOWQEIgsQkPqMk3pBBJ5wr/dNhDP6EZ+EVzVWQTj+W0WizXJDJSBJXZ7Zcg5POG4Z2dsGZWFXIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336629; c=relaxed/simple;
	bh=Mc1QexEYE7/xAZ4XvkEdf0auTM05TQEBtr+Twc3j83w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BSJVcyKb8ZsrMk/FRuD5whA7R9U8663+BuqH6JEYYy94pYsa0BrwFIBiQ+bHtA0KgrUgay0qCvLpDnwYG5Jk+SMUr7JRdrZfIsjxBOMHAYnu2bJxusTdTcdATDJPQvBC/Pt+SL2YuMr2bqJoELKhZ0p+DdbpHGx7GcY0im2+J2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoPUCpDL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoPUCpDL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73BC1F00899;
	Fri, 25 Sep 2026 11:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790336628;
	bh=Mc1QexEYE7/xAZ4XvkEdf0auTM05TQEBtr+Twc3j83w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MoPUCpDLIhjD8U4s3o3mtrHx4sIdjn5cH5J6BA2erxgV2Y32Wy6sASiY+07UN2Atg
	 kNUyJzRtFZw9Uyu/xjE8OmsUM4Rqxnjl8mLuPlYd+WveOtA6Ubsaup41sc27Y5ulr/
	 IhmD3jNvHUuCv6YMqenZZl0i+r3NqzeJka+bMjt+v+PX+KCvF+u3h69xKxJp+JAemb
	 im7CTKcXWayBXQKiJUc931R6/Vi6AEevzP7JnxDCGNz2aRd/ropdKv0NVfaQBYNw0f
	 5rjhxjVmJXgrtRfywd97w2t9xugEGyLo2OD7eu5hGnWfk2ZOL7kr94vT7LM3euv+fU
	 Yer+H+Vq0eUDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 5/9] lib/lz4: switch the compressor to the vendored
 sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260925-lz4-vendor-upstream-v1-5-1c7ffbe21c4b@samsung.com>
References: <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
 <CGME20260925113500eucas1p1b8c2b9936e936f393b295efb2ac61c51@eucas1p1.samsung.com>
 <20260925-lz4-vendor-upstream-v1-5-1c7ffbe21c4b@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 11:43:46 +0000
Message-Id: <20260925114347.A73BC1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Replace the forked compressor with thin entry points over the vendored
> lz4.c.
>=20
> LZ4_compress_default(), LZ4_compress_fast() and LZ4_compress_destSize()
> keep the trailing wrkmem argument and forward to upstream's *_extState()
> entry points. The rest are plain forwarders.
>=20
> Compressed output is not quite bit-for-bit identical: it differs on a
> small fraction of inputs by a byte or two, with no measurable change in
> ratio. Both implementations decode each other's output, so nothing
> already on disk changes meaning.
>=20
> <linux/lz4.h> spelled out LZ4_stream_t's layout for the fork's benefit:
> lz4defs.h included the public header and the fork read internal_donotuse
> back out. The vendored compressor brings upstream's own definition, so
> make the public type incomplete, repeating upstream's forward
> declaration. Both headers then name the same type, which
> lib/decompress_unlz4.c needs since it ends up including both.
>=20
> LZ4_MEMORY_USAGE, LZ4_HASHLOG, LZ4_HASHTABLESIZE, LZ4_HASH_SIZE_U32,
> LZ4_STREAMSIZE_U64 and LZ4_STREAMSIZE only existed to lay that structure
> out, and go with it. LZ4_MEM_COMPRESS keeps its value, 16416, as a
> plain number.
>=20
> Callers now allocate LZ4_MEM_COMPRESS bytes instead of
> sizeof(LZ4_stream_t). Every caller but zram already did; zram is
> adjusted here.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-lz4-vendor=
-upstream-v1-0-1c7ffbe21c4b@samsung.com?part=3D5

