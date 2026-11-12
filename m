Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492333;
	b=3P5d5jAkbpRqGtTlq/CteiirpHzpyb6jARxhtSd/gUsIFtNsPlLvVb3dR5Pmleh5gT+O
	 B36FTbElA8FTmDnCbSuR4BYqZUh1IuGIX/Q1GTyHCx1GST81yzDXZTFvgpvBvHTK9Pvlc
	 lXzNM2w528wwTWNEYiTWkCG2lcLLVj4d2awOhlyv4ROjWhGwLncoYiXEQtmKDd2x9otRc
	 5HEFqWCuoQYtzLBe/xH9FX1NHikz82hw+Irr2sAxEW5OjKd+FhlPHoJcAdY36JxF15ii2
	 UTMnr4fIwa5Q6Bpq0sZaLxZ7kCs3KmCHJDHBI8WMIxAmkGkdMJCFsZzMgS2hRGV3vIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492333;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=pko6mRCMfp9Cyyy/gAoWpwIveNBcnJXIKlKgVug+D/o=;
	b=CG0jZbQa4ozj/ZvT7JDjHkzHM44aOt28LTCIMD3Y9HzHhPslUSLUiP13DYx9WQaXOmgK
	 yXP8h1OOD73snVY7+6/9PGzJNT1aav5+hNczzJrtB689DxCn2n4j9eMt7NqyC9tpiZxvI
	 ed1EfSPaZze4euXpHbJM+RAzOSRtEoqqX+15bFEhqjA5CurtKy75E2ZfiRs0yAxkNpAbo
	 dj4WIuKS9UkRL+vRMM15v/LzeCKb+ub5ceQftsSxHUrMKiZCTiSe281o5ZCDPD3wb+Zev
	 G0dz9ncnN7EqvEjZr2vV2cp6ejyTHua1pzRRtS94b1hfRonhMQfbxh2mbnHpSzXlXGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=Xh+h1wSV;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FqEKdWwe;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791DD606A889
	for <linux-s390@vger.kernel.org>; Thu, 12 Nov 2026 14:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 791DD606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=Xh+h1wSV;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FqEKdWwe
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C309B7A00F1
	for <linux-s390@vger.kernel.org>; Thu, 12 Nov 2026 09:05:32 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 12 Nov 2026 09:05:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794492325;
	 x=1794578725; bh=pko6mRCMfp9Cyyy/gAoWpwIveNBcnJXIKlKgVug+D/o=; b=
	Xh+h1wSVBu44nSJ74HnYBVZC3D0EBf1F6f0FHS7sToQviRCNenAi+z0CBn0Jwnox
	ejnFqzYKhIx51SNCnaUSnZzzqrQ+wqvQckDK/fMjWzFOO2enBez9pGWqHZf9eS79
	7TqHB9QdwSNlpvFDqzH0SPMAmX3a3kSolXe6DKs+ij1SwIupxzQzK+bPO+p5fSpZ
	YEtrA07xt/Q5H+cyOb/m8WWQXhqCvZtYZBN5r0VTNpsWfLsx5KSYwLH1gPTz8wh7
	aAqiDcYOqUbLfnb6FUeX3j1uLR6qs97kX1JsfW1YijTycwg1n8uBYQy+YQQIx/rG
	6nqV9Rtub99HBhD3dooiXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794492325; x=
	1794578725; bh=pko6mRCMfp9Cyyy/gAoWpwIveNBcnJXIKlKgVug+D/o=; b=F
	qEKdWweWYKGwAOqEQHtslqgHkl02o+VAPHTV+Ok0UxkqW/umCZK0USiDkcQGDmnm
	zPqB668MutngAEMB6/B4Zt3OVm3JGZi4AHkcmcwX4RIJEQwks++WW45H32q4p+AI
	J0HR4qb8etAY1z/DVsxOmHZ/CWUTbosqjobcqGf0CTFp5A8O1Cbr679+KBZH5Map
	oDlpoY18EPMZynyf5mjNnsHtfwDhd/qStKlC7GIJ7InkQPO+N9RaeZWMt+FCvmZR
	vnaSVJrvgEMOkz1zMQrY+2SUBpg1yhVk/8oOekR4AMGm6Mw7wyoDhXo4bJvfu5pD
	tMEv9Zan5KlrwtvUv90+A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794492325; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LXMzOTBAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:KcCb9tgfFXkBL0nTWKuS0qg44JG3jtI0MvR8T6WaBPUrMTW
	ZIBtV8rP4s6EhMq9z47iA3qHUT8iU8prEIEYIcSvGKkYZi9Xl5gngbFVhSvWWLpM
	JuopOC1CWfYIJ0nFG//9SJgabMvV8y8h9TJGeYDY9nACaPlRtKZ0ZE9Rm7hHQAw0
	WBFZ51p0eMeAM5qxTQAfuYotf9Da+7J+8rswCaf6Osa/N6xjGaeglKXLyEOC5t7y
	wkjDbbdQpeb9VK1PjqEvRgHsPEjKEHUdMznjWykPrh8nYFYdDMwADUF6ql792Cfk
	cy08o6HYOESwC9fN5QqimCMOAzUVozUX7qaMoBg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:V60JOROyj/FCtqcbRKRyHTpWddfUd3jbk7dyOJsukjU=:Of2aUQiysyEawKxf7qyisIhQXXg6zSM4x99cDBoHPUk=;
X-ME-Sender: <xms:oMf1agFOMxhRnSVLuDUoykP5UcEaUmqTFjlXdqyO2uB6F9su6yRNUw>
    <xme:oMf1akLwZwhweZnV5ZmnIfs10GzsHsK22-pTYnrYX3V-cjegvJPl_Myftn5u0Gbwm
    DaCWXLR_MoNxjIEU4nSmSLZrTGV1f3nnW3z6kcicXNxfBcD27jZuRoh>
X-ME-Proxy-Cause: dmFkZTEo6VaWdj6bxILRHhv5G1jOW57ujTVJlC60OvW6f6oZAOkjAhJfLyfQ49u3ydRqSD
    6McsbenddWiSAoIlBf0W+NIryEOud74ndQRz1ZNlMraGhXPv+PXtGwEWkyMxloBFs28AM+
    VC192GnF3PbfCLd/7+bSFeIt/B0QBaOAfOsIn395cK3dTopXenIvBp6SQsQKB6phN+B9N8
    64zvJ/tH5yyX1gC6DuvHI/QxWEKFFTCz3bKka6l9Oc60EMdBZdJIR7mDAcEwPZSfBGmwPb
    2Z9OY6PpxO64z/9vBGotM7b8//4i1p4MJhV0SzERiXc9YegNJHS2YEhsW2FEyw/g3Y3ZRu
    oYdobkUaJL2vVkuf3T68WqVhzELvAAGfVl1I02wG2/C2ee5pG4BsL99/ufnRR/RMRJfUDL
    IAOiMCCS/0lXXQL0QiDC+S9LQxR0GnnllNps6HKEOYOzABoYBb73irVKV+/FvcBrj/lZlt
    KNgU5rRvLdeTEsl5/OmCVzut8/pJmcfBWSq9jgtDWtKtfbYVKtPBr6tYGiNLXE4KYwDsCX
    TuSkgz3NcCJjmEocAeYLBdE3MtcNWb4/YseBTWzbPMmhrXkYZPYwSVkCpchNqNRuriNhqE
    AZrpEdcFFaE1gBWBqfwXUzpCNEzsnW4FNez5rGN8yS7XzeIux+zwtk8TNIAA
X-ME-Proxy: <xmx:osf1avEZfAfXrF6erZ-8PXAN54m2ulAyFtO0FYzjsf_1FxrnbaIiCQ>
    <xmx:osf1as8BNfiWFYPBCaJ86GPB2RJe4q470hV-HuChed5yBLL21RKeRQ>
    <xmx:osf1asSOl9G_RlHWFW4hJcVJeg1HfYqN5torsMoo160Yk7Co8S1WEQ>
    <xmx:osf1ahrsJhcpjQbCC8-euvDiMkYTBNRXBWR9bHNczCu6x11eef6VMw>
    <xmx:pcf1ashlANfxc3dlsCHW7RA00z0RWpZW_h8YKAmt-y_S0kOrMRqVWIb4>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 8FB1332A0099; Thu, 12 Nov 2026 09:05:20 -0500 (EST)
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
X-ThreadId: A6ErS7mxpCYw
Date: Thu, 12 Nov 2026 15:05:00 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 "Masami Hiramatsu" <mhiramat@kernel.org>
Cc: "Christian Brauner" <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, kernel-dev@igalia.com,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 linux-alpha@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev,
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org
Message-Id: <b728a698-bac7-4cfb-9eba-505f955148eb@app.fastmail.com>
In-Reply-To: <20261105-tonyk-syscall_table-v9-1-8d1275885d9c@igalia.com>
References: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com>
 <20261105-tonyk-syscall_table-v9-1-8d1275885d9c@igalia.com>
Subject: Re: [PATCH v9 01/15] syscalls: Make --abis parsing more robust
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026, at 21:05, Andr=C3=A9 Almeida wrote:
> Some archs Makefile have something like this as the rule for making the
> syscall files:
>
>   cmd_systbl =3D $(CONFIG_SHELL) $(systbl) --abis common,$* $< $@
>
> The $* symbol is evaluated to the variable found at $(uapi)/unistd-%.h,
> where % is 32 or 64, resulting in e.g. `--abis common,32`. Sometimes t=
he
> rule for the file won't have a %, resulting in a trailing comma e.g.
> `--abis common,`.
>
> Currently this input is transformed into (common|). This is problematic
> because grep will then match any ABI because of the trailing `|`. Make=
 the
> syscalls scripts more robust by removing any trailing comma.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
