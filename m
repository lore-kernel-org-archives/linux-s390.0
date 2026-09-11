Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8EB33F8C4;
	Fri, 11 Sep 2026 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137881; cv=none; b=Ylqgp6aQEfrtxd9mjV2oELiF9tJ7iKelcGCT2zYwreXjIjFrqmDHGF8mEXfvzpnZ/oQ85tJYbJbm0oY/gPxYhWiXG0pIIul/7yEYPlXts6WHDolwdhXkxWjVm4UzdeqA0Jdqn2zW4e6cN16bxmiVQ68hw6XH9S3ATQZkoQRYxYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137881; c=relaxed/simple;
	bh=2AJJko8U+J4dHmDdkiEzUD4h6o4OYqK+VdwHAHnxHps=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gfwQtUVzzOOkc7DA8dYP+N4EpH1YuEE1/P+hyOGA3+40nI8/2ku32zz/ys2pEIZKHopDAlnmL/W0NFEPkjsS4FHlsApfLfPfTAiphVq458o8B05sKVj5NzOSf7aYxuQ+nU1Ntmyn28i5+vJaBjz6rbpZM4W7yjynQu5LutmiEYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7O2BKxT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7O2BKxT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBAB1F000FF;
	Fri, 11 Sep 2026 14:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789137880;
	bh=RW00a056kkhFpknuKkHeqhqBXN2wJvagsD5q+JZFl6I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C7O2BKxTjps08h3p1g2/RKx9mx/grIJm8t70lwJBwQRY8/tlCgCD5DIZ0mqyIh25F
	 Yo3Pz0DCX9VDi7JiOs7qf0gg4seD4QGqMzrAJ9fkJEVwKx8AQoXxHlPVwgf//B4rMH
	 cKEnudIsizLex9KMtn4AissEbKKSSZEg/myoEQKmO7XYyDcRW+oEzuho2nCBGbNkYt
	 xmwpyUWssDH3HkfFDYp7K9AQOHmhWoGXS6vsMxQgiX62iU2WKaqCPRW3OHXBf4mR6k
	 jTR3ZveO+Q3j/iou5qDX+ZlVNb67dDmDKw5YXKf4ukbW01gi32M6vYnIT7Eo+S55y6
	 xCgrUz7Ry7P8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] x86: Avoid indirect includes through
 linux/module.h -> linux/elf.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, linux-modules@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260911-module-include-elf-v2-1-954c732975fb@suse.com>
References: <20260911-module-include-elf-v2-0-954c732975fb@suse.com>
 <20260911-module-include-elf-v2-1-954c732975fb@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 14:44:39 +0000
Message-Id: <20260911144439.9BBAB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Several x86 files use ELF-related declarations and currently rely on them
> being provided indirectly through linux/module.h -> linux/elf.h:
>=20
> * arch/x86/entry/entry_fred.c: ia32_enabled() -> asm/ia32.h,
> * arch/x86/entry/syscall_32.c: vdso32_image -> asm/vdso.h,
> * arch/x86/kernel/cpu/intel.c: ELF_HWCAP2 -> asm/elf.h,
> * arch/x86/kernel/fpu/xstate.c: elf_coredump_extra_notes_write(),
>   elf_coredump_extra_notes_size(), NT_X86_XSAVE_LAYOUT, elf_note ->
>   linux/elf.h,
> * arch/x86/kernel/process.c: mmap_is_ia32() -> asm/elf.h,
> * arch/x86/kernel/signal.c: get_sigframe_size() -> asm/elf.h.
>=20
> Add the missing includes to these files in preparation for removing the
> linux/elf.h include from linux/module.h.
>=20
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-module-inc=
lude-elf-v2-0-954c732975fb@suse.com?part=3D1

