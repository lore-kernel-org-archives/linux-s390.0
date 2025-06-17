Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF7420296A
	for <linux-s390@vger.kernel.org>; Tue, 17 Jun 2025 18:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750184977; cv=none; b=hNjI4BOuwft8W4SV3z3QbTZ29pjQqJ3B0Xesmwim0HJ7GW/jqR65b/AQBledyd7KvR+LJJtmaCy7pPkd6Bl97yBBf+LXQxDnb+acuL7stHCP2z586amNTgbNdrI73AYL9lX6NcJsNaPD2/iBhj0OzYfw+trjgjidIM9XxS6VvAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750184977; c=relaxed/simple;
	bh=4D7DO/f/TIDpTtJg/TTFmgQrH4mAxp5ug7V7AlGUGEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pF1NF3wTV6hc1QWYNGsK+NVml85UgUj0jHYXQhOp2M66Y9077t26sp6xrxnxlFlSCJBfvLnZBEJjwngCEjTD2rNMypOkgD5ZSkis9lhycp31kAb2sCFqiDBp04dAyZo+d77PnhLY30YjLHI9gqtvrN45vBBwBikeh22c+QUI2+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZULnhdeA; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZULnhdeA"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ade750971f2so788129266b.2
        for <linux-s390@vger.kernel.org>; Tue, 17 Jun 2025 11:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1750184973; x=1750789773; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BpmH32X+ubnFGRkDpBaCqaiio/3lQgXW15x6m1ucLKk=;
        b=ZULnhdeAZv+Trzzq5xzt/azn4/Dh+J6LuQR9TATLOD8coIES4JnNPqeaeQoN9LvgF7
         KlhVBrAk0Cfljg1ouLWQuEcxHXE7DC1msQ7pxvlQSiCXEUa30IGvcPvAjUZTxyLf0wDC
         NI7XXjEZCn4CwdSwugKLYQxp2JqqUnoa4XBm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750184973; x=1750789773;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BpmH32X+ubnFGRkDpBaCqaiio/3lQgXW15x6m1ucLKk=;
        b=HhN+qsQrL7kaVLEc6f+342lGezxFRCBtptV9F1BHVKRxG8IophR2bG1UPMm7OY5fdw
         Q6ml32cKYqJuUCZrvoOribb9y6fGG6HszHtL5LN2+vj48l5D/hpPN5l41zBjig6KwxYt
         R08jFU5EN9I5Ce6B3mAMzdZBSqKk9GxA73y5O+wO3FSCjIxRhSftq0MpS5YgqitgQ4nS
         ghQ+3vPbEFYDDii/SC4iQIq58GoLJHl2REa4p2H0xp7lpk6W4TSeZ3ie0pLoj5uAm0cL
         //GXPR35j0wBUXuaeU/th+hm0+WVF+DesyRjFvfeikTP4APT+CjRsXKt6dtYVUnJ3Dp+
         gLNw==
X-Forwarded-Encrypted: i=1; AJvYcCVQna8zVim7XSU5ECulnHIN3ba+NAso6yzkqhhvCBctqrO4ulEzfIcGKPS1t2k8H7E8QnxpPga+GhBa@vger.kernel.org
X-Gm-Message-State: AOJu0YxM7RPxP+7rdLpuoikAD7O+/7L0SEQYZZBsje7K3x2qnte1mLMu
	2mVfDmtxrrCSuRee05JcIU4TR6kXa37PB2Q19Y1pMhgcVitRae385/yc85FAPainEMMt9HOfufp
	vyTIbduM=
X-Gm-Gg: ASbGnctM/bVwIG4zY0xRv8zC0ofib62FpHoIYY6SMj3FtQZoUISI3K82Jd5+vMtoVC6
	I/Tml62LZ5eku+lSDkfFEwIdaBCxgIlC2yySoxKDv3El0LzHXYkxhSmtdOSh34jAL6C4HFd2PD+
	5XKlPoq30DKYfEZX7Lr5S8DJx+lb7kHl1fzaEaOFVIlN1L3RtBJO/fUrTjwj67rEyjX6c5i6XIS
	PBaHfxqR4I3c9BZWCE43VK1rEADdqQd8OtLt6hJakJxkUN+ZKT9ULfBqOliC/NzX3vAsbB7RHfI
	8o3Kx9nRGr68qzC6A9FdfqNtWAppEnbGZ1T0VFe3kXMqniUwaU5bQTuFJvxyes1rjlEnxN53q2u
	GVhE6UEqP26t7+ev8FoF6fLjbK8IEqtCTVHjgHsXMmrY0rTE=
X-Google-Smtp-Source: AGHT+IE0C92yPo2t6wodQJrPSJ9CBBBivRtB+GwTaEz2oB8hLKG0KyUTNvU1Nmws4fRN+D1kulhUKA==
X-Received: by 2002:a17:907:7fab:b0:ad5:a29c:efed with SMTP id a640c23a62f3a-adfad4181f0mr1457169666b.33.1750184972862;
        Tue, 17 Jun 2025 11:29:32 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec81b8a3fsm904586666b.38.2025.06.17.11.29.32
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 11:29:32 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6071ac9dc3eso10529779a12.1
        for <linux-s390@vger.kernel.org>; Tue, 17 Jun 2025 11:29:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW0wEDC0O4IfthL2e8FiJ1Nvt2bsXCY/YSroptMXikHnptr/6CNoxGJRUtWr5RyIr+8TngqBYKmOGEK@vger.kernel.org
X-Received: by 2002:a05:6402:40ce:b0:5ff:f72e:f494 with SMTP id
 4fb4d7f45d1cf-608d099f37bmr12876236a12.31.1750184971733; Tue, 17 Jun 2025
 11:29:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616014019.415791-1-ebiggers@kernel.org> <20250617060523.GH8289@sol>
In-Reply-To: <20250617060523.GH8289@sol>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Jun 2025 11:29:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5d4K+sF2L=tuRW6AopVxO1DDXzstMQaECmU2QHN13KA@mail.gmail.com>
X-Gm-Features: AX0GCFsDpDEWkWJGZUHtM58JGRAX5cSPaq4yB3fqNYhO8hMv3GVq-qz3C44LzlI
Message-ID: <CAHk-=wi5d4K+sF2L=tuRW6AopVxO1DDXzstMQaECmU2QHN13KA@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] SHA-512 library functions
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Jun 2025 at 23:05, Eric Biggers <ebiggers@kernel.org> wrote:
>
> An additional note on testing: [..]

Talking about testing - when adding test scripts, can you do it as a
separate thing entirely - either before or after?

As it is, this code movement is hard to judge just because the stats
are all messed up with new tests:

 77 files changed, 4012 insertions(+), 1756 deletions(-)

that's 2k+ new lines of code that pretty much entirely hides the
question of "did this code movement result in a simpler / same / more
complex end result".

So in general, I'd really prefer big re-organizations to be *separate*
from new code changes.

It's just a pain to review renaming when it's mixed up with other
changes - whether renaming variables or whole files.

And that's as true on an individual commit level (we try to avoid
renaming things *and* making other changes in one go) as it is on a
pull request level.

If I see a pull request that only adds new tests, it's a no-brainer.

If I see a pull request that only re-organizes the code and the
diffstat just just renames with some small updates for new locations,
it's a no-brainer.

If I see a pull request that does both, it's a pain in the arse,
because then I need to start to look into individual commits and go
"which does what".

            Linus
