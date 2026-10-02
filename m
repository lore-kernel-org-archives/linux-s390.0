Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247003655EA;
	Fri,  2 Oct 2026 09:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790934593; cv=none; b=YV1t2imBNPhZgj4VdSo9XXgENrtKBuihKLVFfoP+l08/CRtor6sF3n98fZ8Vjyu6CkmIQXPqpUo0eqLdAS2IR9rXAkHdwx2EhL0rqJoYT4+QSS9X3yyxfFk40lmAa8rdXQPEAmJG09rs/5lTnDwVHyTOpF+yryW1m9Sk6B0JVSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790934593; c=relaxed/simple;
	bh=hTWziqKtepDGWLkXqTacUJOldfkRVj3vc6hsj12mp38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIZvdrsn2UtWSIkArzhTN/f/0jD6gv/CBUoHatfNwubISZMIS1ctutZG0HbJqaHbcp1nP1mfjpcrBuBsidTRq+xJZXPx/65LTTQBhMce89tI7BuoTGJyV7vUR0WouEz325jf/Qa1T39i3eqgHfKy1ZyvEItOs/odMdibMluSrWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOMAm0+c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOMAm0+c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C201F00898;
	Fri,  2 Oct 2026 09:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790934582;
	bh=O1NvwTXORD+Bb07RA52Wu5WZWJqKJmdYmCUZOMWRc5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aOMAm0+cj8fILcHV8Uj0RSZsjvcpY1RGYRxgNmibtLJucq4PJOFYlIeiGQVMfrMtH
	 DuOOY8IKcr5yOnM73cxavmFw/nMHIjF2qDFrl5uDmTm4oMLgD066mfJFMfXw9Bc49t
	 csqzp1wUBMrdSv3SghZJ/e5GLtijiu6xy2aZ5PO4v+0coTfSNOC/XZkaenDtUej0CP
	 i/q/JrIeY1TU8Nol9o5vJO8rP4m5pAttrz6dh8syfIsV6x0pir8FExIzAdOKEXHnA9
	 Cm8d729oJ1G8qj87sC00EzJFfXA+tDEZru+V9USQSA1Xg//ndb/O3J7bRLVs8z/I4V
	 zfigDTcHw5t/g==
Date: Fri, 2 Oct 2026 11:49:32 +0200
From: Nathan Chancellor <nathan@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2] random: vDSO: Avoid call to memset() when zeroing
 reserved in __cvdso_getrandom_data()
Message-ID: <20261002094932.GA3435055@ax162>
References: <20260930133813.GA3142230@ax162>
 <ar0a4b9CjL2YHCkY@zx2c4.com>
 <ar0gTS71qxnx9AkW@zx2c4.com>
 <20260930151337.GD3142230@ax162>
 <CAHmME9pA+AntJ6hWoFYpTVjh-NUSd0ZGXp5XiUuhQcq3HjQT3g@mail.gmail.com>
 <ede392d7-3104-4a0f-9fa1-99b22552dcd6@kernel.org>
 <ar4nD8aRH7wEvTMt@zx2c4.com>
 <20261001102059.GA4176271@ax162>
 <ar46ap4jzLWyP92C@zx2c4.com>
 <20261001110310.GA138012@ax162>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001110310.GA138012@ax162>

On Thu, Oct 01, 2026 at 01:03:10PM +0200, Nathan Chancellor wrote:
> On Thu, Oct 01, 2026 at 12:48:10PM +0200, Jason A. Donenfeld wrote:
> > Does this commit seem okay with you? I used the diff you sent below and
> > adjusted the commit message: https://git.zx2c4.com/linux-rng/commit/?id=56ff95ee85715047eb5b5220243778af657778c8
> 
> Yeah, that seems fine to me, thanks for taking care of it!

Can you adjust the LLVM value by one from 4294967295 to 4294967294? ~0U
is actually a special value, so we hit an assertion in the SystemZ
backend.

  https://github.com/llvm/llvm-project/blob/3f48e22a1f321d5d3341bd812803694cea588785/llvm/lib/CodeGen/SelectionDAG/SelectionDAG.cpp#L9547
  https://github.com/llvm/llvm-project/blob/3f48e22a1f321d5d3341bd812803694cea588785/llvm/lib/Target/SystemZ/SystemZISelLowering.cpp#L1470-L1471

clang: llvm/lib/Target/SystemZ/SystemZISelLowering.cpp:1471: virtual bool llvm::SystemZTargetLowering::findOptimalMemOpLowering(LLVMContext &, std::vector<EVT> &, unsigned int, const MemOp &, unsigned int, unsigned int, const AttributeList &, EVT *) const: Assertion `Limit != ~0U && "Expected EmitTargetCodeForMemXXX() to handle AlwaysInline cases."' failed.
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace and dumped files.
Stack dump:
0.      Program arguments: ...
1.      <eof> parser at end of file
2.      Code generation
3.      Running pass 'Function Pass Manager' on module 'arch/s390/kernel/vdso/vgetrandom.c'.
4.      Running pass 'SystemZ DAG->DAG Pattern Instruction Selection' on function '@__kernel_getrandom'
...

-- 
Cheers,
Nathan
