Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E609D5328B3;
	Tue, 22 Sep 2026 10:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790072372; cv=none; b=m0JugsPjenu7/zBFg+aUbt4W2rvN2ErzXSlMkhvKFx258WjDglOHx2Fry+XVvPNCXhjTGMGcFLWQ0yIioVRvz/Sx5IHuUy+/JF4TbouIHTjBYIbb1F2nQyrSosluLtPfiNf4ieWXI/XUz0T6a3YUqTJVnquBSfe+drMWEGlO1KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790072372; c=relaxed/simple;
	bh=fnfJDBEXNUMOlGWOqPPPrXtBQMfJE8QcEAnUb4psO2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOJzW9om4XPmYzkzddLC0mwWyGAzGlGlv5w78cfcweoHAWseexw/RrL8esmc5WPvM2+UK8aAKoPugtppDS/wR9RDN5dtwBhhzxRLJaWQplEFaTFh4wRs/MkSzGNOOMSOGF/ogEfAuypN6XSHBZYFgY0YO1VuwKXdyebgiiVlUR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=clz8S1En; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="clz8S1En"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M05gAH2948920;
	Tue, 22 Sep 2026 10:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KY2NWf6oBgwasWp9Z
	JhMWxWZkRkGv4HTySqVrEev6Kg=; b=clz8S1EnEejOgRDkqpcsBQfzyQoYnDgN3
	QaOUirLuBvgW5NSiFydIUoRXYZTXhkaZ03bJ4RiqSN/v5PbyI77wWzSsznyQHB+e
	MV86CDIYGp92vyrDEGL2FuwY72HugapAfS/Ub+ZeVnC6SsTKxElbz7CRgcCQ4Tbn
	WqdYK6gjIazATmMIhjHRflkZlCB5HGTYK7mxuWqZ5NxWlSgVNCwXRja5eXL0gZ0D
	dv+AKfhUOI2uBzbQ08wj9+staLvS2fRdbWptQFUHj6HJPfFer1pdvENUXOcrRASe
	G2SIdsi7a7f8r66T52Xi5f8IZVsInLgI99Ci50mkvbx7MAXAcX1bA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgs55u5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 10:19:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68MA3NCU2995419;
	Tue, 22 Sep 2026 10:19:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dy94u5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 10:19:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68MAJIwW30933698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 10:19:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D984720043;
	Tue, 22 Sep 2026 10:19:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93EEB20040;
	Tue, 22 Sep 2026 10:19:18 +0000 (GMT)
Received: from t83lp71.lnxne.boe (unknown [9.87.84.240])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Sep 2026 10:19:18 +0000 (GMT)
From: Nagamani PV <nagamani@linux.ibm.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc: wintera@linux.ibm.com, aswin@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, kees@kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, Nagamani PV <nagamani@linux.ibm.com>,
        stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net v3 2/2] s390/ctcm: Fix use-after-free in channel_remove()
Date: Tue, 22 Sep 2026 12:19:13 +0200
Message-ID: <20260922101913.239103-3-nagamani@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922101913.239103-1-nagamani@linux.ibm.com>
References: <20260922101913.239103-1-nagamani@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab2562c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=c92rfblmAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=vvMWNJ4svd0Vc9r0P7sA:9 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: 60gZuBT_fD4UQXP40fZK_NBXjTbspf21
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE0NSBTYWx0ZWRfXy0rLOLCXKY08
 YYAtXWP2yiyMt17yo8ojPNJ2hcsk7iy1PCjxbHrWXApnMrGTFXoj9cDFHvm5rG5hhGJlipp4+cm
 0mXF7VbYynY+56/sI+bKb9nZM8PiFauCWn9WDGgR4KcEhHsUAq50O6kYnDQYKg6+CaIOc0K4RUv
 Wy0DaiAF8cOUwrtyJnthsmZ20yDhrR2RZYFpeKWZEmjvJKUlab71uw+qMt6ysbAmQRMwt2CXBD9
 DSp2neoOYJ78MzQkUuMlf7ZLvC69rvvnYn+6e+LOUp4vXGFvuc6xTGb07xLKrxTykHuoZKLb1Jt
 byqcKxbeRQQVOLTfEV2U9aRZCRcWHLfkjM6i7OdaHX7VzwlmaMPyRw3R5NmJXqq+ICZElxTciFn
 z08bK1z7iZzzylMIdQwh2WEY3n/glQpagrp7RuARU0RJj3YThtPcuzJCEWYFYWyRb3wV2w1Tkvx
 6+4zhvxxtwlnt9FfRaA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE0NSBTYWx0ZWRfX28dGCOxUWYjB
 v7jX30zkWtk7OCXNS4bmLz7NjQVxoIup5raQ6evlxKFQgwSVaGe25ZPzQyYFtAFBEVc7cn7xHrY
 wxda4oxapuYH7AMuxKsi5WkXv4lssZ0=
X-Proofpoint-GUID: uiI0-ym9hIrxCs59EvD5c2Y-1vdRqT54
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220145

channel_remove() calls fsm_deltimer(), which internally uses
timer_delete(), then immediately frees the channel structure:

  fsm_deltimer(&ch->timer);
  kfree_fsm(ch->fsm);       /* freed while callback may still run */
  kfree(ch);

timer_delete() returns immediately even if the timer callback is
currently executing on another CPU, creating a window where
fsm_expire_timer() accesses this->fi (which points to ch->fsm)
after it has been freed by kfree_fsm().

Fix this by calling timer_delete_sync() directly on the underlying
timer_list fields before freeing, instead of going through
fsm_deltimer(). This cannot be fixed in fsm_deltimer() itself because
FSM action functions triggered by CTC_EVENT_TIMER call fsm_deltimer()
from within the timer callback chain, which would cause a self-deadlock in
timer_delete_sync().

For MPC channels, two additional problems exist. First, freeing
ch->fsm before tasklet_kill() leaves a window where ch_tasklet
(ctcmpc_bh) or ch_disc_tasklet could access the freed ch->fsm. Second,
ch_tasklet can re-arm sweep_timer via ctcmpc_send_sweep_resp(), and
sweep_timer's callback re-arms ch->timer via ctcmpc_chx_send_sweep().

Kill both tasklets before stopping the timers: this closes the freed
ch->fsm access window and eliminates the tasklet-driven sweep_timer
re-arm source. Then use timer_shutdown_sync() for sweep_timer to wait
for any running callback and prevent further re-arms of ch->timer from
sweep_timer. kfree(ch->discontact_th) is moved into this MPC block
after tasklet_kill(ch_disc_tasklet), since mpc_action_send_discontact()
accesses discontact_th.

timer_delete_sync() is retained for ch->timer because normal FSM timer
callbacks can delete and re-arm ch->timer; shutting it down would break
normal operation.

Patch 1 changes fsm_addtimer() to use mod_timer() without reinitializing
the timer, which is required for timer_shutdown_sync() to reliably
prevent subsequent re-arms.

Backporting patch 2 without patch 1 is not safe because the old
fsm_addtimer() reinitializes the timer with timer_setup() before
add_timer().

Fixes: 293d984f0e36 ("ctcm: infrastructure for replaced ctc driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260803182736.2356374-1-nagamani@linux.ibm.com?part=1
Signed-off-by: Nagamani PV <nagamani@linux.ibm.com>
---
Changes in v3:
- Kill ch_tasklet and ch_disc_tasklet before stopping the timers and
  freeing ch->fsm: closes freed ch->fsm access from tasklet context and
  eliminates tasklet-driven sweep_timer re-arm.
- Shut down sweep_timer with timer_shutdown_sync() before deleting
  ch->timer to prevent sweep_timer callback from re-arming ch->timer.
- Move kfree(ch->discontact_th) after tasklet_kill(ch_disc_tasklet).
- Drop Reviewed-by and Tested-by; please re-review and re-test the
  new teardown order.

Changes in v2:
- add Fixes: and Cc: stable@vger.kernel.org tags (Sashiko netdev-bot)
---
 drivers/s390/net/ctcm_main.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
index 8b0d76a47d9f..5053737f11fc 100644
--- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -211,9 +211,13 @@ static void channel_remove(struct channel *ch)
 	while (*c) {
 		if (*c == ch) {
 			*c = ch->next;
-			fsm_deltimer(&ch->timer);
-			if (IS_MPC(ch))
-				fsm_deltimer(&ch->sweep_timer);
+			if (IS_MPC(ch)) {
+				tasklet_kill(&ch->ch_tasklet);
+				tasklet_kill(&ch->ch_disc_tasklet);
+				timer_shutdown_sync(&ch->sweep_timer.tl);
+				kfree(ch->discontact_th);
+			}
+			timer_delete_sync(&ch->timer.tl);
 
 			kfree_fsm(ch->fsm);
 			clear_normalized_cda(&ch->ccw[4]);
@@ -221,11 +225,6 @@ static void channel_remove(struct channel *ch)
 				clear_normalized_cda(&ch->ccw[1]);
 				dev_kfree_skb_any(ch->trans_skb);
 			}
-			if (IS_MPC(ch)) {
-				tasklet_kill(&ch->ch_tasklet);
-				tasklet_kill(&ch->ch_disc_tasklet);
-				kfree(ch->discontact_th);
-			}
 			kfree(ch->ccw);
 			kfree(ch->irb);
 			kfree(ch);
-- 
2.53.0

