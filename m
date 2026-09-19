Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C461F371899
	for <linux-s390@vger.kernel.org>; Sat, 19 Sep 2026 00:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789779313; cv=none; b=DTV/kTZvADYLrEeKHsa3fuxK4AdlqMeUbc89jagFFXUGHU1agD2a7Em5ZKZYWSy2D2ws90r2ZtPlsSHr4Su0T2wXfSBQDkvilem4U/qJkrUOOBURreuyn1K27eUSzbd6UzA8qyj5uK5rj4oR1sD0Enbps3FXuUKjGRcgbqtfocI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789779313; c=relaxed/simple;
	bh=74vfIrt8WGXQkg6evVP3sO0/gTZ4U5EkrEbpc7yIW0k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L9HDpdF/Kds8n9ZnV/LT3kfV3EJrdY/Iu/ockNP6gHF5VgypyosoJXAO+1VjiGsoG2xxLbb6i1rgpbbLFGUUGl/16iEGt7qin5Qd29w1su2TWvJ967Bxe0vKXtKDWrEjBu/tVSe7J7fdzaJB6gTXV4botPupU0KRcNOb/o97GTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIOY5GKj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIOY5GKj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2551F000FF;
	Sat, 19 Sep 2026 00:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789779307;
	bh=74vfIrt8WGXQkg6evVP3sO0/gTZ4U5EkrEbpc7yIW0k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eIOY5GKjnaiExeHgaCzA1WmvBjMg0U77Jh+4zjPhQEPFtIiQGCqAzQHe6If0Ap9Yj
	 SnTCBN1RC0HPX3Q1pLWD+Yk61ZKL5pCvXnDn1hbH3v8HmD1+mDmFx7HEdGjXcfaVLY
	 PdyC8OVfG+0JXMN481jbRSAb8Dnff0RN3L+7xTyXqeBZZCaZYziChZWyZXyi4CUiz7
	 RaoRC4i2D16ARUNZ5DbsvT3jsNw626va7YH920A1+Z9oiRJOc0BLh17GscwPxaZyKq
	 Z/V85bJtai0a4RdXnmHB3OLEquI38Z/9x3o9OXayeCfgqz6rpJJGFflNE2BtRHiOh/
	 8L6jFeTzU6Dhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 09/12] syscalls: Add an option for offsetting the
 common table
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260918-tonyk-syscall_table-v8-9-0e2d60cad13e@igalia.com>
References: <20260918-tonyk-syscall_table-v8-0-0e2d60cad13e@igalia.com>
 <20260918-tonyk-syscall_table-v8-9-0e2d60cad13e@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 00:55:06 +0000
Message-Id: <20260919005507.1E2551F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> To better support architectures that doesn't share the same syscall
> numbers, but have them in the same sequence, add an new option to offset
> the common syscall table numbers by a value. This make it possible to reu=
se
> the common syscall table for alpha.
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-tonyk-sysc=
all_table-v8-0-0e2d60cad13e@igalia.com?part=3D9

