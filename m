Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB22E45BE8
	for <linux-s390@vger.kernel.org>; Wed,  3 Apr 2024 05:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712121134; cv=none; b=T3xumaX6iHC9LBbEoDCio0OlB9yEDMhnvYE50ytWkjSBoh4LvQSd/NVzWJu9npjnYK6+5YKHMORetP6rNVn/qz/BPW+84yBZIY6WEyVWRUXZW9UWpDjM3a+YFgGSDLyUBDj+75JpbHLg13q7Vxrfoz71ixJWcCeT7BprFUj/yqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712121134; c=relaxed/simple;
	bh=gk1ceLIqH+4O26RnUpPypaZWFeUJyuxmRfQ73gUdFB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opDZyAWwnEbFQ9GB1QWgesk/W+1vY660bVp0ysBU+rmRuoK4y1S6PVO4+1ifjzKwT0BMtE0fElx4ra0HtCsXcZbbMvYVszyE5gEYz49wb2XktYkW7CcTPFPGCjX5/MHfda6YuazQGjquHft2QLeWGAVQyXG8UCohPOs3XTzqk00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aXnY+4PU; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aXnY+4PU"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc745927098so5604433276.3
        for <linux-s390@vger.kernel.org>; Tue, 02 Apr 2024 22:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712121131; x=1712725931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxRG9lv5n8fexIxo+XXVWIBRdafbxcACyQss08DTFqc=;
        b=aXnY+4PUiwiZhn7IvOcswG5yjJf+By4a580ApT38OEiBizO3zO9zchRpFBDZR+gddh
         N1UUQSAlaWtguNM3XdheQzbXRSacW7OdDeQBMbzJZ6HV4nUtAHM8oTio62Hg5kpn03ij
         EORRSR2FsExte92MPdHJZbpObk9gT83EeqgWhl9BNLePRHHr0oWUIh8mBWUMfQu9QNu8
         J1ec0DOXpGYLzy3/l0woUfhHqWiw1lptJJMpFSq2lia2wlPsIqpLuwHs8FMUxphFbA9h
         h7WpmP4S005KUx+SgSau5kaGiz4YxEZe05ruXavwT+O+4dj9XCzycAYlKZxIsSFYJdiD
         U3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712121131; x=1712725931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CxRG9lv5n8fexIxo+XXVWIBRdafbxcACyQss08DTFqc=;
        b=BL9wFLEU9imoIOopx8S0GeIeZrR+HImMwKQ8+ygWgZUVKNDq5fAlFZ7NxZMp8D7fSI
         ACd2lkPk6KcPKYEV67DqwytVWvxTx4Ihp1LTCUSYnR4q4yYVN5Ab7baToc9UY5LJRSYQ
         ZxLdWXPpNqhHvwHYrOhN/3a4VPW2BX0355lbUbLc6Egu1Xkh+0ndKa7yqbUBBQu2ToKx
         B3qJQxTt8qD8W4TH8cao77emOxlyFNObfq2CiJeevYrlKNPCi8x/+ra27sVnX8H1y8GI
         heLzorDY2729FSvqdrCBP6lR1PusKkBdMAH9Y0z1omSBbqJyr68qfy3axKo0bv2g7FD4
         kaWw==
X-Forwarded-Encrypted: i=1; AJvYcCXsJO404o/m5hC+7RChnx/vPmW0CNCC6dnYzkM5VGKMMnVqeW7Hn3evw/HUwEBOqZSxXMSbfAQdsQ4YMiggNQhk1rIvIfWkXX23ug==
X-Gm-Message-State: AOJu0YwwFrL8cYvSCrOtTmQ+g9dkUfX0Buv93KeCoDhxREB9EmkEx+yz
	w7bE7cNE9eYp4YPhDDtoohpYhTFrMd7st/lbj4+saGgFzfPeViM1LV21XlYTIcRPNHkxyG07rLd
	v+T6WyKskpREl+SX9IIUlG/sNaeUVXkpmlqoU
X-Google-Smtp-Source: AGHT+IHv6JffsEzPnx5KbInGZZ0OL1jobKmTWbbhcnG9zLMw35NFD69tvdQCf9596q687XkaokyV8L2kfkQddNDCMI0=
X-Received: by 2002:a25:ef46:0:b0:dc7:4067:9f85 with SMTP id
 w6-20020a25ef46000000b00dc740679f85mr12942760ybm.58.1712121130607; Tue, 02
 Apr 2024 22:12:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402075142.196265-1-wangkefeng.wang@huawei.com> <20240402075142.196265-2-wangkefeng.wang@huawei.com>
In-Reply-To: <20240402075142.196265-2-wangkefeng.wang@huawei.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 2 Apr 2024 22:11:57 -0700
Message-ID: <CAJuCfpHkqx7yWgN0yXVqtThrNCV07=9AdhTtc5mi=skMXmZRKg@mail.gmail.com>
Subject: Re: [PATCH 1/7] arm64: mm: cleanup __do_page_fault()
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
> The __do_page_fault() only check vma->flags and call handle_mm_fault(),
> and only called by do_page_fault(), let's squash it into do_page_fault()
> to cleanup code.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  arch/arm64/mm/fault.c | 27 +++++++--------------------
>  1 file changed, 7 insertions(+), 20 deletions(-)
>
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 8251e2fea9c7..9bb9f395351a 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -486,25 +486,6 @@ static void do_bad_area(unsigned long far, unsigned =
long esr,
>         }
>  }
>
> -#define VM_FAULT_BADMAP                ((__force vm_fault_t)0x010000)
> -#define VM_FAULT_BADACCESS     ((__force vm_fault_t)0x020000)
> -
> -static vm_fault_t __do_page_fault(struct mm_struct *mm,
> -                                 struct vm_area_struct *vma, unsigned lo=
ng addr,
> -                                 unsigned int mm_flags, unsigned long vm=
_flags,
> -                                 struct pt_regs *regs)
> -{
> -       /*
> -        * Ok, we have a good vm_area for this memory access, so we can h=
andle
> -        * it.
> -        * Check that the permissions on the VMA allow for the fault whic=
h
> -        * occurred.
> -        */
> -       if (!(vma->vm_flags & vm_flags))
> -               return VM_FAULT_BADACCESS;
> -       return handle_mm_fault(vma, addr, mm_flags, regs);
> -}
> -
>  static bool is_el0_instruction_abort(unsigned long esr)
>  {
>         return ESR_ELx_EC(esr) =3D=3D ESR_ELx_EC_IABT_LOW;
> @@ -519,6 +500,9 @@ static bool is_write_abort(unsigned long esr)
>         return (esr & ESR_ELx_WNR) && !(esr & ESR_ELx_CM);
>  }
>
> +#define VM_FAULT_BADMAP                ((__force vm_fault_t)0x010000)
> +#define VM_FAULT_BADACCESS     ((__force vm_fault_t)0x020000)
> +
>  static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>                                    struct pt_regs *regs)
>  {
> @@ -617,7 +601,10 @@ static int __kprobes do_page_fault(unsigned long far=
, unsigned long esr,
>                 goto done;
>         }
>
> -       fault =3D __do_page_fault(mm, vma, addr, mm_flags, vm_flags, regs=
);
> +       if (!(vma->vm_flags & vm_flags))
> +               fault =3D VM_FAULT_BADACCESS;
> +       else
> +               fault =3D handle_mm_fault(vma, addr, mm_flags, regs);
>
>         /* Quick path to respond to signals */
>         if (fault_signal_pending(fault, regs)) {
> --
> 2.27.0
>
