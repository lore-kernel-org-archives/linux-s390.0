Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6561D345EDC
	for <linux-s390@vger.kernel.org>; Wed,  9 Sep 2026 09:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944566; cv=none; b=IktFvOkQsZoiIz4oQeXYzrF2ItY8cU83VFULQbIMMCvCvPwwgRMl/Qty7nDK34sh+NsHxJaexAxrmXr5PnZTf5gKQWrhkuXOBVxgExt5MSszZYO6Lk7NobED9X4c8p96TkNaUw49y8DSZZ5n2Ljvyt9APfhG/L/9IIt2pd/QPBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944566; c=relaxed/simple;
	bh=dah9W42S06RhAIuRe0XT4JrPgbf62fj1c1vNtWqavSQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kRJeIrjtAXFzQ5nX4IzNMcf8ePlcNkTENPAzza7T0q63wzKXTrebza1Str/tq9L3B3Mjhd53F7DeZaU7ROgvmLrNnKEkgAqtDPfJWITaH+PHK0KusFCH37PolwvYvzZ7dxNqcLz4lJsIi01O3ABdpYDwnWEVh3IeTt+mOtzMhc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZIm0sfV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZIm0sfV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E781F00A3A;
	Wed,  9 Sep 2026 09:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788944565;
	bh=dah9W42S06RhAIuRe0XT4JrPgbf62fj1c1vNtWqavSQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IZIm0sfVnxpG0vQxuQb6lfjsgv/35NUwK4D9ftfrLClABSGGblIfRjgdF0esiCRij
	 9UVehn7gQV61eluySv8KM+mebjG1/0NmAQt6oit3K822JBUF2zON3SW7mXtO4H4r0R
	 2s5ZsGFfH0RKzASYlDyIP1JhVpOiQZmAXdHSgdYk8DuhQ7uN0XIlcXvV00yZzXZCuu
	 QDaA8Ckf0cL1OvvAKBcR9PYKCRmdhnTkRY12t7GnlfyV3W+B2NAQaDcKsZZE+MNM4X
	 f1UvzzkFJrBct7TuRmIiRnWZbasbwQlR4jf4GrOI5OWeMYxign71PdDcylTHC4nkW1
	 L0Nzvfs91ZcsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/15] x86/vdso: Delete asm/vdso/vsyscall.h inclusions
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260909-vdso-asm-generic-vsyscall-h-v1-10-63ae856cc659@linutronix.de>
References: <20260909-vdso-asm-generic-vsyscall-h-v1-0-63ae856cc659@linutronix.de>
 <20260909-vdso-asm-generic-vsyscall-h-v1-10-63ae856cc659@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:02:44 +0000
Message-Id: <20260909090244.A5E781F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The inclusions are unnecessary, remove them.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-vdso-asm-g=
eneric-vsyscall-h-v1-0-63ae856cc659@linutronix.de?part=3D10

