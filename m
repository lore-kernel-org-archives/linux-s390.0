Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FB839FC1
	for <linux-s390@vger.kernel.org>; Tue, 19 Mar 2024 18:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710874509; cv=none; b=ktTgnHrzRG2KJ14ws2DG6A6g5Xjs+As3994ExVr4p4HrJnjkLTK2IbVgf52jcE2zH1kTqxxaPtn9SFjBIfGPxEIpCrSIlVcDDCe4QCQYgtPTcN20VtCvoH0EETLGcaddhUm4YqBe4McacAb9qilfSck8jHCvs9UVG2RjGyZ+Llc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710874509; c=relaxed/simple;
	bh=cquyfRZ0VBetvG8+L3oqKgTGchO/YG/tGhNA+Cv+Co0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iFny4A5O5LqCsnuaSCt95jenivyHQ95HEpwf/Ul+Yctmk8ZZeT0ThXZ5WTHzOQUIyaXHwGMb9zvhikmeAQ407y+IVhOhSPWC9Pr54tRelWcYk4ROlMPzyFUhmwMRy67fxCZyVS3TD3a1jPsHWgpON6w8C1UZwbSvx0seX9Z6bqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=b7gzV3Cb; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b7gzV3Cb"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56b85146589so308854a12.0
        for <linux-s390@vger.kernel.org>; Tue, 19 Mar 2024 11:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710874506; x=1711479306; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u4KodDa0zT/HNzbAX2EO8nLcPy/wnsGHD7zCwXLN7BY=;
        b=b7gzV3Cbtoo13O7zkMZsbBl0KrI+htHS+KyP8w5EUiEyjwvAbXFlqGMAA65pfARnkV
         mHixlgRLdzQHXtXpWZQA9STVE6BVA2JNjaLOQgztT1CbX8gO6tCCWFGvl+Uxhg6/jd9C
         SuN1HVOuPAStpUUhLYFwOk1hy6Gczc0oqVmEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710874506; x=1711479306;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u4KodDa0zT/HNzbAX2EO8nLcPy/wnsGHD7zCwXLN7BY=;
        b=vfw3l1Bl9sSEH6E5t137GtVsYSHhK6rPc6T0VEvPHAHKudab8h7jJjWGgZG24nTykm
         3oIbGs59mLdQvTw0EcasERm7EXDwXDO3VU7twY5qcnVoQFKVyN1rGIe8NFWIdCVEyOWJ
         yar0HHToglcNc1zxPAz7MQkYMBuXJ9xXHTGrxgZ+eP/78zYHcPqLrhBQ3z5WQgqWqEBz
         5XO81Wvl6GS4epAA5newOQvQhpEd5NBhsMCkZry+yw+e1jiBWiYMSFZ5mLGtdi6qhWp9
         vpDQk5qCnUN1P8SByiJV9ytDCgLrnKcxG08JgWxkolYYPFlQXuxzb0DwglFxLCtAv3Wd
         LF5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9KYiF9RT3d9ryS1l0Fbhn0KgLrxYWOj+DBL40VAnlI6nwzHry8VQof5xXHTBF+MkCgrIfulZGoB2jsRZKEXY5MSNVUdHa7S8oug==
X-Gm-Message-State: AOJu0YwiE0GlX66GOjn3hYQo4EZV+zv/BnCs7x8F9c1kHbTA3UiJY2LL
	LCgG8UWm5hH74617ZSG+4SOete/YwieFKwqgiIhLIfieo+Tsq7eH/8703mNSIF2IosCXz3QzT1g
	C8zQejQ==
X-Google-Smtp-Source: AGHT+IGIYF706kM24H6xgZKcn1jgt7+aq+ZMx6QOJ1eXk5hlD2HMYzLKraf9sa//SPx9LC8FFF5O1Q==
X-Received: by 2002:a05:6402:3224:b0:566:59a2:7a10 with SMTP id g36-20020a056402322400b0056659a27a10mr409393eda.1.1710874505538;
        Tue, 19 Mar 2024 11:55:05 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id u10-20020a50950a000000b0056b909e8b8dsm1303121eda.40.2024.03.19.11.55.04
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 11:55:05 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so253375a12.1
        for <linux-s390@vger.kernel.org>; Tue, 19 Mar 2024 11:55:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqtuJE+y/xKC4H3M9a+Rz8BlGsNp9EAgIpXW68GWPSKeeQterXBxw3cZhmFX94ADmscd4Kv8YSZzbS3ZcolYqep7d9X1LB39WcWQ==
X-Received: by 2002:a17:906:c7d4:b0:a46:dd1f:7dc6 with SMTP id
 dc20-20020a170906c7d400b00a46dd1f7dc6mr2839426ejb.24.1710874504637; Tue, 19
 Mar 2024 11:55:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319141230.23303-F-hca@linux.ibm.com>
In-Reply-To: <20240319141230.23303-F-hca@linux.ibm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 19 Mar 2024 11:54:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiGkerd+_ARB6bbSgAm02nkoOxRiy4LVsS_24ANQV-eZA@mail.gmail.com>
Message-ID: <CAHk-=wiGkerd+_ARB6bbSgAm02nkoOxRiy4LVsS_24ANQV-eZA@mail.gmail.com>
Subject: Re: [GIT PULL] more s390 updates for 6.9 merge window
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Mar 2024 at 07:12, Heiko Carstens <hca@linux.ibm.com> wrote:
>
> - Add new bitwise types and helper functions and use them in s390 specific
>   drivers and code to make it easier to find virtual vs physical address
>   usage bugs.

Hmm. Because you still want to be able to do arithmetic on them, this
is really what "__nocast" should be used for rather than "__bitwise".

__bitwise was intended (as the name implies) for things that can only
be mixed bitwise with similar types. It was _mainly_ for big-endian vs
little-endian marking, where it's actually perfectly fine to do
bitwise operations on two big-endian values without ever translation
them to "cpu endianness", but you can't for example do normal
arithmetic on them.

So __bitwise has those very specific rules that seem odd until you
realize what the reason for them are.

In contrast, your types actually *would* be fine with arithmetic and
logical operations being done on them, and that is what "__nocast"
really was meant to be.

But we basically never had much use for __nocast in the kernel, and
largely as a result __nocast was never fleshed out to work very well
(and it gets lost *much* too easily), so __bitwise it is.

Oh well.

It looks like it's not a lot of arithmetic you want to allow anyway,
so I guess the fact that __bitwise forces you to do some silly helper
functions for that isn't too much of an issue.

              Linus
