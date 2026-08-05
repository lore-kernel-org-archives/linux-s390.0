Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A64417BCF
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 09:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923769; cv=none; b=hby/wH1k5uG4D5da88TpeRU/+fXKYNDSYXbR3k1njnRLvMxnTRnJEzP5kYrqqCUtVScsUq65IWNJuPUs8m6xpl21w/DL5sd+mFF0xNy4+oMzFCo6UOKQ5u2Hk68KxwFvYqv5gqUPhES2yVpOqXbN7nsP5DiL9ZDKV7uKl7aOxPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923769; c=relaxed/simple;
	bh=r3eRewsEAyEmsH5HzRcRaHiqf15LKxJfbpTIOQfBCJs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ElROjcOw3Y1nsqqOb4+K8xFPoehhVtUAMCRUNzHNKpcDwwYTinuLg9zd3e7C2qcnXjWrdBBIgx1mc/YjXXBOgPxfnPIg6qz16cd8YMc1sRN21/+53w5VN3XtnGALPUtTxm9KnbDmneWLTf71OenWR94i6uBrSGwL7ICWt/Eh7bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sn0geKjY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sn0geKjY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463FD1F000E9;
	Wed,  5 Aug 2026 09:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785923768;
	bh=r3eRewsEAyEmsH5HzRcRaHiqf15LKxJfbpTIOQfBCJs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sn0geKjYymacJPJshUKJF9vliqM7A1oRmEweKlyNvTG5YRbDUY0fv3JUnQBmQjaKv
	 nnQ07fwJca+ddmOoSXxk/BEBe7K7cOQdGQ1Z1FBEJbpvo0yuaMqB5dsoBdOjRs5tf2
	 9zmDIBpKj0SeXxnXYeOBZgm8sGM8QAzXmICZilwdSic7z4h0HHH1PiKSKMRRi4y+EA
	 jFN2qo8PHSi7Yhq+jgYdfVDB1U1FYsTaAV68krf7Zm9TZMJ0IYespTZe4SYqlteZxX
	 8+kILOLQvrujr8RSiXAOE7t9mDtSe+eFs36KQGjuHPymg+yfZfKcKkPL1Z4qCLJGqX
	 jlINKEuDWrq+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] sparc: Implement arch_do_panic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260805-arch_do_panic-v4-3-af4a36f99414@linux.ibm.com>
References: <20260805-arch_do_panic-v4-0-af4a36f99414@linux.ibm.com>
 <20260805-arch_do_panic-v4-3-af4a36f99414@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 09:56:07 +0000
Message-Id: <20260805095608.463FD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Implement sparc specific arch_do_panic() instead of using sparc specific
> ifdef sections in vpanic() code.
> Reorder arch specific panic handling, sparc's Stop-A messages are now
> printed after "end Kernel panic" marker.
>=20
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-arch_do_pa=
nic-v4-0-af4a36f99414@linux.ibm.com?part=3D3

