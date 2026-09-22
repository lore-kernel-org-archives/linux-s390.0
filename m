Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51720489FA1;
	Tue, 22 Sep 2026 18:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101275; cv=none; b=qKgNx8yawaBs20aaoMBGspuRdnR1VaUjWxd7JPjXbWiR/SeoArCzweuv7oEUP4LeNEXWMzGrou2LdHqAccb+5OOIJcl5ymtgO55233rgfZ1vkVzJ2fIGNbdylK7Z77F/cVC7p1M1skfNwPkdD8/1nrXD8g9mO6MIOvgbRX/hleA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101275; c=relaxed/simple;
	bh=Q3Jq6AE38hPWyaC8PxBDHclNOm3GiucU6dy5HxDiIMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7CAbleV+GvSXd4cPKWojjSXvX8mP7hU+36e5cfFwdKNJ4d6DocJboPBDmDMVP8InD9Rl0m1AqY90wKOB2UpFvym7CHjKugZ1ZhiN/j7gjCj/sBslT/sDvdIw1b9usk8mIfZcGxl0NZGGNF6Rbgdu5lUp1jpaXu4FJ49lkUHe1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QbV58KhP; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QbV58KhP"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EC94C40E01C9;
	Tue, 22 Sep 2026 18:21:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hws8afuNhZVG; Tue, 22 Sep 2026 18:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1790101251; bh=wnm2vVrHQlGco2ec6VPqWb7bpCBXERRnc2z2yPnMu4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QbV58KhPfBVno6B2ArSJUhoSDLAQ4Hsf6Dk72/CpFNt6mZ+6+S1L18CuGaogLzaqZ
	 H3uX7aBWCoZhg13pIdi057ptLtwXUoaJJ3HywCGhlDHEQIpFKnWYlgSFipzy15hhLd
	 hE43IncmcBX7EKM0kvR5LNpyAhjG6BrWs5Q3MhlIpCgr0O1cO0CUxfc7k23U7+6RR8
	 3pGcYnWwlJOQ3wfqEVFKCl9nNaS9RKn+257MdnQR1waZGqG9p6ktKIVcAEtz3RwpnI
	 dgPft8Z3A2f0JQ/eQPzu7euTFDQ1bRJomhb15ikY5m9EajJngUNRXzi7HFd1v3lxPW
	 m/PecNbYJCsjEfzeo7AoB4cDgbuPDUjoYzQwgWYlH8jlIraFhutf/9wzfVfvvWP9JS
	 wgvL87caUEU3qauAkYvKztkcEb/rlzQavUbb/WtUfzT6Z/+vl2Vg9EMWDPOh12AjBh
	 ZgjaiIKFQnw/Y/1xQNYF/vUQvxAxzwMfCDW9BRT+MwZTZwayfaDbYD1znHp54yaRHL
	 XpewZPye+CeXiNijEyCz5LsD+PNqSthE0R3+dg2Dqf96Y4oKC0Ovjg04LfNX1yPNM3
	 XApzx8xgGwzN5wAtHIQAXryDJSKgRM53xzH8BP+cZz94XmahSUzXuL9snfgN0OtKBi
	 zoMm4dxnzhYwg8dgViCun/z4=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DBDA540E00E5;
	Tue, 22 Sep 2026 18:20:22 +0000 (UTC)
Date: Tue, 22 Sep 2026 11:20:19 -0700
From: Borislav Petkov <bp@alien8.de>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>, Xin Li <xin@zytor.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Aaron Tomlin <atomlin@atomlin.com>,
	linux-s390@vger.kernel.org, kvm@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] x86: Avoid indirect includes through
 linux/module.h -> linux/elf.h
Message-ID: <20260922182019.GAarLG4zWMoNNZJVZK@fat_crate.local>
References: <20260911-module-include-elf-v2-0-954c732975fb@suse.com>
 <20260911-module-include-elf-v2-1-954c732975fb@suse.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260911-module-include-elf-v2-1-954c732975fb@suse.com>

On Fri, Sep 11, 2026 at 04:40:31PM +0200, Petr Pavlu wrote:
> Several x86 files use ELF-related declarations and currently rely on them
> being provided indirectly through linux/module.h -> linux/elf.h:
> 
> * arch/x86/entry/entry_fred.c: ia32_enabled() -> asm/ia32.h,
> * arch/x86/entry/syscall_32.c: vdso32_image -> asm/vdso.h,
> * arch/x86/kernel/cpu/intel.c: ELF_HWCAP2 -> asm/elf.h,
> * arch/x86/kernel/fpu/xstate.c: elf_coredump_extra_notes_write(),
>   elf_coredump_extra_notes_size(), NT_X86_XSAVE_LAYOUT, elf_note ->
>   linux/elf.h,
> * arch/x86/kernel/process.c: mmap_is_ia32() -> asm/elf.h,
> * arch/x86/kernel/signal.c: get_sigframe_size() -> asm/elf.h.
> 
> Add the missing includes to these files in preparation for removing the
> linux/elf.h include from linux/module.h.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>  arch/x86/entry/entry_fred.c  | 1 +
>  arch/x86/entry/syscall_32.c  | 1 +
>  arch/x86/kernel/cpu/intel.c  | 1 +
>  arch/x86/kernel/fpu/xstate.c | 2 +-
>  arch/x86/kernel/process.c    | 1 +
>  arch/x86/kernel/signal.c     | 1 +
>  6 files changed, 6 insertions(+), 1 deletion(-)

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
