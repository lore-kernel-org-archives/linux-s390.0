Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C25534D384;
	Wed,  5 Aug 2026 14:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785941448; cv=none; b=fO1V2aWPQFPWxQYSikL9L6OotqYGwvqhR2uUv32TfN/aUiKkRodR5mgRWLuSTMoHVbJSzuFt+uD1dvcAY8E8vzm3e8N+12hNvcTuIJRbjYQluI2ThCJQwWqczJOcBfrRqYN5pe5my8Eq3yl9j+r4uD6P+uFyiz9Af4ZfWmPDH5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785941448; c=relaxed/simple;
	bh=jQAY0rWQEnwB0Ekd/vzqDwizH0ilt6Ia7nac5GPvGMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ioKGUTd+87hsuHVeEeWVZyR/X7SaoEhVQygZeyvwqat1TcWh1P+GZByJjVpKBLXlzCT/E2SiZcf2fR9YspCYB1NQNjiyukd+ApWk3AD0zb/LEZ8X0c4WYdFpTOgldxz45nXr4jLgaZjdJAVp6U+tkOJIPVff+pV9H07BQ67fXYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GYLEKnPw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GYLEKnPw"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675CICUo1942424;
	Wed, 5 Aug 2026 14:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YukVHqqFZfW8YodRz
	tAmTn0Oih1YdlovKHC9UWor/EI=; b=GYLEKnPweauuYrqeexxvodRhqAB1AaBgr
	482n7YIx5Op5kx8Nbnpjkmkj+ZM219EXs+Y3MbU/tCkxuLXTvwTUIjRdyZYldqQ6
	BsvdgxsG84aveIExKtmA83R6re1g4y5lEA9IqgcX8WwmcWDCMw1srJqmDbT0EFnT
	FxLiYHF/y0ikN4jL1y2qNCbXoNG6rLev85rbTYlGhCJF6hyeLLON1UVbFSB/iFgQ
	3k9Wgu2gAN+AqTN6xNbQZCliK+cKQPG4s7CwWBNv+tEOhnLNCYYGQbIQ0l94x9ML
	QYGsnxf0wzcnV80ffxVXkrQgERlWtTHg0B2y589mvu+4SsymFUwrQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqugs0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 14:50:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675EfK43002817;
	Wed, 5 Aug 2026 14:50:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyprua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 14:50:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675EoXn517301794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 14:50:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7021120043;
	Wed,  5 Aug 2026 14:50:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D6902004D;
	Wed,  5 Aug 2026 14:50:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 14:50:33 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>,
        Aswin Karuvally <aswin@linux.ibm.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net-next 1/2] s390/ctcm: Add __context_unsafe() attribute to various functions
Date: Wed,  5 Aug 2026 16:50:31 +0200
Message-ID: <20260805145032.1409325-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805145032.1409325-1-hca@linux.ibm.com>
References: <20260805145032.1409325-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: bhGR6EwEYHX7Cl5nivZq80MA83H3_JF_
X-Proofpoint-ORIG-GUID: CTA4hjeAJ2Gw7oXPATUN8LAMsxBOdeEH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEyMCBTYWx0ZWRfX9XmDCarm4Xr9
 WoGVWktRAS7Va9NH9d3Lo2Nq87tAupyn/d5SEV2tqrSwC0uOP+JaCNkF90pBVujlSa/0lkf6Oaz
 ydy/JZi5vwt2/bgv37nEXie+ifLviT0=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a734dbf cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=j69ynYp36yJWYSPH5OQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEyMCBTYWx0ZWRfX1Ppr77hyHFef
 Oic3tl20KQo/2lK5V0KmqBGA89GQwBWKy321r2zhQH4R16sepsP4tsnI2GA4RNCEesQr0NoqXGa
 i+r9VJteqVc2ap18WDsSdjlbqGH0xFvrFJCbVmotY+hgxhs8bABRmOfcVoSv/V+8Az8fVLHG/PV
 k5z5qg02Lk70rIGJbHZVGqfcgRTNvVhby6fqreaWYPB4QTgwVqNtGV4Oe5EhBWi5+uL8f/Z5MUm
 UavcZDx3+0GGmr1DNrMrNl5YP3SK2SHLQi8h3/KP/CEGwI2VROcy7uQjCWm4DXn104XKSq/BpKM
 l20J+pHllKlt33ksJbnAn4cmySVs9SQA5K6VtNuDY2DvFNOJ4YY/FF1cX9G7sO2lz5bjZwfgBHb
 xu7zwo2e2hx6bAuEY3bWis1YMWi9sPSdXXc5Kc8ny1xxUhELrxlopaK8OneRX/e9nFDx05Ahmof
 ldHlyZ0btvfQ8ufcZkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_04,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050120

Disable context analysis for various functions to get rid of context
analysis compile time warnings using clang caused by conditional
locking like e.g.:

drivers/s390/net/ctcm_fsms.c:1457:8:
  warning: spinlock 'arg->cdev->ccwlock' is not held on every path through here
drivers/s390/net/ctcm_fsms.c:1459:4:
  warning: releasing spinlock 'arg->cdev->ccwlock' that was not held

Use __context_unsafe() to provide a short comment why context analysis is
disabled for each function. Each of those functions already contains a
comment that the (previous) sparse context analysis warnings due to
conditional locking should be ignored.

Remove those comments everywhere and use the __context_unsafe() attribute
instead.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 drivers/s390/net/ctcm_fsms.c | 20 +++++++-------------
 drivers/s390/net/ctcm_mpc.c  |  6 ++----
 2 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/s390/net/ctcm_fsms.c b/drivers/s390/net/ctcm_fsms.c
index bf917f426453..84fd394d3525 100644
--- a/drivers/s390/net/ctcm_fsms.c
+++ b/drivers/s390/net/ctcm_fsms.c
@@ -545,6 +545,7 @@ static void chx_rxidle(fsm_instance *fi, int event, void *arg)
  * arg		Generic pointer, casted from channel * upon call.
  */
 static void ctcm_chx_setmode(fsm_instance *fi, int event, void *arg)
+__context_unsafe(/* Conditional locking */)
 {
 	struct channel *ch = arg;
 	int rc;
@@ -563,8 +564,6 @@ static void ctcm_chx_setmode(fsm_instance *fi, int event, void *arg)
 
 	if (event == CTC_EVENT_TIMER)	/* only for timer not yet locked */
 		spin_lock_irqsave(get_ccwdev_lock(ch->cdev), saveflags);
-			/* Such conditional locking is undeterministic in
-			 * static view. => ignore sparse warnings here. */
 
 	rc = ccw_device_start(ch->cdev, &ch->ccw[6], 0, 0xff, 0);
 	if (event == CTC_EVENT_TIMER)	/* see above comments */
@@ -648,6 +647,7 @@ static void ctcm_chx_start(fsm_instance *fi, int event, void *arg)
  * arg		Generic pointer, casted from channel * upon call.
  */
 static void ctcm_chx_haltio(fsm_instance *fi, int event, void *arg)
+__context_unsafe(/* Conditional locking */)
 {
 	struct channel *ch = arg;
 	unsigned long saveflags = 0;
@@ -662,15 +662,12 @@ static void ctcm_chx_haltio(fsm_instance *fi, int event, void *arg)
 
 	if (event == CTC_EVENT_STOP)	/* only for STOP not yet locked */
 		spin_lock_irqsave(get_ccwdev_lock(ch->cdev), saveflags);
-			/* Such conditional locking is undeterministic in
-			 * static view. => ignore sparse warnings here. */
 	oldstate = fsm_getstate(fi);
 	fsm_newstate(fi, CTC_STATE_TERM);
 	rc = ccw_device_halt(ch->cdev, 0);
 
 	if (event == CTC_EVENT_STOP)
 		spin_unlock_irqrestore(get_ccwdev_lock(ch->cdev), saveflags);
-			/* see remark above about conditional locking */
 
 	if (rc != 0 && rc != -EBUSY) {
 		fsm_deltimer(&ch->timer);
@@ -824,6 +821,7 @@ static void ctcm_chx_setuperr(fsm_instance *fi, int event, void *arg)
  * arg		Generic pointer, casted from channel * upon call.
  */
 static void ctcm_chx_restart(fsm_instance *fi, int event, void *arg)
+__context_unsafe(/* Conditional locking */)
 {
 	struct channel *ch = arg;
 	struct net_device *dev = ch->netdev;
@@ -842,9 +840,6 @@ static void ctcm_chx_restart(fsm_instance *fi, int event, void *arg)
 	fsm_newstate(fi, CTC_STATE_STARTWAIT);
 	if (event == CTC_EVENT_TIMER)	/* only for timer not yet locked */
 		spin_lock_irqsave(get_ccwdev_lock(ch->cdev), saveflags);
-			/* Such conditional locking is a known problem for
-			 * sparse because its undeterministic in static view.
-			 * Warnings should be ignored here. */
 	rc = ccw_device_halt(ch->cdev, 0);
 	if (event == CTC_EVENT_TIMER)
 		spin_unlock_irqrestore(get_ccwdev_lock(ch->cdev), saveflags);
@@ -999,6 +994,7 @@ static void ctcm_chx_txiniterr(fsm_instance *fi, int event, void *arg)
  * arg		Generic pointer, casted from channel * upon call.
  */
 static void ctcm_chx_txretry(fsm_instance *fi, int event, void *arg)
+__context_unsafe(/* Conditional locking */)
 {
 	struct channel *ch = arg;
 	struct net_device *dev = ch->netdev;
@@ -1042,9 +1038,6 @@ static void ctcm_chx_txretry(fsm_instance *fi, int event, void *arg)
 		fsm_addtimer(&ch->timer, 1000, CTC_EVENT_TIMER, ch);
 		if (event == CTC_EVENT_TIMER) /* for TIMER not yet locked */
 			spin_lock_irqsave(get_ccwdev_lock(ch->cdev), saveflags);
-			/* Such conditional locking is a known problem for
-			 * sparse because its undeterministic in static view.
-			 * Warnings should be ignored here. */
 		if (do_debug_ccw)
 			ctcmpc_dumpit((char *)&ch->ccw[3],
 					sizeof(struct ccw1) * 3);
@@ -1383,6 +1376,7 @@ static void ctcmpc_chx_txdone(fsm_instance *fi, int event, void *arg)
  * arg		Generic pointer, casted from channel * upon call.
  */
 static void ctcmpc_chx_rx(fsm_instance *fi, int event, void *arg)
+__context_unsafe(/* Conditional locking */)
 {
 	struct channel		*ch = arg;
 	struct net_device	*dev = ch->netdev;
@@ -1462,7 +1456,7 @@ static void ctcmpc_chx_rx(fsm_instance *fi, int event, void *arg)
 			spin_lock_irqsave(
 				get_ccwdev_lock(ch->cdev), saveflags);
 		rc = ccw_device_start(ch->cdev, &ch->ccw[0], 0, 0xff, 0);
-		if (dolock) /* see remark about conditional locking */
+		if (dolock)
 			spin_unlock_irqrestore(
 				get_ccwdev_lock(ch->cdev), saveflags);
 		if (rc != 0)
@@ -1539,6 +1533,7 @@ static void ctcmpc_chx_firstio(fsm_instance *fi, int event, void *arg)
  * arg		Generic pointer, casted from channel * upon call.
  */
 void ctcmpc_chx_rxidle(fsm_instance *fi, int event, void *arg)
+__context_unsafe(/* Conditional locking */)
 {
 	struct channel *ch = arg;
 	struct net_device *dev = ch->netdev;
@@ -1566,7 +1561,6 @@ void ctcmpc_chx_rxidle(fsm_instance *fi, int event, void *arg)
 		ch->ccw[1].count = ch->max_bufsize;
 		CTCM_CCW_DUMP((char *)&ch->ccw[0], sizeof(struct ccw1) * 3);
 		if (event == CTC_EVENT_START)
-			/* see remark about conditional locking */
 			spin_lock_irqsave(get_ccwdev_lock(ch->cdev), saveflags);
 		rc = ccw_device_start(ch->cdev, &ch->ccw[0], 0, 0xff, 0);
 		if (event == CTC_EVENT_START)
diff --git a/drivers/s390/net/ctcm_mpc.c b/drivers/s390/net/ctcm_mpc.c
index aeb102537e7f..08e36685e578 100644
--- a/drivers/s390/net/ctcm_mpc.c
+++ b/drivers/s390/net/ctcm_mpc.c
@@ -1647,6 +1647,7 @@ static int mpc_validate_xid(struct mpcg_info *mpcginfo)
  * CTCM_PROTO_MPC only
  */
 static void mpc_action_side_xid(fsm_instance *fsm, void *arg, int side)
+__context_unsafe(/* Conditional locking */)
 {
 	struct channel *ch = arg;
 	int rc = 0;
@@ -1774,9 +1775,6 @@ static void mpc_action_side_xid(fsm_instance *fsm, void *arg, int side)
 	CTCM_D3_DUMP((char *)ch->xid_id, 4);
 
 	if (!in_hardirq()) {
-			 /* Such conditional locking is a known problem for
-			  * sparse because its static undeterministic.
-			  * Warnings should be ignored here. */
 		spin_lock_irqsave(get_ccwdev_lock(ch->cdev), saveflags);
 		gotlock = 1;
 	}
@@ -1784,7 +1782,7 @@ static void mpc_action_side_xid(fsm_instance *fsm, void *arg, int side)
 	fsm_addtimer(&ch->timer, 5000 , CTC_EVENT_TIMER, ch);
 	rc = ccw_device_start(ch->cdev, &ch->ccw[8], 0, 0xff, 0);
 
-	if (gotlock)	/* see remark above about conditional locking */
+	if (gotlock)
 		spin_unlock_irqrestore(get_ccwdev_lock(ch->cdev), saveflags);
 
 	if (rc != 0) {
-- 
2.53.0

