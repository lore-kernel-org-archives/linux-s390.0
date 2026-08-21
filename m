Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E35282F1F;
	Fri, 21 Aug 2026 20:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787343353; cv=none; b=FcnlLK/CpQCm/mvWk3insGFKY1IzuIACpteI3kxre8mpecoHv2pr3PMiz3pYPHJ5OMB1q3yN2t35j9hbqbN6+dJ8wVYCWRQKvRkE3SLNQqD1iergnHKEm5RWBBURVxad/9RPk1fzifalCf626PnNDsJQU1yhBXFK8V2VIzZbwq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787343353; c=relaxed/simple;
	bh=5ZrL+QR2CEiKk7l7aEXODk1nYrTHEV3j6ZrXDmc2DQc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MCJbyQhTecPFWSb221AAosj1Dp3o0aQ2wearjZCWYxK7U9n5XoVxn3WPR8iMSJn2pXb64G1dRUdiDSArR8L3xcgOuABTiab3T2xLPFaV3qodgwDMFpEHYW2l4Kxk/0JWpNxVCC3K21eO/h8HJ1/lxTZDcSWVvdR5u5I9kxykKmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0vkIVH7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0vkIVH7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0731F000E9;
	Fri, 21 Aug 2026 20:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787343351;
	bh=qmEiVJtfXgo1Hu/l+k/SME4B/ur9/ZkBVR1ql11MfYY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n0vkIVH7BE9ZldGC/WL3mtPEkpNw/Hi8tixuzIIJe9U/6Yc87Gzqk7Jt/QwdsHPQY
	 5uYlht98kdvG/D1JdVrZDQt3mMWxJpiX20DP0G5jb5wQjC2QuDu1+TLD3c8cTNL0yp
	 aDwod44O0HmQcNCtsMJx+Awq+ciJe0TtbTToMj1yhJHGP/1ZhuYs+OPcGtiPRGOylG
	 6LJgNBj9h5RV00aCldz5Yzb/GfhSZ/QNPKZv92wQgSlfBRaimIFSk/4US5G7NsVKkc
	 w3iNXtNGPyOZh/K+ExnwHo7wgxb1c8MxmFgAPgDuSobE3O4J5uO/r3sEPx1YZOACqz
	 8qDbFfSmhFKXw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 23/24] unwind_user/eh_frame/s390: Enable eh_frame
 unwinding on s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260821195259.2688377-24-jremus@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
 <20260821195259.2688377-24-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 20:15:50 +0000
Message-Id: <20260821201551.4A0731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The unwind user eh_frame implementation works well with GCC and Clang
> generated code on s390.  Enable it.
>=20
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821195259.2688=
377-1-jremus@linux.ibm.com?part=3D23

