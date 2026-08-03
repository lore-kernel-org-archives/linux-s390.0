Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E9A3AAF40;
	Mon,  3 Aug 2026 19:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785787036; cv=none; b=cYhtzy1x2S6iFdw7jpnpzKGvfZAX+ZWoBcALAaiazUpO7GaNZ50fwzfNtlcZ4FpqiiONP/QLf2i9jckcN+ot/Y5q+KtNYhPy8ED0rAndcmope9lYxCD0zke1pAzeD5occ+4FV3m+PvdGJHEI8THL7F/0W10TFwHkIpo9hoYtH5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785787036; c=relaxed/simple;
	bh=fCRsNkCEqwHoPRilNKFXevRP0xgvCmY+zGu4aEXK1PY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=vA4gE7nuYpCAqWHMWdFehJ6Um2Kw3o6dJRta1VghOpWxxpKKB5Rx6k8E2KhZ2CrjCo1i5gMIdP49x9N9QXOZ2mVaQsPyQrc4TY6oAlPX7Fzl6Jg3sXZttz27Ag1Z/Zr0WOEt3O4ZlVVwiE2c0m+CeffgAseQyK3qcBx724IPmfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=FMSqh3F7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HUim8J+K; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="FMSqh3F7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HUim8J+K"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1519A7A00E2;
	Mon,  3 Aug 2026 15:57:10 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Mon, 03 Aug 2026 15:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785787030;
	 x=1785873430; bh=mY/6rvzP69RzWZiS8I+ni2XMqznB7lR2WoXu0t0T/WM=; b=
	FMSqh3F7xWocGy8NDNvDYJrEAHyZOUhYRSzY5NB1iSEexYFvylBCWGNBXO1rzx7F
	o9KgjFrpONh/qd3ynw7yOzdlv1OFIETRsOBaQ00hbdiQ4HAbMyhTzzeWeHo5yyUE
	e3IJOQ6456SVmIUKHKaP/WMr84zU3bjLNiqPH01F6XSmtUd7j9rWaPPGI16Hyv7d
	fbjGUOXg88DcPWTvvh1DHgTmxGZ5IKaK7XIda76boMTdpaOyOe9U4/4W0tiMxX6E
	VNs4L6iZVHVGFM7kxUgPq2BGVd3+HIBhD2XSv49qleGQ00/x0E3eQBikjQta39oN
	X95YePgmmGNkH1GoGg+g5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785787030; x=
	1785873430; bh=mY/6rvzP69RzWZiS8I+ni2XMqznB7lR2WoXu0t0T/WM=; b=H
	Uim8J+KgTVTLi2hsoy7OofZI5xG78XjE2kmv/6md7QkzEjT9s/xGL2w5IK5UudaJ
	g90C8CyONmUbq6vQjwvncjW+xJcPsqxtbNoLYn2XLfOrR6iqXOOeH3Bc3BmAEJZp
	v46XNbzsKWEBLrCVCN/9ue/WdAQc6Lf7eZ2UzEe9N9PUtDLm0F9IRP/m3nLYDtmH
	m5Ez5prAT/Fq6/OUhskID7ChbxCsJH3rF0zJsQjBOH/XfViV76S3wuiutTCt3fJF
	FBIWqsyxB85gz2lPh8PsMLwrT1Y+yduMkBqaWX2ux2lPnA8igyvlBZJAcZ4lw2FU
	+i9Gi3r8hA1vzNqv2loUA==
X-ME-Sender: <xms:jvJwapNw7YUa1NYb3IPz6czPdiGiEp2bWwXlLadhDO-KqE6mdoEGjw>
    <xme:jvJwamzUT3YTFNCmjfzGzhe5mkHOvU3aEiRV0qyEFG4Wmz0noo_A6cIHMX-X9gbiZ
    jVMGVPCBzFf-7YRhBSg24rVNHgBE43NnZo8P6AfS646Bg6ZlPQ6ANSQ>
X-ME-Proxy-Cause: dmFkZTELVz7Dq0P2Ik40Hp2ZlPiBrx6xzy06ctQJZXTMC4c9UE+/TE+8G8kgQvf4TgoyFH
    sOrv0hg/GzbQXM1zowmstQ6IH0RXgDtIHNYUmdezXf7fZA2KY1yQEqL1lScWuBLCRgN3/l
    nLZIqAOqH5+PEvwR9ZqfEhI202LyT9rqA6HSYvW8hFHpW7z1X1O2HHvcVEeefUTLgghUkH
    9o+bLULGn3TGR2Fkf3VDGeOvaUavNnZ0tNS0G3yVHqwtV7g3f0U/Rc6yqsu4gvEq4jinin
    aSvxWRl20dqqWMMsZbZvhbV0Iv87VQg8fIK+0D3P8rK4+UE05pHh3ZN5ForWbl8B3X6bEI
    cfyFtZjuFQXP3k2wsqOdX1HxP2ps550rQpUkxt5cU+P+eRIzij9BwIJTCueSH8PupHhW+Z
    uiEm4OM8r7w9gDrGqHw+L824Eu+v1COImDaEtVZ4RpSeukP8IUMLJgn856LBrncNUiNxgb
    eYjCffzwCRb9CL79ChUZY0POWUWyTONNv38SVj3dxt/wWfnNpTzlLFhTZMMC0EQ6xOc3Ab
    x9jK/L66U8xL9dTZ2ImJO1zYYGyGGULpWlwwr024YqBQZjmT8u/txUe/C0NLvjPlt8nbAG
    Dh0qCpJGgKnidqiikMablEXB9ORNv2gs0E2XG/xM8A5k6zbwSqyBdW5jjj8A
X-ME-Proxy: <xmx:kvJwatkgMBy9ffuDy0Ywbore37u-zese6Z6BV2w0SO0tAFd1JLJupw>
    <xmx:kvJwasw5N4LIUpBvW-Uh_T0Y1-HZuGtsEIe9oD2s12DYqYlveDNOkw>
    <xmx:kvJwasIjPohHY7QUsEC-NPqD9mmDV9LznBiugmBtvyOUx_kcsgi7Iw>
    <xmx:kvJwanKWSXv5L7gWn4eBe25STB3rI5BxM9dP7nr9L6PN1jJR3aftsg>
    <xmx:lvJwanYVd8qxuTOA3k1cGXq6LGl1kqodb2mwZCxgyKvH7UYnQjI3NNLR>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id D7B7132A0064; Mon,  3 Aug 2026 15:57:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ag8nwV6tN_57
Date: Mon, 03 Aug 2026 21:56:42 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Miguel Ojeda" <ojeda@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>,
 "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: driver-core@lists.linux.dev,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 "Benno Lossin" <lossin@kernel.org>,
 "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 rust-for-linux@vger.kernel.org
Message-Id: <fb2daae7-4eba-4ca1-95a5-60f8157eb66b@app.fastmail.com>
In-Reply-To: <20260803180931.97202-1-ojeda@kernel.org>
References: <20260803180931.97202-1-ojeda@kernel.org>
Subject: Re: `io{re,un}map()` build error in s390 under `!CONFIG_HAS_IOMEM`
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Aug 3, 2026, at 20:09, Miguel Ojeda wrote:
>
> so e.g. an `allnoconfig` with Rust fails.
>
> I assume we will need to `#ifdef` the helpers, plus the users; or stub
> at some layer to avoid changing callers.
>
> I hope that helps & thanks!

I think in practice you'll find that all sensible configurations
will have PCI enabled since that was introduced in the 2012
generation (zEC12), while the oldest supported machines in
the kernel these days are from 2008 (z10) and Red Hat Enterprise
Linux already needs a z14 from 2017.

In theory you should be able to use rust code without PCI MMIO
support, but I can't see any practical downsides to making rust
'depends on HAS_MMIO' to avoid having to add those #ifdef.

Note that we already have 'config COMPILE_TEST depends on HAS_MMIO'
to work around similar problems with random drivers expecting
MMIO support.

      Arnd
