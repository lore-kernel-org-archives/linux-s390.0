Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35BB1D69E
	for <linux-s390@vger.kernel.org>; Wed,  3 Apr 2024 05:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712122676; cv=none; b=k7E7f9dLG5k8HVq0RGW635xZUB2QkVxk9mPWb9ZJ6GZQSF4zO9z17DUX3VvhB+1MAkz9hMbdDqJN1IGbqPEdkoc6to6qk2bHxlnFi6MxFvwfpfRHHx9UTwPnYGQ6IDVt4FKJ2yBWHuY3Vjp5z84UCb75D+7xf4TXpqzGcffiSo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712122676; c=relaxed/simple;
	bh=txr2+JM9tiLKvxakApi06LPCnou9f+rYPTAbzYrTnuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJ8XBKVBNMgvVDTLsANuct7dxX0kvx2jMtjqx8CJ3G8p/epwBrXdPb9G0Ji8JTCoN8qfeSomF86732Hlc9x44nikZw1K9QWQn8PAuS2Wr6ak4M9wHzZdXYoBFTZ49xYvTrARfwV1pEDXeluUd20mmg7mDn/OIa7AFL/MbDctiQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NokWvb5B; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NokWvb5B"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc6d8bd612dso6043683276.1
        for <linux-s390@vger.kernel.org>; Tue, 02 Apr 2024 22:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712122674; x=1712727474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7ujj04+OlaPcvnr/mU1u92sbiZXtwW3xdBUhXyZWrg=;
        b=NokWvb5B2PXrd109FGXmgmtorwnzKYKJ82m/aHMS8x74awdjhvE+fNGB0WaqJSFAPq
         PJ9n0r1LCw3tV/KSqzCaCMFRc2i/eGj8dzn/yxSncrKRxW4OdaN44tOyVRrKqcT3sYQb
         nG4ePVysjXN1VoVSVED2ql7lUvZ99el/qZFZ+vvO9NGkYJhsK6hHiFFQwZZmDGxbbTbO
         jIteMEWrgBI+9emSAle4lJ1sULFPpPp31NuKHFFnIE0CHj4bkOzFV0NRCgOPiFujFEn9
         5ztdtXqu5WeY6F8UkkKVyS/NlVDj4GE3fA/1/qjSiU19JphHFqPZcgp92jwTmVTCgPS+
         G84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712122674; x=1712727474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e7ujj04+OlaPcvnr/mU1u92sbiZXtwW3xdBUhXyZWrg=;
        b=RlKSkoE0bCVkhCRINIwPBGzLKoD3yJhu1xQMvy1/WJI1GWoh+RcwNwLTHX1FgxRagR
         FA9jr6kvwplH7laNHijIAtCQYBH8n3EPr7P1BvEzXf0/byX0TTPTjL8KB8gN8JaqSVry
         8Bgi+2QpyTR3xsECFzt1Dvkcj6pCeTYRDyIxonzrctJkjZfr+yIzmWcjQbqfeP0/J22f
         PEEGuq5vpRl/PMvHztteG6/jwLHNae+XsugCd9c3RAqM47z7e8IZWl/a3o9qDeNDW/VS
         CeFu8Fk17dnoXT74YQjHQcrXlKJHlcjXnr81sww7VBgxfFZcfaVeTFORitaIvkTna2l8
         W6Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVhdYEzoQC9Y4YVz/5TyIPH3zXl6KHW2WxW09iafdA5nhS1i875pD3jT+rLiZKMXFh4ku/lipr1ZJY5iY4GNrjiYzdGGnzyVSTnjQ==
X-Gm-Message-State: AOJu0Yx8PITY6hAA8k0acM1V4kA1syIOr+qO5AIDaQhdCv347erSwwlT
	ZpNsgPWMXf9biBqorBIdyesSKpDI57VkxIDoZt5uAGB7sPO4u++bSBJG3liAGC/qN24zmvYxllH
	NUTM6UrMIP6rFwmJxnau0shCGqA1MDMP1bL0Y
X-Google-Smtp-Source: AGHT+IHpjlrFXGBHC8xjiSR2pkdos7fU1V4MIpNPbQfj0CNzmJ1GKeTFoSnYGK3QnW6iiu8Gm/GTnJLLIVUWpqvl8zo=
X-Received: by 2002:a25:bfc5:0:b0:dc6:bbeb:d889 with SMTP id
 q5-20020a25bfc5000000b00dc6bbebd889mr12522955ybm.52.1712122673515; Tue, 02
 Apr 2024 22:37:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402075142.196265-1-wangkefeng.wang@huawei.com> <20240402075142.196265-6-wangkefeng.wang@huawei.com>
In-Reply-To: <20240402075142.196265-6-wangkefeng.wang@huawei.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 2 Apr 2024 22:37:42 -0700
Message-ID: <CAJuCfpGa746Fn+i=M0oDEGMEJYTJhZ3m-paZ6k3tbZs+yJgu8g@mail.gmail.com>
Subject: Re: [PATCH 5/7] riscv: mm: accelerate pagefault when badaccess
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: akpm@linux-foundation.org, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 12:53=E2=80=AFAM Kefeng Wang <wangkefeng.wang@huawei=
.com> wrote:
>
> The vm_flags of vma already checked under per-VMA lock, if it is a
> bad access, directly handle error and return, there is no need to
> lock_mm_and_find_vma() and check vm_flags again.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  arch/riscv/mm/fault.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 3ba1d4dde5dd..b3fcf7d67efb 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -292,7 +292,10 @@ void handle_page_fault(struct pt_regs *regs)
>
>         if (unlikely(access_error(cause, vma))) {
>                 vma_end_read(vma);
> -               goto lock_mmap;
> +               count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
> +               tsk->thread.bad_cause =3D SEGV_ACCERR;
> +               bad_area_nosemaphore(regs, code, addr);
> +               return;
>         }
>
>         fault =3D handle_mm_fault(vma, addr, flags | FAULT_FLAG_VMA_LOCK,=
 regs);
> --
> 2.27.0
>
