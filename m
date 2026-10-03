Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8CF3793B3
	for <linux-s390@vger.kernel.org>; Sat,  3 Oct 2026 18:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791052380; cv=none; b=V+7oHNDVcc/upqxG9ajKso91QIpXdld6wJMpXUHLDwU3wnxzH9PqRGwJmCoLNdDbF/WmWzGIqO0IfviFAX0jfpCSwvXN/tJ6t+/NuOGm769yIrpUi2aFfR3EDYtSABAjfCrWaFcCSjhjRawlDVw5qVO10EGXmjcpyEQ49SC/tS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791052380; c=relaxed/simple;
	bh=e8+32VoGE30visGqC+voYuoBvY7B5aSastltx3abuUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6UMepnraa6kavHAmz66ATzrxBzO84SdYg2sKv5z18kio20nodH7nNSWDG4/rUVPWX1FjapndXuZ34XEp8CEDHR2h2ko3YPrkgQe+82m73YRo4jpkz3euHzF0Y+qSALnXlz5lAGD6dOXDojwMeNHOPdteLOtjyZX36iNPF8Mp2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJ/cUnKX; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJ/cUnKX"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-35120bd8ea6so11477eec.2
        for <linux-s390@vger.kernel.org>; Sat, 03 Oct 2026 11:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791052376; x=1791657176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ts2pGekLDFXLhFg7otC8qId4L8lOf+SyIKeEb5TIWXg=;
        b=mJ/cUnKXDA43B1SgsvRcWygp1PbGy0KzQS+p7IvMGuK4wazIRmGIxMDHALwh40nZZw
         /cDA2l5Yb8OIk+VYUWhsrocilUtGSU0x/UfuBmJgE+2Or0NAOEi/XH8NWm69LcHym5Br
         vGFjFHzDVtUlQ6/COsbr4mvBqC46QIe+N9uGA6ZXme0gwHmo7j6tV6CYEALYLrTXRXT6
         qXa/X8/Iy8wwa9drojn3+x/Y6mAtTK01cGy2cwU9TfHTY+ugKiTVsJm7XK/PuUTJSyvs
         YeTb15OmdHkuvs0wtcMW8mgBkCPWBAY/LJbpZp9b2EA3G1xKUoaUAxFh19/w3qZg/1Xe
         ALaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791052376; x=1791657176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ts2pGekLDFXLhFg7otC8qId4L8lOf+SyIKeEb5TIWXg=;
        b=dly3LWgCMaVItmklOsZ2azqLrqC/OIL1nqf4KWodw20hX3DoCtpRoSo8CAchRnD4AK
         B/grxff4NDru+wWUCP0b6G/gEsSW4TQXmz+gWOYqCJDYg8BMZFK3Ia+pf14jXSkMVMKV
         u3PFI7Xk6jfimhfCkxJLPJcnXIRXJ5k9kOfZAmAWcPmpHpD3+rPCecvf8cknB2LprhAF
         EYY1IPP4WXY2f+HH0PYN+7y1hJ9Ps/oluW7CgLnYZ4wBgSbAqpjPzglSphoCvyAzmAwf
         gKsGXCl4FPUZQBmKJ/Ux3ach01Cvo8xID3pJuvkPCdF5F+YAlmVYyJlCEJZWDAIdd/66
         5big==
X-Forwarded-Encrypted: i=1; AKwUvBziJ+FzXzKwZiNUoiTJIPDRRxWkRcqPgOZXRujI/kR0dPW+xJAYubw4Ut68zODY0XuymHhKapByidVC@vger.kernel.org
X-Gm-Message-State: AFq9FYLrdCMDzotLvG5AM5ZsOAeGurm2UzhuzNZ3FkxQjD18LMnF0Wqe
	+sDiVVVpixA2iEcRAyF9XkzSIVzD8keSl4fp5OGe7rPABpsVpXPlb3HW
X-Gm-Gg: AYBFou2Bp2tZOEMerptsCfir7D/hrTSHF8SnpUmtXxqQ/d2Bty05WjElNF27mqMZ4Gh
	J1KIQERG9Hn78WM3IeB7nMrqhG8MxlWqcYN3l1wkHkKTjEKlFWJNt1sFjqB6bnwkaIQ9RnElkv8
	4Oa7dSpWqQYij7cbYK0QuWI03la5Rf7XJG/DuyF6ZGGsmlWXhrMhZ/QLJZL5ai7BpQ4SLxTaNYS
	WKxgcWYIL6uzfSG5tXfmK+rDjf6fkqIfybNANuVFnerq7eMzvRt4idYm5GeCRHghM6qzxwJ7/mh
	kyssHSdw+/IHl/jQz31CJmDuUCByd9XPzpauNRSVM6pdoeAITsmlekXhyaDgoMrcGHEmWZCuM5q
	IyPYXF8tfXm6Tq46nD2d+6wA92gVAQH9tAnP0HwvQjipCIaVWAOT2CadKLW0i/0d+MG4+DL5pAm
	fqIadofJIFMBmIUZNkMZkYhsrQLMx70BbvWDj32GBT6ouKu1TQR2BLtvdww3jZsKg5Qtd4xXLnX
	/mScmQ/3RvTm4PY8xNym10lzwdfwlGGWrAZdC45yJGqq/W1iIvnf/7h0msu+B9RhTxsUA==
X-Received: by 2002:a05:693c:864b:10b0:33e:4e49:d08d with SMTP id 5a478bee46e88-3510d2815f3mr8297160eec.1.1791052375983;
        Sat, 03 Oct 2026 11:32:55 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14fd9698sm17118191eec.23.2026.10.03.11.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 11:32:55 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	mjambigi@linux.ibm.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/2] net/smc: serialize link group free work scheduling
Date: Sun,  4 Oct 2026 02:32:36 +0800
Message-ID: <20261003183237.2284245-2-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261003183237.2284245-1-nicoyip.dev@gmail.com>
References: <20261003183237.2284245-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smc_lgr_schedule_free_work() checks lgr->freeing without the link group
list lock held by the teardown paths. A concurrent smc_lgr_free_work()
can set freeing and cancel the delayed work between that check and
mod_delayed_work(), leaving a timer pending on a freed link group:

  CPU 0 (smc_conn_free)            CPU 1 (smc_lgr_free_work)
  observe lgr->freeing == 0
                                  set lgr->freeing under lgr_lock
                                  cancel_delayed_work()
                                  smc_lgr_free(): drop lgr reference
  mod_delayed_work()
  smc_lgr_put(): drop last reference and free lgr

When the timer expires, the timer core accesses the freed memory.

  BUG: KASAN: use-after-free in __run_timers+0x86d/0x8d0
  Write of size 8 at addr ffff8881186902a8 by task swapper/2/0
  Call Trace:
   <IRQ>
   __run_timers+0x86d/0x8d0
   timer_expire_remote+0xd3/0x120
   tmigr_handle_remote_up+0x4f4/0xab0
   __walk_groups_from+0x40/0x150
   tmigr_handle_remote+0x229/0x2c0
   run_timer_softirq+0x1f5/0x250
   handle_softirqs+0x18d/0x5b0
   </IRQ>

Hold the existing link group list lock across the freeing check and
mod_delayed_work(). Set freeing under that lock in early cleanup as well,
before __smc_lgr_terminate() cancels the work. An SMC-D server releases
smc_server_lgr_pending before receiving CONFIRM, so another connection can
reuse the group and race its removal with early cleanup.

Give freeing its own storage. The neighbouring sync_err and terminating
bitfields are written without the list lock; their read-modify-write
updates must not overwrite the freeing transition.

Rearming then either precedes the freeing transition and is caught by the
subsequent cancellation, or sees freeing set and is skipped.
smc_conn_free() retains its link group reference until after scheduling,
keeping the group alive while acquiring the lock.

Fixes: 8e316b9e7260 ("net/smc: improve link group freeing")
Cc: stable@vger.kernel.org
Assisted-by: GPT-6.1-Sol
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
Changes in v2:
- Give freeing its own storage so adjacent bitfield updates cannot
  overwrite the list-lock-protected transition.
- Set freeing under the list lock during early cleanup to prevent a
  concurrent SMC-D connection from rearming after cancellation.
- Keep asynchronous cancellation without adding work-owned references.
- Send with the early-cleanup ownership fix as an ordered two-patch series.

v1: https://lore.kernel.org/r/20260927074520.3694663-1-nicoyip.dev@gmail.com/

 net/smc/smc_core.c | 8 +++++++-
 net/smc/smc_core.h | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 9974149659c2..478c8bc2759a 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -80,6 +80,10 @@ static void smc_ibdev_cnt_dec(struct smc_link *lnk)
 
 static void smc_lgr_schedule_free_work(struct smc_link_group *lgr)
 {
+	spinlock_t *lgr_lock; /* protects lgr->freeing */
+
+	smc_lgr_list_head(lgr, &lgr_lock);
+	spin_lock_bh(lgr_lock);
 	/* client link group creation always follows the server link group
 	 * creation. For client use a somewhat higher removal delay time,
 	 * otherwise there is a risk of out-of-sync link groups.
@@ -90,6 +94,7 @@ static void smc_lgr_schedule_free_work(struct smc_link_group *lgr)
 						SMC_LGR_FREE_DELAY_CLNT :
 						SMC_LGR_FREE_DELAY_SERV);
 	}
+	spin_unlock_bh(lgr_lock);
 }
 
 /* Register connection's alert token in our lookup structure.
@@ -691,6 +696,7 @@ void smc_lgr_cleanup_early(struct smc_link_group *lgr)
 	/* do not use this link group for new connections */
 	if (!list_empty(&lgr->list))
 		list_del_init(&lgr->list);
+	lgr->freeing = 1;
 	spin_unlock_bh(lgr_lock);
 	__smc_lgr_terminate(lgr, true);
 }
@@ -1565,7 +1571,7 @@ static void __smc_lgr_terminate(struct smc_link_group *lgr, bool soft)
 
 	if (lgr->terminating)
 		return;	/* lgr already terminating */
-	/* cancel free_work sync, will terminate when lgr->freeing is set */
+	/* cancel pending free_work; a running instance rechecks freeing */
 	cancel_delayed_work(&lgr->free_work);
 	lgr->terminating = 1;
 
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 5c18f08a4c8a..b8c67f277337 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -303,7 +303,7 @@ struct smc_link_group {
 	struct workqueue_struct	*tx_wq;		/* wq for conn. tx workers */
 	u8			sync_err : 1;	/* lgr no longer fits to peer */
 	u8			terminating : 1;/* lgr is terminating */
-	u8			freeing : 1;	/* lgr is being freed */
+	bool			freeing;	/* lgr is being freed */
 
 	refcount_t		refcnt;		/* lgr reference count */
 	bool			is_smcd;	/* SMC-R or SMC-D */
-- 
2.43.0
