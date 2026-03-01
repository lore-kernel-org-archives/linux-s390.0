Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF44E21FF30
	for <linux-s390@vger.kernel.org>; Sun,  1 Mar 2026 21:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772401982; cv=none; b=b/KryfKrDR+dH/l/bcocgUb1f/5qOYV96zBoC4RT99KgUvbEETGCAi2VFxcifo8KGTNIalbO6+kLT5McOxjbwi0qfTUSO/9Gz2Mdc4NxT3/SWz87tJgyEdZ9nAliHMV89PZbjeGmX8uLJNYj07uUgqEKeyo7ag3j0Q+19umHHU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772401982; c=relaxed/simple;
	bh=UZuV4vRle4QPExsCoWwOx/8Bt6/Fqaq7WbJVQeadgG4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mJdFu0vRa/XHASwBkoOY6PyfapfQG/TBn7d2TeRtCsHEnmvwR1ipOqlgBXReNoLhbFR4kt4jLq6XERzV9dspl9ERTSu4dIch0F2pzKD2yBvf3UUeUGxv3BP6BvwmzjmacYzL9p/5+m5s+f8y9312UBdF/VZWML5EUduhQDTNX5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZR6TzZVJ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZR6TzZVJ"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439aeed8a5bso940838f8f.3
        for <linux-s390@vger.kernel.org>; Sun, 01 Mar 2026 13:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772401979; x=1773006779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylRWWUwK5o3MfEB7pGrnKLZH79m/zlgSbzMzkIBZ2EE=;
        b=ZR6TzZVJr3DP8uFrAQAqaQLDHdUeHQNdUpwsfIueIbLeUGw8smk1/8T2LpCGzgJ82t
         D8D2zG73T6pUxc8sjxKEOL8aRDgi3L6cp6ZZpopeOjey5McoaxpL+jgKL2rppML3IaFE
         Y4pD+jIoN3seNEsq0etIGExw0i7twrlIVblsmsNVJ9gVTS9dldsWL1DX0uVES4m/7G19
         bblXB7d9T0b8HxN6ZmwjUXU5YUmJOhl2Y4bpYMIJrdNb/N4Hs+nbQVCCaQvsOzYgYozU
         iVISzjeTK9VJkvAn1ylCTASaM7UE0+yhUd/oadVrlgzSOofrE5O5VW/EGxWOv2aSEUow
         XPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772401979; x=1773006779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ylRWWUwK5o3MfEB7pGrnKLZH79m/zlgSbzMzkIBZ2EE=;
        b=IfFqlpNGjs7OYgD0aZqu2xKbkNFqNXnMtk1pj67+l7t0p0ut/R0OGyS346KofpE9+G
         9XMzw0VNZtldmQ5Bith6Gps4FbwdBl17Xg2hrzNe6nC8n7kFWikVMy/I9MvjvOLua6gi
         HSIqSwie9T4qGCXoqo1qdjj0RphY/3YHQDMqQaWDMGB62df9GSKCGyon+t5HKc/N4VHx
         16TE/GCSz5Hj2EONEeWcF1raZCj7qWBCSkk7cKJNr69UKNy0vOMC2UNCasiflpoNlLcL
         /8vGldUKWFWOIMBkRzAadtgkoyBzkvCIE9D/8+1xr8g924LaG3xCgB+sr1ce1+33b+AX
         prMA==
X-Forwarded-Encrypted: i=1; AJvYcCVuEfUUtoDw4PO6FakJw1WsFA91o4gxcmnFlYoL1Y+3Z4rki/iBS1OZuJv06ff22YV6FCLoOtnEQ02u@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4vjkG97LdB6NzENMpGb/SGVGBfxXS2SsUedve4Scu7C6S8mCs
	eQZzJrBH6tmDx32CFn3C/OBOV9C9N0WhgE+i/FgzXfyE+K/AG+sBv/B2
X-Gm-Gg: ATEYQzwIEarvXBNP+uaHlENZUuP0RQ2zWcIv6/aKXNIaB+ldnGD7EQHRWpvag43TKxx
	W7bvU3h7NTFoyVjZ+x+02B81WkrlxaIy2fiTnK6h1+D3Lz0ei3FFvTrwUavWH275wRYr2VoKwTS
	tAHQKlCbC+sHkymkbjZi0kaB4KEna+x9IeddMEan6hIkhxnNKmOSK/REWnAs4lKWk2QllKYwCFT
	oLH60WTZus31Gzud0W4Zm5UDzjqEvm9piFuqg18GZ8ZhwMMvscwkXhBtClydKLzcqPBMfCcqJdE
	G8lA9RrKWT6cAHOWHn1D9qYUpG2C+2oLwWJJkeeOkjo5TKMMltW59mFSKbY+HpKSKX9xPfDs4xG
	rpL+aPebyECO8OVxRFb5Szpth8yROjxaMz8gB3Lyo60b786q6+27iJrIn3wvTIAqjNL6Cs/mhNu
	rz6UCBaPXxpTBHOoy7OOdWHTU9POassUM6omGoIt+G1R5d9yIFhgEj1HdseA+kEsyaE1DxtIXiP
	2c=
X-Received: by 2002:a5d:588f:0:b0:439:afd8:6235 with SMTP id ffacd0b85a97d-439afd86565mr5809623f8f.18.1772401979049;
        Sun, 01 Mar 2026 13:52:59 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439ba2a58dasm61132f8f.27.2026.03.01.13.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 13:52:58 -0800 (PST)
Date: Sun, 1 Mar 2026 21:52:57 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML
 <linux-kernel@vger.kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Cooper
 <andrew.cooper3@citrix.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, kernel test robot <lkp@intel.com>, Russell
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
Message-ID: <20260301215257.7bdad5f1@pumpkin>
In-Reply-To: <4e994e13b48420ef36be686458ce3512657ddb41.1772393211.git.chleroy@kernel.org>
References: <4e994e13b48420ef36be686458ce3512657ddb41.1772393211.git.chleroy@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  1 Mar 2026 20:33:58 +0100
"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:

> After converting powerpc checksum wrappers to scoped user access,
> following build failure happens:
> 
> 	  CC      arch/powerpc/lib/checksum_wrappers.o
> 	In file included from arch/powerpc/lib/checksum_wrappers.c:12:
> 	arch/powerpc/lib/checksum_wrappers.c: In function 'csum_and_copy_from_user':
> 	./include/linux/uaccess.h:691:1: error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
> 	  691 | ({                                                                      \
> 	      | ^
> 	./include/linux/uaccess.h:755:37: note: in expansion of macro '__scoped_user_access_begin'
> 	  755 |         for (void __user *_tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl); \
> 	      |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 	./include/linux/uaccess.h:770:9: note: in expansion of macro '__scoped_user_access'
> 	  770 |         __scoped_user_access(read, usrc, size, elbl)
> 	      |         ^~~~~~~~~~~~~~~~~~~~
> 	arch/powerpc/lib/checksum_wrappers.c:17:9: note: in expansion of macro 'scoped_user_read_access_size'
> 	   17 |         scoped_user_read_access_size(src, len, efault)
> 	      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Cast __scoped_user_access_begin() to (void __user *) to fix it.

I posted a patch to fix this in december, I'll find it and resend it.

	David

> 
> Fixes: e497310b4ffb ("uaccess: Provide scoped user access regions")
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> ---
> Thomas, I encountered this problem while preparing some patches to start using
> scope user access widely on powerpc in order to benefit more from masked user
> access. Can you make this patch go into 7.0 as a fix in order avoid dependency
> on this change when we start using scoped user access ?
> 
>  include/linux/uaccess.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 1f3804245c06..5d9f6d45d301 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -752,7 +752,8 @@ USER_ACCESS_GUARD(rw)
>   */
>  #define __scoped_user_access(mode, uptr, size, elbl)					\
>  for (bool done = false; !done; done = true)						\
> -	for (void __user *_tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl); \
> +	for (void __user *_tmpptr = (void __user *)					\
> +				    __scoped_user_access_begin(mode, uptr, size, elbl); \
>  	     !done; done = true)							\
>  		for (CLASS(user_##mode##_access, scope)(_tmpptr); !done; done = true)	\
>  			/* Force modified pointer usage within the scope */		\

