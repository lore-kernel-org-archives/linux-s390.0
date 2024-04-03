Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293BC46537
	for <linux-s390@vger.kernel.org>; Wed,  3 Apr 2024 05:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712122248; cv=none; b=h6kCpXI52kZ1k3faQP9ReUqPIV3TSVN0P4a91IyRRNhl6cYukVVHTltQq2+RRZes56uG3aqVerB77E5V/3QtXnpo9V0V8WJwTb9NmdoCZtxGIQwu+j4pd/HP8FMg/PgXLDSfl+xWbLcebpEhWyU2SE3M0HTW8bNg+y14R8pyPdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712122248; c=relaxed/simple;
	bh=WbyZBV3R6H5PKDZW5ouaxklPr0pVydg0o3dHBgCNgpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CWiwoXiW6vwTFCWDuA5gaqHLrlNmwZeKeZzxvwF8ZfpX4OxmtejOlJH3pHnR8iNMQEMwqbpLcJbu196miMIRbjIcelWxwbd1qYPUxLJA7LGXkOEO+QdIRZXSfMYcxmojGL+64ftYRVwnijyrxeyTSMlXSY5gWi86j+Q3A6s6iso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kRs7ZAfV; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kRs7ZAfV"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-60a3c48e70fso58118857b3.1
        for <linux-s390@vger.kernel.org>; Tue, 02 Apr 2024 22:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712122246; x=1712727046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FGC0ogSAewDWnDccn9HyW8lHJXe75+YXBIJHLHFGHI=;
        b=kRs7ZAfVYXS0UjTf0la/sXrxEBUbs0nZxjoAGLv9YE6HO16DiMbLw/I93c11uNjOy7
         qsWVtR5y+ZuGl7WXysNGV8oedEuP+Wih31rbydkuQqF5pqE3MLLUVlxrnD0IYXgL6cee
         hKIm+LlXTNz7mv2FjwvLVDqu2WuIjsic8mFygiJsAht7VZ7Q3DjPC8lnNiZoBJHjlFbM
         4QmyVqOZIumd3nl6kz6XfAX9lHp4OXqHBfdNz6aOV5oMg/sH1UVIALc7gBon6SaWGLU+
         WZoKAZdvjg7WcM34w56dsdqsb4hcCWnI7qCtMKwPepWIm0+DeJksItqMuC541ZAfwTJo
         dofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712122246; x=1712727046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FGC0ogSAewDWnDccn9HyW8lHJXe75+YXBIJHLHFGHI=;
        b=oHSyqf7e+0VwtAjtynv5Mle5zHoAXLtyg9kNIF2NSvjVqwfR8rvJ2+BirLkOal1Jgp
         WxVG1S8BbRtf4lzHXequMZ8yI0m1qJDF/lng+OCnRylhjjY4jmxzxIKCMAaswPUjJD3r
         6a8rPhF8W9ijjGTqndYqH8jHaJUdNQhur/pDMlDy7gyFvixFHsb2NMnnK+8Rihu/uo+H
         JBEO1a0Ggs6FX+fA3HqBFvs+mmAjQ4iss97FMiMln8gs/+K5URclkMd8aUlP6bH4l2Jf
         yio6/7xD0c74L7rV2QW0z2B0syIRR3/HllgkMKgOauqIIgpy1Qqh5QpiOc752GNu3c4I
         IhJw==
X-Forwarded-Encrypted: i=1; AJvYcCVWE9FDMi8rDJ3s86njt0iqmLy7mkmsSo17Oezkxx+EsWitRVpspRCyb/zHlQVW/2wI9lQ8UDghlNTEueLINayQHfXXdxma8/LB5w==
X-Gm-Message-State: AOJu0YxAulqOax1uPEervyhffJA8LQrFl0LYemaiP8oNHE1YTITgkon5
	kZGl2lZtUJVSsAG8/lvOA/tiGsArXk3cRdqaxPL8PeWonFRpvNx+b18M9/iBulvriWM0ILf9LgP
	Ye46f/ZM5q48D517T7b3o+MMZ+G6b7eVEP0Ng
X-Google-Smtp-Source: AGHT+IERcF+ZJQdvucNfySTOQI0rZqXN5JPmGGJueefxP3/c8KUs6v78wwHnFWFD/9UuBTtutSqFi5LiGSrexLI5jh0=
X-Received: by 2002:a25:ce10:0:b0:dcc:cadf:3376 with SMTP id
 x16-20020a25ce10000000b00dcccadf3376mr13231486ybe.18.1712122245862; Tue, 02
 Apr 2024 22:30:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402075142.196265-1-wangkefeng.wang@huawei.com> <20240402075142.196265-4-wangkefeng.wang@huawei.com>
In-Reply-To: <20240402075142.196265-4-wangkefeng.wang@huawei.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 2 Apr 2024 22:30:34 -0700
Message-ID: <CAJuCfpE7txgXZQG=xvzKYtKUs=3V5C9pe7OOzf71BGPfb+Qqxw@mail.gmail.com>
Subject: Re: [PATCH 3/7] arm: mm: accelerate pagefault when VM_FAULT_BADACCESS
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
> bad access, directly set fault to VM_FAULT_BADACCESS and handle error,
> so no need to lock_mm_and_find_vma() and check vm_flags again.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>



> ---
>  arch/arm/mm/fault.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index 439dc6a26bb9..5c4b417e24f9 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -294,7 +294,9 @@ do_page_fault(unsigned long addr, unsigned int fsr, s=
truct pt_regs *regs)
>
>         if (!(vma->vm_flags & vm_flags)) {
>                 vma_end_read(vma);
> -               goto lock_mmap;
> +               count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
> +               fault =3D VM_FAULT_BADACCESS;
> +               goto bad_area;
>         }
>         fault =3D handle_mm_fault(vma, addr, flags | FAULT_FLAG_VMA_LOCK,=
 regs);
>         if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
> --
> 2.27.0
>
