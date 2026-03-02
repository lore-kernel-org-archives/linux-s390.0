Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F04E2877C3
	for <linux-s390@vger.kernel.org>; Mon,  2 Mar 2026 17:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772472325; cv=none; b=fUAjqbNJk0sqBF4RYCBKX/2/Sac/B1ewK+LPSMCQrb1sEj5Ph68oeJ2aH+E+9wAznYmweDXp0YpOGmfuhuKqj0QyEgI7tv8DikM39b7lgQrL+YcOl21PlWw34IV8FTviPt6bh880flCROgEmL3sVGjdDKx2mq/XmRBJMm3fcke8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772472325; c=relaxed/simple;
	bh=bHDpiT/DMBChb2eg6esWRxtOQQQsukrENMa/lbFayFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4Jfc8s7bcRBVFVvGErCqFRIXgJUjX9Peo/mUXHEssIac66nuecH8e1G8ELwwezGA5y8v1lvWkr6x1zgbsH2nyhfd29Fm92SPmxZK7CSTwz8a9ORo8353rLfVZzZZGgwRnn1TG9l7fOCsC0CKnAwmXn54EAC6L8BeqOlkhkVNsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YNEg7GrQ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YNEg7GrQ"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-65f73225f45so7516252a12.1
        for <linux-s390@vger.kernel.org>; Mon, 02 Mar 2026 09:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1772472322; x=1773077122; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TbIkpYLS9gbJFch6OaF8nYKkHDJKdsVHvQjZGTHSn/8=;
        b=YNEg7GrQkrASmtxOsslb7zAIHX9LtW453CEBLjmHfhLgBhS/wQAH4XPDgnktvzwTUx
         5iWXrHSURTweNIImn2XODyT1aOb2N+bT1WkMlyi7ztpswbkTRhhyeMqvcQCrA9g4zMDU
         va3o5NImy++Q4/PqD7Nh/ozcUKopAygphl1ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772472322; x=1773077122;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbIkpYLS9gbJFch6OaF8nYKkHDJKdsVHvQjZGTHSn/8=;
        b=dULIXJAaNsENaCVcy2h7NUMOxNX30rI/cRAeJwOtexunJTGY+jRtUbisMS0AUGv57z
         k6QZP8Eg5tr5Pw3clOHV2xanm98fJgs5HgeBkD7lFNmZjTTA8rEAVOW5X4m8KPAOZqRq
         WBLb+9G0QHuURDTamQc6gFUT03WLUe3W5rFUG3nzEUe0CJxH5qlLmxDYuCDVzYjxxfEz
         nXk4vkfecY64VLjiFzhgtYXfGxQvTH57DHpllOjQelUFpmPuUsUmUHZJuz5NJGq99BAR
         lmECBg5FEfWharpQ5UZXGXWAR/0tUlhabEBM5W+EGyEUGJdBOCdXl8kaGBqXGchZpSc/
         +6Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWox6eah5vOi+0WPUF0vKNAiXECgx+LrtZ8gAaNmYPjJYekJ8JYFzLvYUjelfYX77R5hxqPRvwnM7Vx@vger.kernel.org
X-Gm-Message-State: AOJu0YwQI2uzXUAkCzzLQT7a1VecRu8/2RYhcFWv2GhrjSawskIFnq0W
	FaukdD41pZYm+OBF0tFMRrnO4sYQTRvZ9EWz214QsRIf8plmO/go/YG1lOB4p3YoD5ZGOghuoIF
	bSeyi+PGuhw==
X-Gm-Gg: ATEYQzxGr7A/oLdiWOk1uR2V8bsGWzhGmoIOmJKJjvgBEhXD40tEqoeVKnYAtJysnNP
	WiyL3QyyrFRJM5xP8+F68aIN8dW7aO5yCM3uPCC0OTQY6O8/lPkZpzU5sxYDqVmYQRbT2YLb9gC
	h1CsG9DJ7bWgvpgJ5azjt2FThlkrUZ45Qk6Eb+56QrZdZJlFfL1crobQFnQpYHe1EJ+hRIQc72H
	pTQxG/kTbbqmDZD6Y2LjK/58C72wnHD8UJ+O5LCR8HzSjkBchpMl/qDyzZYurIybps/sZwFl4sN
	dR+lUoXHKlYF2fbFuOffjWtaxA6lP3skXMu3X954FMpDNLteqqy4vu+PRCscZc57L+9A/Zl975s
	ZvPoh49DsSzqIJ/jNn8dewFmmzgbf5t/L6biarHJiHcIn6/551XqP4uycXCqrpMhOmpe0liNZb8
	0hQdEcdnQEC85OiNzbP0nFrzCXJn9tRZMfUQuuB4nkvuJsVAN9yCblPFxG35hjC9+kBJIjyMmX
X-Received: by 2002:a17:906:9fc5:b0:b93:6559:3148 with SMTP id a640c23a62f3a-b93765defa9mr711027166b.61.1772472321649;
        Mon, 02 Mar 2026 09:25:21 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ae613ddsm491271866b.33.2026.03.02.09.25.21
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 09:25:21 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-65f73225f45so7516220a12.1
        for <linux-s390@vger.kernel.org>; Mon, 02 Mar 2026 09:25:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWwtECuH9onWoCR8GBC2roC+p4LU6WuWkRlj/38FMcvoTaMpV4iz0wca7BzBp+wC3U2P0IlgdDL4h3t@vger.kernel.org
X-Received: by 2002:a17:907:25c2:b0:b8e:7dcb:7f1b with SMTP id
 a640c23a62f3a-b93763af8f8mr867609766b.21.1772471885098; Mon, 02 Mar 2026
 09:18:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302132755.1475451-1-david.laight.linux@gmail.com> <20260302132755.1475451-5-david.laight.linux@gmail.com>
In-Reply-To: <20260302132755.1475451-5-david.laight.linux@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Mar 2026 09:17:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=whaR_ujJvWGTe_fZxg_d2YSORZWnXwHLa5Gao+x136pYA@mail.gmail.com>
X-Gm-Features: AaiRm52ly83FU0bUfVtu2Rv39h3JOZJTzcdxMzg3AYFviKySZcFGK5yhPqg6aWc
Message-ID: <CAHk-=whaR_ujJvWGTe_fZxg_d2YSORZWnXwHLa5Gao+x136pYA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] uaccess: Disable -Wshadow in __scoped_user_access()
To: david.laight.linux@gmail.com
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Andre Almeida <andrealmeid@igalia.com>, 
	Andrew Cooper <andrew.cooper3@citrix.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Christian Brauner <brauner@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Heiko Carstens <hca@linux.ibm.com>, Jan Kara <jack@suse.cz>, 
	Julia Lawall <Julia.Lawall@inria.fr>, linux-arm-kernel@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Nicolas Palix <nicolas.palix@imag.fr>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Russell King <linux@armlinux.org.uk>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, 
	Kees Cook <kees@kernel.org>, akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Mar 2026 at 05:28, <david.laight.linux@gmail.com> wrote:
>
> From: David Laight <david.laight.linux@gmail.com>
>
> -Wshadow is enabled by W=2 builds and __scoped_user_access() quite
> deliberately creates a 'const' shadow of the 'user' address that
> references a 'guard page' when the application passes a kernel pointer.

This is too ugly to live.

There is no way that we should make an already unreadable macro even
worse just because somebody - incorrectly - thinks that W=2 matters.

No - what matters a whole lot more is keeping the kernel sources
readable (well, at least as readable as is possible).

Because W=2 is one of those "you get what you deserve" things.

             Linus
