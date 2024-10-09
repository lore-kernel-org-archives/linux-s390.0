Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23C817E012;
	Wed,  9 Oct 2024 10:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728468333; cv=none; b=pozG8MMC7Koewj1cYsM+WWRM/GQO4cf1Nyj2b+xW1rOBKmK0QbCMy7HseSKjCDZHotYHdX7iRG5dXdRb2tpJjbgg+X1fVQfv1FKb49BRKGCE7RX6JXpOHhYUyfP4SNE/TXke4LYSemKTYI3cjZo5dXHPsJeL9SuAMQAsSDqBD0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728468333; c=relaxed/simple;
	bh=98a6KyiTpUrUZYit/BsRgKAgBjUVUFZLNZTtJTqMcuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iCRvLyXqzb2PmR+EfKbo3cw7tmB8tb7w7JL5nmY3vO9w68h5K01E12sHPsDPT/lQv25pXkDM3rRwPgsXQfPbfvqw9KkGuA9NniFS9oznaZXN3XvhFfMWhsdof0mOuM8PRhaIxP2V6zYiLvVXL4z3n/TTPMnalafdyfkWbu/B6eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFVaA5S8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFVaA5S8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D16C4CEC5;
	Wed,  9 Oct 2024 10:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728468332;
	bh=98a6KyiTpUrUZYit/BsRgKAgBjUVUFZLNZTtJTqMcuU=;
	h=From:Date:Subject:To:Cc:From;
	b=GFVaA5S8wf5g5aOQy/zuImIU3G1xneje2BDCAZVretbJCGJYjODY5YtJjkry37wZU
	 RXg3IWyJsJ+H6HhXN5PrhvFnpOVT9xB0gZ4ZBNNSfwihK3PfX/84GojGtlvTFBvoxz
	 8A5qriEORTEHWJHBMr/KjTVKtTnCNqXEeqtQwfFrruoanGo1Rd86Oy/Evu9zZF7GUJ
	 3hZyErV729gyaC8tDb2tB8N01FKupUAiM2rwNFHMNXG7QvUdH6pUA60C79D5XHC9xe
	 aE226+CtTUNC3KredWJkD1lV0fUgTjVURB4oV2njitUx0LXJqlsY13hDNXxpxJKc2I
	 6BkofraS87eiw==
From: Simon Horman <horms@kernel.org>
Date: Wed, 09 Oct 2024 11:05:21 +0100
Subject: [PATCH net-next] net/smc: Address spelling errors
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-smc-starspell-v1-1-b8b395bbaf82@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGBVBmcC/x3MQQqAIBBA0avErBswCYWuEi1CxxowC0ciCO+et
 HyL/18QykwCU/dCppuFz9Qw9B24fU0bIftm0EqPSiuDcjiUsma5KEYMwY02GG+t0dCaK1Pg5//
 NkKhgoqfAUusH8S5RcGkAAAA=
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
 Jan Karcher <jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>, 
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-s390@vger.kernel.org, 
 netdev@vger.kernel.org
X-Mailer: b4 0.14.0

Address spelling errors flagged by codespell.

This patch is intended to cover all files under drivers/smc

Signed-off-by: Simon Horman <horms@kernel.org>
---
 net/smc/smc.h      | 2 +-
 net/smc/smc_clc.h  | 2 +-
 net/smc/smc_core.c | 2 +-
 net/smc/smc_core.h | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/smc/smc.h b/net/smc/smc.h
index ad77d6b6b8d3..78ae10d06ed2 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -278,7 +278,7 @@ struct smc_connection {
 						 */
 	u64			peer_token;	/* SMC-D token of peer */
 	u8			killed : 1;	/* abnormal termination */
-	u8			freed : 1;	/* normal termiation */
+	u8			freed : 1;	/* normal termination */
 	u8			out_of_sync : 1; /* out of sync with peer */
 };
 
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index 5625fda2960b..5fd6f5b8ef03 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -156,7 +156,7 @@ struct smc_clc_msg_proposal_prefix {	/* prefix part of clc proposal message*/
 } __aligned(4);
 
 struct smc_clc_msg_smcd {	/* SMC-D GID information */
-	struct smc_clc_smcd_gid_chid ism; /* ISM native GID+CHID of requestor */
+	struct smc_clc_smcd_gid_chid ism; /* ISM native GID+CHID of requester */
 	__be16 v2_ext_offset;	/* SMC Version 2 Extension Offset */
 	u8 vendor_oui[3];	/* vendor organizationally unique identifier */
 	u8 vendor_exp_options[5];
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 4e694860ece4..500952c2e67b 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -2321,7 +2321,7 @@ static struct smc_buf_desc *smcr_new_buf_create(struct smc_link_group *lgr,
 		}
 		if (lgr->buf_type == SMCR_PHYS_CONT_BUFS)
 			goto out;
-		fallthrough;	// try virtually continguous buf
+		fallthrough;	// try virtually contiguous buf
 	case SMCR_VIRT_CONT_BUFS:
 		buf_desc->order = get_order(bufsize);
 		buf_desc->cpu_addr = vzalloc(PAGE_SIZE << buf_desc->order);
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 0db4e5f79ac4..69b54ecd6503 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -30,7 +30,7 @@
 					 */
 #define SMC_CONN_PER_LGR_PREFER	255	/* Preferred connections per link group used for
 					 * SMC-R v2.1 and later negotiation, vendors or
-					 * distrubutions may modify it to a value between
+					 * distributions may modify it to a value between
 					 * 16-255 as needed.
 					 */
 
@@ -181,7 +181,7 @@ struct smc_link {
 					 */
 #define SMC_LINKS_PER_LGR_MAX_PREFER	2	/* Preferred max links per link group used for
 						 * SMC-R v2.1 and later negotiation, vendors or
-						 * distrubutions may modify it to a value between
+						 * distributions may modify it to a value between
 						 * 1-2 as needed.
 						 */
 

