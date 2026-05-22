Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61631386C10;
	Fri, 22 May 2026 12:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453003; cv=none; b=AN1s3b6AUffWDWlU4+QFnDj6MqIjHbmgMUmi1LBgzunnxKfvXmGD6ezQpxgy+1KnHJrqT/hoQW8onnDDj/iVbdpSj+W+KzEMOG00dIas2PioYW9/Yi30DNisjobC5CCGCsyETnbstbt8Y5gCxAKIQ0PCKEfVP4VJA100dxEidlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453003; c=relaxed/simple;
	bh=i2w+JN8iElcVXJOlc/TBvAUVKvjZzqVBbbi3DJUGrOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XLB3TXfVjK93EgDYhVLWtau8n3VDtV1ViaCDQqf86M1e1pcnU1hvdts4q7G3cg8eWHyVHZk2SlxcmBQ/Gw8g5Sx5kuC1OSu9zlNzDzP6w5Ih7i8rSfGF3nw7QfDYGV3WzeTZgHBgFhhw71jw31jUTJd5UmSt5zp4p3A3Xl/NF0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y93C/5ko; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y93C/5ko"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M53WKd3214577;
	Fri, 22 May 2026 12:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xL0B9GixA1Hwyohyh
	mHg4WsDiB/9EErMDy3rzndFXuw=; b=Y93C/5koIhOGInWex9fytvrgFiLqMx2cx
	J6FOtifQtfuOQVRWMpm6toKgaQOc/OVm85A0BHeTqEVTnZkaYoIg9B9BYgZ9C4Dm
	tlNmSdYGvjr5zKzhUf3aAD6KSYnwKWHRD7LRU5xcH6pnQGtmQxToVZNA2/AS+eQd
	/EhDUs5aslIpxo4pDttq0quJ/AB08Qy7l+HGKiC0rKIgeuAjoxXU7awwgytz5CwZ
	MXDfAX1sBlPbK3sc0Vb8Pd2Lqmdxv6L5/5CndCj/2zh96ZNboHtF9rUczSTpQrT/
	WKyasT0L8RzKAukkGhKmDzDbRPiegp+ILUgwr9lTtjrmY1RvSfumQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hawjg0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 12:29:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64MCOKUX001527;
	Fri, 22 May 2026 12:29:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wkgtxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 12:29:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64MCTqH851315172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 12:29:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9E0520040;
	Fri, 22 May 2026 12:29:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA6742004B;
	Fri, 22 May 2026 12:29:52 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 12:29:52 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 4/5] KVM: s390: vsie: Fix redundant rmap entries
Date: Fri, 22 May 2026 14:29:50 +0200
Message-ID: <20260522122951.117120-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522122951.117120-1-imbrenda@linux.ibm.com>
References: <20260522122951.117120-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEyMSBTYWx0ZWRfX5ANqX3hHpnBl
 C6sRkUjjy3H28CiVKTH3KXaVlBbkcVvooYMw3gjGwr7yYNRy3oYhRrge6gneiCZGxiNuFK9PsBT
 1snRvo6KWJ8VFzA2XPop/QB6trklZZxSfgbmKXhozhYwhweu07oMeDLHizzOm8ATUHUExpXqx96
 rGR1Jg0qgRBbAZswvWKrKNJbLFV+IXl52z4eiC/qLnakqTRvQc/M57P/bkTnGoavYOrYkj7wbSx
 3tOmtJni4JCqqHFJ2rOB4BDb3Xq0ChU8giAbswnsRWKDzPgWN9leDOhMHqtmTU3Ds8b3SZqWwap
 28mjrY8VFP9hzLSIzCLv+eSInP7iqDZwSfyAdAnsaXow7GJQz3Mcn6D56bBaKL1W/EYZDdOzKqz
 /d252nvkyWxBw8Ve5EjxygunzAwX8PcpARn6uruGy1Pmm/ADz8qJh7tlbZamz7DUU3VyNqH5DmS
 OsHp/dmlkqv9MH0UivA==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a104c47 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=7eV5o87doowNvqF6OWkA:9
X-Proofpoint-ORIG-GUID: aYrpWU1yJhbCJoi3TZLBjX0S8ptx4PCA
X-Proofpoint-GUID: aYrpWU1yJhbCJoi3TZLBjX0S8ptx4PCA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220121

The address passed to the gmap rmap was not being masked. As a
consequence several different (but functionally equivalent) rmap
entries were being created for each shadowed table.

Fix this by properly masking the address depending on the table level.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/gmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 8cff0cf5ce24..957126ab991c 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -1025,6 +1025,7 @@ int gmap_insert_rmap(struct gmap *sg, gfn_t p_gfn, gfn_t r_gfn, int level)
 int gmap_protect_rmap(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gfn_t p_gfn, gfn_t r_gfn,
 		      kvm_pfn_t pfn, int level, bool wr)
 {
+	unsigned long bitmask;
 	union crste *crstep;
 	union pgste pgste;
 	union pte *ptep;
@@ -1041,8 +1042,9 @@ int gmap_protect_rmap(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gfn_t p_gf
 	if (rc)
 		return rc;
 	if (level <= TABLE_TYPE_REGION1) {
+		bitmask = -1UL << (8 + 11 * level);
 		scoped_guard(spinlock, &sg->host_to_rmap_lock)
-			rc = gmap_insert_rmap(sg, p_gfn, r_gfn, level);
+			rc = gmap_insert_rmap(sg, p_gfn, r_gfn & bitmask, level);
 	}
 	if (rc)
 		return rc;
-- 
2.54.0

