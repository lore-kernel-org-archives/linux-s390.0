Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231BC17F377
	for <linux-s390@vger.kernel.org>; Wed, 10 Apr 2024 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768550; cv=none; b=keLQcMkFU8dfPlcadfaCq3wUywTjZt5PK+VbpXh26q9l3k8wXxUAOpx3F/QRmHGQ3znBojkG5q1u5IrHCs6Ly68exgfqV8wpwpeU1fLb4M1qTJY/8qSFHe+hP8Qe5mWC2PEAgH6zyYYMrNcA5016wiTAtkzYZaJMSQzqLIzDxDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768550; c=relaxed/simple;
	bh=Ro3xK5q4IrY0T9S12NVIoXoa4EqFPVxp3QMVafHPnmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AiAQIarmfI3/LMo+umgnlof1yB6JKQIHkAl4kDETCoCmfHMini2cg6/CMlcJxUDRD4xR2unLaSnhU6MUrjEnaeOm1SCOPU+7PCqi/5NIwU6hMgG9J2IhWHCSHrpVptWKE5hYFgU3OtBZftuMjfUwUbxsltGJXr4ILrUReBKXZ3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gCJdMayQ; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gCJdMayQ"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6ea3627014aso357540a34.2
        for <linux-s390@vger.kernel.org>; Wed, 10 Apr 2024 10:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712768548; x=1713373348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMoPP11thXk4/7UbTWGCDNVZtlBCq9YfZi08dxGpwkM=;
        b=gCJdMayQNcptgjdyj0XaPYS/CKWxiizmrKkPOZNY0BJquD+IwfqjDWiRiNpCUs33P7
         +YVtVAie+wmxlztmBDbeqrmxb/AN5GmAoISgmi9wEM3M7BQBgROwPk9vcIy+DEtsYsi1
         S+HtUFuuH4cYepRdrbjYd3Sib1mPdNt+lgDkERubGTY/9qmT8+re7qk6sx9vYgGqeMvW
         0Rte4kJkErC8SJggf/EXJasb0QhCZP/hJwyukXcOa9Neb7BJjdyxiA3ZJpPAbhjk01Kl
         Ud9klQBZNxFct+Qj+nPL2xlmiR+eUnAgnrD6+Ey0tGebf3ydWAJ31bKorzKk8VvMsfZ7
         1Y2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712768548; x=1713373348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMoPP11thXk4/7UbTWGCDNVZtlBCq9YfZi08dxGpwkM=;
        b=GEFazx+bXAo4z2FiZLu1eBvzFQNQexzDET0UpiuY7fMJ6gnQrAvUyqGnnPdGdX6mud
         I+/lr1XwpJhs2TRC9u0oxhX2wj6EojoXAgB5ZCvLD1uPn5wt7acaqgkocoJN7zyZNfzP
         XCBfF4379FUIF2WmM2K6Y35qlqsCaX/K43NuQ1cvOGWknSkvhMnzA5lfDEccUGlXtEM2
         2Z/NwjDSCWNCeoRbkZaZ1fUiSNf8s9X8CRoYk6F+w/68eXiK9LSRFzempdr5Dr+dHN4P
         KyTTPBdqh0zyXiw1iWDYpQATBEF+PyyGkC1e5JYNHDXa8jfROWc1yplmv21v7Fvq/dFu
         cqGg==
X-Forwarded-Encrypted: i=1; AJvYcCX04FwcIKLxHMbF/9OVWOjb/RLfWLxo96Z0IjFWkMz5nNcOpg4cioGCCgHabIOB/bbFUKBek7PjEqvilH80zT2KbGeqkF1N7lbRPA==
X-Gm-Message-State: AOJu0Yy23BfUoXzhT7Sh4w1YqmTTQ+uJyO1EIcd/QezM9TnTQC89dn2Z
	nhfC7ZItVI8pvOz81UzLiEJcjEsz+n3jQQ04hsmwxj56S3+fm4sUzkwJTF3SsbwaraNfdwL+nub
	myDjLpJZx8sSbiJIRdgcWF8k7R0ssjvSPWd7YCA==
X-Google-Smtp-Source: AGHT+IFNF1nhZXvybXgcJEFh8M4RKpKSYief0sXA9TsDfyic6FFts1F5HiYeJTzbEnw67nBhXnq5gM9nLeSrRUK3LkY=
X-Received: by 2002:a05:6808:20a3:b0:3c5:f831:5f33 with SMTP id
 s35-20020a05680820a300b003c5f8315f33mr3792446oiw.16.1712768548028; Wed, 10
 Apr 2024 10:02:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410153212.127477-1-adrian.hunter@intel.com>
In-Reply-To: <20240410153212.127477-1-adrian.hunter@intel.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 10 Apr 2024 22:32:16 +0530
Message-ID: <CA+G9fYsZcOv+tE09K20b7G=4s9D=HxAYwMV_zx0oWa1r2mqdrg@mail.gmail.com>
Subject: Re: [PATCH] bug: Fix no-return-statement warning with !CONFIG_BUG
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, John Stultz <jstultz@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Anna-Maria Behnsen <anna-maria@linutronix.de>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Apr 2024 at 21:02, Adrian Hunter <adrian.hunter@intel.com> wrote=
:
>
> BUG() does not return, and arch implementations of BUG() use unreachable(=
)
> or other non-returning code. However with !CONFIG_BUG, the default
> implementation is often used instead, and that does not do that. x86 alwa=
ys
> uses its own implementation, but powerpc with !CONFIG_BUG gives a build
> error:
>
>   kernel/time/timekeeping.c: In function =E2=80=98timekeeping_debug_get_n=
s=E2=80=99:
>   kernel/time/timekeeping.c:286:1: error: no return statement in function
>   returning non-void [-Werror=3Dreturn-type]
>
> Add unreachable() to default !CONFIG_BUG BUG() implementation.
>
> Fixes: e8e9d21a5df6 ("timekeeping: Refactor timekeeping helpers")
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Closes: https://lore.kernel.org/all/CA+G9fYvjdZCW=3D7ZGxS6A_3bysjQ56YF7S-=
+PNLQ_8a4DKh1Bhg@mail.gmail.com/
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

This patch applied on top of today's Linux next-20240410 tag and
build test pass.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

> ---
>  include/asm-generic/bug.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

--
Linaro LKFT
https://lkft.linaro.org
