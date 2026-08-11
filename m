Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A9A42FCC5
	for <linux-s390@vger.kernel.org>; Tue, 11 Aug 2026 23:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786490417; cv=none; b=hfHM+q7UZBvhx2N1Fl8io0QFRdY/ttn4RotkV+O8arnDHlvWhbXSdlGjzPUiT0xhwrtWZl05BUIzuS63LwBZomrxFfcoGQDd48b+VTFzqe0N8QGp9a5dUJAoSbxp9365DY6kpmXDMQDELbsovePv7A7QbqS1uarG6Tu0MdoCgik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786490417; c=relaxed/simple;
	bh=22nPeXdbupsRSm+fjl9Od2TafluxfMvurzDk9av37OY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCt2rbUPn6NoSNILVHG0GoKwsPgPNK8txn+GAU2/WFAzQ3vAn5X95YpjuIuW2JOsHUsrA2XqwiPJMBUatAFfk6agLLLQ97sJS4nqL6ckNhmdxI6s+xNSU9J0jk8I+CSVl3ZH+iC+mZfiCmceC974VZkF0g0DWq+quU89wO/lfts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=xL+TXGow; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="xL+TXGow"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84847482584so317482b3a.0
        for <linux-s390@vger.kernel.org>; Tue, 11 Aug 2026 16:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1786490415; x=1787095215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gk+a9mLjO1sFOyggqzNdg6aQdGam47r8W59+GEbhQOg=;
        b=xL+TXGowS1L3PRwf0Skkb9QnNKyeGM2QJZ+vH7Q1whwPXM3xZ5joolsH/ITZ8TFByI
         g11KItUyYz6dq5BkLcbHdJOP2TuKQkUpPdwGGUxttjyvj7x7T7sNNBVU5f5nhdCY7TbG
         GPewq1I1uLY8EJAw2h6c5biItomxjlg2toQrGppjQ/f5PUwm76NGncPk3hCg8GROwrGy
         v6+1GeNW5fJFeHsOsGzfcicroTvYxA+eFQbAx7C+MWUa0LGFiB33ef0FLokmMJ+fB39c
         la1IOM5lq/8XBU1qRKn1RpQJuMXaOZn8T03Z+hk3Jqtq37DVcAbZDRCPsfnc7HfCNe0E
         3eow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786490415; x=1787095215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gk+a9mLjO1sFOyggqzNdg6aQdGam47r8W59+GEbhQOg=;
        b=YmmDItmkZBxMxEwVT049Shz+B6XfVkLj6CYoGGIEaW7Nt7Z7gUMwtMzj6VPEGxF5Fp
         fyNcOf6ybS0FvtrlEAkVTEx3xzBGVjiTt1dV25Pd0WVuvG50iy9wm/4+Uqvc47/YsP1B
         UM3UZOQMNNRnDVhU6HtpDBl7e3fc19EutYuWJCIAVSpaBBLg/qbZRNJOdlxwecK15+7y
         xmuXST49QmKVA1ko6cHBJ3ncpNeiECWrPQx//Eyh5XDo50oGFLn5vBYwzry2VJeumutK
         TIdKSns3bJERPdCVMTukDJhtciDUvi/t5E7MWB8P6IQ5KxDocjD1EwBCVg0lUs7fCJsL
         w0Cw==
X-Forwarded-Encrypted: i=1; AHgh+RrU+uLHkM0iVnIGvszfBh2XU4KeUBnSYR+puD9BE27Qu0KDIlojudC3HSa9xU2yBOFs1FHBzugk0sPq@vger.kernel.org
X-Gm-Message-State: AOJu0YxkPdI8p5+tiowSKAfywm2Xd+skRLOoQf48KLMqYvEyzEVZyNpF
	b0DZ7gejyyU+8c8biF5C7ryhUycNXcVKcnhvDBESEv7/TmTWvfuVBcrV/TkteiVrilU=
X-Gm-Gg: AR+sD1009SDcbbhEX6FYfjqETLtW4bpfBh4XrpRLK96wli3ZigVUKZ3F4vmemgS1B9b
	TAp1grfNNkFpuhL9BJjg2b3CXQ/TvsvvQHwC6VDH7TGSLxxB4daxbxGe84taA8B2xxLu8flGY2F
	S5z3nJaB6rag5gsTzKgP7drioLoRMTDd4Q37GpRn2B/JEVLtPkVcFXu4BCNTvZ1Yr8ukKWFfrR0
	XMR+Ab/DmmATfFQCHVluEkYsECHmRBcnn9/hhJOWyO2l0GCnbRAQcrLamq1HsVuDeiIp4OyT+Nb
	WoswRDDOuoPoV8gKoQyS7kn8hrTFcuw6Q4thZtgx5AYLrNSN3s5Gl0NqVSH/QKj/gSVB7UbtJku
	fZ7HHdAXlcjXdJNzbtgbgJYaceQtybp0dz6dkq3HiETuVmgsOnn/hRyIrhGQuUryCoShYac0keh
	Mvrx5psAr2Xyl4okhZDHHnCGuc2rx6KYkzLr+PHlOY/O/HNndjVJNwTGH/9gN7rlN/eU9bY1Gl6
	HKrM8m4lqo=
X-Received: by 2002:a05:6a00:1c9e:b0:84a:2b96:5986 with SMTP id d2e1a72fcca58-84fafa314a0mr4134236b3a.8.1786490414938;
        Tue, 11 Aug 2026 16:20:14 -0700 (PDT)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:365f:6c09:b402:1986])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbedbac8842sm1177810a12.30.2026.08.11.16.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 16:20:14 -0700 (PDT)
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
Subject: [PATCH net v6 1/3] net/smc: fix use-after-free of the LLC qentry in smc_llc_srv_add_link()
Date: Wed, 12 Aug 2026 08:19:00 +0900
Message-ID: <20260811231902.47089-2-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811231902.47089-1-yhlee@isslab.korea.ac.kr>
References: <20260811231902.47089-1-yhlee@isslab.korea.ac.kr>
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
already freed.  Before the Fixes: commit that branch always used
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
exit label.  The reject path has to detach as well, otherwise it would be
freed twice.

This changes only the lifetime of the entry.  The same read still runs past
its end until the next two patches bound it, so a backport wants all three.

Fixes: 27ef6a9981fe ("net/smc: support SMC-R V2 for rdma devices with max_recv_sge equals to 1")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
Changes since v5: return through the existing exit label.

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

