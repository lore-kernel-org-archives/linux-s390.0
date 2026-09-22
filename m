Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E43F5328DA;
	Tue, 22 Sep 2026 10:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790072370; cv=none; b=WC6sWz2In3LAVIWTL3QtjFhCPO+LiCvIIHSorDfjiCM7Jp3hW14Ane5whi/gvKW/8COMeidPRWq+65wVgY+r0fupbVA6vubGyr5fmiYBglbY/S40mfNbfj3j0JXfHwYe2PQKE/vZ1FUJMzV5tLG8L6YlO+DVOTXzRzqWccHsf0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790072370; c=relaxed/simple;
	bh=B1Qa+nkvY8U0bmLpznwmykvTGZOX4kTi77Pj0B3TFTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i1D1bzoAoB8uVeCd/BL9wGe1W+AeeUJepwYbcEtvhbo6JVY+jm5w78L7Dhne6ySEMJKEH/z/g79Tzfb0JgPU5zELr8JOe1YY++lEAnVCh+IGRx4oTby5RgNq7GqShVkx8jxBvJqm1XtFMziq50C3M4UfkJi9cJ6etpv7oB5haEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rH59kq5P; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rH59kq5P"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M05dGR1778072;
	Tue, 22 Sep 2026 10:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=SENuwHelByXhcnMfBQ+ZhMnkdBktkHZiPgELWqnwx
	WI=; b=rH59kq5PK4Ve1UaRHbqeAAoq31iYstyZ/PkwfoDxe7EGRB9RmS4Xj1Waa
	13FRSVrl8qyOrMFGIt47GNjsAgPJeW9JGojKAGykbwmpOvK7j+sK4oduw7dza2/A
	k7JOeLbsYZ5b4DwI0yN2J7kVbYhOdgppEsNDN5nqwu/tNifakenYl4NZ+Fcf2UkY
	EoiT83P4BZ9gLwBsIdc4N/I0byomC7ooQ95bcuUkl3k4mXKxNNn6v+tTBIC1y3uy
	0aZZ7S3QV3yB2CqV3kqTYJrCiHPp6aOQck0fX002fETyC3CyaNajBOYTOLbp5ab7
	VXmRRaVO9kpgR0MApjvSvg3cWYXRA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqcujn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 10:19:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68MA6wQC764392;
	Tue, 22 Sep 2026 10:19:19 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gu5bkbwkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 10:19:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68MAJFsV48562646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 10:19:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A97B620043;
	Tue, 22 Sep 2026 10:19:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 631BE20040;
	Tue, 22 Sep 2026 10:19:15 +0000 (GMT)
Received: from t83lp71.lnxne.boe (unknown [9.87.84.240])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Sep 2026 10:19:15 +0000 (GMT)
From: Nagamani PV <nagamani@linux.ibm.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc: wintera@linux.ibm.com, aswin@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, kees@kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, Nagamani PV <nagamani@linux.ibm.com>
Subject: [PATCH net v3 0/2] s390/ctcm: Fix timer corruption and use-after-free
Date: Tue, 22 Sep 2026 12:19:11 +0200
Message-ID: <20260922101913.239103-1-nagamani@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab25628 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=3rS-qYyT1ibZB_HPfVwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE0NSBTYWx0ZWRfXw+XoZuDyjcpI
 lYYpk5buZxKy/oFMo99qq4d7iqz2MyhyoiVq/8A1ngxA9EHqZNSiqiiK0IVk0uB/qlfCVuV9PD1
 qozWClN3oow6lxKbtbzmU2jkZPMgA73H7IXs58bzHgc++BCyoL5frqXohH7gbW7GSMTGg4KA88x
 N5gMYeMZ1C9K6f0CBwAGFGlUk1vICBeReorjW5gpXYJv3JpDnW27ChKmK4Sh9KWOE4glcNFeXx3
 XZ+tDuUcWUip/OCeWLWjmh5owC5E1e515AByhNcqQgQvb9lrx9hiZG+pfurt+eD64doq+GtfVi0
 KD/pvN9X/JNi6ETcfWL6GNk6GsYHjsIZHE4Yo8wgixELcViIu0YnO2swvHEbMo7X8FF0wO3kFKN
 yGXfipJu0EfXSudvxmzosnazgwu8pCRSIMWI0tiO1ci2XPkCWpHCzNtxKB0qop39T97ASxVa7V+
 NIKlniu0ChUyHgEGsBA==
X-Proofpoint-ORIG-GUID: PalLib8XLoV_i-NlgGGXYGNZOiMsQhjt
X-Proofpoint-GUID: Q4jUXzb0cB-NR1SJQ07UXANXqpeAMU6E
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE0NSBTYWx0ZWRfXyHA8Aw/1v2Ek
 TzTHA1k90wI8VHPkLN8PZDQglAj3yx2XrJJQI75oGAeOXq1CbQ8Ki6pO3nUGOA9KVoquBwYchYO
 hj/blmb8eit9JnvS+5rGrvDD7x1lwUA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220145

Fix two timer bugs in drivers/s390/net/fsm.c and
drivers/s390/net/ctcm_main.c found by Sashiko AI code review.

Patch 1 fixes timer list corruption when fsm_addtimer() is called on
an already-pending timer - timer_setup() re-initializes the timer
list_head while it is still enqueued in the wheel.

Patch 2 fixes a use-after-free in channel_remove() - timer_delete()
returns before any running callback finishes, leaving a window where
the timer callback can access freed memory. For MPC channels,
ch_tasklet and ch_disc_tasklet are killed first so they cannot access
freed memory or re-arm sweep_timer; sweep_timer is then shut down with
timer_shutdown_sync() because its callback can re-arm ch->timer; only
then is ch->timer stopped with timer_delete_sync().

Changes in v3:
- Patch 2: fix MPC tasklet/timer re-arm UAF identified by Sashiko:
  kill ch_tasklet and ch_disc_tasklet before stopping the timers, then
  shut down sweep_timer before deleting ch->timer; move
  kfree(discontact_th) into the MPC teardown block.
- Patch 2: code changed; Reviewed-by and Tested-by dropped.

Note: two pre-existing UAFs in ctcm_free_netdevice() (grp->timer,
priv->restart_timer) and a NULL deref in ctcmpc_chx_txdone() are
confirmed but out of scope for this series; follow-up patch planned.

Changes in v2:
- Patch 1: fix function name ctcm_send_sweep() -> ctcmpc_send_sweep_req()
  in the commit message (Sashiko netdev-bot)
- Patch 1: call mod_timer() then return 0 explicitly, preserving the
  "Always returns 0" contract documented in fsm.h (Sashiko netdev-bot)
- Patch 2: add Fixes: and Cc: stable@vger.kernel.org tags
  (Sashiko netdev-bot)

Nagamani PV (2):
  s390/ctcm: Fix timer corruption in fsm_addtimer()
  s390/ctcm: Fix use-after-free in channel_remove()

 drivers/s390/net/ctcm_main.c | 15 +++++++--------
 drivers/s390/net/fsm.c       |  9 ++-------
 2 files changed, 9 insertions(+), 15 deletions(-)

-- 
2.53.0

