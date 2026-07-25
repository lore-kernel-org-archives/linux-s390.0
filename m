Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC24327BFB
	for <linux-s390@vger.kernel.org>; Sat, 25 Jul 2026 20:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785012921; cv=pass; b=oHU8MH+scnmglkTp8x1tvjMO5UN36v7A0s/9bnJDh4MI2aFhH2xCOj+XeSd0DxZYoAYssJzHeo84/DoQ/U84x+7ENg7q/VekVD6M+56nx4tCFg9qzUMX/O4YGjmaJPGGM5oyOJ4EF9KNkgw44CVmPvXVc5AXovOjCVwCyQZvgzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785012921; c=relaxed/simple;
	bh=zw51gC5xIPlAb+ehmicqnY9g7AruYRjvzVknaMunE54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZlqJZ5g5KPO0CFIF78GXYx92skjJFvNJ60TJUVJ8rN8wHObkj7bqGJmljH3QY2qV/E5RQ1NCy4G2fEeQDYDgypGRzKGex8o2Wwg7s1WVffkqbFAoL3Lnus9Efm+IWG/ZaSCi1uB1wrGoyzGXUOLdnMRJ7XSGCUws+QLvnFL29/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCfA16sJ; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCfA16sJ"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c9aea40d799so772695a12.0
        for <linux-s390@vger.kernel.org>; Sat, 25 Jul 2026 13:55:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785012917; cv=none;
        d=google.com; s=arc-20260327;
        b=NjsV+I4PXBDQDOiDr6UQfhFeyGONi64C7k6j0sBGEpI+E3E+6l9b5ytnl9QDJ923rX
         f0eQ7GmuE+yqmPA5/IZeHBM4GOslKkWdiz8GCYxtZPLpPt4HggOIcI2dwPQfQMUw7+ps
         veoM2YGSoNTEZEkDGITHjuZpehpjZheiUNasaDbvtzNlOMqUkvVHflyPCaZRaPMhxpNj
         nVC5lkSYH4fakzSKSFmBZGxZsF55PB74GCeM9uawzMNtwR6pcSWCe/CVd9KeZiw8DF6O
         oiCXHwDlOfsWiVaM87xpbr79EHdfnLQ2xYn+gl1ybqnXRsNAiW/nbCawNoULRGLSZX6R
         a0Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8WOQSahUV2FdjC/IM2f0n66+R/EWHlwNnk6q/oqvWX0=;
        fh=hu26QAb2mNBUMci9m3ezMRc8xKu9kqI/VUPaoHGsYPE=;
        b=sdS8OsG1xBjKygvfSUU7inWcZLiBeB6E9tXaEoG7V0dvfNq+wM2mxAPq0Zr1dxlVrv
         mzxYeaiiT1NX1A7Z9tc7SZ8N2dz4lTlAYjuGQ3Xd/Vk5tX+791vHkV7aSGlD5Zc/pZQR
         eIS4KGrdHcdXlimSoQPJB86lBQoj7SpWwJd9RwhxFplWOWNXKJeHT+vdy3Ksw4DDfJgn
         67sofsB1bs8NEUTtCqcoIiUSfwjnQkG0vWUyOuA9epu6/lgLknz7NYMNUMnBYKNLpHHX
         OHmZzpaPXdZU53dPxoFhSUm7akDVMI0mccGiC5tRzIyxxfXG1hIC4QPxyCywRtIzuIQK
         J1PA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785012917; x=1785617717; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8WOQSahUV2FdjC/IM2f0n66+R/EWHlwNnk6q/oqvWX0=;
        b=CCfA16sJBtgz8hldzWHYxUcyEjDqG0Y36DO6tVDS/ExmfNKDZzPZL53IiAy2HXqw2O
         KGAlALuZKD65GL9IxDdiAKuHMignZ6WXOsZx1samvNlbskdHpyC7TijOlka7b7Ab7JlX
         9DOirbvc9OUcRek2FGlvwCYNbjCSoGUKFnIS+mB249msG4ov5+/MS9llmMgoi6gXo4wR
         SQnOgz2SA+68IAreR4Ru1Uk0nfis315U2LA9sR0U72Iezp+sgkabMYRYXpfdgB4JiNMS
         jEuo3pZ0GvvmCxcqlnHbjxszgy/btfDRvWGt+aeO2Q/am25HTFd9D96Xz6Fy0N7YIeZO
         Yw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785012917; x=1785617717;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8WOQSahUV2FdjC/IM2f0n66+R/EWHlwNnk6q/oqvWX0=;
        b=hfbtNJN5MjAlRsAFmW7IZJaKF6lr4hJGvYhYQkl2JBQb9n7T/RISXtO4Iro5l8IGOy
         zX6scBw48IMMXgitJE33Ge1Jqj+wZBfTvk6bgQdVv+pgmteW4nnoahIEBbjWOgFwZObi
         N5lMAEKdFESxGVZq0Qed53t00uyOmtDfHDQaTFmow/yaajGROxmkw/bEwMGQgerGU7K3
         4CGIxfP5HLMG2OSEUAdHE1Q2MSmezs6/eG7SPKLJEQd7+OPseY4Oq98OVN4SxUovFqE7
         IMh3X+hvcbtUNIxTPIg0qYw+sdoNPdawIIVF9/Q5URDCZLohtoo5zKE1YjsjdAX6386A
         qGoQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrr48da+7Y5TRcLISA1kZrsFsdRKBrl3TNn5oUNdd6tzxCmo/X8wkF7oSlUBInfzOexFwo8xbN+cBc8@vger.kernel.org
X-Gm-Message-State: AOJu0YyykuomB+Uow6nnsTHsxoi6w8xjExeSEuTpZxR+9Afz1Je5v9BJ
	HtwvxHyG2G5Tq0OCwanUTAEbCgLa1o8NnNMs7p74IfoVp3o+87AcK5jxsY1EwlEq/SMXn17KtYe
	Yp2IJraU8UkAHno7XjBuTs3U9GyKzNSA=
X-Gm-Gg: AR+sD11HaE4tRgUTVcK/32bEBksAK4Bddrhe0LAX/c0LblatY+tkv3RFeMhgWHPdvF+
	4M5dFSP1S78kabub9qRtDO7KthHZPFLoAavAuYTTW/tmLyPthiF9Fgcu2/K1hxJ2+8wCecD6IA2
	G/HbF54my2+NhY+Baa180mfmf6G1vSCEenrOzP4YbKGOWdODeIak0Rt8FjngnoPkiMmBJyQyZV9
	InV1vCtgUh1nXi3FwJ7NRHX3rPjh/7R4g94kzLEzFTQ+pyeFgm4HOLJvV6wxQ==
X-Received: by 2002:a05:6a21:4784:b0:3c3:990b:2292 with SMTP id
 adf61e73a8af0-3c67dfe6723mr2903792637.57.1785012916705; Sat, 25 Jul 2026
 13:55:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523-af-alg-harden-v1-2-c76755c3a5c5@gmail.com>
 <20260603133312.12848-1-freude@linux.ibm.com> <amOGWwdjnJqyxH5L@codewreck.org>
 <20260724160034.GB2032@sol> <amOTjPW__CNZui3_@codewreck.org>
In-Reply-To: <amOTjPW__CNZui3_@codewreck.org>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sat, 25 Jul 2026 22:55:03 +0200
X-Gm-Features: AUfX_myV9AV5bwxaPxDCds8CpJSSwUUfrEfnR7d5D_zQ_thbtzqC3K-k805u5U8
Message-ID: <CAFLxGvy+ec3nQLrQtwFZgGELhT2pKBDnHdD0pMvEGh-Mf3rjgQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] AF_ALG: Drop support for off-CPU cryptography
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Biggers <ebiggers@kernel.org>, demiobenour@gmail.com, 
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

On Fri, Jul 24, 2026 at 6:41=E2=80=AFPM Dominique Martinet
<asmadeus@codewreck.org> wrote:
> > There's no "tk(cbc(aes))" algorithm in the upstream kernel.  So, it's
> > not possible that this ever worked with upstream.  Given that, there's
> > no regression in upstream for this program, and it wouldn't be
> > appropriate to consider a sysctl knob in upstream at this time.
>
> Bleh, you are correct, it's an NXP patch in
> drivers/crypto/caam/caamalg.c that they've been carrying in their
> tree(s) since 2018[1] and has apparently never been upstreamed...
> [1] https://github.com/nxp-imx/linux-imx/commit/6868c9e49c1854028fb46022d=
aac3b1b10ca2c70
>
> Sorry for not having checked, I was hoping for better.
> (I should be used to it by now...)

Sorry for joining the party so late, you're killing AF_ALG faster than
I can follow all the mails.
Speaking of CAAM, there is a legit usecase which exists mainline. No
vendor patches needed.

You can create a CAAM BLOB (a generated and sealed key) using the
trusted keys subsystem and use this BLOB
later in AF_ALG to perform AES with a key invisible to userspace.

e.g.
kid=3D$(keyctl add trusted mykey "new 32 pk" @s)
keyctl print $kid | xxd -r -p > blob.bin
Then just create a caam_pkey_info in userspace and feed it into AF_ALG
and perform AES with it.

So, pretty please,  if you kill AF_ALG and all this, offer some way to
achieve the same in userspace.

-
Thanks,
//richard
