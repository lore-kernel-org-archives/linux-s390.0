Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BD14908AE;
	Fri, 24 Jul 2026 06:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784875028; cv=none; b=WrGW2cc8pljxY9fDFHV+IH4EMK7D18An/sQVOMeN/LNs1cAKRqSTwwCA74NSoP015j1GUvwTq6BpRbZVL5U8gUSY4rOjyqnaXK32GmALuaAD03ptXxHf/gltsLW/WNHuLcNegmmeQZDbGKDKRUEhmyfiJwvcPtbsUqb6H77DtSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784875028; c=relaxed/simple;
	bh=PL+cFJw+A1mVND9tcmXNWtL6i+LZP+ToNTcw6ge+K5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ts+he5ViPSj9q9auFrY9qzJWJiLXNsCMA5kidRGWF4P9PsBuaYc/sLBL5Xo5deG7aRSL1RUhVt/czodXulVXZf7JLOa7Lx2QZoBrUFEfzwUz9G5YFHuXFLpTybKvkCwao/XlzN9HsAPyYTrcIcG29z9GpEPWCRv1XVMfcf0ALm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=Xb3VqjiR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E4KRqURO; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Xb3VqjiR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E4KRqURO"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.phl.internal (Postfix) with ESMTP id 0305713800E3;
	Fri, 24 Jul 2026 02:37:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 24 Jul 2026 02:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1784875025; x=1784882225; bh=PL+cFJw+A1
	mVND9tcmXNWtL6i+LZP+ToNTcw6ge+K5o=; b=Xb3VqjiR6ggHWM6NVPVt0/BKjK
	bXhw8MVXE53YORvHsKkzqFzUo0IXSWczqFvOIWbSRPiwBhh46d2l0+z+48E9jAqH
	bxe7UetM5rYAxFCSSENb+AqeMCfRX/vMsrPbK9esDop/Y8j4NJNvnVZ/z3g0dcT0
	L2+pH16ElKFfxaRZa6JWMmCiUVARPMBID0lnFdr4BJNAu47ej/Zc4a2QaQdoB6Gl
	J2xEZ/u/cipp0ccjwklA+tNT4ScF2nDFkMuszDtZkFZp3wRp8pJm6YNz3cHYLg8j
	gFrxXGM41jq+Q7ns2NY7rQlvB/4cmUxhTjnwcgLeh/cm7wpJRl2QV8LjJ5OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784875025; x=1784882225; bh=PL+cFJw+A1mVND9tcmXNWtL6i+LZP+ToNTc
	w6ge+K5o=; b=E4KRqUROThBmzor2t/zYxQJPB0ip9oJCkwPIx7cIxB9Ker+R+Cn
	N5Qhu+Px3qugUOgFYhTi1FeLsql8Ia7evopSC0nShTfPNGF6WUOM0YsZjbcrR5tT
	T81nmIkrQZb6Ke4YWb2yQksAPjjSD8bZOvlpm61vSSjusYSklXtqDFfZbcxDXqDa
	SrJC/zFzC+SldTBgkkefxcFfcpipLKfvr0z/Rw+0jC4GoBmW38pOmBoC+XuCDvE3
	iN9/DKnMKgVXZblyIWkWPBZvtgTgaMozBLRBdPDW1d1cTWcG3v+x2rWsEzN6qRno
	qLPLV55uDV95wFR0kEu1tTQRZyYyfGvoQpA==
X-ME-Sender: <xms:EQhjajIahRpDyx59YVAOkO9j9BUpR9uxdf4NYmtzk1PkrESKBsCdyA>
    <xme:EQhjauHNIWSuwlIHsO6uzb7ivHVBZoemkAjWhePEi6brT-Uf-ZGGzNBKMW50p8xYF
    qPz89Bhiw7xrvpSdBHTLPfVZ5ZZ-fJ_4fjIu9lmwqFLDiNK>
X-ME-Received: <xmr:EQhjakoEPLUhORWZwQ_c-AwNC_8xjyXi11gYR8EY2Qqy7l8h3PyRGhtHyOLOrsc-CR_SEeeBu1q-xLerES5QGQd5KA>
X-ME-Proxy-Cause: dmFkZTFX5iPjis1+08aMQAfG2anV+zBI8zmH41Y47VAyCiJWTyfwZ7ELMO3BhcMlLZKfMW
    fDTWyOy+PZWlS7Kx0pAXG7czUqKvrgCi4q51xKfz5cJLLsvJYphO9ETeTeFDNZQdXHYgVe
    im9wGVk+RJ1YLmeL6ZP/396+9lUxfFYoPLWLGBYHqgNXSvw/ruBoPyxVtLKOQH5nhRPvdR
    fPHAtRIJhLDkZXwHO0SBQfKq71gLj6p7ksc4llFPpIUa4UxdRtbYrMBU2cLrxeU9FSZFR6
    T/Dl/+RyngkiZN++qOZL1XZFDdA87kiubCGqiBzUY50/fHnnxgbpsi5T71PF1j+rW+aWe4
    U+RWmDRzPaaUjDb67h3Hud9a8QHWQXPzNYpCRWV0gfiL0b36vn73tyFYXyLtZYxf83lYex
    BAYrhOEH2yZOV45k1hcrx4tL58/D8YLiPf3UX+jOKhtBVEig5hCZkJNc3xbnIlmN0alFY3
    wTvD8qtj/WfpTIXxH4MRj27kg+Fl4lyOH244mmo+idDPzQvNCNCOiCZWcZEOdpBnCLG0OI
    7EnbERLSfCi5pK3SzHsEvYSN6XmziCBTZ749fxUlpBbovtejWaVQHI6IuL6sGiv+sVlwOq
    rZs4nn01uxi611kMHRlCXh1MR+K5xAior7grBjFf5EjOl6Es80nyEMChUgEg
X-ME-Proxy: <xmx:EQhjakNHbpMmHIZHJawQiTeRof7s-JdEiu5ucVVYtVXP7Oaw7YrObQ>
    <xmx:EQhjakpsS4MslApj7D75HsFHPWK_7d12Z9JvFaPFyahEUKvzLRLgoQ>
    <xmx:EQhjaqnYAKr85uSFUQ5G6PT_zyUwMPJ0HXTlHLpJiecCpxUogLlgAg>
    <xmx:EQhjakw00X7KtRLLhmGIgmuXgLfVGeh3u-g_-BfU5q9hJUYEBHj7NQ>
    <xmx:EQhjauW8KJG8te-aYgxBMw9UXPqEx0i5V_L5rEes977ufK1ky-lM76Yy>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jul 2026 02:37:05 -0400 (EDT)
Date: Fri, 24 Jul 2026 08:35:42 +0200
From: Greg KH <greg@kroah.com>
To: Min-gyu Kim <gimm78064@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>, bpf@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, security@kernel.org
Subject: Re: [REGRESSION][SECURITY] bpf, s390: verifier/JIT mismatch allows
 unprivileged kernel memory access
Message-ID: <2026072436-carload-untaken-585d@gregkh>
References: <CAGKGUvm6sC9ay98zsYJS1xwB9+qUwverqAsAAwpVOpmqFpEy5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGKGUvm6sC9ay98zsYJS1xwB9+qUwverqAsAAwpVOpmqFpEy5A@mail.gmail.com>

On Thu, Jul 23, 2026 at 04:55:12PM +0900, Min-gyu Kim wrote:
> I have not yet tested a patch.

As you have a reproducer, please create a proposed patch that solves the
issue for you for us to work off of, as our security documentation asks
for.

Also, as you cc:ed public mailing lists, there's no need to get
security@kernel.org involved here.

thanks,

greg k-h
