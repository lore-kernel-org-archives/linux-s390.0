Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520D818A6A8
	for <linux-s390@vger.kernel.org>; Fri,  2 Jan 2026 22:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767394449; cv=none; b=UX5sl96gf+U+iaNBRCCz4sV14o+ImK1k0CYxDCkuRO3FJ4EnT0QV2I2fdXxnYrXFLUOOKFJbBmJFFTjsep6bsrxbh1GDN5CStsnXG3k01JCJOTK8SfPY8T+LOqFS0LLZcAFi2wgsHT0OoecdciETVETk9rdFH31edDyxzm3BxVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767394449; c=relaxed/simple;
	bh=kPMxx2R7Gx5ZxYwa7SRt+S3sFaD5KMccJKMZB0MZviE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fA29PwsGDdcsCSHXgzsjlx4bOUJ9BSpEioVNXUKq3exGdWxDKr/BZ0qyo9tA+3IMKFIa5oD2y4hcoAKEQz0KAcus9OOQwYUs3xO8kkU3PSTkL+s6y0ZqNBxduTLjMCgqrjk6mCd7HPl/+s8EhEfyHXj/BsAev5KlwIIgwPQuhpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYXCMywc; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYXCMywc"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-430f5ecaa08so5070459f8f.3
        for <linux-s390@vger.kernel.org>; Fri, 02 Jan 2026 14:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767394446; x=1767999246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StGZh5UIhFdeUEf/ngmSy2NSY5Z+LAPTFt5BciOr9oI=;
        b=SYXCMywc3jtTL3eeoySGXWzOryGNIh716Yk2bb5NqvXUeaI0YVh7snV0fnf7BsuMOa
         PIDk0tLAD/eNgqSMUAfaEYm6bsGmlCYPJ4SAP7mTO5V2ihUnjtY0paWhTe5U7mzXQGOF
         NXEO87yUbnAAxGQBEhwheV5eHqRRan5hrOmPSvYBaa6Zdyp1r1YfLjYOuR4x1j+yZh/h
         jzmvLp0XizDEgpnSmob3rsXlXJnnIaojUNjILlYXZq2Xbv990ROsc/xZEmRc733xZj3Z
         +IZHI69tinmTsmuc6iIiX48zrFX4tuN4Xe+UG4HvVwjsp5JWOQVZGscpJTZ23SeejvmI
         jL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767394446; x=1767999246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=StGZh5UIhFdeUEf/ngmSy2NSY5Z+LAPTFt5BciOr9oI=;
        b=R1dFWmLv9I5OY0iL65Nwj8zRPzfCLzurCi9mUsrx2ylzztCN2tv58btpTEQGrdtQ5B
         3EorYinT/yE0HfO8ZQ/7qDKQ2dANC1ZiqYV6joRWyScbUXiqYEi7gt1uVb7DeEViYB8j
         j3Vh/q42kejYekef51SxMW7yZxz3Xct+wPspv3NVCMbv8YkCcqxjSwp0DDZdBkBglP/3
         78locV7FfludNiegdCdfd80HKNe/c5rZ/6nynqN+o2iFAKTiMmaKNqUbe6yJrRCRW0iH
         g7mWWgs9/C1VY8yoKXK0RwjRw2sMYuTiLL6UP7ovLT0QdWmb5rP36wwntH0DAGQHzoFw
         xjWw==
X-Forwarded-Encrypted: i=1; AJvYcCWJBRrYVFggXZPdwYd6v4m9wml7DmANHqnw+sYyP4pFIYa0jFoTIoUwjsqFb/Ece2+bmbz5dWRbrAMx@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/5EgxOJ2qOyTyPIcPlA3yBAH6tVSDUv56OCH4u+dIsC5/EleE
	+CpUe9oxnBEpgpaKjsBqN4vZ7lAt4UFNbS4qhzf4aGYxFihilS8RW6FS
X-Gm-Gg: AY/fxX55t9OCsICSVO1wF1A/kdZ1Nc7e0hf8Ewyl5WcAQE/1NP7ErZsqD7wesJRB82R
	wjVTfZjmygMhGx/lcCiU1pJBzRhpcxCGFOtXqK60pKiYBSnL43hccP8pSDXAUkK6jkHLGHx5T0Q
	tHjdOEoMs8caj1kxGHGBao+lfAue+8304+01nvK75MVwB7LRG/kwcin30cIh7sd4PerkLwcsAQZ
	bWnlAVhasWlM/EFjcMl4e5AAyiCpm1m7zF65jCa4Yxjb6tMuvf/2oJV0DkhlQJYfpBoLsRyD8e3
	QuOq/3Z5eqW7/V06ZMjtrRzmLchxkM8P7qOi5qSD8PhiMG68b9jFGtuQot6MLJX9qTSZzjeynoJ
	mmiX3duHo3hT+6uwxGigOc5jWYb7GeRyY5wvXmbIkuHMJa+GU/IVEWjFYgdXbNYCoznBX/+n0mO
	EUxo3pPNyDJBb3ecSkmjQ5c+Hz6iTfYv9G2raamVLrzaueIO0zC6A7
X-Google-Smtp-Source: AGHT+IHhZlcstoHojBz97OFk5owjy0cbb1cp4fYnQEbcnWo+WUycqSneA9mdGDNlnSrZ5xQclO2tXg==
X-Received: by 2002:a5d:5392:0:b0:42f:edb6:3642 with SMTP id ffacd0b85a97d-4324e704c03mr44422531f8f.60.1767394445433;
        Fri, 02 Jan 2026 14:54:05 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab2ebfsm86000586f8f.40.2026.01.02.14.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 14:54:05 -0800 (PST)
Date: Fri, 2 Jan 2026 22:54:03 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Huacai Chen
 <chenhuacai@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland
 <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Jeremy Linton
 <jeremy.linton@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 2/3] prandom: Convert prandom_u32_state() to
 __always_inline
Message-ID: <20260102225403.78e26214@pumpkin>
In-Reply-To: <CAHmME9qHiVZwf4TAringRHSZ-yqHuPwmP=Wnx98n09jv7Vu_Rg@mail.gmail.com>
References: <20260102131156.3265118-1-ryan.roberts@arm.com>
	<20260102131156.3265118-3-ryan.roberts@arm.com>
	<CAHmME9qHiVZwf4TAringRHSZ-yqHuPwmP=Wnx98n09jv7Vu_Rg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Jan 2026 14:39:21 +0100
"Jason A. Donenfeld" <Jason@zx2c4.com> wrote:

> Hi Ryan,
...
> > +static __always_inline u32 prandom_u32_state(struct rnd_state *state)  
> 
> Why not just normal `inline`? Is gcc disagreeing with the inlinability
> of this function?

gcc has a mind of its own when it comes to inlining.
If there weren't some massive functions marked 'inline' that should never
really be inlined then making 'inline' '__always_inline' would make sense.
But first an audit would be needed.
(This has come up several times in the past.)
But if you need a function to be inlined (for any reason) it needs to be
always_inline.

Whether there should be an non-inlined 'option' here is another matter.
There could be a normal function that calls the inlined version.

	David


> 
> Jason
> 

