Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A17921CC54
	for <linux-s390@vger.kernel.org>; Fri, 15 Aug 2025 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755270353; cv=none; b=X65z1p7mGllACDQrAfqpuYMnQTyNU/JiyKePqJC0NJtU+qhIrxMbQ3+GXMK2YZdaVKrDux+FKM8k4o6ZoqMkeW8EMY5WilBRgGjCQpTxoFm8EoWiiAWFUaAvwa6qwjCVXTPeByX3F81e77YBWwUF17MXPyKxzcFsuI+pBGbYH6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755270353; c=relaxed/simple;
	bh=wNfhEAk3rnqID1OBHwaELciuLi86NZwkA7swq1t5JdI=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=iYZEDG7DHxxazLR2K7qqu4G4aP1wYOAIjQikN+cSgYzk6rs2m79S5DJjz1rLeahD2OM2kkooRFnlV0ivGh0MibMlcRvozzCWRkguIrm4eBnyQ+qrkjRP4LZh+omHKleDTuptjM6KD3EeEymNys7cRcw1vfdk0CSonof4y9wI6ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=mZKauASq; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="mZKauASq"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e39ec6e05so1091360b3a.2
        for <linux-s390@vger.kernel.org>; Fri, 15 Aug 2025 08:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1755270350; x=1755875150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=38zqqxNHqbGz3C68JOy9Ugb8wAb711DWGVbxjNinx0U=;
        b=mZKauASq6wZkezrwzg5EsqpZPzKSyUiLiawcT9BlsvW3YiILWWbdCLQfpTP13qY6fB
         oZwx20nglnVNrDmmPfk4aePlJDu2TAg1mBu6EglTB/5H97T2cGuSu4PxV7HImr8TrepE
         68t/id3y3tOVHNYVxVkwTaIc14VHd7H1o9mUsS4bzQlMJR/z7XxZmVnGsRHSebQYgnEV
         rSZiKzLN5z5qnW2SjxlNV1Brx5GmqFnBIIZxMHmU2kyWh2/WybeT81JLEcA4kHv1QC8W
         CS8Wu00IF1ktWN/Ff/zHUzMA0yvpQqSCuCbC8nUpYkKRabnJW3fuJQ0QupC66XAb6JiG
         WqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755270350; x=1755875150;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38zqqxNHqbGz3C68JOy9Ugb8wAb711DWGVbxjNinx0U=;
        b=SeP5wnhfrDGzI/HRAEhDyOR9BHsvd28A5EvdUTVPaOfoAs51Tw9sazFp5ZWDXm0wrf
         fkXo5aPkw3yC/4DMtBhhBD8tt89wXvSOLMndxmIP/Knyd23O0MiAXsXXmSZKW2jeTwDI
         5T3F7PYnu4RAE7QXyojP+oO/0NNVTqTSOH/pP2DB6nFksjFYXjLtyVknvrr2HLPZNVz+
         OAvUEXFNp5Ns5VBm6Kn0WYq5qsUCE6zg7tZ2ipCQrt+UUGurnfcNBDhkIAXfBygQ9Fcw
         Dtb+XH4Gn7l19vzdeXE99pTXib1YuSzY30/WoAz3dbuiX9gDjy2BM6uCBZ6e9Tfpxozr
         IM5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvoyFBAHSVxGkok6kP5kssA+n6NPfFv4325Mhaud4CjM4FVZeewd1fE5GjnSSnZNfAc/AJSWFIDcE1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6WYq0g4b7YvlSuss5bNEkFrI8gq8k6ZTq5kr2Wd6aVfJG8je5
	+wBycW7GB4+zJjp4tJXH5lc6Wx9MQflNUGKVQGkBidtXIO9h9zQLFLf3lVyr95G/bsE=
X-Gm-Gg: ASbGnculF0MZgAbAa5h8KWfT117b/b1+wykl7wFfWbkALM4t84cO+oYhrQKtp6FgEcg
	iLGY+4n1CgoI04scgku72v0fwGosw9qcSkyiY56WM7LgLitfSaLN+6F37eaeZE5jmzPozsj7qVh
	IK74nBsJd85Yz5VCZE0G2iNGLSBFeD2yyMBP4cDl8PVazpa+GbLEOsCWUchuIAvFKfF92rDTBsW
	jXWXg6tUAYiKuy7mvIHmv99d9VecoiQxGNJg3Cz8fnn8FVjKaFc9gyOngSt1TZcGLjEwnSYgGOr
	UmwdFovDY9H8tL79JvrniIEPT5KwNKYq+rPhx21EyjsJd1OpdbosC5bLxlhi2eahn6a2JJeOb35
	9fyic+LcgeqRFgTWx5BT+zqHYd3t2LamMCxw=
X-Google-Smtp-Source: AGHT+IG3gBMogdOr+spUGY65daTLUVfmz5lhgO/opdXo6UimhkccgL0C2Gx+F8DUbrOBq4AI/2z6Vg==
X-Received: by 2002:a17:903:198c:b0:240:a222:230c with SMTP id d9443c01a7336-2446d5af743mr41307075ad.12.1755270349908;
        Fri, 15 Aug 2025 08:05:49 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2446cadf96fsm16286885ad.41.2025.08.15.08.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 08:05:49 -0700 (PDT)
Date: Fri, 15 Aug 2025 08:05:49 -0700 (PDT)
X-Google-Original-Date: Fri, 15 Aug 2025 08:05:47 PDT (-0700)
Subject:     Re: [PATCH v4 06/24] riscv: elf: Move relocation constants to UAPI
In-Reply-To: <20250812-vdso-absolute-reloc-v4-6-61a8b615e5ec@linutronix.de>
CC: Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
  Alexandre Ghiti <alex@ghiti.fr>, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
  justinstitt@google.com, luto@kernel.org, tglx@linutronix.de, vincenzo.frascino@arm.com,
  kees@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
  hpa@zytor.com, richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
  linux@armlinux.org.uk, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
  maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
  chenhuacai@kernel.org, kernel@xen0n.name, hca@linux.ibm.com, gor@linux.ibm.com,
  agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com, tsbogend@alpha.franken.de,
  ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
  bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
  tmgross@umich.edu, dakr@kernel.org, nicolas.schier@linux.dev, linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org, llvm@lists.linux.dev, linux-mm@kvack.org, linux-um@lists.infradead.org,
  linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
  linux-s390@vger.kernel.org, linux-mips@vger.kernel.org, rust-for-linux@vger.kernel.org,
  linux-kbuild@vger.kernel.org, jstancek@redhat.com, acme@redhat.com, alexghiti@rivosinc.com,
  thomas.weissschuh@linutronix.de
From: Palmer Dabbelt <palmer@dabbelt.com>
To: thomas.weissschuh@linutronix.de
Message-ID: <mhng-5B6E084E-60EE-440E-BFF9-5E81AAC9A473@Palmers-Mini.rwc.dabbelt.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Mon, 11 Aug 2025 22:44:19 PDT (-0700), thomas.weissschuh@linutronix.de wrote:
> These constants are useful for cross-platform userspace, for example to
> process ELF files during kernel cross-compilation.
>
> Move them from the kernel-private architecture-specific header to the UAPI.
>
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>  arch/riscv/include/uapi/asm/elf.h | 66 ---------------------------------------
>  include/uapi/linux/elf-r.h        | 66 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+), 66 deletions(-)

Acked-by: Palmer Dabbelt <palmer@dabbelt.com>

I'm going to assume you want to take these all together though some 
other tree, thanks!
