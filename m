Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63D11E3DD3;
	Fri,  4 Oct 2024 18:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065924; cv=none; b=Qdw5D6/JxTyLmI2VE3c/JKBSDdaodJiblvXbPAIQSsNFrSzEHPY1ZnAY9bCOtGv0VtJkfGttLGBVWpAV7NxLSrfk0VF9EJ40ic3rqSrLs4KnZSTk7h5Oq6LU6i5mZDaqncZk/t2BQrFTD9FPKsxMz4RtEyxvc/a2dpZhvCBiFqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065924; c=relaxed/simple;
	bh=d5U3kRSvnghxiJhM8CHSHD4ypZUxb7chyG1RiQlKkQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Smcz2t41N2lbe0RGmm+Xh9ykxLFGzu7yBC+UHZtzpfLgKSXALU7vMeG+cY+URAmpnCVFt81Y2viLg18S1HiApC+4ntcrUEtBd/LmeVMQU8PZVEBYBjFWVQ+dehkfdn113NFttIafRRapW6fXW6CypcO54RhcWlqg3I3kFG18N10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2J9T9hX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2J9T9hX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793BDC4CEC6;
	Fri,  4 Oct 2024 18:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065924;
	bh=d5U3kRSvnghxiJhM8CHSHD4ypZUxb7chyG1RiQlKkQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l2J9T9hXwiwxCxSNy/qPUXR55nAKBEABS8CrefUIQev8XbVbgSZnyfohyU8cbZN0P
	 zBT+1M4ZcHanBJ1lT5/KJ7T1Icv/nLnjAE/tI6yZfWXmmiBVU8+5UbJizz1p1SLfFj
	 NuQ+GeFb/bmFB9MRO5n0BtvWWmwAJ1NwVbURSUorARvk+WVgqB23HDGUg4L/vZPtoW
	 +As9Uf1tJvNKuoYwaF1qiHltg0OvJ/c3561RLkXauaVkMDbPOZOEjbnc5sh2iw0iYx
	 N9c3f87XIxrTI1V0LqT9QQuPnWZX1TetrS+rSHbqppCAPjcqX/fzTFW+WNcdJmFJg9
	 Mctdzj05qK4WA==
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
Subject: [PATCH AUTOSEL 6.11 08/76] s390/facility: Disable compile time optimization for decompressor code
Date: Fri,  4 Oct 2024 14:16:25 -0400
Message-ID: <20241004181828.3669209-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
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
index b7d234838a366..65ebf86506cde 100644
--- a/arch/s390/include/asm/facility.h
+++ b/arch/s390/include/asm/facility.h
@@ -59,8 +59,10 @@ static inline int test_facility(unsigned long nr)
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

