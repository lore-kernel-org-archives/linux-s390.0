Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF24A442364;
	Tue, 18 Aug 2026 15:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065861; cv=none; b=nOinvmYtED1Ei2yOTmE05UfDx2+qxgiuP9eNQMnyx6vABzCjv/BskaxmWM2/bNDBlQ6He2x6/+XDyN50NwoWSY8eJFPfwtg0XkPw2YzQgVRsNTIMuydY01my/QsIrf6z23/QtPf8IELlWKqw/I+KP6LpbxxkXHB/XETcY1ceOSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065861; c=relaxed/simple;
	bh=fiIx7Yih5L6ooWA9+tZoa7cmzYlfpJ4bRD0mPh7NshE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RpvQ9cDHaBWNLGYKqzMTohmDQsWEJePkjiQs8teBic2flFP7XIyoPF4ZfToQzZLlqsbL3ZFF8Snl946xxsk25vIR/JY+dSOlY9z3fhCxBJym+KE36hDlPxmYSa2CDh4cjY6mO0p+AnaVhUlJ8eVQ/jrASljqX4jaG5wcbXGZMVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofyN8Z2W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofyN8Z2W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E9F1F000E9;
	Tue, 18 Aug 2026 15:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787065859;
	bh=j55WGrFm3m7ySyHMDxW6Ii9B0nrRzNoP4MbuSx4Yg2E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ofyN8Z2WcMvSYiXhopZdC+MMtasbwW6KWVhLlNVK4fVRBiEKgLpdUISb2S+LAVUH2
	 +az9YSEr+YaTS7WOaDpPIqcFHROtRKd8fO6ASep92dkBLcD/jXRV2eh4fgbcCdD5XP
	 4a8siG8hLdKb/jpANWwW+o+biekvdgVx9JVSr+leK+SdFa4m8mHAS65jOSTkgseaJZ
	 E5WH2+6WE9afwIfIwGiaejrTw3vYa1we88k7sXQcGZjqKMKO3znuE4j3RgIGZDkbUT
	 rVGakruZrT1ruOlLIEq+wbzj9c0EfVrELhoOzf7tOGMPog3ows8DhlH7v2mofsXoZt
	 ivZB8HFTP093w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 12/25] unwind_user/eh_frame: Remove
 .eh_frame[_hdr] section on detected corruption
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260818144954.2320378-13-jremus@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-13-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 15:10:58 +0000
Message-Id: <20260818151058.D6E9F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Lockless maple tree traversal races with concurrent in-place updat=
es due to missing MT_FLAGS_USE_RCU.
--

--- Patch [12]: [RFC PATCH v1 12/25] unwind_user/eh_frame: Remove .eh_frame=
[_hdr] section on detected corruption ---
commit 22bfd7679599379e32b650580760b87fb294aeb1
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user/eh_frame: Remove .eh_frame[_hdr] section on detected corruption

To avoid continued attempted use of a bad .eh_frame[_hdr] sections, remove
them on demand when the first sign of corruption is detected.
Based on Josh Poimboeuf's, Steven Rostedt's, and my unwind user sframe
implementation.

> diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c
> index 5ef8fef06a805..7657291324c06 100644
> --- a/kernel/unwind/eh_frame.c
> +++ b/kernel/unwind/eh_frame.c
> @@ -1149,6 +1149,15 @@ int eh_frame_find(unsigned long ip, struct unwind_=
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
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Could this introduce a race condition with concurrent lockless readers?

If multiple threads encounter a corrupted section concurrently, this will
trigger eh_frame_remove_section(), which eventually calls mtree_erase() on
mm->eh_frame_mt:

kernel/unwind/eh_frame.c:__eh_frame_remove_section() {
    ...
    if (!mtree_erase(&mm->eh_frame_mt, sec->text_start)) {
    ...
}

Because mm->eh_frame_mt is initialized in mm_init_eh_frame() without the
MT_FLAGS_USE_RCU flag:

kernel/fork.c:mm_init_eh_frame() {
    ...
    mt_init(&mm->eh_frame_mt);
    ...
}

mtree_erase() will modify the tree nodes in-place instead of using RCU-safe
copy-on-write.

Concurrently, eh_frame_find() performs a lockless traversal using mtree_loa=
d(),
which only relies on standard RCU for protection:

kernel/unwind/eh_frame.c:eh_frame_find() {
    ...
    sec =3D mtree_load(&mm->eh_frame_mt, ip);
    ...
}

Can concurrent readers observe torn state, freed nodes, or corrupted pivots
while the tree is being mutated in-place?

> +			dbg("eh_frame_remove_section() failed\n");
> +
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818144954.2320=
378-1-jremus@linux.ibm.com?part=3D12
