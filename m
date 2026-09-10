Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FBA3BED18
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 06:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789021837; cv=none; b=ECzqCwh1mLjCJKQENuUGAX3wD6+ZOvxHaWCq4zjaaAfLNKhB6MQrwJtKcWLEbhX/iTapkLW3SlW73nKgnSzokm9Cmr8kyDjyZCk65XTdycijNVqAQGMg0n0SPRdr1O9o37PG+l1fhaTrlv6CT03XwMfck9eNLvwjxDZxrlqu7Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789021837; c=relaxed/simple;
	bh=EUuCydnRUGYzSeRu58rjiYUztHHlJmW9V2Knv0e985o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkEzshtP+QkQH5EuJrNPX12IZS7LjVEg9NNOxIOz7ElLC1tO0UHI5aIqell1TTtNC5lPPxOXRl1SzfKoLCiYOr5+PQKfxu0nAdLP/dgIjk/aqUmPpKkz5nnf3PFPOf/mLVfBu4nhuKFxh/xeFPec+UUUp2MFqF1+B4tMkMxIsuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDReZqNc; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDReZqNc"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b9184fa80so1178656a91.2
        for <linux-s390@vger.kernel.org>; Wed, 09 Sep 2026 23:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789021833; x=1789626633; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+D6cJ4vp1LctESLLAIUDonAYYPlamTo1qtNnAwvsz4c=;
        b=iDReZqNcx0REF0wyFCtAAUxiMoPC/7LtPHYWfQQ+f/qRLod0DZvfijU8fkRllV7NMd
         a7q0AZQAIHufx5QyUdyEaiBlrk+09KEtmGwXy+nu6h6b1P47wxrAZHRfQctUrhJlpprJ
         cOXVp6O59O6XhJZERx0hAhOkkcXwaE2wxWwXLDGwm3qmwbgxe9cPJcUlg8REZbC8L1ZE
         61GjYxlIAl7ezyYpfUurOchRoW/m0Ad+rQcfNL9djPo8xHjgymXAzTNOfPuK0d3mheXX
         pMa1t15R6WYqwIpy6Vohc+j5gbwVrVA76hyJIIBHPVZg/ocxGnwYeXVjJVxSa2g+3l95
         iE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789021833; x=1789626633;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+D6cJ4vp1LctESLLAIUDonAYYPlamTo1qtNnAwvsz4c=;
        b=G1BO9S2oYCkb6TBPpVa4+47DOcAVSUkCUbS4r2CwQgPaAGdMxRsna0co1R9oeohKAr
         sIpfI7kMQqZIkk4/c03sX0O9I4E699Z+qrKHxk3omOYMoxldc8oOwSn3k0nxFavk7iiX
         lrASznQM1sGFsIayHc7LPNajHwcXOOSZ+EE+BPvauOUb34Q2R7PgoEVX658U/a+Uoi7I
         msTzRDTkpZKbittr1PKMeLrD37i0OQbM8a3iviGTk1iorhAZ5Hnwq/9sUFSS4iHYqQJk
         PjJFqdjLGXVXKwanYxP9pJo3bxb4g/yXvb9JVmvpBx4KkDkbrNAA7OmcbbHKPh+LOHWL
         yvZw==
X-Forwarded-Encrypted: i=1; AKwUvBz+Bn3f+avtHtQQv8piXL13DIoqQUPg/lgJdxvDDyLmoll2NBsD1N9i1/digshgLK2z81Y+y9gGxiDq@vger.kernel.org
X-Gm-Message-State: AFuF++mm75H+NAiU6yRzMEIfG6AHc96wLUBWLmCW8NvRb1Y531f9Gk0c
	00Z9kY8BHVKaIWsy9lv+yVMMmsTLlo68OuBfWdkdeZWQjRWK/msF3Z/J
X-Gm-Gg: AYBFou3p4TcusHX5dwQ1CBtwAUo5EMAMfJoEAkGzN5Jt7rkF8jLijtq7bqmwBZk0cC3
	LbaIfbLH/AghCo6ZFE844bjBPw6MImYcy/J1xRsRMiZlZzliKAiwbUEAlYie2vbVcll9jemIC3e
	mC0bCGC1V6J8Zd77WsYbGIBOC7i5SzJXtPxgQczwCcb8vHddZLncBFQp1vNom2zhEOIv7408dG8
	EFpbJhp+xtIHfN8RK8yhKhuHXI5bmG6yt8GcD2LaZRA1ZZrFx3vMoHi2+eMTu2PQDb5Wte2vsOa
	amBoOCAWB8cB4YOrN6OB3jHDK2quC55o2gkWzoNOywOfQu60U3FcngopwNtAY1cII0rDRuy2TaH
	61Pt7Ztmm3uEbCeC4ok/9GSDuy5nMXSI/kkgnrYPNFoQ3iPYjKkr5iF2ddbCFXviLDahT/nnJwE
	2HM60cGHynSLlIJYXfDKiWTJr3mwkkvcQzk3lCPWifSZAge8/LG6dQcYOOl3wT+soD9ozaAD8Ed
	RE8hd7NeXBsACuEugELgNPlAzOoaQi0A245YUqnMpA=
X-Received: by 2002:a17:90a:d44b:b0:398:d93a:b343 with SMTP id 98e67ed59e1d1-39d709e7326mr9258034a91.3.1789021832765;
        Wed, 09 Sep 2026 23:30:32 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39bae7ecc09sm2865475a91.1.2026.09.09.23.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:30:32 -0700 (PDT)
Date: Thu, 10 Sep 2026 12:00:14 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Andy Lutomirski <luto@kernel.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Christophe Leroy <chleroy@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Nicolas Schier <nsc@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, linux-mm@kvack.org, 
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, linux-s390@vger.kernel.org, 
	linux-mips@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Jan Stancek <jstancek@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v5 05/24] powerpc/elf: Move relocation constants to UAPI
Message-ID: <aqJOZaVh8DHZKoc6@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-5-3a93791af1cf@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260908-vdso-absolute-reloc-v5-5-3a93791af1cf@linutronix.de>

On Tue, Sep 08, 2026 at 08:33:39AM +0200, Thomas Weiﬂschuh wrote:
> These constants are useful for cross-platform userspace, for example to
> process ELF files during kernel cross-compilation.
> 
> Move them from the kernel-private architecture-specific header to the UAPI.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
>  arch/powerpc/include/uapi/asm/elf.h | 201 ------------------------------------
>  include/uapi/linux/elf-r.h          | 201 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 201 insertions(+), 201 deletions(-)
> 
> diff --git a/arch/powerpc/include/uapi/asm/elf.h b/arch/powerpc/include/uapi/asm/elf.h
> index a5377f494fa3..aba921b8249a 100644
> --- a/arch/powerpc/include/uapi/asm/elf.h
> +++ b/arch/powerpc/include/uapi/asm/elf.h
> @@ -17,78 +17,6 @@
>  #include <asm/cputable.h>
>  #include <asm/auxvec.h>
>  
> -/* PowerPC relocations defined by the ABIs */
> -#define R_PPC_NONE		0
> -#define R_PPC_ADDR32		1	/* 32bit absolute address */
> -#define R_PPC_ADDR24		2	/* 26bit address, 2 bits ignored.  */
> -#define R_PPC_ADDR16		3	/* 16bit absolute address */
> -#define R_PPC_ADDR16_LO		4	/* lower 16bit of absolute address */
> -#define R_PPC_ADDR16_HI		5	/* high 16bit of absolute address */
> -#define R_PPC_ADDR16_HA		6	/* adjusted high 16bit */
> -#define R_PPC_ADDR14		7	/* 16bit address, 2 bits ignored */
> -#define R_PPC_ADDR14_BRTAKEN	8
> -#define R_PPC_ADDR14_BRNTAKEN	9
> -#define R_PPC_REL24		10	/* PC relative 26 bit */
> -#define R_PPC_REL14		11	/* PC relative 16 bit */
> -#define R_PPC_REL14_BRTAKEN	12
> -#define R_PPC_REL14_BRNTAKEN	13
> -#define R_PPC_GOT16		14
> -#define R_PPC_GOT16_LO		15
> -#define R_PPC_GOT16_HI		16
> -#define R_PPC_GOT16_HA		17
> -#define R_PPC_PLTREL24		18
> -#define R_PPC_COPY		19
> -#define R_PPC_GLOB_DAT		20
> -#define R_PPC_JMP_SLOT		21
> -#define R_PPC_RELATIVE		22
> -#define R_PPC_LOCAL24PC		23
> -#define R_PPC_UADDR32		24
> -#define R_PPC_UADDR16		25
> -#define R_PPC_REL32		26
> -#define R_PPC_PLT32		27
> -#define R_PPC_PLTREL32		28
> -#define R_PPC_PLT16_LO		29
> -#define R_PPC_PLT16_HI		30
> -#define R_PPC_PLT16_HA		31
> -#define R_PPC_SDAREL16		32
> -#define R_PPC_SECTOFF		33
> -#define R_PPC_SECTOFF_LO	34
> -#define R_PPC_SECTOFF_HI	35
> -#define R_PPC_SECTOFF_HA	36
> -
> -/* PowerPC relocations defined for the TLS access ABI.  */
> -#define R_PPC_TLS		67 /* none	(sym+add)@tls */
> -#define R_PPC_DTPMOD32		68 /* word32	(sym+add)@dtpmod */
> -#define R_PPC_TPREL16		69 /* half16*	(sym+add)@tprel */
> -#define R_PPC_TPREL16_LO	70 /* half16	(sym+add)@tprel@l */
> -#define R_PPC_TPREL16_HI	71 /* half16	(sym+add)@tprel@h */
> -#define R_PPC_TPREL16_HA	72 /* half16	(sym+add)@tprel@ha */
> -#define R_PPC_TPREL32		73 /* word32	(sym+add)@tprel */
> -#define R_PPC_DTPREL16		74 /* half16*	(sym+add)@dtprel */
> -#define R_PPC_DTPREL16_LO	75 /* half16	(sym+add)@dtprel@l */
> -#define R_PPC_DTPREL16_HI	76 /* half16	(sym+add)@dtprel@h */
> -#define R_PPC_DTPREL16_HA	77 /* half16	(sym+add)@dtprel@ha */
> -#define R_PPC_DTPREL32		78 /* word32	(sym+add)@dtprel */
> -#define R_PPC_GOT_TLSGD16	79 /* half16*	(sym+add)@got@tlsgd */
> -#define R_PPC_GOT_TLSGD16_LO	80 /* half16	(sym+add)@got@tlsgd@l */
> -#define R_PPC_GOT_TLSGD16_HI	81 /* half16	(sym+add)@got@tlsgd@h */
> -#define R_PPC_GOT_TLSGD16_HA	82 /* half16	(sym+add)@got@tlsgd@ha */
> -#define R_PPC_GOT_TLSLD16	83 /* half16*	(sym+add)@got@tlsld */
> -#define R_PPC_GOT_TLSLD16_LO	84 /* half16	(sym+add)@got@tlsld@l */
> -#define R_PPC_GOT_TLSLD16_HI	85 /* half16	(sym+add)@got@tlsld@h */
> -#define R_PPC_GOT_TLSLD16_HA	86 /* half16	(sym+add)@got@tlsld@ha */
> -#define R_PPC_GOT_TPREL16	87 /* half16*	(sym+add)@got@tprel */
> -#define R_PPC_GOT_TPREL16_LO	88 /* half16	(sym+add)@got@tprel@l */
> -#define R_PPC_GOT_TPREL16_HI	89 /* half16	(sym+add)@got@tprel@h */
> -#define R_PPC_GOT_TPREL16_HA	90 /* half16	(sym+add)@got@tprel@ha */
> -#define R_PPC_GOT_DTPREL16	91 /* half16*	(sym+add)@got@dtprel */
> -#define R_PPC_GOT_DTPREL16_LO	92 /* half16*	(sym+add)@got@dtprel@l */
> -#define R_PPC_GOT_DTPREL16_HI	93 /* half16*	(sym+add)@got@dtprel@h */
> -#define R_PPC_GOT_DTPREL16_HA	94 /* half16*	(sym+add)@got@dtprel@ha */
> -
> -/* keep this the last entry. */
> -#define R_PPC_NUM		95
> -
>  
>  #define ELF_NGREG	48	/* includes nip, msr, lr, etc. */
>  #define ELF_NFPREG	33	/* includes fpscr */
> @@ -166,133 +94,4 @@ typedef elf_vrreg_t elf_vrregset_t32[ELF_NVRREG32];
>  typedef elf_fpreg_t elf_vsrreghalf_t32[ELF_NVSRHALFREG];
>  #endif
>  
> -/* PowerPC64 relocations defined by the ABIs */
> -#define R_PPC64_NONE    R_PPC_NONE
> -#define R_PPC64_ADDR32  R_PPC_ADDR32  /* 32bit absolute address.  */
> -#define R_PPC64_ADDR24  R_PPC_ADDR24  /* 26bit address, word aligned.  */
> -#define R_PPC64_ADDR16  R_PPC_ADDR16  /* 16bit absolute address. */
> -#define R_PPC64_ADDR16_LO R_PPC_ADDR16_LO /* lower 16bits of abs. address.  */
> -#define R_PPC64_ADDR16_HI R_PPC_ADDR16_HI /* high 16bits of abs. address. */
> -#define R_PPC64_ADDR16_HA R_PPC_ADDR16_HA /* adjusted high 16bits.  */
> -#define R_PPC64_ADDR14 R_PPC_ADDR14   /* 16bit address, word aligned.  */
> -#define R_PPC64_ADDR14_BRTAKEN  R_PPC_ADDR14_BRTAKEN
> -#define R_PPC64_ADDR14_BRNTAKEN R_PPC_ADDR14_BRNTAKEN
> -#define R_PPC64_REL24   R_PPC_REL24 /* PC relative 26 bit, word aligned.  */
> -#define R_PPC64_REL14   R_PPC_REL14 /* PC relative 16 bit. */
> -#define R_PPC64_REL14_BRTAKEN   R_PPC_REL14_BRTAKEN
> -#define R_PPC64_REL14_BRNTAKEN  R_PPC_REL14_BRNTAKEN
> -#define R_PPC64_GOT16     R_PPC_GOT16
> -#define R_PPC64_GOT16_LO  R_PPC_GOT16_LO
> -#define R_PPC64_GOT16_HI  R_PPC_GOT16_HI
> -#define R_PPC64_GOT16_HA  R_PPC_GOT16_HA
> -
> -#define R_PPC64_COPY      R_PPC_COPY
> -#define R_PPC64_GLOB_DAT  R_PPC_GLOB_DAT
> -#define R_PPC64_JMP_SLOT  R_PPC_JMP_SLOT
> -#define R_PPC64_RELATIVE  R_PPC_RELATIVE
> -
> -#define R_PPC64_UADDR32   R_PPC_UADDR32
> -#define R_PPC64_UADDR16   R_PPC_UADDR16
> -#define R_PPC64_REL32     R_PPC_REL32
> -#define R_PPC64_PLT32     R_PPC_PLT32
> -#define R_PPC64_PLTREL32  R_PPC_PLTREL32
> -#define R_PPC64_PLT16_LO  R_PPC_PLT16_LO
> -#define R_PPC64_PLT16_HI  R_PPC_PLT16_HI
> -#define R_PPC64_PLT16_HA  R_PPC_PLT16_HA
> -
> -#define R_PPC64_SECTOFF     R_PPC_SECTOFF
> -#define R_PPC64_SECTOFF_LO  R_PPC_SECTOFF_LO
> -#define R_PPC64_SECTOFF_HI  R_PPC_SECTOFF_HI
> -#define R_PPC64_SECTOFF_HA  R_PPC_SECTOFF_HA
> -#define R_PPC64_ADDR30          37  /* word30 (S + A - P) >> 2.  */
> -#define R_PPC64_ADDR64          38  /* doubleword64 S + A.  */
> -#define R_PPC64_ADDR16_HIGHER   39  /* half16 #higher(S + A).  */
> -#define R_PPC64_ADDR16_HIGHERA  40  /* half16 #highera(S + A).  */
> -#define R_PPC64_ADDR16_HIGHEST  41  /* half16 #highest(S + A).  */
> -#define R_PPC64_ADDR16_HIGHESTA 42  /* half16 #highesta(S + A). */
> -#define R_PPC64_UADDR64     43  /* doubleword64 S + A.  */
> -#define R_PPC64_REL64       44  /* doubleword64 S + A - P.  */
> -#define R_PPC64_PLT64       45  /* doubleword64 L + A.  */
> -#define R_PPC64_PLTREL64    46  /* doubleword64 L + A - P.  */
> -#define R_PPC64_TOC16       47  /* half16* S + A - .TOC.  */
> -#define R_PPC64_TOC16_LO    48  /* half16 #lo(S + A - .TOC.).  */
> -#define R_PPC64_TOC16_HI    49  /* half16 #hi(S + A - .TOC.).  */
> -#define R_PPC64_TOC16_HA    50  /* half16 #ha(S + A - .TOC.).  */
> -#define R_PPC64_TOC         51  /* doubleword64 .TOC. */
> -#define R_PPC64_PLTGOT16    52  /* half16* M + A.  */
> -#define R_PPC64_PLTGOT16_LO 53  /* half16 #lo(M + A).  */
> -#define R_PPC64_PLTGOT16_HI 54  /* half16 #hi(M + A).  */
> -#define R_PPC64_PLTGOT16_HA 55  /* half16 #ha(M + A).  */
> -
> -#define R_PPC64_ADDR16_DS      56 /* half16ds* (S + A) >> 2.  */
> -#define R_PPC64_ADDR16_LO_DS   57 /* half16ds  #lo(S + A) >> 2.  */
> -#define R_PPC64_GOT16_DS       58 /* half16ds* (G + A) >> 2.  */
> -#define R_PPC64_GOT16_LO_DS    59 /* half16ds  #lo(G + A) >> 2.  */
> -#define R_PPC64_PLT16_LO_DS    60 /* half16ds  #lo(L + A) >> 2.  */
> -#define R_PPC64_SECTOFF_DS     61 /* half16ds* (R + A) >> 2.  */
> -#define R_PPC64_SECTOFF_LO_DS  62 /* half16ds  #lo(R + A) >> 2.  */
> -#define R_PPC64_TOC16_DS       63 /* half16ds* (S + A - .TOC.) >> 2.  */
> -#define R_PPC64_TOC16_LO_DS    64 /* half16ds  #lo(S + A - .TOC.) >> 2.  */
> -#define R_PPC64_PLTGOT16_DS    65 /* half16ds* (M + A) >> 2.  */
> -#define R_PPC64_PLTGOT16_LO_DS 66 /* half16ds  #lo(M + A) >> 2.  */
> -
> -/* PowerPC64 relocations defined for the TLS access ABI.  */
> -#define R_PPC64_TLS		67 /* none	(sym+add)@tls */
> -#define R_PPC64_DTPMOD64	68 /* doubleword64 (sym+add)@dtpmod */
> -#define R_PPC64_TPREL16		69 /* half16*	(sym+add)@tprel */
> -#define R_PPC64_TPREL16_LO	70 /* half16	(sym+add)@tprel@l */
> -#define R_PPC64_TPREL16_HI	71 /* half16	(sym+add)@tprel@h */
> -#define R_PPC64_TPREL16_HA	72 /* half16	(sym+add)@tprel@ha */
> -#define R_PPC64_TPREL64		73 /* doubleword64 (sym+add)@tprel */
> -#define R_PPC64_DTPREL16	74 /* half16*	(sym+add)@dtprel */
> -#define R_PPC64_DTPREL16_LO	75 /* half16	(sym+add)@dtprel@l */
> -#define R_PPC64_DTPREL16_HI	76 /* half16	(sym+add)@dtprel@h */
> -#define R_PPC64_DTPREL16_HA	77 /* half16	(sym+add)@dtprel@ha */
> -#define R_PPC64_DTPREL64	78 /* doubleword64 (sym+add)@dtprel */
> -#define R_PPC64_GOT_TLSGD16	79 /* half16*	(sym+add)@got@tlsgd */
> -#define R_PPC64_GOT_TLSGD16_LO	80 /* half16	(sym+add)@got@tlsgd@l */
> -#define R_PPC64_GOT_TLSGD16_HI	81 /* half16	(sym+add)@got@tlsgd@h */
> -#define R_PPC64_GOT_TLSGD16_HA	82 /* half16	(sym+add)@got@tlsgd@ha */
> -#define R_PPC64_GOT_TLSLD16	83 /* half16*	(sym+add)@got@tlsld */
> -#define R_PPC64_GOT_TLSLD16_LO	84 /* half16	(sym+add)@got@tlsld@l */
> -#define R_PPC64_GOT_TLSLD16_HI	85 /* half16	(sym+add)@got@tlsld@h */
> -#define R_PPC64_GOT_TLSLD16_HA	86 /* half16	(sym+add)@got@tlsld@ha */
> -#define R_PPC64_GOT_TPREL16_DS	87 /* half16ds*	(sym+add)@got@tprel */
> -#define R_PPC64_GOT_TPREL16_LO_DS 88 /* half16ds (sym+add)@got@tprel@l */
> -#define R_PPC64_GOT_TPREL16_HI	89 /* half16	(sym+add)@got@tprel@h */
> -#define R_PPC64_GOT_TPREL16_HA	90 /* half16	(sym+add)@got@tprel@ha */
> -#define R_PPC64_GOT_DTPREL16_DS	91 /* half16ds*	(sym+add)@got@dtprel */
> -#define R_PPC64_GOT_DTPREL16_LO_DS 92 /* half16ds (sym+add)@got@dtprel@l */
> -#define R_PPC64_GOT_DTPREL16_HI	93 /* half16	(sym+add)@got@dtprel@h */
> -#define R_PPC64_GOT_DTPREL16_HA	94 /* half16	(sym+add)@got@dtprel@ha */
> -#define R_PPC64_TPREL16_DS	95 /* half16ds*	(sym+add)@tprel */
> -#define R_PPC64_TPREL16_LO_DS	96 /* half16ds	(sym+add)@tprel@l */
> -#define R_PPC64_TPREL16_HIGHER	97 /* half16	(sym+add)@tprel@higher */
> -#define R_PPC64_TPREL16_HIGHERA	98 /* half16	(sym+add)@tprel@highera */
> -#define R_PPC64_TPREL16_HIGHEST	99 /* half16	(sym+add)@tprel@highest */
> -#define R_PPC64_TPREL16_HIGHESTA 100 /* half16	(sym+add)@tprel@highesta */
> -#define R_PPC64_DTPREL16_DS	101 /* half16ds* (sym+add)@dtprel */
> -#define R_PPC64_DTPREL16_LO_DS	102 /* half16ds	(sym+add)@dtprel@l */
> -#define R_PPC64_DTPREL16_HIGHER	103 /* half16	(sym+add)@dtprel@higher */
> -#define R_PPC64_DTPREL16_HIGHERA 104 /* half16	(sym+add)@dtprel@highera */
> -#define R_PPC64_DTPREL16_HIGHEST 105 /* half16	(sym+add)@dtprel@highest */
> -#define R_PPC64_DTPREL16_HIGHESTA 106 /* half16	(sym+add)@dtprel@highesta */
> -#define R_PPC64_TLSGD		107
> -#define R_PPC64_TLSLD		108
> -#define R_PPC64_TOCSAVE		109
> -
> -#define R_PPC64_REL24_NOTOC	116
> -#define R_PPC64_ENTRY		118
> -
> -#define R_PPC64_PCREL34		132
> -#define R_PPC64_GOT_PCREL34	133
> -
> -#define R_PPC64_REL16		249
> -#define R_PPC64_REL16_LO	250
> -#define R_PPC64_REL16_HI	251
> -#define R_PPC64_REL16_HA	252
> -
> -/* Keep this the last entry.  */
> -#define R_PPC64_NUM		253
> -
>  #endif /* _UAPI_ASM_POWERPC_ELF_H */
> diff --git a/include/uapi/linux/elf-r.h b/include/uapi/linux/elf-r.h
> index cf931fc05afa..0d0dfaa7c724 100644
> --- a/include/uapi/linux/elf-r.h
> +++ b/include/uapi/linux/elf-r.h
> @@ -113,4 +113,205 @@
>  
>  #define R_AARCH64_RELATIVE		1027
>  
> +/* PowerPC relocations defined by the ABIs */
> +#define R_PPC_NONE		0
> +#define R_PPC_ADDR32		1	/* 32bit absolute address */
> +#define R_PPC_ADDR24		2	/* 26bit address, 2 bits ignored.  */
> +#define R_PPC_ADDR16		3	/* 16bit absolute address */
> +#define R_PPC_ADDR16_LO		4	/* lower 16bit of absolute address */
> +#define R_PPC_ADDR16_HI		5	/* high 16bit of absolute address */
> +#define R_PPC_ADDR16_HA		6	/* adjusted high 16bit */
> +#define R_PPC_ADDR14		7	/* 16bit address, 2 bits ignored */
> +#define R_PPC_ADDR14_BRTAKEN	8
> +#define R_PPC_ADDR14_BRNTAKEN	9
> +#define R_PPC_REL24		10	/* PC relative 26 bit */
> +#define R_PPC_REL14		11	/* PC relative 16 bit */
> +#define R_PPC_REL14_BRTAKEN	12
> +#define R_PPC_REL14_BRNTAKEN	13
> +#define R_PPC_GOT16		14
> +#define R_PPC_GOT16_LO		15
> +#define R_PPC_GOT16_HI		16
> +#define R_PPC_GOT16_HA		17
> +#define R_PPC_PLTREL24		18
> +#define R_PPC_COPY		19
> +#define R_PPC_GLOB_DAT		20
> +#define R_PPC_JMP_SLOT		21
> +#define R_PPC_RELATIVE		22
> +#define R_PPC_LOCAL24PC		23
> +#define R_PPC_UADDR32		24
> +#define R_PPC_UADDR16		25
> +#define R_PPC_REL32		26
> +#define R_PPC_PLT32		27
> +#define R_PPC_PLTREL32		28
> +#define R_PPC_PLT16_LO		29
> +#define R_PPC_PLT16_HI		30
> +#define R_PPC_PLT16_HA		31
> +#define R_PPC_SDAREL16		32
> +#define R_PPC_SECTOFF		33
> +#define R_PPC_SECTOFF_LO	34
> +#define R_PPC_SECTOFF_HI	35
> +#define R_PPC_SECTOFF_HA	36
> +
> +/* PowerPC relocations defined for the TLS access ABI.  */
> +#define R_PPC_TLS		67 /* none	(sym+add)@tls */
> +#define R_PPC_DTPMOD32		68 /* word32	(sym+add)@dtpmod */
> +#define R_PPC_TPREL16		69 /* half16*	(sym+add)@tprel */
> +#define R_PPC_TPREL16_LO	70 /* half16	(sym+add)@tprel@l */
> +#define R_PPC_TPREL16_HI	71 /* half16	(sym+add)@tprel@h */
> +#define R_PPC_TPREL16_HA	72 /* half16	(sym+add)@tprel@ha */
> +#define R_PPC_TPREL32		73 /* word32	(sym+add)@tprel */
> +#define R_PPC_DTPREL16		74 /* half16*	(sym+add)@dtprel */
> +#define R_PPC_DTPREL16_LO	75 /* half16	(sym+add)@dtprel@l */
> +#define R_PPC_DTPREL16_HI	76 /* half16	(sym+add)@dtprel@h */
> +#define R_PPC_DTPREL16_HA	77 /* half16	(sym+add)@dtprel@ha */
> +#define R_PPC_DTPREL32		78 /* word32	(sym+add)@dtprel */
> +#define R_PPC_GOT_TLSGD16	79 /* half16*	(sym+add)@got@tlsgd */
> +#define R_PPC_GOT_TLSGD16_LO	80 /* half16	(sym+add)@got@tlsgd@l */
> +#define R_PPC_GOT_TLSGD16_HI	81 /* half16	(sym+add)@got@tlsgd@h */
> +#define R_PPC_GOT_TLSGD16_HA	82 /* half16	(sym+add)@got@tlsgd@ha */
> +#define R_PPC_GOT_TLSLD16	83 /* half16*	(sym+add)@got@tlsld */
> +#define R_PPC_GOT_TLSLD16_LO	84 /* half16	(sym+add)@got@tlsld@l */
> +#define R_PPC_GOT_TLSLD16_HI	85 /* half16	(sym+add)@got@tlsld@h */
> +#define R_PPC_GOT_TLSLD16_HA	86 /* half16	(sym+add)@got@tlsld@ha */
> +#define R_PPC_GOT_TPREL16	87 /* half16*	(sym+add)@got@tprel */
> +#define R_PPC_GOT_TPREL16_LO	88 /* half16	(sym+add)@got@tprel@l */
> +#define R_PPC_GOT_TPREL16_HI	89 /* half16	(sym+add)@got@tprel@h */
> +#define R_PPC_GOT_TPREL16_HA	90 /* half16	(sym+add)@got@tprel@ha */
> +#define R_PPC_GOT_DTPREL16	91 /* half16*	(sym+add)@got@dtprel */
> +#define R_PPC_GOT_DTPREL16_LO	92 /* half16*	(sym+add)@got@dtprel@l */
> +#define R_PPC_GOT_DTPREL16_HI	93 /* half16*	(sym+add)@got@dtprel@h */
> +#define R_PPC_GOT_DTPREL16_HA	94 /* half16*	(sym+add)@got@dtprel@ha */
> +
> +/* keep this the last entry. */
> +#define R_PPC_NUM		95
> +
> +/* PowerPC64 relocations defined by the ABIs */
> +#define R_PPC64_NONE    R_PPC_NONE
> +#define R_PPC64_ADDR32  R_PPC_ADDR32  /* 32bit absolute address.  */
> +#define R_PPC64_ADDR24  R_PPC_ADDR24  /* 26bit address, word aligned.  */
> +#define R_PPC64_ADDR16  R_PPC_ADDR16  /* 16bit absolute address. */
> +#define R_PPC64_ADDR16_LO R_PPC_ADDR16_LO /* lower 16bits of abs. address.  */
> +#define R_PPC64_ADDR16_HI R_PPC_ADDR16_HI /* high 16bits of abs. address. */
> +#define R_PPC64_ADDR16_HA R_PPC_ADDR16_HA /* adjusted high 16bits.  */
> +#define R_PPC64_ADDR14 R_PPC_ADDR14   /* 16bit address, word aligned.  */
> +#define R_PPC64_ADDR14_BRTAKEN  R_PPC_ADDR14_BRTAKEN
> +#define R_PPC64_ADDR14_BRNTAKEN R_PPC_ADDR14_BRNTAKEN
> +#define R_PPC64_REL24   R_PPC_REL24 /* PC relative 26 bit, word aligned.  */
> +#define R_PPC64_REL14   R_PPC_REL14 /* PC relative 16 bit. */
> +#define R_PPC64_REL14_BRTAKEN   R_PPC_REL14_BRTAKEN
> +#define R_PPC64_REL14_BRNTAKEN  R_PPC_REL14_BRNTAKEN
> +#define R_PPC64_GOT16     R_PPC_GOT16
> +#define R_PPC64_GOT16_LO  R_PPC_GOT16_LO
> +#define R_PPC64_GOT16_HI  R_PPC_GOT16_HI
> +#define R_PPC64_GOT16_HA  R_PPC_GOT16_HA
> +
> +#define R_PPC64_COPY      R_PPC_COPY
> +#define R_PPC64_GLOB_DAT  R_PPC_GLOB_DAT
> +#define R_PPC64_JMP_SLOT  R_PPC_JMP_SLOT
> +#define R_PPC64_RELATIVE  R_PPC_RELATIVE
> +
> +#define R_PPC64_UADDR32   R_PPC_UADDR32
> +#define R_PPC64_UADDR16   R_PPC_UADDR16
> +#define R_PPC64_REL32     R_PPC_REL32
> +#define R_PPC64_PLT32     R_PPC_PLT32
> +#define R_PPC64_PLTREL32  R_PPC_PLTREL32
> +#define R_PPC64_PLT16_LO  R_PPC_PLT16_LO
> +#define R_PPC64_PLT16_HI  R_PPC_PLT16_HI
> +#define R_PPC64_PLT16_HA  R_PPC_PLT16_HA
> +
> +#define R_PPC64_SECTOFF     R_PPC_SECTOFF
> +#define R_PPC64_SECTOFF_LO  R_PPC_SECTOFF_LO
> +#define R_PPC64_SECTOFF_HI  R_PPC_SECTOFF_HI
> +#define R_PPC64_SECTOFF_HA  R_PPC_SECTOFF_HA
> +#define R_PPC64_ADDR30          37  /* word30 (S + A - P) >> 2.  */
> +#define R_PPC64_ADDR64          38  /* doubleword64 S + A.  */
> +#define R_PPC64_ADDR16_HIGHER   39  /* half16 #higher(S + A).  */
> +#define R_PPC64_ADDR16_HIGHERA  40  /* half16 #highera(S + A).  */
> +#define R_PPC64_ADDR16_HIGHEST  41  /* half16 #highest(S + A).  */
> +#define R_PPC64_ADDR16_HIGHESTA 42  /* half16 #highesta(S + A). */
> +#define R_PPC64_UADDR64     43  /* doubleword64 S + A.  */
> +#define R_PPC64_REL64       44  /* doubleword64 S + A - P.  */
> +#define R_PPC64_PLT64       45  /* doubleword64 L + A.  */
> +#define R_PPC64_PLTREL64    46  /* doubleword64 L + A - P.  */
> +#define R_PPC64_TOC16       47  /* half16* S + A - .TOC.  */
> +#define R_PPC64_TOC16_LO    48  /* half16 #lo(S + A - .TOC.).  */
> +#define R_PPC64_TOC16_HI    49  /* half16 #hi(S + A - .TOC.).  */
> +#define R_PPC64_TOC16_HA    50  /* half16 #ha(S + A - .TOC.).  */
> +#define R_PPC64_TOC         51  /* doubleword64 .TOC. */
> +#define R_PPC64_PLTGOT16    52  /* half16* M + A.  */
> +#define R_PPC64_PLTGOT16_LO 53  /* half16 #lo(M + A).  */
> +#define R_PPC64_PLTGOT16_HI 54  /* half16 #hi(M + A).  */
> +#define R_PPC64_PLTGOT16_HA 55  /* half16 #ha(M + A).  */
> +
> +#define R_PPC64_ADDR16_DS      56 /* half16ds* (S + A) >> 2.  */
> +#define R_PPC64_ADDR16_LO_DS   57 /* half16ds  #lo(S + A) >> 2.  */
> +#define R_PPC64_GOT16_DS       58 /* half16ds* (G + A) >> 2.  */
> +#define R_PPC64_GOT16_LO_DS    59 /* half16ds  #lo(G + A) >> 2.  */
> +#define R_PPC64_PLT16_LO_DS    60 /* half16ds  #lo(L + A) >> 2.  */
> +#define R_PPC64_SECTOFF_DS     61 /* half16ds* (R + A) >> 2.  */
> +#define R_PPC64_SECTOFF_LO_DS  62 /* half16ds  #lo(R + A) >> 2.  */
> +#define R_PPC64_TOC16_DS       63 /* half16ds* (S + A - .TOC.) >> 2.  */
> +#define R_PPC64_TOC16_LO_DS    64 /* half16ds  #lo(S + A - .TOC.) >> 2.  */
> +#define R_PPC64_PLTGOT16_DS    65 /* half16ds* (M + A) >> 2.  */
> +#define R_PPC64_PLTGOT16_LO_DS 66 /* half16ds  #lo(M + A) >> 2.  */
> +
> +/* PowerPC64 relocations defined for the TLS access ABI.  */
> +#define R_PPC64_TLS		67 /* none	(sym+add)@tls */
> +#define R_PPC64_DTPMOD64	68 /* doubleword64 (sym+add)@dtpmod */
> +#define R_PPC64_TPREL16		69 /* half16*	(sym+add)@tprel */
> +#define R_PPC64_TPREL16_LO	70 /* half16	(sym+add)@tprel@l */
> +#define R_PPC64_TPREL16_HI	71 /* half16	(sym+add)@tprel@h */
> +#define R_PPC64_TPREL16_HA	72 /* half16	(sym+add)@tprel@ha */
> +#define R_PPC64_TPREL64		73 /* doubleword64 (sym+add)@tprel */
> +#define R_PPC64_DTPREL16	74 /* half16*	(sym+add)@dtprel */
> +#define R_PPC64_DTPREL16_LO	75 /* half16	(sym+add)@dtprel@l */
> +#define R_PPC64_DTPREL16_HI	76 /* half16	(sym+add)@dtprel@h */
> +#define R_PPC64_DTPREL16_HA	77 /* half16	(sym+add)@dtprel@ha */
> +#define R_PPC64_DTPREL64	78 /* doubleword64 (sym+add)@dtprel */
> +#define R_PPC64_GOT_TLSGD16	79 /* half16*	(sym+add)@got@tlsgd */
> +#define R_PPC64_GOT_TLSGD16_LO	80 /* half16	(sym+add)@got@tlsgd@l */
> +#define R_PPC64_GOT_TLSGD16_HI	81 /* half16	(sym+add)@got@tlsgd@h */
> +#define R_PPC64_GOT_TLSGD16_HA	82 /* half16	(sym+add)@got@tlsgd@ha */
> +#define R_PPC64_GOT_TLSLD16	83 /* half16*	(sym+add)@got@tlsld */
> +#define R_PPC64_GOT_TLSLD16_LO	84 /* half16	(sym+add)@got@tlsld@l */
> +#define R_PPC64_GOT_TLSLD16_HI	85 /* half16	(sym+add)@got@tlsld@h */
> +#define R_PPC64_GOT_TLSLD16_HA	86 /* half16	(sym+add)@got@tlsld@ha */
> +#define R_PPC64_GOT_TPREL16_DS	87 /* half16ds*	(sym+add)@got@tprel */
> +#define R_PPC64_GOT_TPREL16_LO_DS 88 /* half16ds (sym+add)@got@tprel@l */
> +#define R_PPC64_GOT_TPREL16_HI	89 /* half16	(sym+add)@got@tprel@h */
> +#define R_PPC64_GOT_TPREL16_HA	90 /* half16	(sym+add)@got@tprel@ha */
> +#define R_PPC64_GOT_DTPREL16_DS	91 /* half16ds*	(sym+add)@got@dtprel */
> +#define R_PPC64_GOT_DTPREL16_LO_DS 92 /* half16ds (sym+add)@got@dtprel@l */
> +#define R_PPC64_GOT_DTPREL16_HI	93 /* half16	(sym+add)@got@dtprel@h */
> +#define R_PPC64_GOT_DTPREL16_HA	94 /* half16	(sym+add)@got@dtprel@ha */
> +#define R_PPC64_TPREL16_DS	95 /* half16ds*	(sym+add)@tprel */
> +#define R_PPC64_TPREL16_LO_DS	96 /* half16ds	(sym+add)@tprel@l */
> +#define R_PPC64_TPREL16_HIGHER	97 /* half16	(sym+add)@tprel@higher */
> +#define R_PPC64_TPREL16_HIGHERA	98 /* half16	(sym+add)@tprel@highera */
> +#define R_PPC64_TPREL16_HIGHEST	99 /* half16	(sym+add)@tprel@highest */
> +#define R_PPC64_TPREL16_HIGHESTA 100 /* half16	(sym+add)@tprel@highesta */
> +#define R_PPC64_DTPREL16_DS	101 /* half16ds* (sym+add)@dtprel */
> +#define R_PPC64_DTPREL16_LO_DS	102 /* half16ds	(sym+add)@dtprel@l */
> +#define R_PPC64_DTPREL16_HIGHER	103 /* half16	(sym+add)@dtprel@higher */
> +#define R_PPC64_DTPREL16_HIGHERA 104 /* half16	(sym+add)@dtprel@highera */
> +#define R_PPC64_DTPREL16_HIGHEST 105 /* half16	(sym+add)@dtprel@highest */
> +#define R_PPC64_DTPREL16_HIGHESTA 106 /* half16	(sym+add)@dtprel@highesta */
> +#define R_PPC64_TLSGD		107
> +#define R_PPC64_TLSLD		108
> +#define R_PPC64_TOCSAVE		109
> +
> +#define R_PPC64_REL24_NOTOC	116
> +#define R_PPC64_ENTRY		118
> +
> +#define R_PPC64_PCREL34		132
> +#define R_PPC64_GOT_PCREL34	133
> +
> +#define R_PPC64_REL16		249
> +#define R_PPC64_REL16_LO	250
> +#define R_PPC64_REL16_HI	251
> +#define R_PPC64_REL16_HA	252
> +
> +/* Keep this the last entry.  */
> +#define R_PPC64_NUM		253
> +
>  #endif /* _UAPI_LINUX_ELF_R_H */
> 
> -- 
> 2.55.0
> 

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
