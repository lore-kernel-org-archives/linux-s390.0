Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D81230DD10;
	Tue, 18 Aug 2026 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065056; cv=none; b=BOQaEBIEr038hZYSZ0RZvN11ZWJ8mYnubQ0H49AnrG3Rkf391xp1VxzsZv4sgLsFeMyj9OWRNnVOX/19SGq26i9vwr48Sq1xRgUCx1XQOzu0KwmRix3ThCenAtWBuyOsmgL7WxYS69ROuL2gv7DW/qYz9vSZB6cM0qG98Q2mdr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065056; c=relaxed/simple;
	bh=2arL0F2ECWlJkjWCpnJulwnrA+LEqqhfJELQ1VivG10=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aCxV0jUjh9X8Dt/N+uat3MUSH6LwOM5Jkf2KOS9uVdVep9xLeWPOC1ChPuA4v+HGGROm0bCfcRpR7XVLXtZglkjGMBQe6/e4iw9ZjFrtbV4mGuDZDRtPJl5A5iqn8l70+ZVwNTqmoazn3ehaVM8iZT2ayXeU8Pm8P7tVfbpAEX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxt0OngW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxt0OngW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5ADD1F000E9;
	Tue, 18 Aug 2026 14:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787065055;
	bh=YdqUqWZUBav86LMF1u57xEiZtN0Sxgbt9YFutSxX3Cc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kxt0OngWAsP3DbCNMojC0BR9g/oTHFiUbHdtc5fpCesK9aADGQzTTp2fiuZp3m9pq
	 KOnWjLjNwz/jiQ0Z1s4kKbPKHfZndxtrGekP58WDMeevpTmSwV5gVTPM0sdR7FKwFc
	 kgC3b+Z9h7VP0LIahW0rFWC+UEFOISB1pNOtd912jrpmfLcFCjJ4jHRPSNBkzQXW8i
	 sHFj8z4Ynoe1iENYWd1zurDIToejSourHal1/HfInR1gMic9mqCyLZmBkIM8kJxfbD
	 ot0DiW29RdNgEVPHRpWhh4tdHi1MMmUqw/1dscPlJ1fzXnGkKSQUCB2fUsQOiV6jzN
	 BHoEdRcJNFEZA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 06/25] unwind_user: Enable archs that define CFA
 = SP_callsite + offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-trace-kernel@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260818144954.2320378-7-jremus@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-7-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 14:57:34 +0000
Message-Id: <20260818145734.A5ADD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Most architectures define their CFA as the value of the stack pointer
> (SP) at the call site in the previous frame, as suggested by the DWARF
> standard.  Therefore the SP at call site can be unwound using an
> implicitly assumed value offset from CFA rule with an offset of zero:
>=20
>   .cfi_val_offset <SP>, 0
>=20
> As a result the SP at call site computes as follows:
>=20
>   SP =3D CFA
>=20
> Enable unwinding of user space for architectures, such as s390, which
> define their CFA as the value of the SP at the call site in the previous
> frame with an offset.  Do so by enabling architectures to override the
> default SP value offset from CFA of zero with an architecture-specific
> one:
>=20
>   .cfi_val_offset <SP>, offset
>=20
> So that the SP at call site computes as follows:
>=20
>   SP =3D CFA + offset
>=20
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818144954.2320=
378-1-jremus@linux.ibm.com?part=3D6

