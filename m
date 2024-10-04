Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131F11CACDC;
	Fri,  4 Oct 2024 18:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066715; cv=none; b=YQoJX4Bb8AQGm+wJ5ZybOj46uyE4babtcpKa88rNV59oKZM1eg9OCwFdoXquxpL51pzWfARFpfZ6/0m6rFpggi4NFzfq0nI4TaXaRx7OQfiywyxeJJZXt323fgrZxtpwT+NeE2UPlLwyZj62uGOoL9ZDSnR5nfx2m7yPgoLLue8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066715; c=relaxed/simple;
	bh=vlC5VDndKAsjh9jydmkAYyAPtlYjObhApJQ6yxn6qUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HVN1juUwolt5RMaQa/Nz5Hii9cDUJS5VkmSLtBzj6CLGXScAphINy9mU4QwO9QEoX3qIz05bsouZ3ecg1uIJ7yGtcGw3FoNa5tjmdeN6TrGq2wgX+HclJs2XcZkTYhFC5NLYeN0K2RECb9vQ/AtbjdROf69rt8rvrWn/T4OzhWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCZ1GE37; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCZ1GE37"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B62C4CED4;
	Fri,  4 Oct 2024 18:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066714;
	bh=vlC5VDndKAsjh9jydmkAYyAPtlYjObhApJQ6yxn6qUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LCZ1GE37o6qXbuP+0QdGrUws7CZADNNC7uBH8hGuxdYhQv0i6j2NKLeI5PoAs+Rd1
	 B/uPKetde/GnWalV904QJVsyUDiu/SAlsUnqFGwG2QGCp/WIMlk45h90gMBaQrl1Re
	 UM5e3wWBUNbXiGn6m1GRC6zRHqQbOiJSTtnOzNYMJvf06gtCtKj7pXu6Rr/GDZum01
	 r/frY57snXXImPjRSXUBZcBeJBL/jwIHV8/FOUTrlHTNXLCnw8zNuLaPUz5mlG0RdP
	 KqT8LeRTAF9Guv0eH0KsXjONjcKU2JcLPvK8BeFvgNCsSVa+Wsw0W4SRvt2Kvbv6ML
	 FJjl1cHBphAyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	frankja@linux.ibm.com,
	nsg@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 02/16] s390/facility: Disable compile time optimization for decompressor code
Date: Fri,  4 Oct 2024 14:31:29 -0400
Message-ID: <20241004183150.3676355-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004183150.3676355-1-sashal@kernel.org>
References: <20241004183150.3676355-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.322
Content-Transfer-Encoding: 8bit

From: Heiko Carstens <hca@linux.ibm.com>

[ Upstream commit 0147addc4fb72a39448b8873d8acdf3a0f29aa65 ]

Disable compile time optimizations of test_facility() for the
decompressor. The decompressor should not contain any optimized code
depending on the architecture level set the kernel image is compiled
for to avoid unexpected operation exceptions.

Add a __DECOMPRESSOR check to test_facility() to enforce that
facilities are always checked during runtime for the decompressor.

Reviewed-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/facility.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/facility.h b/arch/s390/include/asm/facility.h
index 7ffbc5d7ccf38..79730031e17f3 100644
--- a/arch/s390/include/asm/facility.h
+++ b/arch/s390/include/asm/facility.h
@@ -53,8 +53,10 @@ static inline int test_facility(unsigned long nr)
 	unsigned long facilities_als[] = { FACILITIES_ALS };
 
 	if (__builtin_constant_p(nr) && nr < sizeof(facilities_als) * 8) {
-		if (__test_facility(nr, &facilities_als))
-			return 1;
+		if (__test_facility(nr, &facilities_als)) {
+			if (!__is_defined(__DECOMPRESSOR))
+				return 1;
+		}
 	}
 	return __test_facility(nr, &S390_lowcore.stfle_fac_list);
 }
-- 
2.43.0

