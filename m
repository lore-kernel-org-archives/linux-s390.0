Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816AE43BDD6;
	Mon, 24 Aug 2026 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582306; cv=none; b=k9/z3T1mnb0Fqmvehe9zzO6oLhXOm5Js07qig2oo/VJW9F/ASfBuztc01/AbA13rAQNc4U8+Ge0rWH+zJMNNwru6xHqNMiUQqExNrWsiLk1puZUPSCmMGuX8dXMPGArlwfqiNBvqUZG21HmaGblKLdk5II+s0pKo35zov1/PVUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582306; c=relaxed/simple;
	bh=yVTwzGharsIRM0/3UOjb9ArXOPuZXnWAk7waH1wdbFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HNMok0hcfZf3h6WNNrZoJm6WwRncHDBjHbdSgXGtL3eW8RSjfmAowOcHzzqpxPd9wB8ZfUCRlg8HX1l+y5rXiwEMy3UDdbbFKgl6jkaCYluXNb4EAZXRRq5MdkjzIIii002fIBOobb/Yjo+mKbyIIfS718giofGwWS9f3OQrudQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L9CnaaT6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L9CnaaT6"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OD1YXx1935893;
	Mon, 24 Aug 2026 14:38:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UR5KoMcNjqERhFmu7
	cUazKSvmOW6HSRb2IsffIUh2zM=; b=L9CnaaT6vi9YseKSZz17iRyLBmdQEHm60
	f+VJJuCyCvJO5+CCKhYXAMYUCFMelpRrY1gl5SfI9V+Sm01c/rhF7w8YpGZFv8T4
	q4WRnvAKmb8IxPodgygGZCJQe7nf3u3OR5hYEBv8ysYNXUGscoVUEKmctkOlY3b4
	xTK1oUnlrqku66EDlQ2Klr+K8LLdK/rqoWqZgmDlkLgxsAICVSC6c9sJCmImKAKg
	S/57F9/516tm20dTvao8K6UXHiNU3/BpE6UUHsYUtRJtB0RFeQePq/wZL4nk9vKe
	LIyFGLdLQ9wxWSH5Q5s3d4q/Cy8CjuGe+lr6t7p7oegc2KDhXd/jw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7393t1pq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 14:38:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OEQJ3i030489;
	Mon, 24 Aug 2026 14:38:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkgxfg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 14:38:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OEcGC846661932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 14:38:16 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B288D2004E;
	Mon, 24 Aug 2026 14:38:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 877762004F;
	Mon, 24 Aug 2026 14:38:16 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 14:38:16 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, frankja@linux.ibm.com, borntraeger@linux.ibm.com,
        linux-s390@vger.kernel.org, imbrenda@linux.ibm.com, thuth@redhat.com,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>
Subject: [kvm-unit-tests GIT PULL 07/13] s390x: sclp: Check sclp byte before reading feature bits
Date: Mon, 24 Aug 2026 14:35:39 +0000
Message-ID: <20260824143740.291583-8-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824143740.291583-1-frankja@linux.ibm.com>
References: <20260824143740.291583-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SKLX1CmA4--kyFF9LnWzo3qjx8QahKOM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfXzw5eWu7pNeQ4
 AE0AifC55cbDNN1rIQ0ajYj7rYxoBlVmB/LHA+4GmTQGg/Eaai/QWfJskddIj36uEnXRg6NVvyH
 pATUN16giNn8WODzjC768TX4jA29+O98PWnIbSkjwTsj0Hxs0YjsDN53vSRWdF3chyInx09ACtl
 gjL0SiHKVCaKm+F8nLjvqzQP8OkHrQUOzH5e1YTNQmOKOEdCH4HwM1a6A8MQ9LOMASdFzXB1Xqq
 flBEbfiB6SgaacDzIWa/o6ExOG0g2MIfG76mLxLDyg1v8/1Kb716OSmOKW4palvxVI/E5Ojp/QL
 NfqL+Gc9Hr7ej/crCzU91ple0OFeR7qjc7WvxsWSDR9T12vhriap1V7z6gUPp3/1dBPhG1PSjWR
 0Vj1W47MjZXt50MxkKUZs7xXINs5o48Al8E+IQdXIUPdUiMIIBwMML6G0UdIfrkGh1eSaOGEa6t
 3UIzGKHmUg1FOeVV/ZA==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8c575d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=NxtpYQlKdLe-zD7elHYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX1hC8dh9qnLRH
 ymdgaaS9yPNIQzihCBIQrR/CJ7/b5UBo07ZysabkL3zMo6XOnQZ79X+ZPoNZcxt6fyudp7SupZo
 eiK6eEiTyD9l4BciHLR2Rtyc4h8G3M8=
X-Proofpoint-ORIG-GUID: SKLX1CmA4--kyFF9LnWzo3qjx8QahKOM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240122

From: Christoph Schlameuss <schlameuss@linux.ibm.com>

Improve the readability and simplicity of the code in
sclp_facilities_setup() by moving the check for availabity of feature bits
into sclp_feat_check().

Suggested-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/sclp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
index 2f902e39..1ffcf448 100644
--- a/lib/s390x/sclp.c
+++ b/lib/s390x/sclp.c
@@ -142,6 +142,9 @@ static bool sclp_feat_check(int byte, int bit)
 {
 	uint8_t *rib = (uint8_t *)read_info;
 
+	if (read_info->offset_cpu <= byte)
+		return false;
+
 	return !!(rib[byte] & (0x80 >> bit));
 }
 
-- 
2.53.0

