Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BF21DF73D;
	Fri,  4 Oct 2024 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066613; cv=none; b=jSj6HO9zf+B3zPCAvIsfNOvOrn3b2aWgQPegSdg4ofAyDMOM+AV95dtzh+i/qWtnWdpD1UD8b5PLhAfXr4Sh3VZiyW7OTF87J5odazAingpmO4iWXxkccG7qLlAH1oAACNsgvKyy5Da9MXkKQkt2vxLJHMD8bBbJsJnQbbe5A9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066613; c=relaxed/simple;
	bh=PASC1cDVLfI7W5kc2UXauk071LyN/QUixRh+XkYnRDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJxrRPfUrqjCNNpkvDeywbdgWZqO9FRtF+OcCtNIAs+hactpm2SCW2fmsJrnJzMkQxshAPEVF7YGW9urMdDhquvNb68Xm1UqPuDB/Ms7OQfFvsB7p1F085JZJ+gtJVDeTNr+zqA9gDiFPM6kJiUiD2+1yw9NRz2MfjatyWRlIVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mcv1N5bL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mcv1N5bL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E40C4CECC;
	Fri,  4 Oct 2024 18:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066613;
	bh=PASC1cDVLfI7W5kc2UXauk071LyN/QUixRh+XkYnRDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mcv1N5bL2zeVe5FSUMSQWRYvDIgq1uc6jN89FRdMf0PNzd2LlzIwvOI7Z7C8QSlAJ
	 jkqJ4EogaIIMex2kwCZF509q+uA4iIekLfkD4j3epK5cuPwgm2Wf6m6pkNaLPpk2z4
	 1YTTGtfu/65UOEI2p1Anok9Br/BA3u90LdahI+RHQp0OV2hyWcR+3iz6rHCbMTQfc4
	 TLPEON7TuLp04Z/dEpDhT6ZrkPMn+Nveg7Q5IJ73e18TqIRHMbN1oDWwDe7l3zAaXZ
	 DWikcLqSxurdr9tq2iiW5jy4a1JID4nfilOXFFD+gDASnn9Sy8mFg0JqOaRkhm1ib2
	 lgPddsYtQJZAQ==
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
Subject: [PATCH AUTOSEL 5.10 03/26] s390/facility: Disable compile time optimization for decompressor code
Date: Fri,  4 Oct 2024 14:29:29 -0400
Message-ID: <20241004183005.3675332-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004183005.3675332-1-sashal@kernel.org>
References: <20241004183005.3675332-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.226
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

