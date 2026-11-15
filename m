Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794724744;
	b=RfPXdTfAIy1ysjOFvtCTRQMxC+F3xOpE4hDmDl8rVT57PkmAljINPwPslLJGny4jBQCt
	 eJhagj1Ge7cZZe0fxwGj8K8Xu2yazP7Gfpj03cJtkXUI3NBXM/DlB0QLA0IJhixNbBwjB
	 mZaPefrO03klqZZk3fBQ5lPo3nN4C8/OZbq8axuE0wOyZjJ3FKc2MIgAmoQXCIgJNweNn
	 Ai5W3gLl1eMXuxRTj3qqwVmVZJ6MQOuNU6uWF5ucCyOTVlfRTTDGD9BIzrMqznQE++/TE
	 TV39guLR/nF1vFv2UhTy6olzozYW8q9xiOtLodUNl+4WYJAaUAVDKGv6hBkXITKA6dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794724744;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=5uzNQjIqKu1Z5H5h4ULFcPsML/9M2qNB6yySUHBpd2Q=;
	b=h/AP1EZHYqg1tUtXFrQDnze6+q1cmHPahHxpMrVoJED9C10jFUDrV+eTss2V+6e5Txo4
	 uOtWg177eJ0EYJe3dNwCCMRkmcUdsrobpGfqTlGMbEV4fohtS5UrR9fnNWmDK7yiQKVSo
	 lvXyluqIVz4JMkc15So0HpwtGomN7fS/5lCGSELj0kYIId9RfS2tDeV6eqBWc5dX+IEW3
	 vJt/2AI2Tb7/xkrdWLn8j5QdiSbjFlOi02IpXFjszjANEkVaz0SeVJP4qM9YGASjJj+uF
	 84fasrzTtew0nqHJb1nxrkIZORmmCKztn6nAvhCEDxjWL+1U7gyT/fNoFkBfW5wjJLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XY6g0QDN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DB7606A323;
	Sun, 15 Nov 2026 06:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XY6g0QDN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF9C1F000C4;
	Sun, 15 Nov 2026 06:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794724743;
	bh=5uzNQjIqKu1Z5H5h4ULFcPsML/9M2qNB6yySUHBpd2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XY6g0QDNlp+U9PsTjMW6Z7U+4AKhATHLs5He0CZN49f2Nu0bcao4bAPuuwEsft6FI
	 TWnoj+VGBoUPTmb0EJCJXCsTtwSE0k13bv5Te+OZ5Acn6pVLSE5i/fhLT5QGKgwaOk
	 Ucb2W6afh0Q1yzMIuWl0IoyL1xjTDc8J5WHHCJWlw82oKPLfFptJE13O1Ok9X62IyP
	 xkoneXTm1OtIXF7WSDiXJH8M/fRN/bG7+qbjc7kJUeud8mWA9cz/xm6XTt15y1BZge
	 qGkeMJ/mOBJIxREW4t6uml5kStkcI3+UGIwjK5RYkeEIMSPndyRf3R1y4lpuaoL/kN
	 M2jExDr2sEOLQ==
Date: Sun, 15 Nov 2026 08:38:46 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Donald Dutile <ddutile@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Liviu Dudau <liviu@dudau.co.uk>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nadav Amit <nadav.amit@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Russell King <linux@armlinux.org.uk>,
	Sam Ravnborg <sam@ravnborg.org>, Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH RESEND v8 11/16] powerpc: extend execmem_params for
 kprobes allocations
Message-ID: <avlTdlK9ErlqVRYl@kernel.org>
References: <20240505160628.2323363-1-rppt@kernel.org>
 <20240505160628.2323363-12-rppt@kernel.org>
 <3f7af771-87a7-4ae7-9919-bc4c23bd31c9@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f7af771-87a7-4ae7-9919-bc4c23bd31c9@kernel.org>

Hi Christophe,

On Fri, Nov 13, 2026 at 03:36:01PM +0100, Christophe Leroy (CS GROUP) wrote:
> Hi Mike,
> 
> Looks like I missed this change ...
> 
> Le 05/05/2024 à 18:06, Mike Rapoport a écrit :
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > 
> > powerpc overrides kprobes::alloc_insn_page() to remove writable
> > permissions when STRICT_MODULE_RWX is on.
> > 
> > Add definition of EXECMEM_KRPOBES to execmem_params to allow using the
> > generic kprobes::alloc_insn_page() with the desired permissions.
> > 
> > As powerpc uses breakpoint instructions to inject kprobes, it does not
> > need to constrain kprobe allocations to the modules area and can use the
> > entire vmalloc address space.
> 
> Using breakpoint means the segment must still be executable.
> On book3s/32 VMALLOC segment is not executable, while module segment is.
> 
> See commit 6ca055322da8 ("powerpc/32s: Use dedicated segment for modules
> with STRICT_KERNEL_RWX")
> 
> See report and fix at https://lore.kernel.org/all/ed03d290d440d579a81ae0b7de5243721291d903.1794543909.git.ritesh.list@gmail.com/

I'll take a look, thanks!
 
> Christophe

-- 
Sincerely yours,
Mike.
