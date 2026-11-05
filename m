Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893036;
	b=ZxP2go/ACzQXFgfC1ey8Thb7pX39XLA/NdkJo9sPyvpZ+FDx+Mvkx6h5Y9VDZOLrvTpp
	 gO8sKM0btwfP0YGWQ1egOkD5Y9fPfby4bIHGOR/q9/mYmiofxIuH/vzdn6x3qWYu9ndAF
	 qpdL5MVmX5CcqIrmAxTKpEIL1FSv+XRUi0eFnW089p0cmTvkfwa/3awLLgvGESnFsKmv2
	 8+sfl2LIYXukwMbfHnUUDdPhVffu0YqOF8XNIYnJAq0OC/d+LDf0uhcZVlp5hqm8ucXwW
	 ZgS7Esh21TOr05UhgtRfakk7VRf+OzYW4v0wu94l5nncz83LEDmp3mP9ydPLcHfkgUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893036;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=8qFH0EK8s9pg6jf30Hc/6Bihr00EHsOXOfxiyQj0+P8=;
	b=Q+///DTzB9o2T09NbbQUXZxNoomLOsFG5XNCvrFOW+DVu9nALgPET1r11s9IEptTpknj
	 8W+/rGRd7Hg2jaHfF0A1vWTPOpu4rRelL2lI8GECsNWi0oFSqWCcoQQ2AzTKoz0/ggLN8
	 cAKVMqAX2tGGGt9olmsgOZoA/A/KSJ79r77n8f7NSs4oyVzmvKmDojKvAgI1y65dUPmmY
	 vOMGUTbwmirkkRwMXlG5HoCsG8DazQjgTd89BfA/EKZRX2gUznihk4Uipe7IycYjyWR4O
	 osnBhh3oH3Kq53QF/Zl6Xu5V9Yi8hams9wBfY/EH1GI49QrCCxtcG/rIzUUFdXK6olg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=azchQ3Bw;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41E7606A31B;
	Thu,  5 Nov 2026 15:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B41E7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=azchQ3Bw
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EiFsk3799678;
	Thu, 5 Nov 2026 15:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8qFH0EK8s9pg6jf30
	Hc/6Bihr00EHsOXOfxiyQj0+P8=; b=azchQ3BwZUJyAry9qlPGi95LbvReJTj1I
	VuyqPMF3N+XdfDl6OgWl8lyz9Z5PmYSSBeqyj6Ein+90WH6GzJ2Vfi/wIqR8c4wf
	JztwIvlbEy2X6uGnS3PHd3pSap+3frQ1HzHkfEWPIX4wEE4udxGU0TuevTOpUeRj
	6+dfqiKTYbsn0THHYv4g47OilfdgL1f955QhM9AxwJDfrv8JOIgnJCYFBY1xHcTw
	ADGxPN8p70cswZm88HorQaR9oEZkFTB1j0WCjIGmRuBXxgQn9O1m1/r9joVi1I/t
	7qfKcAFE1C4R9+yn0O+XFgTO+0mmP25/PU7N5jKoCLvxsqFTDvEIQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7ysasc2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 15:37:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EZ1cO595055;
	Thu, 5 Nov 2026 15:37:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hqsf5hdnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 15:37:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A5Fb60416646574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Nov 2026 15:37:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8244520040;
	Thu,  5 Nov 2026 15:37:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FEE52004B;
	Thu,  5 Nov 2026 15:37:06 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.68.31.243])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Nov 2026 15:37:06 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v6 3/5] KVM: s390: Fix idte_crste() clobber and table type
Date: Thu,  5 Nov 2026 16:37:03 +0100
Message-ID: <20261105153705.208516-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105153705.208516-1-imbrenda@linux.ibm.com>
References: <20261105153705.208516-1-imbrenda@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Mcr5KJ/f c=1 sm=1 tr=0 ts=6aeca2a9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=B6i_w3R9oO7yGhDFKykA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA2MCBTYWx0ZWRfX4YVjboOybX3r
 5Fc9lKgucdQX4kOHkjq4YQymhfw1DPlWrLNrGYbSpiP/XOFBjLpc79LsbE83zTobXiI/NHnyf/K
 mLaGIH6/D2pxMe8o6I1OOdj5OyLYI/A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA2MCBTYWx0ZWRfX5DKry1YEnmGv
 ksyU+D97FRdIQhi2XGNxIhj87e0/a55vEqpxNbdYXtx9W9PW1eGoD3sHniV5687d/pRE2ohpAWA
 DzJvkURCRE4OQuv25BFxGSZx3b6oslvWPs6f1IWrG9V29NgRQNFXks4A5n2h0d2bKPQIcNU+pZ8
 f1kn8qq7PWIFsXNOJsJTORAp9Ik1H1MCIYMZ0Dj16PNpHU9idJrLRffYrE4Q34Ht4O9oQkVJLle
 I56dJoVwdkuUe8C/+wCiseV6LVdfISf+UpbuHlleK6DN5ShsyxFP2/ef3Fwgo22whcyPH94404e
 j78kZbAADUebqybuL8NLGAzpyiI4JXxO5Us8ksznfrNwYXtTH3xfrYjsnXSRBXtVe7jxWm1WIc1
 ZCM8LePBjBPd7xWv9eVpR7U3XSdKXv/mkVzWzE/UYxuYla1GcYchXMKVqQuypC7uD47ftY28JRw
 Nm30cyfItxjGUdfLYkw==
X-Proofpoint-GUID: PuFvmJ_xgdBIZ1wX5bZUucDmwEkT7Fvo
X-Proofpoint-ORIG-GUID: PuFvmJ_xgdBIZ1wX5bZUucDmwEkT7Fvo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050060

Fix idte_crste() to add the missing table-type bits and the missing
"memory" clobber.

Fixes: 5a74e3d93417 ("KVM: s390: KVM-specific bitfields and helper functions")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: stable@vger.kernel.org # 7.0+
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/gmap/dat.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/gmap/dat.h b/arch/s390/kvm/gmap/dat.h
index 9cdd1f122d7a..79efc56710b7 100644
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
2.56.0

