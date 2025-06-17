Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9D12E7168
	for <linux-s390@vger.kernel.org>; Tue, 17 Jun 2025 19:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750189456; cv=none; b=lCUFtqvcLsDgb71jPps5j6tNTGm5JYwkUb191p/i7ciqnwzWUsOHpCEFfZLQYULZ9r2KaRkjZ4w1DjW/PaBMdxj43h7KfifBm9ssExI5XWNBUBzgXp2xSDcMzIctS5pdGtQJ8V4bMem+QRb19y0KwUrOGbSe1aXdXrFkADhaC78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750189456; c=relaxed/simple;
	bh=GglwgC9V6N5x5dY/greRFE2ImYu5s9zU1NI2hHBVjMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0LakuSqAEqEbpVYkqK7mbtuhCa7noHz/jZVGA+DrFrOh1nvZTFEVCxI/e0ZwHYVhnIaPCnqoJBhxgdglE7aQs97Tpi1qsCFjjxAN6boWJ+bIunXwGXfhtFb+jD+HEpIp0VySofxtDv8mlb1DEstC8boUejvXJ9QxZ3ZOaF44Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MfYfgTBf; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MfYfgTBf"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60702d77c60so12933537a12.3
        for <linux-s390@vger.kernel.org>; Tue, 17 Jun 2025 12:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1750189453; x=1750794253; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9BlEsfucVc/RasLKZoG4B3LJbpSakOO/+DV6/Nb67hA=;
        b=MfYfgTBfympgPOCejPRlacaQ2xSeWXzJsF7Iwjca6GTFxYez5PLk+BD2r11lmLKXC7
         c5Sp4B6OtlvroLdqq5TEQstgQJXfY8PCR5VEYQG2V4ZusT7jwtuV9vCrnr2FQMAm9an6
         g5wTWBeeBzuII18xwdfO+mbIX7eJdLZM5Jsis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750189453; x=1750794253;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9BlEsfucVc/RasLKZoG4B3LJbpSakOO/+DV6/Nb67hA=;
        b=OQYreJLMDwsG+N3YjPTPG2wd1m2r3/Es/ZcXEtKsUPEzFRbc09kx5/rqoJRzUthxY7
         zrlZ70kdmROwfHMtTL7KVAc9Ar2lzEVUlaA46sTwalCci+ddkZ1GSvzVuvvcQI4QpNFv
         V/O6rg56eSOxio9NgX7duJPghDg0ijM2KHSpTlVBI/saprYvPfymOO5EfWYgqR5xyLcj
         KzJPqBmHFzdVeqizFDySo69ZcohiqmHDFgouJVqrJGJLyLH/5Kzji22An19U5oNkqT9n
         PBkAtoEswG6Jt+hFgiz7+K+oASOGhCJefAGtzi1boj/PyEzo1We6JS9TnP7BgepziaXE
         +COQ==
X-Forwarded-Encrypted: i=1; AJvYcCVinl9Io/gveC3RDhWG3yxs1V5oLk8QXmLKq6IOw52Wq0/1xX7K4hyc4TVlGucR0oXHCKwXDaLAp+0h@vger.kernel.org
X-Gm-Message-State: AOJu0YybYZMo1RT/uQiOkmevjO9Pv2D4ogpIf3U0S4wfPBx+Zsc6Go/O
	ZYe7Gt9NphcgD3okZcImlQU8Xm3eYkLsmX85P7FgWdCQ/ky2+z5Xrk94kkGLRHmBShMFhRo3LNE
	ro3kiyr0=
X-Gm-Gg: ASbGncsCVVvoW1rvvrf47f/uh0ZA6xgypmKz2ASJnQAH43QR3ovlWYYbcp2ZjoQEks1
	TduJH2uqoLpWnSpqxY0SYvZ088R5Zur/gF2/M4hhU9eoHsnu22rjOA7Nk2Ya3pQM3eRd+cUSFiP
	/9TSCMjElA1+bYNDMqFhIc2cATa2D44a3Bz92rA0So6wJpdnS/q+thBSJmT9nNZUM47Hfm7DeYO
	eU9OvU1QMrTLKToCcX70WZOCGH9KFJkRKA9vIEh1cCUyAc7V7KjEMSwC4naM/zXZXMxVbwaDKwp
	u652TKoRyAfXjC1Jc5Oys7wAwPh/w2kJkM8TWcM2UWIEH2Q9d4/RsIGQpIoBGLPMeNxyl53n8EG
	1+oZri+tFF9Xgd/pzHaUhKPYv8G2VaqGGSCwQ
X-Google-Smtp-Source: AGHT+IFrFCLkGOX7y/TEF/sneJmcY9wO+gOku9Gn5PyBJ+MYZmM7j26jNeb+dpqOUEEMAG7g2Qa7ZQ==
X-Received: by 2002:a05:6402:90e:b0:607:27bb:7bf with SMTP id 4fb4d7f45d1cf-608d09a1147mr12545049a12.32.1750189452821;
        Tue, 17 Jun 2025 12:44:12 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b4adea28sm8340384a12.69.2025.06.17.12.44.11
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 12:44:11 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-607ea238c37so12915976a12.2
        for <linux-s390@vger.kernel.org>; Tue, 17 Jun 2025 12:44:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXADKTFSpDBzX8aqPRXEZTJK7avR1J7s2ezy/WLQKLye3XqHVnEkhFs7Z5x6LHk2UkJ2eWVYzVB1ubH@vger.kernel.org
X-Received: by 2002:a05:6402:278e:b0:602:29e0:5e2f with SMTP id
 4fb4d7f45d1cf-608d086197cmr14681659a12.10.1750189450991; Tue, 17 Jun 2025
 12:44:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616014019.415791-1-ebiggers@kernel.org> <20250617060523.GH8289@sol>
 <CAHk-=wi5d4K+sF2L=tuRW6AopVxO1DDXzstMQaECmU2QHN13KA@mail.gmail.com> <20250617192212.GA1365424@google.com>
In-Reply-To: <20250617192212.GA1365424@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Jun 2025 12:43:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiB6XYBt81zpebysAoya4T-YiiZEmW_7+TtoA=FSCA4XQ@mail.gmail.com>
X-Gm-Features: AX0GCFszNgSlkg9Mnl9IREDvPmSYgcHDQLiQJ6pRqgmPlre4NTxTJm_9n0SX2DU
Message-ID: <CAHk-=wiB6XYBt81zpebysAoya4T-YiiZEmW_7+TtoA=FSCA4XQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] SHA-512 library functions
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Jun 2025 at 12:22, Eric Biggers <ebiggers@kernel.org> wrote:
>>
> The tests are already in their own patches: patches 4 and 5.  Yes, this patchset
> has a negative diffstat once you subtract them.

Yes, the patches were separate, but my point stands.

Let me repeat that part of the email since you seem to have missed it:

> If I see a pull request that only adds new tests, it's a no-brainer.
>
> If I see a pull request that only re-organizes the code and the
> diffstat just just renames with some small updates for new locations,
> it's a no-brainer.
>
> If I see a pull request that does both, it's a pain in the arse,
> because then I need to start to look into individual commits and go
> "which does what".

IOW, I really prefer pull requests to do clearly separate things too
when we're talking re-organization. Or at the very least spell things
out *very* clearly.

Otherwise I have to waste time just to go split things out _anyway_.

            Linus
