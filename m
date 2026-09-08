Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103E33806D0
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 07:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788851170; cv=none; b=PwRwKxQ2Y8DAPsdQ04EDlujj58/kOfmPWKd8Qt3sP8CJNtbY04pgXCwXHA6CuqE8EIgwxS1BVmNKGXClmwYlLFCfc/Cmyz4WzgQzXR7evxA9sjpK6gXwOM7nqOgBN2F4LaR5qQNRWFA1PhaMa4BzU2hvF3G5UwmZsVsk/tiGO5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788851170; c=relaxed/simple;
	bh=iU3WSt25KjssQmxa1n82LUXMJxv1+rqPBTF1WnLDZbU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bfxzeyZJckWG8KWnwzp2TyNr3KEaeRTqvnKeKIV3CpeEGHmk4EYa7WEeLCspYCwZ6nkkwxC8lsaIlKLvoCYJzMzkwlnFGTqfmCdl+RIksPk5LAuDHge2Ju83iTwee19eNVzPq1hPGpldmsDxhflHeHLe2SKMCI+oSugg49sy324=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2GTRZFM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2GTRZFM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF901F00A3A;
	Tue,  8 Sep 2026 07:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788851168;
	bh=iU3WSt25KjssQmxa1n82LUXMJxv1+rqPBTF1WnLDZbU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L2GTRZFMJlr5X/R3UpAvg2RKRXAQqsfCYZnTfPEvvr045jKcGscYK42U4uFuR9EL9
	 XMONr/gds+Jz9/ohgGaPTzri1IbxZIAtE2q07/YLSdUf/UTWL6OaYV59vepHKrCarN
	 hxWPxe3I+0RC3rVYl0UwuP5hDmNEMUvT8DwlWBV7zDEc4QTFiD0J05/eWxRCjMIV9+
	 OY7ytV14UhlGAEiBzR1J00vjVVDaPBvQDUpJoqpKx24EMCk1d4M9hxdDYC2/MI/Okj
	 5Hg/O4mfBVBjrjc7TB4eoeLrTbNCUL9QVZUyLXhldweNmcrX6aAXRMdkjOAqUAktKd
	 3pbEt19M2IN6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 20/24] s390/vdso: Enable the vdsocheck tool
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: linux-s390@vger.kernel.org, ojeda@kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260908-vdso-absolute-reloc-v5-20-3a93791af1cf@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-20-3a93791af1cf@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 07:06:07 +0000
Message-Id: <20260908070607.BFF901F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The vdsocheck tool validates the object files and final .so library.
> It can detect if the compiler created relocations which are incompatible
> with the vDSO which need to be worked around.
>=20
> Wire it up for the architecture.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-vdso-absol=
ute-reloc-v5-0-3a93791af1cf@linutronix.de?part=3D20

