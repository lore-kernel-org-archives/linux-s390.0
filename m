Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C83F3B0599;
	Tue, 18 Aug 2026 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065731; cv=none; b=oXv1wLXf7WAQ9R9S1ZqLM7zKQE4yIBX2MjOX4+q83VRwZ+w2AG5qK6YrHvWAlXaqs5a0wTNqW5/QuOTlCWPuE7JpdIOQldS6on9SxSdCtF/AU+tTTU60OVYz0RIrEKTVMHsM9CDLXSOUjR8w8uFB88B52KIKt+y440AH5JFwnhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065731; c=relaxed/simple;
	bh=ZQO+tmSJRF/cfIOpQCVJW+VYk7APFaH2uGAGochVPyI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uRVdW7B+ANb/BJg3kLEh59WWRRR6+S+tvxyBRzcVotB9EJ9uhzs0IoKSyk61/VHlMyTPpeNw3/SeAbjEaBulpUZQBCtKC/Hvk8W30ccFkxVp3s9xFr4deldcAdG7v8GzW0lwbvi4GvVjRbK6C/UzUpbOObAO8Szc/TpCR8RbKHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIDv3hSD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIDv3hSD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293061F000E9;
	Tue, 18 Aug 2026 15:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787065729;
	bh=3dP2Bm0HE/NmPkz68RG6jMp9ELNy7vpGwo2TeAyMW3o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eIDv3hSDWJ/QDjDOZNBQIJGK2lSrZL9XW5Oxk9i9x7lhs+sjo6pqMO2LwA9FrQ0ae
	 Smkkv7myJZcdF8Tbt3h5IeXCDP8xUj0q5I3aZ1ymg43BfjPs3UccLx0AeD8L7W04+d
	 EjzT/0bSCWsnY2jwwMfKZp0Fi/qFI6DnbG0hHIEHBPj5gYNFYcCPsBo6NiY7Jd7oJE
	 9fXXrjUngtHeUmP4PqwT2HfIaPOaAUGA9pGNqyHEXWAM4BIjMIoYLDP4g1Y72WkuT1
	 L8yaEg0iycD6+JqqJcXSGWsH3Yy5NaT7EgfrTdcAiEu4F9w5DLc05JPedX6HLpH7uI
	 0yJqV0ZKgsV4Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 08/25] unwind_user/eh_frame: Store .eh_frame_hdr
 section data in per-mm maple tree
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260818144954.2320378-9-jremus@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-9-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 15:08:48 +0000
Message-Id: <20260818150849.293061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] The `eh_frame_mt` maple tree is initialized without `MT_FLAGS_=
USE_RCU`, causing internal nodes to be synchronously freed, which crashes c=
oncurrent lockless readers.
- [High] fork() fails to inherit .eh_frame_hdr registrations, breaking unwi=
nding for child processes.
- [High] A TOCTOU race condition in `eh_frame_remove_section` allows a doub=
le-free of one section and a memory leak of another.
- [High] An integer overflow in `table_end` calculation allows maliciously =
crafted `.eh_frame_hdr` sections to bypass bounds checking.
- [Low] Appending INIT_MM_EH_FRAME in init_mm causes a missing comma syntax=
 error on multiple architectures.
--

--- Patch [8]: [RFC PATCH v1 08/25] unwind_user/eh_frame: Store .eh_frame_h=
dr section data in per-mm maple tree ---
commit bd68e8b201de54350859df41e271e507dd497773
Author: Jens Remus <jremus@linux.ibm.com>
Subject: unwind_user/eh_frame: Store .eh_frame_hdr section data in per-mm m=
aple tree

This commit associates .eh_frame_hdr sections with their mm by adding them =
to
a per-mm maple tree which is indexed by the corresponding text address
range. A single .eh_frame_hdr section can be associated with multiple
text ranges.

> diff --git a/include/linux/eh_frame.h b/include/linux/eh_frame.h
> --- a/include/linux/eh_frame.h
> +++ b/include/linux/eh_frame.h
[ ... ]
> @@ -19,14 +24,27 @@ struct eh_frame_section {
>  	u8		binary_search_table_enc;
>  };
> =20
> +#define INIT_MM_EH_FRAME .eh_frame_mt =3D MTREE_INIT(eh_frame_mt, 0),

[Severity: Critical]
Is the MT_FLAGS_USE_RCU flag required here?

Since readers are locklessly iterating the tree using mt_for_each() (which
relies on rcu_read_lock()), omitting MT_FLAGS_USE_RCU causes concurrent
mtree_erase() or mtree_insert_range() to synchronously free internal nodes =
via
kfree() instead of kfree_rcu(). Can this cause a use-after-free for the
concurrent readers?

> +extern void eh_frame_free_mm(struct mm_struct *mm);
> +
>  extern int eh_frame_add_section(unsigned long eh_frame_hdr_start,
[ ... ]
> diff --git a/kernel/fork.c b/kernel/fork.c
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
[ ... ]
> @@ -1082,6 +1084,13 @@ static void mmap_init_lock(struct mm_struct *mm)
>  #endif
>  }
> =20
> +static void mm_init_eh_frame(struct mm_struct *mm)
> +{
> +#ifdef CONFIG_HAVE_UNWIND_USER_EH_FRAME
> +	mt_init(&mm->eh_frame_mt);

[Severity: Critical]
Should this use mt_init_flags() with MT_FLAGS_USE_RCU?

Similar to the INIT_MM_EH_FRAME macro, initializing without RCU could lead =
to
a use-after-free if internal maple tree nodes are freed while lockless read=
ers
are iterating.

[Severity: High]
Does fork() fail to inherit .eh_frame_hdr registrations?

A process that registers unwinding information and then calls fork() will h=
ave
its VMAs copied in dup_mmap(), but the child receives this empty maple tree
without any copied eh_frame_mt entries. Will this break stack unwinding for
the child process?

> +#endif
> +}
> +
>  static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struc=
t *p)
[ ... ]
> diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c
> --- a/kernel/unwind/eh_frame.c
> +++ b/kernel/unwind/eh_frame.c
[ ... ]
> +static int __eh_frame_remove_section(struct mm_struct *mm,
> +				     struct eh_frame_section *sec)
> +{
> +	if (!mtree_erase(&mm->eh_frame_mt, sec->text_start)) {
> +		dbg("mtree_erase failed: text=3D%lx\n", sec->text_start);
> +		return -EINVAL;
> +	}
> +
> +	call_srcu(&eh_frame_srcu, &sec->rcu, eh_frame_free_srcu);
> +
> +	return 0;
> +}
> +
>  int eh_frame_remove_section(unsigned long eh_frame_hdr_start)
>  {
> -	return -ENOSYS;
> +	struct mm_struct *mm =3D current->mm;
> +	struct eh_frame_section *sec;
> +	unsigned long index =3D 0;
> +	bool found =3D false;
> +	int ret =3D 0;
> +
> +	guard(srcu)(&eh_frame_srcu);
> +
> +	mt_for_each(&mm->eh_frame_mt, sec, index, ULONG_MAX) {
> +		if (sec->eh_frame_hdr_start =3D=3D eh_frame_hdr_start) {
> +			found =3D true;
> +			ret |=3D __eh_frame_remove_section(mm, sec);
> +		}
> +	}

[Severity: High]
Can this mtree_erase() and call_srcu() sequence race with another thread and
cause a double-free?

If Thread A locklessly iterates and finds sec1 in mt_for_each(), and Thread=
 B
concurrently removes sec1, Thread C could map a new section sec2 at the same
text_start address.

When Thread A calls __eh_frame_remove_section(mm, sec1), mtree_erase() would
successfully remove and return sec2. However, Thread A then passes the
original sec1 pointer to call_srcu(), double-freeing sec1 and leaking sec2.

[ ... ]
> diff --git a/mm/init-mm.c b/mm/init-mm.c
> --- a/mm/init-mm.c
> +++ b/mm/init-mm.c
> @@ -48,6 +49,7 @@ struct mm_struct init_mm =3D {
>  #endif
>  	.flexible_array	=3D MM_STRUCT_FLEXIBLE_ARRAY_INIT,
>  	INIT_MM_CONTEXT(init_mm)
> +	INIT_MM_EH_FRAME
>  };

[Severity: Low]
Does appending INIT_MM_EH_FRAME here cause a missing comma syntax error on
some architectures?

While x86's INIT_MM_CONTEXT was updated to include a trailing comma in this
patch, other architectures (like UML or PowerPC Book3s 32-bit) may lack this
trailing comma in their INIT_MM_CONTEXT definitions, breaking the build.


In a related function, eh_frame_read_header() contains a potential overflow:

kernel/unwind/eh_frame.c:eh_frame_read_header() {
    ...
		table_end =3D table_start + fde_count * entry_size;
		if (table_end > sec->eh_frame_hdr_end)
			return -EINVAL;
    ...
}

[Severity: High]
Can this arithmetic multiplication overflow and bypass the bounds check?

If a malicious .eh_frame_hdr provides an artificially large fde_count,
fde_count * entry_size could overflow the unsigned long capacity, wrapping
around to a small value. This would bypass the bounds check and allow
out-of-bounds reads during later unwinding binary searches.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818144954.2320=
378-1-jremus@linux.ibm.com?part=3D8
