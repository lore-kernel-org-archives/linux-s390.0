Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795084398;
	b=f8v+a5UADeip58pl8NM4hi8Tu+2v36oO7sSuWpsBWxMVUqVTOqo84Xc411LGhXvhRwxu
	 ja6lUHmzJqiDRJ435zey/hNOmmBhr2BlgY6HA9HMTXw+ihjAMeXmkD7HUIxWRUVgjUEmp
	 XfCE7cxBwsm1U7yiW36pxcBmji/4yMHfNVL/c2BiQkHYSUl+xtTMEAr1ufxcPniE/vqu9
	 jp1TAHv1Y2NTVIZGF2m79N0Cnnfi6334AClUrT8fCTkDWyaJWxV2HfX3otwsdiiNi0RGE
	 E/XhF+xXOmqmszkVW6VG4Z+mCWzAvf5M6P/0Y8/3Pi6+E0k4oF/Ty6rzVoXtFh6m2yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795084398;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=EXPWBY+uefC1JguAGA5YUej7z0ZQdkAe6wYZ2IOJICs=;
	b=XpwxosrFQ43Q0R+5G9bRUoHApy16H1+hRgcDuuUto8AvCgiCzhmuvW2j8BUCGgF1mwVy
	 R3GxmonSy9EPuBi4xIEoEbUPk25KuSOQlWjBiTwNJljRUXEd/Fkss3DDknGJBTzuVA8dx
	 b+87veItS2ynEofiSQmuhrixrv0X1kJDjlshtvnSiCeOmF14n7GAVsqnTCYzY5nleDgwF
	 obzPP5OTSe7npaS4St+l8x8VMZ25sGWRsZHmzoMuiSpTrrae+pKvnjZy80H9VMK71oVKt
	 8D/eTXdtwkD8vv8z/XsOG3AwE8dmdz+qrcuAlxDxXKD5w+Hhj/xkAIEIpA6UIIEHXYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mIC+Fk5B;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3BB606A326;
	Thu, 19 Nov 2026 10:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D3BB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mIC+Fk5B
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ6uX6s2236074;
	Thu, 19 Nov 2026 10:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EXPWBY+uefC1JguAG
	A5YUej7z0ZQdkAe6wYZ2IOJICs=; b=mIC+Fk5BC1Gdnhzsa/eycE+qw8LxqjoTi
	LBxImMHD4JLbhm4JobDcWGlXKeb3o9O0QR5qEyvenIa0lJqitW9OT6xXYks/ii4S
	J3cGjfNVwSSkKMxaHL2XYX75PwXlmyX3N0zNdRdC4UmnUxj1ItW/M5WxhC9zHo3/
	46Bp9X1YFfVZv1/JEjFwD4jKOUFLnWaALveAf9O4K9W5dljPrbw/wHKBA4k5Nv6X
	AlQam069Yug6LOz0S8fGvbJchduvU7Q4Nm/thNSSlk4spwOMSAElSRovY9W3PSwG
	4DuNokERCmOHsnqroVhnmBHyjcjp9gawBAYd3ykSySmeSDWa3TNMw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105w01yk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 10:33:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJAEvi6472257;
	Thu, 19 Nov 2026 10:33:13 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1hd6uqh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 10:33:13 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJAXCgj31064822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 10:33:12 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1396358064;
	Thu, 19 Nov 2026 10:33:12 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E076E58063;
	Thu, 19 Nov 2026 10:33:09 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Nov 2026 10:33:09 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Steffen Eiden <seiden@linux.ibm.com>, Marc Zyngier <maz@kernel.org>
Subject: [GIT PULL 4/6] KVM: s390: Fix idte_crste() clobber and table type
Date: Thu, 19 Nov 2026 11:32:57 +0100
Message-ID: <20261119103259.7523-5-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119103259.7523-1-borntraeger@linux.ibm.com>
References: <20261119103259.7523-1-borntraeger@linux.ibm.com>
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
X-Proofpoint-GUID: 08hNUDHpDEO2_CJdVJEg0cDmkg4TWVoO
X-Authority-Analysis: v=2.4 cv=Z8x5j3RA c=1 sm=1 tr=0 ts=6afed069 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=B6i_w3R9oO7yGhDFKykA:9
X-Proofpoint-ORIG-GUID: 08hNUDHpDEO2_CJdVJEg0cDmkg4TWVoO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0MSBTYWx0ZWRfX2eaw4ZW6HMVZ
 3+n84Jivwf0k8VOTBVEw7D8gxLFoPsZM/VytfjULEWWev240902oPLV0zXA5wS9+g047HiVsHDc
 eXL/M3wCRb/Z58JZvB6K5WvG3BCeCQ0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0MSBTYWx0ZWRfXxCtoNU7Ynyyw
 ouBBno99apyAJTiKBrlWpXIINv9qDDazZn4K7xvs9xRGBl5HVE2U3Vk5iV7smcK4eZr8YQhSax1
 UMT1JtnqYJ5lolpH/3b50VYypiQehLX6ofYQltedkS45NEEDDAcA3yULW8Av2lSNBHbh5+JaRpu
 OV0uoHKP/ElU17FA+G4XKxo5wg4ovqW7JRTpmFP3TPfGt400PLATV1McExKUpVNN/SKTmc4qqOj
 LtCJohzjeBKe9gtvQP/BnqDWainOfdaoxrXWNg+EjsTN8XqEqCKdSQbY0QEVJkJMLUau854Gnjt
 veKG6fH1vQb0N9Vqw8dHh6zqCe32ayvHhRNGnTiInf2GxCJ0Ol1PLPirj5Q5iRoVSNsH+JnTr6w
 zvWXEJpGZMcKx8UgcOvAjZbCiBDVUPLlVpXJyq+kaZ37LIc6pZwVyNZj5b3G3WIS6JEKZbqL4B4
 Kul6Se66pnvyFPRrmRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190041

From: Claudio Imbrenda <imbrenda@linux.ibm.com>

Fix idte_crste() to add the missing table-type bits and the missing
"memory" clobber.

Fixes: 5a74e3d93417 ("KVM: s390: KVM-specific bitfields and helper functions")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: stable@vger.kernel.org # 7.0+
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/gmap/dat.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/gmap/dat.h b/arch/s390/kvm/gmap/dat.h
index 9cdd1f122d7ae..79efc56710b78 100644
--- a/arch/s390/kvm/gmap/dat.h
+++ b/arch/s390/kvm/gmap/dat.h
@@ -646,20 +646,22 @@ static __always_inline void idte_crste(union crste *crstep, gfn_t gfn, unsigned
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
2.53.0

