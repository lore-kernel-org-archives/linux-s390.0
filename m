Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D68F44F543;
	Wed, 30 Sep 2026 07:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751780; cv=none; b=RsA61Kx4v6r/qLGHm7bj/BUeSEufKeyBiRQD098yTjfI8REGsvCQ5H0kZmOjin/DsU3Y0JgGkmf5JbVMwCqsl6SvgUkvBqr1ygo7KfjRfnWOSdpBQKqSYzoDxpFI6XmMs8Ekdh8l+KUg/XkaFROVq9kGkw2McZczKSNKMYCr154=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751780; c=relaxed/simple;
	bh=I+oRYE1hByn30bYkUkL6uPnSEbWCuf6g31HZNmsdTtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xbrv40Ac5qTt4m3ovVEhIyczK485LCfKp//dqWiAgNRPHX884CLM/xMaXl4rdMcrqH/X+gRTyK8kKDyV/Atb4Ow+D2WU9lRwaNJ/O8L1TnF4V4o9aVk3AAgHnSwJtl9UW3Qaha6nG7NQfvgE6jViZO5/jr+4rxgnuzKwcX4Mhto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mn3CBeOA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mn3CBeOA"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TNZqV4120194;
	Wed, 30 Sep 2026 07:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=w15/hm9CPDsPrawR9
	7OAtf/xNAjIDheAVnZI3Epe7xc=; b=mn3CBeOA3Meu1ttpcRNbnGsjjxvhaayvw
	YZs+rCTLWLCBcAtJ5CWUxuVZ1l117ZoQeGCSPVEVs8qPuv29EQpJm79ZKDnvGNFr
	9+cq4FH6N9k4piihRWazT3ggqdn3ZOWt0dj5b+C0n7CEqGYEHZLJwNvLt1Mx8nUv
	igtwm73Yb4DZmGMEyouYn2SEhJb9W6kDuSaogLT9ZJIUTCczDfRkCwhYqjO8EEzi
	Kl9FXjvZZRR791me3bueHOa7CEPMKLcPmgACi0nM9EFdX8x5hVopqwq/eizi63pL
	mgy3SvK1HbfPtGomQ87P1EwZsQIysVJADwDECyvGFg/hbtNAuXgRw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4feampr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 07:02:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68U4rag22549180;
	Wed, 30 Sep 2026 07:02:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxrrwddpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 07:02:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68U72cab31916608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 07:02:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A508F2004B;
	Wed, 30 Sep 2026 07:02:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59D9320049;
	Wed, 30 Sep 2026 07:02:38 +0000 (GMT)
Received: from t83lp71.lnxne.boe (unknown [9.87.84.240])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Sep 2026 07:02:38 +0000 (GMT)
From: Nagamani PV <nagamani@linux.ibm.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc: wintera@linux.ibm.com, aswin@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, kees@kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, Nagamani PV <nagamani@linux.ibm.com>,
        stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net v4 1/2] s390/ctcm: Fix timer corruption in fsm_addtimer()
Date: Wed, 30 Sep 2026 09:02:33 +0200
Message-ID: <20260930070234.569500-2-nagamani@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930070234.569500-1-nagamani@linux.ibm.com>
References: <20260930070234.569500-1-nagamani@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abcb414 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=c92rfblmAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=T_NMYt6YcsbJOU4cA00A:9 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfXwLEr6Udz+830
 IgLIJMvqSqshGXTWcfHTvpBsxzd9Pj1emKbjlo2EOJlRUsy35wBli/R5zX1/7L03fE2R99JbhOH
 t+viu2c5uiVGBNv1Qq2tzl0W0T1VNzk=
X-Proofpoint-ORIG-GUID: jHfV2Zs45mM7mZ9W7QtA7_1ykMdW-j6C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfX2C9T6E03ZsI0
 lYWkWJK+PkLelP+JZ7Xw23b2LVIB7yWE/RNJ7q9s2GX+1Zcw0N7buGYLdQUkQ074avv8zLrBGKL
 9iPiXWLr7VLJ3hRXn6cT/lGUZLSkTyMR0pL4BYlOXUFccH0hFn+1up0b60HGYl83Mhn17/D08bk
 G3fc4jahQf1S1VOPHR+XCPhEAI8KkAs7GBpOFIZ5Svf20bT4utuvxDXFDn+F1izrkCWR9Eiymca
 LvLz2bNmYMuCTi8nm2YKpUCMCVqULI+sxjkkgS5y14Snzd+qL1Rc3Jq6SP9RgtJKY8L07o4YNlg
 VMpvbLqOke5XIzti1LhM6O5i5eVW3ENzV8GLrUi2TppoCSpQbJWL2XMItxA7AWBc1w54QMwIM2R
 yyiHSaU4UlQaHj3Q0S70mspyOt7XMrEn4yqzp9aifwN9qbBW7+5ok4SozpfMcJLCV2dbsfqh30s
 Yk7kHl88IKM97DPaNSw==
X-Proofpoint-GUID: 0-H4ws03r4nC5qy37iYWw7yAE2PvppIe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300026

fsm_addtimer() calls timer_setup() unconditionally before add_timer().
If called on an already-pending timer, timer_setup() re-initializes
the timer's list_head fields while the timer is still enqueued in the
wheel, corrupting the timer list.

The timer is already initialized once by fsm_settimer() which calls
timer_setup() correctly. Multiple callsites invoke fsm_addtimer()
without a preceding fsm_deltimer(), including ctcm_main.c
ctcmpc_send_sweep_req() and ctcm_mpc.c mpc_action_side_xid(), making the
redundant timer_setup() in fsm_addtimer() a real corruption risk.

Remove the redundant timer_setup() calls from fsm_addtimer() and
fsm_modtimer(), and replace add_timer() with mod_timer() which safely
handles both pending and non-pending timers atomically without
corrupting the timer wheel.

Fixes: e99e88a9d2b0 ("treewide: setup_timer() -> timer_setup()")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260803182736.2356374-1-nagamani@linux.ibm.com?part=1
Reviewed-by: Aswin Karuvally <aswin@linux.ibm.com>
Tested-by: Aswin Karuvally <aswin@linux.ibm.com>
Signed-off-by: Nagamani PV <nagamani@linux.ibm.com>
---
Changes in v4:
- No changes to this patch.

Changes in v3:
- No changes to this patch.

Changes in v2:
- Fix function name ctcm_send_sweep() -> ctcmpc_send_sweep_req()
  in the commit message.
- Call mod_timer() then return 0 explicitly, preserving the
  "Always returns 0" contract documented in fsm.h.
---
 drivers/s390/net/fsm.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/net/fsm.c b/drivers/s390/net/fsm.c
index 9b8622aef807..936ed0bc8401 100644
--- a/drivers/s390/net/fsm.c
+++ b/drivers/s390/net/fsm.c
@@ -171,11 +171,9 @@ fsm_addtimer(fsm_timer *this, int millisec, int event, void *arg)
 	       this->fi->name, this, millisec);
 #endif
 
-	timer_setup(&this->tl, fsm_expire_timer, 0);
 	this->expire_event = event;
 	this->event_arg = arg;
-	this->tl.expires = jiffies + (millisec * HZ) / 1000;
-	add_timer(&this->tl);
+	mod_timer(&this->tl, jiffies + msecs_to_jiffies(millisec));
 	return 0;
 }
 
@@ -189,12 +187,9 @@ fsm_modtimer(fsm_timer *this, int millisec, int event, void *arg)
 		this->fi->name, this, millisec);
 #endif
 
-	timer_delete(&this->tl);
-	timer_setup(&this->tl, fsm_expire_timer, 0);
 	this->expire_event = event;
 	this->event_arg = arg;
-	this->tl.expires = jiffies + (millisec * HZ) / 1000;
-	add_timer(&this->tl);
+	mod_timer(&this->tl, jiffies + msecs_to_jiffies(millisec));
 }
 
 EXPORT_SYMBOL(init_fsm);
-- 
2.53.0

