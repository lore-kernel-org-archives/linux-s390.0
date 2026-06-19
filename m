Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F96A35E931
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 10:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781864040; cv=none; b=dk3bMRlpdYDVEl3hkoAvBnSIqDJcwEF+8bamx8tB+oRUjvpLACXQV75ywyZ//SX/yZUJHjIheKrWwaktzomxURuVRAp2N+8TD7cOzRMdFnGQAyyRsGKU2krZUGtB7q1lfqPNzC3dBDXaspxpmChBuQSHMrt8kSpMAYjNj8mOcS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781864040; c=relaxed/simple;
	bh=5Jg7CTHzZb+P+jc9jFSF5WCRTFe4ttnfo/h0lM6uv00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A7XWfc3iut7pxu5n6/EesiuBDmrEcqjThfuX55lQftTFC31ghj30elCT9tW60+p/FHM36W3yRbyIuxxl86Yxi4ULkb1cZok4RmR12VjovWcC1bi7Q9Du+kbkqJ3DOSMa/xJkiFe1o8Qd0bNCVJlUvNKg/Bi7bE1BIfzhh8aAWak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oB3nmSav; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oB3nmSav"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J7mo1D1590691
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 10:13:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=kx+2nu46oa3LUsyXOs5vCT2Oj7i3YjYXjixFoq+b/
	2Y=; b=oB3nmSav9uTihwSwR6H/hQImGLqFKwm52kq4deb8cb2UefmpVqSLGVwl9
	A6f6QxCE8omw4QHVLphYBoMDWjAESmagswNHa21BjLpVuNEVxXKLiUSpk/Pc31qi
	6qv8C1QX/9AWLshqJ+plJm9oo6U4RV5Z5WvL0oLm8nLCTlm4abwH4lUIPUjhyWho
	ePHrjhnEgeMUJWhnw3QiDZnXW109ZJ7s1fSvDiJkG94YThJPD+JBTSKCYEeo6MQy
	rD+YsfKDdI4Ls02bRswuhunQ0RlpcRXiGknzucAo0neQkAUueSOe/K5AljS+4+1b
	Bkkvy1CwJmmF9m0Tr1FxepUCEql2A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxcsy3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 10:13:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JA4e8X011870
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 10:13:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev1728ajc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 10:13:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JADqXf42402120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 10:13:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D7852004F;
	Fri, 19 Jun 2026 10:13:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E38BC2006A;
	Fri, 19 Jun 2026 10:13:51 +0000 (GMT)
Received: from t35lp84.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 10:13:51 +0000 (GMT)
From: Ciunas Bennett <ciunas@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Ciunas Bennett <ciunas@linux.ibm.com>
Subject: [PATCH 0/2] Improve DIAG 9c observability 
Date: Fri, 19 Jun 2026 12:13:47 +0200
Message-ID: <20260619101349.162430-1-ciunas@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA5MSBTYWx0ZWRfXz7/DT0gG8Umh
 HSnzV9SbqxilscCOqGArMAfccgpPX32ei7Z+iqGq4I4OhvwwyGxXZ2TFjoj4GqZjyqx6pBUfUuN
 Nph6DvEEoaeWqQA/86N6Q1RSZsoyQ1kOJFmQCQub7pE8m7NjuLww2O86Fs3Ag4OqvsL/QNwP+p8
 xSbk49oDgYfrXK8Azw1a2gPoznVqvVB6R1jwp0S0DQzMJrEt5HMhj/maV+/U3QWqmewGCYfqT4H
 w4yVEmlxdPtc1Qo8w16LXldU79BTylzhllIgPNZVcwHkGFHCQqgq0LCthGB49bOnBjTKzGX7uDN
 m4lhFX28PDjTJmeIBY/yu3vm1W5VsKiwwHLxiYfvY1J377gOp1u1QvQuP/Mhl/XuICj72/8xQVy
 rRT+yhUcysQhB32s4Ir8vhfdZPA8V7s5r5x6g3kgbEwZZc9retpHrUEHHJj74zHq8q3WIKVFwDK
 g1SZ/zbTE2tsXNtJ6Yg==
X-Proofpoint-GUID: EIAhGe9eUYgKgtqsQ-G9O_kgp046-cCX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA5MSBTYWx0ZWRfXyQGXZsDCXqrq
 duYM+2qwmZxulPK6enbPoTkfOy4R4YJhP6LOllF7ayOncWKxgBzJ15TnNFM31nTeiQ65F0fBNiN
 W7yZ+qhlXpNqHp3TdY3/csK1AY64XPQ=
X-Proofpoint-ORIG-GUID: EIAhGe9eUYgKgtqsQ-G9O_kgp046-cCX
X-Authority-Analysis: v=2.4 cv=auGCzyZV c=1 sm=1 tr=0 ts=6a351664 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=e05qxJdhFS1Mp7vzFoYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190091

This series enhances observability for DIAG 9c directed yield operations
in s390 KVM by refactoring the handler and adding comprehensive tracing
support.

The first patch refactors __diag_time_slice_end_directed() to use a
single exit point with a result string variable. This consolidates the
control flow and eliminates code duplication in logging statements,
making the function more maintainable.

The second patch builds on this refactoring by adding a new tracepoint
kvm_s390_diag_9c that captures detailed information about directed yield
operations, including source/target VCPU IDs, physical CPU numbers, and
operation results. This enables better analysis of VCPU scheduling
behaviour and helps diagnose performance issues in virtualised s390
environments.

Together, these changes provide kernel developers and system
administrators with better tools to understand and debug VCPU scheduling
patterns related to directed yields.

Ciunas Bennett (2):
  s390/kvm: Refactor __diag_time_slice_end_directed for single exit
    point
  s390/kvm: Add tracepoint for DIAG 9c directed yield operations

 arch/s390/kvm/diag.c  | 19 +++++++++++--------
 arch/s390/kvm/trace.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 8 deletions(-)

-- 
2.54.0

