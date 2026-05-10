Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC252E5429
	for <linux-s390@vger.kernel.org>; Sun, 10 May 2026 22:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778452012; cv=none; b=ggT/GxsftUkqnpPuTFZnuYrzch0oEgJTWqpvJbxnRX3Y6kPZg1PRTF6m1Fs99qAq6diri2OAcTAkGIrh6Zm6a119X0sGBYFHMMhkoRdckIGopVFQBjXEjNh80PNu4DB+rRP1VMSjrL8BnmBj3TdbSD9WAnIVi+SbXZNmj6XwKYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778452012; c=relaxed/simple;
	bh=bRTtC/Y15xDEtxte9f/6vRbkFyBjJbqPWN5T/9gK6dA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J5W4YprnTI4cSb5mlGYL0/AjdJTz3k5o2rs0RE+UFozRrZWjwNzCdJ/LxG0GUg7KkVoQjvX+wtfN1tZm0NohG03oly64+8GdynwRdYnH8JjTFu5I0/v1Ed6/G/nbRxJU7Ui7mdGhrXxx6NSgMUDCTgEtnzbKwsKU2zx9DGI7IdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=LPHcRNQp; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="LPHcRNQp"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2c15849aa2cso4469941eec.0
        for <linux-s390@vger.kernel.org>; Sun, 10 May 2026 15:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1778452010; x=1779056810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+7jw5q6CV7UA5J8SrJGgRjMCaga/xFBXiIaTtBtIkq8=;
        b=LPHcRNQpyA8LHU0CD4BSba/AFLiUCtkxJozbnzrEHCxUCAa3Jt2rRDOkHVMcewCRgK
         dHljdlQ0IaBJOUGstUuI+9mR9gxE1xCjGnnJxhLUB9EyTyyjBs2scdZElAEnPauVJtgj
         v9LF1RjJ34FqWKhpHbIXFH+DUNw+Ko3E3MlUAG3Ok8Xh/jr+aGOrDiRSTLjzZubxcJ5n
         7UGTVEIPD7pJK1itWfm6o27iNJrn3gpF+Li2h87gxFixzcKrM+DB+lxyNvEybQzDV8k9
         iIfaXeRgDFv89hBfgpVfkFne2n9ZEFxQ+wiVwudLw0yt44rixeaCcK8q6aDSbfSynefP
         nBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778452010; x=1779056810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7jw5q6CV7UA5J8SrJGgRjMCaga/xFBXiIaTtBtIkq8=;
        b=Ae3dsM1sAQqZxCcFsJG2jLFpHBlqG8oLBtA0Z2U938IF0uDs2+ErK14sxtxWiKeFW6
         XzBPQcjfI85z2KmReLyHfTkngAfnu6f0/ke6dw7dJxQDI8e3cVB7P/J1SFIaDsw4kINP
         Gl05Uhv0vtHdlskdRXYK5B/KD9QPOMuBcf8gVIObM502Rg4ldaCQbHd8EtONSuEmBdCO
         j801KjeapAn4veViItSPsG9UllyYanItYVsOe5LRSv7DN94zJITId4UsXkUWFJNcIGHw
         Q5Ck16DYnkI8S7ikQgjSTOL6zyAJG/yLFZgoIjXAaJ7dnDArD/5doUFWiL651t5ISUcV
         T9Gg==
X-Forwarded-Encrypted: i=1; AFNElJ8+lnWw7Mk4ZgGhp5SLZpjiSTyRPnuq3QAx0MBxrVsDa7+xE7yzmsXagrUrzucKM8zzAr6YFw5UBGGM@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcg8tafY2AqvJUVFRRNVJpjoFh9rDtVExCKyK5CnKmKo+b4mQv
	yRxFfSddWYjJOorOeHDpj6Y63mFn3hClV8ogoqe0C8z2wQ1dnKdoWFRh708NQrmf3w==
X-Gm-Gg: Acq92OHhdcZs/IQ7oYUDGFzGh/tkbpkq/iapVmT0yPMwDJ628YXyg9TzdIaKefupJG1
	awRqh33R0h96C28IJpfL6psDZ6VisxLJ9gC03piBRVoVzNJNK7VUFWxz5+MC3q8khGGzjSONMgw
	SjyRPPS6TYmKh+n3Jx/gnNwMRu0zUio7mQKBQCxW7EeITkt2BCIXo3C2didDtDHa0s94/XyGJgp
	/4qj2m8GvJsl1Y4eFHuBCPzbXZ2eADj2c1OtLUzXUk2eYcYKECEkAz3E7VPX6gf3giTqubDzE2D
	3VzwS1eAprZ6scq98F8QSewc/NrE5GDJkEDfQvo/0SRKU9DjTInZmRS1w61BiLH7UbPFZTBciz5
	6/Snau6b1XW9dHUUl8qxgWPZIPmC1PXbEuvarJKEeR/t46ooc99pAlZuCCoMAlhvkFtj/uOkUDt
	xU28MarKO24QIvwM6aXfZNKSXHDZ6jQjbv2sPRIU/lqhZQLFRWyK8qJg==
X-Received: by 2002:a05:7301:578d:b0:2ed:935:aa33 with SMTP id 5a478bee46e88-2f5482684a9mr10241346eec.5.1778452009918;
        Sun, 10 May 2026 15:26:49 -0700 (PDT)
Received: from p1.scai.dhcp.asu.edu (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8862d429asm11143902eec.12.2026.05.10.15.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 15:26:49 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	wenjia@linux.ibm.com,
	sidraya@linux.ibm.com,
	tonylu@linux.alibaba.com,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] net/smc: avoid NULL deref of conn->lnk in smc_msg_event tracepoint
Date: Sun, 10 May 2026 15:26:40 -0700
Message-ID: <20260510222640.1230720-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The smc_msg_event tracepoint class, shared by smc_tx_sendmsg and
smc_rx_recvmsg, unconditionally dereferences smc->conn.lnk:

	__string(name, smc->conn.lnk->ibname)

conn->lnk is only set for SMC-R; for SMC-D it is NULL. Other code on
these paths already handles this (e.g. !conn->lnk in
SMC_STAT_RMB_TX_SIZE_SMALL()). With the tracepoint enabled, the first
sendmsg()/recvmsg() on an SMC-D socket crashes:

  Oops: general protection fault, probably for non-canonical address
  KASAN: null-ptr-deref in range [...]
  RIP: 0010:strlen+0x1e/0xa0
  Call Trace:
   trace_event_raw_event_smc_msg_event (net/smc/smc_tracepoint.h:44)
   smc_rx_recvmsg (net/smc/smc_rx.c:515)
   smc_recvmsg (net/smc/af_smc.c:2859)
   __sys_recvfrom (net/socket.c:2315)
   __x64_sys_recvfrom (net/socket.c:2326)
   do_syscall_64

The faulting address 0x3e0 is offsetof(struct smc_link, ibname),
confirming the NULL ->lnk deref. Enabling the tracepoint requires
root, but the trigger itself is unprivileged: socket(AF_SMC, ...) has
no capability check, and SMC-D negotiation needs no admin step on
s390 or on x86 with the loopback ISM device loaded.

Log an empty device name for SMC-D instead of dereferencing NULL.

Fixes: aff3083f10bf ("net/smc: Introduce tracepoints for tx and rx msg")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/smc/smc_tracepoint.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_tracepoint.h b/net/smc/smc_tracepoint.h
index a9a6e3c1113a..53da84f57fd6 100644
--- a/net/smc/smc_tracepoint.h
+++ b/net/smc/smc_tracepoint.h
@@ -51,7 +51,7 @@ DECLARE_EVENT_CLASS(smc_msg_event,
 				     __field(const void *, smc)
 				     __field(u64, net_cookie)
 				     __field(size_t, len)
-				     __string(name, smc->conn.lnk->ibname)
+				     __string(name, smc->conn.lnk ? smc->conn.lnk->ibname : "")
 		    ),
 
 		    TP_fast_assign(
-- 
2.43.0

