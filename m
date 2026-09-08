Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4466525A95;
	Tue,  8 Sep 2026 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788858607; cv=none; b=QlIe3qh0rVgjePHA8Anu9iQu8qL8CCR3KoSmdsakjNHEOke4nVvxAYUCuzaB3/yoe29iYDrFSXZOiqQG0ymvo/JrkKLR/JxPSPkjP8eqp+kHa6Esl96vGZNYsJKh8ARQNFlWTK1hUywdiDMqKs+pfge2l2glW0nZagArqFLG1M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788858607; c=relaxed/simple;
	bh=qWOLiaR9p+P3dmHLSiKcOAVXc67z3slo0DunECLdxgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X7EZ82ZrY8ys+4bxLk/EPnQDHOazbJaQO9kkiWNXP23QWE8xtzVqdlh6UebKYLRN6RVhlD7CJt1frOkq1s5vMaSnrVSO97XTVYb4SLamsi0EmyOjczjVcHPTG4BtaQnH3u6Nbv732T84yrzWceDe6MLYcCGYntG6cQPO11PBT9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAE45L0T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAE45L0T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569471F00A3A;
	Tue,  8 Sep 2026 09:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788858606;
	bh=R0gSNJNsFiBELJzc2W3yE5oEemx5pk46RuJIr17mKUU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DAE45L0Ti7ZzN2J9EggKEpXt9EOFC/xe7EhCLBEAgKZ1EKM0gpJTm6lUAH9Rv1Y/l
	 Qb9gt8wqAJzrDQsE15lcnh+2LUSKHF7Y85tsfXTkApAmKRChoYKRr7LNH1NO5zCDxA
	 DgSV71bDNblo942RePIiEaOET6DD2BAm6jQXNwGXYyYXCVrrPfTDwooEAWl2+nKYnh
	 ROImd7jwopGGxZDYzhcgEHbseuZcsu9rqsTTi0oEx18R978jIBC68KJY6GiEvY9ucn
	 ZPViZj8X62xbMqmZxsQcKY9LdenN66zHgBKx4TLNgSPHoQy5QHpClKrY1uem3vgjH+
	 BNFhyDw3+tpqw==
Message-ID: <41c824f9-aa04-49a4-9d0a-9ffba7b014b4@kernel.org>
Date: Tue, 8 Sep 2026 11:09:48 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/24] tools headers UAPI: Sync ELF headers with the
 kernel sources
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Andy Lutomirski <luto@kernel.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Kees Cook <kees@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Nicolas Schier <nsc@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, linux-mm@kvack.org, linux-um@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 loongarch@lists.linux.dev, linux-s390@vger.kernel.org,
 linux-mips@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Jan Stancek <jstancek@redhat.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-11-3a93791af1cf@linutronix.de>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260908-vdso-absolute-reloc-v5-11-3a93791af1cf@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/09/2026 à 08:33, Thomas Weißschuh a écrit :
> Pick up changes from the UAPI ELF header files.
> This picks up general changes to elf.h, elf-em.h which was forgotten
> previously and the new elf-r.h.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> 
> ---
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>   tools/include/uapi/linux/elf-em.h |  71 ++++
>   tools/include/uapi/linux/elf-r.h  | 696 ++++++++++++++++++++++++++++++++++++++
>   tools/include/uapi/linux/elf.h    | 112 +++++-
>   3 files changed, 868 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/include/uapi/linux/elf-em.h b/tools/include/uapi/linux/elf-em.h
> new file mode 100644
> index 000000000000..ef38c2bc5ab7
> --- /dev/null
> +++ b/tools/include/uapi/linux/elf-em.h
> @@ -0,0 +1,71 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _LINUX_ELF_EM_H
> +#define _LINUX_ELF_EM_H
> +
> +/* These constants define the various ELF target machines */
> +#define EM_NONE		0
> +#define EM_M32		1
> +#define EM_SPARC	2
> +#define EM_386		3
> +#define EM_68K		4
> +#define EM_88K		5
> +#define EM_486		6	/* Perhaps disused */
> +#define EM_860		7

Add a comment that it is /* Intel 80860 */ to avoid confusion with 
powerpc 860

> +#define EM_MIPS		8	/* MIPS R3000 (officially, big-endian only) */
> +				/* Next two are historical and binaries and
> +				   modules of these types will be rejected by
> +				   Linux.  */
> +#define EM_MIPS_RS3_LE	10	/* MIPS R3000 little-endian */
> +#define EM_MIPS_RS4_BE	10	/* MIPS R4000 big-endian */
> +
