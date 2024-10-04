Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2462009C4;
	Fri,  4 Oct 2024 18:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066316; cv=none; b=B0hTtow5hS+Kv8DPtVOpKqS4c1wwcu1728Mryh4SDJAjHFrs5IojC2RWrRwbidXn0+7A49YuOF3b6y3zX9iVGAH0UBd+jRJ+DNMjHzEAkEcpPGAajek4diIXLsKmcHsphsBuGe7PjaLsIxWHAVvosSe60ZPBGx8CIXaxYXWceyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066316; c=relaxed/simple;
	bh=wX8N+tx3kFBBYYzq801n8SW2ZPgDnMul93kbozxOElA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5nXrwcb9toHu70fBIGPRyXCycDgs0HDKqmUJja07tIUSRu+DXVe/qtQuDhMJPcK+Gh2cYdsRTQLW2cNLF3OCxj7xQWGI30yZiDsilwbfkMi/B3B5R3mK6tdRYT83Kbtoh+QbGSVzKS/1CVnNT5jyp9BMN9eOmUtaubeGNSRTNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjCrEyiE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjCrEyiE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96389C4CECC;
	Fri,  4 Oct 2024 18:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066315;
	bh=wX8N+tx3kFBBYYzq801n8SW2ZPgDnMul93kbozxOElA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WjCrEyiEe6w8VTQAxUtmMTbzeGlfe1B6LGZgxlkuG7UWF52GhyMTE4EE7tnyJzz96
	 oA+JNYt6pBZbRacTetJz2w1oggty2gk1PjAbd91BmkE12ll1/Iy/xrIC00zx2jPviQ
	 hQiWs8T2vTJGX4hGYuxQnIDR5b8W6Ae6HjK3TxaeZXtdudtC3+WHegK3zFBGPoxVAk
	 N/XNVWvQhCAh7KBp1b3P2LPglZw+Ls0BbJNqe7a2v8k6F47/ui2esrkFCpIihQruK9
	 pqIeepNw2uORne6P5+Z43JQTYNH++p+3zCKOUNiZXHHxUbvuEp7S/rtcb0tOgSSUFk
	 Z5dPcFod11w7g==
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
	imbrenda@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 06/58] s390/facility: Disable compile time optimization for decompressor code
Date: Fri,  4 Oct 2024 14:23:39 -0400
Message-ID: <20241004182503.3672477-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182503.3672477-1-sashal@kernel.org>
References: <20241004182503.3672477-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.54
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

