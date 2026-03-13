Received: from outbound.baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6095819992C
	for <linux-s390@vger.kernel.org>; Fri, 13 Mar 2026 05:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773379414; cv=none; b=rjhnYW6K5HPug6AOtLn8VGGzm7FMK6w9iKTZzjqrrrXd1aPc1VVD7UBLVlHvzdXuqFFKWj8c7ifZvA4JBc3+Eh/5Ih1bg62cSyKcCkZacPKpV86yd+bQUvS4K5sjfWL/FSHtI80AzMkn32ap0bmzwZXUIdtLjJ+AiypYMBkxbaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773379414; c=relaxed/simple;
	bh=0DzqQVd5sdVit0crh65Ule9biZ+yg4+64e70odhKAMo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e5WOK/DXwT620eLZ9o4BYMYk2WKjDde+A41EBjvoYfvNpTIbiGbrlJUdmNZUHikvm30HMp7i6XS3yHRM08LkPecCqwgiHpwL/Ruxrtb4wlba9eFJeqEtL0QSagLoIL4lLziVsB1SOTqSytok4+LKcyIw3kz/rZuUHc4qIPojDtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: Harald Freudenberger <freude@linux.ibm.com>, Holger Dengler
	<dengler@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
	<gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
	<linux-s390@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] s390/pkey: Remove synchronize_rcu from pkey_handler_register
Date: Fri, 13 Mar 2026 01:23:12 -0400
Message-ID: <20260313052312.2389-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc9.internal.baidu.com (172.31.3.19) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

The synchronize_rcu() call after adding a handler to the handler_list
is redundant because RCU readers will either see the old list or the
new list. Removing this synchronization point reduces the blocking
time during handler registration.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/s390/crypto/pkey_base.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/crypto/pkey_base.c b/drivers/s390/crypto/pkey_base.c
index d60cd98..c2e29d6 100644
--- a/drivers/s390/crypto/pkey_base.c
+++ b/drivers/s390/crypto/pkey_base.c
@@ -60,7 +60,6 @@ int pkey_handler_register(struct pkey_handler *handler)
 
 	list_add_rcu(&handler->list, &handler_list);
 	spin_unlock(&handler_list_write_lock);
-	synchronize_rcu();
 
 	module_put(handler->module);
 
-- 
2.9.4

