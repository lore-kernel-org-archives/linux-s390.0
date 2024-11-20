Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE761EB3D;
	Wed, 20 Nov 2024 15:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732114876; cv=none; b=CYH+ntTW3NPJbz97chTdgkN0gwxr7kkeDgB3jNA+d8LyNM6WC7cnBB8Rg58Fam3+/Mr+WEPtT9bRmRgAPr4p1GE7oj8xmsnDNmXmcfhDdpTJUKdqWLtR9MCpuoVscvCJ1qWSHYrphuugcn8iNxadfAR4/RmCo1fEH8wEJY1oAUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732114876; c=relaxed/simple;
	bh=9PHHaga7qdizbZvNAUY9ymsRQ2ooNPqub9YJW56h3qo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FjooauzBt9GcIj7teNhWV3Mn54IrlJmJx4eNYD5wCkjGZ/+H1eWXrLH2+i3xfbPKpW6DzylhlckFEYSi1wEE3gWXBRmPvswd3d/mbSzPBvQQcAWzfHzuOcTq0V4Ksy4HWmwteqUwpvKBrfYrMuHCjgRyGa+PsIcmBBaY1VSXF8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCgK8OqQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCgK8OqQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93959C4CECD;
	Wed, 20 Nov 2024 15:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732114875;
	bh=9PHHaga7qdizbZvNAUY9ymsRQ2ooNPqub9YJW56h3qo=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=JCgK8OqQcukJuFdvCEamxuF8FRP0ALaJfShK1alyCkI9pE567w8EL6hovidWUf7Kq
	 iCaKt9Hf/G8Duke6dldLjeGGPKOy50F1RhLF8WFt6c/Tol2uyJWutt4qiOUEboiGUJ
	 uhZc7z09LMtTaiZv6ezoIFaf4LQ78FrfAaz9TNGBsBwkcjkAoJqr1R9HYR+H0vqfxC
	 gFpWand3PtTHwFEK2sI+nYG2g2exfWjvaEU+Xr0XGdTupSK6na2vAyaIekCE67C9cR
	 KJBMy6hXV7KxO8wIfBm4fF8sjdQYzvSoASqSn2hNL72W7J9dMuEikUd+z1fk7gzna0
	 3D2kWvzvuFeLQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876B8D711AA;
	Wed, 20 Nov 2024 15:01:15 +0000 (UTC)
From: Manas via B4 Relay <devnull+manas18244.iiitd.ac.in@kernel.org>
Date: Wed, 20 Nov 2024 20:31:13 +0530
Subject: [PATCH net-next v2] net/smc: Remove unused function parameter in
 __smc_diag_dump
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-fix-oops-__smc_diag_dump-v2-1-9703b18191e0@iiitd.ac.in>
X-B4-Tracking: v=1; b=H4sIALj5PWcC/4WNQQqDMBREryJ/3S8mxoJd9R5FQpp89S9MJEnFI
 t69wQuUWQ0z8+aARJEpwaM6INLGiYMvRt4qsLPxEyG74kE2UgnR9DjyjiGsCbVOi9WOzaTdZ1m
 xuZt3S71r+1FBma+RSvdCv8BTRk97hqEkM6cc4vf63MSV/8dvAots15mWOmWcejJzdrWxNXsYz
 vP8AQMX4onMAAAA
X-Change-ID: 20241109-fix-oops-__smc_diag_dump-06ab3e9d39f4
To: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, 
 "D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, 
 Wen Gu <guwen@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Anup Sharma <anupnewsmail@gmail.com>, 
 linux-s390@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Manas <manas18244@iiitd.ac.in>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732114874; l=1964;
 i=manas18244@iiitd.ac.in; s=20240813; h=from:subject:message-id;
 bh=RbsJs9xT5OEaPMfZxEp4gByrXVK8Tp/HwiFKPToZuMU=;
 b=yfq/MghKcAbWF2qD5/LJadh+UeQjXsDoTsZHgqNhsXBu6xgQOkxlNUQcm72cf00XWAsS1LtfI
 zJETk+AZQLPBFg9IetHj1TxzztZw8rKQKxbrxrGK0GKQFYphxDoB8eP
X-Developer-Key: i=manas18244@iiitd.ac.in; a=ed25519;
 pk=pXNEDKd3qTkQe9vsJtBGT9hrfOR7Dph1rfX5ig2AAoM=
X-Endpoint-Received: by B4 Relay for manas18244@iiitd.ac.in/20240813 with
 auth_id=196
X-Original-From: Manas <manas18244@iiitd.ac.in>
Reply-To: manas18244@iiitd.ac.in

From: Manas <manas18244@iiitd.ac.in>

The last parameter in __smc_diag_dump (struct nlattr *bc) is unused.
There is only one instance of this function being called and its passed
with a NULL value in place of bc.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Manas <manas18244@iiitd.ac.in>
---
Changes in v2:
- Added target tree and prefix
- Carried forward Reviewed-by: tag from v1
- Link to v1: https://lore.kernel.org/r/20241109-fix-oops-__smc_diag_dump-v1-1-1c55a3e54ad4@iiitd.ac.in
---
 net/smc/smc_diag.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index 6fdb2d96777ad704c394709ec845f9ddef5e599a..8f7bd40f475945171a0afa5a2cce12d9aa2b1eb4 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -71,8 +71,7 @@ static int smc_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
 
 static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
 			   struct netlink_callback *cb,
-			   const struct smc_diag_req *req,
-			   struct nlattr *bc)
+			   const struct smc_diag_req *req)
 {
 	struct smc_sock *smc = smc_sk(sk);
 	struct smc_diag_fallback fallback;
@@ -199,7 +198,6 @@ static int smc_diag_dump_proto(struct proto *prot, struct sk_buff *skb,
 	struct smc_diag_dump_ctx *cb_ctx = smc_dump_context(cb);
 	struct net *net = sock_net(skb->sk);
 	int snum = cb_ctx->pos[p_type];
-	struct nlattr *bc = NULL;
 	struct hlist_head *head;
 	int rc = 0, num = 0;
 	struct sock *sk;
@@ -214,7 +212,7 @@ static int smc_diag_dump_proto(struct proto *prot, struct sk_buff *skb,
 			continue;
 		if (num < snum)
 			goto next;
-		rc = __smc_diag_dump(sk, skb, cb, nlmsg_data(cb->nlh), bc);
+		rc = __smc_diag_dump(sk, skb, cb, nlmsg_data(cb->nlh));
 		if (rc < 0)
 			goto out;
 next:

---
base-commit: 59b723cd2adbac2a34fc8e12c74ae26ae45bf230
change-id: 20241109-fix-oops-__smc_diag_dump-06ab3e9d39f4

Best regards,
-- 
Manas <manas18244@iiitd.ac.in>


