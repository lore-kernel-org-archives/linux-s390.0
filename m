Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484744;
	b=Vmtyoxz6CCxuiw3XyHZblMPbI13KEN8WhjhKMKEmuaXJAJQIyqcKDjGaGkP2go6JHzKQ
	 0TvoFHGMG/gJ5xF+RfziMGFHzw2wFSrHjyBFU5AVxTee90k8yB2Sg83CLr4V7Yrctgqvm
	 rD+4Q9Kxr6g2V7IxEcJ0poFeClEvRyxr+hVovkZtMRQ73v3i0t6ig2hpS3RMTwaK6U2J/
	 EpS4u5DD+YhyhGPxGtIEZnwztu1mD/3YH8pocf7opeNtjyK5PF9Lw01zxwoc461G7imO9
	 W2MxCM/ZJJNxSQCk1N6MtFQZK3PPuaQRg4+VVIJ6LAjRDFi7EODUONE4us+kHo8GjcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484744;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=jAJohs9jM4C9qmzSTrnzOJHD+AEB6zrnbjv7P5LD8bM=;
	b=4RoQ5NI26Qeq/y0gcZTzkfKhyHlaK3AkMAWCOKJ+nhYzmUasQ1DLGINhIUtrcwRoLd6l
	 4FbXM2+L3A5D94sA3c3Tvv5DWKLPoPVIqx7BPblJ0Eln8YVwRr/14lSobH+wjXk/QzL6J
	 L9V4cUkTIwX3h9EzAwLG8p+po0LkZf6YQKii2FagI0mVFKokyUlQCe7m5AbZOVBDS9gCL
	 FFlWWzQidLlKYKJn48x2Tr5yPbw8nSu5LH2wI7b9ou+1ZKDMMjWoq3xrm5o/wach29lZm
	 EQkNxT9eM3X7jIMMMenXMxjGL/F1KULKtKNOlvWRT0s3S9Nyr0iJVdA0YwXYtorTnnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RcjK16qB;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D36C606A319;
	Tue, 20 Oct 2026 08:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D36C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RcjK16qB
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69K1ENHR4176854;
	Tue, 20 Oct 2026 08:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=jAJohs9jM4C9qmzSTrnzOJHD+AEB6zrnbjv7P5LD8
	bM=; b=RcjK16qB/2LH7X6b83KR75wtihO0XSKdlxjmKOinFid0CZdUl5YS+gLHI
	0kEHvU0YgVC/N41k9+SwC2EpndVMRvGM0Bq1vvhSKosXhXaJaXzCL3Owsc+jzjX9
	r3ODH2IEj9BuAm1OlSzobAIVgvElwGKgL9jN/KD01xfs7JlPVzrE228CixevDe5o
	domYQXWb2NtWmU6OA/3bC+ptSH4Z0CkEFxCVgPKF32wQv+oihZjQaKTzWSzWyXc6
	435G9tCvSCyj1xSanGxXZ4jVr5y/x4Sm3Q10xd3JE6c7o+w+FZcFzn8iD+5gILG0
	ZU9fBJ7mSl0xfkwncoXq6roU39Iow==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw581p7u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 08:25:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69K6vVs5794894;
	Tue, 20 Oct 2026 08:25:40 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hcp1yh1ft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 08:25:40 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69K8Pcuk18285216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Oct 2026 08:25:38 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E55F58050;
	Tue, 20 Oct 2026 08:25:38 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2A3358054;
	Tue, 20 Oct 2026 08:25:35 +0000 (GMT)
Received: from b46lp13.lnxne.boe (unknown [9.87.84.240])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Oct 2026 08:25:35 +0000 (GMT)
From: Gautam Gala <ggala@linux.ibm.com>
To: borntraeger@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: frankja@linux.ibm.com, imbrenda@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com,
        pmorel@linux.ibm.com
Subject: [PATCH v1 1/1] KVM: s390: pqap: fix AP status written to wrong half of GR1
Date: Tue, 20 Oct 2026 10:25:34 +0200
Message-ID: <20261020082534.481867-1-ggala@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAzMiBTYWx0ZWRfX1stH9jO+DoIW
 bKahL0Z3YB6PqoqtJo0AHFS3HIl7ZNQfbke9TQu9XpNOPrSk10SxIn0zyQz/MJC/WReOrcwHENU
 ApK+fx5HLC6aUtqA8cc3ubw9fxB1O3U=
X-Proofpoint-GUID: LpeQUKuIyJmjA8GLABCRRgCQZqo51mhB
X-Proofpoint-ORIG-GUID: LpeQUKuIyJmjA8GLABCRRgCQZqo51mhB
X-Authority-Analysis: v=2.4 cv=UOBIjyfy c=1 sm=1 tr=0 ts=6ad72584 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=dCozhJJj6gtuAxkZyfYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAzMiBTYWx0ZWRfX7iQjd7pbtWcS
 Hxkr1xC/OT5W7a8iIt4huK3uTc/QxhIAXnPKlpmJbxJBR8GEFxYPSylhQw+sRoQvBMi1RUDW7SH
 TdPL+vrEcbthhuT4J+Q0IH0aQIsuu3B0OPD5chEG9zaiqAyamZAG8AmBzVUt/u3CxXgVXRCVPBE
 I+KsE3qYDuXc3rRZDFpTJvzJ6dIRuPN9Lpy3J8f4nZxZGaQjceUkqIyjG8t2UTYf5wrlPQdJ9ZL
 zeOcsAHpkAAjtEJrwsdIByV7T7T6CjpWGBgpctoOrf6LHCz/HlRZ2GppAw2YNs/MeT16lw8E1DW
 ze6JgRlcl8EwC9dfGnazghu7s0xl3UySR9YmLn2rjjX+sACLNxvv4q4jZZJAwfpy2TvJV44hEp7
 k0R7ZqTKa9CGyLtEf1XiYvve+Cg4NmoKnhO2ZM0R0NUV1oJkabSWUJsstytrsJdiGhPVYyIsXYf
 3DW5O+nTzPVXUBbFzcw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200032

The AP Queue Status Word (APQSW) occupies bit positions 32-63 of GR1,
i.e. the low 32 bits of the 64-bit register, while the upper 32 bits
are reserved.

The no-hook fallback path in handle_pqap() synthesizes an APQSW and
copies struct ap_queue_status directly into GPR1 using memcpy(). On
big-endian s390 this places the APQSW in the upper 32 bits of the
register rather than in the architecturally defined APQSW field.

Use union ap_queue_status_reg and assign its value directly to GPR1.
This places APQSW in the correct half of the register and aligns the
fallback path with the register layout used by the AP infrastructure.

Fixes: e5282de93105 ("s390: ap: kvm: add PQAP interception for AQIC")
Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
---
 arch/s390/kvm/s390/priv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/s390/priv.c b/arch/s390/kvm/s390/priv.c
index b3cb2c2c3aa7..ccb2a7830265 100644
--- a/arch/s390/kvm/s390/priv.c
+++ b/arch/s390/kvm/s390/priv.c
@@ -592,7 +592,7 @@ EXPORT_SYMBOL_FOR_MODULES(kvm_s390_is_gpa_in_memslot, "vfio_ap");
  */
 static int handle_pqap(struct kvm_vcpu *vcpu)
 {
-	struct ap_queue_status status = {};
+	union ap_queue_status_reg status = {};
 	crypto_hook pqap_hook;
 	unsigned long reg0;
 	int ret;
@@ -661,8 +661,8 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 	 * No hook means no driver to enable the SIE CRYCB and no queues.
 	 * We send this response to the guest.
 	 */
-	status.response_code = 0x01;
-	memcpy(&vcpu->run->s.regs.gprs[1], &status, sizeof(status));
+	status.status.response_code = 0x01;
+	vcpu->run->s.regs.gprs[1] = status.value;
 	kvm_s390_set_psw_cc(vcpu, 3);
 	return 0;
 }
-- 
2.56.0

