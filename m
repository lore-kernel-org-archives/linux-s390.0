Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7E7346A07
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 07:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789027077; cv=none; b=Gu1RgMLTUa5PUtcJQc9KGfSlqhb2BEhCz03zozkMV0RjtZsN0rZB8cq5IMeR2fYFp6IbWeq90BH9X1ZUy004o81Pn2puWm0jxrMNjLUz6ksra+ZvHKLDBOKNK2n3K+rJZKmwjkWxzS42FRRjnP4j0Fs4NFo/RqWanwiP4KKh/UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789027077; c=relaxed/simple;
	bh=YUZilcb3LtfQx5OOUPqtI+syd7Re38M3Vf29flEu5wY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m655zN+i2Mo5KQz0C9IgoHBmcluCvE+jUra+F4jfbLDzQqEpU8SgCuotDUwRu9WYzs/cx75vZjyO5xNR8GJojxiWk2FComV97y/yAJHp+wiJPaHkzGmS4v6D6I95+aJlAQM6GQxIkdZ3jKPOQX4cK+6EMHeR9uoJ4vsNfutpJ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FW0rThtZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FW0rThtZ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A5VRdl1973303
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 07:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=SnSHm2FUAbpVqirbgfo/ru8+ARblwT/1S1CaS6EHf
	X4=; b=FW0rThtZe77B2687bngRpiZ9TMmY4JjGrTJNTyEzwjqArxf9baMsQFy6g
	9Y1JkMjXTkQKaNao0PCHbkpKPzystv13nYJ7Qw+OXN6jOKo84AHyb41M+s3czBdi
	DkQEeL0WkbK7QsRvuXrkp7oCiVNPYgsZKabcOsKzwPgdUZ+4ldmXJEWgI0Z36G5a
	gFZ6kz2ZfTXz2F+Gprm60iR+UGtjo+YM5SIjW6P2KpUM3/ELcQ8c7CNz4CJsEVcX
	O1H/cJRThiIozyD8E2J1xhaLwEElTisnDRMpNAZcyzD+zb86ssHkKRJ6XSx/dMEg
	oh37UN7dCWQ9daGqXIIxt94prVbbQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8pk5n6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 07:57:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 68A7uKYv032301
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 07:57:54 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gkcr3b6w1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 07:57:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68A7voSf43254032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Sep 2026 07:57:50 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B9C82004D;
	Thu, 10 Sep 2026 07:57:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C71E20073;
	Thu, 10 Sep 2026 07:57:50 +0000 (GMT)
Received: from t35lp46.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Sep 2026 07:57:50 +0000 (GMT)
From: Euan Bourke <euan@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com
Cc: meted@linux.ibm.com, linux-s390@vger.kernel.org, euan@linux.ibm.com,
        ciunas@linux.ibm.com
Subject: [PATCH] s390/hiperdispatch: use system_dfl_wq to reschedule hd_capacity_work
Date: Thu, 10 Sep 2026 09:57:46 +0200
Message-ID: <20260910075746.1233706-1-euan@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=eM2GH3p1 c=1 sm=1 tr=0 ts=6aa26303 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=fq4Gsc4iZSFbyweIEM0A:9
X-Proofpoint-ORIG-GUID: v8rYyWwwAu5_T9ZSDAc8cKBPSnX01H6j
X-Proofpoint-GUID: v8rYyWwwAu5_T9ZSDAc8cKBPSnX01H6j
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA4MSBTYWx0ZWRfX9zifJVkSla5J
 b1EcbcQaNZBGV+h9mIwXmTaNKzuYVys2LZcBYHgp5PicWJ6YoBWaj3eOQC9yZkQdhqqcFoxjHwJ
 DMg+FMfYkm7QkAi8JxI4lgdh1AE5gsk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA4MSBTYWx0ZWRfX+Z3elaYMJyFA
 blvD9nOWvvZTH9QSQgSqmVgDl7jQhdJedZay71KtWZisESWdZwdPCU7AVcCVyYmEutuAAgkPXH0
 xR9LYpLuasTGb0c/+OAHJjoH5OJiLIbBU/v4bco1st1FrCoCAMIMDo5IW29T10kyHo/8XEl8w/X
 VuOKYLxF9BXK+K/M9o8+zZiqZ/JmC+wD32BPIYOvKtGpJNL7JgKRn8+q4VParXZQ61dUIjCNfwE
 CfJhqxOzkHg2nh0Ob2eTGD1d1iTg7dB3HquatFEzPRjgBjun65AXcz+adnbBQ+A0SGu0IuLVEOr
 5pL0TDJ+avEBquXWyCFfaLvz5ehXdIz9D06VbZPTlaIBXdHl2TTP4oO17sXts49efqYqZG2M4yw
 nX3eocx7bhUHP+Y5DQ7nJigMEVRg5BxMyXgydp039NoJ3vM533AAXENz5+YQCvaDod3FIHJnxM0
 +ekd6HxcfrAPIBrud9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100081

In hd_enable_hiperdispatch(), hd_capacity_work is scheduled on
system_dfl_wq, however the work function reschedules itself with
schedule_delayed_work(), which uses system_percpu_wq.

Hiperdispatch does not benefit from using the percpu workqueue. Use
mod_delayed_work() with system_dfl_wq for consistency.

Signed-off-by: Euan Bourke <euan@linux.ibm.com>
---
 arch/s390/kernel/hiperdispatch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/hiperdispatch.c b/arch/s390/kernel/hiperdispatch.c
index 217206522266..2b9187e47217 100644
--- a/arch/s390/kernel/hiperdispatch.c
+++ b/arch/s390/kernel/hiperdispatch.c
@@ -265,7 +265,7 @@ static void hd_capacity_work_fn(struct work_struct *work)
 	}
 	trace_s390_hd_work_fn(steal_percentage, hd_entitled_cores, hd_high_capacity_cores);
 	mutex_unlock(&smp_cpu_state_mutex);
-	schedule_delayed_work(&hd_capacity_work, HD_DELAY_INTERVAL);
+	mod_delayed_work(system_dfl_wq, &hd_capacity_work, HD_DELAY_INTERVAL);
 }
 
 static int hiperdispatch_ctl_handler(const struct ctl_table *ctl, int write,
-- 
2.54.0

