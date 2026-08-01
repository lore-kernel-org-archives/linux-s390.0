Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E513BB681
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 18:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785608627; cv=none; b=oZ8bvLTE5pxe60nUuzEE7BDPnLrYbwezVW/107xYiOL+HuoBbjIHNnGeuUzMRwygD+biKd/RR+wqsMG6VPxslb+Zi3AoQO3Baq3nSuCbAJyeahvz2gbmCvILS8C+HyA4foUlzwwBkkww20LLQrPsHZmbHnl8i1gkWmNnquJzL5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785608627; c=relaxed/simple;
	bh=Fjz5gZRFqf8eDgihuu20nlJjJsWKiM2XjoxfVBvQt+g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dkD+oU1QbInOHYuWbsTIzS0O4+MWP7lPF2GpvZx16YpdvyHtrCxs7mvnX1kt9RjJSIhBDnGf6Fr1TwLEbTMa+ZV51vfY1Vo6BBrw6metvkpgxCvf3DmlfgSqz5bW8r+pWFhJQf9Pd10xK2KBSJZj4qCvwJmOBPjJJbv0gTxAei0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbVAfEpa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbVAfEpa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27EE51F00AC4;
	Sat,  1 Aug 2026 18:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785608626;
	bh=Fjz5gZRFqf8eDgihuu20nlJjJsWKiM2XjoxfVBvQt+g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TbVAfEpamiCXyBJPPSjjdyO7stVWbcmH6+MXMZxRh2WM3PRcti53vDS3QDl53GEG1
	 iAjvpxYKWTJ+Q9YiDdLBj7x4CGMfZfou2QrR2KjBAH9bLxNL8UNthARVN+lwS4z9yI
	 fay+VSDTbMhEh11vKIxQdvL+JzsadD/yolgXGGD44+pVXODDMik6yBXSC08RWXKPfr
	 Bueyepp+Aa4HLTfXYGFsdIwWqgnldVZHhWlB5q+deC4eHatA5jyApxvdjnoz+AlFwf
	 yAsuKr+meeQrB7ZUfHmVH3TPr+z/ERHIHxXT2weyrn/qOj9nsVWiqXLKHiZlssr6nh
	 yqa7KIi+WfS2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/19] s390/dasd: Add range-based format-track
 collision detection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260801180033.3679412-10-sth@linux.ibm.com>
References: <20260801180033.3679412-1-sth@linux.ibm.com>
 <20260801180033.3679412-10-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 18:23:45 +0000
Message-Id: <20260801182346.27EE51F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Removal of `trkcount` without an active replacement introduces=
 a TOCTOU race allowing double-formatting and silent data corruption.
- [High] The new `collision` check in `test_and_set_format_track()` is perf=
ormed outside `format_lock`, creating a TOCTOU race even when fully activat=
ed.
--

--- Patch [9]: [PATCH v7 09/19] s390/dasd: Add range-based format-track col=
lision detection ---
Note: The format of this report has been altered to a free-form summary due
to recitation restrictions preventing direct quoting of the patch diff.

commit 4fd0dd7f48bc14f4366f229841daa2dd1074fb30
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Add range-based format-track collision detection

This commit replaces the single per-device format_entry slot with an array
of 16 slots to allow multiple format requests in flight. It also introduces
range-based overlap checks and a new collision flag.

[Severity: Critical]
Does the removal of the trkcount check in test_and_set_format_track() in
drivers/s390/block/dasd_eckd.c introduce a window for silent data corruption
before the new collision mechanism is fully activated?

It appears that the old trkcount protection is removed, but the commit
message notes that the new collision check remains dormant until a later
patch routes the format requests through dasd_return_cqr_cb() in
drivers/s390/block/dasd.c. Currently, format requests still use
dasd_eckd_ese_format_cb(), meaning cqr->collision will not be set.

If a data request fails with an unformatted track error, initiates a format,
fails again, and is delayed in ERP, could a concurrent request format the
same track and write data to it? When the first request finally retries
test_and_set_format_track(), the format_list would be empty and the
collision flag would remain unset, potentially leading to a double-format
that erases the data written by the concurrent request.=20

Is there a way to keep the trkcount protection active until the new
mechanism is fully wired up?

[Severity: High]
Is there a race condition in test_and_set_format_track() in
drivers/s390/block/dasd_eckd.c even when the collision mechanism becomes
fully active?

The read of cqr->collision is performed locklessly before acquiring the
format_lock. If a thread reads the collision flag as false, and immediately
afterward a softirq completing a format sets it to true and removes the
track from format_list, the first thread will then acquire format_lock.
Finding the format_list empty, it would proceed to incorrectly format the
track again.

Should the check of cqr->collision be moved inside the format_lock section,
or re-evaluated inside, so that it is atomic with the inspection of the
format_list?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801180033.3679=
412-1-sth@linux.ibm.com?part=3D9
