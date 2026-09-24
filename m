Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7B1377AAD
	for <linux-s390@vger.kernel.org>; Thu, 24 Sep 2026 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254171; cv=none; b=JbXnoTAw8sieMzyPUTh2fDsjA12NgB+fjlbrq7KaVnnDsodJHqTpcowOirIZkAFSvBl/EoTNv3lXsj91ZIx20G2+v+LGqVP0HACM5hHFIro5XE1CinlSXK8AcNFL0/cocy2XnjfrSjLcxLtMyw2LyNv2wn2vFFgjr6pTK+Xjn10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254171; c=relaxed/simple;
	bh=mm/RA3MbdbxHQUNOrH5jFy16V6zWLg7CURTgVkxqBq4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bFV69VwLG5mSv2AonOASCgwg1+6dvN0SpMQPrEcWRY0PrLWcBQIhcfNWq8cd4INuF1fCl1aWRWtWVOWv3Qt3LFGfQpnSbvDBPdO6790fNJuAxVJ5VQCuVT8Eq6UTcXV3bKIXuMEnu4DOwSmFPl51t6dzs2b6GtC0z4H9/OaGzr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtZ6mw1R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtZ6mw1R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CC41F000FF;
	Thu, 24 Sep 2026 12:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790254169;
	bh=mm/RA3MbdbxHQUNOrH5jFy16V6zWLg7CURTgVkxqBq4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MtZ6mw1RwePnij3UqX7ibCbsW5FXNmkUzx2HeuA0RKzFb8a4dnv4tBDXA4VrNKRCr
	 m24mZmSQ/11Mtg+IT06rt3dlMwj6c2R2q/swlv31irxotZ2XHCc7/apZ4rv3JYgyja
	 8ubm2hD7cT5NwnZnL3uhjx+KVi2FNroHtRlmZrhy47pgT9CPomUgRBcnUEsfWx5vTB
	 JI1zt58ZvOnCWdMyq+AsvYGSIRtN7IleeWBcAWCZQOjNNeqLUS4p6uoGP9DnLcmgxV
	 IVPJc6qtNIXZhO/e7BXi4qZiJyOPPtS3W7SdbflgPn/9M3E+dCg97oKmzGMZlR5nwx
	 2xkSOpLvr5dwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] ORC: pull out module handling from x86/loongarch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Johannes Berg" <johannes@sipsolutions.net>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260924144039.1f625ed6f732.Ief8583cee373b18ea2151118373ff3d8ab73ac60@changeid>
References: <20260924124039.1621965-6-johannes@sipsolutions.net>
 <20260924144039.1f625ed6f732.Ief8583cee373b18ea2151118373ff3d8ab73ac60@changeid>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 12:49:28 +0000
Message-Id: <20260924124929.67CC41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Johannes Berg <johannes.berg@intel.com>
>=20
> The x86 and loongarch code for ORC unwinder are just
> copied code, and I don't want to add another copy for
> UML. Pull out the common module section handling into
> the regular module code to reduce duplication.
>=20
> I used the x86 version, but loongarch is identical
> except for variable declaration order.
>=20
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924124039.1621=
965-6-johannes@sipsolutions.net?part=3D2

