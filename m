Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319674457D0;
	Wed, 30 Sep 2026 07:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751786; cv=none; b=oIeBau+aEfIwWhqDTa1YUsfCEh97Hq+LzCL9FXviPqoIwS0pL7ozy6+Jju9a6nWd0+J34afciYWlaXA7SB7geBGwAjhGLQubVzns9mku9RkL2jpwNpVs/XxURxxHGusYtDTRG0ELL3dPJqpJXelYRdrHT4zjbD47W0SPSISJsEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751786; c=relaxed/simple;
	bh=qlRqE2vNenbOLICqAkjg4vnZ5IytPZbJEx9QsZytqEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P1IqBvEzvWdfVTu+DP8FzIT64gIe/+sE0sWjUGAyrlhOzUMh2do/3+bPQuNnP32qclLHjj7EtXRNclU2D3qKT1M4ZIgw/HB0nUI0NXWR9G1pQHQ71xd/r6zbuphYjpdeZrL+wa0bQHCZaVgBMXl2X190gXczgEgptqvg2S6MPRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G3oLGZZ4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G3oLGZZ4"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TNZTVM1171251;
	Wed, 30 Sep 2026 07:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=0m+hd4dzlVyX6WJx3fvPh0IxBeM4mypmVgHmJ/XKm
	QU=; b=G3oLGZZ4I/2A6XEUNvDK3Sb4eHG+cYQ6YK43ZINLGjATJlDRtJ7VYFH2a
	yNvJgR78CRdK1S6/z5Hft7P7gnjrKj+bxXhxaprwxVQL1rlB1kqjS3ZWJOjUZ3Pb
	vxn2ghDpS7x6nFWxygQTV9LmgLVrR9BlGRJx5ZYvH/6iR8RHYmVKiSO4bRoVX4BA
	W6NC4Mr2Ex6pKgwozVPpt2bgH1gSw83sHkBDqb1DqMbjOpHLxmfTHNbEYV40OzF3
	XN9PMpE7q74eS8+Lb0G+sv85l+StsBw7soz6qeKimDZfdk0E3LHc2+wVwaJbn5I7
	obtyfzyoy+h1cSIx/JJP1ETGiM7Dw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fkavtk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 07:02:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68U4abSA2606303;
	Wed, 30 Sep 2026 07:02:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsvhn8dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 07:02:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68U72bed47645134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 07:02:37 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1B4520040;
	Wed, 30 Sep 2026 07:02:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A800E2004B;
	Wed, 30 Sep 2026 07:02:36 +0000 (GMT)
Received: from t83lp71.lnxne.boe (unknown [9.87.84.240])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Sep 2026 07:02:36 +0000 (GMT)
From: Nagamani PV <nagamani@linux.ibm.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc: wintera@linux.ibm.com, aswin@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, kees@kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, Nagamani PV <nagamani@linux.ibm.com>
Subject: [PATCH net v4 0/2] s390/ctcm: Fix timer corruption and use-after-free
Date: Wed, 30 Sep 2026 09:02:32 +0200
Message-ID: <20260930070234.569500-1-nagamani@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: jb15DGqXlZqq59Xnj4XWlo9rTL001oRg
X-Proofpoint-GUID: DUMgBzWgkWuLLMXwnH2F3j4mbhH0jwTc
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfX/53ERnLX7sDo
 w8/EJY3sWlOT6D6yh9rjgz6fAGUnpF8/gFXPFnTOw5D/DSRCFAogXBE/AZw8HsIyLdlb81Mszyn
 bwEvaRylDvepTYHw718B1A20bz1H730=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abcb412 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=xbCyY-VrbdgBLaH6_X0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfX6alJsvJf4OkD
 R04aRQSr73X8eL6TOvl4DIzzO8ICA21zC5frOl7gzumVfD9guCNVTElYCmhZSIo1tcyoIsr42tn
 7XDteU6DDAn02TJKxG4U8dTRj4KxOZZeJxuHRvgeEtBVqMCZSC3CxilPM1vT1zQpLDQOTDvpWom
 aHn+VrtFfPEcj3q9/yrFvPRax3akWh3DF9Rb0aFJPQwBej30UQfDr9++N/xS1Gqtu9w9tftZ7pE
 BlDOKs7b7xVtiQ/UMK/267J6X36lrF8qWawHuKmcNfOU4UN9szkA5OV+sAoaunN78pllNCgyaUP
 PY8Qf3SmkPSlazFuyAR0rZizp7HLcCztwJrbMuwbQenQ69WX04wczwV9MGNO/29ADNnlvH+sfm5
 AX28Y00u3kKI1gTzdoRLKP/l6CfVOp0CcjW5WtJV6dGAB20J++1Q9XSeYDu741hiAiBRudtGAP0
 Gv4Uj6uN78W7aN3UcvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300026

Fix two bugs in drivers/s390/net/fsm.c and drivers/s390/net/ctcm_main.c
found by Sashiko AI code review.

Patch 1 fixes timer list corruption when fsm_addtimer() is called on
an already-pending timer - timer_setup() re-initializes the timer
list_head while it is still enqueued in the wheel.

Patch 2 fixes a use-after-free in channel_remove(). For MPC channels
the teardown has a circular dependency: the ch->timer callback can
schedule ch_disc_tasklet via mpc_action_go_inop(), ch_tasklet can
re-arm sweep_timer, and sweep_timer's callback re-arms ch->timer.
Fix by shutting down both MPC timers with timer_shutdown_sync() first
(sweep_timer before ch->timer), then killing both tasklets. This breaks
all three re-arm paths before freeing channel resources.

Changes in v4:
- Patch 2: shut down timers before tasklet_kill() rather than after,
  shutting down sweep_timer before ch->timer.
- Patch 2: use timer_shutdown_sync() for ch->timer on both MPC and
  non-MPC paths.
- Patch 2: name prerequisite by commit title and add structured
  stable tag dependency (Jakub Kicinski).
- Patch 2: code changed; Reviewed-by and Tested-by dropped.

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

 drivers/s390/net/ctcm_main.c | 14 +++++++-------
 drivers/s390/net/fsm.c       |  9 ++-------
 2 files changed, 9 insertions(+), 14 deletions(-)

-- 
2.53.0

