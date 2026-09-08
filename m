Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665424B0CB4;
	Tue,  8 Sep 2026 08:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857852; cv=none; b=c3ydSHzKeomlRzuuRRnWlfK0lrJlhvvIcDMw4JURMraLK0BUuVXhDszxCxl+E6SpiR2kXYXhkvQQ2CIBnd8nQ7THhTATXCaLuYYurw5LgQo4no1DnIpNZZOxoScH84e+CUERa3eeKJ6NOI/KG8Fucerffp25ZZru47rep2v1RDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857852; c=relaxed/simple;
	bh=AbUW8cML5zO57Sb8jF0d98D12k6Bi/vuzBggBha5Vx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QwKIfP8FXjofDDlxxgz6KHBsmuJCnncoMgvjP9NN1b/SlC+bIYZ2TNIUIrqiciH+f7e0EEvRx+SDLagQCAehn3sl+jD82jWzOCAWdXONyvtJEUmAAgemydlk9EEgQJnT2BhLn/YQkGDolRSf2jUXLyBdKTJwAf3wN/PcU4cT+VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMlWBWtH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMlWBWtH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D6F1F00A3A;
	Tue,  8 Sep 2026 08:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788857835;
	bh=BOR2t3VtcjszZ4q3H4RF8INxqX7I/2OnFWmBk3yYh2U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RMlWBWtHsUr314SSes2RbgrXEdhowxsDExyywV6MWPiyRlQ2MiRcnzJrKxwP2Uq5y
	 FxFi3d8oyrDb4Ns+a5YQol0nE9UlpMARb5Srs2FLa3c8UgJq9bIRFnwje3hSYKfvsy
	 4lejU8BQqLNJPlkLkj5fUKy1asSopqBNr8Z/GdXh3YL25ZL/xotJOBdRT8X+1frbzz
	 5wc8MC7jxG0TFbXkBqhY75SKcdrJ0GvpwyMgIKA6vQKX0ndFDZCBRqE2+uKYcWsIZK
	 O423o/0XnOMDsJENmzRb5yAhovNWoPRl28a6i0Ifx5k/RVsnRdBM2JH4gLApjYzNXL
	 e95ar8gZlvOGw==
Message-ID: <06996199-5255-41d0-ba6a-ebeca57f61da@kernel.org>
Date: Tue, 8 Sep 2026 10:56:58 +0200
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

> diff --git a/tools/include/uapi/linux/elf.h b/tools/include/uapi/linux/elf.h
> index 5834b83d7f9a..88bdcbb526c1 100644
> --- a/tools/include/uapi/linux/elf.h
> +++ b/tools/include/uapi/linux/elf.h

> @@ -312,7 +323,7 @@ typedef struct elf64_phdr {
>   #define SHN_ABS		0xfff1
>   #define SHN_COMMON	0xfff2
>   #define SHN_HIRESERVE	0xffff
> -
> +

Getting the following warning when applying this series with 'b4 shazam'.

/home/chleroy/linux-powerpc/.git/rebase-apply/patch:846: trailing 
whitespace.

Seems to come from here.

>   typedef struct elf32_shdr {
>     Elf32_Word	sh_name;
>     Elf32_Word	sh_type;
