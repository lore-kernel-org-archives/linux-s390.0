Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD06194137;
	Sun, 26 Jan 2025 14:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737902943; cv=none; b=pP2r11fkGcdS3VvaBL1U7GcgU8OFBLqCn06HO3t2XCsmYPt8HYYbcGDiOAQcujjyLDfnMCX+Fw5gRMlc3LAIKhmTKdClf7JmoYat9vDD2XhAeLPOn0wLaQweB04PCnn3JStds2bBaP6/vNH4o8xz7VgS0oRhWn8+xj3D9iQ95wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737902943; c=relaxed/simple;
	bh=PKz/tUNjKmibvKH3GaGhjJ+PRUw2DYBI7SOrKrB3yOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ueWc1j7/fUNJNrIY01/YeJU/GvoKPMiNIdasQRM40TA3g0TL1SoG7A+rmm2wJhIrx6HkToJ8PO/zFCDbPY2RoPAasNL5Ye6A94fcMHmm4yAvA0rFtvwlEnUzq5JMLf8GaHxA1ikXLzjMfCArqnk5eaK83Ho2NJ53yTr3Tvi6+/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjfSckqp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjfSckqp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E154C4CED3;
	Sun, 26 Jan 2025 14:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737902942;
	bh=PKz/tUNjKmibvKH3GaGhjJ+PRUw2DYBI7SOrKrB3yOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pjfSckqpa4PKiBDg5wbrGWz/J7RW7Z+NhHUdWY+xXCy4SYcluPU/VXfuni1/eUOBZ
	 dmSugMA0l1Kwh2DHWvak8JHytQ3ghPyqjBRMjgTItxomGS7QbEeQx4ovImTDZrUxnK
	 RGKRD3iqjG+mPQKnv3URauMTzlsfJhFXlV6fAD9c2F5gXYDLYW9/3mXTd3LUG/+M8c
	 TpOKD1tIeCqzmkES49oULr6387t03So4CW8MFLD2dPwKy33ltOl6/4AYglrSrVB4jc
	 EA52hg9y65JLytC6+z24rX7t5NgwCw8MqTtzgkgIyLJgYfLs+bLR8BenUvY8b4/tjH
	 /aZIKD0ZqcuMw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sven Schnelle <svens@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	gor@linux.ibm.com,
	imbrenda@linux.ibm.com,
	meted@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 4/6] s390/stackleak: Use exrl instead of ex in __stackleak_poison()
Date: Sun, 26 Jan 2025 09:48:51 -0500
Message-Id: <20250126144854.925377-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126144854.925377-1-sashal@kernel.org>
References: <20250126144854.925377-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
Content-Transfer-Encoding: 8bit

From: Sven Schnelle <svens@linux.ibm.com>

[ Upstream commit a88c26bb8e04ee5f2678225c0130a5fbc08eef85 ]

exrl is present in all machines currently supported, therefore prefer
it over ex. This saves one instruction and doesn't need an additional
register to hold the address of the target instruction.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/processor.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 9a5236acc0a86..21ae93cbd8e47 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -162,8 +162,7 @@ static __always_inline void __stackleak_poison(unsigned long erase_low,
 		"	la	%[addr],256(%[addr])\n"
 		"	brctg	%[tmp],0b\n"
 		"1:	stg	%[poison],0(%[addr])\n"
-		"	larl	%[tmp],3f\n"
-		"	ex	%[count],0(%[tmp])\n"
+		"	exrl	%[count],3f\n"
 		"	j	4f\n"
 		"2:	stg	%[poison],0(%[addr])\n"
 		"	j	4f\n"
-- 
2.39.5

