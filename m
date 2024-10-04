Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE2E1E049A;
	Fri,  4 Oct 2024 18:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066673; cv=none; b=FJ//znwxLEr6NLIslPM6eODKUKHRsPreybXsTPPLr29af/7ttd6baO8yj5MdLscIsgY4UQDqoJBp3Nsj+z0P1YSMjs1Ep/ABIC/8Qv1KtUzJzTiJs9JCUKi1vm4ctKkYDFsxU0kOz98yQCm8StHxbjc9FzB8CSdktZr3dw9tl4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066673; c=relaxed/simple;
	bh=PASC1cDVLfI7W5kc2UXauk071LyN/QUixRh+XkYnRDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ie/OabbRpomDlV5mi44yu1rXkYHn6/0/3Wx27R3zo+0tDbkxRWEhyxq00q1iHEFiPOp8m9aoEoatHNbAk9gMLiWhH4+RSAXYcugvGjSC/yQAf7BgZ06gJmwxFErbTdenisz2BRsrgA79DrgWp0O2soUwhgHGIHZhAqjqhYYdiEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADfyvxSd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADfyvxSd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A63C4CEC6;
	Fri,  4 Oct 2024 18:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066672;
	bh=PASC1cDVLfI7W5kc2UXauk071LyN/QUixRh+XkYnRDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ADfyvxSdtZ1h4EoqtIvBBe3Fov8+NEYKpZA8fGdIcRo8PuE39z4x6Uut4XFrd579Y
	 VkhA096TE5lD8XU3WdGN4MHdUJ26GxCPqHKAtVIGa2gOui2GQE0rGguYqNl25yU/To
	 ZeEAqW863cyQD+qngwtxZwcEXZr0oFOEMvH7MHD3lVFBGszmOQFzOJ0iSHcb1O8Lne
	 yDPW6DTHng4perfCCdYZoKXHuvRR2whfgJfQaiOp6IOht9VoRJsWatf0OW5yl3fu64
	 86IoZnsJGpu0f35Go4XOenwvq1ma7G/x1S9ynAcyML/MMO0bgA8x0wXnZYiLFM7xCr
	 NXIKU6UTBBLSQ==
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
Subject: [PATCH AUTOSEL 5.4 03/21] s390/facility: Disable compile time optimization for decompressor code
Date: Fri,  4 Oct 2024 14:30:38 -0400
Message-ID: <20241004183105.3675901-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004183105.3675901-1-sashal@kernel.org>
References: <20241004183105.3675901-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.284
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
index 68c476b20b57e..c7031d9ada293 100644
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

