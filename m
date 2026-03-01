Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662DC3054EF
	for <linux-s390@vger.kernel.org>; Sun,  1 Mar 2026 21:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772402395; cv=none; b=ZBUHzNGnYLrxyoS80MDLydL41TqY1DLB1b/5ANVUNCxLfv6d7Li9+kh9c3+6d+EdW5E8CDpDq1NQ/iSw2ZUGbnbaMH+nunozOmIOU1P16k6ZzISdG8hHnMObSD7RLvkjehlvdsxK7KFX3gDDghVOd43RboZeshWy/s69n7g3lzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772402395; c=relaxed/simple;
	bh=kDs9LBWyn9QMil9Ec3Kwi6PapAxHBc3vX406latBklE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KBuzswWVdX03aITW+3pqH7z17skPeHCDfbfSodO5lQ+L0FytjuZdmDQAHbPufZPNBQP6xrCq2NsiFAJtCFb94RSwGHK0Ytfh1pTPRSNCPzRIsprnQ+OTuGHuHPMvNE4pWy9MO2lyrcYk/60abks0LBuxCQPq8gsmbKnpr+N1KO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgIp2NwM; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgIp2NwM"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439b2965d4bso624981f8f.2
        for <linux-s390@vger.kernel.org>; Sun, 01 Mar 2026 13:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772402393; x=1773007193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdF90L2tMXaU2D2ZcWRZkQORWHdME4B3q+DTo4zCDx4=;
        b=EgIp2NwMp0tsJEKn5c7aY7HPhL1T06qlBBgAnbSwW+qZ7d0ogKfQR3SuX/aAuUrg0r
         FznTifxM4H/vjzme8eBF79AG2vklaRUQYk6a/5oQXrO5XJOVpp+uvQS7hGBkAuKqLkw9
         lU+AahxaSFbu4ls8RUb0EDxM5V4LFQ7CqXYim9kxHKcRVJoLFT7vXyOoI64OHgvnR9KI
         3SMKykTmvckkDK/GJokYMy9mNCnz3V5ifHjfNAQzQxHLsJbKweCe3xLqCsfVF6zn+SoC
         pNJ820yXu0lMab0ZhTRu44EhauzrUBgHbk9t/QCg6vMgYoQCZPBaKkq1cHOWo+bZaF2s
         R8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772402393; x=1773007193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XdF90L2tMXaU2D2ZcWRZkQORWHdME4B3q+DTo4zCDx4=;
        b=llCO5egpEbpQu7iWdSX1u7kcgDeWorS56Ww2HmqUYYkNQA2TAGSewsiayWeBP9zd4m
         V4eXFdixNq29h4oKj3pC6xf8y8hjMBRI31wP+t2aJK8YO8of59P5NykvJhaHaLNg7KQp
         REJnv0MYaEE3obpRAxx4B85iy8ipiLCMMnaTNInSdFu7AL7Ytw4jKbnzYhiTPCgmQRkG
         K6Z+TEzOB1WUPoVYdfbhOKPaogOVdsd3IHkVNnUKwR9pJ4qE+jncbbzpkRZSSnVGsIAJ
         mYy1pYdofJ1gPfbiKmyYFdg2JDUmzkwBlL0vYnAOm7v/56v3IgWrkxk7sXRhlI0QRHq3
         5nEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcZUhVkXnWlrEvFO3cB+LfCUzXtw0LHrrNwHy6eLAjqr99rAQpDn0mlMYUd8dsmua5aV9TS7XigHss@vger.kernel.org
X-Gm-Message-State: AOJu0Yypaxk7/sssruC3S54NweChtq9THTtdWcwtfWgZrYco3t3sbUxm
	8MOpt71AgYqGFLfRGbrWfudFiQuXpvNmEfgGiOiRkmkB4URWSlMEOAl1
X-Gm-Gg: ATEYQzyEmPiGX1eIvhY6Sz0ucWAdFWcKDI/17xCdW3ZTIZc+9++cE5i0JtrrrZ81U8/
	xPEWf+0yzJ5Lp8G3t1YN+OR7nix2gtoN6dS7/HelGgFd9h0+qiYZrU81Z5aC2rJXw1fOBc0+iNg
	2BGfYEOcNBad4HnObFV6NXsVSaR7vGizZlxlNowth+TEu4o1km0OLYh7xYRE6WcYrqPq6HgyrYA
	/DNClyXsFsEKxQJq0o2lRrkXgih2AIcHyubsA4x3PGIQ/VQCPQzzm+6Cq5nfHbr8hf75hWDd3OW
	5ihAPEdtVV0GmRDhd+GOBZXQsGQOvSSs8gTVs8kUeawgwdzNg664Cj6DCvx67gygk8mnFh6Izid
	g2KN995yPF9hESzNKHs1wNiOYkSw4P4YM2yHmmARH5EOZ704fgzFLli/PSL7+uOVl0hCcAK3kFn
	kIUzPJzYpwQv+R/poDz5Y1W7pG5AL14cTRJM3mKMj3beyDzLPM2b0Jz0Z+BJv+4yjz
X-Received: by 2002:a05:6000:18a6:b0:439:b886:20cd with SMTP id ffacd0b85a97d-439b886219amr989086f8f.16.1772402392592;
        Sun, 01 Mar 2026 13:59:52 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c75a523sm22434797f8f.19.2026.03.01.13.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 13:59:52 -0800 (PST)
Date: Sun, 1 Mar 2026 21:59:50 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Cooper
 <andrew.cooper3@citrix.com>, kernel test robot <lkp@intel.com>, Russell
 King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, Heiko
 Carstens <hca@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>, Nicolas
 Palix <nicolas.palix@imag.fr>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Andre Almeida <andrealmeid@igalia.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] uaccess: Fix build of scoped user access with const
 pointer
Message-ID: <20260301215950.2fef5722@pumpkin>
In-Reply-To: <CAHk-=wixyP1mzyVcpZqQZd_xbabZQ873KVph3L-EkrNZGv3Ygw@mail.gmail.com>
References: <4e994e13b48420ef36be686458ce3512657ddb41.1772393211.git.chleroy@kernel.org>
	<CAHk-=wixyP1mzyVcpZqQZd_xbabZQ873KVph3L-EkrNZGv3Ygw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 1 Mar 2026 12:01:08 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, 1 Mar 2026 at 11:34, Christophe Leroy (CS GROUP)
> <chleroy@kernel.org> wrote:
> >
> > -       for (void __user *_tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl); \
> > +       for (void __user *_tmpptr = (void __user *)                                     \
> > +                                   __scoped_user_access_begin(mode, uptr, size, elbl); \  
> 
> Why are you casting this return value? Wouldn't it be a lot better to
> just make the types be the CORRECT ones?
> 
> I didn't test this, so maybe I'm missing something, but why isn't that
> just doing
> 
>         for (auto _tmpptr = __scoped_user_access_begin(mode, uptr,
> size, elbl);         \
> 
> instead? No cast, just a "use the right type automatically".
> 
> That macro actually does something similar just a few lines later, in
> that the innermost loop uses
> 
>          for (const typeof(uptr) uptr = _tmpptr; !done; done = true)
> 
> which picks up the type automatically from the argument (and then it
> uses the argument both for the type and name, which is horrendously
> confusing, but that's a separate thing).
> 
> Does that simple "auto" approach break something else?

This is what I needed to do:
(Note that is pre-dates 'auto', but it should work.)
Send at 21:56 on dec 20.

If a 'const struct foo __user *ptr' is used for the address passed
to scoped_user_read_access() then you get a warning/error
uaccess.h:691:1: error: initialization discards 'const' qualifier
    from pointer target type [-Werror=discarded-qualifiers]
for the
    void __user *_tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl)
assignment.

Fix by using typeof(uptr) in that assignment and changing the 'read' functions
to use 'const void __user *ptr' rather than 'void __user *ptr'.

Fixes: e497310b4ffb "(uaccess: Provide scoped user access regions)"
Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/uaccess.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 1f3804245c06..c5d5f2d395bc 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -650,32 +650,32 @@ static inline void user_access_restore(unsigned long flags) { }
 #define user_rw_access_end()		user_access_end()
 
 /* Scoped user access */
-#define USER_ACCESS_GUARD(_mode)				\
-static __always_inline void __user *				\
-class_user_##_mode##_begin(void __user *ptr)			\
+#define USER_ACCESS_GUARD(_mode, type)				\
+static __always_inline type __user *				\
+class_user_##_mode##_begin(type __user *ptr)			\
 {								\
 	return ptr;						\
 }								\
 								\
 static __always_inline void					\
-class_user_##_mode##_end(void __user *ptr)			\
+class_user_##_mode##_end(type __user *ptr)			\
 {								\
 	user_##_mode##_access_end();				\
 }								\
 								\
-DEFINE_CLASS(user_ ##_mode## _access, void __user *,		\
+DEFINE_CLASS(user_ ##_mode## _access, type __user *,		\
 	     class_user_##_mode##_end(_T),			\
-	     class_user_##_mode##_begin(ptr), void __user *ptr)	\
+	     class_user_##_mode##_begin(ptr), type __user *ptr)	\
 								\
 static __always_inline class_user_##_mode##_access_t		\
-class_user_##_mode##_access_ptr(void __user *scope)		\
+class_user_##_mode##_access_ptr(type __user *scope)		\
 {								\
 	return scope;						\
 }
 
-USER_ACCESS_GUARD(read)
-USER_ACCESS_GUARD(write)
-USER_ACCESS_GUARD(rw)
+USER_ACCESS_GUARD(read, const void)
+USER_ACCESS_GUARD(write, void)
+USER_ACCESS_GUARD(rw, void)
 #undef USER_ACCESS_GUARD
 
 /**
@@ -752,7 +752,7 @@ USER_ACCESS_GUARD(rw)
  */
 #define __scoped_user_access(mode, uptr, size, elbl)					\
 for (bool done = false; !done; done = true)						\
-	for (void __user *_tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl); \
+	for (typeof(uptr) _tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl); \
 	     !done; done = true)							\
 		for (CLASS(user_##mode##_access, scope)(_tmpptr); !done; done = true)	\
 			/* Force modified pointer usage within the scope */		\
-- 
2.39.5

	David

> 
>                    Linus

