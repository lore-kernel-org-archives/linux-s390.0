Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708E048E0FA
	for <linux-s390@vger.kernel.org>; Wed,  9 Sep 2026 09:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944481; cv=none; b=XnH3TYZM3OEU+LMmVvaVXogAa5quqo/Vuaqq86UnmzeW3bORBZn/6rq74IwT3NrBzFh5ev3qr7B3hhmXRBhQ2C/OQdn6idU3DgAhSE/JZQ6W8mZN/iVJgFVWdzcplg6eQzfurMb8AEsSY/kLFqui/1z/J5aGFQMbbAc/j1eEby4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944481; c=relaxed/simple;
	bh=KSY7evaUgGdkTjmllwO13EmcTfh/fXEDKiiRysj4Dqg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WtGDX4IwTmb+dzTJbSKc6E57ErllnEGSYsxY5exEBnzW9EeNUeRU9UWmN48cjkohpM6Hxr0JS1fTePOlBYjP0ZDitSEbAXQCbQLk02VM3H5W8yABj5yWdojn8S3c2WqnRiO50JaJ5B7RZx/Ag7Gf3cF37vFu/P5ng15MSg0adTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naCYRxjV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naCYRxjV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FFE51F00A3E;
	Wed,  9 Sep 2026 09:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788944475;
	bh=KSY7evaUgGdkTjmllwO13EmcTfh/fXEDKiiRysj4Dqg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=naCYRxjVc3+MWRWz5VbqRxwLgo1VpkJgL1qzxvQN4AIvnmKVCabjlh+PkGi5h7DAm
	 PRhbk+JnS53S6ggVGnAHrYJIoI9J/6Fzx2jSmWmIADbL1fXdkeYITEh9nVENib+pvQ
	 Cf09UPfYlqb6Hc8KnJfWIImEylJrWv+JHTA0NcC/8CumU7BeK+Zlty0rq7c0tyc/8l
	 Z6VedmLhS/9G3XYqPTKl0u946OOvyiZtpLbjfL5zeeKGOnlOvk805muOXP+qtDqpN8
	 p3xIWC36r9y0glnbACZhtfQaOWNqXBmZ9WEzyaU4jLL1GPAehrqtfJJhMq3+dKUwXl
	 MLbilux/HcQgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/15] vdso: Remove unnecessary vdso/vsyscall.h includes
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260909-vdso-asm-generic-vsyscall-h-v1-13-63ae856cc659@linutronix.de>
References: <20260909-vdso-asm-generic-vsyscall-h-v1-0-63ae856cc659@linutronix.de>
 <20260909-vdso-asm-generic-vsyscall-h-v1-13-63ae856cc659@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:01:13 +0000
Message-Id: <20260909090114.3FFE51F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> None of these files uses anything from the header.
>=20
> Remove the inclusion.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-vdso-asm-g=
eneric-vsyscall-h-v1-0-63ae856cc659@linutronix.de?part=3D13

