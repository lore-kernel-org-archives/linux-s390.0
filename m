Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A948F647;
	Sat,  9 Nov 2024 06:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731133726; cv=none; b=K51bvuEEohsnOvCIXHbdcUPsohB430I1RVgqJCySgIebOGzDiofUjJ4qml//b4ImlvwTIDATV8FUm0cn7RCJeZdRDQx4uf6kE4Rv8n/ytdUk4mEfbzJvJWRX/qMD2Z0+6PGMpV0ebaaaDbSTKbvJpYtq63y17P7xJd4Z8tosjWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731133726; c=relaxed/simple;
	bh=BbW/oL25Xft/VAwDwDmWDCWb0CV85/g+avDhCUs7c0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qeqouNsFqEOLHfFPHEbgi3tw7bKyE3a10hP3I+kEtGIVzH1jl84pwrRWr6aszxK5zWrktMjWGr+GjSImMysIM020MM+BY861JC6uy+u8QIUNuviBNu8YJnFBtICYHCFo/q3tFoGG6H+TsIsktUiDeZBMngP0sIukbKJeIX0Z0ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avGdlif0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avGdlif0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3588DC4CEC6;
	Sat,  9 Nov 2024 06:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731133726;
	bh=BbW/oL25Xft/VAwDwDmWDCWb0CV85/g+avDhCUs7c0s=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=avGdlif0zUfb8u8Yjk1Y8YvaQHGlnVHY0Cyx1XqMjBpCekM8lFm0OYkRUfLJPGDno
	 3T1Ck1T4Ri0jR3FbC2H9TV6xkjdHZV11/cgGNImXJ9ImU8Y1Q/kufaxeoS4XJEahk9
	 UUHZ92ogDdsXRm39gFxtL4o42ZrAEHF/yYltA+qf/Oj7AbCyvhKssuYgplSrJW/Gn5
	 UD1MG2PgR0YEPgde1XroI0qdfLNjTQx2GBJaHBqur4FoT+2NJ569YvTeM1SiNKNQZt
	 AgMjq2EBjYPyfn7s4K9u/114BEuGdLwESRoR9JoTez/3PiOU6nCIseie1mdRUByrdP
	 DinqlZ2voW4gw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B94D5C0FC;
	Sat,  9 Nov 2024 06:28:46 +0000 (UTC)
From: Manas via B4 Relay <devnull+manas18244.iiitd.ac.in@kernel.org>
Date: Sat, 09 Nov 2024 11:58:34 +0530
Subject: [PATCH] Remove unused function parameter in __smc_diag_dump
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241109-fix-oops-__smc_diag_dump-v1-1-1c55a3e54ad4@iiitd.ac.in>
X-B4-Tracking: v=1; b=H4sIABEBL2cC/x2MQQqAIBAAvxJ7bkErAvtKhFhutYdSXIog/HvSc
 WBmXhBKTAJD9UKim4XDWUDXFSy7OzdC9oWhUU2ntTK48oMhREFr5VisZ7dZfx0RVe/mloxvzdp
 ByWOi4v7rccr5A9z2hXNqAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731133722; l=2754;
 i=manas18244@iiitd.ac.in; s=20240813; h=from:subject:message-id;
 bh=uj59/apt0R4vc2BSfem7J5/pEkXFApMSXA+V90Ln/PY=;
 b=DBoFQEraDrMRc9cmU2gZR0vrq1jy1s3x5PYP93B5LyVZszthzhOfKkZvePz8D4qjnDZDjFrRP
 M+n7bDZGW5wCCa/3dAG6xrV6Fyr2pVM96n6kO+YAoWBsc1ZI4oKxGlv
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

Signed-off-by: Manas <manas18244@iiitd.ac.in>
---
The last parameter in __smc_diag_dump (struct nlattr *bc) is unused.
There is only one instance of this function being called and its passed
with a NULL value in place of bc.

Though, the compiler (gcc) optimizes it. Looking at the object dump of
vmlinux (via `objdump -D vmlinux`), a new function clone
(__smc_diag_dump.constprop.0) is added which removes this parameter from
calling convention altogether.

ffffffff8a701770 <__smc_diag_dump.constprop.0>:
ffffffff8a701770:       41 57                   push   %r15
ffffffff8a701772:       41 56                   push   %r14
ffffffff8a701774:       41 55                   push   %r13
ffffffff8a701776:       41 54                   push   %r12

There are 5 parameters in original function, but in the cloned function
only 4.

I believe this patch also fixes this oops bug[1], which arises in the
same function __smc_diag_dump. But I couldn't verify it further. Can
someone please test this?

[1] https://syzkaller.appspot.com/bug?extid=271fed3ed6f24600c364
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


