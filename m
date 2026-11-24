Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795530052;
	b=czvjv8LYjCQ8LBj9zOytPsRy+rD9tYQrnAfwFllAfnNK0IK9Q/jxpBYgcA7sGaiSuxKZ
	 vuqK6twzAKdEJGtNyA2zZqGtGPiK0EKibb9AjMC4pEvLCaov0xWbVwHo6HR7aTddZqj90
	 ROEYQPCrlc1FbU5p93Hjk+5FsYb3ek7QS0kSIjYwdw8o/Fc8WrCzLFWvYSpJxgafP0DEa
	 cAL9l3FVsFT6gfev/VP0ovAQ+6nchccUuEc2N/+wlUkxdR77pJ58zc7XvSpqfOUD9AeQJ
	 zRFbJRnwrfPnOJEFpA0Wu7ojV9jfW+JAMPYzpTo+Lhao0GcgwrqLSit/PGuyoSz1/Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530052;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=u3j6+1vDkkUdepekjgVOAW7Wo6iXb2x00XUTpjNkTgk=;
	b=UCpSEvQ08pt1JfxYw6cDCFp0f5N2jQ1FhLYBW5GJfUmirGDV/3ZByYtWgkFW5fqdQqWI
	 IxSlFfnUfiZ9UTzVC1qDkMg/BnDaZCJvMC8kuxly5mmLi0y0IwKj1Kd00oH6WN4rCH+2t
	 OIwUZy7OIX7vYlDoq9eZ/pB3xcW2f7iaendQyxyBH/QuAL0Rz2PkWiEHyxGJ5cg5rI1fl
	 qFwU4Hqvz+kdTm2DDri3VU/mfVtCksb/lQcpkE6d0EGbrTxyeXwhkm6O2Vkj0n59CJjGp
	 JBQnP5KtdsVK2+P1SLWO5OeH1hskuADQxTJv3cHUG0tzX6/aZXQZkn04+ODwA0/zclQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=PVorD37Z;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=UtwWEvoZ;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D73606A327
	for <linux-s390@vger.kernel.org>; Tue, 24 Nov 2026 14:20:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61D73606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=PVorD37Z;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=UtwWEvoZ
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5A9D01400302
	for <linux-s390@vger.kernel.org>; Tue, 24 Nov 2026 09:20:51 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 24 Nov 2026 09:20:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795530047;
	 x=1795616447; bh=u3j6+1vDkkUdepekjgVOAW7Wo6iXb2x00XUTpjNkTgk=; b=
	PVorD37Z9jDNNC1k6/oiHqSM9Vf6vAHLVrm073XtVk2Sqijo6xNw1XCQ74urOwyU
	wp32RSngykH2l0sDAh2UeJQ/0NqUEJ0cSg2UiTmsikF7UxKL0FDGs54oGa/uKUR/
	Y5HCPegh230snV9Oe6SsSD0k/vP77CspXv9Kcj0/1rKXCWu6X8QK+sdN8FDt5B9V
	B4aVxaDPKqXsjV7HtNdaeYBjoNmaJGZw0u04abomRKWieufOV1PL7rXmCmrDB/xW
	9Ltg7R30nDDMXYz7Ay1Ju38Egdi8kFVJFF19IGZkriACuav3qGT/9Iacb8qfOBuo
	pGMp+1s9iCq7Klb9lHrCyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795530047; x=
	1795616447; bh=u3j6+1vDkkUdepekjgVOAW7Wo6iXb2x00XUTpjNkTgk=; b=U
	twWEvoZRg5cdcif8ONh/tL3K+fVsXGM2+q1a2BkmIZ4q2edlu5335tSuhRjETho1
	/jgu+dstWjejJTtO1W/dn0UgmzlVnSFzBMntGGNYZ+4rJS26X/x0PnVSsf8kH9OQ
	Br/okPX4lzQcGusHYKPJVBf54q8QkRDLPKot7zSIU0dQcy2qpHqWtAD56SFZMgXM
	5Qr1iqNyakiw1VwjEOKycG1yxLjBGj7JnzPZkO9WB8dL8MIOeQKJoGlMv7SlbBOT
	FHrDzvFcu6TotkHxHzxbd9TvcjVy0m8dvXI/y52rmlnul1r5g9mgIoRKZDr0tQv7
	qaslpR8HS3W9rRhYb5e7Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795530047; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LXMzOTBAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:L+IZXHsBNxtHOMBbMs0TyZFWzw4IiyijtuXTDvIBkeQN7jX
	RP1/j2pMdS0nGUfCPxBnampfWtgQIq3NZn+7p9LUvEErZG9kFo0Oy/Uc/I4Eq56M
	Uq4BiZHlYeqrwsCOTdHWM99V8I/+471eOCHiC0eAy+lOgAcBzFpWlk55pu3k997Z
	InLvQnmufOIdpDp7pg1hwMth9K+x+HwuKGjkGr2XREH/P2UMkf1OnMJTMe0TWjmm
	eqhPWRs6jtLSc2xc025vJpsN/+7Dfaj/wVbnnqJg1k3WhSef0mqcAHVP4dTx2pnX
	zMP/4jEQGQghvmTH1kjgOLPUWfDHFJbOedDY9OQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:QWI2uJx9uKHNEkI5ArHbcx6fT0KmIPMlK1h+9jS7NII=:1r9tw/j/3peIDWcTRzPnQcmEJg6r6Mi5hMfjZtJnzRU=;
X-ME-Sender: <xms:O50Fa4H5xcml6H14agoXxF_92vPFDiJwsMdeCK35Mhc8jWjY2vwySg>
    <xme:O50Fa8L174MX3mda9fHYCSd24ThdkkBuj_YqyfUXradE-itBeqF1bAmEvjlEk5jR_
    z8AnK8IKZ0PNsfjPgI_vSaTlCqL7x0bNwFODdxLV5CjbYk2xelLP_E>
X-ME-Proxy-Cause: dmFkZTEzcLHzUbygVSoohLJKupEtfEaADKNynBPP+A79ygbUcaBEdyY3/dAANqKmhrkblO
    Jrae/KV3GLY+RywD9rqxWs2jej9mhDb2TWInKeQNn+yEiA4oO7214aCWGh1pWRuSHLG4lz
    TdoLSFYKLGnO5oj5ojEc5oqP6D1a7M2XWTfL1XsEmO58G94E7SVDAZz/i6TAwTuQMjP1/F
    5TPW0GY754A7e2ys/CGoidT/VBp7upqptqyunqjvfPBeie53CuSfAlSGwR8bN5F1FaHKno
    AL0ThjRjo5RR2bV/aqsZJpIOYawl2HGcD5gns0fAQQl7C8bRBC9pk5vmzfbmO4suSI0JLC
    Lpnyz46cCf9anYpgPOg04vL5NcAu6B+CbaR2p64ylCE9OtchHxU2/sFYPcab5dF9SQic1T
    BtTBN/n3FXbeW+YhdOtF2TiqcVWW+UCyKEwYNr0+0wID7jJERGyGaBXfVxI6mN4AgiYtE2
    JVmX/mSt4BfYY9CVVhhTpiBQDd1fQ4eIcmYyJAqYjSizSp5IOLOxbulU+HP7chDG4+IgQx
    tLfqzihdnyFfP/VLwltW+V7URcNCtlCG7nXuYoJ37Nl2M7LxoSQSNJMUHDFEjvJ6qhcJM4
    aLxrpi/j53kJgPy7MYlmKNBhlU8/wRwzhf4dPLTZksm211Bypt/ItkogSTYw
X-ME-Proxy: <xmx:PJ0Fa7oXw8zeiTB6BEkz_IJr2ffUf9voVAf6yWLsKISNXdWNaYrCYQ>
    <xmx:PJ0Fa3NziNSlPzrCjYnUdLQrWercCpl38axITNNSqTwnWDtmvi-lDQ>
    <xmx:PJ0Fa3cQYYQmZXBYGTHLHk9XzsuScY7a3-S3oPDnnjeV1DXc1ZsURA>
    <xmx:PJ0Fa1W-0RzqLaNULftEzcNXQaRtqI2WYpcneTTueorUeu18kw4qMQ>
    <xmx:P50Fa9OGGACUrFWX6Voa9pbaKsrtI08gEVmULLqFPTSsI5WRDzPWvBMs>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id E4BE132A009E; Tue, 24 Nov 2026 09:20:42 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: A-w96cgpwkaV
Date: Tue, 24 Nov 2026 15:20:22 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: sashiko-reviews@lists.linux.dev, "Kees Cook" <kees@kernel.org>,
 linux-mm@kvack.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>
Message-Id: <5de01709-19e6-4664-b91e-7cf35b843d77@app.fastmail.com>
In-Reply-To: 
 <20261124145907-12f830e3-70ab-4e58-a330-2fa974be1a25@linutronix.de>
References: <20261123-at-vector-size-arch-v3-0-d342dae9e843@linutronix.de>
 <20261123-at-vector-size-arch-v3-3-d342dae9e843@linutronix.de>
 <sashiko-outbox-230870@kernel.org>
 <20261124145907-12f830e3-70ab-4e58-a330-2fa974be1a25@linutronix.de>
Subject: Re: [PATCH v3 03/15] asm-generic: add an in-kernel auxvec.h header
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026, at 15:03, Thomas Wei=C3=9Fschuh wrote:
> On Tue, Nov 24, 2026 at 09:49:24AM +0000, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential
>> issue to consider:
>> - [High] asm-generic: auxvec.h unconditionally redefines
>>   AT_VECTOR_SIZE_ARCH to 0
>
> This is indeed an issue. Not sure, how I missed this, especially as I =
thought
> to have sent this through 0day.
>
> @Arnd: Could you drop the patches?
>
> I'll prepare a fixed version, probably for the next cycle.

Ok, done,

     Arnd
