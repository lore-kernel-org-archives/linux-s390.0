Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493063;
	b=kn/DZgBOLJOplCN3t/VQ3fR0HFj+Cv56yI5oEUY1/rvAbH/Eoq24cgGCxjBDyP20k+JK
	 QW6KjdAYfTLAAenJ50NxX6wis/kerAagDDve0KlKhjAtvYz46uA+ua5Yr6MGUtGoVE/BJ
	 SHQIGIwye4AwCjCLq/rjHz3+VJ0NcifnsGerNrV+Ms4G4krL94JeujRGlyx+rCeGVnGEg
	 CfD2Ji0/vb0Cdbd+rh7zQcQiv/XF9Ob0JWj6siu3htyFz6UGtEOzrnbdxtbi19CPI3x3q
	 ygwad0A3YPmyl6bcDUtycqFphBSl6MhjmrYUqozJ+qY1Q+EFHNMJnvohslvZYUSXhMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493063;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=Dl26GbVg1oiRuWqjJg2siO0OK6Jj2MIKjLQSLXLLVvI=;
	b=uq1Cbxrwix5OoPErrJNhzIw6UourW3cJCXsCGPj4aZglSZYqBAKBL5YNNxIuEUQ2VHxb
	 OefuA0h+/yRbtOmWxkWqcQNuHDQ+ciOCXbdS1Lm1ewPYM7utBgy8oo9Sy362gfNzlaTaR
	 b46iq+Ygkc5q6I8DOYv2B7RSQcPdtLlHunLnvor+MgPqdOYTCldg27QAemKKib4WNjZ3t
	 AfZFX2JzOCUn/s+svx5s/smXT+zOfEqLaNJChyXUwWvBneHEvw54V1vVGXYc5n5AX+xed
	 JE5RnoL3h8S9Aw8mT6b3bE0ywEamp1/NMfiUYa+1AitITN1VY2oGqUHlFvNywaIKSSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=BgDCCRZe;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="DjNFiF/g";
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB9460A2615
	for <linux-s390@vger.kernel.org>; Thu, 12 Nov 2026 14:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AB9460A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=BgDCCRZe;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DjNFiF/g
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5EB877A00B4
	for <linux-s390@vger.kernel.org>; Thu, 12 Nov 2026 09:17:42 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 12 Nov 2026 09:17:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794493054;
	 x=1794579454; bh=Dl26GbVg1oiRuWqjJg2siO0OK6Jj2MIKjLQSLXLLVvI=; b=
	BgDCCRZeMAYVP5Mkj3rC4Dx0zPfpuVx1tHrvLPUjMUiE9v4Th8qYAkXqf30BhCsD
	AbHa8yCNbVYzzKPm6VaDXRF8TdKbbwwygMupuI9lRPeiB+IDkvWyGW1D2U8LDwRJ
	REBa4iHNytvQeP2cdQ26sEhXGgegb4THLEYaB5KxSwZMGoNreZAuoETdNSs0RqW+
	WiBU9wK11SpZRjP5h3H1afBYZFpN8N8XuvWNoXcMlRxxEHVk9LCpYojqMa1Xvicg
	70gBugV2yVntrBidoQA1rZ8KpsZUR45dNhF9L3iwDGmHFtO0xoiTHXZ9m8LBSbT1
	Gj1Y3Cb1MebI7XZb6ooSiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794493054; x=
	1794579454; bh=Dl26GbVg1oiRuWqjJg2siO0OK6Jj2MIKjLQSLXLLVvI=; b=D
	jNFiF/gyldbSf72yF03RPBfvfqo3QLXXUSHA23Y6f4JFfRjITQ7MR51oKm7Y/m36
	G14pKndIrwIwIEWh4evUxSara5lSHuTGH5v3E7C529/nAlq7iy+MzsWTt7SChnvv
	wR74cJz8zTVpv0G9nWezRB/Gcx+RGnsmh16nx9Ykl9V549U9Ue1j8RaRcDb3pK9S
	cl7J1H35YxYrSWKNWiuMRiaQK2fYo4VUCev3OID0lZUb7Ganbs4EbC9Yhbx9jp97
	7RvuJGYg2tcBAzBE/9bQm9U2sOxfdscsQvcvwzCDVr/uKZPvOd53IeX+5IbT/fsi
	U8yGmb91KO2ihEzrHHKow==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794493054; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LXMzOTBAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:iqChA7SX1OWg8rnCEOfl9bgl5QrOkwCWDvyldVQdRbWIGtg
	r1I0B93HQ+Tv4rZ3JO5DnfdbmVIVSC1QWLWly2sxGU0hAK+Wy6IZWl6SELVODzDz
	Jx7Di9Y62++J2IbW7zEpHp+2nHFsSsuLb8kfxWmtNxHFoaRafDJ9JF/2m1Dfp+nJ
	lZoStEIThc+g4m6wTad0JqUt5mQdqQNe9SLe516iAb5gmr/Ls1mt6n1apa7lz5er
	izi1uu+nf/RJTG+IwpdK2taGFetBBkJiioMDlu++oPQnZ+4wvrWAVpRBJvZOOJ9s
	d65eW9eHEvAhiyICRltLR9E+LO/CBOHfy7N61bA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:pDEDEbEGIMSKrrCLp4vJbOtj9ftXD25ifr3Txi0ong0=:ihnDo+fn6sT3wW2JYtL6VV4KZA17ran4u86UJkWTYTg=;
X-ME-Sender: <xms:esr1auMX3thMxma8_ztiAYINB64rYZ1OoGq4Lba2qMVXHlnsLf0gBA>
    <xme:esr1anzx2JrsuiaSpQUKP6BShu4yxdXEafjZevf5iJ_PSj0AagENZIqZNG10Dcy4T
    ZPNvEMEVMcjlsml9O8C4afEUZuRbLQfVpMo61KGPNgTymIh_lFs2RhP>
X-ME-Proxy-Cause: dmFkZTFzWmoFbTkI7ku6XcdQ5hmYHvBEWKmAFPbxx+KR4fuDHIzPXuKeT0NCsMF/OpNsoS
    vNCHz4+rbPFGPxzWkj4fQ2mhyluj+KuubUvMLFtq5HTh8zcdQVazJy1ZO3KupoUgNX/HBz
    UK3ZMd78YWZnDEkDu4jfayCCjWchMJCp0hVux7BUm7FZ+xpkw2l21dm6hf65cO0zUU+UgW
    0xJ4JOUkxgcOjmsQHqWBoqOPcyOeq6m7PU2wJyINkQmiuXddixOgB6X5MZXIUgZ/6A+4gi
    /2GHdXAjLTRdlPJq5XdS+MaFOnCet398jadXoGZk8QwjUY1dNB1DztJ7N2yCV6k9hzAVt3
    YERdmi3cxnlo2u/Fr4+/jwLaSG8K06vfncSJgdAFlvJ9IZGhCtFH+SA/c0iKVjdqoj5RmA
    mv3O8ysmd1Cx9w7Iwck1JLIDnD/UEoV+lxqpTENFt8z9V1QbqGN/lRqpkoY/m6DRdJidMW
    voZZDuRV2L98fCiOLdzGJRQQTjyvEhk68t3azBy+bMrHBalh/WcEzV+mgM1qMKuxKND9aV
    vsGkexNAZg+vqQ+h/jjW6Fj5+BMvdn7a1tClce4EYlaRMGvOt7BBw9XmDobvscVt9D7sZM
    RfuxKt+2V07xyHeeQwiwbV2R0EDBQe0yXWD/ukogazvfc1OeoSWp+n1b6YgQ
X-ME-Proxy: <xmx:fcr1arvlfUZ5zY7s63oNATD2IKLwoP7oPXxeI0fDqUY_oT_MsXprtQ>
    <xmx:fcr1atFCSHPOQGOFSy0rC8QHirVbD09Ymq7u5Mr9nEfXsj3MYw9Kow>
    <xmx:fcr1ap4ICi-1ZsEaVt5Jq2HXR5jOvv8K2T4XspKXDbRfuzr58VQ9pQ>
    <xmx:fcr1auypVhvDdDON9TS-fms29QCLjYsgXsSB-RHjS1-zByWAEcyaHQ>
    <xmx:fsr1agLFJdgZsVPD-Yn31hgBLVw90wdlTHc07fX6wz_fVaKteeZn42mv>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id DCE5932A009C; Thu, 12 Nov 2026 09:17:30 -0500 (EST)
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
Date: Thu, 12 Nov 2026 15:17:10 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 "Masami Hiramatsu" <mhiramat@kernel.org>
Cc: "Christian Brauner" <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, kernel-dev@igalia.com,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 linux-alpha@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev,
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org
Message-Id: <cf0ce4be-43df-4341-816e-4d7f4f486beb@app.fastmail.com>
In-Reply-To: <20261105-tonyk-syscall_table-v9-5-8d1275885d9c@igalia.com>
References: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com>
 <20261105-tonyk-syscall_table-v9-5-8d1275885d9c@igalia.com>
Subject: Re: [PATCH v9 05/15] sparc: Use the common syscall table
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026, at 21:05, Andr=C3=A9 Almeida wrote:
> Remove some of the duplicated code by using the common syscall number
> table.
>
> The generated files are not exactly the same as before, but they have =
no
> functional changes:
>
>  - syscall_table_32.h would generated lines like the following
>    __SYSCALL_WITH_COMPAT(422, sys_futex, sys_futex), which is equivale=
nt to
>    __SYSCALL(422, sys_futex)
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
