Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E1B25C82B
	for <linux-s390@vger.kernel.org>; Sat, 26 Apr 2025 15:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745680676; cv=none; b=mQFZG8R6s7nadXLjwCWxEXHBwB7boJ8LWq8/MHG6wDquvPtRaC4CEVq+gytjzO8rpsG0PBPVXA/bW6W0CyJqENDCPow+2S+yGbbsa6ucYi3+urvRzH/4jPZSp5iI0QEJ+45Yi9Io7pZAJDhhAfhY4WhON2XF+j54Z3A6L4BVubw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745680676; c=relaxed/simple;
	bh=lwUT3Iv8t9p6mwjxLMSSqUxpKJyupbTKnPyyqPO3ZNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ca0fXqlqU05m/R15N613opIBTHG7YhgIqkZVT1Oz7Gq/ovByhvbLdDEgwVrbw+k9cSyYx+KDBMT07n037CSRRV4TZQ3LCluy7zL4M4ptING6EMIHih/tUkpTHiwMPj4iAaAK0ZfrECPEReHFKHEriG15yKtDobxc63Gsf9dwMws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Mc6MG6/V; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Mc6MG6/V"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9ebdfso4555762a12.3
        for <linux-s390@vger.kernel.org>; Sat, 26 Apr 2025 08:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1745680673; x=1746285473; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BNlY1Kyobnrt/7plmlszUhTRPyZa/aNAr5+UYAUEWpg=;
        b=Mc6MG6/V6hwO06vE3eA+UHCuAFh26Ni9xSB3MnoZo28aig7wbb4DbE9E1a3fZW0pcs
         hivHrDcIiTfsUfCbHy8L7Yp8+MDzK/m2PXJlFpkZZvq5fltmDFG/7I+/2ttHPPtNqCQ4
         HfP3s0X/gdLU8OsXPu1tChe+cpWZUUG5MeMDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745680673; x=1746285473;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BNlY1Kyobnrt/7plmlszUhTRPyZa/aNAr5+UYAUEWpg=;
        b=JB8AAXrZ68QzEUconTNAH9DoRSJI+WT6OzTBTm70r0g4V748UB72p/qq6iG8rzd+Ep
         AcZDMDuwKz+gp9G2wZejQjFIJq6sJjwa/FH2i4bKwc/OMHJ+028F4qlp+ZB/6gwQqJB3
         DwEY2IaX43UIDdJvpvjHe7iYc9g9Nzep6aBQShOqsST+Czn2ougYtW56rg4lNVHhGqz+
         lpbD3XQEvFlDGc0/7FEWCThVUvbNpeAWBJC+16S1eqY6U2zXlCqAs/yOciOjReHUgEUy
         1tOCgsaGreFZGhMLNwcskZJJEc79C3mgrQEYeb43H+QHn8T6o6nrHqSrI1M9ZkdlxY0G
         6+5g==
X-Forwarded-Encrypted: i=1; AJvYcCWv4z43d4eisXb5edEGk4N7MBmnO0x9/5SFawxmtIBN5JqbzXk08bPOdt7+EU+JJBFvUw8Moi9kOWVe@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6eJoL0hf3hjtyzMtQI05gWm7iDQigY0u7SLi7huG5fT0x6Ba/
	6T1BbEQBSbQicB83Vg4lZdW5th5uTgINbjGeHwDkdezbfG9gEy7SRjnG5pNojqxt0OcfZlyaJ9j
	7+gs=
X-Gm-Gg: ASbGncuKrZgcSg8S2TGq16ZblLlN5Q2k5C170JCYAbre2WhtZDOmfjCI5chVkkOb3iY
	0uomELZJdYaqrMeZ980RNXdcPFLJQ2wOFUJTuBQzz9pMJSXcUblrbg5eBbCGSEvWrnovmET2khc
	XlJV1MNCMiJ6qdTdbn47RmiYfH2GsUPgS7fj7PLiXQyhQInk/QwW1+rxIMG/z6uFCFs/qEMc//E
	0eJ/MyXYjgXDGQJSSroDwoOrkcxTr8OslKJR2WT8KMfkulekZ5kXbGx5ismR5dVw+xqxKwg1+Vl
	F+7ofA5o2lQXuKlT9kEv051bKehYWMoIdHcvn60XkKUspUA/bn6x16RztF+h8x3ysL0beVh3YJq
	wy7EY3Uu5H1aLn6M=
X-Google-Smtp-Source: AGHT+IFIs2dUXv4SxTKAi5W95KXqE0UG9AAA0T+1oqBTbgWYpwzIhZSIgi0p2LyH3l6FFYjqlhGALA==
X-Received: by 2002:a17:907:7e95:b0:aca:a162:8707 with SMTP id a640c23a62f3a-ace848c0281mr256192966b.7.1745680673038;
        Sat, 26 Apr 2025 08:17:53 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f703831b5csm2766583a12.65.2025.04.26.08.17.51
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Apr 2025 08:17:51 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2c663a3daso627984966b.2
        for <linux-s390@vger.kernel.org>; Sat, 26 Apr 2025 08:17:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX6sI/rMQcHjPFUxlLSwOvMGppHuQZXr5o3WVENy76P0C+NjHAK3ARov73HmBdSy3NAQTkt7teeFCge@vger.kernel.org
X-Received: by 2002:a17:907:7e95:b0:ac3:8895:2776 with SMTP id
 a640c23a62f3a-ace848c0439mr259814066b.5.1745680670908; Sat, 26 Apr 2025
 08:17:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250426065041.1551914-1-ebiggers@kernel.org>
In-Reply-To: <20250426065041.1551914-1-ebiggers@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 26 Apr 2025 08:17:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_ArMFL9E9SehR2Z3pfV5QPut0XwbJs9mYWkRvcZcSRw@mail.gmail.com>
X-Gm-Features: ATxdqUFbLPq86s-2TFMi3kWckNkp7TWtoBPlYGSlRtiuXxSXCOJQKui7bzYM-j0
Message-ID: <CAHk-=wg_ArMFL9E9SehR2Z3pfV5QPut0XwbJs9mYWkRvcZcSRw@mail.gmail.com>
Subject: Re: [PATCH 00/13] Architecture-optimized SHA-256 library API
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org, 
	linux-s390@vger.kernel.org, x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Apr 2025 at 23:51, Eric Biggers <ebiggers@kernel.org> wrote:
>
> Following the example of several other algorithms (e.g. CRC32, ChaCha,
> Poly1305, BLAKE2s), this series refactors the kernel's existing
> architecture-optimized SHA-256 code to be available via the library API,
> instead of just via the crypto_shash API as it was before.  It also
> reimplements the SHA-256 crypto_shash API on top of the library API.

Well, this certainly looks a lot simpler, and avoids the duplicated
crypto glue setup for each architecture.

So this very much seems to be the RightThing(tm) to do.

               Linus
