Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C98D37F8AF
	for <linux-s390@vger.kernel.org>; Fri, 22 May 2026 22:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489919; cv=none; b=HHvSxNvbjdwyuDmmcoJyk8KeSgTzrg9yKNqCQKShKbtXs9I3NCdldSIJBMo94rAR2NeaTztCV9u6w4b2VH0DcS/ogCMcjP2ILStD07zdARsi9tW2x+mMhyTcHlAGyj21tJtO81sh4PD3AA5of1m3HRwQL96KEk+kX6+SmLIQ1O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489919; c=relaxed/simple;
	bh=T9KX44UYXGJA7w/mV7wE3XyA+BBG92afu5gBlRGmKT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CWRctPSewAHSJunatODQSNwZkGjZNLyFw5ZrexQg1AeO3mua4bAIcdCDBvH4LRI36N3JYrVzr73FztaemBBwr6oLBKNWKU9qrfHNQRHGd1uLlJQ/B2oP80ioHhNi8x3GMQ641UcUhsr4UtPWgaMJsMlNbx9U1MzcO4YxjO9H92A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Yim2Bzbv; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Yim2Bzbv"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-67b32c695efso15805216a12.1
        for <linux-s390@vger.kernel.org>; Fri, 22 May 2026 15:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1779489916; x=1780094716; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DGhhwud0T2bSUGixoA5SMvgP96IcOgcTJzS7uIZ7FH8=;
        b=Yim2Bzbv4BE/ND06CYfIOj9DXaaXlhcAt6ggD0YPWxqZKL5gNB1fbSInDL1nU/mSvr
         PipmS3uVV42b8zfBwQhxgJBXfpnbtybNz7jiC4rN/dz2BftwDswl7sqcXV7QRGdl0jjg
         h0Rv9bytEodydDXvavq9oE/odEbgZ/R/QoZt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779489916; x=1780094716;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGhhwud0T2bSUGixoA5SMvgP96IcOgcTJzS7uIZ7FH8=;
        b=sQrtQCcAzUCyw6i0Q6DjB6uk++94vh+0D5Y6z0MfKRecCQ6dmMW+Ehsi4b6nTNJP/Y
         Iobg+donTTKfwvPX4POqjV+deXHBvaydBJW1XvqjOSRkOeDjf8cyPaQHkFKVfxygI+tl
         aoS1lMWEvqdUbH0YwgIrjVc0Vo24gnI04LBdWZFEP0cP8Sadlf0KRrN8JK3a+jzyVXA9
         Q12oecJkpUPDiFactIa458vkYXjNszY3McS94MFcXvmQPu1//cCEcN5dNPNjkJcM1RFC
         M8E8I8WOKPU/nIbtw3R3GjC8I9UlRIWieEwu9FeOlSIrLFmPtKNvE0yUjLSL9H/bl+Ct
         JA3A==
X-Forwarded-Encrypted: i=1; AFNElJ8yQyP1EljYgirxLahk4hAVavmxdk99TGYwKo1veSvzQMsaDKR0L2Kr0ZRGZH/IGPYYkEXb6bqjl4TR@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc03JaW2xIn0gTdjiXXjKkQLJ4IEIDOq5uwVNu5KNW2Md8tQ0/
	Ci4z05BFFpgzZ7Hl7CZ2YdjoZKAsNyE3anj6Cuactx78BThL8mqu/4Re9VVSn6cSCGOXjJa1G+h
	M03K3qAA=
X-Gm-Gg: Acq92OEY8FF9hWs6uWFaVOpg4lIqVDVRwJ7naO3r6gzNdCLSYqU2reqkgLDllqmcmbe
	xzL4HKYOWpoxUoCAMkwMUWer2MW9z7pMYdIsgDhYOT4SLvcfIsUClRNw0yuJfFpV181E7AjaR3K
	EGdfzZ5fyXB2OaRQgSJ2TdV0NuzG7qxNLfo5pVVkkujzv1km4Mg34ni1oqP3C6k5Z9N4SOAATH5
	ShoaGSYIl6qe5dL4AFoE5CJ8eWm2ljOv6PJJ70k0uEEautA3WLiBCBwhSIuCGh2Ul6Jrz1i9uhS
	CGsnh/5DD0flWiCd3it/FwI+tLXIfYWU3tXmvzsi1F8Rjvt8eXGJ19hmbk+ujg/1+l9aLwXc9bQ
	1d/OP78hfHtMWQ1Oz9obhhjrH9purq6Lg6disYPcXUs85XBMjfFXgu2zGtxYrK4Mek/zrtzeNEq
	+FLXeJvKX2EPCRojh9wHdy2r5AJ+sjWz1GQC/LgtaWjF0Xw46lKcUSNaZF8HD17zdAFmQbbAwl
X-Received: by 2002:a17:907:b0c:b0:bc1:c4d:cc70 with SMTP id a640c23a62f3a-bdd47df5a02mr225624166b.2.1779489916556;
        Fri, 22 May 2026 15:45:16 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc5ece387sm98499966b.41.2026.05.22.15.45.15
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 15:45:16 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bcda7765d64so1617574666b.1
        for <linux-s390@vger.kernel.org>; Fri, 22 May 2026 15:45:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/rQL9ldsiuTYHVnbT2X3FrRehbaExczrVGctWOHmTFYZZwVsI/MHYBemoapgTJucm2xm4B8bee2k7k@vger.kernel.org
X-Received: by 2002:a17:906:6a23:b0:bd3:329e:81e0 with SMTP id
 a640c23a62f3a-bdbffc5fe4bmr534033366b.9.1779489915282; Fri, 22 May 2026
 15:45:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511214226.937793-1-minchan@kernel.org> <20260515-nachdenken-umbenannt-a90006a46e14@brauner>
 <agd--WZpeTq2iKFW@redhat.com> <agefLhQeWpvil14M@google.com>
 <CAHk-=wiHfzbufXD2nuc9BhOVp-pYEmnVUYeThKmfZRXLU0kJ7w@mail.gmail.com>
 <aggE2haQ7yGeHPeF@google.com> <CAHk-=wg08=sZb=hVa22KjN2pD3aNk-diGmKQnizCgmoMMfrvwQ@mail.gmail.com>
 <agzNyXKIirm1zOob@google.com> <CAHk-=whqfr-M9ip9OWAUR1X6aOEy2P4gSWYDkbkTCc3E=jCz_A@mail.gmail.com>
In-Reply-To: <CAHk-=whqfr-M9ip9OWAUR1X6aOEy2P4gSWYDkbkTCc3E=jCz_A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 May 2026 15:44:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whMQsyjB6DOyWB73jPR4wrtcc++kZy4=hGQiRE+GxKh=A@mail.gmail.com>
X-Gm-Features: AVHnY4JHHOP3swFysb8Yirnvo4-2-fu_dlBx3L_5llutkMME2AiE0nERZWyjwO0
Message-ID: <CAHk-=whMQsyjB6DOyWB73jPR4wrtcc++kZy4=hGQiRE+GxKh=A@mail.gmail.com>
Subject: Re: [PATCH v3] mm: process_mrelease: introduce PROCESS_MRELEASE_REAP_KILL
 flag
To: Minchan Kim <minchan@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Christian Brauner <brauner@kernel.org>, Jann Horn <jannh@google.com>, 
	akpm@linux-foundation.org, hca@linux.ibm.com, linux-s390@vger.kernel.org, 
	david@kernel.org, mhocko@suse.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, surenb@google.com, timmurray@google.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 May 2026 at 15:41, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> At that point it will go through at most one iteration of show_smap()
> with the lock held, but that will be true even for your
> PIDFD_SIGNAL_PROCESS_GROUP_EXPEDITE case.

.. basically, what I'm arguing for is really to try to fix the
underlying *reason* for problems, not add new code and new
infrastructure elsewhere just because /proc/pid/smap and friends are
being difficult.

Let's really try to make them *not* cause difficulties for others instead.

          Linus
