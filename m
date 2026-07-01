Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1A536B07C
	for <linux-s390@vger.kernel.org>; Wed,  1 Jul 2026 16:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782924433; cv=none; b=VL6duEmEtnf7Eu0Ddr32aw/qHfOsaMmLTxCi8FX7PSjJgbwvqzM7EUNdqJf3V6i2mW4k3UtawEUz85s71SevY//qATRk3kPUVFu+zy6MS6ioJejMJaUBwNbOYZx0WrUod1I7oQ1OkIIixW80oXfkhRfevgnaS9+NPudSPHBoOMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782924433; c=relaxed/simple;
	bh=+gkOl6Jma5OdYt9EGfZHA5frhFKAnc1cMPLw/iRwn1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=htGksQw7LwB9Jkd9if3301D1HiUCqHsyaVmXWolzAvnpOk8/3XOodsztJG7qc1fRlGLIMWr30zY6iXEkxo/paWxcpGDTHGXfRNGu7/6Zu5+eGNlQNR6a/KU1naiubveL3C8X+6MIV6PaGL21NzPIzr/Ky36/v0OLbHV1PFf9WX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N7URT1cA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N7URT1cA"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661AIoow495301;
	Wed, 1 Jul 2026 16:46:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7HeIz0x3Vg4GqOBlZ
	v/iGgOTB+uhuxBJfASbtqqOY7o=; b=N7URT1cAu1psOodMHEQCKrSclIBRZCxYQ
	/FGHelWGTfVpHyLk1TxuvVgBWWPR3hlU5vuXzhfxR570WnXCLAr+Qpgm7bae88MU
	fz8XFiEaUeQ36kyK0A2cpxAFGAthD9Gudq4ztI50EPM7Tv9aK66cGhTZowaFYinX
	dgL2Ke5DR3gi9SexKyCKqs6w3JAZTwtT3wcnQnCmbg4MzFH0/zMJzVjfENHIHsTZ
	hjr/+6uFTKz8Pc5Pebu/mSGFV9M7cc1Zh4EzFQcpLqjpbDIS7u9ogcejiblROBrQ
	Dy+K4yDfomrvUAZcBa311o+ULa1/kqkCsCnuj+x7gI4LvxuZL+ExA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rf56f3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 16:46:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661GYbPY023119;
	Wed, 1 Jul 2026 16:46:56 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhg3wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 16:46:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 661GkqAN27132286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 16:46:52 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F37A720043;
	Wed,  1 Jul 2026 16:46:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB5A72004B;
	Wed,  1 Jul 2026 16:46:51 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.187.249])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 16:46:51 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v9 01/21] target/s390x: Fix wrong address handling in address loops
Date: Wed,  1 Jul 2026 18:46:24 +0200
Message-ID: <20260701164650.95760-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701164650.95760-1-freude@linux.ibm.com>
References: <20260701164650.95760-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a454481 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=JcvBkDReJmzHsdK6FyIA:9
X-Proofpoint-ORIG-GUID: rmq90IjdDyk1ha73vrcGhEkSXQYzOxko
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE3MyBTYWx0ZWRfXykzZCLdUQJjd
 vVzaBvUMlZRmY/vYT75KNBW7SRvz87TTLqXjctwMQo+qxYr3F9+EimjsUdOE2cL2QloZqGxg9xM
 +1fG8+0AUWmu9QemopGWQFWZGPy7s2HIJrqOkgdXmNbchgVqIkGh2UFT93h0rQ91RALvl2I8WH2
 F3vx5vQp6w7ozMauACRyo5/wA87w/ZmvyS3AsV/QwoVGw8lp3lnfcePvXEjmlun48xUMVZsU8Uc
 1ggPH4AuQ67Azxo/FRrNg35ZVlMfuJo5c/3+w50CCKHPFjafI1v46AqRUgKfKSehvQdYfm6zzzb
 OulflBqrAKLJuOHeRQJU1zJwUtMzC6gChlTK37BG2HOX0iM8CKEEm7D+YQtp8bbmOw/qfBSL8q5
 2HUZPH8E0rVPNVp4BRwJ/PSxRDIFR3Xcd+ImV+m+TA3TRHT98wXK9xc7vSTuMnmwx0BBotKcSNI
 X2EEPWOfGptIuAg1wog==
X-Proofpoint-GUID: rmq90IjdDyk1ha73vrcGhEkSXQYzOxko
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE3MyBTYWx0ZWRfX+Us5Fz3ZHRzg
 atHKzHQDf7zyb0jbQU9i4cD/PnjwVVIkHJG+sysfSpo62WhQfA6hw9ScSHkN11Av8GxYZXFo1jB
 838By/Ap+TFkVloQ03FIZSgdHup4Cc8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010173

The loop increments addr by the element stride (+= 4) before calling
wrap_address, but then overwrites the loop addr with the wrapped
value. On the next iteration the stride is applied to the wrapped
address of the previous element, not to the original unwrapped
address. This results in every element after the first is read from a
wrong (wrapped) address.

Fixes: 9f17bfdab4 ("target/s390x: support SHA-512 extensions")
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 target/s390x/tcg/crypto_helper.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index ae392bce0e..8fe0a22219 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -126,8 +126,7 @@ static void sha512_read_icv(CPUS390XState *env, const int mmu_idx,
     const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
 
     for (int i = 0; i < 8; i++, addr += 8) {
-        addr = wrap_address(env, addr);
-        a[i] = cpu_ldq_mmu(env, addr, oi, ra);
+        a[i] = cpu_ldq_mmu(env, wrap_address(env, addr), oi, ra);
     }
 }
 
@@ -137,8 +136,7 @@ static void sha512_write_ocv(CPUS390XState *env, const int mmu_idx,
     const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
 
     for (int i = 0; i < 8; i++, addr += 8) {
-        addr = wrap_address(env, addr);
-        cpu_stq_mmu(env, addr, a[i], oi, ra);
+        cpu_stq_mmu(env, wrap_address(env, addr), a[i], oi, ra);
     }
 }
 
@@ -148,8 +146,7 @@ static void sha512_read_block(CPUS390XState *env, const int mmu_idx,
     const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
 
     for (int i = 0; i < 16; i++, addr += 8) {
-        addr = wrap_address(env, addr);
-        a[i] = cpu_ldq_mmu(env, addr, oi, ra);
+        a[i] = cpu_ldq_mmu(env, wrap_address(env, addr), oi, ra);
     }
 }
 
@@ -159,8 +156,7 @@ static void sha512_read_mbl_be64(CPUS390XState *env, const int mmu_idx,
     const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
 
     for (int i = 0; i < 16; i++, addr += 1) {
-        addr = wrap_address(env, addr);
-        a[i] = cpu_ldb_mmu(env, addr, oi, ra);
+        a[i] = cpu_ldb_mmu(env, wrap_address(env, addr), oi, ra);
     }
 }
 
-- 
2.43.0

