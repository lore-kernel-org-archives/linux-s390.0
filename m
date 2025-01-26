Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB3419DF41;
	Sun, 26 Jan 2025 14:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737902954; cv=none; b=ExbwdaxKJOfXk+8Le0BHR+e4jDjYcA7pHtcuru235ZMElHu+TUE+M59kGoCEzpQ90V0WJIOTrSvspTssTJHr9q2zeBS2O50Pf/qUwf7LVv0AcEobUiY4x8OviuBC/DSz/PinangzWCwsip8IC5QMF66WYO6j1A1CZJ62XJzka/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737902954; c=relaxed/simple;
	bh=EqJsOZIwVZcoQJsAI8S4W1Z4uoLBpJWDnuichvSCSjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sxWMoZHLsgt83Ack3vm3BaPjPkkubfbkwFBuCzXv8FVsJ6lf691sPK+Yg7L27R/fDsL9HETUeQHnfKB5dUT5egP1ArwBHHE9rYwTDbgFIe8oB7lfayUicZ4VqrOZlCP02Lc6aIZIU+KxkcQevlSg0q5Zn0T76swsDMQPabI+J6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhiPI2TA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhiPI2TA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24A1C4CEE4;
	Sun, 26 Jan 2025 14:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737902953;
	bh=EqJsOZIwVZcoQJsAI8S4W1Z4uoLBpJWDnuichvSCSjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UhiPI2TA2LdOVBTqLMCge/XYC22GjJxWRTz3XTUv1z+NooPWhQvyS26xgYLki4jUK
	 CFoRpmnRoP7OlST3d2Av90wWhPQoIXVbY0izl2TwT1iRjxoWKO4xT7SFXW+EH2V8hC
	 pZvsEXz4x6oJMAuMN25901DAnQaordlynKcUSoKz0arrUGYkhmK2/SN4d7I2Lrmi4z
	 Sd3WMluidySz8LEH75DZGzxfZO5IpElbsQELpV9yNG2f4vObaPlKZXd84sjQJGDNJ4
	 eYwi2gXwieJek3ES8RchrH5fyKx2J6gYr0RXsXjdpUYn4OwU3CoNQbu1ndV03GzTAY
	 /QoIY/vkFa+7Q==
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
Subject: [PATCH AUTOSEL 6.6 3/5] s390/stackleak: Use exrl instead of ex in __stackleak_poison()
Date: Sun, 26 Jan 2025 09:49:04 -0500
Message-Id: <20250126144906.925468-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126144906.925468-1-sashal@kernel.org>
References: <20250126144906.925468-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.74
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
index e7338ed540d8f..2f373e8cfed33 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -140,8 +140,7 @@ static __always_inline void __stackleak_poison(unsigned long erase_low,
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

