Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8F048AE0D
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 21:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785879568; cv=none; b=ZXvqBKE8lYWtlUu8w8mCk9AuNhb9QRwrZmqzJhCfDMG6V5cl3cJfwuYYzsUn4O8s6lEOVWR/ASJzum3gsFVljiXGbn7aICDjjdeOvnpwYzie+9xyIsatNifa7AKkfTlxAdyA5z9xenl9sQqrpyKJEDIJWBp1Ms1VFWgoDye5mDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785879568; c=relaxed/simple;
	bh=c0jHAqCKMMLGqElB9P0Zc/ra2eBZhFiyVAmWgrs0dpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nzj5DHx1CcTcSHqyKcqrzs8iQSb7MGZBm6zNRO3RVbCBSsfdI66s5fsxlIR5kSAJzKPNJuXclJ/CDg4o4BmxqpHOHBvjrvQTcrEnjzh7JpRPcwcH1O2As9t976rvyCkUlXNosnpUnJHQ9IZKi1rTZ9lUTxqICO8XdqR/4BeMheQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6SmcVV5; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6SmcVV5"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbe3fed2f58so198383a12.3
        for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 14:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785879564; x=1786484364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AVzPi9qdoodMQ73+79x+gG0Fw90m+Wzneqb+ihmK6gQ=;
        b=e6SmcVV5jfw8sFCaBIZVZtBXSOxoKLFnviVSNIVBBcs83peqIeViDqgJEo3jqTaY0d
         TR8/fjJmVb0hWCcPgGzufqhPCPutU31Xm4xTfJoOCv6teNG29GSiL+L0E48vQwy5jTQ3
         mA/7d2LQHgAacqW5xthUbx9uNEk+JkD2qY11MFzXLwQ3R2pLOPBZe7zB45/csv+uoVDa
         9WBxSmYkNRb7LDzTaCqlF0pqpjxCWtK+Z1M/wOpKyeQhWFNuWI4k+dD1XSOnqQGgwCaD
         djz6ydqXVE1xwO6hy1v8ouFil/C2+7sha/+kWbmx/lw4a3dnppMvVTTnxiIv4qzYIqVj
         2M2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785879564; x=1786484364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AVzPi9qdoodMQ73+79x+gG0Fw90m+Wzneqb+ihmK6gQ=;
        b=SaIETZTnUf9j6yRl+lyw2PX/Yq44zp+TyLHt2xSBC7oldzioDOfZ28+4cefJMLwCSd
         cmslb25hBNLg8ktp1vrH7z3zLIegZ3Oe6lQIMweFDyPwrQtypsAXj7mv1XJuxEKmZUAT
         2IwVz387jxHks4o/6KcGjGQvonsLFIbKx2ASc+qL+y5r2mc2qwc7kNk2dTaco8oJ0T4S
         pD/i0PEGzccEPh+qKQW4L7FTHI0Z6HyBFPSpg90kPL5x6rOzTrURPuc8D1REgAl0hpHP
         OHqYTeJO7U9ONFMX3W9YGVYU6adQnZ43Ey0RVvlVL212yCwtQ1g960pQmgwt3LUsjgKp
         SVZg==
X-Forwarded-Encrypted: i=1; AHgh+RqFs6n5cojyaB4bg0l0ERhl5BSpYbMJHiQODLxY/EF7vZ/WpPhdKYC444jn8/lPaqMDKNmP8HwiumZy@vger.kernel.org
X-Gm-Message-State: AOJu0YyqC8U4K2eiJ/wV1KHnUiFbJpz8aLjuDQlSyOvkQV/LxNXyiCG8
	Dk+bI8m2neQAC/9R8e84+53K8c6r8gCfxGV2j3PkkcLUZNbrpUdFjnnM
X-Gm-Gg: AR+sD106Anyre4crnCh6pdixIotO3JwtPh7oO2E5v3U5SyXBzTcFgn3+UBwLEvrXz5F
	6MKLYIVGKWJPHGSz4xV7ry9IiEDPqrystsIaxbBMqcjqNw4jeffh+0+J5dtSHpG1NPic0AaCCsh
	z0J9PUxzgAS2ZmRzkBRM7EUgFazNj1QfQxgbbPLsIhDb7daYLjAHFz7rCjkwru6mQLTsiuL4dFr
	LF+SGU6/WyeLXXo9MzX1mJVOTcTPDWqpegr83Y/rAohw11MZLTPuFlSs9pnQJMcneL/1GajEFM/
	h9HS9OPW8ZKGI0Ww/38oIOZFE+iTaletGIYgycp6DR9FqOSgYlNmt3i4RoqPnZDH7nUg9ZbFrBn
	OwML1cOj7T2iYYtQJLp4JobI80zlD7JOQFrW2QUNCmkw8IUiKoNI4NnTsElsIsH6W0ECh7wcaPj
	Twu2fBtseOqc3a5Qw7OPikjUWCHd5WWeU3VkbdYCP/QW87TLT83Jgd9Juo/Pnz08kIDfaCS4Eo8
	l12yok8pDiBmucjdK5XoUw1VCSshhiqvmIH5/KpD80=
X-Received: by 2002:a05:6a21:a38d:b0:3bf:6fb1:ce0d with SMTP id adf61e73a8af0-3cb85ea3663mr1881337637.21.1785879564575;
        Tue, 04 Aug 2026 14:39:24 -0700 (PDT)
Received: from LAPTOP-DPAKMOI4.it.purdue.edu (pal-210-106-74.itap.purdue.edu. [128.210.106.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315867bc341sm14727379eec.27.2026.08.04.14.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 14:39:24 -0700 (PDT)
From: Yifei Gao <gyf161023@gmail.com>
To: "D . Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Ursula Braun <ubraun@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	Yifei Gao <gyf161023@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net/smc: fix sock refcount leak in smc_switch_conns() error path
Date: Tue,  4 Aug 2026 21:39:17 +0000
Message-ID: <20260804213917.3413525-1-gyf161023@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smc_switch_conns() takes a reference on the socket with sock_hold() before
dropping conns_lock to prefetch a tx slot. On success the reference is
released by the sock_put() after smc_switch_cursor(). When
smc_cdc_get_free_slot() fails, however, the function jumps straight to
err_out without a sock_put(), leaking the reference and leaving the socket
unreclaimable. During SMC-R link failover with an exhausted backup link
this leaks one reference per failing connection switch.

Release the reference before jumping to err_out. The err_out label is also
reached from the smc_switch_cursor() failure path, which has already done
its own sock_put(), so the put must stay at the get_free_slot failure site
rather than at the label.

Fixes: c6f02ebeea3a ("net/smc: switch connections to alternate link")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Yifei Gao <gyf161023@gmail.com>
---
 net/smc/smc_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index cf6b620fef05..04c6ce608ec7 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1148,8 +1148,10 @@ struct smc_link *smc_switch_conns(struct smc_link_group *lgr,
 		read_unlock_bh(&lgr->conns_lock);
 		/* pre-fetch buffer outside of send_lock, might sleep */
 		rc = smc_cdc_get_free_slot(conn, to_lnk, &wr_buf, NULL, &pend);
-		if (rc)
+		if (rc) {
+			sock_put(&smc->sk);
 			goto err_out;
+		}
 		/* avoid race with smcr_tx_sndbuf_nonempty() */
 		spin_lock_bh(&conn->send_lock);
 		smc_switch_link_and_count(conn, to_lnk);
-- 
2.43.0

