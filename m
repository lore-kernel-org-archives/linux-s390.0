Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1037A37B000
	for <linux-s390@vger.kernel.org>; Sun, 26 Jul 2026 07:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785051068; cv=pass; b=QpWQleP0bvRthaRpMbYbNoSfDuHAkOZhuKe++s1DQ9yq0/E4bDK+aiBa9bXRJsfMP5fzioOpdAfZMi5oRfXrotUyHSpNoRzhBuyOhvpv2CIoyefHlfdQ+pe/ysD60e5czN3fddQYgT2epdRC69dCq5Phf5w7YJV4IYxgvieVWew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785051068; c=relaxed/simple;
	bh=i0lh72d2nmu3uu3VDQoHujJQG0QNixt9o8QmQUrkaDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CHecj8tBUd0whn9Qmyz2+UosVT8wGqxXxLXvgpTw1daq2FiZOFYRWBSeGrNDxX/xBpC5bnTN3uv2+ptjg9KWWyxWnQUF2bT4LQ/E9yA5yHAfKCg9m+pKKlSrGPvGzlxvERekuBWhJy3bWGSwTrpDKfItLZJ+qeW7gVtkFb2WB4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrK5Lp6W; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrK5Lp6W"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-848595b338cso1935235b3a.0
        for <linux-s390@vger.kernel.org>; Sun, 26 Jul 2026 00:31:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785051065; cv=none;
        d=google.com; s=arc-20260327;
        b=IWp+IqHNDQPmxELfNBXVrzq3ZP58httjzZLgnDY/XFdcADCUtvPoZohGpX3OeEWayJ
         Ll27fBoY7j8l5A+cCo9Mka0urOrs//4ccIrJU00Z3JHRtcLnEWbluJnpodQwyhWLoNMx
         LwHfnO7Wz1SfnKK4wLqTRsHSOE/wkGKEdLtYkh6ZPMl57QWQnFkVVpwTrSIOSvUFx/iP
         /hCnB/kIIaojnwrPC+BywXSsDM0mUaaOm3Gf32h8SA44Twl2Pev51J0WLXjgGxK0aVuc
         iqsk0cWgz678v1GKZdDmNaM+aSFCxe3QE8wVWRFfZRb4Za8IHIUbtNOfpM/zG/Fo3KPH
         tiww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LZTVSxKYFzxJZaYDAFPYkohl9eRKYUawYCXhr4l0HQQ=;
        fh=cQvjkJ3gMhD/bg7Gs4vS7jD9hbqT3RidNaYetSX1Lo8=;
        b=Nhh5HwzeXiRytidAln0/fsBM7Q0uWcc+iBsvt5JLHrqfPjc3nvFhmkD1+mIh6Mj7P6
         60fnM0J2+MGJRP1aYpzMj0dZWWmGSps4q7rYMMKNBiIAk+8oWIKOkxJcvhGs1XTVoYDF
         XuyXVUPZ71FB+IHw7KvTdqdSlhqGkZ4irxSVr5mU/t561AXKjSLIrsyhroYhdjwqIjWQ
         sfvJ7xL1J7d+HgDOW+Qj0r1zfhPyeoYXJDNz0t8NxvWobou2dLz62nfWT3k6eIuI+qwY
         rXiJfdothcN1Oe6nJdm+mASu89Z6+f3xELBs3NY1yrVFfq4EF0Rh3E7TQzgL1PGnn3wK
         FsyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785051065; x=1785655865; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LZTVSxKYFzxJZaYDAFPYkohl9eRKYUawYCXhr4l0HQQ=;
        b=ZrK5Lp6WqJQ4AYEUExlJ96qEozJu712C5w53xvpoTOGRL96QqYfaHp2RmF753iN5bo
         SpbMiuR/Rrr6NF/cirypL9oH5ccFJu5bTk5LzZmmXhUqeg7FVeM4fTLlYxpoITkSGNR3
         I2Um1YzhaO7tB+9iew+TAmbV46K8WlZPKgh13IKI/eze+xalGjRmg2DPm7Yb1PTuegy/
         MxmXX75YGz7gvyBYyFHTMjrtevUQ63b9cQ+XCIYw2mH1awAMLl2FHoDGAuf6Q59GTmyB
         e/a4KhMt4VrfzGIH4psfiIcGyicDjqv+g4+ML8pvR1lnV4M+UuNinfYSKlsY9SespX06
         E0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785051065; x=1785655865;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LZTVSxKYFzxJZaYDAFPYkohl9eRKYUawYCXhr4l0HQQ=;
        b=AA58j6ycqQfET/qIKPwmRR90EoVKosjfu/u1hMbwNFvhTBT8uWGrL9GaM/J0nE/6d2
         PC8rl2xi7TWzhb3GNKYiSdUgGVl9mxkh+6BvWcKbruszQWS2WMzHdGRD6Cn+P911SLGw
         0T3/1JBudzgerqe2feHKZFWIx5ZP9PPN9h7E5Bd/wQ7AHPny9AqfjlxdfHMijR/BV4GY
         LtFD6AEi0e6iQqrAz477L7Eloo4HZ2bbQFfFi4OiWtgjaz9P1Cj6ITIXbZ8aJ+hy7rHe
         DJTY6CPweiqS6I7E7xoZBCId4m+X7ih6fLqc86Wl7koMaTw283bgLUu84s705LlLBSTN
         pRVw==
X-Forwarded-Encrypted: i=1; AHgh+RreszBQZOyPHxXn4YkyXfmkt/Gqp/Q7DgCIDxPFxwkMvEMdmC86WzpGXttTq/0HAqEx6RNC83USas3H@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwi4iaKEOLm03NiLWQHd/uaOzTN43Nfb2C2zwaSL59NuCxn28/
	nMpXIBA6xo/wcXPbM3bTKn/Be7pZNawD1S1iaj5UFQ9bfgCDauEAiOJ+MFi69aEcC07Cq5topFS
	jFr3B6kW+tf9FcKhoTEOH+1UF2cxGzxU=
X-Gm-Gg: AR+sD13JcoIJFlX4dCYy+gV9rmSVDrYL2b9iN5LQbWjlXP17Fp9EoexfoYbC3FueSuL
	2rmKN/ao3ZhRLV77jPWAIUAHioCqWspZ7/CiiSJhVPREzpeE/CIQt3RJIQSDuc2q0csAovwmYAO
	qyk88OKmXpJHtxkJYIkkWnhFiI5mhl9TPzJbzbnOPqOUmzF7dMr7njgUuf/rMosU6dQ9i/vPirE
	u1LV2IgwSTJAIVBITqxOFokzEi4xXuTH0t1ieZFR2Vs5Bud5Y8uJz55ICkvsg==
X-Received: by 2002:a05:6a00:4213:b0:84c:4d9a:ae42 with SMTP id
 d2e1a72fcca58-84e59498487mr3719808b3a.27.1785051064667; Sun, 26 Jul 2026
 00:31:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523-af-alg-harden-v1-2-c76755c3a5c5@gmail.com>
 <20260603133312.12848-1-freude@linux.ibm.com> <amOGWwdjnJqyxH5L@codewreck.org>
 <20260724160034.GB2032@sol> <amOTjPW__CNZui3_@codewreck.org>
 <CAFLxGvy+ec3nQLrQtwFZgGELhT2pKBDnHdD0pMvEGh-Mf3rjgQ@mail.gmail.com>
 <20260725220443.GA41199@quark> <20260725230922.GB41199@quark>
In-Reply-To: <20260725230922.GB41199@quark>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 26 Jul 2026 09:30:50 +0200
X-Gm-Features: AUfX_mwtxGS7a6c5QzhlmY01HvejyEPiuukikmfTBc_9wA_H1fyNyxlq8igMsLA
Message-ID: <CAFLxGvzT7jO+dxLSUgw0SOViuV7suY+Tz8m-RE6DBVfF-WbRUA@mail.gmail.com>
Subject: Re: [PATCH 2/3] AF_ALG: Drop support for off-CPU cryptography
To: Eric Biggers <ebiggers@kernel.org>
Cc: Dominique Martinet <asmadeus@codewreck.org>, demiobenour@gmail.com, 
	Harald Freudenberger <freude@linux.ibm.com>, acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, ardb@kernel.org, axboe@kernel.dk, 
	corbet@lwn.net, davem@davemloft.net, edumazet@google.com, 
	herbert@gondor.apana.org.au, horms@kernel.org, io-uring@vger.kernel.org, 
	irogers@google.com, james.clark@linaro.org, jolsa@kernel.org, kuba@kernel.org, 
	kuniyu@google.com, linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, peterz@infradead.org, 
	skhan@linuxfoundation.org, willemb@google.com, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2026 at 1:09=E2=80=AFAM Eric Biggers <ebiggers@kernel.org> =
wrote:
> > You've only mentioned that it "can" be used in this way in upstream.
> > Can you confirm that it *is* used, and with an actual upstream algorith=
m
> > name, and if so which one(s)?  And if so, would you also be able to
> > share whether this is for dm-crypt or not?  We should remember that
> > dm-crypt accepts keys directly and AF_ALG is not needed to use it.
>
> We'd also need to know whether the user (if there is one) requires
> unprivileged use.
>
> Hopefully not: these sorts of hardware crypto drivers have lots of bugs.
> Indeed, the CAAM "cbc(paes)" doesn't validate the key length correctly,
> leaks DMA mappings, concurrent requests race with each other, etc...

Uff, you're right. There are some nasty bugs.
I guess nobody noticed so far because the algorithm is only used a few time=
s
at bootup (as root).

--=20
Thanks,
//richard
