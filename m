Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FCB2F8EBC;
	Thu, 24 Sep 2026 12:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790253117; cv=none; b=RPjY9od/5swXzRzzmz43f5NQqF5ZRgRdkm58ea7dpGzGAmpIkXzjEKCPz91mhJ5Seax+4jqR+BKvhYtCb1ulnY5cGxzGQ1g+2TIv/wczwI2x/XGRlCDJxXSLmxKR99sjZy1ZoalavYcSkhMV3+V9mapMQswyTgcryK/pgFuv39Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790253117; c=relaxed/simple;
	bh=tyroa8lBoOqLwHpTeRHuGpjV833qc9sQbRMa/D+dsoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILxUdjR37BVLUVQK1t4mx3a/Z9msa3+4fijhXc64NdS4QRIL58TilBpSXQh/ekCcA4Coyx+miKjRTiwhaHFJqFmWcYzQiCVlmTyNmt/MYW5g1xKhIj5bIojuh6Q23zxcOURRXDp5hDxDJckgibKD3UW2m8FIh1UL21FSxC3y1/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lz309Dy3; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lz309Dy3"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B3381570;
	Thu, 24 Sep 2026 05:31:51 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2777F3F86C;
	Thu, 24 Sep 2026 05:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790253115; bh=tyroa8lBoOqLwHpTeRHuGpjV833qc9sQbRMa/D+dsoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lz309Dy3TlEu+7y1tHZCYfrdPqaWCgtZMoXnPf8tuQOM4LMWKCZ6sgCmYSkYsjvcs
	 tO7bMRWvAOIpOXYh7A+nfbCx25N76QAhUGvlajWZ3EFwvUyLVK0EAGgwuHLQJWAXUT
	 QV+kIw/8QJ9o4Wbe1n28zhddNcWmz6QOOLHombIo=
Date: Thu, 24 Sep 2026 13:31:42 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: catalin.marinas@arm.com, will@kernel.org, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, ojeda@kernel.org, boqun@kernel.org,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	dakr@kernel.org, daniel.almeida@collabora.com, tamird@kernel.org,
	acourbot@nvidia.com, work@onurozkan.dev, nathan@kernel.org,
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
	jszhang@kernel.org, japo@linux.ibm.com, peterz@infradead.org,
	jpoimboe@kernel.org, seanjc@google.com, pmladek@suse.com,
	thuth@redhat.com, ynorov@nvidia.com, joelagnelf@nvidia.com,
	david@davidgow.net, fujita.tomonori@gmail.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [RFC] rust: kernel: Add KUnit tests for ARCH_WARN_ASM bug table
 emission
Message-ID: <arUYLsJJewE--wqo@J2N7QTR9R3>
References: <20260922054959.955093-2-mkchauras@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260922054959.955093-2-mkchauras@gmail.com>

On Tue, Sep 22, 2026 at 11:20:00AM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> Verify that the __bug_table entry emitted by ARCH_WARN_ASM has a correct
> bug_addr displacement — i.e. the arch's trap label reference resolves to
> the trap instruction — by calling find_bug() with the exact virtual address
> of the trap, mirroring what the real trap handler does.
> 
> To support all architectures, each arch that implements ARCH_WARN_ASM now
> defines ARCH_WARN_ASM_TRAP_LABEL, a string constant naming the local label
> at which the trap instruction is placed:
> 
>   x86       "1"     (ud2 at label 1:)
>   powerpc   "1"     (twi at label 1:)
>   riscv     "1"     (ebreak at label 1:)
>   arm64     "14471" (brk placed at 14471: by __BUG_ENTRY_END)
>   s390      "0"     (mc at label 0:)

I'm not a fan of exposing such a low-level implementation detail out of
the architecture code, and I don't think we should expose this.

What exactly are you trying to verify here, and why? Has there been
some _specific_ issue on powerpc that caused you to look at this?

Mark.
