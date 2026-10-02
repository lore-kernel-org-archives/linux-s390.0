Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3621F471414
	for <linux-s390@vger.kernel.org>; Fri,  2 Oct 2026 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932410; cv=none; b=s0wAmu54t4NTtdJiY3hMvDsAY3PUOy6+E6d+FIXeh8ZHoewA8iMtuG0UKurZ6cJ0dWQyLy4t3A7R8WGW8EgMOcbTfBLX61MKZrp8m9FKRPDD0z9yaBBzGd5psANeX9rOVF/2st8yotQixKnrIAq4sI9JpRL8Q0GPyr0C/b0BJm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932410; c=relaxed/simple;
	bh=qdleRCwd0SKO5d6vIPkSKABuhXnX/ooI1r9CfoJWLr4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UrvzZvz3KZug2vuq2ND5Fc0K6LJgmcAQyOStD/KDfj8m1uIMFJnfGGE2eyEVc14O8RSn8zpJEXrCTnIfLoGH9vNWWc9IifNypmH0JJC/3kuEiRFPq+5boSCAgr8TIZf3zkvixEmTyukjfzW9CHmzgUDNRh27QN0VMWMzKPFToQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyT5j5B6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyT5j5B6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C566D1F000FF;
	Fri,  2 Oct 2026 09:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932409;
	bh=qdleRCwd0SKO5d6vIPkSKABuhXnX/ooI1r9CfoJWLr4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VyT5j5B6/6kf7TixB6NUga7lOl/PpRfvO10HibohgIGgTkZzjHKNgBfAdHXrPmvL1
	 5OKhx6njqbhA5CXzrnxNw9mOnrLJdF2LKtP2hSNO7NMHIa0AIhIvwpgFr5qMH8YcTh
	 6C3aCxhsv8WzpDQrkExoNUyOJRGsHBP6sfX4NOUflAC8o20NPTB9VpXV2w++VPEz14
	 xRAswVh4ptyJpdsjSWRrJbSqG+1VRuyEwb0xDIyMKFZdVpdQWPPs/NTOF9nYCpfzTN
	 Vv7hSZUEbv3fg1EJ/LmeCSK0Jc+sitxRFsGREP3GBqKZxipeAYl5x5dRVMoz7JD6BW
	 x3GGEceXcdLCw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 12/13] sched/fair: Allocate nohz.idle_cpus_mask
 during sched_init_smp()
Reply-To: sashiko-reviews@lists.linux.dev
To: "K Prateek Nayak" <kprateek.nayak@amd.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261001192849.74788-13-kprateek.nayak@amd.com>
References: <20261001192849.74788-1-kprateek.nayak@amd.com>
 <20261001192849.74788-13-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:28 +0000
Message-Id: <20261002091328.C566D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> nohz.idle_cpus_mask is not required soon after early initialization
> since the boot CPU cannot go tickless idle before CPU is activated and
> tick is started.
>=20
> Defer allocation of nohz.idle_cpus_mask to sched_init_smp() via
> init_sched_fair_class_smp(). This is preparation to convert
> nohz.idle_cpus_mask to sparsebitmap (sbm) which requires architectures
> to finish smp_prepare before initializing the core bits.
>=20
> No functional changes intended.
>=20
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001192849.7478=
8-1-kprateek.nayak@amd.com?part=3D12

