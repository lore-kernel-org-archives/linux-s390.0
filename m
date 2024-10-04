Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C421EFF1E;
	Fri,  4 Oct 2024 18:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066137; cv=none; b=L39bZySgHAEAY/fmaDDBL7FPkbENVer3KaI8DhxfQgdQ+cJPKU2Mw9lEuejHucF6wmPzVx6HxwC3tQKx7HMpjxan9CPjDw8FtzUmRhbXSYFp7c2YFfVKoyoEejHXxIjlvIHJ2djB4IT1ThQW4DE8APnwzKJRPA4aTWB3N7eq79U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066137; c=relaxed/simple;
	bh=UkIDyYGeIWvoIN8v1d114YDDc39d3ebjIbsCAmnu38Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ivxhxi0URoWWZ0EGIBI55Zu2FFWJ71y9Css7eMfGv7PxqV70T6paYSw/DcKLYuJSzEW0kTavFpsPLyt0Uj1ZGQ/up1qwxtk9CvxwnRJ1UJ2r36yjDjVu2XOdvkoEDpVk/Mesu+vXiNoWCpan9SDVkVastUkBcHXiIRp/O4kkOVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1YiXsJ/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1YiXsJ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EE6C4CEC6;
	Fri,  4 Oct 2024 18:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066137;
	bh=UkIDyYGeIWvoIN8v1d114YDDc39d3ebjIbsCAmnu38Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s1YiXsJ/QnvypLIptoZr6dYfCUyAOr0vEEZMAN0P52rnmmPo+kHHBxImp/J8Hu3r4
	 hD+HIliLrABDrtp2gJGrQc4rfbRAsUKTInuGPMS6GCQRHo7VV+ZmUrWB0xIA+dgWrH
	 ovfjiG8pEX1SHuMX6FrF3HV3pR7Gd5Hjdxa+JKINQTmixmsygTdXxm3gPvcWb2cTe6
	 F/VEKBnLqfJnVEIqMMQn8q9mQMPL96vdOJOQcmToieH9O7Q2UQ4NRPtW++bCzC3NyC
	 BkEMkAZjSmtLR/2O9Byjv42QOTzP/V9BcI4Pwlw/xKiLcFxlA+tmpwwglN/TfZb8X/
	 ata6ABMHFGjAg==
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
Subject: [PATCH AUTOSEL 6.10 08/70] s390/facility: Disable compile time optimization for decompressor code
Date: Fri,  4 Oct 2024 14:20:06 -0400
Message-ID: <20241004182200.3670903-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182200.3670903-1-sashal@kernel.org>
References: <20241004182200.3670903-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.13
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
index 796007125dff2..6b54aa3711920 100644
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

