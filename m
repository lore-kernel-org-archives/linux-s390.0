Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DE5369206;
	Tue, 18 Aug 2026 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065093; cv=none; b=SaAMt6xVjjr1gU8z2NKuMX+bF4/+wlzJ1/+kuja0n6UwoJ/zUoIh44zWZyNj99U0kNm/0RW0XtHltbr7YMNUKdW633A/goXzLIV25F0nkV9Va6UPpfqy7dYSoQDqWXL2VTXnf4TwY/ln3V8wUrRIeoFAuMG4Kw63Nxkn8YasmEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065093; c=relaxed/simple;
	bh=7EKMtaxt/5ffB7M2akLJ/Fqq+BE1rvwsAmeDTFxOssU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g0XAn+3er+kxoyXh0cmrP0EMYVoDiUZ57bTDmdcSCpjdkVduh4Az8WUc537uhP2/frhCDKrw6ch3u7zLi9QZbvws672ftVWRTBCsi21z5o+e5Zz1doMXg9K5CkyRUA8jPBxUrsPeUrAGHdFmdaY1YIYxsRdOaymDKzdiDWFBFD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Li/jOeqA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Li/jOeqA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E1A1F000E9;
	Tue, 18 Aug 2026 14:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787065091;
	bh=HUufDXXOSAPnc+Fh4gWa5xezJy7uKsr0NO8R+HDaMhE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Li/jOeqAm+HNR9G0wZds0v06WXtYlrKj3bGUGTAdk+D98IbFMh6MX1FyNIluo7EFf
	 CqMm1G/UVaCYF5JO9LP8BmMMxmzTbI18Y8aETNjRSHXZ15/F/zTVHJ7JlQcYaVTtFd
	 guxnNHPqPypHm+rkUGPIl4W7/dGdwahKLMTByD4qPFPeL1DOvaEP2e1dtL3ZR3Ra+S
	 qBe8YzGqHqpGcL7RGmZxhuWUWKKWRM4b6Qvqe7i5do9LrvEEUsfCuVVASz3ywjjWP8
	 t4g/WAZC4O009YwSn1UFbrFaqe7CrqmTRUSJqQBySOKdHlGllAoLwNoKlXzf84g97d
	 LdHAdBIG95p5g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 04/25] unwind_user: Flexible FP/RA recovery rules
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-trace-kernel@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260818144954.2320378-5-jremus@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-5-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 14:58:11 +0000
Message-Id: <20260818145811.75E1A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> To enable support for SFrame V3 flexible FDEs with a subsequent patch,
> add support for the following flexible frame pointer (FP) and return
> address (RA) recovery rules:
>=20
>   FP/RA =3D *(CFA + offset)
>   FP/RA =3D register + offset
>   FP/RA =3D *(register + offset)
>=20
> Note that FP/RA recovery rules that use arbitrary register contents are
> only valid when in the topmost frame, as their contents are otherwise
> unknown.
>=20
> This also enables unwinding of user space for architectures, such as
> s390, that may save the frame pointer (FP) and/or return address (RA) in
> other registers, for instance when in a leaf function.
>=20
> Reviewed-by: Indu Bhagat <ibhagatgnu@gmail.com>
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818144954.2320=
378-1-jremus@linux.ibm.com?part=3D4

