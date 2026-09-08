Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618783D3498;
	Tue,  8 Sep 2026 11:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788866793; cv=none; b=uwHh9lGnIniDXw1eAjsihmYPw10x1YzUr9ulNdwo0p12AMhWjcW+C47gOUtuUV+is/8ve/WRHdHevJbyM3W65LbaM05i/qfXHlByAWMgoGBSTS5Mu2WFXpcnfLXiesWqrJaxN0OIZwK5/7gKc3xhTm39tnvGuauPs/r4kaVYqig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788866793; c=relaxed/simple;
	bh=NRJWzG6+BUdTryF2o8t2oci58TIeBpzItGkSajbOHFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LS8XGwNFrg6kMm/hjc2BSgTXmuz0veUj4VqAUfmSLFuSeE3mrVAZPF9j3y6YHISyqCJ/IR7xRqOW5ZBqzmiaoVerl17/crHtn1yxjYXUul8GakvlsIgPtVna0GGs9zyMfZ3ywcFON3yLLblR6TPYtEUhycegY/5Zd+OFyO/nYiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qfQcfxmS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qfQcfxmS"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688AVNKl641397;
	Tue, 8 Sep 2026 11:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=0+KOuUkv5NXhrHFikHiaqF1JEy8ozSeMHfFFSOVyk
	r4=; b=qfQcfxmSrPhMZ58mnUbg546CZz+gzBVJj9tADChsn0KcBjuodqwg6NNoD
	0lWjkwbxD0w5zsyGbWxbjIqIGe4N9a8b1tByytgjEGJxMmKnUd+V8uIiMmuvhvjB
	vx/YuUhFbT7Q4vFaN0At/3W6+LmQs5Gboa9/2w5Jc7LGIiYq+IHkiTifNEgXZ5Qd
	6GO+Dy4k6Sg1BFRXdMBn7xJZYGY6DDuaVWSN1Pp2VfO6jLB7M+YMa6BuTtrBU5yY
	FnMDQ0ZBh0NXem9sJfXWXlAfMbrC+FHauCGyayY/cHeSTj8mmP0hOyrjE+R7P8z/
	7iRLDMdsBtBZoAP7eRMz5X/EgXHSw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhkph17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 11:26:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 688BQPTA009378;
	Tue, 8 Sep 2026 11:26:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggwsw3jmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 11:26:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 688BQKXY22217320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Sep 2026 11:26:20 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F1662004B;
	Tue,  8 Sep 2026 11:26:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CD2320043;
	Tue,  8 Sep 2026 11:26:20 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Sep 2026 11:26:20 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, ciunas@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390/rwlock: Add contention tracepoints to rwlock slowpath
Date: Tue,  8 Sep 2026 13:26:07 +0200
Message-ID: <20260908112607.828469-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDExNyBTYWx0ZWRfXxmZexCEm8m0/
 5VZ6Oj/yn8PDpCREQl8VtFXlQdVEi6/418mAVIsi8eSG2/Xi8tAU+qM12Y2GsBIdkL6TCXR3fbl
 bwHrI+SGndqk9I8J9snE5UXl0XEkEl4=
X-Proofpoint-ORIG-GUID: H5-Rwavw12wlNa_84TNdvAWUZHQDmjVy
X-Authority-Analysis: v=2.4 cv=NMDlPU6g c=1 sm=1 tr=0 ts=6a9ff0e2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=YYcdB7fvNfgyQl8EhqgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDExNyBTYWx0ZWRfX3x4rAEtrjcWg
 H5zGqUtB/fydgh5T8y2rxtSzWtrPbY1ZL3c9zk4Un5JMf75FZuI61ZtIkpsYbcfDXgVcew0JCGp
 PFzs5rYoAn+V+TwYg7nCpZC+dw8Z8YcvyG14/wkBLttgV8lT6ssf/vQ45L8SwFgxaQeh6B94d4o
 LAyOctM4q3TF+vI2qxyMNgakXf0868uEtWtIef5swq2LrJ88EEZyDdXwR0UbR1EYQfr2zZLJv0w
 1uJeSM2WOlNtzUlsOmVsu/Tv+FXFk6PtRc7a47n9QOliVdtelwIAyDKAbPAAonjmyj8CACZrjvf
 a2RaV6VfE/C768uVMYAexWVEbD29n29kWr/tFxyOxat5ifmZKm1NqoqXahG2rZ6Y3BpOiV/i0xr
 wSJvvG72ZBpQRJL0AiZf34wVm49Hxku3ZCityh3DEH3+dcENCFKde2/A7Ay3zu8V9Gxe+rsmGr6
 +8DBZcp0sBu9R3vO0MQ==
X-Proofpoint-GUID: H5-Rwavw12wlNa_84TNdvAWUZHQDmjVy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_02,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080117

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
 arch/s390/lib/spinlock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/s390/lib/spinlock.c b/arch/s390/lib/spinlock.c
index dbabca35c008..9094617a5e00 100644
--- a/arch/s390/lib/spinlock.c
+++ b/arch/s390/lib/spinlock.c
@@ -316,6 +316,7 @@ void arch_read_lock_wait(arch_rwlock_t *rw)
 		return;
 	}
 
+	trace_contention_begin(rw, LCB_F_SPIN | LCB_F_READ);
 	/* Remove this reader again to allow recursive read locking */
 	__atomic_add_const(-1, &rw->cnts);
 	/* Put the reader into the wait queue */
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

