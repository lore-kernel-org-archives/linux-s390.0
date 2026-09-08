Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694E4394492
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 07:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788852474; cv=none; b=LHmHQ5YBs4EGd7c0TYFpSJuqxSovO+U5xinPyfyzAGGSmo9Wki9Hpw3evrzsiz0++Dmjttv9irMq7U/FIKCb7ENt2F2wohmKh4tgyEwshGqeXCKp8IcoTQ9RErW/CxbzRT/piBRwT8uF4VQxiw6KPJHejI5WkeOcBvQziu+1xa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788852474; c=relaxed/simple;
	bh=slGAeybc8ji8/WEgAuKgvrceBnbYrXQ3dUFUMLWt56M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u7M/PnZQy28cbyC5WxvvNXy5JjQaMgjcTQ5lbpdXAFuENiqmFDTdk92t4UgwmONfmxLhe7uKgpIKxYgcNIa8w3c4bdLyjpTnWu4edn066lyGQwExEorHlWHzjDPphQKstFsoRjUeHO2vl7N5mSAwJn/2uERWZixDPUJWvBr2X1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPEHLVn3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPEHLVn3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4A01F00A3A;
	Tue,  8 Sep 2026 07:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788852473;
	bh=slGAeybc8ji8/WEgAuKgvrceBnbYrXQ3dUFUMLWt56M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IPEHLVn3n6nLhnc5eN44yGTiqthrhhrQk6QuWcvWxSojUl8Jxkbj9G3KWmjzzIvFE
	 mhNbRAcfoGMbcPI3DK//AnCUt+q9t41kQvl6cM+/Nf944QEdRAZsfYdaaZ32itQvWK
	 o374B0D7ggrQnsvCGF7OXx64vaMpagGxBDIw9Jt5c8YvHejVZURNY4kxok4KynXhTz
	 6vkIeLqJZg5UYIdPuPSbQk+AWA5wEr/5Ji/E361W/EkZvef2efuPPhUj3fNL5gz8DI
	 XbUDqfbi6o74neKB0CnW5RTBzrZ4KnZ5XDUWAUhYCilw3ZG1w8ZCWH1Pm7feL+Ron5
	 KqoQJzuXoittw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 23/24] sparc: vdso: Enable the vdsocheck tool
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, ojeda@kernel.org
In-Reply-To: <20260908-vdso-absolute-reloc-v5-23-3a93791af1cf@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-23-3a93791af1cf@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 07:27:52 +0000
Message-Id: <20260908072752.BE4A01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The vdsocheck tool validates the object files and final .so library.
> It can detect if the compiler created relocations which are incompatible
> with the vDSO which need to be worked around.
>=20
> Wire it up for the architecture.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-vdso-absol=
ute-reloc-v5-0-3a93791af1cf@linutronix.de?part=3D23

