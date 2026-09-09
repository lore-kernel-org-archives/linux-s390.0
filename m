Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA8037E5FD
	for <linux-s390@vger.kernel.org>; Wed,  9 Sep 2026 08:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944098; cv=none; b=XtGderJcKHrrrV5jBoB2d682TzwFgSnGOoTBWS+SqqjAxIjeNCK3K7+D67zPloJgNM4OI24ldjYuYzwVW7k4qTpdbxgG5nWQL4lBMAik1t0mjZletZNU10yWPJZKeJDMLPXdg9qbPDWGeLl+BvgolehtO5GT/EOypI/XiQbB5Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944098; c=relaxed/simple;
	bh=AWBcsfRmIj7of+aHPtj2h0g3zhMJRQfUh1OCFnXt7Yw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KB8EAIYqnczs08giYn1CnIQxuOllW8JWAuZZ2ldaQtyGa9+9TjWdHxFJCiHFDUc4B4dOWOXLweUzYF1F9JWxZSuRa0c0PiHQbchWIOlTRJv3Ky4s95zNvN6VltZtjzcciO2sKocfkYSmaosYXpR+Hx1PANJNG9rYtWVWBbDZ2+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yry2/k4N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yry2/k4N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94AE1F00A3A;
	Wed,  9 Sep 2026 08:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788944097;
	bh=AWBcsfRmIj7of+aHPtj2h0g3zhMJRQfUh1OCFnXt7Yw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yry2/k4N7RSvcfQyuZwXp5JZBwRDNtTGF46qjgoXR4gsswcRqcFIO9iAOHQ3uMDDJ
	 B69FKDS46zwPvdQS1yQwtdtVUnfS8TtzzvoBvTr51FS9EOa34JUi6lhk4Sg8tzRzDc
	 vp5gZpUhVj88rLUXLU7nrzwE77U+4oJd44tlZLAeCz9mE2hSVl3odKPV3Sg+rdUpgb
	 /a0W7R+7c0tFItn4QoWLyQMQUuNMpL1BUJPucjyGvh/EesuVYyS/dHTaZLg89W2xvg
	 1WHtUZ2kFxMdLboShzFGsl6nce6pPigumZPMv33NfL/tx6md8hzXQ0OwVesFGcDTVq
	 6O/mUeFiXbo2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/15] vdso: Delete asm-generic/vdso/vsyscall.h
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260909-vdso-asm-generic-vsyscall-h-v1-5-63ae856cc659@linutronix.de>
References: <20260909-vdso-asm-generic-vsyscall-h-v1-0-63ae856cc659@linutronix.de>
 <20260909-vdso-asm-generic-vsyscall-h-v1-5-63ae856cc659@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 08:54:56 +0000
Message-Id: <20260909085456.C94AE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Recent refactoring have made the header empty.
>=20
> Remove it and its mentions.
>=20
> Also that header was never a real asm-generic header anyways.
> It had no reason to be in the asm-generic directory.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-vdso-asm-g=
eneric-vsyscall-h-v1-0-63ae856cc659@linutronix.de?part=3D5

