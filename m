Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8741D89E2;
	Fri,  4 Oct 2024 18:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066446; cv=none; b=IVPrmtutGF3dph1I1Ux8ON3cFsjCwolgZDIleMORP/kvTGkAo1yRqBUq9MEe2QjcB3+WQ1KBvbVajT5T3mHIj4NXDtDCdjfmA6gx1l1is8VdyZPtFxCmcU59hprb43UY9tEqpjbHFIGn5TbZGWi+aMfbCoZy+Qn7p1X2MUZwPlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066446; c=relaxed/simple;
	bh=wX8N+tx3kFBBYYzq801n8SW2ZPgDnMul93kbozxOElA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0LgGuLJWh5QihAz+XQsuSVWf9JxuVKX3LQic+hki+j5GNwMHfssDLPwGmeR3SX2kHI8/gubZm/3GOvcmgMmtKCrLvpLlcvxzIo9gGwJqscuKim9wTt3mmx8gj03/YgI/gl1tL+3CkL5G9xwz8pNEzsNd/gsYtMn5x1AXMIHJYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+6kzQ17; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+6kzQ17"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA07C4CECC;
	Fri,  4 Oct 2024 18:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066445;
	bh=wX8N+tx3kFBBYYzq801n8SW2ZPgDnMul93kbozxOElA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S+6kzQ17wPhbklHXHS7EUwbGErE/QAsiA6ScXs3U+DvXzX5Lnhhl5rTTjSdBs7QY6
	 UyHVLSouiSiKZwWVFWULvtGR4rP3zLbYXNbywcrjdXFJ6tSkiGyo82URFqnVNraL+c
	 ktv+uMrl89G5sMVgZMaa8RBjdRhQRPB80Xlc85xX0FfBFuTgE9z7WmGKu/LA/ZvD7V
	 46Kg1Gr9uqExnN4nTfS44nHx3WITk4OSkQxHhPA4SwfE4QfNpLUhJ1gOqZeifw+Pfc
	 GCo1ndmoVNwXbOK6XJaUKdJ8hGU0dZNUHbf1dLSxlLNlCFEWbDNBOTylqGhxbakaof
	 UfzaKYfGHlewQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	frankja@linux.ibm.com,
	david@redhat.com,
	nsg@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 03/42] s390/facility: Disable compile time optimization for decompressor code
Date: Fri,  4 Oct 2024 14:26:14 -0400
Message-ID: <20241004182718.3673735-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182718.3673735-1-sashal@kernel.org>
References: <20241004182718.3673735-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
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
index 94b6919026dfb..953d42205ea83 100644
--- a/arch/s390/include/asm/facility.h
+++ b/arch/s390/include/asm/facility.h
@@ -60,8 +60,10 @@ static inline int test_facility(unsigned long nr)
 	unsigned long facilities_als[] = { FACILITIES_ALS };
 
 	if (__builtin_constant_p(nr) && nr < sizeof(facilities_als) * 8) {
-		if (__test_facility(nr, &facilities_als))
-			return 1;
+		if (__test_facility(nr, &facilities_als)) {
+			if (!__is_defined(__DECOMPRESSOR))
+				return 1;
+		}
 	}
 	return __test_facility(nr, &stfle_fac_list);
 }
-- 
2.43.0

