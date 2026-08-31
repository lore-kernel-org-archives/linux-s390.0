Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBF5470134;
	Mon, 31 Aug 2026 18:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200340; cv=none; b=cxOhaqIEbEwCnJHOYEeq/Dws+JcY/hkoRPxbI9AwXJ0BtiaoIJcBF9kii7TcFO5W7P9cVXjXi3pCwccCaQc++Jfe0RY4LhOAELk5/7r7fKgFWilBUOKxZEJW8i5qVQH2b13rwGu6q7i7XpQqhWRwXBnKuuBL1QOK9l55dJQtjgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200340; c=relaxed/simple;
	bh=b1vEMa85yDPUmCDPVCI381nZR5OusD2MYjD32IZwKVo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Agv4izRuoJo/oi3sEwNUDtmW8YGzDmazWHF76uhtWOPQjgURrMO0dPmt4CIzXUSCqhOHUcEVvkt8KOVowgW2Wh+6RX4xJutWAtf0weLF+e7l83F16QhlKrS5UefnXyVkLmGn9q2qP/Dytpg6JagWdMOtomHPwM4rNH2H2Gxb0c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHPbIi4E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHPbIi4E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697B91F000E9;
	Mon, 31 Aug 2026 18:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788200337;
	bh=SRiA0R1qPyKOjs4Zr+JnPGwkt8WwHwHAIu4gQo0q2Mg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IHPbIi4Ehy0WrzE6lc1Ja5MeYbO0TYiAyK5FpPe0arnSEAJ7TG0cbIQugFRSwpi91
	 LJmGOosv1/lGvnJc2oxbyVWv0tWb2opvDZeYwt0wZrQ7y624pleVI50aWEz0sfmQ6J
	 t2ERUr+0Xbfd5JNTTIZoKxxn/UjYiU7MNeXhVrqSd/VfEfjDXrdNtsbSCeTiQkaBuz
	 jddVsgc4M0z5+yZ8QZpq/cfFc6YByXZ3K5xz6Oo66tfUItq+6lslPvRqEbXxvtmCMU
	 wzLu9TyCIkeOr3XkVjsKNwLb3r87eCbyov7dwlx6iwe+sJfkkTLqVd54aGtU2sdKLY
	 w5zTavT4kPXnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/20] arm64: sysreg: Define OSLSR_EL1_OSLK_MASK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvmarm@lists.linux.dev, "Heiko Carstens" <hca@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260831145536.913567-4-seiden@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
 <20260831145536.913567-4-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:18:56 +0000
Message-Id: <20260831181857.697B91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Typo in the commit message: 'OLSK' instead of 'OSLK'
--

commit 834d9af2283801afa096e24f8b7cc277f61cf317
Author: Steffen Eiden <seiden@linux.ibm.com>

arm64: sysreg: Define OSLSR_EL1_OSLK_MASK

This commit adds a missing mask definition for the OSLK field in the OSLSR_=
EL1
register to allow safe writes to that field.

>     Define the missing mask for the OLSK field of OSLSR_EL1 which is
>     required to safely write a value to that field.

[Severity: Low]
This isn't a bug, but is "OLSK" a typo in the commit message here? The
architectural OS Lock Status Register field is named "OSLK", which matches
the newly added OSLSR_EL1_OSLK_MASK macro.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831145536.9135=
67-1-seiden@linux.ibm.com?part=3D3
