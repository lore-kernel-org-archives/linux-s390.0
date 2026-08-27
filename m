Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775A5296BA9
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 06:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787813204; cv=none; b=PeYUdGq1IrHCC7n1ccmGNMEMpVYjcXmSNCawHlMZcZFU5xIJx42dpSzqxA+glmp/3s7tumfCDvrPFcCDjonVTzmBBMtsXUxLyfHLLSBj1pZEUFUffPHIJvFcp6AUZAmwMf8CABT/WBaa+8m9lmOSaJl0mTi+tjw6V+DtXC0OlZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787813204; c=relaxed/simple;
	bh=qG+IqojyIiLIGL5gPW/g+rDF7OW5HNi7t3D6NKHBUVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GI6p5biae5vdwjg6DIyLURsiBOASp58gsFPPgZAF5/Y2U6elRabdb71Zgzfa2DBxJVjTtihOyiTQvDe2Aq+YhGuzVisd2nJ05JE7OGTJJkzZPwu0GJ46usDQZOJAYuyfwl3GNNnphmS8hUKC6zdhJBsVbLIcdH8NHPxYcPEjW7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y4aIGpos; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y4aIGpos"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R6Vdjw1082060
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 06:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=d5RVCO3yC5YNr+PR9/FuremUzeYNlZ9Kv/4ohYaI8
	9I=; b=Y4aIGposfl927HQHsE1MCwIb61919qNb5gLS5Hzch1zDb+vAQiDa/ZVDW
	tiRa6iocXsSA4Ul57gVgTRvEZU2kTtpPlmGLjYmk1On8DVW81M47SWfBL8342JkV
	/ejUB/etUYK2/+DAoxOO26r/+bxu+MAMNERO4YN6hkTo+kPu8jHXCzQs3CorzrqB
	AalHkfWUOKAZ2zwi0+p5CEAZ3J8cdHKPVhfpQPw89HsAGOIFp7Nvre5UWA6pXHYO
	tkVEWLBGyvBTRxzQfM4lkLa8nBU8vpaH7cNuBFbn2jhk7NaDFGHRTrP9I8xO4lHc
	CaUKjyimVSoXiw+VC2P3RhEOKC6rg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726eukdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 06:46:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67R6fGsp006108
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 06:46:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qesxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 06:46:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67R6kbSl47055270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 06:46:37 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 921D720049;
	Thu, 27 Aug 2026 06:46:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F0A020040;
	Thu, 27 Aug 2026 06:46:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 06:46:37 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] s390/pai: Prevent ioctl(PERF_EVENT_IOC_REFRESH)
Date: Thu, 27 Aug 2026 08:46:12 +0200
Message-ID: <20260827064612.3161950-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8fdd52 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=32-ppuM1j2JskDvDLfMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA1MiBTYWx0ZWRfX38vjLO0jdZI4
 YBvZkw/QkxsN3d67douAYaDJp9E/j1wGPdtokeSoYAVTJqn3puJFebp+iWA6HLMsfYQNq2sOXBw
 rKrgxJI95ZTdeYmslzay91AjedVPaC4=
X-Proofpoint-GUID: kpwUMfBcPu_GyXyNud2lzZqIaUrod4Y8
X-Proofpoint-ORIG-GUID: kpwUMfBcPu_GyXyNud2lzZqIaUrod4Y8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA1MiBTYWx0ZWRfX/4D06H4nBLh+
 9vqyAy/5UTTGOz3xr76exr+JYbrkEUNk7YG6Hd4NHv4sKUQ5IzJCvLx6RZPX9l9BlwQ023skmQe
 Lm8Xg5W+L0Xj6focuvOFc+vJZkFM2yduQRn+cgQN5T613NPLNgSXTqz67dCq3ISfvLSRBCkHs9Z
 qdMI9exRcM/vzTrNXZMYrM3N2eQpJYp1ydsWnlNPa0xXBwsSLowejUu7liy+MoU72ZhJ151Re+h
 XmIgsJlxPKQL40Hg9tVbrz7bo0PF9Q2n3c7bJ1r7b4YMEyY7Cv3w+SD7i333CE36QWnTbByjAhZ
 X6FmJUDhbs95D/Do8jYYv7rqmFVH8uFZsoE4nAbT7cz3taHsKMJnugfE5CYkgMgnSAFIlFmoxFn
 oOsdn9NidMN+eOlGchCVBjPKm1uDvN9ORJpac4LWEktx8iWfmNlK81JmnGR4J7KRSd9CfXfUiLM
 vv8cDd53kywHbYAJmag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270052

Prevent this ioctl(fd, PERF_EVENT_IOC_REFRESH, XXX) to take effect.
PAI PMU events CRYPTO_ALL and NNPA_ALL are designed to read out the
changed counter values at schedule out time, when these events
have been installed system wide. Then they use CPU-context.

If an application issues ioctl(fd, PERF_EVENT_IOC_REFRESH, XXX)
it expects to read out samples after XXX hits. The PAI PMUs do
that read operation and then reset the values because it expects
a context switch out. This contradicts the readout at next schedule
out time. The reported result is too low.
Therefore prevent this call ioctl(PERF_EVENT_IOC_REFRESH) right now.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 arch/s390/kernel/perf_pai.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kernel/perf_pai.c b/arch/s390/kernel/perf_pai.c
index 05f74d74fad1..3e972d940100 100644
--- a/arch/s390/kernel/perf_pai.c
+++ b/arch/s390/kernel/perf_pai.c
@@ -666,6 +666,8 @@ static void pai_have_sample(struct perf_event *event, struct pai_map *cpump)
 
 	if (!event)		/* No event active */
 		return;
+	event->pending_kill = 0;	/* prevent ioctl(IOC_REFRESH) */
+	atomic_set(&event->event_limit, 0);
 	pp = &pai_pmu[PAI_PMU_IDX(event)];
 	rawsize = pai_copy(cpump->save, cpump->area, pp,
 			   (unsigned long *)PAI_SAVE_AREA(event),
-- 
2.55.0

