Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED432D1F44
	for <linux-s390@vger.kernel.org>; Mon, 11 May 2026 06:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778480518; cv=none; b=u/IBUeE0VVzbaCuWitOpJ34yEcJLSq5gj9XukiNglT7a7JeIyuDA4nVkQr2BXVbnJexkvzw6WeqN/6yJFo9oaerqKemp81XXsO7MAkOIXTz23LZVZjLsyRUNMxzFPQCsHBBwoRg7OXYg2mzrACiO0wr70AQ7ScL0Vp/zUIe10SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778480518; c=relaxed/simple;
	bh=A7y3fzKCF+AJo3foiCNqQdkebzrP/Mi0PRjx4WBSn84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r75QvHRThLTm8e0NIOQ5vptBu5hXPEaGFmjM04mUShU8PH4q9Qonv1OAH/67v175G6Bbptw16QhJO6ifJ7XOufuf2pv3my/hQkxu8eGR5k5FUjZgTtdqFeNvn8DtOHXJO1rw/804oa8ZVaPDjZunK6hRvv9mRzJjvGEFjz9OJ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=NBqYZFdh; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="NBqYZFdh"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12c8ccc7755so5459992c88.0
        for <linux-s390@vger.kernel.org>; Sun, 10 May 2026 23:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1778480516; x=1779085316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cLVkZzC6n6tfb7crw+XJ4fgX5lyHGF1s/SBlI8VZgbc=;
        b=NBqYZFdhZq+RQK96TfcXFzU4STpoQTG0rofHiPtAuknXhXQH20V43EsufTJWZnLn49
         PkWK4MXWjFjAcEhxyoHsDS9Gzh1iW7okoTs2izRAx2oEhZLYNNqZFr9lRNp/NBzHNxRg
         4r2afnXeb5cSpUZyFzEXfuxLkeiaKJB0tT5QcDk1MtEVKG9MCfZVDZq62OypBr5vhVO3
         HnKgW+zyLjoPE4hRy6M1Y/dGXySjSl3Rq3kLOKFWccGJs4XfFnJ+lI+EulOHJLqOZWHD
         Pif4qIWzIOOmKDjWKH7Hzd8kZgAm9q5/fWXxyi5/h2tCc86JYwK+DpMP59uGlMhQS7BO
         ZP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778480516; x=1779085316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLVkZzC6n6tfb7crw+XJ4fgX5lyHGF1s/SBlI8VZgbc=;
        b=dyB7x2FRAaStsBI3IRRKGRNHVX6RTrBSzBtvjSjKufvu/ku48jQdYUrMFjqxSp/c+q
         LknWOSvfyVIgWOuDGz6PszV+xZ5pUXvBYydnoVWFfSwaOPfSqvjkjjdKFjsljkhbWOm3
         h/E+7sxF8eg6P39rCla2bD43jzvjIx2qZ6uKlIVeyVxmnBnwJ5vt9NZHCT6e/DGdel/c
         sF4pZo2ph+mQFbNSetGKjGnUnQDdal66+m6M9HPD98qEWutnkF6nTtBr03nB7EpOxrEc
         +00oOusi8sbqs9awikQSg6LYSelRN3T4oBUu+g1fUv18MHqeSXjYDh3t8Ly/nLVDUrMY
         PanQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ZmEcw3QZV3GUcZMy8LpvE20WJcVUKjdOvA8wExhhi+EdmZWR0gAoKjIR+igSGOd4fk30l23vTln1s@vger.kernel.org
X-Gm-Message-State: AOJu0YwEJK3VXKlA7YasLwBl94DLmeMTMuW8MUGlou3JtR6BTW6Ihqxr
	WNK9VWO0jXYunL/iDJIIsWKNtNKEvcyDnMF/mmVRT1ZX+qyOREBaILeArTu8YnQv+w==
X-Gm-Gg: Acq92OGbLUs93fDxfQXnDI28dFU46LGJtg/Z7fhgXafyB9DqU/hGcuvaBmMOWO/vhbC
	4RinqKdL2XRQSP922DDjLbCeqe75G7+7cuyjp22ovgQWHzedIypYWc7PFqLDSiwfi5J5he4sbxi
	/utjgS+ddjKcjE68vffpKxlUjf5sGlZP0MDjEfnQwJEGFPUNuda7HQKO60uUTJ04NED5tXf08jE
	Z6lA0ixrYJkXXLuNzR5WozpVBSTiu6q349Y7Fc/mncRSXe1RtZld6fcvgEuLzKgsQu3b1HhzG+g
	sRMagyrKsO0BOaKZY8w+cO3ODM9UUxpnfPezrv+2PcTV3a0M7OAyo/mQJolLXPvcwCk9lPu6dg/
	r2hlGISS4eoyyUkbKajhRkT+xRw8BOctCC0nJPDYaj1VDcgTKJlt/Kg7sFx9cSjxozI4qqJacaf
	lPJFIu8jRkiUwPFGgY5/FmpL9fZRfyMtOlCFFGq3xD/EfUjX+SAS5aUg==
X-Received: by 2002:a05:7022:439b:b0:128:d24a:a5ba with SMTP id a92af1059eb24-132a83f77d3mr4278742c88.20.1778480515748;
        Sun, 10 May 2026 23:21:55 -0700 (PDT)
Received: from p1.scai.dhcp.asu.edu (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13278210d40sm16083102c88.4.2026.05.10.23.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 23:21:55 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	ubraun@linux.ibm.com,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] net/smc: reject CHID-0 ACCEPT that matches an empty ism_dev slot
Date: Sun, 10 May 2026 23:21:38 -0700
Message-ID: <20260511062138.2839584-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the SMC-D client, slot 0 of ini->ism_dev[]/ini->ism_chid[] is
reserved for an SMC-Dv1 device. smc_find_ism_v2_device_clnt()
populates V2 entries starting at index 1, so when no V1 device is
selected slot 0 is left in its kzalloc()'ed state with ism_dev[0] ==
NULL and ism_chid[0] == 0.

smc_v2_determine_accepted_chid() then matches the peer's CHID against
the array starting from index 0 using the CHID alone. A malicious
peer replying to a SMC-Dv2-only proposal with d1.chid == 0 matches
the empty slot, ini->ism_selected becomes 0, and the subsequent
ism_dev[0]->lgr_lock dereference in smc_conn_create() faults at
offsetof(struct smcd_dev, lgr_lock) == 0x68:

  BUG: KASAN: null-ptr-deref in _raw_spin_lock_bh+0x79/0xe0
  Write of size 4 at addr 0000000000000068 by task exploit/144
  Call Trace:
   _raw_spin_lock_bh
   smc_conn_create (net/smc/smc_core.c:1997)
   __smc_connect (net/smc/af_smc.c:1447)
   smc_connect (net/smc/af_smc.c:1720)
   __sys_connect
   __x64_sys_connect
   do_syscall_64

Require ism_dev[i] to be non-NULL before accepting a CHID match.

Fixes: a7c9c5f4af7f ("net/smc: CLC accept / confirm V2")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/smc/af_smc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 185dbed7de5d..12ea3b6dbc64 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1400,7 +1400,8 @@ smc_v2_determine_accepted_chid(struct smc_clc_msg_accept_confirm *aclc,
 	int i;
 
 	for (i = 0; i < ini->ism_offered_cnt + 1; i++) {
-		if (ini->ism_chid[i] == ntohs(aclc->d1.chid)) {
+		if (ini->ism_dev[i] &&
+		    ini->ism_chid[i] == ntohs(aclc->d1.chid)) {
 			ini->ism_selected = i;
 			return 0;
 		}
-- 
2.43.0

