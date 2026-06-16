Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA1835E940
	for <linux-s390@vger.kernel.org>; Tue, 16 Jun 2026 08:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781599525; cv=pass; b=WaqKySDHR7ZLIgIg9YmAgTF8hpdz/EjwG+Lw+vwpPIXXKTCE9f3fw7DWSoLGRG+WbiGUT++SmbJJwV+S5gKx4fWHXTQcNc3wGGIDJhi5DJzTXAXW+y62NMQwrG7JVVyRh88W8MQD8QvcflHhZpu92mUa0/peDm/NUlW5LCBYQh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781599525; c=relaxed/simple;
	bh=0Saf9Ku0AdbaZ27kploZ5WAYm1wQnaE0aLpGzNXq2UQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uFQrktO/KLkvcY1YDEeu9kRG43x8P/zc+K8vMaC07uXmBq373kBxfmU73SB9GrwA7R/pB7XVbJ+0rETCI1UoWrLPB6OeD0EcNxWc8lug+qLMZAQs0cO2pcJaVBToNRzL9uy8QGVEMZoPGRehzDvZ4efuKsFvvYgXoOQH7urshVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HS8GLNx5; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HS8GLNx5"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3042a99f0ceso534816eec.0
        for <linux-s390@vger.kernel.org>; Tue, 16 Jun 2026 01:45:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781599523; cv=none;
        d=google.com; s=arc-20240605;
        b=W9VgrovkngBc4jzeS+wsG6uvzcqZbfzO7et0QWVSFjpPFvl7b+n7MNYdyhNBZVZh3x
         Vcmqif9teqJze5Zd4vNCPYrZQHUdKffSVqTwYoN7KHFnt0GNfpRZ8Kqbe+b5MyRaLBqZ
         liFJqCSLfT+qOJJYZC5yTPdpMvxUraYGVEc3EWc2c391E3dOxzlaDeukEvD6T4rbh+RE
         XJwQobe4+KYhOs9Q5TNPFnuSvI7a00Wvp6bDhoKu2ixV6RCw9WN+FyQrbv5N1++EVS4w
         AKNoLSS8YeZJJTUJoQPwjMs+RyZp9VI/Efy7t71ekI6KmGoKCzmH10djFb6SlhU6OtEe
         m/Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0Saf9Ku0AdbaZ27kploZ5WAYm1wQnaE0aLpGzNXq2UQ=;
        fh=T3I+9M8TrHzcNAjF1avKJViNuGeeIImS92TJAcheeDY=;
        b=EDnq0AOaleBZvS0jLczpa0YevLye7wDFK9wCJR8hBAS/IbeDp2ZrQgl+F/3SJ8vOiJ
         B9Lj/XvSlbOcYFUzAAacCbc+UPtvni/WB/HhMPxm9DGYw8pzwIUrrSNGzjd+06g5u3vy
         l3zoMB4bOplD6HUK/6LmgQ1EOMPvqa639NrgOnhUGFu9CgqCOgfkG/5yue4RAwvM6JVk
         hJkQLn3iXXPUoRKl4tE081VcNYvvUVYaBBkIAJldmQvrO1RoZ8oTDNaV4jcZoAE0KSaK
         gek4RLdW0pxmHq8ikk5CP6K0PTR/HNRXAyQN14Yfd1K4XzPkw+8RpDg7SZlffV1CMgfr
         RGMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781599523; x=1782204323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Saf9Ku0AdbaZ27kploZ5WAYm1wQnaE0aLpGzNXq2UQ=;
        b=HS8GLNx5+l0If7AsxApYNwiXrhwwzsaCruPWPZyiEfLXo4Kl4R60uzKkyevd06JoC8
         UtHa2InpaPlZMYMbimnJ+o2/7djBQusFoGGKAOv49VIOOboEvyuA79bGY5diD4sgWOaj
         Bc36NaAd3TJHYf51xmHQCMFtjniVd2Gobcks2GT0Nx/7Wxp28yvH+NgBh+du1grpXc6v
         NNuuVL9WbTdKWnTIha/xgTKF5VeYXpcUfQ4KAhv0zj3DzZkrbu7+Kw8IHxacX0rKAWyN
         RYFulNcbPMd2d4qm3x/hcFS17YbL9tAqhDEpUBwoC2sC3UkPkRvT8ODuOKTcBrOfgx7+
         OVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781599523; x=1782204323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Saf9Ku0AdbaZ27kploZ5WAYm1wQnaE0aLpGzNXq2UQ=;
        b=PGMsGGD8MQs/HxKOOIYxvMKrZOiwDeYCmQgi+FUi9eEXduXM4cJVoCUNzgTK8TkSXP
         zlK8oFcKVio51G8fvr5WYOd26+XfyZds/XPXsnAUQBNroCro5rvaRiZukA/N+3OSRX/x
         xMzTts8QeShgtKGS2lS7imFGUjCJQJ5/zsKUddL0fXokEzTvA/wq3JWGntLMh7pw4yUj
         hlCWtmweE7FoIdEyXDVNsYcW7zbYOjo7hb0kgy2aQ9+ORsE6vI2eVF+xFNR4vXo6jnfR
         yHVYLILCBUa+G7IDmCoH+17y2O5fr777mdTOYKWUY2tX6eE284lQ6S6FS/vrC0lFQMtJ
         /XVg==
X-Forwarded-Encrypted: i=1; AFNElJ9HoQSBbWHI0l3TPsyiYcVyvZ/09muPxph/BSS79iqAVp4HcvoF3b8mEtBZ373/Gkw59v9IO3oSR8Fk@vger.kernel.org
X-Gm-Message-State: AOJu0YywXiwWFMPi8+xwraIcIbJQTCZhecRCKA2A3Qp/WaD9vPYQUs3i
	NfZu2L06wNqftYRmogHhOBs6/U6C/5o1KkyFUXNw8PdoABYMBtocg6NSHzxbdBEWbLctgSCmzjJ
	ojtIQCk+Q7oYiXlNwGkE4+LMwtj/R8u8=
X-Gm-Gg: Acq92OH6fvZN5rSZSV7dfOCL/0Y9XCGnsRTpUSybaoB75trlI/Bj4iZ01GpzUJSUULc
	GjNIjmLRaMAVanZ3gkjugWAq0vQhi8XSQ1sVkzb4w0EzMVw8xsmxTGCIDuIFrXp/iTJeI0RVCTI
	+6GTTe0BzuElsHCWvB+5qxVBVeRQX+jISsuGnIpZLqvN1t4Z9o00uyDH7FE4sl0ef5+nmgwKiMs
	iD1caMKr63WKNh4OwS8b/7RqNxR2FTEdnJLnwRLxC1ulsVhFzRLVgOGpvoGCcgD5dsnweqeA6ix
	mMzADGy/OKnVQX9v5PaIprd76rY1naTFAgRqPCx0okTtfdkvJOYsVL/cHziOOluIUBG9jlvzh0n
	0bHEM5Nh5HnZoIc2K10tyFOBtiD3nqCL6/g==
X-Received: by 2002:a05:7300:2318:b0:307:d4e7:b178 with SMTP id
 5a478bee46e88-30820054649mr4116001eec.4.1781599522964; Tue, 16 Jun 2026
 01:45:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608181451.3734956-1-japo@linux.ibm.com> <20260608181451.3734956-7-japo@linux.ibm.com>
 <20260615164013.GA249489@ax162> <CANiq72nkm2YwxcV+vwDj+v0svd6e1dro-W_0ybVms3pG_oJiXg@mail.gmail.com>
 <ajD9uw7MhsisxdzY@google.com>
In-Reply-To: <ajD9uw7MhsisxdzY@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 16 Jun 2026 10:45:10 +0200
X-Gm-Features: AVVi8Ce8ppVywZIY_ATJ3pLfGr5qRJIh-p7Powg4rirApr2Mm_Us5rATobeRnQI
Message-ID: <CANiq72=Dv8wUrMz7jbsHOwAyd2GtgnRxvXzZeER91KvPcULzhQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] s390: Enable Rust support
To: Alice Ryhl <aliceryhl@google.com>, Jan Polensky <japo@linux.ibm.com>
Cc: Nathan Chancellor <nathan@kernel.org>, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, ojeda@kernel.org, peterz@infradead.org, 
	jpoimboe@kernel.org, jbaron@akamai.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, dakr@kernel.org, rostedt@goodmis.org, ardb@kernel.org, 
	linux-s390@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 9:39=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> Since fixing this requires a change in rustc to recognize the backchain
> target feature, has this work been started? I think that for stuff like
> this, we should make to at least start working on fixing the warning so
> that we don't emit a warning forever.

That is the expectation, yeah.

Jan et al.: for powerpc I have been accumulating the links etc. in
https://github.com/Rust-for-Linux/linux/issues/105 -- do you have
similar links to the ongoing work for s390 so that I can fill the
equivalent https://github.com/Rust-for-Linux/linux/issues/106?

Thanks!

Cheers,
Miguel
