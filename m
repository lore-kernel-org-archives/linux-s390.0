Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C37518A6D5
	for <linux-s390@vger.kernel.org>; Mon, 24 Feb 2025 08:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740386986; cv=none; b=aMYHbF2ceCRVAUpW/CRX8/bPFiZfn3zXdHrPWfRXSY6dPLdeJ89OIoIS/R6Z2E0g10TDDaf4roeNJmblPlnja3hTbzduxevPIjAVR7Emfi8/YjyS4pv7/WbpocLlZ+6MqZMqsBDaw6mNUsHEJ0Vf1QeQNTjyn9SMVRITIh1t1hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740386986; c=relaxed/simple;
	bh=ppiswH9vEMe6zxrVIfdb/Uf7gsEP/ONB4tqkdFbon6w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PPW77NjbS2YYP4xd+gnvDz5rPGCjhIcQK1mRGEibkjFB8o1mUfcX+cOziA3QfrHEd3pr+ewRUf685AWwktahmluBVLgdRStl3VRfJjoJS7wq194/W4Bzk54h9AsEsu5TeT1F8TPZpvX4IUqTQg2GNp+SGo+0KzK7I/tojEhooZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=GF6qsW0w; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GF6qsW0w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740386984; x=1771922984;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ufYlZ93Ge2Xp188K5bIdJcvQtBUhPoZGLKy/mc0m2VU=;
  b=GF6qsW0wJV03oaouHlG3VHwX84Z1nZC0A4JxgPRAX7RRNAnNvsH3G12W
   8kzI6+W2aCvAhR5JQW0M8gRCIjFeJZcu8Q6g4Oli+dJFcCo1ZXTVOkAPd
   e1W8jntF4gjL0hEPF99PQd7HMkgvesS1RUmz2FFnFNGPsxWU4iVmIWUoE
   8=;
X-IronPort-AV: E=Sophos;i="6.13,311,1732579200"; 
   d="scan'208";a="801405854"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 08:49:37 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:19703]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.141:2525] with esmtp (Farcaster)
 id 8a1959bb-673c-4a76-9be2-284d65e495b0; Mon, 24 Feb 2025 08:49:37 +0000 (UTC)
X-Farcaster-Flow-ID: 8a1959bb-673c-4a76-9be2-284d65e495b0
Received: from EX19D002AND002.ant.amazon.com (10.37.240.241) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 24 Feb 2025 08:49:36 +0000
Received: from HND-5CG1082HRX.ant.amazon.com (10.37.244.7) by
 EX19D002AND002.ant.amazon.com (10.37.240.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 24 Feb 2025 08:49:34 +0000
From: Yuichiro Tsuji <yuichtsu@amazon.com>
To: <linux-s390@vger.kernel.org>
CC: Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
	<svens@linux.ibm.com>, Yuichiro Tsuji <yuichtsu@amazon.com>
Subject: [PATCH] s390/net: Fix typo in a comment
Date: Mon, 24 Feb 2025 17:48:33 +0900
Message-ID: <20250224084833.3433-2-yuichtsu@amazon.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB001.ant.amazon.com (10.13.139.132) To
 EX19D002AND002.ant.amazon.com (10.37.240.241)

Fix typo in a comment.

massages -> messages

Signed-off-by: Yuichiro Tsuji <yuichtsu@amazon.com>
---
 drivers/s390/net/fsm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/fsm.h b/drivers/s390/net/fsm.h
index 16dc071a2973..e5011d32d64a 100644
--- a/drivers/s390/net/fsm.h
+++ b/drivers/s390/net/fsm.h
@@ -17,7 +17,7 @@
 #define FSM_DEBUG         0
 
 /**
- * Define this to get debugging massages for
+ * Define this to get debugging messages for
  * timer handling.
  */
 #define FSM_TIMER_DEBUG   0
-- 
2.43.5

