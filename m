Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D136447ACE3
	for <linux-s390@vger.kernel.org>; Mon, 12 Oct 2026 11:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805568; cv=none; b=D6GTRHk7o4P7JpPacCx2RvBGISxX7F9npd+npxqhykvd9eubguSm5ajqIx/ihd6D1+gs5t5kVdppsCvW9TqJ5lwQvmhXbCMljr34Ti+4+7vaedqtUF6XL8scEKgx8VocjcUuizCgezxxml8QqQ4FFlYKc2Hc0wPdT2ZN/5RCcE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805568; c=relaxed/simple;
	bh=d5ekW7ub95oe4ggGzDIhKbQd6GyZJhCMT4d2krEcGqg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=b+rOP4rMyMj3mM4YEqleCJy2JfrdjrMByA0Xoetgu7EUbyA977aZcIBdMoS7GkSjerTeQY2oXnzQwh2k8EPIo9+TDnkJgRsrjtTxcRMaxk0PoP/naQDTRrUSJQgBBhWTre7uv7IVf8WFlVbO5Z+rRFSuRQWOFCt1WahKwnbdlhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PF+uaBJ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PF+uaBJ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F121F0089B;
	Mon, 12 Oct 2026 11:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791805567;
	bh=d5ekW7ub95oe4ggGzDIhKbQd6GyZJhCMT4d2krEcGqg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PF+uaBJ25YaviA8ptUuh4nfcmt0C/sTbOJrDi0UzeaQcxPZAxRb2RGXLkPBik6by0
	 Lg+IMjFG1QaaFFfytp8iSIZK18Mi7Bp02s6SgNx/PY5tioFaj7CMWNQ3O5mncDDKv3
	 Acd4OpU2mIp5NjaeG8AiSMYRvHpeGmVkXsTz1RJg/c1jfjf80Ls0L9AnurK2GQKYe8
	 ZL53noyZUw3+mPEoD8xfQ/9hHJEG24HT9gtui+hzxgY3LYJ1RUK3B9GMw7Ef4+bna5
	 ZtyseN900qDv0Vv0ZLtPea/IWM9vPbVYV92H1jlmNgXskuGhwchlmtBU8wHScTtxUh
	 LKjA40DBNomcg==
Message-ID: <sashiko-outbox-168026@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] s390/percpu: Use asm_inline for arch_this_cpu_add()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20261012114249.2898572-2-hca@linux.ibm.com>
References: <20261012114249.2898572-1-hca@linux.ibm.com>
 <20261012114249.2898572-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 11:46:06 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When converting to preemptible percpu operations the arch_this_cpu_add()
> inline assemblies were not converted to use asm_inline instead of a plain
> asm statement.
>=20
> With all the macro usage the inline assemblies grow significantly, and
> the compiler may decide to not inline even small functions. This can be
> observed with gcc16 and a defconfig build where many calls to
> __srcu_read_lock_fast() are not inlined anymore, even though it is
> basically only a this_cpu_inc().
>=20
> Use asm_inline to address this.
>=20
> Fixes: 18ec6c5d7ec6 ("s390/percpu: Use new percpu code section for arch_t=
his_cpu_add()")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012114249.2898=
572-1-hca@linux.ibm.com?part=3D1

