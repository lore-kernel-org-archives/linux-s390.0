Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D945592F0;
	Tue,  8 Sep 2026 13:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788875953; cv=none; b=uHC6BRPNLFrzbP+xg+DPALVLQmAwGwnvxQ3JgHFztMaAoKWA4GyMmh1E4MVNJIznsW3FqyTwVYuY9e5vuBarItpEdmpSc/ZG+vLXWYiJIjsidWKe1AdPhRWOcdX8H52uq0enePoyUi6FDfgjCo8PcmmtXTZZoanLzOGJ38Os6Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788875953; c=relaxed/simple;
	bh=bZJtJCOAOgV0u3xemrFTs11xz8hf4sJwrOt5eIn7Cic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i1emBHt0yvnLrBiolOGeLHzTZ62LpazOrjRzobxMzo+veuqawH8+3HY9kdPuFgVFVZ5hHbqGbw5kml65ovT/ECNBuh0P9LOKXsYKtdcFpbgNdBgn27T7zAH8D0oiA+z2o50hePM2SRexhhUbM4NRimKD6r0ddVkfJ+/soY5CXJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G7X5SwGz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G7X5SwGz"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688D1Val966810;
	Tue, 8 Sep 2026 13:58:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=+a7HwRmXbItxlGjm4Y7u5hDFhYq/CU7cfq0FvCIrd
	R4=; b=G7X5SwGzL5FNhNmpKWI2BF9jAhfXU0Ix+ZScg3VZOT5Q+HPJVQ+yKNLVm
	GmuOWBbiRLOenCHvR/8aL39y556n/Jg3XoV10l1ROae+EgwEoq35qwn7xo6bnx4j
	kBQB/gCl55ei8L8SfGxpUgTcWi+Mfi7Gk+XpX3lZim4DWjaYZKmvGN9LXjHunT69
	Zf0xsZZwqasAzFq+t/SZneGQQR62ENONvhmSCwC4EdxyUrRyeF9wMI5dtyrXk92t
	V1ybZaCQDSLqWTf5heQOfq8mgj+4rz4Q54oOxRSdFo7NGw436/LN4ZCOGSFZWYJs
	9600Pllm05Xel/MTCxLwJ2WQTR+Sg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbf3ybr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 13:58:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 688DuDbp011292;
	Tue, 8 Sep 2026 13:58:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggwsw49d0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 13:58:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 688DwlcI42991938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Sep 2026 13:58:47 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCA3C20043;
	Tue,  8 Sep 2026 13:58:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89DAB20040;
	Tue,  8 Sep 2026 13:58:47 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Sep 2026 13:58:47 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, ciunas@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] s390/rwlock: Add contention tracepoints to rwlock slowpath
Date: Tue,  8 Sep 2026 15:58:43 +0200
Message-ID: <20260908135843.1384367-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WabEUFDeeqN6OHigmuxnbHO7Eyh05LkF
X-Proofpoint-GUID: WabEUFDeeqN6OHigmuxnbHO7Eyh05LkF
X-Authority-Analysis: v=2.4 cv=DbEnbPtW c=1 sm=1 tr=0 ts=6aa0149d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=JY_O3_BXcsAUf05eb4EA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE0NSBTYWx0ZWRfX0J4rEKPFs4sr
 uaz2l5CVyy6c5eiFIdp3QOFko7q33KcjpEElTXblUN64WFMme9UcgRF744Xa8qO/a73l5/GBo4G
 +LEZtckjA7hG15hOIXLEd60kwqQ18c/rDfFiQG2oWUWzFYg3rLP7f6LZQCrJ4ob83FzIgQe0laC
 8xBjJXxZMUGwbIIIb9Tv8/Gvb1vzZz+lxbT+3fGmecTpc93uScwvA7jOgmDGtvqDU5RAwREVGAS
 ek+eTNzynSaw7eFpWyNrb1ivkVXDKkX80vtCyQpIoYMRM1wu4WXdPFYwo4zxOKnveB92u3V9EGS
 LWpby0o3qZi1S9TjHAM9eTkMCBsnhqX7BUx5vnlPCfQ2MyJmnfufv9F4jBHzwNDR4qfqeALnLsq
 YrxH00161iEu/UhaHU17MoSRc+4OWLwzji1siDRW+2h2JVX5Wn8nWlP93qXOvuFcKnF2gKI4FPz
 6FLSJ3W5k9qtPup0uYA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE0NSBTYWx0ZWRfX+w6JNyZ6bRnp
 ubE3mDvoRP5W0enAbNhPDbAikz+UgT/lLsLqIb57eX858wy8vX+y0wKleo0qD9RaTLaX6ZG0eja
 fS9cyxaH/cCDqqiInUjcGusdlt5wCwQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_02,2026-09-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080145

Instrument arch_read_lock_wait() and arch_write_lock_wait() with
trace_contention_begin() and trace_contention_end().

These tracepoints are used by lock contention analysis tools such as
perf lock contention to identify contended rwlocks and measure wait
times. The generic implementation in kernel/locking/qrwlock.c already
emits the same events from its read and write slowpaths.

For arch_read_lock_wait(), the in_interrupt() fast-path is intentionally
left outside the tracepoint scope. That path spins without entering the
wait queue, so it does not represent queue-based contention and its
duration is not comparable to the normal slowpath. This matches the
behaviour of queued_read_lock_slowpath() in qrwlock.c.

The include for <trace/events/lock.h> is already present from
commit ffa796cc1f45 ("s390/spinlock: Add contention tracepoints to
lock slowpath").

Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
v1 -> v2:
- Fix tracepoint placement in arch_read_lock_wait() to avoid recursion deadlocks.

 arch/s390/lib/spinlock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/s390/lib/spinlock.c b/arch/s390/lib/spinlock.c
index dbabca35c008..c84991a1be20 100644
--- a/arch/s390/lib/spinlock.c
+++ b/arch/s390/lib/spinlock.c
@@ -318,6 +318,7 @@ void arch_read_lock_wait(arch_rwlock_t *rw)

 	/* Remove this reader again to allow recursive read locking */
 	__atomic_add_const(-1, &rw->cnts);
+	trace_contention_begin(rw, LCB_F_SPIN | LCB_F_READ);
 	/* Put the reader into the wait queue */
 	arch_spin_lock(&rw->wait);
 	/* Now add this reader to the count value again */
@@ -326,6 +327,7 @@ void arch_read_lock_wait(arch_rwlock_t *rw)
 	while (READ_ONCE(rw->cnts) & 0x10000)
 		barrier();
 	arch_spin_unlock(&rw->wait);
+	trace_contention_end(rw, 0);
 }
 EXPORT_SYMBOL(arch_read_lock_wait);

@@ -333,6 +335,7 @@ void arch_write_lock_wait(arch_rwlock_t *rw)
 {
 	int old;

+	trace_contention_begin(rw, LCB_F_SPIN | LCB_F_WRITE);
 	/* Add this CPU to the write waiters */
 	__atomic_add(0x20000, &rw->cnts);

@@ -349,6 +352,7 @@ void arch_write_lock_wait(arch_rwlock_t *rw)
 	}

 	arch_spin_unlock(&rw->wait);
+	trace_contention_end(rw, 0);
 }
 EXPORT_SYMBOL(arch_write_lock_wait);

--
2.53.0

