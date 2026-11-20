Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795206229;
	b=LhVmU/sOeBulyENbtxXp7iFR4/mvuIbUVipMO1UUQ0mOYCHtdNZnH64fA92+388b9zsm
	 0TYLCM1sZ5CFAryKWfwWygw3IxRj/htJykfjPfmz+HQa4rzCGmFMTZScmDNsE1Ker19ET
	 hxdFWCrNWzeFYc6x+N+trQYaYbWMHWkxNRyOK6inhNeZ/wlsfjqU54P3bML3yShFOLcMj
	 +iaWLj5CpBIi8sojQEmfnKkuNh/LMD1D9fM2uGigFGsYirnWfcoLWkjv+YFrWal0xylp5
	 Woke2U45CUriKAvS+3A+KFH/uMm9YWiThlJguwi2qFVKPDVkFE6skBTZJ0cFZtNvaIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795206229;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=m7+6zrMxeiS17890kA969H+H6NuDtTTgoFJXWPPZp/0=;
	b=m1PTD8GMv/rhvmSLSwbpFmxqy5J7cfC8+iZdp3SivbOfPtAKsnzZSB2Bqcw0qw6jqbpw
	 sV70Ga0eLXurc4mLRBU0gu65TVr49sP/T5Qq7zL2BKTvC6dQiARxz+uUIVZdfxjVDBMbB
	 1M0zs8nbKhpExldHWSQ/v7PDbN3UFl++Op/2jxPu5JIrLoKt/A8nbPUbqbWBikSwM1I92
	 5DDC/O7OrptO22bArohgiCgD6ni3sfAQjf2DG5wUMQs1Ud0YELy38PoaeCH+ymRwcuMp0
	 D2e2QVVuXxTnQKkzauMem2+/cpPLk7SPFl9D0af+rwZvAktbLWkULdQ9hgvwlIntCvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LoFYeBBc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516A1606A6E6;
	Fri, 20 Nov 2026 20:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LoFYeBBc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3961F000D0;
	Fri, 20 Nov 2026 20:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795206228;
	bh=m7+6zrMxeiS17890kA969H+H6NuDtTTgoFJXWPPZp/0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LoFYeBBcqj3fyQy7yNH68YvF7N7B+hrmS3PnP4bpA3dnGBZCg5zMrVuRrQsfivZLS
	 zUNt56QxCl57KpsWow1UkpudvG29/u1XsYLbV8ouii4HWqAFDhLwhunXYch7umS0pW
	 Wwuqv0WnshDTdkE0EWZJ6ZM4of8eNH1R+eSPV4RzlbdexGYUnd1MRBJMjJwsqrNVIB
	 lVTQ1C2rZgScHaa0uL1SYaYsh3qgj2fJGbEIOAKW0wl8RY7TgJkygBw6tXI5BHzvLw
	 2d7hh6eqzE/VvK5T2ZGtNhKppKKBXFWVCfaMgkPa10B48KF9IKIkXE6Yfp5IoBGgE6
	 ujK//RFcjiFJw==
Message-ID: <sashiko-outbox-226058@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 00/16] syscalls: Add a shared table for all archs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261119-tonyk-syscall_table-v10-0-a7c9ebd900f6@igalia.com>
References: <20261119-tonyk-syscall_table-v10-0-a7c9ebd900f6@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 20:23:47 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 16-patch series:

- Patches 1, 3-11, and 13-15: no issues found.
- Patch 2 ("syscalls: Create unified partial table for all archs"): 1
  potential issue (1 Low)
- Patch 12 ("syscalls: Avoid matching substrings in the ABI parsing"): 1
  potential issue (1 High)
- Patch 16 ("perf: Synchronize syscall tables with shared table"): 1
  potential issue (1 Low)

Detailed reviews have been sent as separate replies to patches 2, 12,
and 16.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-tonyk-sysc=
all_table-v10-0-a7c9ebd900f6@igalia.com
