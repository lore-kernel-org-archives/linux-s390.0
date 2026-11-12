Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493207;
	b=IZH8rZJ74jM+nJvHCnp5BvK7QFJLsD8G1+I9Ft8PoWynRVn/Zv3TeazbRMiAP2/GcpkD
	 tSyHq8p/43/PNeU3MuScx/dSHQ6GXS8A+WtWgyXMBtRP7I6gmOv5HWuNK8FCKwKQ5p+wV
	 Li8NVf46yuLxX6g6ZleQa77IhdeexX+TajAcRl+Wr2HwtIdhR751IZwtgZnlhGg5euoWA
	 irOGxnhEOxRXZ5MrImbOr/zjRZtjfyC4po0bU1M3M3oqotdQYkD+jSs6OkTX+yA3c9vaX
	 InXveLbD/SWb26jHv+w6Q1KqSdXfs34XvwyOFp87Bo1niTG8ZFuuTW8GClYxlCbhEIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493207;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=Po91A0TQeeSBZp6Uv+2VnxQcRtafkxVPR5t/omhy96I=;
	b=bVG1ChRsIHp5Qv2j4u31S1GlxN9fOHxqRzQz7kFnr0ePiCF9pWMRtD/4ImoRISwxlHo3
	 bKRNBNnBGlfb3MBkYxczOCWB4n+Mu8v9TY2OOQcCJ819UKRXyJT0zyI0aEGTU1yfzjF7A
	 WRBtGnJihdY7Wh0LDUNypNv6g3X2nvoJE9va7jm9IHegX93K+RX+1KM89pgLPUAWsLQ5f
	 d0Za9PPpY7TPnDRnBChVZ5N836qvEYUgGPq8S/SRf56mwRd2+1NBgxQxwpfna9fQ8O7c1
	 nMXFNUL2/IDoZs2cB966ttvWAQwue37pHgW1bx4agEg+OKVY0WRFAN2pMxW01JZI4qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=JMAgKw2c;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="A+eih/B1";
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67558607379A
	for <linux-s390@vger.kernel.org>; Thu, 12 Nov 2026 14:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67558607379A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=JMAgKw2c;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=A+eih/B1
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7D2777A0108
	for <linux-s390@vger.kernel.org>; Thu, 12 Nov 2026 09:20:06 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 12 Nov 2026 09:20:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794493199;
	 x=1794579599; bh=Po91A0TQeeSBZp6Uv+2VnxQcRtafkxVPR5t/omhy96I=; b=
	JMAgKw2cBxf3HBI2nLW3v6qPzOCjORacm2L5oljcdrnvA8ThpZZz5Hdq6WOi0TMO
	ceF0cV114PdYIJzsbw4e7vTOU7Y+t2gJX9tXCbdbvAq5RjuZJXm0dF598zcFr3n3
	0MkQeiapmR1u+8s28Adb/7nqCoZB5/OFZ8OYLciR8rvS+BTNMTNJHVAul1qU6Obd
	m7kwZHrv1/gx0P9jg3gZy97282TzzBGt26bstIN9zVy0Y7yS/K7pYpcI0ZzfZ7Ii
	giegKtclp/59pFWgaqoOoXxLCtvrSggYUD30kUsXZCbLDngx69lIDrO+07q4EplR
	JmlUmlvllIQ67OkdTFUrmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794493199; x=
	1794579599; bh=Po91A0TQeeSBZp6Uv+2VnxQcRtafkxVPR5t/omhy96I=; b=A
	+eih/B1y/W9H127L0xh9ReznZXXhgI7L9PcIOaXk2mStUP0UdFqxYgpZo39oQ3bG
	hCMd8qID1qjS9hlJGeytziYM3D6obTneIB+CRttDQT0K0JeCU/AWRD1+CNC9F/ma
	YfCBZUIV5Fv3YZZHJkPyWMYfhRNoWaXW39BxIAJD4B3/W85hMKrng7BbWZFeExpV
	zxeWNqtPZ6KP/QH7gY8VCx1Evk4LBUuJ1GC7i7ewKnnJZNvL+psDSmyPPx7S88sg
	e3jlx1+E2B5nd1OJgNCMN7Dduq6H6DmiMAhv45NYGUpiyBuGYRvh8rhg03MB3SoK
	sCAWGMHZ89fCm1HkdoMew==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794493199; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LXMzOTBAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:XMv2xZYxPIKPnV4t18Bq+YQ6nGnz4HGCffyJRTNkHbFJzkc
	ZdiOxw5eXe5q/gcqVoOkr+jdPxfGpjArEY0vR1MISYhOfoJvtFMTK6V2CKHg4RqW
	bZrHxIQNq5BEsQ6/cRf0LBsmPYndSKyIYp0yrp2ZrqUQhiMFPoPVvT/iDCK96TR2
	zY5fZNVZVAdKGHmBvi6UCkG6w++VVOJFZnFCO6KCvXOmlQYZELDDD8B2Zzi5lvIR
	bTtqoxrcf2gcKdRkEcB+HMG9FsHydEv0L+x8MatHEs66ET7++XmKOWU9YSAOe/WV
	GbExOwGDaoVjYnGqji6v39mTu6HClfvwvgkcxew==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:CzKjW2ii3Ii99NcUIE7R3IQcCSwwTZp6oJmN9GEyraE=:Qpp6TZr2LnQu0fCpUcZA+1b0xv6q77wCVX6VfeaszxA=;
X-ME-Sender: <xms:Csv1alPV7r77mU1QBRPAnfIyN0Eyq8uhCVZrfZ_QIjAApbqJxbcncQ>
    <xme:Csv1aiw6bF3nJx6b4GpodNu-DsmWk2lemw2cdwhjPVAndkydL5BJ11UgMzvgUrv8h
    WTa8u34956DxS-YcXJoW2W1cGzrHkDOwbAPkpElhwiDLAJLZOpTuKi7>
X-ME-Proxy-Cause: dmFkZTEObNg9umLLU6xbG7/zXV89KDQzCCfYBEHjjSANLrrtjlLiY2uW4lVziXjkEqJKMw
    XKNREzQgdsZrR9VEWvgYl091p+2S9cwT38HvM+f6o9ZXeDX7ArQxQRxom/0dvdgccvHJ8s
    KQoVaehMfXFDpcPJTRU8Jf+KseI+Fuh3gwSBIXny3wQJxHpGVJ09y07nDjlGSfIYI7nzPP
    yPeFbOTCi7qvYql9hQNyv976yhHdHwdUMRHAPyDEdMnh9Sct4pcvHn/l1EyBYWSP9NBHp6
    EFRdwL0uuGwBKZvKwVYRx5Nhu+SPlpW9rLOD1o3RdS19XbZZD26isGy32pGW9ODsGcVFjP
    6mFM2+VWBb1JKBxs+khMv7QolWaYUeXxg9zCZ1yLf2LnB8S+6n8zH+7W0i8o1TaBvUk4MY
    806sI4+fNBC1agVYDxMI5tGuC52G+3X5UbVEXy9x0dWTYftE0e4KqGQEeymj4HNwHblDnb
    4RhxAFLdyFzXfCK2oOJQ5tWC8ONXuIjGfwJUq1XlLfbsikQri2GGgTJfm9RSEkwJWBvGgP
    /HWxHR1J51wtUT++wVV+JWxJeimNBF3mdFaj1NYqMGSZA0CSJSDlWSdnSJxoAds/dXopAr
    RhQYAS697+WdmObA0ptBXVVgKkvsiVhNvfRng3Ga44/hcUgd60rxS2CsMSOw
X-ME-Proxy: <xmx:Dcv1aixQxdoERAc4bVzvsOZTE0ZYEtgDms2ahp4EBAU8-M5YHfwQAQ>
    <xmx:Dcv1ausdRbBJhCqxEYMXT_msYCWaWFA4AoLQrugRNI8hd8sr4gY5nw>
    <xmx:Dcv1akFP1uWvaiRmrWwLNGG4qVqGhb38IdZJE2l_QNNnWNNzH0tb_w>
    <xmx:Dcv1ak708SsZK0YMmm_yBtDZNHfjEEFAI6iPqHSyi9Q90K7NzkglLQ>
    <xmx:D8v1arbvp7KsVFLrSk3rDjW-CTgilKWVmFz5_djGcM_lckGNErxPLCbR>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id B747032A0099; Thu, 12 Nov 2026 09:19:54 -0500 (EST)
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
X-ThreadId: AytIAyy8u7pB
Date: Thu, 12 Nov 2026 15:19:34 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 "Masami Hiramatsu" <mhiramat@kernel.org>
Cc: "Christian Brauner" <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, kernel-dev@igalia.com,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 linux-alpha@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev,
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org
Message-Id: <18807452-5b89-4b69-b77b-812f8d7acc4a@app.fastmail.com>
In-Reply-To: <20261105-tonyk-syscall_table-v9-8-8d1275885d9c@igalia.com>
References: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com>
 <20261105-tonyk-syscall_table-v9-8-8d1275885d9c@igalia.com>
Subject: Re: [PATCH v9 08/15] mips: Use the common syscall table
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026, at 21:05, Andr=C3=A9 Almeida wrote:
> Syscall numbers from 403 are shared with all architectures, so move the
> toolchain to use the common syscall table and remove duplicated code.
>
> The generated files are not exactly the same as before, but they have =
no
> functional changes:
>
>  - For O32 ABI, the syscall table would have entries like
>  __SYSCALL_WITH_COMPAT(403, sys_clock_gettime, sys_clock_gettime)
>  which is equivalent to the new entry __SYSCALL(403, sys_clock_gettime)
>
>  - For N32 ABI, the syscall table would have entries like
>  __SYSCALL(413, compat_sys_pselect6_time64), which is equivalent to
>  __SYSCALL_WITH_COMPAT(413, sys_pselect6, compat_sys_pselect6_time64)
>  given the new __SYSCALL_WITH_COMPAT() definition for N32.
>
>  - The above applies for N64 ABI as well.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
