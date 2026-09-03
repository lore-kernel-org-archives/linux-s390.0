Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4E54AD4B3
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 13:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441690; cv=none; b=V/MmLDf4gh2v3XtEIi06TVAcnVa6AXOqzd3pPZvitJrp5KZ6YwhxoUcprIkovkFAi2gdyeCqclcD+SDthTq/zjmspl6kkF1LN8KiQN/3UF1hEFynYT2PKdfYr2hOZ/+dtNrtsaiObrCUFLiHCydXOWUp9ig48yJ8XpoMo2oIrHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441690; c=relaxed/simple;
	bh=lXu3CflzNnKMuBE2mtx1dCzsQL0tJXmQWpAma2mTgeo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I1HOT7U1QdU5zP9GpGEWWuMlSDuvVwHlFxnt16buykDv8IsRvmQ6oEXY2l0VusCRDBLi48/BhiKLFxpAEkW8QemAFEd3aqnwAJFBdaEEfG32tFISbZO3GhgPdIDIt02seSc/EgnTNNJoL/6X3Oz01DdvzsLaTNERK7ib2Hq8qA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpVoRCyP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpVoRCyP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F271F00A3F;
	Thu,  3 Sep 2026 13:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788441683;
	bh=rWeNrN5Anhnhz7fYTDKOJtf9DCG6PyvtshEPWzqMJ6I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CpVoRCyPpOsYh+aU1MlC93erH7vk5CriAEZyJGB4V1Ehl0PQAjhTH7eZU1EMABQXG
	 ZAg2eD0mJmErTEZ9hgP0P12BVG3JCKKgpzMFtb6lXpiqcZTYcHoI/3Dp7io2CZRNbH
	 fXvVTsXeJvwr910eVAas+A9LCxCqto7Zf4Mzn17fQHizkhsI2INA/CbVryvZA5u7KW
	 IsWAOZvBXJQkoQE/VzDRJHFKfVNgLdWldHuzv/x2MmrKGh+vpbsVeIf4XHRO3jVTkr
	 l7krmtJBxKH5aGfBXb8uvJb4YSSqM9QQUWrD/fJ7X9GR3jBJ7UgrP8Rozfz5VbVzYG
	 i/8wxW6qI+4Rg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] s390/debug: Fix race between debug area resize
 and event logging
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikhail Zaslonko" <zaslonko@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260903130733.709001-4-zaslonko@linux.ibm.com>
References: <20260903130733.709001-1-zaslonko@linux.ibm.com>
 <20260903130733.709001-4-zaslonko@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 13:21:22 +0000
Message-Id: <20260903132123.12F271F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Preexisting NULL pointer dereference in debug_info_copy() if debug=
_register_static() fails to allocate memory.
--

commit 1749ca122b22e4769c7efc7f4a52046777b678ef
Author: Mikhail Zaslonko <zaslonko@linux.ibm.com>

s390/debug: Fix race between debug area resize and event logging

Trace functions check for non-NULL id->areas without lock to minimize
overhead. This opens a race window where a NULL pointer dereference
occurs if id->areas is set to NULL after the check and before id->lock
is taken. This commit fixes the race by rechecking id->areas under lock.

> diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
> index cf411f203571b..b5bf8284dbfc8 100644
> --- a/arch/s390/kernel/debug.c
> +++ b/arch/s390/kernel/debug.c
[ ... ]
> @@ -1663,9 +1673,11 @@ static void debug_flush(debug_info_t *id, int area)
>  	unsigned long flags;
>  	int i, j;
> =20
> -	if (!id || !id->areas)
> +	if (!id)
>  		return;
>  	raw_spin_lock_irqsave(&id->lock, flags);
> +	if (!id->areas)
> +		goto out;

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential NULL
pointer dereference in debug_info_copy() if debug_register_static() fails
to allocate memory.

In arch/s390/kernel/debug.c:debug_register_static(), if the allocation fail=
s:

	if (!copy) {
		pr_err("Registering debug feature %s failed\n", id->name);

		/* Clear pointers to prevent tracing into released initdata. */
		raw_spin_lock_irqsave(&id->lock, flags);
		id->areas =3D NULL;
		id->active_pages =3D NULL;
		id->active_entries =3D NULL;
		raw_spin_unlock_irqrestore(&id->lock, flags);

		return;
	}

This sets id->areas to NULL but leaves id->pages_per_area and id->nr_areas
with their original EARLY_PAGES and EARLY_AREAS values.

Later, if debug_info_copy() is called when a user accesses the exposed
debugfs file:

	for (i =3D 0; i < in->nr_areas; i++) {
		for (j =3D 0; j < in->pages_per_area; j++)
			memcpy(rc->areas[i][j], in->areas[i][j], PAGE_SIZE);

Will this cause a NULL pointer dereference when accessing in->areas[i][j]
since in->areas is NULL but the loop still executes based on in->nr_areas?
Should we reset id->pages_per_area and id->nr_areas to 0 on the error path
in debug_register_static(), or add a NULL check in debug_info_copy()?

>  	if (area =3D=3D DEBUG_FLUSH_ALL) {
>  		id->active_area =3D 0;
>  		memset(id->active_entries, 0, id->nr_areas * sizeof(int));
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903130733.7090=
01-1-zaslonko@linux.ibm.com?part=3D3
