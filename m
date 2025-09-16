Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E876B2ECD15
	for <linux-s390@vger.kernel.org>; Tue, 16 Sep 2025 04:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998177; cv=none; b=RyLY+nUzaU5fTZM/zTSttwoBzUW40zQ1DNCt0bqY3yF0lDcf/aZ9QwShRrpXK6zxSKqBVpMHAl5fD+rRkpZz5nzVJU5fMwycFXmTZ7BNzbMlLrvkyYjTm/zA2Uifk0eqB25SLBigu6H5Ktd+NsnJSdVvJQAUp1oZ2BnHom7AbOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998177; c=relaxed/simple;
	bh=dy9spvLipBJ0oxpRy6D3U8JeqM1cA+2DUbEARoiEIho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rXd9KQ6yVxNQPOZs9OBHXISEemHeFpgK5W4Ka8MM4CAIL+lW9r/eatNds5Uv1M7LwpU1DsiNLxcvTzRSv0CZsyKNYLV1QOPI8zdh/xNCsK9nKPypzDcY9Jhct3M5FTU9sGR6XnZaAENFtscOZZ6MOTFpRFxg1Is8hff7HJVhLww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEJwboRo; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEJwboRo"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-263b1cf4d99so15669915ad.0
        for <linux-s390@vger.kernel.org>; Mon, 15 Sep 2025 21:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998174; x=1758602974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kee/jWM05xMj5MjToYK8a9EUY/mguZ7xPQQnB3cJ53E=;
        b=WEJwboRoA+7Q/dtbpjLY1iSOzyDv2c7nLD5tzESh/xoo13VNtR/TuEemvpBow5vvEn
         H7ry4eNsUi4IQV8DjKDpbV4r0L5NEiNdbzxgZ9uF1g6TLnrD4vmU5xiiUDdvRUp82yHX
         5XmgyQKs33tjnmDUjMrqxpFjpFB6RPqKiIYNPBfImWxQHKjvIJQIuhSjg3OwcMtI6Sfo
         i4HnREvhWsFyA7lO140ZMwL9JUpp5QX2ZSunJSuv006RmJnQTtQVVYSSc8waQPaTuRg6
         2dO06Xyt+iuxUmp3SRacsW6eS/lXTsOf7kwLF/UWzELlusoGLpEM/leXstF1sKj4podi
         n90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998174; x=1758602974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kee/jWM05xMj5MjToYK8a9EUY/mguZ7xPQQnB3cJ53E=;
        b=tCeM28UD86aWKQq2OFlxg67mZG7ajzjntOPWiPGm/d3iU8DvcSbC7I7YIocxb609nJ
         B7ieFwXcEIbl25+TR8NX6MvDlUpZcUztPV2WW8l6/HPgUAhkpezd+c/YrN3+rXJFbtP7
         UQWSOPI6lhNFH8nvQH/lc42BNIxDKy8yCa2x2K0pICu+15H46OtzcOrv+0h5aoZP9Bvf
         e0LaBreBKGHUBM6IHKlxnuN9iCk08C2WBb0jjsvjNvFjxqtZ2KlUBf99CFRX7AjUx6Qv
         V9Yh9ftGaLHaauw8m4mUiLOXex1/rturVgTlgODXw+GOw1s15dAuNTe4N+km3G6xYwQl
         tJFA==
X-Forwarded-Encrypted: i=1; AJvYcCU+kA0s9pFKwftyK2YRZ3NhwR/oJA58YuGRAwRMtDP3E43A4CrXzloUDshJQ2yWURcOazFqNZcvs5wG@vger.kernel.org
X-Gm-Message-State: AOJu0YyHemlkKq/9LOTxGLImqBJbEFsj/u2U83CPr+QlwOMIWp+ecIAm
	eBjdqsdRO5FcQYcNvtk8iL8Z0xEID1Vco3MHICx1fKmMe1UolAvHPSoG
X-Gm-Gg: ASbGncsbMnE6JVcLM5eL9eCdIxNbnDO7oQevWYwt6+OJ/7+SvzL70LdKFpZvoRy0J2r
	V+SNrE0HgnmoaGDX8kY9npxedJOrwBCogBTEr8QGUZqrrK7Nh6xOE2FcT0Wd0aDpLOji2LNP9W/
	l6OsHXklF/lvYMvhXiFqIPXNApQ5HtBsbFBMbCmNvASGr7I81o5V11TlvnulpBWJWkQ8jgHjklw
	QXclhjENkGl9VBJmFihcTedUVJcCjLeS9bDC3XYJXSRHAjgjaYpS4qNqL9rmMHCPaPsB2qahZxS
	F1+zKuaP9ptC5VpjZDvaHvzZOvdVLMoPj+4qkzUYwLb/zTh9zv3cY3HHJpAoxNaM5Ag8tVHcotU
	nv/5Id4Doa0ePsq4TXo3b7tIp8QAg8C2mhWzyiOc=
X-Google-Smtp-Source: AGHT+IHQsp/jp2h5qh/u2y0fwJLYw3kUJFgybrRxf3n883LnUrw88kxlxQMidQOFwo4KtZaOVgbKQg==
X-Received: by 2002:a17:902:cecc:b0:267:a1d5:7372 with SMTP id d9443c01a7336-267d151fba1mr14211985ad.4.1757998173983;
        Mon, 15 Sep 2025 21:49:33 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:49:33 -0700 (PDT)
From: pengdonglin <dolinux.peng@gmail.com>
To: tj@kernel.org,
	tony.luck@intel.com,
	jani.nikula@linux.intel.com,
	ap420073@gmail.com,
	jv@jvosburgh.net,
	freude@linux.ibm.com,
	bcrl@kvack.org,
	trondmy@kernel.org,
	longman@redhat.com,
	kees@kernel.org
Cc: bigeasy@linutronix.de,
	hdanton@sina.com,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-wireless@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-s390@vger.kernel.org,
	cgroups@vger.kernel.org,
	pengdonglin <dolinux.peng@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 12/14] net: amt: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:33 +0800
Message-Id: <20250916044735.2316171-13-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
rcu_read_lock_sched() in terms of RCU read section and the relevant grace
period. That means that spin_lock(), which implies rcu_read_lock_sched(),
also implies rcu_read_lock().

There is no need no explicitly start a RCU read section if one has already
been started implicitly by spin_lock().

Simplify the code and remove the inner rcu_read_lock() invocation.

Cc: Taehee Yoo <ap420073@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 drivers/net/amt.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index ed86537b2f61..aaed9fbc7526 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -295,7 +295,6 @@ static void amt_source_work(struct work_struct *work)
 
 	tunnel = gnode->tunnel_list;
 	spin_lock_bh(&tunnel->lock);
-	rcu_read_lock();
 	if (gnode->filter_mode == MCAST_INCLUDE) {
 		amt_destroy_source(snode);
 		if (!gnode->nr_sources)
@@ -306,7 +305,6 @@ static void amt_source_work(struct work_struct *work)
 		 */
 		snode->status = AMT_SOURCE_STATUS_D_FWD;
 	}
-	rcu_read_unlock();
 	spin_unlock_bh(&tunnel->lock);
 }
 
@@ -426,7 +424,6 @@ static void amt_group_work(struct work_struct *work)
 		goto out;
 	}
 
-	rcu_read_lock();
 	for (i = 0; i < buckets; i++) {
 		hlist_for_each_entry_safe(snode, t,
 					  &gnode->sources[i], node) {
@@ -443,7 +440,6 @@ static void amt_group_work(struct work_struct *work)
 		amt_del_group(amt, gnode);
 	else
 		gnode->filter_mode = MCAST_INCLUDE;
-	rcu_read_unlock();
 	spin_unlock_bh(&tunnel->lock);
 out:
 	dev_put(amt->dev);
@@ -1327,11 +1323,9 @@ static void amt_clear_groups(struct amt_tunnel_list *tunnel)
 	int i;
 
 	spin_lock_bh(&tunnel->lock);
-	rcu_read_lock();
 	for (i = 0; i < amt->hash_buckets; i++)
 		hlist_for_each_entry_safe(gnode, t, &tunnel->groups[i], node)
 			amt_del_group(amt, gnode);
-	rcu_read_unlock();
 	spin_unlock_bh(&tunnel->lock);
 }
 
@@ -1343,11 +1337,9 @@ static void amt_tunnel_expire(struct work_struct *work)
 	struct amt_dev *amt = tunnel->amt;
 
 	spin_lock_bh(&amt->lock);
-	rcu_read_lock();
 	list_del_rcu(&tunnel->list);
 	amt->nr_tunnels--;
 	amt_clear_groups(tunnel);
-	rcu_read_unlock();
 	spin_unlock_bh(&amt->lock);
 	kfree_rcu(tunnel, rcu);
 }
-- 
2.34.1

