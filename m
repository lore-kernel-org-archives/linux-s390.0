Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6D61474AD
	for <linux-s390@vger.kernel.org>; Mon, 22 Apr 2024 12:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713787901; cv=none; b=amz8NUBC7/CjbMpFyJ5Oq5JbawiyKYZlSIjFT7MirFz/EHITx5jaQ4HhSeaw1mqigy/yAsw0PJNBih/ky+pJEeqZ01mb9njY8yd8vb+CGgAeCM5KeigAdo0NiQnJvSZB4aFpwdhExZphHrALJQyK0bnmxd5fT9uu1gGZqXhWb24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713787901; c=relaxed/simple;
	bh=P+ngD7651DKaxK2xXQRIyCnuFIb7V6Y5I4v0Y+4liW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cBFBqxnT4Gx0IOJ9xrvP+CyUiok5H3ieDtkpr+jmSnTzMAtEBFBP5sOOq/yGAscRbq/50irrppfpyAwSEedGYS2jVRd/GhcTFWGQje66x8Xo4dLCAaGhFe6ZTv8MLecR05OR5nVHiKNS4lAOAW4ySqhDsTcytAp9Szos2+VQSC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CFHTz0AC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CFHTz0AC"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41a7aa24c4fso3332405e9.1
        for <linux-s390@vger.kernel.org>; Mon, 22 Apr 2024 05:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713787897; x=1714392697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bCRnuZK0O/QOXHu1Ldkstjl1doP0jCVLWLbPZKH0WnQ=;
        b=CFHTz0ACeA5cePDuWJvlh0c8tKCX+vdZE51F+lymx2ic2Y7hs2eXx05OW4IBWO5NY7
         enwTee91Ffu3VfDwyIkmea7VIvN1ABlqbVpYWHDO8qGLChX0hoAO+wasQMUtc896zpHB
         QxjKoTPskxJNDiDIqOlKG4CIT6U73cuCt0Vs9fgQM0ezVMx0psIJB9CigTkRj5XWIUKW
         xaeJd3fUGhkumQtrwTPbnfBgS5vg69UeFthGeF6sKzOfXwJNG5K2/VFS9jCmhxkfP77J
         31QAA9xu9VEv3dBKe3932dOMZdSw5hMYLReIRTM78EV4NCYcxeN6zzWPjQTuz5Shh7PR
         Wv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713787897; x=1714392697;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bCRnuZK0O/QOXHu1Ldkstjl1doP0jCVLWLbPZKH0WnQ=;
        b=P2dxHi3XU/rTqSb3Nd36nHOQgj0o/uOVIBoPuxSz5/00zJrq84ViEZClfUtRh0V8Ej
         xi4IoY2UClxs7ro4VJYsOApGUt1lXu6laCh7KXM9Bxng3DrvEJtRNgYsJc7/tiFPyaNX
         v4oHsJBTFSUeeSPUzqxJMdiRWOVrslf64TEEVMqtDblctRZVyVF9Hh2Z3Z2Zoh8m2jSO
         mB38ie66FfGkA+yUkO3dw9c2AqkRidRdPoUUVpeDczdRR9DqGkFOJplAEsWovQaA6xGF
         XbwRa3w5WURVsRobzf1z+LWu12Ns/rlS60CT5tnY58DRwCTvhGw7xqG/mgEg8axOf5Zt
         ZfwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCDJClv+zg4jmxQeCQv724+7pqZ0DwIioI0V6IwkU0lgA0EW5UeFYv6hbqMul0Kl/qtw3S8HmcLD2l4y5ORL+/6uLNFaDisAklIQ==
X-Gm-Message-State: AOJu0YxY3TEWNDvUYQQbklThPFgFo33NdWHhjfzAKl7vHnVZy+1I6h6s
	HE984PKxaBko1BCt4mWAqw74vwtc2Fl+JmXNZSEDCrJ81QhoS6KSEKxurzEemYU=
X-Google-Smtp-Source: AGHT+IHynTNWSPs7rYJt+CqENDAY0rj5tOUJ3mwkpUrvPfTTqXCsLGZ4LMBMh1xVXt1DdTNJhAB4yQ==
X-Received: by 2002:a05:600c:3552:b0:419:7fd:2fbe with SMTP id i18-20020a05600c355200b0041907fd2fbemr5536580wmq.11.1713787897251;
        Mon, 22 Apr 2024 05:11:37 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr. [83.193.250.196])
        by smtp.gmail.com with ESMTPSA id r14-20020a05600c458e00b00417e5b71188sm16503881wmo.34.2024.04.22.05.11.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 05:11:36 -0700 (PDT)
Message-ID: <fb942d49-1c72-40a6-8309-ef3331d8f8dc@linaro.org>
Date: Mon, 22 Apr 2024 14:11:34 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/15] arch: make execmem setup available regardless of
 CONFIG_MODULES
To: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
 Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "David S. Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>,
 Donald Dutile <ddutile@redhat.com>, Eric Chanudet <echanude@redhat.com>,
 Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 Huacai Chen <chenhuacai@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Luis Chamberlain <mcgrof@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Nadav Amit <nadav.amit@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Russell King <linux@armlinux.org.uk>, Sam Ravnborg <sam@ravnborg.org>,
 Song Liu <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 bpf@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
 netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
References: <20240422094436.3625171-1-rppt@kernel.org>
 <20240422094436.3625171-12-rppt@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240422094436.3625171-12-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/4/24 11:44, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> execmem does not depend on modules, on the contrary modules use
> execmem.
> 
> To make execmem available when CONFIG_MODULES=n, for instance for
> kprobes, split execmem_params initialization out from
> arch/*/kernel/module.c and compile it when CONFIG_EXECMEM=y
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>   arch/arm/kernel/module.c       |  43 ----------
>   arch/arm/mm/init.c             |  45 +++++++++++
>   arch/arm64/kernel/module.c     | 140 ---------------------------------
>   arch/arm64/mm/init.c           | 140 +++++++++++++++++++++++++++++++++
>   arch/loongarch/kernel/module.c |  19 -----
>   arch/loongarch/mm/init.c       |  21 +++++
>   arch/mips/kernel/module.c      |  22 ------
>   arch/mips/mm/init.c            |  23 ++++++
>   arch/nios2/kernel/module.c     |  20 -----
>   arch/nios2/mm/init.c           |  21 +++++
>   arch/parisc/kernel/module.c    |  20 -----
>   arch/parisc/mm/init.c          |  23 +++++-
>   arch/powerpc/kernel/module.c   |  63 ---------------
>   arch/powerpc/mm/mem.c          |  64 +++++++++++++++
>   arch/riscv/kernel/module.c     |  44 -----------
>   arch/riscv/mm/init.c           |  45 +++++++++++
>   arch/s390/kernel/module.c      |  27 -------
>   arch/s390/mm/init.c            |  30 +++++++
>   arch/sparc/kernel/module.c     |  19 -----
>   arch/sparc/mm/Makefile         |   2 +
>   arch/sparc/mm/execmem.c        |  21 +++++
>   arch/x86/kernel/module.c       |  27 -------
>   arch/x86/mm/init.c             |  29 +++++++
>   23 files changed, 463 insertions(+), 445 deletions(-)
>   create mode 100644 arch/sparc/mm/execmem.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

