Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1124F6467;
	Wed, 16 Sep 2026 13:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789564941; cv=none; b=dObSfwTZaEiEj3KrhywLOkmCRV0Nb/lzXJ/V9EDv++T/hkt1tRUglefgQSy9cvwvcorAvnWy81JGIuUx+NJ1chVZwT3Oewrfq1xOuEiAxUXwK053gLaJgUNTEkVjZrFQX7ooSH74tH5VIIDNRQ9614PTLbtYKyR77TV2kGVqynQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789564941; c=relaxed/simple;
	bh=ze+Aw9WdTGhsZ4i0naMYgcnBoUTra4tVH8dOWrOEABo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QwpGyOAl4SnL6NOQxmHSzms4LBzH5Dn7H/dx0WesNa0TQ9GFZPwzCSeSBNa+OTVkYFHYw6hktkjsum1nu/CwbIamJWYWn+gUGwMXLv6oKPf+VQxRDQ1MxlsLGBUM6iy+1sTXvg09H90uKljqThjBjHcdn4GemWB9jTb425QnU1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ib4HMDi/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ib4HMDi/"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GCVbZO3753170;
	Wed, 16 Sep 2026 13:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TA9laSBzAgR+QI2Gg
	X0SBR/sLGZub2r9/L5mZE+8KuE=; b=ib4HMDi/B75zLJBuHUK6/QD70DsXsgBJ2
	FCKj4mmSpToE04C2AdmmxRRuqt18b8cBH74I8+t+tdMNPhfUqucsO8HQeKFbjlOb
	3f1m+sgm0IVC6kO9Ggay4JhRzD9IbON53gCzUVBHZpqtG1QupSbw6W7jdV7y8k5H
	oMl687etIis6e+nWceJQpQ6ztEoy5DVFAaMpr8JMxluKeXqQ2gEuWiI9MclQ7ruN
	+892RIFfmD2vFlXy+BkbMsHftpYnQRYArMkHl4hRAkW0j2X7/CfKNgVOGBYBE0Su
	wAlAu1ci4BjSiEgGNwrYCwjKApCOh8TN7ag0FL0joE/P1Ql6j6Kqw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx83vr0q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 13:22:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68GCZStC1404907;
	Wed, 16 Sep 2026 13:22:05 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gpyxseh9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 13:22:04 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68GDM15X45613326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 13:22:01 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCBBE2004B;
	Wed, 16 Sep 2026 13:22:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9687820040;
	Wed, 16 Sep 2026 13:22:00 +0000 (GMT)
Received: from t83lp71.lnxne.boe (unknown [9.87.84.240])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Sep 2026 13:22:00 +0000 (GMT)
From: Nagamani PV <nagamani@linux.ibm.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc: wintera@linux.ibm.com, aswin@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, kees@kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, Nagamani PV <nagamani@linux.ibm.com>,
        stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net v2 1/2] s390/ctcm: Fix timer corruption in fsm_addtimer()
Date: Wed, 16 Sep 2026 15:21:48 +0200
Message-ID: <20260916132149.4185912-2-nagamani@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916132149.4185912-1-nagamani@linux.ibm.com>
References: <20260907144511.3810194-1-nagamani@linux.ibm.com>
 <20260916132149.4185912-1-nagamani@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE3NCBTYWx0ZWRfX0u6a/Auel9Pe
 WSQ1QuMFOFql2+c0OWUImfZZ/rA4CtL4GKOODKnYaEC12D56UKpTE5BYHBaSlnN9KL/+qs2lbmy
 lHw5v6/O5YaMfegVRJ6QuARO0h+4MxGjFys6vh9JHx+2ceR09ZYxCAzGW/vqmbiOPGovrozs0uq
 rBST6jPhWiW1wcxnBtUiIxvrn5wFmxXOfqPbk52woV2MeK5l97xY8CCuz84CvDeswCiETPJ/A1b
 TXMrVED+YuY1/LMkZxZcPg5SBDipAXxvIkcw0CPnfRgi8gb3tKRB8O0jiNFhZf5vUO7DXowgIfq
 jl8G90CGV//9f975kKHESOG4rP3F8C2esXt3dU0I6mua/JL1D9R0iDuUABLpusB5vWMLrsejt2r
 nlbfxbfek5je9IjK1ASJfLiXMv+9hQpYM6NzrPUSFOHuDax/K838pEl9D/pGQE+3BBFh0M/PEAJ
 8gvE/84z29OHMWVxwVg==
X-Proofpoint-ORIG-GUID: qOfK38SfL7-OYQsNycEfvfVKMkwqjaWO
X-Proofpoint-GUID: qgcfhJcrB-XyGGN-B-s8fJllxMysbn-u
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE3NCBTYWx0ZWRfX06ZeQgcVQyXI
 Dtns36RmohEDnx7N7j8QzVrSNSapVU15i4Z/Kkb8EZh6V0HgIjf78DbL9n6pGJr2/ihPfYAuYAL
 wKS5SqQeSnHgmKbR1cN8qjSLydLjiOY=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aaa97fe cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=c92rfblmAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=T_NMYt6YcsbJOU4cA00A:9 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_02,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160174

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
Changes in v2:
- fix function name ctcm_send_sweep() -> ctcmpc_send_sweep_req()
  in the commit message (Sashiko netdev-bot)
- call mod_timer() then return 0 explicitly, preserving the
  "Always returns 0" contract documented in fsm.h (Sashiko netdev-bot)
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

