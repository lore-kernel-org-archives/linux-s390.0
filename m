Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEBC2877DE;
	Fri, 21 Aug 2026 20:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342552; cv=none; b=oZPx4neW4csO7cB3mYi8xU5TdtdzyYXZPzMX9dyeOsDKYV/hKyqldLElXs3qDhnqrGMPSGO22Ar9+FXnkiOw3foIhBjBu2PihBirar5hPDrc7MVDsKh/bkY7t0JiB3g1z/kmF1/LpFmX8NYiLKazOcVB3X6C0BrnaiTLvjhIcjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342552; c=relaxed/simple;
	bh=QKmXxQH+yI2SorBvpqPMaD5v8meVsFqETCHRH4cDbBM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F4MXNgpxhZjXE7I/ENpPcaiJS+mvjhPWdayTniXXwo0PmGXT1ju3GQvv28UqJO2w+vpegjvkcjhetcw9j7ZThvt/IOGyoJf+tv2SRhY/fPgp/CgTA261VSqQIY6CPj7mBE3SYCMHxiIpoTJkjQXjpMReqztAssAxTrcG8VHaV5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNRWqiyh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNRWqiyh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4873F1F000E9;
	Fri, 21 Aug 2026 20:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787342550;
	bh=HFlzjHnTE4B4oQ8+AIKnE/mkWWCTV0eFLVttI7f+dZI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VNRWqiyhxKsrR3TKo0dIk8MpDdkWCWkL8alsizvWBNfFU6ggXElicYKcNqWMNnZFe
	 fz4QxKv/foDHq98leefWdHSvSEpaoy7t6JbaaHaZ7iEWAtryCVREOtuaZtF1Y7e1JS
	 56tAhLNewVHE0hyxDPNtr9QQArZ8kpfxATWinYDSQM3PrYQp7qK9T/bOi+o0oOV8ew
	 l5/mnBhVguoeaw0Fj/WSWADVHHrJQPnJ0nWErQpz69xz74cYiDk0Oe0Xfdh01wK+ak
	 HjW7I+KfgLRMCNEVLEnoAC09I+rLd5pP5feXHfbRrypWu8X/BBXMJaPGkZ+r4o7t9P
	 3Py8zyLBbNIug==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 03/24] unwind_user: Enable archs that pass RA in
 a register
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260821195259.2688377-4-jremus@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
 <20260821195259.2688377-4-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 20:02:29 +0000
Message-Id: <20260821200230.4873F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Not all architectures/ABIs pass the return address (RA) on the stack on
> function entry, like x86-64 does due to its CALL instruction pushing
> the RA onto the stack.  Architectures/ABIs, such as s390, also do not
> require the RA to be saved on the stack in the function prologue.  In
> particular, the RA may never be saved to the stack at all, such as in
> leaf functions.  Unwinding must therefore not assume the presence of a
> RA saved on stack for the topmost frame.
>=20
> Treat a RA offset from CFA of zero as indication that the RA is not
> saved (on the stack).  For the topmost frame treat it as indication that
> the RA is in the link/RA register, such as on arm64 and s390, and obtain
> it from there.  For non-topmost frames treat it as error, as the RA must
> be saved.
>=20
> Additionally allow the SP to be unchanged in the topmost frame, for
> architectures where SP at function entry =3D=3D SP at call site, such as
> arm64 and s390.
>=20
> Note that treating a RA offset from CFA of zero as indication that
> the RA is not saved on the stack additionally allows for architectures,
> such as s390, where the frame pointer (FP) may be saved without the RA
> being saved as well.  Provided that such architectures represent this
> in SFrame by encoding the "missing" RA offset using a padding RA offset
> with a value of zero.
>=20
> Reviewed-by: Indu Bhagat <ibhagatgnu@gmail.com>
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821195259.2688=
377-1-jremus@linux.ibm.com?part=3D3

