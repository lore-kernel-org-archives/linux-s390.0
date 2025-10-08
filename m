Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4EB29DB96;
	Wed,  8 Oct 2025 03:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759893535; cv=none; b=AM6Uo9KPUra1q+ZfzI1mv9cXpuRjmBEkvUkckAsHl0IjqyAUXuRHvaobtw4drbMOkb4P90lzBis+hgpmHNRDR/SfsDE3V8u/IoXshOE8DT/e5XWfz5Fa7Xe1nh5TQ5cKbrNkQtReFyUoOj4NXQLrFZ/hYpOaqhIMyeEbf6ndCd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759893535; c=relaxed/simple;
	bh=hfwxsf91UOa/ZzCi0wOKakAi9bfyZrL6KPmJfVnQy3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRi62e9IYZYstNqaXs0sUwZtmCVVsOxtVXPiIWX09RYrPj4idM/fMazvIAgjcd01/00jjEUDI2X7hAQcktmLDQQbqoFl68t8yRn76IJa5npf/hOBF+OBrBOoP25q7m/5E2L0mx0ra4vycl6jJ5UOMqUGxK22RG3Rs+80pDVZvio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lopGO4rX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lopGO4rX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446D8C4CEF1;
	Wed,  8 Oct 2025 03:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759893534;
	bh=hfwxsf91UOa/ZzCi0wOKakAi9bfyZrL6KPmJfVnQy3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lopGO4rXzPmAj7esZ7EHkgOaI6vc3YjsCSEKhVi20wTl++1OzV80nC8EMRVtOZITO
	 x915bnQJtSRKGSH4LqFqyLXoQ6p348NcEBgmfDKZEoV6hURd2PLK5TZX+Gt27u5oGr
	 kbKZZGZniUsUd935iky6Pgu6eyXXvXEySsFQrq5tng9rKkLfuhk4ALq4v11s50nTwA
	 8plJG2hywZw1OIspNp5xRbP1+YG+QHieS/eNh3GYeuhSa+R0CTDtxs/42oX4pmCN13
	 SxSPDvMTYAMN2svXR27OtknYp9K/KD4YmFFBtaJ9IuN1dbk2ijWXl0BGayONJdD6Sw
	 p5cr8lVKlOg0A==
Date: Tue, 7 Oct 2025 20:18:49 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Alexey Gladkov <legion@kernel.org>, linux-s390@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: next-20251002: S390: gcc-8-defconfig: symbol `.modinfo' required
 but not present - no symbols
Message-ID: <20251008031849.GA509861@ax162>
References: <CA+G9fYvVktRhFtZXdNgVOL8j+ArsJDpvMLgCitaQvQmCx=hwOQ@mail.gmail.com>
 <20251006174740.13659A33-hca@linux.ibm.com>
 <20251006234114.GA659425@ax162>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006234114.GA659425@ax162>

On Mon, Oct 06, 2025 at 04:41:19PM -0700, Nathan Chancellor wrote:
...
> > > ### Build error log
> > > s390x-linux-gnu-ld: .tmp_vmlinux1: warning: allocated section `.got.plt' not in segment
> > > s390x-linux-gnu-ld: .tmp_vmlinux2: warning: allocated section `.got.plt' not in segment
> > > s390x-linux-gnu-ld: vmlinux.unstripped: warning: allocated section `.got.plt' not in segment
> > > s390x-linux-gnu-objcopy: vmlinux: warning: allocated section `.got.plt' not in segment
> > > s390x-linux-gnu-objcopy: stM7JmYX: warning: allocated section `.got.plt' not in segment

So these warnings should be fixed with:

diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index feecf1a6ddb4..d74d4c52ccd0 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -214,6 +214,28 @@ SECTIONS
 	DWARF_DEBUG
 	ELF_DETAILS
 
+	/*
+	 * Make sure that the .got.plt is either completely empty or it
+	 * contains only the three reserved double words.
+	 */
+	.got.plt : {
+		*(.got.plt)
+	}
+	ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT entries detected!")
+
+	/*
+	 * Sections that should stay zero sized, which is safer to
+	 * explicitly check instead of blindly discarding.
+	 */
+	.plt : {
+		*(.plt) *(.plt.*) *(.iplt) *(.igot .igot.plt)
+	}
+	ASSERT(SIZEOF(.plt) == 0, "Unexpected run-time procedure linkages detected!")
+	.rela.dyn : {
+		*(.rela.*) *(.rela_*)
+	}
+	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
+
 	/*
 	 * uncompressed image info used by the decompressor
 	 * it should match struct vmlinux_info
@@ -244,28 +266,6 @@ SECTIONS
 #endif
 	} :NONE
 
-	/*
-	 * Make sure that the .got.plt is either completely empty or it
-	 * contains only the three reserved double words.
-	 */
-	.got.plt : {
-		*(.got.plt)
-	}
-	ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT entries detected!")
-
-	/*
-	 * Sections that should stay zero sized, which is safer to
-	 * explicitly check instead of blindly discarding.
-	 */
-	.plt : {
-		*(.plt) *(.plt.*) *(.iplt) *(.igot .igot.plt)
-	}
-	ASSERT(SIZEOF(.plt) == 0, "Unexpected run-time procedure linkages detected!")
-	.rela.dyn : {
-		*(.rela.*) *(.rela_*)
-	}
-	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
-
 	/* Sections to be discarded */
 	DISCARDS
 	/DISCARD/ : {

I am unsure why newer binutils does not show this but I did not care
enough to actually bisect.

> > > s390x-linux-gnu-objcopy: stM7JmYX: symbol `.modinfo' required but not present
> > > s390x-linux-gnu-objcopy:stM7JmYX: no symbols

I did bisect binutils to figure out that commit c12d9fa2afe ("Support
objcopy --remove-section=.relaFOO") [1] in binutils 2.32 resolves this
error.

I can fix this for those older binutils with:

diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index 7c6ae9886f8f..9ea92c3317dc 100644
--- a/scripts/Makefile.vmlinux
+++ b/scripts/Makefile.vmlinux
@@ -82,7 +82,7 @@ endif
 # ---------------------------------------------------------------------------
 
 remove-section-y                                   := .modinfo
-remove-section-$(CONFIG_ARCH_VMLINUX_NEEDS_RELOCS) += '.rel*'
+remove-section-$(CONFIG_ARCH_VMLINUX_NEEDS_RELOCS) += '.rel*' '.rel.*'
 
 remove-symbols := -w --strip-symbol='__mod_device_table__*'
 

I can send a patch series tomorrow.

[1]: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=c12d9fa2afe7abcbe407a00e15719e1a1350c2a7

Cheers,
Nathan
