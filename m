Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DB34F054B;
	Mon,  7 Sep 2026 14:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788792337; cv=none; b=DnWT2oCJAfIPDqazgehcHs17OlpCb1TGZDLQ0+NPiAPuQQnjUA3Cz5lisWYqWlhKpuliUO59/7H5v2BYQ96yQi9d4lVOksPdk/H+fX5pLiyj7zJY6300xOAnd5TqWa+2ZhZiuw497W7AvhDnZJvq465dnuwRuS/3pwzvZlJEJKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788792337; c=relaxed/simple;
	bh=tVN7exGVe+OxPH5wzllGt4ki5atK0RKHwBWi4j3CTUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXrbJO1WLMKlOD+N95qTPxTY/gHjF9gImfQjnR++Hc43wFaC2A8WoEcH7TizrI9XhQrQw0eLe4o0NkSr18tCQy3EkwJtwDhKsqOeg2EEvK9yVgQXDetbFEkPOxjgRnqMJN4fC2ca4E/autiSlMhhu4DipGgag9DTGBxFQ8CMk98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HSQsSB2Z; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HSQsSB2Z"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687E1ZbH1006149;
	Mon, 7 Sep 2026 14:45:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pCM9+mBbY9cVhqzRP
	L2jwxQGBQ0gRlI4+HZraomA43E=; b=HSQsSB2ZSszOtFJL8HTcZbHh0etyiH//I
	ABpWI30GYiqrkepmsMJYK/dRq6UiGLA872HUNu13fR5I18AkM1LkMIjPeXCxNv61
	kxH0t20QbYjMn42Z5it2p4RJ4n0bh4weHGu5Ue+ozw2YfHbUoSzvL5fQcXEmfxVm
	93ECajAm0JFrTujU5SCtG66qHUbT5nYvWT+dzPWax239pzq/0Nee2uwltP7w3KrD
	brL3hjvgqkarttTNsaacmY5AvnA5OUqutczKTvrXYCKR6iCZaqiIPTtd+Mf6uVZg
	4ul8+e2y/7gzmGGEI/pheY5KZeL4FZAfOVW7LocqLa5EKBRlBOaOw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbjrh5ub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 14:45:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 687EfPus001287;
	Mon, 7 Sep 2026 14:45:23 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gh03y695s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 14:45:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 687EjJdP50463072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Sep 2026 14:45:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C222620049;
	Mon,  7 Sep 2026 14:45:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8757B20040;
	Mon,  7 Sep 2026 14:45:19 +0000 (GMT)
Received: from t83lp71.lnxne.boe (unknown [9.87.84.240])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Sep 2026 14:45:19 +0000 (GMT)
From: Nagamani PV <nagamani@linux.ibm.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc: wintera@linux.ibm.com, aswin@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, kees@kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, Nagamani PV <nagamani@linux.ibm.com>,
        Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net 2/2] s390/ctcm: Fix use-after-free in channel_remove()
Date: Mon,  7 Sep 2026 16:45:11 +0200
Message-ID: <20260907144511.3810194-3-nagamani@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907144511.3810194-1-nagamani@linux.ibm.com>
References: <20260907144511.3810194-1-nagamani@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E7T9Y6dl c=1 sm=1 tr=0 ts=6a9ece05 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=c92rfblmAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=LCK66-T8MJ8bHskDLlgA:9 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE2MSBTYWx0ZWRfX+bAo5mhFFbaE
 eAH/e8wdBprqTEc+KyOx+QdslXrqgTW0hIPveONlM7/BLEzZUcKwnC2w+B53pYyrLtcrmAuUlNR
 rcUj/QlVBMhsIRHkHPp1C/cF+FFPpU0=
X-Proofpoint-ORIG-GUID: XKf7XC4XMiK-uFTmRUpZ4CiXDW_8RcvK
X-Proofpoint-GUID: pMaG_TKejyVRX8DqcBpzzoXhxXTr2dkd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE2MSBTYWx0ZWRfX5z6NwR0TkGcD
 QYib7iFdkmGu+TK4iyQ2g0cyMoVEIb33gYYAkXFNUIw7dDZCk/6WATm8Nb0qkbp0Nn9V8QbHaaX
 4Vv2QFvfuVupN8Qy54gMDcuGZo19NAZlvp0drdcsAgw60GM34kvhxRn5vSqYe3JCXqWo0tdgzTd
 ADmBSsJs7bofcIoW3vYpR1BfVy1AdufKqZLJBO+970qowkAvY3nYAQuEGb4XY0kJ1YxZyYezI+l
 N+aYWoXCzZ0XaEx75kx6pkCvRE3Uw5rCT5R7WqjYCNDeWx/Za2sconbzgb+oX40KeSJvw5WhoMj
 sGtLbQ9bRxjhCmImjmVbxxbs6SHcDEvr3wAip0NcUA+CHUx1ML0gdQseaLYQP/3xEm7PltB48h+
 H084gL5uAkNqPxPtPIShHZQXB5ebzMf86IQDpJ5cdAmCUOztj0wgvslBJJYnWIEuKBxt1ppNPgv
 y+sVgj+sVQ7GAyKlLVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_04,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070161

channel_remove() calls fsm_deltimer() which internally uses
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
fsm_deltimer(). timer_delete_sync() is used rather than
timer_shutdown_sync() because the channel is fully torn down by
channel_remove() and the timer is never re-armed after this point,
making the re-arm prevention of timer_shutdown_sync() unnecessary.
This cannot be fixed in fsm_deltimer() itself because FSM action
functions triggered by CTC_EVENT_TIMER call fsm_deltimer() from within
the timer callback chain, which would cause a self-deadlock in
timer_delete_sync().

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260803182736.2356374-1-nagamani@linux.ibm.com?part=1
Reviewed-by: Aswin Karuvally <aswin@linux.ibm.com>
Tested-by: Aswin Karuvally <aswin@linux.ibm.com>
Signed-off-by: Nagamani PV <nagamani@linux.ibm.com>
---
 drivers/s390/net/ctcm_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
index 8b0d76a47d9f..63f8832f9b14 100644
--- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -211,9 +211,9 @@ static void channel_remove(struct channel *ch)
 	while (*c) {
 		if (*c == ch) {
 			*c = ch->next;
-			fsm_deltimer(&ch->timer);
+			timer_delete_sync(&ch->timer.tl);
 			if (IS_MPC(ch))
-				fsm_deltimer(&ch->sweep_timer);
+				timer_delete_sync(&ch->sweep_timer.tl);
 
 			kfree_fsm(ch->fsm);
 			clear_normalized_cda(&ch->ccw[4]);
-- 
2.53.0

