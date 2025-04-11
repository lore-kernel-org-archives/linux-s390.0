Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AB62853F6;
	Fri, 11 Apr 2025 07:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744355793; cv=none; b=ZM4UCSv4ACmExA2MM3I0A8eTsX0O4ywQ1sbwwAEDY5Ek4qcbVh13+5aV6BJWW5kep2SOcv2KC9qI6QKSspQs/5kt8KHWrpJIaKW2QBaQWBvAy+AEz2+l9KoWPqKyPP1s2hoDWd7B9VGUVFdWurACdC2I/4lKwCaS9ho0Uuv2uoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744355793; c=relaxed/simple;
	bh=zua8Zt9PCF9PeIPdm0Sm86CS+6Yzk4xhdcr+ZvilYoY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=XWtZYAwSBNGyaV1b6+R0MZgJI5GfS8YEpqrR00IqdwzBZil0X0wg78F1iYOFa3qh7yRUnKcYSMCviugtzky5oA6CqLNy9ZHGuh7qo1jy5Kx54ypX/OrqUheV/R9fapKPGa0tlEHPWoUj+2BmoRJxmrhi7wa7FigPEXLBhtdLHns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3Ahmj5w; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3Ahmj5w"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-224100e9a5cso18389825ad.2;
        Fri, 11 Apr 2025 00:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744355791; x=1744960591; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AZYV1raCKCE7T+GJKC63E8g42JVSDuGR93rMhn9HOQ=;
        b=R3Ahmj5w3N7gdLG7N+JtTivHGs5/cDS/dsdQhSzA+vN2DCHskiC4MTCc60IhlCojbq
         0nQp4BMHn3vSDqv9tfLHw844HGO16RwS1/x72intxtRREJ7P3pLsej2z8asXhwwxXSs6
         SLNusH39T5l+biiPu/I50s1cU833tbezkeYHAhBVdKY/pzCkxU81HzFuCcX5Iu66h9Zz
         c8QZQbRTRJ+eNybiTJ7Ae48HbUFNxBVWFiBBtlTUOkue8sRz+L0u5BiuNMmOyFl5wCrp
         ZbWH0Wo6ZOKbCOHK8c0ZpfdvY5ZqwiJk5CwsTfminACXmfk+s2WZvTDyPytvb2RuXHjZ
         +DRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744355791; x=1744960591;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8AZYV1raCKCE7T+GJKC63E8g42JVSDuGR93rMhn9HOQ=;
        b=EDM9nhNy0x8W93oOMjYFlRUPv+bZORPdBP26o7TZevdCF6z4jKHOb5WBz2ixXYE5kw
         1VXCKfRL37t+eNEuGjl6Rk1ddXZkBocE+b3z+ZuFN2wbSvqILERlsLFicWfYZzH9H3ol
         iV+IZf+txfPZQGSUYtjm3SalEL/pV92gyBxmMsbP3qTs3czBL8a4w4WPHhvUgJTao1mo
         DQ10ZBqWQjQ4MpDsVoNZ2fSHSAT3Z08H/PbvUwfph0Pg4lKns5dM5Uqfjd+X7jznggqR
         GeVxCREGQ35KNXPlhXv7BkqWVDsrajFqn00PBDM+jfsJjRYm0At5gRxDuKt2Onh/Q/Bd
         +pyg==
X-Forwarded-Encrypted: i=1; AJvYcCU2CLIHRSYjEGmlXbeWyMiwOEUr3Xyxhw6KBhj/xGT+reGYwlieyvJa44pAXYeZwpuRDCg5y4ElLzbZmA==@vger.kernel.org, AJvYcCVwYTw4qY1I4lFJM/wUMG+iGOEft7RkkeuOMbxPtZYX66RcM584YrjHl4ZGfiZgaCpgIWLaQMPdK2WY/g==@vger.kernel.org, AJvYcCWqniOLUOZdTtmYVJG2gzUWiShKl/zKiUHgLqLb/Ze64KZYru1euPa+s7D2CJASxhMYq87wEG6XkS+QDSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaoXIngwLdV+vz5r4aYkW2+NHAqApYJp7ZpxkBCO1TkVpCpC5b
	H3zIbEv52KXfn8aUMfk4gqJY0Sn6Ju5t+sGneaDURYE+7tXlHaxf
X-Gm-Gg: ASbGncuxzf5HH5EFPKXh/QbTvJFOuAOC39CRiPpNz8CuwEm1Xp0h8VehhyIZZ7UIkMK
	mwmyhFoKiWd5BaEgElzhzs9zRua6D0QetZurSmqXZ/lLntH+svux0Le1cSo6eXZGSX62AJK3G1p
	2BwoIyagt0UTHORKp1Fd7qHK/NUmb11KKzGMm6tO7CzcYx8quTLX6n4fLb6fS9IEtE8OYaMPjYg
	BjumjnisRMQ3ikXUew3a25+GsoD+opAFj7q5ZJ9wlhTtPKo/2vIQWTZkJrHX3pyD9Hl/j2qD3C1
	N6UYkcQauqrc4T0VqWxG+8OufjcyqIi/Sg==
X-Google-Smtp-Source: AGHT+IHEcvyi3TC9JEHNBrBd62VdoZ1tkH8a7fjLbKQXjCafKk3/popDo8PXG6WTmR/MWpJCm32MMg==
X-Received: by 2002:a17:903:1447:b0:223:5c33:56a2 with SMTP id d9443c01a7336-22bea4bd57fmr30624525ad.28.1744355791439;
        Fri, 11 Apr 2025 00:16:31 -0700 (PDT)
Received: from localhost ([220.253.99.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb5047sm42114385ad.170.2025.04.11.00.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 00:16:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Apr 2025 17:16:24 +1000
Message-Id: <D93MIOI9YLAD.1WDMNT59MMEM2@gmail.com>
Cc: "Hugh Dickins" <hughd@google.com>, "Guenter Roeck" <linux@roeck-us.net>,
 "Juergen Gross" <jgross@suse.com>, "Jeremy Fitzhardinge" <jeremy@goop.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <kasan-dev@googlegroups.com>, <sparclinux@vger.kernel.org>,
 <xen-devel@lists.xenproject.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v1 4/4] mm: Allow detection of wrong
 arch_enter_lazy_mmu_mode() context
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Andrey Ryabinin" <ryabinin.a.a@gmail.com>
X-Mailer: aerc 0.19.0
References: <cover.1744037648.git.agordeev@linux.ibm.com>
 <5204eaec309f454efcb5a799c9e0ed9da1dff971.1744037648.git.agordeev@linux.ibm.com>
In-Reply-To: <5204eaec309f454efcb5a799c9e0ed9da1dff971.1744037648.git.agordeev@linux.ibm.com>

On Tue Apr 8, 2025 at 1:11 AM AEST, Alexander Gordeev wrote:
> The lazy MMU batching may be only be entered and left under the
> protection of the page table locks for all page tables which may
> be modified. Yet, there were cases arch_enter_lazy_mmu_mode()
> was called without the locks taken, e.g. commit b9ef323ea168
> ("powerpc/64s: Disable preemption in hash lazy mmu mode").
>
> Make default arch_enter|leave|flush_lazy_mmu_mode() callbacks
> complain at least in case the preemption is enabled to detect
> wrong contexts.
>
> Most platforms do not implement the callbacks, so to aovid a
> performance impact allow the complaint when CONFIG_DEBUG_VM
> option is enabled only.
>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

This is a good debugging feature independent of how the fix
is done. I would just warn once, since it's not a bug for
the arch and could fire frequently if it fires at all.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  include/linux/pgtable.h | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index e2b705c14945..959590bb66da 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -232,9 +232,18 @@ static inline int pmd_dirty(pmd_t pmd)
>   * and the mode cannot be used in interrupt context.
>   */
>  #ifndef __HAVE_ARCH_ENTER_LAZY_MMU_MODE
> -#define arch_enter_lazy_mmu_mode()	do {} while (0)
> -#define arch_leave_lazy_mmu_mode()	do {} while (0)
> -#define arch_flush_lazy_mmu_mode()	do {} while (0)
> +static inline void arch_enter_lazy_mmu_mode(void)
> +{
> +	VM_WARN_ON(preemptible());
> +}
> +static inline void arch_leave_lazy_mmu_mode(void)
> +{
> +	VM_WARN_ON(preemptible());
> +}
> +static inline void arch_flush_lazy_mmu_mode(void)
> +{
> +	VM_WARN_ON(preemptible());
> +}
>  #endif
> =20
>  #ifndef pte_batch_hint

