Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59A717084F;
	Sun, 26 Jan 2025 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737902929; cv=none; b=E+99pYm2UOgOjPmv2z4Zu4iL7N8GXRqZTxII1wUTYpVSuVl0OYqXjoGvISdoVzac7jXuO2l3mIayhKY1M76N3BunQsj+PjxcukVMBjGHl/61G5AEzh8qrsSQWwficEPft+d1pVrXdMXntKgvp5jsqKHcNMnfJhyv1c07ApLpBsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737902929; c=relaxed/simple;
	bh=eh4cIulasgqyPYNqTd0PIqpVWaBDnASMx9Xs+U8eW9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TkorYxfMyeCi5rO89N+IDGhjFvJVlqGfV8UmgaxBc76HZRo9vwpkV0c86xzham/mtc6WLLQG2kZdUwVpzbrVTo+lqDzxMV20BeAnnYajja9gikFOARy0i0Z7Xas164cyt1Pd2mYwDcwGrClm9vQgTkFy3WQvkCzHMkkw01SYLKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVZi/5yO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVZi/5yO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2CFC4CED3;
	Sun, 26 Jan 2025 14:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737902928;
	bh=eh4cIulasgqyPYNqTd0PIqpVWaBDnASMx9Xs+U8eW9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gVZi/5yOPWFByekCISiwlAzV8c+58Cc/0yQLJ3P9oUce56n0fJjrkOkZbDNdF43Ph
	 gDjrDCagpp7SkzA72s8xJ2HvDchI0xW6dZ+exNd6WqllGRwSSUyKkT9h1Qd1cqe9Gl
	 pCCck8taFdCwKlEp2n0EEMcwRhuKR2W6N3pHdmJLiGpBBkIL3RLZkvXVm2u0s1kLRB
	 RzDvG+rrkVlAIj5sQ0AjUnE9Omnka6NY3EyJnbMy/BoGA5c3GzTg1LEbcsA49Kmd4f
	 jpuNuXjb/g7LSdebLoiqDBO9YZDGmQp0qymIIkJJfnor1DH6hIoiDZ3lpLupDerAM/
	 sTVd/e7DW0ZCg==
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
Subject: [PATCH AUTOSEL 6.13 4/7] s390/stackleak: Use exrl instead of ex in __stackleak_poison()
Date: Sun, 26 Jan 2025 09:48:35 -0500
Message-Id: <20250126144839.925271-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126144839.925271-1-sashal@kernel.org>
References: <20250126144839.925271-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
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
index 8761fd01a9f09..4f8d5592c2981 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -163,8 +163,7 @@ static __always_inline void __stackleak_poison(unsigned long erase_low,
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

