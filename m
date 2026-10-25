Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792900993;
	b=mybzmaA+mY8XRHiivfD0oY16g0UgdTHn8r7pMxEbBTQ0hwpSN+qj3aAF2aLsfH2ShiEk
	 D8ZvSxUZ1JjQxInyS7vDSIlItwDNjaiJiqf3gI5y3qs62kjBjsWm+FhQdqnZPZp98E4cM
	 vb5JoqFByGLOj5JA1xJM8MdFUp7PZr4rPqVudgxLzRTS4JsXI88sL2tzkppkN1cvBzGYp
	 shViIBbfIqFlLryYVKH/9OeoNKC42o5r2UEiHKjuapb4zmzdRYJj1KgsBqvfP0yVB5Pbd
	 xQ3vT576HsqEjLG3eD48jnXQzqehO3WP9PZSpZ1f5Sc+N43Qh92VYB+PvqGMbjvx6Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792900993;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=bXXWN0U2LwSgs5yFSiYomIOkF6F+3ijFGiBpJE+lZgY=;
	b=LpyitDEEkd07R6mLFVzLZRk5t5fyC2CB+1L/m6uQ1gHZjQghtm1gNl7rNiKrwAuSVQ93
	 QORNmSdH2L4Novpjn86iH6TYdmBgTyR1/0+N/GAv5+zTkW0jHvIuThVTUxhXRgWriden7
	 wpavu8HS0nptFcBpGxMiZowgUEJAJhy8Jdh8IxZCpKBpmQ9tz3ciPEDn/XTUxerw0qM53
	 xBjhL+sBG+CkViEkWdvuFE+89HtjRfiasCJVNwv484A5e+5k7rCEpnsblZq56Vrp4VyBv
	 UI8UAv9QjctlWN7JSqUDMML4UjuqXkb777bnKaYhcnaPLAAh4YH7qhaSScKUHq24AMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DNKNW9T7;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E581A606A323
	for <linux-s390@vger.kernel.org>; Sun, 25 Oct 2026 04:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E581A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DNKNW9T7
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3adb9cbb0c3so208086a91.1
        for <linux-s390@vger.kernel.org>; Sat, 24 Oct 2026 21:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792900992; x=1793505792; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bXXWN0U2LwSgs5yFSiYomIOkF6F+3ijFGiBpJE+lZgY=;
        b=DNKNW9T7kGfS78TEh9BVgxXbbjDsK7FmBqAhYSl/KQ+eTH7raGVvtdvg1NUc98VoRU
         K+t6Nc6VFF63JU0nm30Oaoo7PWDuZqaJa/VGdjf1oEl1vKQws6xUEHvpigr1aU8XJKW9
         ARzBEbRowo/1PB62yadC/gAYjKkjUksvUtAWL5KNMcmW0it4u1TdjgS9IKYCVSUT/B4B
         5LmSmhiSWh9nYee/Q8xH/mbjnKv05BsnHAXumcfsZ1MU10WIv7HErjsSADO0LjhEhqVG
         kuOy2JsugMVzT+/xQMFxDhtCn1QSY8Ludbs8xew8apip8FeKjXp7edLasQnaxkyYNus2
         mgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792900992; x=1793505792;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bXXWN0U2LwSgs5yFSiYomIOkF6F+3ijFGiBpJE+lZgY=;
        b=qpRxedo29LgfwIaEh425WR8vYiePs8Ny/EDCf9BhNOko2TjyzZ6nLOzYW1J1bPLt/i
         22R9L0qmANoenyEqgSMEzjBhYZb8vivE6lS0XQ80TY5FiRJGkLvMHIejrQ8q7GOwAglK
         QdJDacPeyAqIor7sfbbBt4/G64gBVJZLmIm55Z44j3t/rb4nVZoccSUSBliUN08aF2D+
         zkB6q6/QwwFtvFckZlbi+7C29roYT4AvX1O0/CnKL6Kkdo8VRz8SD8ebo9YJldwWvLrV
         T3zLyd2CswokT1CNU3+epmiGsYhhMJn40RqNBuiwS7kuNllDc1YAmsHo3c7RqlMFCN6h
         2QDQ==
X-Forwarded-Encrypted: i=1; AKwUvBzne5RZNjl2LCBns668B7SsVVIpefQ5xJYSB4QfekNTMtUTbSs1lvwI19cZkFfseyxTVrwz395QRGwm@vger.kernel.org
X-Gm-Message-State: AFq9FYJoP/A6IpiaGTG6XPi/SRMge5XxPdIUN4Y5KGjz1WwLqL/MY6J/
	Anu7HsHD/hU3HAOt4D3/arQmc/+F85wOGYiSmWwnGAw27RlVOCNKFEWJ
X-Gm-Gg: AYBFou393RV6zxoIybMsn+0eNwAxJ2V8GsJSZJVRVJ3vGqdDsPJqZR8Z8NvNSuFhpOB
	dTBR6Qm4L+OiiwuGka6w+LmtH/BnzLPXR0xGgRUTtnxB7XcvCTAsq4DuPOZMgu5QINk1wWvzRDj
	qccycU2kwIlxh0X/zCihGUv7rLly1oNOUjA5fVX7eONO/JO705tNkW3uGykBWicOw4WzheR66V2
	SRth4+Wllzn6wvQA+K7ICm4MWAqn0DvEDDcPuRw27r5+K/4NxJGcMiSCLBp8Mo2lTLpW5MilXBm
	lyaQSDxORstvDG5/MFWUHa+N7Xol7AyTP9Aaa/3wEhnWJ8Dr4gcXnKRkl+COrh02BNt2d/YGgC2
	K3tjwV73BpounoRwHY2PSLFG+a7TI1yVws0cQVQiP07xosr2r2UgSQckP6jHEls78Wvac5pqJft
	dtAR/lb2DBgbv+IcBuP3wDGg9wjxNAzx/UB4JyE5mfZo+WJbU8Mb1bXZNmZ5Tdd26+6rRKuaUJx
	Ezxd4pfpThH7rfV4hwpMtH13WtET9m5Yq6tvgaR68Ff2eIFE/EaU5aihwHh3HNTmjah7Fhdt7hZ
	GSqZ
X-Received: by 2002:a17:90b:3c0d:b0:3ac:a7ee:6785 with SMTP id 98e67ed59e1d1-3ade9b35f05mr4994498a91.1.1792900992309;
        Sat, 24 Oct 2026 21:03:12 -0700 (PDT)
Received: from melokc-laptop ([101.90.152.206])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeb82761esm2921587a91.0.2026.10.24.21.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 21:03:10 -0700 (PDT)
From: Anfernee Cao <anferneemelokc5@gmail.com>
To: D. Wythe <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, Sidraya Jayagond <sidraya@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] net/smc: fix possible recursive locking in
 __smc_lgr_terminate()
Date: Sun, 25 Oct 2026 11:53:35 +0800
Message-ID: <179290097759.51540.15412712294727302463@gmail.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

syzbot reports a possible recursive locking in the SMC listen path:

  WARNING: possible recursive locking detected
    kworker/0:2 is trying to acquire lock: sk_lock-AF_SMC
      at __smc_lgr_terminate() (net/smc/smc_core.c:1580)
    but task is already holding lock: sk_lock-AF_SMC
      at smc_listen_work() (net/smc/af_smc.c:2463)

smc_listen_work() holds new_smc->sk while calling
smc_listen_decline() -> smc_conn_abort() -> smc_lgr_cleanup_early().
smc_conn_free() unregisters new_smc from lgr->conns_all before the
early cleanup, so __smc_lgr_terminate() walks the remaining
connections and locks another socket, not the one already held.

All sockets use the same sk_lock class, so lockdep cannot tell the
two instances apart and reports a possible recursive acquisition.
Annotate the per-connection lock as a nested acquisition, as
smc_listen_out() already does for the listener socket.

Reported-by: syzbot+7ea1f5efd5de7e24f1de@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7ea1f5efd5de7e24f1de
Fixes: 2c7f14ed9c19 ("net/smc: fix LGR and link use-after-free issue")
Cc: stable@vger.kernel.org # v6.13+
Signed-off-by: Anfernee Cao <anferneemelokc5@gmail.com>
---
 net/smc/smc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 9974149659c2..5911368ae520 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1577,7 +1577,7 @@ static void __smc_lgr_terminate(struct smc_link_group *lgr, bool soft)
 		smc = container_of(conn, struct smc_sock, conn);
 		sock_hold(&smc->sk); /* sock_put below */
 		read_unlock_bh(&lgr->conns_lock);
-		lock_sock(&smc->sk);
+		lock_sock_nested(&smc->sk, SINGLE_DEPTH_NESTING);
 		smc_conn_kill(conn, soft);
 		release_sock(&smc->sk);
 		sock_put(&smc->sk); /* sock_hold above */
-- 
2.54.0.windows.1


