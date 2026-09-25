Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF2949B5B2
	for <linux-s390@vger.kernel.org>; Fri, 25 Sep 2026 11:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336602; cv=none; b=mvPEK7+rJcyvOhZMqnGqbLXNGsAx8Q7rn1boZtC0UNDGdTNJnZNfp51CC/e+hWYgZdIxSUAvp8gGFGLDuBfP6BeTj/UpX/Fx1ayMldzJWBqvA493Yksy7XWdDqn70fXPv/RQVi+y5QsVhMJx8eRXJH/00bgFDPSTUvyX+KAt53o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336602; c=relaxed/simple;
	bh=XqSPD+c7TAKkwoiVwGMeoxt+wDUx+9Rj4+Yda/oyC5g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XSAlP3u1frm2veHEphdE4XYeDFxXdt/cErEqFvq3mSc/oAyFWXUohFl/s6YZu96mYXyqqyrAJT+bh8xbvjbQFztpumntkgLerO88cZPQ2cBgkuH/A8GxDwBDnxKwav2hd9FaMEs/ylNLLI7o9UjUo01Y7WJ7ZfJn/u5waNbpnQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XumDG+O7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XumDG+O7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6791F000FF;
	Fri, 25 Sep 2026 11:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790336600;
	bh=XqSPD+c7TAKkwoiVwGMeoxt+wDUx+9Rj4+Yda/oyC5g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XumDG+O721q02nQEd8ah5hmse0cRJq5mjxYB6gYEf56yNBPNX8Ck0Wr7W2g6qq00K
	 qjEXOTdqs/WoJOAq4JH+wybO4F+hxtwDWyfQZNJH6farfn/vjY6TNqOjpUEb5wfSj0
	 q7L0I2Lf9g8npWf9fhK3htgLAwfdfG+nlsvZYoDi9d1BXDsRuYeqkD/zs/CxiCv3Tw
	 9HEz9gSDnLtOxeaL29hgvJKK4dMALjTmGmU13CBYyJHSCPJQ8AU9Cg9j4fEKqvKU4+
	 KITJAmmWlO0eNx1CmUi9M8/JR8H/80KV0S8tUPq5vmw3ZHeyD4w0nfuSv/7ITG3Flv
	 iQc4uV0KWQuiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 8/9] lib/lz4: fold lz4_kernel_api.h into
 <linux/lz4.h>
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260925-lz4-vendor-upstream-v1-8-1c7ffbe21c4b@samsung.com>
References: <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
 <CGME20260925113505eucas1p22390762781266971ebfa0279f09ef838@eucas1p2.samsung.com>
 <20260925-lz4-vendor-upstream-v1-8-1c7ffbe21c4b@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 11:43:19 +0000
Message-Id: <20260925114320.4D6791F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> lz4_kernel_api.h carried its own copy of the twenty public prototypes
> because it could not include <linux/lz4.h>, which defined the stream
> types that upstream's headers also define.
>=20
> The types are incomplete now, so it can. Two prototype lists for one
> ABI is a drift hazard: the entry points were built against one and their
> callers against the other, so no compiler ever saw both, and MODVERSIONS
> would not catch a mismatch either, since it hashes the exporter's view
> only. Now there is one list.
>=20
> It also puts the public constants in scope of the entry points, so the
> size assertions can name them, and the HC level clamp can use
> LZ4HC_CLAMP_CLEVEL, static_asserted equal to upstream's
> LZ4HC_CLEVEL_OPT_MIN.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-lz4-vendor=
-upstream-v1-0-1c7ffbe21c4b@samsung.com?part=3D8

