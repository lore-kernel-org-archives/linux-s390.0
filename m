Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF284B53E5
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 23:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789689404; cv=none; b=aYSGcbRwo2Y1OnYjZxxDnB9qHW3lWxWJ5vFdXlshxsW55W7vk8j1O60awvgxZRxE9qq26GVRGtU4Tn6eIvWPCtaZr1kbyJ6Gtv6w18x1xEpYByugH6KkEW2he0lVIwLN0xJiYKp9ZEh/UaV0/frfksE3s0m6spFebCBMFuPSJ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789689404; c=relaxed/simple;
	bh=3fIcT0AKsmvmJTY9F7AGaNmXWN8ZMogcZGgbGjc9TvU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nh6Q9uk1HrTKXT+myq4S+YUPznDpAkosbgmh1F6lEJSVzPEgtph+9as5n3MXrvi3ADRZsRASs8Z6LRfzGkcbhQyvhRMaYzisjtdi3UM0FQiiFHLQ1gBrZiSphOsxakvTYjzVzrJZFTFVnGYvSAE4f0xFopSjFu+xxcbMGGZNxzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qp7lnLrI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qp7lnLrI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FF01F000FF;
	Thu, 17 Sep 2026 23:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789689403;
	bh=3fIcT0AKsmvmJTY9F7AGaNmXWN8ZMogcZGgbGjc9TvU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qp7lnLrIEnqsiXzXHH/auuZdevomIV3DItMVj824K7bSJgwe1sxAtErLyutRaDMcl
	 394g0OueHuTk8B1vORPZrgDQioG1hSdP1JeLM3COPKzBa/mhgcYqUDMlkUMZSLwGPr
	 +6RIHGcCr/i+vSxD3oNQ6lgdOjC/NLd9bC4ynTUcWx160bzmYxqt2Er+i8Zf+a/+nD
	 3Kba+aTYJH91Sp3ddbkNkg+REVJOs35gZdma5lkDvcFdqwMT8FfW0GBbK9neMEeDNu
	 7Wvm+4f0ZG31lJjsEywWzEYp0wmYfJ8YofkzwPW1/ptkyWu8EcFnJLQQRJsvre8W0z
	 3Obid/FwiYtLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/13] s390: Use the common syscall table
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260917-tonyk-syscall_table-v7-5-f4cd8f8e3265@igalia.com>
References: <20260917-tonyk-syscall_table-v7-0-f4cd8f8e3265@igalia.com>
 <20260917-tonyk-syscall_table-v7-5-f4cd8f8e3265@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 23:56:42 +0000
Message-Id: <20260917235643.25FF01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Remove some of the duplicated code by using the common syscall number
> table.
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-tonyk-sysc=
all_table-v7-0-f4cd8f8e3265@igalia.com?part=3D5

