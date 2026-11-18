Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795014107;
	b=ljreU0UVsSNIQJa7u/t04DjvYkTRo5rAX/Gz2oW0mHghgaPLed+XJ0WEhs0Vnn6ph1XW
	 5W2i1A9cRxzeiMuzIPy4Ovsn8XSQechNO2VUEYfFD+/qRg/M/WlzCGSLUagOgyS4K/Qdi
	 d21lndPNyWuXjHbMF2i4uWx4wr3iSOoD7/Re1JUxTMMq70TeMRGDITNe2odZF+pYjbJ15
	 T/74F0qmX6Lm+fQZnpPtZKY2cSrBQQkG/hNEn1R1Fyb+7CBnoY9ciU3yJvZYuvZFxalr/
	 ZrgA7q9PIyvyih8rKnDmhydsUXb/QZUlXoVn8s/KvwZnS779CVHl81wgLu08Td87K8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795014107;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=260xEPAm4+yEuIbZ5dhkFJ+UgkfgbzGzYew7hQHuFZc=;
	b=HwUbm4jNs+qusAblOBmyuUE/48etuWqNtfi7tr5abqMxG3BF1CsvloVJ5W4fi93Rl+jb
	 Twzi73Gg/paBtCzZxZ3JJujayTy/4JmPZ+i9CnMzrohaMKpem9JKLXB4kwxk6NnNaLCoO
	 sAv5h5w/Mf/2ExPieWIe+3xJBT8giX0G65uS1bja7vYmA3hA8GgUt0nyc/+u99BdsfExP
	 iqR1tN7CXg9/S/axmgsQvS7rcMk1B/7QYPsgqg2f2JkBXu4m0TX/Z//hZd7gShbK/7Fa3
	 hqAubngrqH2f1S3UIHa48qZqsVT7w+vlaGUzpyPDyGUeWWMTywFeZmCMj/8C7Kp+47g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NINMazIp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8825C606A325
	for <linux-s390@vger.kernel.org>; Wed, 18 Nov 2026 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NINMazIp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD041F000C4;
	Wed, 18 Nov 2026 15:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795014107;
	bh=260xEPAm4+yEuIbZ5dhkFJ+UgkfgbzGzYew7hQHuFZc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NINMazIpZCLNbGWw866+wxLPVLJpciBjNCoshkPZY1f/S44J0UvDF9bMW161l+BHH
	 8pvRCCPqlQdtpbNVIcOlejzAIZJmdYKH9BrVqp+FgZig89IPxECREaVAqoqVeB/pAb
	 ooVpqafof9UngS2EubXSbuhNz28VHNa8QLCQodZwQpDeO3+y4bqvGrxrcdc/M7QE54
	 UxqCUsgtRhZAVmY3P4dYKZGRupmNyH/ZjndmcH6wEWmepV324lIbf9Ruwv5LpMSMP1
	 VNSr3Ax3II64L++am2hAykyXuLbjuy72yP+/PuJkH/vfV09o7u14WsaD3Rg5yfEgqK
	 AYtRyrZZ3q1nw==
Message-ID: <sashiko-outbox-221280@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/8] s390/module: Add error handling to
 module_alloc_ftrace_hotpatch_trampolines()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261118144709.202520-5-hca@linux.ibm.com>
References: <20261118144709.202520-1-hca@linux.ibm.com>
 <20261118144709.202520-5-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 15:01:46 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] s390/module: inaccurate return value in commit message for
  trampoline alloc
--

commit 1f1b0c01e4a7101a1a14aadfdd4c9c1dbcd1303a
Author: Heiko Carstens <hca@linux.ibm.com>

s390/module: Add error handling to module_alloc_ftrace_hotpatch_trampolines=
()

This commit checks the return value of set_memory_rox() in
module_alloc_ftrace_hotpatch_trampolines() and frees the allocated
trampoline memory on failure.

> Let module_alloc_ftrace_hotpatch_trampolines() return NULL, instead of
> a pointer to a not executable page if set_memory_rox() fails.

[Severity: Low]
This isn't a bug in the code, but
module_alloc_ftrace_hotpatch_trampolines() returns an int error code (rc)
and leaves me->arch.trampolines_start unset rather than returning a
pointer or NULL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118144709.2025=
20-1-hca@linux.ibm.com?part=3D4
