Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15001CD5DB;
	Thu, 20 Jun 2024 17:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906313; cv=none; b=artVaZnoj72LraHMrp77m00V164AejW+fATzN373fYJK9/kUyZ5IEYIlw53vW/N0cqLaIXmbXURGq64AwwzuQGmgWVpp1G1WUcUnqnG1DdMbxY95RZc8M7SZfgr3kiq47XnI2hqLXg0uOuZx+6bDUKXl35t8R2gGISQAE3pA2sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906313; c=relaxed/simple;
	bh=yUj0Y+PW1ytJyi+j5TbtjzOTkmnNG3+T5JTavbIkNlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0VUtlM5vfAWz15a77QYeZntFp1dmrQeK2FsNntMr4JYS3ZSbFOLzQ/Jz3ayTVPfNiqt9vzABkXGpI1QrwFSnSwEPoqgE0TEhRh91sPXTkD1biOUQgk+soeBXPiSFIErLXAe1QH05Z3fQb9JNjoEP0Z8L8Zb9BlHFlYYJnWsN6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UodKF5VX; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UodKF5VX"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c80657e4a3so397726a91.0;
        Thu, 20 Jun 2024 10:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718906311; x=1719511111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4ZNVeHwDlQoCLSBSWGAz09EiaWGr7H7R1MAc+9TBMI=;
        b=UodKF5VXGDYf+97aUtqqtVv+qRYvkgHw1FgT6MpVk1RmNNj98QJEpBra0u5mkuaMxy
         WYF9rEo2ARMuTOyLxpzi26OkRT7fL8mV+gfs6RMjzyJ8Rb2q8rFC6V+Yz8xhkeCBeaFr
         H4jyP9xncoXC9onCxcsmt+3C/X5NAYLG4E8Q//vXIVSMR378V8F/GdwAYKtgPtmv3GuW
         WkTJ4rgRy88q/AOltw9xpIIuYFa1sjGfMdbm8By8knWXfEP/3XqKApoJHii1Zwsbc6pF
         2eFtvcStKDT2CN5eUF3QwCiBiEJl0sywVfRCNHpp0HwgMVZ07xVENhzkgT7pOO4ppac6
         ENkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906311; x=1719511111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4ZNVeHwDlQoCLSBSWGAz09EiaWGr7H7R1MAc+9TBMI=;
        b=EuYQHgsE2Tn6sW2eWbpC3ZOVYKlNsdNz30PavFXQ9/aIh73X9GwV5Jk4g8MTjPlfN2
         PwQneYZP345JuoDHVXpyThI1O8GwMDAOGNdM0j/1cZB4zyo+DohZ4BiQYx5ReUYt/NiB
         asslckQEn+0MIIfU0Trfzv5XJHQxClTciLbmpDrp+xO2315SdLWUFDwYRLOcjUi+o+aC
         DBc8ApkjOGnBSm3ejydozXzxfxYAVbyn+c9n/aWIZWVL+8sbRR5tIP68LmwSH0/KDSGI
         3kh3jtX9EMllB0GfrFx59EuAP5fwRYpwcjRzIuIcJa+4118KqQqrLN+qKQal0H4yN1Jt
         Owcg==
X-Forwarded-Encrypted: i=1; AJvYcCW5kFNHRYJ96W3ehttdbw4jVbob1HUSXPrnxLA8PUbOkP/DoLlUb9tKQsw0BofkldcXfjqo2psyesvxKWJ4SpJdn+Z3nwNUaX/T5Ni/kTW/fsN+RjhPuQCynBVF1HHplE93hg==
X-Gm-Message-State: AOJu0YzfTiMcBQujzq4Fw6QLYJ5mxj4DuFdkbgnSQ5hXQrStKihRPES4
	kqlJxp8CAQNbSCAxs6r1E+dq4A4NZelVTZi66p3P6PCC23TAXQalW9W8OZykUfc=
X-Google-Smtp-Source: AGHT+IGQvEz1XDyV8hqESSgXyRr9H2vNsDwapE+wi9Cj5ayf2ki62AI5CWw/I1Sfogv5UmABjnUlEw==
X-Received: by 2002:a17:90b:3688:b0:2c4:e000:f811 with SMTP id 98e67ed59e1d1-2c7b5d98300mr5635707a91.49.1718906311353;
        Thu, 20 Jun 2024 10:58:31 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e58d3f93sm1998031a91.45.2024.06.20.10.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:58:31 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Karsten Graul <kgraul@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Alexey Klimov <alexey.klimov@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Alexandra Winter <wintera@linux.ibm.com>
Subject: [PATCH v4 29/40] net: smc: optimize smc_wr_tx_get_free_slot_index()
Date: Thu, 20 Jun 2024 10:56:52 -0700
Message-ID: <20240620175703.605111-30-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620175703.605111-1-yury.norov@gmail.com>
References: <20240620175703.605111-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify the function by using find_and_set_bit() and make it a simple
almost one-liner.

While here, drop explicit initialization of *idx, because it's already
initialized by the caller in case of ENOLINK, or set properly with
->wr_tx_mask, if nothing is found, in case of EBUSY.

CC: Tony Lu <tonylu@linux.alibaba.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_wr.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
index 0021065a600a..941c2434a021 100644
--- a/net/smc/smc_wr.c
+++ b/net/smc/smc_wr.c
@@ -23,6 +23,7 @@
  */
 
 #include <linux/atomic.h>
+#include <linux/find_atomic.h>
 #include <linux/hashtable.h>
 #include <linux/wait.h>
 #include <rdma/ib_verbs.h>
@@ -170,15 +171,11 @@ void smc_wr_tx_cq_handler(struct ib_cq *ib_cq, void *cq_context)
 
 static inline int smc_wr_tx_get_free_slot_index(struct smc_link *link, u32 *idx)
 {
-	*idx = link->wr_tx_cnt;
 	if (!smc_link_sendable(link))
 		return -ENOLINK;
-	for_each_clear_bit(*idx, link->wr_tx_mask, link->wr_tx_cnt) {
-		if (!test_and_set_bit(*idx, link->wr_tx_mask))
-			return 0;
-	}
-	*idx = link->wr_tx_cnt;
-	return -EBUSY;
+
+	*idx = find_and_set_bit(link->wr_tx_mask, link->wr_tx_cnt);
+	return *idx < link->wr_tx_cnt ? 0 : -EBUSY;
 }
 
 /**
-- 
2.43.0

