Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FE53BD64C
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 02:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787106808; cv=none; b=lEeHM5MJbl+4n9zx4ZgvKQxILpQn1HKaGP5dxhxnJsCl2WkOi7QfiC60Psdtxi6YZS5bRT7XUrer2F1j6JuuWBZMfrXg3vVhS4aPZtBTeA1UOvVJu02U+d0HiT5I7ssz3b+hB1HGtV+nHU28jUy6sLSyMbx1bu7fak4GzrKn7u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787106808; c=relaxed/simple;
	bh=ZuphiXNWb/uj/JB4yhd4PdsT5Aa34PaTeZB5VmeK4IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aktka6rMYENIhOGIZP15N8MjNB2ew7H0qYZjr1hEu3wkgIGLvJyVdLqWk8OXC+LOvzUezLNIdas9AN1T45uJoKuEh+CwoxzCw/1zcDpkypRE2270HEptPWVLTgugTbcsRbJSO1DMIL1IR1mzadfCMCg6hNolS36m+93AskkdArk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=YJtjBkjh; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="YJtjBkjh"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38101f85591so1530428a91.1
        for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 19:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1787106805; x=1787711605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MRyhD/De8I3XwFwEvg80m/qAYnxN4OiKijosBqahdgU=;
        b=YJtjBkjhF6tZ7VqSFQD7rYmpfwO50J2utmx1g9Lq80rpW+vCRayAolf35lb7M1ZEdv
         TCUyPEuyk1VegyifTgI5c+KEWz8lA7gQ6l1fYpymfOYgXMd1vNzXSMfq4jgmGMEFwTUp
         iHGiKyX4ML0aZFQ61qt3kjOoOpCm2147j+oXJEsjNdd6aGSSTYWzpqYnpWwPq1gslws2
         8FDmxRXrOz2FeF0R3+X4PI9vTggMRdLreCFuIp2HRXssOAZpdK60X2DhNtUmbzqjrFbw
         flXI50P/Sj/8yYh8NO+159dAkA85Q03FF5t8Lcssie4+abRZ7UlBWCEd4mYYN5Pzur5i
         4qlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787106805; x=1787711605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MRyhD/De8I3XwFwEvg80m/qAYnxN4OiKijosBqahdgU=;
        b=rpyPZRTv4Axktt4/RuYezFagWs63RkQTvJlRTfA9yVupmEl2dfGvRRmqXUl1l01F8d
         lkOhtGdV/HA1nO97QioiEPZasspASYcMeRFOGQeTG7xVla3tBb6lizYGsnp3n8t1vqIe
         Y2hC9xv7dy19urouj9ocFriQpktinFoEeMh+6DcwpyLW2g+MSsgtLaM8gGyw3HvbBCz9
         8P3U0JsnL2ycShfGBnszrQKII72H6Fgc5LeuWNnH+ZJZq2yRPoJ1O4IAwMzCilprgTxg
         x2Y6aIYYQdoN6arREZ48eOLLwANKfyStSpGexo1a8FX1ruDni6y+zpZLu2XtW77dTJef
         uDtw==
X-Forwarded-Encrypted: i=1; AHgh+RrB0X5nuBSKXDB2X/1MvRdU8iY941C+MJafPuglTffKnP/86AhQ+grAosG936iMvbDhkTrxY5C+ULDt@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu/ud15jfe+c8PiNjxRqWOFYuG2p1pcsQhnG8XvlC2WbQWiOlx
	paAAgsC4+GqTNNEkj4wd+wWfBNjX5v5+KHc5gK67HrpsW/zj0cvb9AbRk7yNVVNnLxk=
X-Gm-Gg: AR+sD12+BtungSC813N5SJKRPkoWYPBDfvo724NGhktYnfHDWj4+Cky90Ic55XGa3EO
	kd/v4TagFFThVGSK9M4TTGZyUBU/3H3HwWf3sY1pVPi8dOuK0dqaJxCsWOneeJLzqurAgt0ugW1
	bYFzELm/tPRHktgU6s8EyDC3dniH9la8LdBo27XClu5EIEcCRw+tDWL3RHiaCVtQi0SAxj0KGT9
	6TI1dvVQr9y9Lho2gwjSoGBvDgHYYJ3W1Q0KYvt8CkG80433LMDdP/S5ueIL/GiCNdnUKUqrCzu
	wxgq3i3DtEnNKt7wRo6DFopySLgxEcMM7By0MW5t6AHnRULAgri6rj/l6M1To15wpp2n4Ne2nCl
	VNnfclaiPYLAZXg70qu/sds2L7BJrAgXD2GXz1DxtUgf1WcfAZS/ITadfhG40zD+/V4F0SDLcDk
	R6k8jm6vJQBvQykKhad0Po86DYWXusR8zbkq9AciPrxWXG/Cgf2TZ7tkretP/nV8vgu3Mf
X-Received: by 2002:a17:90b:3a45:b0:387:d9cc:7dc3 with SMTP id 98e67ed59e1d1-3957fa83eeamr2551747a91.21.1787106804865;
        Tue, 18 Aug 2026 19:33:24 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957f9aaa12sm786281a91.5.2026.08.18.19.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 19:33:24 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: leitao@debian.org,
	horms@kernel.org,
	mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	guangguan.wang@linux.alibaba.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH net v7 1/3] net/smc: fix use-after-free of the LLC qentry in smc_llc_srv_add_link()
Date: Wed, 19 Aug 2026 11:33:04 +0900
Message-ID: <20260819023306.644849-2-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819023306.644849-1-yhlee@isslab.korea.ac.kr>
References: <20260819023306.644849-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smc_llc_srv_add_link() keeps add_llc pointing into the queue entry:

  add_llc = &qentry->msg.add_link;			smc_llc.c:1482
  ...
  smc_llc_save_add_link_info(link_new, add_llc);	smc_llc.c:1494
  smc_llc_flow_qentry_del(&lgr->llc_flow_lcl);		smc_llc.c:1495
  ...
  u8 *llc_msg = smc_link_shared_v2_rxbuf(link) ?
	(u8 *)lgr->wr_rx_buf_v2 : (u8 *)add_llc;	smc_llc.c:1504
  smc_llc_save_add_link_rkeys(link, link_new, llc_msg);	smc_llc.c:1506

smc_llc_flow_qentry_del() kfree()s the entry, so on a link without a shared
v2 receive buffer the pointer handed to smc_llc_save_add_link_rkeys() is
already freed. Before the Fixes: commit that branch always used
lgr->wr_rx_buf_v2 and add_llc was not used after the free.

Reproduced on an unpatched tree over rxe, with KASAN, kasan_multi_shot
and a link forced to max_recv_sge == 1: the entry is freed and read by
the same call, and the freeing frame is smc_llc_srv_add_link() itself.

  [    2.523161] BUG: KASAN: slab-use-after-free in smc_llc_save_add_link_rkeys+0x333/0x350
  [    2.523499] Read of size 2 at addr ffff8880052194de by task kworker/0:1/11
  [    2.523789] 
  [    2.523862] CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Not tainted 7.2.0-rc5-p0-g2c9dd296545d #35 PREEMPT(lazy) 
  [    2.523865] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
  [    2.523866] Workqueue: smc_hs_wq smc_listen_work
  [    2.523869] Call Trace:
  [    2.523870]  <TASK>
  [    2.523871]  dump_stack_lvl+0x53/0x70
  [    2.523872]  print_report+0xd0/0x630
  [    2.523874]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
  [    2.523876]  ? smc_llc_save_add_link_rkeys+0x333/0x350
  [    2.523878]  kasan_report+0xce/0x100
  [    2.523879]  ? smc_llc_save_add_link_rkeys+0x333/0x350
  [    2.523881]  smc_llc_save_add_link_rkeys+0x333/0x350
  [    2.523883]  ? smcr_buf_reg_lgr+0x2a4/0x660
  [    2.523885]  smc_llc_srv_add_link+0xaa2/0x1e50
  [    2.523888]  ? _printk+0xba/0xf0
  [    2.523897]  ? __pfx_smc_llc_srv_add_link+0x10/0x10
  [    2.523899]  ? down_write+0xb0/0x130
  [    2.523903]  ? __pfx_down_write+0x10/0x10
  [    2.523905]  smc_listen_work+0x489e/0x4d00
  [    2.523907]  ? kmem_cache_free+0x1c6/0x3a0
  [    2.523911]  ? __pfx_smc_listen_work+0x10/0x10
  [    2.523913]  ? release_sock+0x148/0x1d0
  [    2.523915]  ? smc_tcp_listen_work+0xb4f/0xfc0
  [    2.523917]  ? _raw_spin_lock_irq+0x80/0xe0
  [    2.523918]  ? __pfx__raw_spin_lock_irq+0x10/0x10
  [    2.523920]  process_one_work+0x633/0x1030
  [    2.523922]  ? assign_work+0x11d/0x370
  [    2.523924]  worker_thread+0x45b/0xd10
  [    2.523926]  ? __pfx_worker_thread+0x10/0x10
  [    2.523928]  ? __pfx_worker_thread+0x10/0x10
  [    2.523929]  kthread+0x2c6/0x3b0
  [    2.523931]  ? recalc_sigpending+0x15c/0x1e0
  [    2.523934]  ? __pfx_kthread+0x10/0x10
  [    2.523935]  ret_from_fork+0x36e/0x5a0
  [    2.523937]  ? __pfx_ret_from_fork+0x10/0x10
  [    2.523938]  ? __switch_to+0x572/0xdd0
  [    2.523943]  ? __pfx_kthread+0x10/0x10
  [    2.523944]  ret_from_fork_asm+0x1a/0x30
  [    2.523947]  </TASK>
  [    2.523948] 
  [    2.531253] Allocated by task 48:
  [    2.531399]  kasan_save_stack+0x33/0x60
  [    2.531570]  kasan_save_track+0x14/0x30
  [    2.531737]  __kasan_kmalloc+0x8f/0xa0
  [    2.531905]  __kmalloc_cache_noprof+0x158/0x370
  [    2.532100]  smc_llc_enqueue+0x72/0x560
  [    2.532268]  smc_wr_rx_tasklet_fn+0x474/0xa80
  [    2.532491]  tasklet_action_common+0x20f/0x8a0
  [    2.532714]  handle_softirqs+0x18e/0x590
  [    2.532886]  do_softirq+0x3b/0x60
  [    2.533036]  __local_bh_enable_ip+0x61/0x70
  [    2.533221]  __alloc_skb+0x732/0x890
  [    2.533384]  rxe_init_packet+0x16b/0x4f0
  [    2.533567]  prepare_ack_packet+0xb8/0x830
  [    2.533760]  rxe_receiver+0x495/0x96e0
  [    2.533933]  do_work+0x144/0x470
  [    2.534078]  process_one_work+0x633/0x1030
  [    2.534257]  worker_thread+0x45b/0xd10
  [    2.534424]  kthread+0x2c6/0x3b0
  [    2.534569]  ret_from_fork+0x36e/0x5a0
  [    2.534737]  ret_from_fork_asm+0x1a/0x30
  [    2.534907] 
  [    2.534980] Freed by task 11:
  [    2.535112]  kasan_save_stack+0x33/0x60
  [    2.535279]  kasan_save_track+0x14/0x30
  [    2.535444]  kasan_save_free_info+0x3b/0x60
  [    2.535625]  __kasan_slab_free+0x43/0x70
  [    2.535798]  kfree+0x121/0x380
  [    2.535935]  smc_llc_srv_add_link+0x9a8/0x1e50
  [    2.536128]  smc_listen_work+0x489e/0x4d00
  [    2.536305]  process_one_work+0x633/0x1030
  [    2.536482]  worker_thread+0x45b/0xd10
  [    2.536652]  kthread+0x2c6/0x3b0
  [    2.536794]  ret_from_fork+0x36e/0x5a0
  [    2.536958]  ret_from_fork_asm+0x1a/0x30
  [    2.537133] 
  [    2.537205] The buggy address belongs to the object at ffff888005219480
  [    2.537205]  which belongs to the cache kmalloc-96 of size 96
  [    2.537719] The buggy address is located 94 bytes inside of
  [    2.537719]  freed 96-byte region [ffff888005219480, ffff8880052194e0)
  [    2.538216] 
  [    2.538289] The buggy address belongs to the physical page:
  [    2.538524] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x5219
  [    2.538857] flags: 0x100000000000000(node=0|zone=1)
  [    2.539066] page_type: f5(slab)
  [    2.539210] raw: 0100000000000000 ffff888001041280 dead000000000122 0000000000000000
  [    2.539534] raw: 0000000000000000 0000000000200020 00000000f5000000 0000000000000000
  [    2.539863] page dumped because: kasan: bad access detected
  [    2.540098] 
  [    2.540170] Memory state around the buggy address:
  [    2.540379]  ffff888005219380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  [    2.540684]  ffff888005219400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  [    2.540988] >ffff888005219480: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
  [    2.541291]                                                     ^
  [    2.541548]  ffff888005219500: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
  [    2.541857]  ffff888005219580: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc

The offset is past the 72-byte queue entry because the out-of-bounds read
fixed by the next patch is on the same line; what this patch removes is the
free at smc_llc_srv_add_link+0x9a8 happening before the read at +0xaa2.

Detach the entry instead of freeing it there, and free it at the single
exit label. The reject path has to detach as well, otherwise it would be
freed twice.

This changes only the lifetime of the entry. The same read still runs past
its end until the next two patches bound it, so a backport wants all three.

Fixes: 27ef6a9981fe ("net/smc: support SMC-R V2 for rdma devices with max_recv_sge equals to 1")
Cc: stable@vger.kernel.org
Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
Changes since v5: return through the existing exit label.

Changes since v6: collected Sidraya's Reviewed-by; removed the extra
spaces after sentence-ending punctuation. No functional change.

 net/smc/smc_llc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 954b2ff1815c..055a03eee5b5 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -1481,7 +1481,7 @@ int smc_llc_srv_add_link(struct smc_link *link,
 	}
 	add_llc = &qentry->msg.add_link;
 	if (add_llc->hd.flags & SMC_LLC_FLAG_ADD_LNK_REJ) {
-		smc_llc_flow_qentry_del(&lgr->llc_flow_lcl);
+		smc_llc_flow_qentry_clr(&lgr->llc_flow_lcl);
 		rc = -ENOLINK;
 		goto out_err;
 	}
@@ -1492,7 +1492,8 @@ int smc_llc_srv_add_link(struct smc_link *link,
 		lgr_new_t = SMC_LGR_ASYMMETRIC_PEER;
 	}
 	smc_llc_save_add_link_info(link_new, add_llc);
-	smc_llc_flow_qentry_del(&lgr->llc_flow_lcl);
+	/* add_llc still points into qentry, so only detach it here */
+	smc_llc_flow_qentry_clr(&lgr->llc_flow_lcl);
 
 	rc = smc_ib_ready_link(link_new);
 	if (rc)
@@ -1512,14 +1513,14 @@ int smc_llc_srv_add_link(struct smc_link *link,
 	rc = smc_llc_srv_conf_link(link, link_new, lgr_new_t);
 	if (rc)
 		goto out_err;
-	kfree(ini);
-	return 0;
+	goto out;
 out_err:
 	if (link_new) {
 		link_new->state = SMC_LNK_INACTIVE;
 		smcr_link_clear(link_new, false);
 	}
 out:
+	kfree(qentry);
 	kfree(ini);
 	if (send_req_add_link_resp)
 		smc_llc_send_req_add_link_response(req_qentry);
-- 
2.43.0

