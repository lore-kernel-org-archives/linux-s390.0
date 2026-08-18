Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87E93AB5C7;
	Tue, 18 Aug 2026 15:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787066304; cv=none; b=XO3jR6VgX3910pnmMOmOxpUSPks3wPwjBK9MPBvSf+5m/ilEaOwhNQvKrhhtUmR+TTlsmKkWi7746U+yFbd2fH2XIXsH+NjBCv+LczjPKrZovVaninuy5Y7Az2TZiCtIKlg+6vT6CKhhAfgaVevmwl0BuD9UKAlHSyhzAANfoBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787066304; c=relaxed/simple;
	bh=R5tM4gAjDW+eaR/dLTZOP+e2n8FmfEseVDpTWc22KuQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UZJy4X935mMNqS+sNgM3i8kLNxXh655jUtHJPRRNKebP6L884oZGSTFRULMX4v3/Zcsmh2x+UCoP5PKd1VXp1apKIeAQAzjCxJpDQFtS/0IeAKqZ0+X1nnbqZkAqtKfX8zRQbKJ+4ADt38lDYSjQSQSd+LrgMAabja4cDEG9Go8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWCPmpdi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWCPmpdi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F161F000E9;
	Tue, 18 Aug 2026 15:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787066303;
	bh=4/ER9l30bxbqF71G3U/TBPJvk0ITrzfhWzVQG6UdLxY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gWCPmpdiPwr8RlTT9aF2QaVoPaZ6xRfzxXYwIcMQAVyMn3ywCQ/ZZp2OHVTVrxMOP
	 S+A6IsbeLkiUeIIKW8bxYp/Wsh06FSEJirkmuSP8GUO6pxLcKwSHFeQ6oSgstSw/p4
	 LZgYzlXYnG7AlCP5P7BK82SIHUDdl5Vx/yFI7pkGghUqK7cDHSJrImsduCSkgap/JN
	 qmoC5mpl95WOuu78R3pcSiawfTrwQmsT1HqbGFcmllsV7e9Wc/e3BMYy2L50G40N02
	 KCfM/Qh33KXd0Yre3Q5VuMwOONxcDkmVtrID0qvaSXspHNUEDIA4i3KSbl8a0uVo2e
	 DRAamYCvl/Bcw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 10/25] unwind_user/eh_frame: Detect .eh_frame_hdr
 sections in executables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-trace-kernel@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260818144954.2320378-11-jremus@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-11-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 15:18:22 +0000
Message-Id: <20260818151823.18F161F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing duplication of eh_frame_mt during fork() leaves child proc=
esses without stack unwind capability.
- [Medium] Executable segments with a trailing BSS section silently fail .e=
h_frame_hdr registration.
--

--- Patch [10]: [RFC PATCH v1 10/25] unwind_user/eh_frame: Detect .eh_frame=
_hdr sections in executables ---
commit e178ff4c7b227a1dcb3db08f8923210e443187ac
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user/eh_frame: Detect .eh_frame_hdr sections in executables

This commit modifies the ELF loader to automatically detect .eh_frame_hdr
sections during binary and interpreter loading. It associates these sections
with the mm_struct to support user-space stack unwinding.

> When loading an ELF executable, automatically detect .eh_frame_hdr
> sections and associate them with the mm_struct.

[Severity: High]
Are these eh_frame sections properly preserved for child processes during
fork()?

When a process forks, dup_mm() creates a new mm_struct and calls mm_init(),
which appears to initialize eh_frame_mt as an empty maple tree:

kernel/fork.c:mm_init_eh_frame() {
    ...
    mt_init(&mm->eh_frame_mt);
    ...
}

Is there any subsequent logic that duplicates the parent's eh_frame_mt
entries during dup_mm()? If not, won't child processes inherit correctly
duplicated VMAs but an empty eh_frame_mt, resulting in a complete loss of
stack unwinding capabilities for all children?

> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 16a56b6b3f6ca..8c1cdd8318c53 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c

[ ... ]

> @@ -637,6 +638,23 @@ static inline int make_prot(u32 p_flags, struct arch=
_elf_state *arch_state,
>  	return arch_elf_adjust_prot(prot, arch_state, has_interp, is_interp);
>  }
> =20
> +static void elf_add_eh_frame(const struct elf_phdr *text,
> +			     const struct elf_phdr *eh_frame,
> +			     unsigned long base_addr)
> +{
> +	unsigned long eh_frame_start, eh_frame_end,
> +		      text_start, text_end;
> +
> +	eh_frame_start =3D base_addr + eh_frame->p_vaddr;
> +	eh_frame_end   =3D eh_frame_start + eh_frame->p_memsz;
> +
> +	text_start   =3D base_addr + text->p_vaddr;
> +	text_end     =3D text_start + text->p_memsz;

[Severity: Medium]
Will this silently fail to register .eh_frame_hdr for segments with a
trailing BSS section?

When an ELF executable segment has p_memsz > p_filesz crossing a page
boundary, the loader maps the file-backed portion and creates a separate
anonymous VMA for the BSS.

Because text_end is calculated using p_memsz, it may extend beyond the
file-backed VMA boundary. When this is passed to eh_frame_add_section(),
it uses vma_lookup() and checks if the entire segment resides in a single
VMA:

kernel/unwind/eh_frame.c:eh_frame_add_section() {
    ...
    if (!text_vma ||
        !(text_vma->vm_flags & VM_EXEC) ||
        text_end > text_vma->vm_end) {
        return -EINVAL;
    ...
}

Since the file-backed VMA ends before text_end in this scenario, won't the
text_end > text_vma->vm_end check fail and terminate registration?

> +
> +	/* Ignore return value, eh_frame[_hdr] section isn't critical */
> +	eh_frame_add_section(eh_frame_start, eh_frame_end, text_start, text_end=
);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818144954.2320=
378-1-jremus@linux.ibm.com?part=3D10
