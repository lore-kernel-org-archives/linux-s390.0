Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667AB3D3CE0
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785404754; cv=none; b=CbF3AsleHPFGgahnrHiOKhAHdxzXr4BxLi/AN6EJmKvgLRF9Jz/Z2WzKIf/yeaDeKStarpUb3P1hTdC5bT8ZqLebKrsGATonTv+jmM4Mqcwa/Xfo8c4gWjcN/bFp+4NmP44hSwVuh58/uUwYqlKgr6D0TqfllU7vYuy9qjK9J1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785404754; c=relaxed/simple;
	bh=sQFnonh56uLX+G202rjJHtDKQvDx4ZMCiZew/6+WsDs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oGu4vS/eCx00+KlEzFFpMpxdcQu5gS9jyJobBHWbYxYjMT1eRdaRyww6BBTTIMGxDdOHDXVIbQlCnhGLFiN6yCEbdrIIJeZKq0ELFR6b4+0i16/9WlBxwzjJwSUDMC/lz/QoGWIJJ3tfjZ6L/GRp0NhwOX8lgRnr8IwIqP808Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9jZTKpZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9jZTKpZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50F01F000E9;
	Thu, 30 Jul 2026 09:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785404753;
	bh=sQFnonh56uLX+G202rjJHtDKQvDx4ZMCiZew/6+WsDs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I9jZTKpZJ2kCyNZx5rUlgURWXEZwzWBkSpQGp2Ti6MAI9470vf7M1TN9oqRCwXSoH
	 1E3sNQvw0/096cLSUNIxuuOdr4/X86KFgTAAK4PpR8rxp7724fkburD86WYkiJmfQ2
	 77EdscCWHWwJJigi1QLF8rOwEzzQgISDTvLCKR1KRXYUz6qANfjJ85IKBAMvD4SA9s
	 yUA/FOhfLo1n9SsfT0/eC5NjYmylHQh9x6Bh9QUAoymqx+LFLbBDkOrCc4UObIJdp1
	 49Kk9AgC7fHWmFHhwbY5y/V/JmlXGqrM5lGPwhQSVEhfmHc5XrYxGs6er+CqP0Wr7w
	 D9fStodk4t2Sg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] panic: Introduce arch_do_panic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260730-arch_do_panic-v3-1-d5401e683cdb@linux.ibm.com>
References: <20260730-arch_do_panic-v3-0-d5401e683cdb@linux.ibm.com>
 <20260730-arch_do_panic-v3-1-d5401e683cdb@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 09:45:52 +0000
Message-Id: <20260730094552.A50F01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Introduce a hook for architectures to put their specific panic handlers.
> s390 and sparc already has ifdef preprocessor checks to execute
> architecture specific code. Pave the way for vpanic() cleanup.
>=20
> Suggested-by: Sven Schnelle <svens@linux.ibm.com>
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-arch_do_pa=
nic-v3-0-d5401e683cdb@linux.ibm.com?part=3D1

