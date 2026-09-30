Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EFA44F564;
	Wed, 30 Sep 2026 07:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751783; cv=none; b=A8SKYo6nmOFBYtQwOQSoVpo1hnkZe+7tJ1KLGEZSFidW2WcDDA1pNYzeK4Y2DT19hn2X8IzYUWx15FJcQDtH2ESVdGlXfQNFvrDOdwKKrNItjQYJ4A5zAkoRJ4LMkAPvh4CuKCznP1a2OU1H2NgVKCpSSN+CHSzxQxbmKa/Fe+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751783; c=relaxed/simple;
	bh=XIyRTnWIRaVSAIb/81hvoHZfnI1fRBFmB0t2MlaWbkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uq7fKzi9fglTCU8Gx40KeAvyYj/JgQTNSj/uNKgo7V1IGot93f8VunKBQG173VwxWKisQWuJab/bROEvCNmpsnlBhf478/USn4tSQjNUmAEldvvaMJtD9fQeA/vqEWxNSmwuiU2tPXiPOIgR2j/vOrhrTt48mztlnYvMLCQHzTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IOGlqbQ+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IOGlqbQ+"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TNa9b41396084;
	Wed, 30 Sep 2026 07:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qUBD5W2/1rgO3xyMc
	qc3u/pRDCV16OZnPPXxRKq4t40=; b=IOGlqbQ+7haFYLl9WH2ycXHaSDV9oIHsj
	r7R6INqfKnEIZqWu53/q+xoSL+AZdLQkc5dO9rB/OEjNfHXLNXM8ms85TNQHFxok
	VSk/oQXMK0UL6SDhYzaEBPqS2vkMQIL17buti/lQTGsxmG9DYLhyKVnl3DnOBDph
	yJdk+Px50jPHxdUM5dOqMzutGkaHUE6RAfDCNCVhYAqMlrBIiC+HgcEofQOt/43X
	T4R/lNrMO0r5JPf7L6EThSabe7LU/bdVpd5W68G/w6EXIxvbcAtsnEYiqd+ljkq2
	j6LF4OZ9tvwmV2HaWyFeQAjxXlN8ze+WoU3EgU4yaI19g1H74v+AA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j5bhwm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 07:02:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68U4m5Fn2589585;
	Wed, 30 Sep 2026 07:02:44 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0g8e2xrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 07:02:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68U72eqO42336546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 07:02:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F71420049;
	Wed, 30 Sep 2026 07:02:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD83120040;
	Wed, 30 Sep 2026 07:02:39 +0000 (GMT)
Received: from t83lp71.lnxne.boe (unknown [9.87.84.240])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Sep 2026 07:02:39 +0000 (GMT)
From: Nagamani PV <nagamani@linux.ibm.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc: wintera@linux.ibm.com, aswin@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, kees@kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, Nagamani PV <nagamani@linux.ibm.com>,
        stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net v4 2/2] s390/ctcm: Fix use-after-free in channel_remove()
Date: Wed, 30 Sep 2026 09:02:34 +0200
Message-ID: <20260930070234.569500-3-nagamani@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfXwKb1ZX1leOWl
 QITqWFY1K8qJ6bhSbZGYskfjIAhJWuhFQHcK8QMRqrfKNbZeeV495gt3Hss0COaka3WFXUi2xzj
 XzOh27IoedvkYaCiBTT5mnB0eQtkw+E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfX7AVbHaIZndNE
 2ffsXVnTeloaNKC1m3qwOVfjqNUEFmIfBZZd3vscdNNg8hhOKnXSEj2J0fIssv6KlWIhO86p0lR
 0bR96gKuMzm6ZrReQBbe6M2mm4kyo70QMgsEQ9jk2Zsw7P4oE0ExY61dDnaRk+VuwLIO1hjoUsv
 q+OGC0fUtBdc1troDVWO/Yv+YdXQYw+ife68MMepS9Us/akYArRUoR7oRkwhzP25twGUrHEoLlu
 t6Lygdi/q6nysQaomD2DMCy8mA5OAAzVRNu8G3VhaCe+SqcpDnYRUOInhWFAwqiLHf1+aSZ55W0
 BwGIuL3Wo7Rk3xIuSN0YdrqGN8O1HXkkOgrS2/U+vKiMi7o2q5Ui6dsjORL69y5pJPIWjyaK/yu
 djN53UBQpewlFGEiGUKzQ0fnxaMKug8Tn62G5QMX4bR4umCJnikwL0JM8WRQsKqvNndDSPhbJKD
 3w/1Y2dnqzEgrvSHmpA==
X-Proofpoint-GUID: cP8dcVZMZrfifdZFaroFYg6DXy8WT42D
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abcb415 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=c92rfblmAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=t-MDMg0rlNtVIxhSxYUA:9 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: MZFBJvQTXQXBw5GZbjAya2ixvgGjXhd6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300026

channel_remove() uses fsm_deltimer() which calls timer_delete(),
returning immediately even if the timer callback is running on
another CPU. This leaves a window where fsm_expire_timer() accesses
ch->fsm after kfree_fsm().

For MPC channels the teardown has a circular dependency:

  ch->timer callback -> ctcm_chx_txretry() -> mpc_action_go_inop()
    -> tasklet_hi_schedule(&ch->ch_disc_tasklet)

  ch_tasklet -> ctcmpc_send_sweep_resp() -> fsm_addtimer(&ch->sweep_timer)

  sweep_timer callback -> fsm_addtimer(&ch->timer)

Use timer_shutdown_sync() for both timers: it waits for any running
callback and permanently prevents rearming. Shut down sweep_timer
first (its callback rearms ch->timer at ctcm_fsms.c), then
ch->timer. Only then call tasklet_kill() -- catching any tasklet
scheduled by an in-flight callback before shutdown.
kfree(ch->discontact_th) follows tasklet_kill(ch_disc_tasklet) since
ch->ccw[15].cda points to discontact_th and
mpc_action_send_discontact() starts I/O through ch->ccw[15].

timer_shutdown_sync() is also used for non-MPC ch->timer:
ctcm_chx_txretry() (CTC_STATE_TX + CTC_EVENT_TIMER) calls
fsm_addtimer(&ch->timer) on both paths.

Depends on "s390/ctcm: Fix timer corruption in fsm_addtimer()" which
replaces add_timer() with mod_timer(). mod_timer() on a shut-down
timer is discarded; without it fsm_addtimer() calls timer_setup()
defeating timer_shutdown_sync(). Backporting without that
prerequisite is unsafe.

Fixes: 293d984f0e36 ("ctcm: infrastructure for replaced ctc driver")
Cc: stable@vger.kernel.org # depends on: s390/ctcm: Fix timer corruption in fsm_addtimer()
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260922101913.239103-1-nagamani@linux.ibm.com?part=2
Signed-off-by: Nagamani PV <nagamani@linux.ibm.com>
---
Changes in v4:
- Shut down timers before tasklet_kill() rather than after,
  shutting down sweep_timer before ch->timer.
- Use timer_shutdown_sync() for ch->timer on both MPC and non-MPC paths.
- Name prerequisite by commit title and add structured stable tag
  dependency (Jakub Kicinski).
- Code changed; Reviewed-by and Tested-by dropped.

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
- Add Fixes: and Cc: stable@vger.kernel.org tags.
---
 drivers/s390/net/ctcm_main.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
index 8b0d76a47d9f..27a22dbc9280 100644
--- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -211,9 +211,14 @@ static void channel_remove(struct channel *ch)
 	while (*c) {
 		if (*c == ch) {
 			*c = ch->next;
-			fsm_deltimer(&ch->timer);
 			if (IS_MPC(ch))
-				fsm_deltimer(&ch->sweep_timer);
+				timer_shutdown_sync(&ch->sweep_timer.tl);
+			timer_shutdown_sync(&ch->timer.tl);
+			if (IS_MPC(ch)) {
+				tasklet_kill(&ch->ch_tasklet);
+				tasklet_kill(&ch->ch_disc_tasklet);
+				kfree(ch->discontact_th);
+			}
 
 			kfree_fsm(ch->fsm);
 			clear_normalized_cda(&ch->ccw[4]);
@@ -221,11 +226,6 @@ static void channel_remove(struct channel *ch)
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

