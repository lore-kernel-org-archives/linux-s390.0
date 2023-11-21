Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5523B46535;
	Tue, 21 Nov 2023 10:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqM9ioDn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1583C43391;
	Tue, 21 Nov 2023 10:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700562993;
	bh=Br1SkmNs2wmxWtCfzlRvkihDMx+ev4HQgVz58LlvuJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eqM9ioDnWDYdrf47n7Fr+BtuSZC4Gg/CsWiMHkyqPmowW5WVa/Ramv6XL7VXoQvjd
	 2Vv8xGBifzOwiM2JapDt2wMFF6AarpQtr9G5AAuDYM1zsbaRo7tUhRtpbMrDtfprMG
	 dKEkkfct6vdxIhhrZ8m/3fm72yeTiAqEtPsTgQdKQif6cEnhh6CRrIsm6mLjqZaRjq
	 3bK4LCrSBYOauRyZSTZLAUoAD6HUrRzradOR604vaD+TZOCmtLzMuoJ2mzJlhoxBq+
	 n/y9/z0YPsAuhrKn+o/wGZFe1FoCMEGwKjux/V3uNQXhTpa1eU31k/4U9IdckLiqt5
	 RVCYBp9a68BLw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org
Subject: [PATCH 1/6] tty: con3215: drop raw3215_info::ubuffer
Date: Tue, 21 Nov 2023 11:36:21 +0100
Message-ID: <20231121103626.17772-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121103626.17772-1-jirislaby@kernel.org>
References: <20231121103626.17772-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clang-struct [1] found raw3215_info::ubuffer unused.

It's actually not used since 2004 when we switched to kernel buffers.

[1] https://github.com/jirislaby/clang-struct

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 drivers/s390/char/con3215.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index 99361618c31f..34bc343dcfcc 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -89,7 +89,6 @@ struct raw3215_info {
 	wait_queue_head_t empty_wait; /* wait queue for flushing */
 	struct timer_list timer;      /* timer for delayed output */
 	int line_pos;		      /* position on the line (for tabs) */
-	char ubuffer[80];	      /* copy_from_user buffer */
 };
 
 /* array of 3215 devices structures */
-- 
2.42.1

