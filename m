Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FFE5326C7;
	Tue, 22 Sep 2026 10:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790072371; cv=none; b=SDl1PBh5bCd9gK4voXseYsnyoQJRvNJbZyaGLWh8OU7m7LR6Yi+Oci+PyayH6rChJBdSV6813hXEyooZg/uKc6/SglTpUHLyPDHApUjIppaEPpfsXCdPtDoKuB/yhLbopLrn9MaeAsHGLcJukFx1IXLH1lmlVd5IWcFcI33s3nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790072371; c=relaxed/simple;
	bh=9VYlEBBzHvNgnKHjD/sB6aGAHCr33aE4j4uXIeG5GlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CECxONyzayVsZdItInpRKiKD7PuOYoDpF+AIu5pD/q3SBmIxYY1gUaU5Vna7gckUMD4uwo8nUx/+u1Fne+Xm4DxOf0Dm1IQiZvVQgsXU68uBPr6pJ14HBrivceTTn+JhF+S1LoL47LGqRCMcC/YwO6g76S96JywIhyLklvzyI4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qATCCJuR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qATCCJuR"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M05Uct1075347;
	Tue, 22 Sep 2026 10:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NNIbTOTUOhN+guE6W
	aKUWJifDAzgIR8Qvw1UneT4K/U=; b=qATCCJuRW3xWRhjg1PLeFgDteb8BOUL3v
	1RTLy99KTFay0ToKqBafd3U1deYsXjbdGlhozujxKiPdhYTgTNiDmj8i/l/KJ5oQ
	X4rgNz4PLRupQu5jpe/7KmUHvHANTg6FQr+nIaacLKrp+pbK1stoCb2sQ8MJSaKC
	i/V8bW2SWPNBn/RNwOw3okg7atLl47+76xhHGolztSqO2C6CM1ZrAhf58qZ16P2+
	tQ8N2erWnXiiBxJp1YYwyKNOiJgSFNaiJbRoL3o/BrbbnicSpxaJEENNXcgNEJd3
	jaPHeL5qF2R5ujCMZ1QcKf/ACXafdl6ZeLYnb84kalEq+qTsGal+Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1n626-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 10:19:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68MA7wjT2045776;
	Tue, 22 Sep 2026 10:19:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt67gs9t5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 10:19:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68MAJHit28377420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 10:19:17 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BCD020043;
	Tue, 22 Sep 2026 10:19:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12C2E20040;
	Tue, 22 Sep 2026 10:19:17 +0000 (GMT)
Received: from t83lp71.lnxne.boe (unknown [9.87.84.240])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Sep 2026 10:19:17 +0000 (GMT)
From: Nagamani PV <nagamani@linux.ibm.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc: wintera@linux.ibm.com, aswin@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, kees@kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, Nagamani PV <nagamani@linux.ibm.com>,
        stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net v3 1/2] s390/ctcm: Fix timer corruption in fsm_addtimer()
Date: Tue, 22 Sep 2026 12:19:12 +0200
Message-ID: <20260922101913.239103-2-nagamani@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: BGE3YdTzp6QTy7G87RG5h6b5x-hjI4dI
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab2562a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=c92rfblmAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=T_NMYt6YcsbJOU4cA00A:9 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE0NSBTYWx0ZWRfX7PX5YQuOCP+G
 TI53nyn6ypXr9ZVIawoSZKS/p61bs1fEDNXsIz3GMbyyfkvHSH3efVvjDJsRqEgH9Zsn7HyzDAr
 MEWuNH7xZRCUFrJsxgE3YJOXy6XIIOU=
X-Proofpoint-GUID: aPAs5Lz1YvfUZYgOlw0JET3kzGtT0vHN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE0NSBTYWx0ZWRfXxEJomm5BbdzM
 apMAz1YGfjZDg+Q6AHSOW+5Tihgbw4odor8wd0589mda8pBu9fNxAwSorOqvhTpKHmXmivRoLfP
 azcopKrJm0IpvuJ/koHTfog7Eb25rM1Xu4Z1ZMG8kk3tYzwI74ezqDAGoqiMRgYB99sLTvcg/w+
 WDpSpdyPbbyg3RtxOEyVByFbNDVa5LArSDZCue0G1Hn9cj7nEky3r3s4V0he+9qzDybcHEOJyap
 87yAa+LMuUkum8oa6w9UpDUCTxZ4XbtrJ6I07oW/PuVJCLmMXTKYREGBZUXWlc4z4lcd48nnRNr
 OP+nz8J5gp2oS7ujLGqhzu2zh+zwlV9YMVRg9NiM6k1jG6mRtDwCQVAPKYlXMozihn5HFchLxlZ
 MN5443NxI4vUC62S+MXLH85/cBvuNglWJCpRSYjC0dDJciiIsQNliT91TNtl0bfx9WRUnfcu2F+
 s8gtfQfOxtRnGQfpbnQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220145

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
Changes in v3:
- No changes to this patch.

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

