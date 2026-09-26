Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE2E4772B9;
	Sat, 26 Sep 2026 14:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790431803; cv=none; b=bkpHUwm+3ce0h63J2MIUQfYA5QF1PPhZ2p+EbknHhyNm0ZFy+Xf7a+SzNFRcLbg9QqpfEPv+P/Ls0BiN//GD7M+pjbjpXZ4w/860gN0/RI1Hl/WPgkL4GDwqIgTjYT+mB0pWrNfrc4N1Z6eJc+IRbj0c4BZy25hYiXMnp0Z+RRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790431803; c=relaxed/simple;
	bh=sk8G+MSr1WDbHct0jxlLZNQCJIfmOTVQ7so7wx9CE64=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KUIKZE2SloufhH3tyI4qIySZ16JNwIHnahxxbaF6bNk4y1BBq3u4nbymOL+fD1iJBl8YqLQqeYvCnUHm5vd60QaHGXLUJD1TMsBpDe0i0rcGQBqHE+ucJh9HHiZH7AhCM6Sh4hJ9L8TnmQ3fw/fppaQJyvQ6A0BUhmrrDXtPv+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBChkuEB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBChkuEB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530F11F000FF;
	Sat, 26 Sep 2026 14:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790431799;
	bh=1mAknSLdneY5WX7eF0ArdSd8dCPkJucm80NUsqgcic4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aBChkuEByOP2C840ux1QPh6mw23l+NgQGtTRijD7bpcsByBmSG9/JMYQq6K1pa6ml
	 BiboX+cJTkWvcZ79nG8TKHPs/3L8NFOAjYslhG0IYuIhsVsgdR6WeIAxUbtSeczW7s
	 f4+Ecv6BZYZmht/5KdARNeemWJVmomv80Kl1KV4L4VpbluqMBMOCNXESKS7Gyz9VTp
	 QYaVN7p0ohYORgXNBTmv3jDo2ntvwi4B/l/qUpzBItyujTAYU696Mxq7Q03xRbyiKA
	 32iQuqKXsng6VBfwzyE9HCvYvakND42mqbxrFgZk4DIbompHF53FeNFaoaByX96Q6s
	 99TkNaXM4jW7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v5 2/3] bpf: Skip detached progs in trampoline
 images that are still in use
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RmxvcmVudCBSZXZlc3QgKEFudGhyb3BpYyk=?= <florent.revest@linux.dev>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, bpf@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260926135605.1217928-3-florent.revest@linux.dev>
References: <20260926135605.1217928-1-florent.revest@linux.dev>
 <20260926135605.1217928-3-florent.revest@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 14:09:58 +0000
Message-Id: <20260926140959.530F11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> bpf_tramp_image_put() makes sure a trampoline image is not freed while
> a task may still be running in it, but nothing similar is done for the
> progs called by that image. Detach drops the last prog reference right
> away and the prog is freed after grace periods, on the basis that a
> task still in the traced function skips the fexit progs once the nop at
> ip_after_call is patched to a jump.
>=20
> That leaves out a task sleeping in a sleepable prog that runs before
> the detached one, which no grace period waits for:
>=20
>   CPU 0                               CPU 1
>   in image I, sleeping in prog S
>                                       detach P from I's trampoline
>                                        -> new image, bpf_tramp_image_put(=
I)
>                                       bpf_prog_put(P), last ref
> [ ... ]
> Reported-by: Sechang Lim <rhkrqnwk98@gmail.com>
> Closes: https://lore.kernel.org/bpf/20260815071927.147049-1-zirajs7@gmail=
.com/
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Assisted-by: Claude:unspecified
> Signed-off-by: Florent Revest (Anthropic) <florent.revest@linux.dev>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926135605.1217=
928-1-florent.revest@linux.dev?part=3D2

