Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725DF470456;
	Fri,  2 Oct 2026 09:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932739; cv=none; b=XyeOzRTZSe2inKlrdAJF1DdsjW6RDfIOsBbnWaSb4rZYhovW/akuXwa6Ll5I6ZQtHBQQm0oW5kIiPbMPqP9jt6GcN82yNFQtl+Rj53U4zxRNAIr3grvcOJZUBp2JNlRUjvCBhPls+D6Rmj7FPei57GH/nXq4XTmwTw1A8Tov65A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932739; c=relaxed/simple;
	bh=suekEUMK13TAHHU4Cf2etsAqCGbQmsK5+r24aKbCtI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gyByd98LZHdwDb6yM2MrFJwcm9PJUiDVZsrU908X7ViUQWMyxZfdRr5PIEjjk7rMgJerBhNFbKJc5wIeqjHMlCE3OSaiuMgXSvQXk1KgjfDXNJCF76xSPbVMHYYE6CtO/dcD6sgK+ZCiQtRRsk/K8RkjfpFWvfNGI8agl+ESMxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bib7a0PM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bib7a0PM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854CD1F000FF;
	Fri,  2 Oct 2026 09:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932738;
	bh=kUPal21B/mSeq/i2I0fVbafYDiAiPgFaWqso5GBNYgw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Bib7a0PM9uB/Juf5Fvu+oSR5+RsFmNc22FbQ3W8GIqtnemb+ACt71CTBw2sib4s92
	 fFnF4433pDjiEGcg7x5zAEvURZ47Q+qrMo2IYrA95mk7vxbQjDv/9+rywF+rGaZ2P7
	 MWKHtnnqTQ8pjgpyCRbNP4t/CulAsggec5uV/Q4dsuX2d3LyZTJU72PUMvHEvpTwms
	 bQHF6mNjpQkROI+pb8cwG0OWRm4RbVW2IZfgTwGPNyr7ZCIRlyeoMH50oI1zzLRcfH
	 fUDv5QFMQ3ZAiDD1vUKWIdfRDKrY3rzo4o2Sj1ojPFTeN/KT1OBRSYQl++2ya2NmOw
	 blTAYWLPs3B3Q==
Message-ID: <83a874fb-db66-4dc2-8e14-68c7e28ae27c@kernel.org>
Date: Fri, 2 Oct 2026 11:18:51 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] random: vDSO: Avoid call to memset() when zeroing
 reserved in __cvdso_getrandom_data()
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 llvm@lists.linux.dev
References: <are6s5e6On3hpD3M@zx2c4.com>
 <CAKwvOd=BrMfFT88jsvBPhh383qqk5G+J07CsofNu0MVkziyhCg@mail.gmail.com>
 <20260930133813.GA3142230@ax162> <ar0a4b9CjL2YHCkY@zx2c4.com>
 <ar0gTS71qxnx9AkW@zx2c4.com> <20260930151337.GD3142230@ax162>
 <CAHmME9pA+AntJ6hWoFYpTVjh-NUSd0ZGXp5XiUuhQcq3HjQT3g@mail.gmail.com>
 <ede392d7-3104-4a0f-9fa1-99b22552dcd6@kernel.org>
 <ar4nD8aRH7wEvTMt@zx2c4.com> <20261001102059.GA4176271@ax162>
 <ar46ap4jzLWyP92C@zx2c4.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <ar46ap4jzLWyP92C@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 01/10/2026 à 12:48, Jason A. Donenfeld a écrit :
> On Thu, Oct 01, 2026 at 12:20:59PM +0200, Nathan Chancellor wrote:
>> control. The change that introduced -max-store-memset only did it to
>> "allow fine-tuning of the inlining threshold for performance analysis
>> and optimization". If they decide to remove it for whatever reason,
>> we're back to square one.
> 
> I suppose all the more reason to get -finline-stringops=memset added to
> clang. Then the dual-default thing you came up with below will naturally
> start choosing the first option when it becomes available.
> 
>> I know something like below would be uglier due to the ifdef but it
>> would avoid changing anything for GCC while clearing up the issue at
>> hand for clang in a guaranteed stable and succinct manner.
> 
> But then we're back to the byte-by-byte codegen that Christophe pointed
> out.
>   
>> If that is not acceptable, something like the following does appear to
>> work for me.
> 
> Okay, great, let's do that.
> 
> Does this commit seem okay with you? I used the diff you sent below and
> adjusted the commit message: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.zx2c4.com%2Flinux-rng%2Fcommit%2F%3Fid%3D56ff95ee85715047eb5b5220243778af657778c8&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cd89b4de22ff94b6be71208df1fa9839a%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639264485055490029%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=Vxf8xRCdLavtw4Dmi%2B49FY1lJDWtm%2BjKv7f8BxKTGq4%3D&reserved=0
> 

The commit message says: Similarly, GCC has -finline-stringops=memset to 
do the same [4], should this issue ever hit future version of GCC.

Why default "-finline-stringops=memset" if 
$(cc-option,-finline-stringops=memset), have we identified cases where 
build fail without that or is it just for future provision ?

As shown in my previous email, with GCC 16 on powerpc32 we get a 
slightly better code without this option.

---
diff --git a/init/Kconfig b/init/Kconfig
index 8583d9f06c52..98d8d7fa64c5 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -173,6 +173,11 @@ config CC_HAS_ALLOC_TOKEN
  config CC_HAS_MULTIDIMENSIONAL_NONSTRING
  	def_bool $(success,echo 'char tag[][4] __attribute__((__nonstring__)) 
= { };' | $(CC) $(CLANG_FLAGS) -x c - -c -o /dev/null -Werror)

+config CC_OPT_INLINE_MEMSET
+	string
+	default "-finline-stringops=memset" if 
$(cc-option,-finline-stringops=memset)
+	default "-mllvm -max-store-memset=4294967295" if $(cc-option,-mllvm 
-max-store-memset=4294967295)
+
  config LD_CAN_USE_KEEP_IN_OVERLAY
  	# ld.lld prior to 21.0.0 did not support KEEP within an overlay 
description
  	# https://github.com/llvm/llvm-project/pull/130661

