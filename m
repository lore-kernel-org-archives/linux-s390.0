Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263305;
	b=Ni4c4YP88pavOMbOt6deeBvwAZJVY4shOEehNohryXkmwDeYWGYEbwTAgQNensQcoGLI
	 oZiSG9lPBU8rQLGsa/ZEyIHfvi1Gv38w0bye6UsLmlZS0nV8wat8lSKMB3zrTavTz7ACL
	 XyC4e02cRrwnG3ZnBufhVu02XN+KnIGRdHZf/FDdZpUeio1Gg/9n5c1pWMjx/YGaxF+9w
	 6uQLwg7NIM3+8t+77B9r8a33ZaFTi5zIMSh11/2pEbOAHsthc+36G/7tHuHcmhhiVPW2C
	 dmXTVSqGqT1YfwxfToECVYqP8FA9JhXIJfiOYkhA+jVhA6LREPfxZ+Y8wma82M4n5Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263305;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wtPUlrl2WouwwasO1djP1PXesd/2M+Gmwwka1rOyiP8=;
	b=oassTyjEVltwcGGuFf9yErzcRGgMgD67oUofk2cM4bWJy+uCawkXhrdlxJCTLvDAWFLD
	 oGN2j1oPuTMw3558BW2Lhft3T1v8OU+tO0B/5fq0b7GvV8MYnMJB81CRk37hCsRocmCpr
	 6I4nuUagb0DuZDfcThYFG2fsrwvT8qN4sb7MZr4RkkMNXaGWZiojzSmXMcdfSoMv7jhAP
	 5B9E+rYgUgdmPzE2kGIuJqC/jIv/qLe0g0WEI2ApjgsssXPlpw7yHX9Rl3tUU+z5GaWVr
	 Bmvd7deHyhp0ZykYY06bgCuxqxuwKHvTpTSnLlbN79bnweqq+Ql9BAgMB6tqqH+ZUMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tf7tfzC6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F32606A330;
	Mon,  9 Nov 2026 22:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tf7tfzC6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9F01F008A1;
	Mon,  9 Nov 2026 22:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794263305;
	bh=wtPUlrl2WouwwasO1djP1PXesd/2M+Gmwwka1rOyiP8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tf7tfzC67dsP+You/Jgvp+Ib8EhQVpAd0FmVZZltZWabJWaj5HZaWMOv68MvkdXHq
	 M+vqygSeV+NboGbYxMYXwu02nyuP9RDW6b9V7GfIXcCWoKss4nx4AjQ68WbHjqmKAu
	 SIxzL/9cMhcHPnmpC6o51Gyhoi9DtvcnAJbPHRTv9pjLj6JzaQceiBAown/UVLHSP/
	 K+vFr36i5iUdVE6yranIBYsvUYA/WaobH8v6L40VMjzEeEQxeBaGbJ/pIQxivXjqru
	 O/9S9z/LiFTMi52wP+SiDMYwjeaCyqwQY4YKAqIPT7VXeSqz/piZSmWLMH7w+SYS1P
	 5SLeqP4Mm8PUQ==
Message-ID: <sashiko-outbox-205728@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/12] dns_resolver: Move the key type into a
 separate module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108222719.304712-3-jarkko@kernel.org>
References: <20261108222719.304712-1-jarkko@kernel.org>
 <20261108222719.304712-3-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 22:28:24 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Once keys pin to the kernel module of their key type, having the DNS key
> type in the same modules as the resolver will introduce a circular
> dependency preventing module_exit() from ever running.
>=20
> Introduce dns_resolver_key.ko containing key_type_dns_resolver. On a modu=
le
> exit, drop the credentials and call key_gc_flush() in order the drain the
> remaining RCU callbacks.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108222719.3047=
12-1-jarkko@kernel.org?part=3D2

