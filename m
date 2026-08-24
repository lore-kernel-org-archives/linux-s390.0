Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E4F43E9F5;
	Mon, 24 Aug 2026 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582307; cv=none; b=AiKLuwXmwGefn+cULwCPJOgRSc+w0jsZ5kSanso6ir9HALm+97c0nRAM4l24nu16PJ17nZRnUbe70sH3lWmWqY2DisxurQ1vG5Kk35kEVM4HaLirNc1F/VhRzZZqdCdZZcEbXkyn+AH5bY38aVeSjekwVeahYQ5FNOU0ob3IM/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582307; c=relaxed/simple;
	bh=JHq7WIUD5gSx+Gc05SO4rhssSmtIikMBnb57TdeWwG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKyi/7Wty4Qqorknk/d97vdC8UjRX6g2c/DLok9BFbNGGtWdk7jaEC4NaJFBdWOCM8Mvz/I7TDq8iFMuLyMF8M3QCKn3Ox8MzHIkPPvXL5muJNoNO4JREhpKXyqr5pqupLdeXobgiv+aRXh1LIzAZ2vvK9Snk2ZC+YQQ6R7erGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QMBkjQca; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QMBkjQca"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OD1UE7084914;
	Mon, 24 Aug 2026 14:38:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=l6zPDAMyPkDmzH+Ep
	T/zB2Qxtdp3t6jjHjx6O/av8ag=; b=QMBkjQca2k5E8UYHUcmLCNaFPSxx9Hj0W
	NxddTt2dTlZzmDo9eSldyeAH5WPY0WBmz8cjht2O6cav3kfTotpnzlnvHEEOS2qu
	7xNKbwHxX/nzAEYbO00LR/hxfkMtzPTIeuKeaa1COWwnr49kGZYPd8r3XtAtfuQz
	QEelKk5kmxX02eJjJelAUqOk5Y5ov4988fVB6KfhaFZQSGe4hjyGwrcNSaHmXMaU
	m9EXJaK0bm95VxL+wqylVgZCWV0wJF2TwykymbrFOGqpiWDtegtKcyKH7SXaLYLd
	BkZ6UZwOBo5egCuqnZu41GNklqrP5tlHQZThyFWsdrU2lQ8YpWMSA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqhytt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 14:38:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OEQGaR029418;
	Mon, 24 Aug 2026 14:38:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3pxqvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 14:38:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OEcHn244171692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 14:38:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CE1120043;
	Mon, 24 Aug 2026 14:38:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5679C2005A;
	Mon, 24 Aug 2026 14:38:17 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 14:38:17 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, frankja@linux.ibm.com, borntraeger@linux.ibm.com,
        linux-s390@vger.kernel.org, imbrenda@linux.ibm.com, thuth@redhat.com
Subject: [kvm-unit-tests GIT PULL 12/13] s390x: unittests: Reenable tcg for migration tests
Date: Mon, 24 Aug 2026 14:35:44 +0000
Message-ID: <20260824143740.291583-13-frankja@linux.ibm.com>
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
X-Proofpoint-GUID: Ow3Ca3sZTLIL1fCbNNeEpVdXG6u5ZfNY
X-Proofpoint-ORIG-GUID: Ow3Ca3sZTLIL1fCbNNeEpVdXG6u5ZfNY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX7b6oFlkBK5zf
 ek9D3VWO4JDZHPCsfv6HADjzMqVnRAlNWWYMelB9I1f631m2GIeEYa0UiZpsI0+N66sxR3U/w1y
 0hkhkpY58FYTmxHNwXbTMtlVWzLOBgHHH+VkeHytWvnbxQ6A8/yxXwXwXjLXQImxOMfN//+b+Z4
 AJDK/vfhs7wMluQYeT5OkIYTT2AU9+PIxslTM3kIJ2acDd3qqn+UidQuGDpoHvBweCZqVtZG+ol
 iOMZpbQqWUoBsxwOaT8GyTtrd+jMdwbBHngywYTlmrqbuDfWVSKIFAg32vgG7KkyKjO7e/BJ99X
 I5DYV9wLW35lIc4Hj3iF+eRkrGButH9lqijQRtQoz6OXzqZhszl2N2ZReDWXwzOb/Xux5Ecm94P
 tVhwmdZsTH5L8Zk05nCy08KSSNV4z3jyPA7jdmepHr3y3OY1nN8qr+1u6nPm/HG6M+84XnHivZD
 PN9sPJyH6QzPrdky6Hw==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8c575e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=uh1mXFUSPedimpaDh2MA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX+AQ15Pvl4hCx
 7VXNEP6QEn8mae7o4TqgWbx742T4G1og4fOn7Q8lBkZjclEjrqb8nZEI4kfUjFyueKviDzdO3/9
 OxHD5XeuG3JjXg+YVoTdE9VoSBovskw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240122

The TCG fixes for this issue have been in QEMU for quite a while.
It's time to reenable these tests.

QEMU fix discussion:
https://lore.kernel.org/qemu-devel/20240312201458.79532-1-philmd@linaro.org/

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 s390x/unittests.cfg | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
index 8c39d4f1..64bc998d 100644
--- a/s390x/unittests.cfg
+++ b/s390x/unittests.cfg
@@ -15,19 +15,14 @@ test_args = 'test 123'
 [selftest-migration]
 file = selftest-migration.elf
 groups = selftest migration
-# TODO: Remove accel=kvm once the following TCG migration fix has been merged:
-# https://lore.kernel.org/qemu-devel/20240219061731.232570-1-npiggin@gmail.com/
-accel = kvm
 
 [selftest-migration-skip]
 file = selftest-migration.elf
 groups = selftest migration
 test_args = "skip"
 
-# This fails due to a QEMU TCG bug so KVM-only until QEMU is fixed upstream
 [migration-memory]
 file = memory-verify.elf
-accel = kvm
 groups = migration
 
 [intercept]
-- 
2.53.0

