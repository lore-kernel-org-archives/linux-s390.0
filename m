Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B84042AFB2;
	Wed, 12 Aug 2026 10:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786531490; cv=none; b=OUQGf8XcCn3wL8wbAMPyKnYJW4p5nHDCTRW5qljSSnhbOWT5fIq6eRy+OwPkshyNoZTozkwDW0exoplGkOchKNb7BSEW9WMinh/kj1w7bHhDg4+KYWM9H3I3KhrmsjUkCTslvWgofeTVfeVFFphhcISBd/6c2twvpKQ5MiYLdJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786531490; c=relaxed/simple;
	bh=EnWUl9RMOsQwOEcTFoQExitZSRGSGbnZKHrln6vePUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etQUxFpfUXZj+j2xoNgn2bd1YzS/26HmtnopJH6b6VcgqI9YVUpyxnLS49QCZ0BhF+inPYHAYNE83QqmUui7K3+SacTYLdgzgoyvzO7luruR1g2egX7maCka+E+rkVrxiZ8psSFoZEZq6mt48KMvF+sUurQn8APIpUvhb+yvxWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j241I2Nq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j241I2Nq"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CA1b3R3086502;
	Wed, 12 Aug 2026 10:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZyomH9e02+wc24Id2
	Rq1y7qJrzevhou1WWekxroTvP8=; b=j241I2NqrpcP4m5U0oKMD13Zi9z9268cz
	4ccFQqS/v4lbprbcXQcOAmQ8QQt64Qmcs376IN6s8qOLt3J36k0zsEGJEU2yIicR
	jINCp5rjGN/dRNOw+yhoBIwJUK8YZ/9PJOAAjzf7fIV/UkCBbGAzJInY80RyY2FJ
	GTaomX+xobbYnb136AWlBUOZR3BZ3RZ8JonLtclGZoo51yhLQg0eEv0Lnuyvb/p3
	Fg5d2z3lPNLqE+ABuPBm9uNgs1Aq+08QofGoHIT0IqnuPoP9swDWXwBzQ7UlKIHs
	YuBF6G1cM4vH1paKhdSm4pO03uD4an3eB6kapgImv+f8p+Tn1xBLA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp317jw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 10:44:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CAfGLd020958;
	Wed, 12 Aug 2026 10:44:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq5se7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 10:44:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CAicCN47448564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 10:44:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C2AA2004D;
	Wed, 12 Aug 2026 10:44:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FD4020043;
	Wed, 12 Aug 2026 10:44:38 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 10:44:38 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 8/9] KVM: s390: Fix potential tiny kernel stack leak
Date: Wed, 12 Aug 2026 12:44:35 +0200
Message-ID: <20260812104436.109741-9-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812104436.109741-1-imbrenda@linux.ibm.com>
References: <20260812104436.109741-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7c4e9c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=geH3wxNwSTHpAUJZdnsA:9
X-Proofpoint-GUID: zKtHnT7cuHxN1Cfbn7xW3zQiN1SdrAyn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4NCBTYWx0ZWRfX+J6W8J4JGWcA
 qg14DnlIzCmCyk6zMaX7F90n7lqwRrDq5jlbCQ+p+O4sRb0EP8hGLe69w4POFWi23wSoqo5B8x7
 VGaqP7cbSYYbbLke+sgeJ5vvWj5rtu8hauYUhFI72CSmXW3z9oDrmZM7n+Z0LaSVqPmjylE5ekY
 yzskKDhu+yz5ybG+/afFdMZeeN/kK/Tnx2ck0whiENNWL7WyRaYhdd7VYzUg7qDS0kfV9UhBCYL
 2e3TCUJHj81Bqik0paX0701x60RZ2ELIhxh/7/a727J+W2Cm7ylAKf+Hbo36s1sLnDJSluonSg7
 fHEH2YnHzO7f9FO8SPPnnUxVyw4nP6vOhvOUawI8hzxeb8+wh/MzFAmlYpoVmKBLexX3ktxycA5
 NcYang1rz0Mzh7sPMN8WGfxT8yH1sIMf6HzFwjxtm4Ui/kvKz2alFW5IWWcsIKrODUWgFrlpx3E
 e6YwZ53KX3LQmirZoRA==
X-Proofpoint-ORIG-GUID: zKtHnT7cuHxN1Cfbn7xW3zQiN1SdrAyn
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4NCBTYWx0ZWRfX/jEABY1L4PMo
 hEn5hRKwXyfxBkPMw9w4aHSRvFTtQItTW7ZCUHvP7ZxVhqRAX6pwQmEoZCZ1b0ahJ0svFcuU0vt
 Yak+W+rr8k2jCCnFYo82VvwKR72CEYQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120084

In some circumstances, one bit of kernel stack could have been leaked
from dat_cond_set_storage_key().

Fix by clearing prev before use.

Fixes: 8e03e8316eb2 ("KVM: s390: KVM page table management functions: storage keys")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/dat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index f4dd6f783417..f2ea013cb33e 100644
--- a/arch/s390/kvm/dat.c
+++ b/arch/s390/kvm/dat.c
@@ -737,6 +737,7 @@ int dat_cond_set_storage_key(struct kvm_s390_mmu_cache *mmc, union asce asce, gf
 	pgste.fp = skey.fp;
 	pgste.gc = skey.c;
 	pgste.gr = skey.r;
+	prev.skey = 0;
 
 	if (!ptep->h.i) {
 		rc = page_cond_set_storage_key(pte_origin(*ptep), skey, &prev, nq, mr, mc);
-- 
2.55.0

