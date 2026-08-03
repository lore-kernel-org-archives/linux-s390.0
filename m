Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE2941B8CA;
	Mon,  3 Aug 2026 17:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777712; cv=none; b=PN/gPE3Tmzwf5Rd1teKEoqHLQ2tswPIYudbxk3JE+brgw65qhB8VMdeRK0lL4AOahRvY/pjjMW4UkwRjDP3WskHlQum60cRQHVmiKxuugSf2T4MVeA19WLcrv/Ekh6mgcqAQAP5us2zlk5tcadecM61LBzQGVvF64DJsUWBzF60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777712; c=relaxed/simple;
	bh=wgDqIbG6vUyK6jc5us0C3UrcAPGalUCpwieH9kTF/mA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQdh4XKIyP3er5nzXck6p1lDmqe92nDzHZr7CQuXuZqAvKyEn6f0fzVh72YOJskdp8y0wgFXY/csRv2MwIjTJWIJrS/zYxfPsnHxPwgxxsrXuNSic69f4f3WW+lwxeHKl7/FqsTFzdPuf5FLZi7P9aOuflp2kK7D+WE25bm+cJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aikrh746; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aikrh746"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673HHjSR2606682;
	Mon, 3 Aug 2026 17:21:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nWBhQMqi5V6YFM447
	2s70ETNFvtTf5AvVhdjbp1Q4hs=; b=aikrh746+uDd+DcecKWcfWISgDsddKpaO
	LS+xG7TLOHPYF1irMtJSm/ydk0Y7J6MHstrwhgRjxwfkQinbnP48YsSzNkv4DFZH
	EgqPeTiqaWQtvvrl3bgzZx/ndUsFJ4ukI1d4ie56qOs6+GyK1W0CHM90rPZWgMjS
	i2hlTFucVzy2BhFft9ylc+eT3nT+JJ7GyIwfkNFJ4B1lOhuuqDHYb0AIEu58inoO
	8fIWxDGkh+I2LjascllNO9xElVlclKWhGRGPCgC0k+PkOhrHTV38T5c5tDip0q7h
	m/vOW0qK+znvLlMC5pI7b9tFGE7ZwLkSf+t1TpteXhFevCyclulxA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77g1u9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 17:21:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673HBeCV020363;
	Mon, 3 Aug 2026 17:21:48 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg68nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 17:21:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673HLigD16908592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 17:21:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD1232004D;
	Mon,  3 Aug 2026 17:21:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE4002004F;
	Mon,  3 Aug 2026 17:21:44 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 17:21:44 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] s390/sysinfo: Add context analysis attributes
Date: Mon,  3 Aug 2026 19:21:41 +0200
Message-ID: <20260803172144.827049-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803172144.827049-1-hca@linux.ibm.com>
References: <20260803172144.827049-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE1NCBTYWx0ZWRfX2O5UrfUdlYH+
 IhAYqvpCBoRmKpR3Vrsjxaw63UwtwF4ArdXcloczkmYYFUnEuo2hs1HD748fbI3KwWJzYivV4AC
 MzCmuQuoDclGYBJYrWa/dhtDnqSCCtpcGD+ruZ4x7zUlMgUMKGvcZkt16rNXhxebSKUcKdEPBRc
 u50Sm0djLqGQMq4yGpE5fjBChOTdeKbLliobkX9EFpVBE06WmjO4QFKrgD6xxeAA+c8DW/+O/st
 3CTLgDttQoCRJVqjTZr5iwJMS+xBmDQjkmwzuU1bDYwpNv2aMqnxa5JD6DuWbb63JGn8gVsCX/f
 bFaFnOSj+eMrCP6MwIVz5EmyGOd64bEhoQgi0uuk6DX/pyDMz2julxECGt0lBJr1ZuRnsgfhCgB
 bWp3m2vOpqs4LAR2idQhtfJ1tExxGQa0Q0WwBC/pGtGNLpNtik2zEqkgXMqzZ0iuf3Wqtt3BUM7
 4hNK7R3lsjDl3uk8vWg==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a70ce2d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=SERiLF2h6cxcJWe3OlUA:9
X-Proofpoint-GUID: I_SpVHyYYiksD-Cauiw2o3X_bTF8DTIn
X-Proofpoint-ORIG-GUID: I_SpVHyYYiksD-Cauiw2o3X_bTF8DTIn
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE1NCBTYWx0ZWRfX2y87MiwftaU3
 uhkdZhu/W/iEjLDQgNnFl5LtH3Wi/JaL9KBilR+/Tc9QfjnjlCyNmN12Ls44XxVwYNa4ZkfmS3F
 Z19WKmIa011Cqgj+aAo9qWE8sSXLHjg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_04,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030154

Add context analysis attributes to service_level_start() and
service_level_stop() to specify that those functions only
acquire or release a lock.

Addresses the following warnings:

arch/s390/kernel/sysinfo.c:331:1: warning: rw_semaphore 'service_level_sem' is still held at the end of function
arch/s390/kernel/sysinfo.c:329:2: note: rw_semaphore acquired here
  329 |         down_read(&service_level_sem);
arch/s390/kernel/sysinfo.c:340:2: warning: releasing rw_semaphore 'service_level_sem' that was not held
  340 |         up_read(&service_level_sem);

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/sysinfo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kernel/sysinfo.c b/arch/s390/kernel/sysinfo.c
index 33ca3e47a0e6..45b4f448fe3d 100644
--- a/arch/s390/kernel/sysinfo.c
+++ b/arch/s390/kernel/sysinfo.c
@@ -325,6 +325,7 @@ int unregister_service_level(struct service_level *slr)
 EXPORT_SYMBOL(unregister_service_level);
 
 static void *service_level_start(struct seq_file *m, loff_t *pos)
+__acquires_shared(service_level_sem)
 {
 	down_read(&service_level_sem);
 	return seq_list_start(&service_level_list, *pos);
@@ -336,6 +337,7 @@ static void *service_level_next(struct seq_file *m, void *p, loff_t *pos)
 }
 
 static void service_level_stop(struct seq_file *m, void *p)
+__releases_shared(service_level_sem)
 {
 	up_read(&service_level_sem);
 }
-- 
2.53.0

