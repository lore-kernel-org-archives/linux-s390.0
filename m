Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4421E220698
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 02:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784859712; cv=none; b=W11E+OmBuYCdYnheIrG3I/o3sLCA6tOrMt4ws36P+5ComSuiqvUeRjdtidBpezKuLwzm5Q0yODMJWyEBt4jSnYQtLNjqxS5tuqPqoX44K1aEa8G4+DRpXCQcVhTfHE1//Qx45/iK2a92dyk+0ckREq/R/srKsVjtv6hJ7XTFGdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784859712; c=relaxed/simple;
	bh=OboCADr/cYTW3AjvfTOIrWo/aL06Vabud/mMoTOfrhw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GerCO+m6FiMBe3uyqsV5y1oZ1IanbjJjnff3UJTcNikqpJ1ZCPBnMvcEDgEtIw1DDli5OgaieJk2RmBB3u/4XXWu28+YOEYYW9IMFWycLEAJC7ZCTXeKd57mHoGULdXOXMpsBbql1Sat+JuaB0zaciofFN1exQO/6vaKZe5hEys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwGXU2eQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwGXU2eQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D811F000E9;
	Fri, 24 Jul 2026 02:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784859711;
	bh=ooaZUfFPOeO0uRnXwZlSY9wVS4Etgmwvm6Gms3lOG2Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QwGXU2eQ5rmy+22ccPUITxA5wryucDL6vwE8H4q37how/Ug093aO+7ih/xLedp0d5
	 iJFxuw2wRB8+i3FISzcjNS1hdfyG4J3VwH4CHt5syloIsvjaB+otyocO8kEyh3cOuY
	 +K2B6pSsJ1qbwX8Pi/70gNJJ4qXhsG34uDhly72oI2Kn+lO9mAnUv9SiQ9Ob2QEMG4
	 homWX8Xl4OlveEGsYOk8ZSNwwKRc7uFFL/fw/28hEvRrRiyP/qFOrk43d/abvPH0ll
	 MD5zIaDJY+F5c+nvHZ3RY1WOPuzTf0F6Km4x8f+z2ZzBqSdUte5R7wn2rRrCdHW0F9
	 a+GYIdfHaWgZA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 2/3] btrfs: Allow error injection on
 btrfs_data_csum_ok
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Chen" <chensong_2000@126.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260724021229.47302-3-chensong_2000@126.com>
References: <20260724021229.47302-1-chensong_2000@126.com>
 <20260724021229.47302-3-chensong_2000@126.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 02:21:50 +0000
Message-Id: <20260724022150.D2D811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The error injection completely bypasses the error reporting and =
notification logic it is intended to test.
--

--- Patch [2]: [RFC PATCH v2 2/3] btrfs: Allow error injection on btrfs_dat=
a_csum_ok ---
commit 1a83f56a9eedee07c1baca182513e1a6c13386dd
Author: Song Chen <chensong_2000@126.com>

btrfs: Allow error injection on btrfs_data_csum_ok

This patch marks btrfs_data_csum_ok with ALLOW_ERROR_INJECTION to allow the
fail_function infrastructure to simulate checksum mismatches. The intent is
to validate error detection and reporting paths in a controlled environment.

> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
[ ... ]
> @@ -3397,6 +3397,7 @@ bool btrfs_data_csum_ok(struct btrfs_bio *bbio, str=
uct btrfs_device *dev,
>  		memzero_page(phys_to_page(paddrs[i]), offset_in_page(paddrs[i]), step);
>  	return false;
>  }
> +ALLOW_ERROR_INJECTION(btrfs_data_csum_ok, FALSE);

[Severity: Medium]
Does this bypass the error reporting logic it is intended to test?

The commit message states: "Testing the error handling path that responds
to such corruption, including any warning output and uspace notification..."

However, when fail_function overrides a function marked with
ALLOW_ERROR_INJECTION, it forces an immediate return without executing any
of the function body.=20

This means the actual error reporting section inside btrfs_data_csum_ok()
is entirely skipped:

fs/btrfs/inode.c:btrfs_data_csum_ok() {
    [ ... ]
zeroit:
	btrfs_print_data_csum_error(inode, file_offset, csum, csum_expected,
				    bbio->mirror_num);
	if (dev)
		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_CORRUPTION_ERRS);
    [ ... ]
}

Since the injected error causes the function to return false before this co=
de
is reached, won't this skip the exact warning output and device stat
increments the patch is trying to validate?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724021229.4730=
2-1-chensong_2000@126.com?part=3D2
