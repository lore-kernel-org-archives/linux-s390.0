Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443440;
	b=U3epqURVk46i1N8D5bUGB0df00PYTsQdtSV+a4crB4fFqV5UGrfAVwu3ncqgcDoxY0PG
	 +jGcrYHtc/Tkuc7Ojnqy7usNL7+qeauxkY9DKkQZNoBPmRDQuZdE77xy1i0KiYuiwSrtj
	 yOiblGCI1tn39Qnk1tdZpQKWF8DalFWVhkc1pFirahBscSMJMWlJM9oOzSgJ9ay7xrB/D
	 YdOzJy6QRk1rRRYGjeTNhENtRAJS7ukareEY6FPATdLpF9TS7H7kjcW8xvBF7TiHn0vZ0
	 cVune7GW36hOxdOkeZWk1bYVQgEzhJ2cxX3IebHZONKCvhW+Dlcl0rgm/YlqYMbAVBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443440;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=BHJ91NJtNYQ6/J6+FaRGzznho5yPOY/r3tuo2Sshg1o=;
	b=ik2k8JrVZc/QEUZKuFk4AFrH8H51j/QlceXrzRlXGFI8lAe2C/XqY8VMeU6yqISzOi/v
	 3w+4G1W39rAy+m0vAhnfttMDG95KPLvkVdKIEev3u6xSdiTaNCd6dxaoF6bCgbD84p1Xy
	 IK/xbnoPfmAUG855L5aNl10e7V+6xUtGIS5lkurCR3zQ85b421WOB1/rJ2vTd7nKYxzfk
	 WEtTlg73Y1R51qYdOD4shgPVXql2vwyviK+hCSFWcyb2x482+CklhANXsmvGNTsDPDkWm
	 dxSSA6FrrlyZQwIdxzZOn2UesOutpVbdg44bZoSBu9xkoFiydW/lsgdhks+txX8Zllw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=cPLj8Yt9;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hC6LIkJb;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17FF606A32D
	for <linux-s390@vger.kernel.org>; Mon, 23 Nov 2026 14:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F17FF606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=cPLj8Yt9;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hC6LIkJb
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id 1B08DEC0B4C
	for <linux-s390@vger.kernel.org>; Mon, 23 Nov 2026 09:17:19 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Mon, 23 Nov 2026 09:17:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795443431;
	 x=1795529831; bh=BHJ91NJtNYQ6/J6+FaRGzznho5yPOY/r3tuo2Sshg1o=; b=
	cPLj8Yt9KDzFT9oOBUn+/GuSsf5mynsPFU3peaGSzzjdcM3xPq2nCeDkNchhwU0y
	agEnTSgyBbGQ/yirLqdAtbec6K/eMPAPx84L678ABrYcb+wpXySl2GHRp4LB9WLN
	CFo2ebu58MUl9iNZ9Ieq9B5w0n8KUsPK5DwUz9m8y9EZ7/GezgGomuFh9mdki4r/
	+BIiXtKtzOGG5D+kuw3mpodMWyr20zPfOAhpC9pxJqrf1XcU6K399GtXsEQMc/8R
	39qj2UCf7kgamdATa+Pl6YH54Dj6cd0VQx4T8GjJ0eSyaIyzVoR7OVUL9GzpK8m7
	+ruoO3v7zMRO6WezXgniMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795443431; x=
	1795529831; bh=BHJ91NJtNYQ6/J6+FaRGzznho5yPOY/r3tuo2Sshg1o=; b=h
	C6LIkJbKj92f5S7k/JXfyeaid1Af9ZzNDUOfhQPFxJP9BRVK8CoFu3txAUBGFSdE
	kDtEOIgPiZzvlCZbCv4YLx/KipUoHlpFtABBaFDzTO/Eo99zurKqUHK11ZRFH3nk
	zrK7lUHYw/5sxSK66fxI2EBGUdhZg116RSbILC1OuB62zbnw2sD4sW3+a4PBWhw+
	vIkMNp+LX1SFD5zMvRTmes4VjgpqWOOFse8Womzu4lb2d/5udJ8V95DWmA0O1EvJ
	RGzmtn81sr/9oZLy7H3BztHTIli/UeDdJz4S0o8+2QlJ2kzB0w3ffJ58MILv/tOp
	VBsPDLa1+OUIFoA4NwwtQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795443431; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LXMzOTBAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:LOMygnjCuFuOW8ggJ9crGUsjkoq7QcrtXQPhKEiolkizBin
	Nutv/b4HviTA/PHO4u6Ei+itUya3SksqCcd+QmlKv18+DkX1Z7A0rAXPC59X1DIG
	W9ojAgJHklvE7jUuxI1NF52IDeLif1e0+j1IDD9idqcD/6P+TIRVh4LnFL1g9o7/
	k0LNsASbZXjyZJ5o6Uy4DTv25AYZYDewiKnSuAmJn0gGYOYOA4v3yY94FX+Xm4fR
	81iNrxEsEYT4DKevscTwFpqD9y/MQdC6ONbQ6SQsGNI5L1fkQPCxp53fTERKPOiL
	Ugsk6ZeFXnJvGx/X1hWQbyhamEEv7pYTEvGCOig==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Sap56MIkcyZT8r4cYNPG+lEt8q7zj6cm/hR6DX/YHXU=:rDsMBjpfa65jK66igtyHf1M93PmlfJObl6/94lUiVSI=;
X-ME-Sender: <xms:4koEa8b6jWHk9Km-gWsvkjXKBe9FOycLSAoQHdX1x28WgylltvrlXg>
    <xme:4koEayN-2NZ5tuVMTv_F6M4wNcDyjmgtjmjdAzvHywIA7KHMufFQZrYw4q170T5Th
    fPdBGfTNlodLlNUN9knmz7mxDJr9FP9Hc2uPOv3pg8T14AiyewMGhM>
X-ME-Proxy-Cause: dmFkZTGFrwq2MF5SSuOMe3naqs9tbtMAmc3XEG2p+PrgD+xfiVSS77ldCceRFMgHOXXvSL
    Ging+R6VT6K3yz4OUeCdmIETXjNj7XXI0r9Tg2543OHjiuaKhMh+yVJAoB6OkAWbwGP/U3
    JowxnSxhNhDyTsBNjiM7LlqkLGWpphbuTeJ0WjErvJ9KhK0fJtLolaHFC6Kw2talXF2YGF
    JN7yWyVcYnsY66wGn8uoBc1Op9fn/HtafFpC/Ha3Z7ng5ziTGTERGiQYQq5K4ZdS/5JuDE
    HH1gfdWjYiM0bW96wZfgClnWGF2XIAu99qwAHGam6Iwuv/kahBWnYmwWVFrVPNzzZ/ahP5
    U1UkBFU5ZxOctbFZFvYR87OCQ9D85IrFkHXF9AU7aFYWG6vLW8lI9uDg5E561v2/5hKHQA
    sjQFn5A8NcDFUKKIz/Gj2N6XcZVOTlbQkDMhl7pFKmJR0nTwtc/ea8J3ozLffLR/0wUUbB
    iamGkspUsbgem4niF9wBtKb8Aybdc10XaTbLUSATly8dgGeAoj4vWgf2FM9ltEDrHvDjNY
    51emBC5k6bV+SyYpJacMFkokFxMkxKPk9r+T99bzSjJsfdRVRAC/r+2KM3FJJSK6C1f8wW
    I+V82FhA+/RpOowStt3CO/53UAvaoCC1+Mr9HKqAkD73+MJL10fMk/SelFXQ
X-ME-Proxy: <xmx:5UoEa7zTEzd5mDVuAJ0khzXfAhl-NnyAwD2CijXl1cunNEN88JhvqQ>
    <xmx:5UoEa4LmzfnQ4K0KUaYuA7sCKQ4bXebQmmhpsTBdhtm50HSfa0pUZw>
    <xmx:5UoEa9456MjeyYgj744opH-waU6skY_xuQzxaCDvT7bwukaslpL8Pw>
    <xmx:5UoEa2xmieeiTKUZnDvuF-Yhydil8f6ZkK_qEXx5P2wofodg1yRZbQ>
    <xmx:50oEa5l_6AC-8c6ZgGJR10cedMu4FgnH1XmeVBS7jPfPPs2PoWN-CFom>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 6EB4832A009C; Mon, 23 Nov 2026 09:17:06 -0500 (EST)
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
X-ThreadId: AMjdjL9dYp0J
Date: Mon, 23 Nov 2026 15:16:41 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: "Kees Cook" <kees@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 loongarch@lists.linux.dev, linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-alpha@vger.kernel.org, "Paul Walmsley" <pjw@kernel.org>,
 "Andy Chiu" <andybnac@gmail.com>, "Magnus Lindholm" <linmag7@gmail.com>
Message-Id: <b7b8e8cd-d0ba-4e37-93f3-0fa209207124@app.fastmail.com>
In-Reply-To: 
 <20261123110111-6431e85f-39a4-427e-b545-2e7a590a6c19@linutronix.de>
References: <20261123-at-vector-size-arch-v3-0-d342dae9e843@linutronix.de>
 <ec5359c1-c16e-4177-8dfa-2ae5ab8a874f@app.fastmail.com>
 <20261123110111-6431e85f-39a4-427e-b545-2e7a590a6c19@linutronix.de>
Subject: Re: [PATCH v3 00/15] exec: Remove AT_VECTOR_SIZE_ARCH from UAPI
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026, at 11:03, Thomas Wei=C3=9Fschuh wrote:
> On Mon, Nov 23, 2026 at 10:44:40AM +0100, Arnd Bergmann wrote:
>> On Mon, Nov 23, 2026, at 10:37, Thomas Wei=C3=9Fschuh wrote:
>> > There is nothing userspace can do with this value. In the kernel is
>> > always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
>> > userspace and also changes from time to time.
>> >
>> > Move the symbol to kernel-internal headers.
>> >
>> > Meant to be applied through the asm-generic or execve tree.
>> > The default recipient list was huge. I trimmed it to only the
>> > architecture lists.
>> >
>> > Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.=
de>
>>=20
>> Hi Thomas,
>>=20
>> I'm happy to take this through the asm-generic tree. I've already
>> made sure it all applies and the patches look good to me. I'd
>> wait a few more days for additional Ack or any other replies,
>> let me know once you think I should apply this version.
>
> This v3 is functionally identical to v1 and v2 which have been on the
> list of a long time. I am not sure how much more feedback will come.
> IMO it can already be applied to gain more exposure in -next.

Fair enough, pushed out to the asm-generic tree now.

     Arnd
