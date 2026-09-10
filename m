Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0E6389452
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 11:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038109; cv=none; b=LGs8JDrE+4LkxJJF7bLamNklyox8yd7LeLIEVWGD7MkkK0DHtuDjjzcVZBDQ88XZP1QZHL98WtTzXNK5g3Oe9QqdBX55vjJRMdShw3VYcmhw2yJayLR7pRi2hW16PJNN8fVdiyLlmgqDBXfr+cLhxnFtJb7BinteBHVyG/x9nGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038109; c=relaxed/simple;
	bh=Rbu6rZjYoGBonaGOJnt2Qi00jMeLTBEGlUn3aigqG4k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tWrXeZFvBoqtCv/rJQA9Gsh+jn7q8E2aMAwPH2l9OzdXP/K4LVFrfW+nLcrkuTFFRsOTeGEmSUCWZL54DAtBcTHvj9UpHp8VeZ0LiItRXFnQa1YLkYUIar2SZX/w2STnDbbnTzz3E+9/tzm3jcFoePoJ0OP9vwFuYMEXCzE9RoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZLrvkWP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZLrvkWP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E851F000FF;
	Thu, 10 Sep 2026 11:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038108;
	bh=MjSP+cTREgCNLqyz0DN03UyxsYp/s1zDWmpn7EH64c4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BZLrvkWPx3BeKX9nLdlRX5wBLaNjJLxnk5Ntvd7e3r7NN1wpUyrDpKb42DEjdvoaX
	 H5z+rclrMTQI8gV+HxY/fzIz9b4LUyAqNyIWQcQNTp7sA1Z2O76u4qwNUPWMzZO3ef
	 a/BfYAdJpxbdYAe+qWORP+AzeGjfit7DpmupqwKWnbVzsWfghzWWJGvcA5dvhTY2CI
	 gUpn1GVeEspLPVinEkS2VBXymOUlqvY6ldJ9BOF85oEyxDBljVs2zNEXY3UqR5Jcfh
	 gjV6hdKpqUx4FMZ59afyGpkPr7mUV6NDEbJnjzsG/RAZxThPjoP4+yZ9JxgDrLJkPr
	 d+SWic8pID1JQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/debug: Reset pages_per_area and nr_areas when
 static registration fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikhail Zaslonko" <zaslonko@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260910104525.3788362-1-zaslonko@linux.ibm.com>
References: <20260910104525.3788362-1-zaslonko@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 11:01:47 +0000
Message-Id: <20260910110147.96E851F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Setting `nr_areas =3D 0` on the error path exposes a `ZERO_SIZE_PT=
R` dereference in `debug_to_act_entry()` if `debug_dump()` is called with `=
reverse =3D true`.

Pre-existing issues:
- [High] debug_dump() does not check if the provided `id` is NULL before pr=
ocessing, leading to a kernel panic if a dynamic debug feature fails to reg=
ister.
- [High] A TOCTOU race condition exists between tracing event functions (li=
ke `debug_event_common()`) and the error path of `debug_register_static()`.=
 If `debug_register_static()` fails, this race results in a NULL pointer de=
reference.
--

commit e3103537d5e7bf2aad3e77c036a8ee844699d72c
Author: Mikhail Zaslonko <zaslonko@linux.ibm.com>

s390/debug: Reset pages_per_area and nr_areas when static registration fails

This patch addresses an invariant mismatch on the error path of
debug_register_static(). It sets pages_per_area and nr_areas to zero to
match the behavior where a NULL areas pointer implies zero bounds.

Closes: https://sashiko.dev/#/patchset/20260903130733.709001-1-zaslonko@lin=
ux.ibm.com?part=3D3

> diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
> index 14d2b58ad0930..0a48748bea267 100644
> --- a/arch/s390/kernel/debug.c
> +++ b/arch/s390/kernel/debug.c
> @@ -971,6 +971,8 @@ void debug_register_static(debug_info_t *id, int page=
s_per_area, int nr_areas)
>  		id->areas =3D NULL;
>  		id->active_pages =3D NULL;
>  		id->active_entries =3D NULL;

[Severity: High]
This is a pre-existing issue, but there is a race condition between tracing
event functions (like debug_event_common()) and the error path of
debug_register_static().

If debug_register_static() fails, this race results in a NULL pointer
dereference:

arch/s390/kernel/debug.c:debug_event_common() {
	if (!debug_active || !id->areas)
		return NULL;
...
	} else {
		raw_spin_lock_irqsave(&id->lock, flags);
	}
	do {
		active =3D get_active_entry(id);

If the lockless check in debug_event_common() passes before
debug_register_static() nullifies id->areas, debug_event_common() will wait
on the lock.

Once debug_register_static() releases the lock, debug_event_common() gets
the lock and calls get_active_entry(id) without re-checking id->areas. This
dereferences id->areas[id->active_area] (now NULL) and panics the kernel.

Can id->areas be re-checked inside the lock before calling
get_active_entry(id)?

> +		id->nr_areas =3D 0;
> +		id->pages_per_area =3D 0;

[Severity: High]
Does setting id->nr_areas to 0 expose a ZERO_SIZE_PTR dereference on
snap_id->active_pages?

If debug_dump(..., reverse =3D true) is later called on this static trace, =
it
copies the debug info by calling debug_info_alloc() with nr_areas =3D 0.
This allocates a ZERO_SIZE_PTR (address 0x10) for active_pages.

When debug_dump() iterates backwards, it calls debug_prev_entry(). This
checks if (p_info->act_entry =3D=3D DEBUG_PROLOG_ENTRY) and immediately cal=
ls
debug_to_act_entry() before verifying if (!id->areas):

arch/s390/kernel/debug.c:debug_prev_entry() {
	if (p_info->act_entry =3D=3D DEBUG_PROLOG_ENTRY)
		debug_to_act_entry(p_info);
	if (!id->areas)
		return false;

debug_to_act_entry() then reads snap_id->active_pages[snap_id->active_area],
dereferencing the unmapped ZERO_SIZE_PTR and panicking the kernel.

>  		raw_spin_unlock_irqrestore(&id->lock, flags);
> =20
>  		return;

[Severity: High]
This isn't a bug introduced by this patch, but debug_dump() does not check
if the provided id pointer is NULL before processing.

If a dynamic debug feature fails to register during initialization (e.g., in
PCI), the debug ID pointer remains NULL. Subsystems may then call
debug_dump() (e.g., zpci_report_status()) with this NULL pointer on their
error reporting path.

debug_dump() passes this NULL pointer directly to debug_file_private_alloc(=
):

arch/s390/kernel/debug.c:debug_dump() {
...
	p_info =3D debug_file_private_alloc(id, view);

debug_file_private_alloc() then passes it to debug_info_copy(), which
unconditionally dereferences in->name:

arch/s390/kernel/debug.c:debug_info_copy() {
...
		rc =3D debug_info_alloc(in->name, in->pages_per_area,
			in->nr_areas, in->buf_size, in->level, mode);

Can we add a NULL check for the id pointer at the start of debug_dump() to
prevent this panic on the error path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910104525.3788=
362-1-zaslonko@linux.ibm.com?part=3D1
