Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FA941D234
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 17:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786557059; cv=none; b=TGaj5fkKgirovyYMZykdgHq7CP+456FlPe7OplfvCf8HLOafvHQ1NV/MY0ob+cMG1wJQYV2viaWGlpHECFv/tPiASPausNb8iL2wrZkgdbrWsZgU+73LjLjYU5mAgC/feyPKs4yeV/Ns72zhqdNc73pE9PghEOpEp2+hMlovCUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786557059; c=relaxed/simple;
	bh=etdWD/lAxEWi6O4GkhGGKvJpmKvVkav4aDjtNk6irlk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pEfIreISXxzEw8jD8hGGgGNaaJUtmCbVen7E7wGY5nyQSZA4f4MgV21cHnvoq2w/ArOmuePCgzrNDUleSppmrLlbr2e7zYazXdNSqZaoIqFw4GBEqmUMGtik2NXws4HozAx6VO1CeHQxaLH4Z5cGb+COFKWrO00+Wgip9jxA03I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxvs9Wv7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxvs9Wv7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE7A1F000E9;
	Wed, 12 Aug 2026 17:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786557058;
	bh=IAdlst117qZBWK1XzWgMH+ua+eNs9iDFhJkykdJelxw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jxvs9Wv7spV+rtGdymXA6NgxJ9FSpkN7CxEayCJt9mLueji7rTdSPZHj+1ik04XF0
	 V4CXWMCNnZSujzSxfpFtPrKwafncMq24ZPTFo/4zSiPcKsiPYtyH1gx9eDVZ6j4SLm
	 /U79Gj3tnFOVJpgn0j/2jHt9eU1MvTdP171fwfx7syfrAo7gSfMJydASLHyFbyRhda
	 2F5OMJiCMOpnsVJhPWKqQt9Pwlt462vIboo2DRd2wKE3/2xuXIJYhSe/FBOTIrt2aS
	 4aSrUOhSbrVc/dU/+sg1M4Hk4r/bH4Mhrih90OgGmAvJoC4srP7tQwmSz07ySSRX9m
	 L/F8Fs1Q42p/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/13] s390: Use the common syscall table
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.vom>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260812-tonyk-syscall_table-v5-5-3d383927c609@igalia.com>
References: <20260812-tonyk-syscall_table-v5-0-3d383927c609@igalia.com>
 <20260812-tonyk-syscall_table-v5-5-3d383927c609@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 17:50:57 +0000
Message-Id: <20260812175057.ACE7A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Truncation of the s390 syscall table breaks perf tooling synchro=
nization and `perf trace` syscall resolution.
--

--- Patch [5]: [PATCH v5 05/13] s390: Use the common syscall table ---
commit 14ffb6f547173922da170d7387b0125457d5de1c
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

s390: Use the common syscall table

This commit removes duplicated syscall entries from the s390 syscall table =
by
falling back to the common syscall number table.

> diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/sys=
calls/syscall.tbl
> index 09a7ef04d9791..ce6d15260dd1b 100644
> --- a/arch/s390/kernel/syscalls/syscall.tbl
> +++ b/arch/s390/kernel/syscalls/syscall.tbl
[ ... ]
> @@ -350,51 +350,3 @@
>  400	common	msgsnd				sys_msgsnd
>  401	common	msgrcv				sys_msgrcv
>  402	common	msgctl				sys_msgctl
> -424	common	pidfd_send_signal		sys_pidfd_send_signal
> -425	common	io_uring_setup			sys_io_uring_setup

[Severity: Medium]
Will truncating these syscalls from the s390 table break perf tooling when
the tables are synchronized?

Currently, tools/perf/trace/beauty/syscalltbl.sh relies on the arch-specific
table to generate its syscall resolution. Because that script hasn't been
updated to parse scripts/syscall_common.tbl, it looks like a subsequent sync
of this file into the tools/perf tree will cause perf trace to silently lose
the ability to resolve syscalls 424 and above on s390.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-tonyk-sysc=
all_table-v5-0-3d383927c609@igalia.com?part=3D5
