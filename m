Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451C0146588;
	Thu,  8 Aug 2024 22:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723154878; cv=none; b=nWDUjn/0xW9IiJ8YwjvBuMq5UVgIlpx4XSmAPIADZQLHRgjdK/cS1WvZfe6zODYBQHOQjSMrDsKrH0TTPtWQuf1Ywvlnsip6ENLnPf7u9G1S6oKNcUJfxHfVVnHgpK4hbKlTWs1K9YQfNFQOLUCkSW5+b2XRhQvdnUxrOTuUOAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723154878; c=relaxed/simple;
	bh=ds56W2QCa96KdbDtVwJvSmZJnvmlqJ2m1jHbaFzN/RM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Cp6y6q85RhI/4jgsa1UyCombmNSblS43zMlSyOAPh8RYnlbsL/R2w8CuZqeLtwMBlxDGbZNQgPR1B6s5hgozn/NMqOy88Syhii7MZ71iI8TQ6aQs3jyNSxhNNcP9Fyn3PmDW8qQ7wsUOHt1hWjdFsEJ949WFm7lRckX5yof7X/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTjUp6AH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTjUp6AH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3689C4AF09;
	Thu,  8 Aug 2024 22:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723154878;
	bh=ds56W2QCa96KdbDtVwJvSmZJnvmlqJ2m1jHbaFzN/RM=;
	h=Date:From:To:Cc:Subject:From;
	b=uTjUp6AH6vxBVIvod3TyBPzqjFIlgJyoqWA17WXB79ZV5CpCRHoSxy9py4p6hlvj9
	 as7VhUD2wf2v0RhmDtYewFGNGf5kTvc+XNieNZKjc1MIdNyz8PE4ap4/rf6TlfO++b
	 P2bYlq3kX8c0QG5T22Qy81R6Uf/nAt/oQ6OjYNRZYi2sglMZlPDrFxIWJ6ja3jC6TF
	 c1rZN9Tu9imLHrNukqKuk+K0tSm4Sz/IHXA/LPkS14O6FDX4kID/EPJDH5N0rc9u/c
	 cuU+ODse3shIXEX5Yn3/Frdb3SR1BHudLzUHlIcsyFSq3KL8Ha3fKSLH7tW44vAslI
	 9SCWPh9bqqyEQ==
Date: Thu, 8 Aug 2024 16:07:54 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] net/smc: Use static_assert() to check struct sizes
Message-ID: <ZrVBuiqFHAORpFxE@cute>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit 9748dbc9f265 ("net/smc: Avoid -Wflex-array-member-not-at-end
warnings") introduced tagged `struct smc_clc_v2_extension_fixed` and
`struct smc_clc_smcd_v2_extension_fixed`. We want to ensure that when
new members need to be added to the flexible structures, they are
always included within these tagged structs.

So, we use `static_assert()` to ensure that the memory layout for
both the flexible structure and the tagged struct is the same after
any changes.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 net/smc/smc_clc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index 467effb50cd6..5625fda2960b 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -145,6 +145,8 @@ struct smc_clc_v2_extension {
 	);
 	u8 user_eids[][SMC_MAX_EID_LEN];
 };
+static_assert(offsetof(struct smc_clc_v2_extension, user_eids) == sizeof(struct smc_clc_v2_extension_fixed),
+	      "struct member likely outside of struct_group_tagged()");
 
 struct smc_clc_msg_proposal_prefix {	/* prefix part of clc proposal message*/
 	__be32 outgoing_subnet;	/* subnet mask */
@@ -169,6 +171,8 @@ struct smc_clc_smcd_v2_extension {
 	);
 	struct smc_clc_smcd_gid_chid gidchid[];
 };
+static_assert(offsetof(struct smc_clc_smcd_v2_extension, gidchid) == sizeof(struct smc_clc_smcd_v2_extension_fixed),
+	      "struct member likely outside of struct_group_tagged()");
 
 struct smc_clc_msg_proposal {	/* clc proposal message sent by Linux */
 	struct smc_clc_msg_hdr hdr;
-- 
2.34.1

