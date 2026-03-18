Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6262FF160
	for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2026 06:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773816539; cv=none; b=Y3EFbkncKak/c9PUXVGnWaPXAJoI9Ig6ptqGCEsov0akogtx2DKo0AzcNBoBalKmYNBQS49IWpe3eW/Xec593fN8x8rnxCp5jGlzsVAys+5xKmdEa1IK9GEv0uEnUI+tD7/NwwbFNxE+xgjsLd+uFIZ4gcTX28VJm2Gq9dNEBLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773816539; c=relaxed/simple;
	bh=Qj1QkGketFTLM6FhMiga1uXkk9E+QIhjnrMOjTAq2ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PazMCrC2L4/AtJlynEV1jx1eWbG9p6PEFioOSita6ZaiWDpYRLBsmruLOX5hwx++9PCSzaE63Ba9WV9b/4ctRGQ1vFr5dHr5Y0ISRpwRMgTrFSJ9P/5OP5nculu/C7JZzICrrIsjHygEo2MLN9iLMOzDjO4FuS43ZsNFPOynw/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbT3p7Iw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbT3p7Iw"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ab46931cf1so5342035ad.0
        for <linux-s390@vger.kernel.org>; Tue, 17 Mar 2026 23:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773816537; x=1774421337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cwVGV5+seuNEQDXpmjKxLE/WMiIEl6PzK6G5vJJXXZA=;
        b=YbT3p7IwofRR4B71gvIvW4EYvPkkHFAZKnxd325boEmEBFUL/kF+aumEjLzU6wTeVi
         J4wJ1MlBDsN9y0A5iwvtdSJ6WmSy1fgLfWvB1FcCA0c8hEajcFDp+KLme9ciDi1sDa9W
         wnj86JwfQquO42V7nWuafBoYJRLPlLE19MJG+CpRN+HqUHcmgB/T5sXbp7udQ4DobENp
         Xa/wkzsznNFEVBZm/0k3L+K7vwji1nj4hG6WTj/rGJcx2MP6k5mzBQJ72ADF+v+qddPj
         LNIAfnrimodMiZ9rkFX+rnCICM9/mmWOs4sgDi4BOs8m1Dd4IA6kPtUJd0AnV3ZN6DcP
         1olQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773816537; x=1774421337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwVGV5+seuNEQDXpmjKxLE/WMiIEl6PzK6G5vJJXXZA=;
        b=SF8IkfdIiO2iOPx5AJ4lrUbTfyXervaikZH+u6/yYgtDAUCegHM81gUJAKtRwBksvZ
         /0Y7P8ou/as6NC0x7hJcaZtFtF62/m2QtZacF2MoHscTKZAGB4X07hA+fLBm0Cn8Xc9T
         FnJnVuULEp0gBvYHH8co10w62MPVAGQAm4Mtc/L0eYz0IZxxVX9h/lr1C86SjppC2pIA
         h0Qm+TPOGAgHrUbdLdehXlj6fGHgmWQJK3YwyZ0riwiWv7jEtYuLdML/aEG35W4cs0lZ
         AKMWSvDmksYSWpNos3Qwph34HWQ/u0TLs68JkZl71hhzKafanEa2cXqzMD6xP2/IV6x0
         ibig==
X-Forwarded-Encrypted: i=1; AJvYcCU1rOEi8Oa9zABxJ9I179y/0umpUYdfpAeEFlPcLK9QuEX1sNciZFBT3mJhUqfexJ1log1IbjQ83u6C@vger.kernel.org
X-Gm-Message-State: AOJu0YyN1pzZVRyn1kFj0JXa38wV2rS7hKbr4IuPDRs7JJO86EJ0Y6Af
	T2PhjO7Jfwx6Hjl06aZiYsg8IdallhTgbO1cLu0JK90GY/rb/zxLpH7h
X-Gm-Gg: ATEYQzxqdMkgx3WiCpiIKwBZ8j1ccZ579jmLH8t5IBmmQx9pQFNr2mrYaNaUy7omGsx
	iL264aMBD7ClUkK+hMD9njLy3WMZxadiRacYPYsvrZBMPlKvjrC6eieyke4g9ySDTUTHiac+f52
	fMgeo8XxyQJdkhqCLOZ5Q7s/GcbVopAHvEg5aZiHH/y3BCpmGMWHqT3d5ZnXQXdwLYonG/H57W6
	xyr7CViByKS1qeFBRes9V5VZRmR4RdwRPemXB1aAAEhvCkJPNvZY8jJaEvfiBKZBXlq1RSniC+2
	TwSGBy9/RE8T69BeI2lo3/MTZphgVqCphPLn52VivfRkmMSR5s9ztm8Wo+aXyO/QzfMKbueL549
	2S3PUduXQhoGy6RUmhVFGMP4FXXLRM038jzdzvHX+xdDqMVcKE6gfkRSK3uPJ9SKmL4bpTS1z31
	F6MeRgzvPTxKrhjo5ZhKUSp+BFA58MOkw9
X-Received: by 2002:a17:903:94b:b0:2ae:5a38:96bb with SMTP id d9443c01a7336-2b06357efd3mr61873795ad.2.1773816536783;
        Tue, 17 Mar 2026 23:48:56 -0700 (PDT)
Received: from localhost.localdomain ([101.5.20.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e6315dcsm19262845ad.80.2026.03.17.23.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 23:48:55 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: [PATCH net] net/smc: fix double-free of smc_spd_priv when tee() duplicates splice pipe buffer
Date: Wed, 18 Mar 2026 14:48:47 +0800
Message-ID: <20260318064847.23341-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smc_rx_splice() allocates one smc_spd_priv per pipe_buffer and stores
the pointer in pipe_buffer.private.  The pipe_buf_operations for these
buffers used .get = generic_pipe_buf_get, which only increments the page
reference count when tee(2) duplicates a pipe buffer.  The smc_spd_priv
pointer itself was not handled, so after tee() both the original and the
cloned pipe_buffer share the same smc_spd_priv *.

When both pipes are subsequently released, smc_rx_pipe_buf_release() is
called twice against the same object:

  1st call: kfree(priv)  sock_put(sk)  smc_rx_update_cons()  [correct]
  2nd call: kfree(priv)  sock_put(sk)  smc_rx_update_cons()  [UAF]

KASAN reports a slab-use-after-free in smc_rx_pipe_buf_release(), which
then escalates to a NULL-pointer dereference and kernel panic via
smc_rx_update_consumer() when it chases the freed priv->smc pointer:

  BUG: KASAN: slab-use-after-free in smc_rx_pipe_buf_release+0x78/0x2a0
  Read of size 8 at addr ffff888004a45740 by task smc_splice_tee_/74
  Call Trace:
   <TASK>
   dump_stack_lvl+0x53/0x70
   print_report+0xce/0x650
   kasan_report+0xc6/0x100
   smc_rx_pipe_buf_release+0x78/0x2a0
   free_pipe_info+0xd4/0x130
   pipe_release+0x142/0x160
   __fput+0x1c6/0x490
   __x64_sys_close+0x4f/0x90
   do_syscall_64+0xa6/0x1a0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

  BUG: kernel NULL pointer dereference, address: 0000000000000020
  RIP: 0010:smc_rx_update_consumer+0x8d/0x350
  Call Trace:
   <TASK>
   smc_rx_pipe_buf_release+0x121/0x2a0
   free_pipe_info+0xd4/0x130
   pipe_release+0x142/0x160
   __fput+0x1c6/0x490
   __x64_sys_close+0x4f/0x90
   do_syscall_64+0xa6/0x1a0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>
  Kernel panic - not syncing: Fatal exception

Beyond the memory-safety problem, duplicating an SMC splice buffer is
semantically questionable: smc_rx_update_cons() would advance the
consumer cursor twice for the same data, corrupting receive-window
accounting.  A refcount on smc_spd_priv could fix the double-free, but
the cursor-accounting issue would still need to be addressed separately.

The .get callback is invoked by both tee(2) and splice_pipe_to_pipe()
for partial transfers; both will now return -EFAULT.  Users who need
to duplicate SMC socket data must use a copy-based read path.

Fixes: 9014db202cb7 ("smc: add support for splice()")
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
 net/smc/smc_rx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index d833e36f7fd4..c1d9b923938d 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -135,9 +135,16 @@ static void smc_rx_pipe_buf_release(struct pipe_inode_info *pipe,
 	sock_put(sk);
 }
 
+static bool smc_rx_pipe_buf_get(struct pipe_inode_info *pipe,
+				struct pipe_buffer *buf)
+{
+	/* smc_spd_priv in buf->private is not shareable; disallow cloning. */
+	return false;
+}
+
 static const struct pipe_buf_operations smc_pipe_ops = {
 	.release = smc_rx_pipe_buf_release,
-	.get = generic_pipe_buf_get
+	.get	 = smc_rx_pipe_buf_get,
 };
 
 static void smc_rx_spd_release(struct splice_pipe_desc *spd,
-- 
2.43.0

