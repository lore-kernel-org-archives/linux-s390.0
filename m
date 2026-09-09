Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9EC3B2FCC
	for <linux-s390@vger.kernel.org>; Wed,  9 Sep 2026 09:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944478; cv=none; b=muW0ftV5V0GXlhgqwS4WaQoA/zeKvOJBMj/UAqafUfgD+g8lidSigSZl7NMJnPtv3Petq57rx9zyhlBK6NuU0yAqq9a4lFwycoBpUZUnSKxJhdNJGeDmPuU1GqQbdEsM2zN8yjwSu5qg0ynh3PZRt5JynU4t3PBQ2oDcJ/6U3X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944478; c=relaxed/simple;
	bh=XpuszgJsdzmsEn2buNKtP9+hIfdBByxb7xeWmoVSjkA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QLceG+g6hRu4tdZ/8h/6uCzH0mgt+45fjOZfluc9h0yCe1K/k3DTBI64oPKGW3LcR7ocJp+muJ/ZjQAMAwbl8Rc+eHKpA/LKmgDRTb8qbfrGk4LhG9f3zogUJhrmD+PzKfKU5+ic1P6kceYMGMgFBbtjYUY0WN6mzzZlwT5K6Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmzCyrSG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmzCyrSG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B4E1F00A3A;
	Wed,  9 Sep 2026 09:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788944473;
	bh=XpuszgJsdzmsEn2buNKtP9+hIfdBByxb7xeWmoVSjkA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MmzCyrSGr9gSb3qLW4Q22myenbeqgxeYv2gBSxzwChBRrMAQSkit+Yh8kpci3h/5N
	 FGJAikXc9N1Uy8XMZBK6lhoI3ec9KUlNGOoy9gtYqof7tTORzvxruVX/mryaL3lMYW
	 nsqHva8TZdSmWVJXmV22qz3phZT/E03//wIfllBUZ3bYg7BomfHBrbKATQz7lsvhbE
	 OzwLPHfuzDxjaczM/WHexuFlenQUJ3wbOIfj/x6ZZtLrCJN/sONMFaT/JDrrwQ3WEo
	 hG02W5GpQNgBjU5KlshqqHuCVPa+jpEG5/NJ4+WuM7S3lTAgrtyW+IiwfGJBL3u56W
	 5g+cU2Yzy3GuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/15] sparc/vdso: Move __VDSO_PAGES to asm/vdso.h
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260909-vdso-asm-generic-vsyscall-h-v1-7-63ae856cc659@linutronix.de>
References: <20260909-vdso-asm-generic-vsyscall-h-v1-0-63ae856cc659@linutronix.de>
 <20260909-vdso-asm-generic-vsyscall-h-v1-7-63ae856cc659@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:01:12 +0000
Message-Id: <20260909090113.45B4E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Most architectures define the __VDSO_PAGES page macro in asm/vdso.h.
>=20
> Align the SPARC headers.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-vdso-asm-g=
eneric-vsyscall-h-v1-0-63ae856cc659@linutronix.de?part=3D7

