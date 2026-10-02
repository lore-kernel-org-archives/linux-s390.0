Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EA447279F;
	Fri,  2 Oct 2026 09:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790933290; cv=none; b=TGJZdGTRPd36kOxxNXimYH5Jvo843N2iLy97krw5kMj/M0FysZvl0WdWbBCAa+nkrpXRK38T1igpPA+EOtU4NFo/WYDHuRH8RCpKXSuT4k+zUdts9EKu9xRHCYdNf6Fxn5YEDy5r7lmxfUd2r0yecq+r6UgLqKeHpBloMpZd0KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790933290; c=relaxed/simple;
	bh=ey+HfqbT063llCzkfHlDumf8iTEsGPYJdwUxMyASXx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qstAiYhr7tkUXXu/qg7nH5AFTw0fVw+cuJMyeFDM8ncaTb2rMOFE73jQlcv9VcpB+bvcArpfQosMt+xjKwPUsiCp75l89+x4ZmVsr8F28wlTlzDos0+py9pIHUEdgwQLVqbTLvT3KKZD9SQEr619UoBFDiG/U0D63nPPbYoCjlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=JXF9aYC9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JXF9aYC9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424F21F000FF;
	Fri,  2 Oct 2026 09:28:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=JXF9aYC9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1790933279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dtcin0LGddrGq1z73zXhBfHbevxSulJDQC2ODA9S4LA=;
	b=JXF9aYC9WwUSK4dqsSbWZahQOF5tPs+qWfT6am7iM2kEiqJtJzCVxFzDeTv/m/a4MQVUpO
	GLRdB7QsZbpopzZdWvYR/SsEQbyfmCcXe2exUQZ5/eF4uZWlcciUWsy7qUj8Yd99apyea/
	uqdi3Lw+wZdB/dnq0RpegAZySOW8XXE=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id 0f473697 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 2 Oct 2026 09:27:58 +0000 (UTC)
Date: Fri, 2 Oct 2026 11:27:54 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
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
Message-ID: <ar95GsA9liO5Avn1@zx2c4.com>
References: <20260930133813.GA3142230@ax162>
 <ar0a4b9CjL2YHCkY@zx2c4.com>
 <ar0gTS71qxnx9AkW@zx2c4.com>
 <20260930151337.GD3142230@ax162>
 <CAHmME9pA+AntJ6hWoFYpTVjh-NUSd0ZGXp5XiUuhQcq3HjQT3g@mail.gmail.com>
 <ede392d7-3104-4a0f-9fa1-99b22552dcd6@kernel.org>
 <ar4nD8aRH7wEvTMt@zx2c4.com>
 <20261001102059.GA4176271@ax162>
 <ar46ap4jzLWyP92C@zx2c4.com>
 <83a874fb-db66-4dc2-8e14-68c7e28ae27c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83a874fb-db66-4dc2-8e14-68c7e28ae27c@kernel.org>

On Fri, Oct 02, 2026 at 11:18:51AM +0200, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 01/10/2026 à 12:48, Jason A. Donenfeld a écrit :
> > On Thu, Oct 01, 2026 at 12:20:59PM +0200, Nathan Chancellor wrote:
> >> control. The change that introduced -max-store-memset only did it to
> >> "allow fine-tuning of the inlining threshold for performance analysis
> >> and optimization". If they decide to remove it for whatever reason,
> >> we're back to square one.
> > 
> > I suppose all the more reason to get -finline-stringops=memset added to
> > clang. Then the dual-default thing you came up with below will naturally
> > start choosing the first option when it becomes available.
> > 
> >> I know something like below would be uglier due to the ifdef but it
> >> would avoid changing anything for GCC while clearing up the issue at
> >> hand for clang in a guaranteed stable and succinct manner.
> > 
> > But then we're back to the byte-by-byte codegen that Christophe pointed
> > out.
> >   
> >> If that is not acceptable, something like the following does appear to
> >> work for me.
> > 
> > Okay, great, let's do that.
> > 
> > Does this commit seem okay with you? I used the diff you sent below and
> > adjusted the commit message: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.zx2c4.com%2Flinux-rng%2Fcommit%2F%3Fid%3D56ff95ee85715047eb5b5220243778af657778c8&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cd89b4de22ff94b6be71208df1fa9839a%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639264485055490029%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=Vxf8xRCdLavtw4Dmi%2B49FY1lJDWtm%2BjKv7f8BxKTGq4%3D&reserved=0
> > 
> 
> The commit message says: Similarly, GCC has -finline-stringops=memset to 
> do the same [4], should this issue ever hit future version of GCC.
> 
> Why default "-finline-stringops=memset" if 
> $(cc-option,-finline-stringops=memset), have we identified cases where 
> build fail without that or is it just for future provision ?
> 
> As shown in my previous email, with GCC 16 on powerpc32 we get a 
> slightly better code without this option.
 
No, that patch tested this option + actually calling builtin_memset.
This new patch has the original code of zeroing a long at a time, but
has the inline memset option to prevent future GCC from recognizing that
pattern and making it outline. Codegen should be the same.

Jason
