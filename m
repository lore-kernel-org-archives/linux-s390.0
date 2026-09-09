Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BE847CC6C
	for <linux-s390@vger.kernel.org>; Wed,  9 Sep 2026 08:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944134; cv=none; b=udQlRSsl7b8nGIoq9q/81/rYONdq1AGWXdCwgpatNeUxJbGEY1igwjWq+tEpHCkOvWp1C8+B6LKniFJUrUt4Qw3vcyAjnzbEEhKiCea45iTEuUMG5rxxRYOcRlK2H448jIha8tWF+nWZDeKr7SZjeYeDcLXxePJ3kNb0ia5D3A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944134; c=relaxed/simple;
	bh=LckIEU9CfXbBohMKC6nfrRunIbD3W2uDy8m0V5Hcp1Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JpcWLRUkYqzS3XytgQmSZ+zmKOD7k+qK+ytpFWHFLLn6N6MBfjcN8AqJWmyBwvQ0pipTaNJfe6MjmzrOiq9dqINw+R5IYp8HBbNISsSn/d0JHakoE+SfPkHVKwIF+SdvGB7aqzKLl9TXeLkMygtQF+Fj0ZChJnw5FRqWY+Gy1qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0Q0oqVd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0Q0oqVd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D211F00A3A;
	Wed,  9 Sep 2026 08:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788944133;
	bh=LckIEU9CfXbBohMKC6nfrRunIbD3W2uDy8m0V5Hcp1Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m0Q0oqVdnsYBfD2vmRgd8M7+dT9DZQ5sKUGzau9UGKW16wJsZAnOjffgdd082Jbtv
	 eDUGQwwiXlYU5TihHyGD3/Rx9tITJ+cOHbT/x3wO4BXdgHjEjgFKebj+pBPErnO0DL
	 tNAoOGGB4HN6K3oBjBYRcgx77w2XcDYe7kQah+Ct5PIRr3ii8qpkcSjLnTj0S1hTsf
	 meVU90xpNp/j8pKAm1L2h0+ZHm4GrqA5+uX76U1el2y+PAvBBFo5Kh4xoV77dxbMpK
	 C0i3t0P9SZXLPajlsPov5PrpdBNySoFVbTfpvrz0UjQ5J5e0ARuvmH2zo9WFfqdF6P
	 CW2q26MZavD9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/15] riscv/hwprobe: Include vdso/datapage.h
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260909-vdso-asm-generic-vsyscall-h-v1-12-63ae856cc659@linutronix.de>
References: <20260909-vdso-asm-generic-vsyscall-h-v1-0-63ae856cc659@linutronix.de>
 <20260909-vdso-asm-generic-vsyscall-h-v1-12-63ae856cc659@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 08:55:32 +0000
Message-Id: <20260909085532.D3D211F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The symbol vdso_k_arch_data is provided by vdso/datapage.h,
> which is currently not included explicitly. An upcoming refactoring will
> remove the currently used transitive inclusion.
>=20
> Add an explicit inclusion.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-vdso-asm-g=
eneric-vsyscall-h-v1-0-63ae856cc659@linutronix.de?part=3D12

