Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501A1356773
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 11:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785584196; cv=none; b=Lsg+rEjBn5BcgdNS3sBsAiPBjmX8u/G12SuogO/GNZq/rVFMBjfpO5tCWWTDgBQwWCCIk3wd3noKU96Im5DEYsvNmB4jHNBe5t5VRD/Bihci3g2hU1NvKUywP0oWV2tAHcs502X0N4Y+LMPMY4AemZrpRvF14fEnVoXsUjP/udw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785584196; c=relaxed/simple;
	bh=35FdbKRqTkMjyRZI/8a5yJJA0+3EEpfDP1UNczZrYZw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b5KNMVQ4ejx0E5wL+EVOwuYBglI1Ouy2gGETc0xiU0nyeEJlb8Nilb8ZZfwgbnDJUNyV6V6U6pKMu2uU6n0UntHKF8APZWMnhPbmqe0hWucIhyb2K2y4JJo+Rt/ngUbTtAhVPhhCF7xkUWHnvhf/LUjykACZ8HxAd8U4IVbWBh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbyE4VoV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbyE4VoV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959421F00AC4;
	Sat,  1 Aug 2026 11:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785584194;
	bh=35FdbKRqTkMjyRZI/8a5yJJA0+3EEpfDP1UNczZrYZw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YbyE4VoV2R90oDg2oiIr3bK6W49V0eWN9MCouNjHq1vohYeN4uTN2zVHvka60XYDJ
	 IGAsf6ZUhHJOgK8PfWfe/YXLuLMLP4FMQsKaOn1lJ3Ltl9GA6EURXhW+yN+1GfuH+5
	 uAPVksnCjJvwFhKDy2MPFzxkqHGEP00Llkdh0Kgn3LEcpZr1JRhQb7O54YJlF8+Dvr
	 /m9zdnVXp5cmeS2QYjIGtS3MEaitWc/m2GyQkTWJ1HPAdKOM+6XwGqbaZMaeX9FiNW
	 WLG4egm4RBLx92Gmfq5nYHeHeCmtTqJZc9Vwpj3E3lYVENBIn6JjuwiTiec5BHevy5
	 38pRks0WVaaMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/18] s390/dasd: Add range-based format-track
 collision detection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260801111008.3391031-9-sth@linux.ibm.com>
References: <20260801111008.3391031-1-sth@linux.ibm.com>
 <20260801111008.3391031-9-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 11:36:34 +0000
Message-Id: <20260801113634.959421F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Premature removal of the `trkcount` check introduces a double-=
format vulnerability that breaks bisection and causes data corruption.
- [Low] Unsynchronized modification of `format->cqr` outside of `format_loc=
k` causes a data race.
--

--- Patch [8]: [PATCH v6 08/18] s390/dasd: Add range-based format-track col=
lision detection ---
Note: The format of this review has been altered to a free-form summary to
comply with system recitation restrictions. Standard diff quoting has been
omitted.

commit a04e5d02e092ddaf9f460306f01f82bfd4b72118
Author: Stefan Haberland <sth@linux.ibm.com>
s390/dasd: Add range-based format-track collision detection

This commit replaces the single format_entry with an array to support multi=
ple
in-flight format requests, and modifies conflict detection to use range
overlaps. It also removes the trkcount snapshot in dasd_start_IO().

[Severity: Critical]
In dasd_start_IO(), the snapshot of trkcount was removed, which previously
protected against delayed-interrupt races. In test_and_set_format_track(),
this was replaced with a scan of format_list.

However, because the new collision flag mechanism is dormant in this patch,
does this premature removal introduce a double-format vulnerability that br=
eaks
bisection?

If CPU 1 and CPU 2 both issue a WRITE to the same unallocated track, the
device fails both, generating two unformatted track interrupts. If CPU 1
processes its interrupt, formats the track, and retries its WRITE, it will
remove the track from format_list. If CPU 2 is delayed and processes its
interrupt after CPU 1s format completes, it calls test_and_set_format_track=
().

Since the track is no longer in format_list and the new collision mechanism=
 is
inactive, CPU 2 will not detect the collision and will issue a second forma=
t,
potentially erasing CPU 1s freshly written data.

[Severity: Low]
In dasd_eckd_ese_format(), there is an assignment format->cqr =3D fcqr which
occurs outside of the format_lock.

Concurrently, in test_and_set_format_track(), a reader checks
device->format_entry[i].cqr while holding the lock.

Does this unsynchronized modification cause a data race on a shared pointer?
While it might not cause a crash since the pointer transitions from one val=
id
non-NULL pointer to another, it appears to violate kernel concurrency rules.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801111008.3391=
031-1-sth@linux.ibm.com?part=3D8
