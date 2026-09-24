Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D3C2F8EBC;
	Thu, 24 Sep 2026 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790253656; cv=none; b=aOXetwY8QhtjV0mJz/sHgUO7CEYLnHz0A/YdcGccWZ93eUIEt+yITE/kOwM9zfFkcHqS2QnWaXygd65Q5bzMZNNlTaiC6R1V7/OZ+B+EFscbxohGV9yiLI5tfOg8AQXxZRPFZCyeKULUEhvW1zm4pwo/Y5Te3MIoxUvLiiWDkyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790253656; c=relaxed/simple;
	bh=SmfhWUHgjEhs7ScLOGqPgd9CVRRbouQ05MUP19ZDCX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7B9WDrC4DZhY55Izz2ivnnfwDGNOYuKGarZTFXXl3vElShpuGWcYI4fF6xvo3HjL7OfWcj7+E0/fGFhjdzvSHABTFHCELpZSqMauGxCbPToTLLCcFxFRxE/JLHTN8EJSjk02ZIJa1/0lU8k8hPjZsn3a1F20Eoga1K6wlCH6mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=dd6Nw9qG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="dd6Nw9qG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=F+mLTFWcuTBUsCxvuF5xTJ0KZMxOy4eAk395s+P/g3g=;
	t=1790253654; x=1791463254; b=dd6Nw9qGNBxe1DKxc19l77kn/BzaNHgIqBnHHpLfSJRDQI7
	UuQlQBh0GBIPgRGT5Wwbr9/YSVQwZn0N5y0KZJz8Jbk+1opJcskVGOErt/a5WTL+4D5Vix7DSu9R/
	8RFdPGsUOWemPfp5KMk28Dll1yOM5FYNsNHm5UfxtEXxrYr0t72zWN6O6omzFXUtf2aFhBlQnWbgw
	emNFNvOkqJ7nyQhj+600O1WewvV04WUqBsfxMjLkR3Tvsnd46BkU/f3wd1lNbWS7HErsMMlM5x1Q/
	q44XD1TBQATa768lPfvwe5EQnUdI6m54wBvuh1NMa4mlEm9tTj2GWQBHqs4vJiGA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x9ikr-000000092x8-1pkb;
	Thu, 24 Sep 2026 14:40:49 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-s390@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/4] s390: remove unwind_module_init()
Date: Thu, 24 Sep 2026 14:35:50 +0200
Message-ID: <20260924144039.4af0d88b163a.I91f8c59a12ad3d5fe67d50aa3b0434d666ffc9f8@changeid>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924124039.1621965-6-johannes@sipsolutions.net>
References: <20260924124039.1621965-6-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This is dead code, but will likely conflict with
the ORC unwinder unification.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/s390/include/asm/unwind.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/s390/include/asm/unwind.h b/arch/s390/include/asm/unwind.h
index b8ecf04e3468..021056d5982c 100644
--- a/arch/s390/include/asm/unwind.h
+++ b/arch/s390/include/asm/unwind.h
@@ -91,8 +91,5 @@ static inline struct pt_regs *unwind_get_entry_regs(struct unwind_state *state)
 	     unwind_next_frame(state))
 
 static inline void unwind_init(void) {}
-static inline void unwind_module_init(struct module *mod, void *orc_ip,
-				      size_t orc_ip_size, void *orc,
-				      size_t orc_size) {}
 
 #endif /* _ASM_S390_UNWIND_H */
-- 
2.55.0

