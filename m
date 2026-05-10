Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9E3371CFF
	for <linux-s390@vger.kernel.org>; Sun, 10 May 2026 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778430928; cv=none; b=LI4dyhEhO5jwEWZDxQCdJp7g0sWsve8DDYYxkIMYQ/nEIfqRAgVRVEGywVmZfT5cq/CCKzKk2yuMGMvBtvTBGvz1Uu8Dv0t8ndBWM2mJivNvFmR2QlMxnhQYPV8/A5LYwb9ZQt9jBtp1KARKnTh0yJ5zQbNAPaE7z4hvXfprTkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778430928; c=relaxed/simple;
	bh=dD6l8VmKuNQkIv7tvRgwMxIbtAjjBGjAsfRUM+v1bss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I342JU7WhN3xQtrsBTwcrmlJB6pzPgCCc1L8gdWEZymMVWalOLaAhLn50F38uXMfrhHTp1nhG7yf+r6jaGkskMTL8bqci+YrJEEYAMNTJYJxA58fsnY2qwr63A5hz3AAHpRGaxwWmoLE1hjbueDV2MVxRDJCKTVRnnm31aebMcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Byym8Uok; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Byym8Uok"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso31703215e9.3
        for <linux-s390@vger.kernel.org>; Sun, 10 May 2026 09:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778430925; x=1779035725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=66E1wRA9xWgEOR2dqWlyPjo6zh/YZ58R9fKD8OAxMUY=;
        b=Byym8UokMGbCigue6+UHQHftxYr4A1Ck8dCM5TM6lCjSw3uQm8fA4UducmVbErqPUd
         v1JvAcihawzU3zCdgZbLkVMM1/Ez/0OHe2/AaKqt5Y6LeYKfjxqD2CtVsQrqOiOApgos
         8hPsNmDq8ByqJ2re1VN//bpUTFteTHa6CDdbl1X7elx3XZuuoItbwx6qhPT3LLm7OpuB
         qrBFoAI2SGdmCKzdqwjlT7FSptud5jn2Wdl7KMbSdsLjeN4A9hzAc5KjpsyWFRpJRgP3
         bMfp73Q/ZzVbSCtJmVZYgbwr5vSK4NLTSurMKWQlMHsP+DKh077e14ZlKWlleUN84ksV
         226w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778430925; x=1779035725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66E1wRA9xWgEOR2dqWlyPjo6zh/YZ58R9fKD8OAxMUY=;
        b=GNyP83Bed+LzEL0i4pWI+XR7lQyIt66wh4NiQcW6N+tZU6Didl/j+XnsfWC5/2F97X
         NRZkd3LZj8DMy5XaxYEqRlQSN1r0+P+J6/KoZbxPBl7yYo8EunXU1EKO6MYzgUaRIgd4
         VRxgMZ6r6vaZXd6yLuLK2KDOwERghhJO7Z3Akp9IcIZzUZPWyiLWcNCAYkW3H64z/QI1
         tbPbVxo4K91C+OacQ7GHTYRslf4Afw1sJOd7a8EpJivpVSVjjrubOjOHxkhKl47kET3V
         XTzW5TUglIq2mdNU/N8ZxdxnvOEIku2DAazycERBiM3zcWpKTYHpJptoCtV53SkywH8J
         1v9w==
X-Forwarded-Encrypted: i=1; AFNElJ/t/Bs4L8Dc0t78XNj2m2IdsVRhlKlNcykx+RHMdiYHUJwl2QBK+8GxKtw/EadvaTHdbyDHOzs2qjy0@vger.kernel.org
X-Gm-Message-State: AOJu0YwkzZ7hfezDQkNGUtkApf9RstRuActi7EXOxp/WIH7t8W7Hw/OJ
	JoIx9NmUsHd7YNRAltKic55pOKs8huGlI5EesRov0UoRaY3mI0VvsOll
X-Gm-Gg: Acq92OGAoP4LvbRdrsUWYRMFU15YW4bBQMHDBJDuAU8Pb9vRS5F/NQVBBpO89ovBT4R
	wwNghdgfJYWBqE3uCJ517wYYaAbesC2wiLMjxmlXMSgUvgyHCUrwS0LjQWSJLwR92f70LILiW8R
	JXM1nxsn58E/zeWvR9A0EEvOzBAme4jprwu1IB+57U5XjKJMFAySKWkfp/zBi4etll6bB6TZsB8
	SfYOAUBWAotCoBUQCD49ndsbvTTUuJ2kuBxbuxSaIafkkbYxIVPm3qvUIyi0ntOmkP/iQRWI3Zm
	OBwKn3MDAtsBYztJ+9JPW7rUoEKKTO9ZAOOs3TI4uWyq8794g493MCe1NiW+e8Wz/lnlqtPkLhl
	qXL6eExzI3XMWz5j9HnR+fxukrZ9Ym/L7ZIN0MVccbDw//U2NPlGG/ZVhit2jirfxPX43jwrayA
	CJrcjZvCCAQWiIpiVCIobz9fwZbeQGqkBVvJ5MFtfOwE3RYS97A8R+u9KAYUw=
X-Received: by 2002:a05:600c:696:b0:489:1c1f:35df with SMTP id 5b1f17b1804b1-48e51e215a4mr190222805e9.10.1778430924757;
        Sun, 10 May 2026 09:35:24 -0700 (PDT)
Received: from kali (93-41-117-77.ip81.fastwebnet.it. [93.41.117.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6fffba52sm143706015e9.3.2026.05.10.09.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 09:35:24 -0700 (PDT)
From: =?UTF-8?q?Nicol=C3=B2=20Coccia?= <n.coccia96@gmail.com>
To: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com
Cc: mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	nicolo.coccia@leonardo.com,
	=?UTF-8?q?Nicol=C3=B2=20Coccia?= <n.coccia96@gmail.com>
Subject: [PATCH v3] net/smc: fix sleep-inside-lock in __smc_setsockopt() causing local DoS
Date: Sun, 10 May 2026 12:34:13 -0400
Message-ID: <20260510163414.16651-1-n.coccia96@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A logic flaw in __smc_setsockopt() allows a local unprivileged user to
cause a Denial of Service (DoS) by holding the socket lock indefinitely.

The function __smc_setsockopt() calls copy_from_sockptr() while holding
lock_sock(sk). By passing a userfaultfd-monitored memory page (or
FUSE-backed memory on systems where unprivileged userfaultfd is disabled)
as the optval, an attacker can halt execution during the copy operation,
keeping the lock held.

Combined with asynchronous tear-down operations like shutdown(), this
exhausts the kernel wq (kworkers) and triggers the hung task watchdog.

[  240.123456] INFO: task kworker/u8:2 blocked for more than 120 seconds.
[  240.123489] Call Trace:
[  240.123501]  smc_shutdown+...
[  240.123512]  lock_sock_nested+...

This patch moves the user-space copy outside the lock_sock() critical
section to prevent the issue.

Fixes: a6a6fe27bab4 ("net/smc: Dynamic control handshake limitation by socket options")

Signed-off-by: Nicolò Coccia <n.coccia96@gmail.com>
---
 v1 -> v3:
 - Resend via git send-email to fix webmail whitespace corruption
 - Rebased against netdev/net tree
 - Added Fixes tag
 net/smc/af_smc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 185dbed7de5d..da28652f6810 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -3054,18 +3054,17 @@ static int __smc_setsockopt(struct socket *sock, int level, int optname,
 
 	smc = smc_sk(sk);
 
+	/* pre-fetch user data outside the lock */
+	if (optname == SMC_LIMIT_HS) {
+		if (optlen < sizeof(int))
+			return -EINVAL;
+		if (copy_from_sockptr(&val, optval, sizeof(int)))
+			return -EFAULT;
+	}
+
 	lock_sock(sk);
 	switch (optname) {
 	case SMC_LIMIT_HS:
-		if (optlen < sizeof(int)) {
-			rc = -EINVAL;
-			break;
-		}
-		if (copy_from_sockptr(&val, optval, sizeof(int))) {
-			rc = -EFAULT;
-			break;
-		}
-
 		smc->limit_smc_hs = !!val;
 		rc = 0;
 		break;
-- 
2.53.0

