Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793278859;
	b=vOGAGJ8Pl8H1vaQg3oZLcmZEC/DoiabGLHYEVs5y341M8PdnkHnvCsRdGe68a10RAK5y
	 0xjLYzHv7BJQWnBikQezD5UbEStFnh6HbF6pVy2tvcu27YS3UYBpg4UmS8gUSz/PMFVeN
	 3UrklzBHsJLvxqREgjzDQ9iZPwS/1k28IaaxEVFM+RIQXNG7YPDsPRBOwRprWf0lO5+pX
	 Vsy0cPIqEOgmcKJYXcnV5jQS2lHkuHKpxJncQPVu3aqvXSiMSRWjf5XZ4SNkR7ufBCNvW
	 i3vcMm4YvWSvk1S+9tXHH09MFR+E8GWbgFIoYkUNOY+hKBsIy3tRBccslqXdCV0NsTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278859;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=NS1j9lVogng+5ldDAIMdZiwng3ol+ONe8hkzIucuqmU=;
	b=z/kvTq154H3KGELuTKxY9F+0wz/xsKOqY0LvLV2vlRBB1PnVrt4wtCwc8EQZkfC0HSkx
	 fYZO+itCDUorUTzhkuis9cVZE8hP21FSwVFRg578aCYD5K1If5CZ1a3x4dHTiU1lpesup
	 AY+qowzV+JnxMo0+me5c7TtULtK1X5aYASkX/FkmOWsHUpPIisk4y+ClQLdYLSdu+QsQ6
	 dWXxXWamBoBS5yudgLbotJVDB3rhMgic/rbme/yTxxyDTsS9AAgwF0r1ddbezFX/81Pt3
	 K+K7elP7CWkFKn7jSriY5tfgxXIhMG7SMP6YIPho384c3yeO21awCIq/qriGAeLy8yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PrcW5UuL;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6633606A31C;
	Thu, 29 Oct 2026 13:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6633606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PrcW5UuL
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCi8kQ212109;
	Thu, 29 Oct 2026 13:00:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NS1j9lVogng+5ldDA
	IMdZiwng3ol+ONe8hkzIucuqmU=; b=PrcW5UuLQfphpR7UmrDBH9qvNlV5IOMF/
	oPxpvFzZ/OxIRrRMWWXW09GegJ5iAs1EijaUKCrRmB5bT67KuLyEpFfAHzc2QKYO
	5raQ6jVfmYF7IV1fRy9HcAU+aYgCnSEidt+rY1P1GLnUZrKHh/Crzk1VZM/OY374
	rOfmkipvKmEsZtaeOCR0BHGOA4SqBHZvhao6chfNlLKbFKVjlg/rp4cuZZMUdtL/
	QzB72ztG3FScB8I7Qbr3dqdao1oQUq/Y3tsLaVjK03mEXDHsM9qXEVVrLFmyoMBD
	0RbCLY0FtAUcOsjTgvj/CZpZs+v+q3vsHcmpURE77nXWNsdz/ik1Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgm64a9rn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 13:00:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCntZZ3084962;
	Thu, 29 Oct 2026 13:00:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hjtnnhp3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 13:00:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69TD0j6Y51904890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Oct 2026 13:00:45 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F77D2004F;
	Thu, 29 Oct 2026 13:00:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FA7A2004B;
	Thu, 29 Oct 2026 13:00:45 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.68.31.243])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Oct 2026 13:00:45 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v5 3/7] KVM: s390: Fix idte_crste() clobber and table type
Date: Thu, 29 Oct 2026 14:00:40 +0100
Message-ID: <20261029130044.125032-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029130044.125032-1-imbrenda@linux.ibm.com>
References: <20261029130044.125032-1-imbrenda@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Uu32pOwB c=1 sm=1 tr=0 ts=6ae34384 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=B6i_w3R9oO7yGhDFKykA:9
X-Proofpoint-ORIG-GUID: ctdgM8m9YRDj88wgevz-KNRB8wJx24SY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0OSBTYWx0ZWRfX4hGnV3vyJ8rA
 F/Q4VXcwV55V2vscJP4BnSdMB9nRtMDTR9mWWJtzuYruva92/+9sLk8uqtXArRUFxYHfaqqO4kj
 +lZxBkLAcH8OvPWN/7nel13e4ht/ZWc=
X-Proofpoint-GUID: ctdgM8m9YRDj88wgevz-KNRB8wJx24SY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0OSBTYWx0ZWRfX45AeqSCbXiBr
 MWmYAwu1Kf61mfu5KJZ12F9CYsy8dPfWJcCF/Ko3nmp9XyUILaNcMu2mq15LeNswxfVz6zaDEet
 YeeAyDc76oa3rYsdvinBNuu7bT4xmV3S/0E4ApadTZKhFFxYP4ZL+XkumQqOR+bcBlGTLWg7XRa
 lGJ0Ngnz31c8QoL9u5VCHf/l/DVPFHxPXw6VYO81+aP+P4My33ruO8VHjoiTPT/D/B3WQ6PqaFB
 Vgmyk3kkiBu5qFrfTC6F2TbU2rJ7wUQ3eblXl2i+xhgpPLyG/qgvDqFjZiTvXuWEu/YwcspoDsd
 mH+CjT4uMN1M99jcOfAQCMqK74faKikN+xIh059DDTBrxT/zcSttoOMU48UlU8lpiyLly9/NeSM
 hrje6p2gxapZsoN2NxgGRgOeJmOGbg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 phishscore=0
 adultscore=0 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290049

Fix idte_crste() to add the missing table-type bits and the missing
"memory" clobber.

Fixes: 5a74e3d93417 ("KVM: s390: KVM-specific bitfields and helper functions")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: stable@vger.kernel.org # 7.0+
---
 arch/s390/kvm/gmap/dat.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/gmap/dat.h b/arch/s390/kvm/gmap/dat.h
index 687e1fa904d6..fb7e839a355f 100644
--- a/arch/s390/kvm/gmap/dat.h
+++ b/arch/s390/kvm/gmap/dat.h
@@ -640,20 +640,22 @@ static __always_inline void idte_crste(union crste *crstep, gfn_t gfn, unsigned
 	unsigned long table_origin = __pa(crste_table_start(crstep));
 	unsigned long gaddr = gfn_to_gpa(gfn) & HPAGE_MASK;
 
+	table_origin |= crstep->val & _REGION_ENTRY_TYPE_MASK;
+
 	if (__builtin_constant_p(opt) && opt == 0) {
 		/* flush without guest asce */
 		asm volatile("idte	%[table_origin],0,%[gaddr],%[local]"
 			: "+m" (*crstep)
 			: [table_origin] "a" (table_origin), [gaddr] "a" (gaddr),
 			  [local] "i" (local)
-			: "cc");
+			: "cc", "memory");
 	} else {
 		/* flush with guest asce */
 		asm volatile("idte %[table_origin],%[asce],%[gaddr_opt],%[local]"
 			: "+m" (*crstep)
 			: [table_origin] "a" (table_origin), [gaddr_opt] "a" (gaddr | opt),
 			  [asce] "a" (asce.val), [local] "i" (local)
-			: "cc");
+			: "cc", "memory");
 	}
 }
 
-- 
2.56.0

