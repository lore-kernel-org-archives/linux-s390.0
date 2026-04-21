Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7358B2C11EF;
	Tue, 21 Apr 2026 11:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776771947; cv=none; b=F4xcHO2Xw2twEsuQhYfbGL1GKxRnGY+2STMYzD5227MAnDM3vut1IVzBxUI+TEh7tLfWTuIcdFyRjZCzVC+c5hP35eLi9jyyzotvImG7TKy9Yz6qk/risLWfh9HKnMgEwPHwmBN3wMwRe3I2fVMHH6J40imtmNKNGB6SFESycns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776771947; c=relaxed/simple;
	bh=qkWhJvM2KfaD2CTFFEMvXKFfbm4En97C1tiACn+3Pdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=glcq+sbdMDZ45kplM62cNAGspUGWg7NY4kThWcL+BDzVV2TiU9oqROThzvxj4m0Twy7ZG26RhiVFOEUAPpXUgYwUbyhTjwFM45oq0Lnja1KNHQYcv3d5li9W0MVUPtYPLIUCpNZkBIOYGrjklkqw54yGtS4Z35A0ROLXDZvgXBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aAo4aWnY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aAo4aWnY"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63KJhq4m1687183;
	Tue, 21 Apr 2026 11:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kh+0oe
	ceshKmn0rO0bKSNpT51u4W1l9P4nryzdCM6Dk=; b=aAo4aWnYeNdEDfMFworPUL
	BRbw8fzE8GLcvtsMYZb4T3HWAlEvqi+LaXkD5D9FGoW3RyI1B75WSg8yMEW8mvfz
	qlopHV9PwZjy/5fzC1vPixrk2eJgdFrMNv1l3cPSkYKW9LLUc1cWn5f/cZ7jEBPY
	HlMg2PNX9NXYnlW6g76F/Ce1WOVRGryJzK7fVlttm0EwwJJv0TCnKTC77f3PrQ4D
	oNzQWpPOCKwT64qMq/HGriekr+WrfTqlF/o/Xq74/iQXVG1ZuR15Y/gNcu/3E0bw
	oNzq39hmD+q+w+qraQvF6zQ04aU9r5IRKW45BbNviIkyOIaKwT4ObwdDoXKG622w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2j6m25s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 11:45:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LBZTrP021624;
	Tue, 21 Apr 2026 11:45:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmmnvrmqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 11:45:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LBjbc351249632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 11:45:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CC2B20040;
	Tue, 21 Apr 2026 11:45:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E05A62004D;
	Tue, 21 Apr 2026 11:45:36 +0000 (GMT)
Received: from [9.52.198.32] (unknown [9.52.198.32])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 11:45:36 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Tue, 21 Apr 2026 13:31:07 +0200
Subject: [kvm-unit-tests PATCH v3 1/6] s390x: snippets: Add reset_guest()
 to lib
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-vsie-stfle-fac-v3-1-3cee84efefa3@linux.ibm.com>
References: <20260421-vsie-stfle-fac-v3-0-3cee84efefa3@linux.ibm.com>
In-Reply-To: <20260421-vsie-stfle-fac-v3-0-3cee84efefa3@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        =?utf-8?q?Nico_B=C3=B6hr?= <nrb@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
        kvm@vger.kernel.org, Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2014;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=RH8dfsfCZRN4Cf6V8h4S8Wlq8Oewg0791ynba/ejYPc=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJnPkxM+FLoVJ8otqb39vCZtv0uDwMMrvCdE/ZMdL6vO4
 t3cr7qso5SFQYyLQVZMkaVa3Dqvqq916ZyDltdg5rAygQxh4OIUgImYz2T4X6UXnXDm13mzNzFf
 J03jXT2R4cfdZvlZ2hulTvL83aTcYcLIsNti3qEjZhz/u6cZsd3yyrxvZ3q9zWHxin31dh87gnn
 3cAMA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDExMiBTYWx0ZWRfX0XJDERMReXPm
 1kEOjlvb3jaSZ2Jpn3mS4/rHILbNH8SWxHptDAks9wS0127w/9qzq6bZu5lL2wOx2QcEs6MnaSQ
 eK8YGwaekj8JHwujl/EIgf++2OJEYaGJfvMK8U+q/ZKCh8Ql3OEAFx6pfo1oK09DltC4kFRw/T8
 PHmtx4ivy4jdULZEoqhp6I+JnOeusyteE3nyEDClSKjtNkM6L7IC+/ugO+l/f1QdGf0kBaZgJBV
 x5hkEESZd0gckDhBh53YGCj3OpxX7pyowTDxBr0oO9nPSjpJLBk0YeVbJw4H+B7dVG+8GgQxXm/
 AzhD7oHYzwAXYwJ95AGXsUZqZ/Zwrm1uDnWGsw2D39xeSQkdWMlLeEOiwaTBljZOaKXlit2rmUw
 1rInsGRdCUHZ0KqhazkkmSN/HkSYdZT2Vh5DML7/rd3LDo6tUrSalwtIWK9ANrXT51qyNl2pJH/
 G4DixZJGJbF+U/Ebz/A==
X-Proofpoint-GUID: YwP0Gr1WT74h9uGPrIOACFBuMWZNOx-N
X-Authority-Analysis: v=2.4 cv=SOJykuvH c=1 sm=1 tr=0 ts=69e76366 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=Cd5Zmu1nkpE67UhzTUQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: YwP0Gr1WT74h9uGPrIOACFBuMWZNOx-N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210112

From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

Extract reset_guest from spec_ex-sie into the lib.
After reset_guest() the snippet can be executed again.

Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
---
 lib/s390x/snippet.h |  6 ++++++
 s390x/spec_ex-sie.c | 10 ++--------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/s390x/snippet.h b/lib/s390x/snippet.h
index 910849aa186c..6f611de510d8 100644
--- a/lib/s390x/snippet.h
+++ b/lib/s390x/snippet.h
@@ -83,6 +83,12 @@ static inline void snippet_init(struct vm *vm, const char *gbin,
 	vm->sblk->ictl = ICTL_OPEREXC | ICTL_PINT;
 }
 
+static inline void reset_guest(struct vm *vm)
+{
+	vm->sblk->gpsw = snippet_psw;
+	vm->sblk->icptcode = 0;
+}
+
 /*
  * Sets up a snippet UV/PV guest on top of an existing and initialized
  * SIE vm struct.
diff --git a/s390x/spec_ex-sie.c b/s390x/spec_ex-sie.c
index fe2f23ee3d84..75625ecffc4a 100644
--- a/s390x/spec_ex-sie.c
+++ b/s390x/spec_ex-sie.c
@@ -31,12 +31,6 @@ static void setup_guest(void)
 		     SNIPPET_LEN(c, spec_ex), SNIPPET_UNPACK_OFF);
 }
 
-static void reset_guest(void)
-{
-	vm.sblk->gpsw = snippet_psw;
-	vm.sblk->icptcode = 0;
-}
-
 static void test_spec_ex_sie(void)
 {
 	const char *msg;
@@ -45,7 +39,7 @@ static void test_spec_ex_sie(void)
 
 	report_prefix_push("SIE spec ex interpretation");
 	report_prefix_push("off");
-	reset_guest();
+	reset_guest(&vm);
 	sie(&vm);
 	/* interpretation off -> initial exception must cause interception */
 	report(vm.sblk->icptcode == ICPT_PROGI
@@ -56,7 +50,7 @@ static void test_spec_ex_sie(void)
 
 	report_prefix_push("on");
 	vm.sblk->ecb |= ECB_SPECI;
-	reset_guest();
+	reset_guest(&vm);
 	sie(&vm);
 	/* interpretation on -> configuration dependent if initial exception causes
 	 * interception, but invalid new program PSW must

-- 
2.53.0

