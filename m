Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AFA396B68;
	Fri, 21 Aug 2026 20:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787343504; cv=none; b=KSvqo4gQfUH5ST+X0RujR+XqRU/Fy+HqXPppoJubUD+O6kvRSzJ0uTw8pA5hU22ICBCXJWBSPpPsBpPW5b0kEorCJ2YbmbNH6WH62ebz3FGF4AEBh1KgQc5sFf03vjWMxMuBVLnT0nQoj/tUH/W7DUs8ritc+lxLVEzoDwxhRWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787343504; c=relaxed/simple;
	bh=Bmni72FBigp05Qk3FlR0uoXb5ptpo7Cq2JzeNLAOGc8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BI7LZSbIOSEW+YMfmusj7OZn85QsENCAK6Gyuj7CFjOjSVhUf7ymKBxyl0cB/Ba9qH4R3aTdGL4V9+XQfYq46YWMsu4ETiVMTf2/LuD3aG+3SoyU5UHLiOdFxP4vAVJJKMMsBES7koQIc7lJBDZNCcHOocxG7qrarc+WQLwCSsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIcrOmPO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIcrOmPO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B8D1F000E9;
	Fri, 21 Aug 2026 20:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787343500;
	bh=7zPthHLJ5M0pXfnJcxALHsANPRtljH3ZF3R8Fyhe8o4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eIcrOmPOTKCcDPfN3jcm+AlD69AwJaBA4Zz0y01QDIxtLkou5Fb8TMPkSfJJjgVje
	 o2hNnvuanwiBmUx5+0JUiXKOy17IDIEpvfijDvdhMrOcQNy3+eLdKvVWxxNvFl1EW5
	 t7coQQAId9VeYb9sv/MAjPcUHrBfnfFOTdB2dHx0D9h69PX4lOe8FblcBf6cV3k80k
	 zS1WWORxdmUR6Jeoc4jjt7hWXRGoNVW9ralQihau0Tfkqu025xzruPcei+jItvtcD7
	 1XDk4gXceAwI1EsrKWCiC4rSkoduLnl1FifwLLtan9Lyd3FCLKDDUyuMuB7s9Y/tqJ
	 8CKpXvVNlAogA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 12/24] unwind_user/eh_frame: Remove
 .eh_frame[_hdr] section on detected corruption
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-trace-kernel@vger.kernel.org, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260821195259.2688377-13-jremus@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
 <20260821195259.2688377-13-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 20:18:20 +0000
Message-Id: <20260821201820.81B8D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] A Time-of-Check to Time-of-Use (TOCTOU) race condition allows the =
kernel to erroneously unregister a valid, newly loaded .eh_frame section du=
e to address reuse.
- [High] The unwinder conflates actual memory corruption with kernel-impose=
d safety limits, permanently disabling unwinding for valid libraries.

Pre-existing issues:
- [Critical] Unchecked error from mas_erase() leads to freeing a maple tree=
 section while it remains active in the tree, causing a Use-After-Free (UAF=
).
- [High] Lock drop and reacquire inside mas_erase() during mas_for_each() i=
teration causes a TOCTOU race and memory leak.
--

--- Patch [12]: [RFC PATCH v2 12/24] unwind_user/eh_frame: Remove .eh_frame=
[_hdr] section on detected corruption ---
commit 14251b7471659003e9517d814ad704b284ed18df
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user/eh_frame: Remove .eh_frame[_hdr] section on detected corruption

This commit adds logic to unregister .eh_frame or .eh_frame_hdr sections on
demand when corruption is detected during lookup. This prevents repeated
attempts to parse bad unwind sections by removing them immediately upon an
error return.

> diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c
> index 21f40805b417f..327849ea4a692 100644
> --- a/kernel/unwind/eh_frame.c
> +++ b/kernel/unwind/eh_frame.c
> @@ -1202,6 +1202,15 @@ int eh_frame_find(unsigned long ip, struct unwind_=
user_frame *frame)
>  	if (!ret)
>  		ret =3D __find_frame_row(sec, &fde, ip, frame);
> =20
> +	/*
> +	 * Unregister .eh_frame[_hdr] in case of an error,
> +	 * e.g. EINVAL (corrupted) or EFAULT (inaccessible).
> +	 * Keep if ENOENT (not found) or EOPNOTSUPP (unsupported CFI).
> +	 */
> +	if (ret && (ret !=3D -ENOENT && ret !=3D -EOPNOTSUPP))
> +		if (eh_frame_remove_section(sec->eh_frame_hdr_start))
> +			dbg("eh_frame_remove_section() failed\n");
> +

[Severity: High]
Does this introduce a race condition with memory unmapping and mapping?

If a thread is delayed after retrieving sec in eh_frame_find(), another
thread could unmap the library and map a new library at the exact same
virtual address, registering it with the same eh_frame_hdr_start. When the
first thread resumes and fails to parse against the new memory, passing the
virtual address sec->eh_frame_hdr_start to eh_frame_remove_section() seems
like it would unintentionally remove the newly loaded, valid library's
section.

[Severity: High]
Is it safe to assume -EINVAL always means corruption?

Looking at __do_cfi_program(), it also returns -EINVAL when kernel limits
are hit, such as exceeding EH_FRAME_CFI_INSN_LIMIT or
EH_FRAME_MAX_CODE_ALIGN.

If a valid library simply has a complex function that hits these limits,
wouldn't this code globally and permanently disable unwinding for it by
removing its section?

[Severity: High]
This is a pre-existing issue, but looking at eh_frame_remove_section()
which is called here, is there a memory leak if mas_erase() drops the lock?

eh_frame_remove_section() holds mtree_lock and iterates via mas_for_each().
It calls __eh_frame_remove_section(), which calls mas_erase().

If mas_erase() needs to allocate memory via mas_nomem(mas, GFP_KERNEL), it
can drop the tree lock. If a concurrent thread inserts a new section
covering the same range during this unlocked window, mas_erase() retries,
erases the new section, and returns it.

__eh_frame_remove_section() then sees the returned entry doesn't match sec,
returns -EINVAL, and skips call_srcu(), potentially leaking the new section.

[Severity: Critical]
This is a pre-existing issue, but looking at __eh_frame_remove_section()
called by eh_frame_remove_section(), can a memory allocation failure lead
to a use-after-free?

If mas_nomem() fails to allocate memory during mas_erase(), it sets an
error state and aborts without removing the node, but still returns the
original sec:

__eh_frame_remove_section() {
    ...
    if (mas_erase(mas) !=3D sec) {
        return -EINVAL;
    }
    call_srcu(&eh_frame_srcu, &sec->rcu, eh_frame_free_srcu);
    ...
}

Because __eh_frame_remove_section() only checks if the return value does
not equal sec, it misses the error state completely. It then calls
call_srcu() to free the section while the node remains active in the maple
tree. Could subsequent calls to eh_frame_find() load and access this freed
memory?

>  	return ret;
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821195259.2688=
377-1-jremus@linux.ibm.com?part=3D12
