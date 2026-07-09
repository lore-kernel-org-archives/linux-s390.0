Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0673C9EE7
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 07:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783581907; cv=none; b=MDXKyDa5CMXqG2vVEtZlyMe6fq40YRAtbxTimtqqyUUJS/mXKR2Vlw/rLlCgbktGMG9oRWBd1FS19JwG0JD9UHf1CBOYnohmiOphfG7YcmRZ8Got11QB8WOA2AFbssW8L7GKzWwwGKr4Hvhznxy24RnfyApaiEFIZlnenUb3/DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783581907; c=relaxed/simple;
	bh=KnO6RhqCGYGRIUA7JGZTWVkhn1xAOxQj2gs7v8A2lU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTYxWtpXgHf7iAnAKvTvYk/E2ObwzpurcBWwpZ4G+1WG16mnVDDSWTuurNWt/yq53Elx1NMPdFGDVM/2UiLg3SOHK0ZCcoc32aawS0/oqFprKvHVueysZFGnPAsN/RsEF1wlwb6PWXbT+eJx21sy1H6IkoKr4xuaUWXNu7NLVZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IDsUNl7d; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IDsUNl7d"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6696INM11535420
	for <linux-s390@vger.kernel.org>; Thu, 9 Jul 2026 07:25:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1gB8f+3y7ao3yBit8
	ffp1Qq6oXKISiAeqKX0q7xI7x8=; b=IDsUNl7ds1SWSoePwyBRbSiLwOhwRNpRe
	7zUDcDqVQPeWfTYdqyCiHYzN/78u9igZw7wzaaa8QDa/NkY8t1XCiWDfpkXUxVql
	PXaVLLhu50JrNDChcVFoLFSWJVkMEfMuFX7Ky5dLDMqFL1SqK8m97jhB6WvTYWSa
	3nwWc2eA6jky93FdiPYW0aV/pq1hF7tGfnbnWnrxvbGYuPca9kfIWhAudrDBhNGU
	rENH28vPP34qN76eExumbLpHXr6NKhJpkLqjUDWI7/547dDOj6veoaBnVLiSQAGt
	IpV7Z9kcoUfR/8BUQqnOzRN3E6ZnPK1Kyh2GloAZGz/PkO1jktvMQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknr0jr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 07:25:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6697Jd9l009475
	for <linux-s390@vger.kernel.org>; Thu, 9 Jul 2026 07:25:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgkc2u2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 07:25:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6697P0th27263412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 07:25:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A774320043;
	Thu,  9 Jul 2026 07:25:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89D1F2004F;
	Thu,  9 Jul 2026 07:25:00 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.224.92.54])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 07:25:00 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, fcallies@linux.ibm.com
Subject: [PATCH v4 1/1] s390/ap: Use mutex_lock_killable() in ap_bus_force_rescan()
Date: Thu,  9 Jul 2026 09:25:00 +0200
Message-ID: <20260709072500.55706-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709072500.55706-1-freude@linux.ibm.com>
References: <20260709072500.55706-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4f4cd1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=Q3fI1I3nFb4Q5P0WJzsA:9
X-Proofpoint-GUID: PEKe61zZeAQXGyJQkjPwRMjTWwS_AIAJ
X-Proofpoint-ORIG-GUID: PEKe61zZeAQXGyJQkjPwRMjTWwS_AIAJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA2OCBTYWx0ZWRfX21UOcf3FgOT3
 LdBBs8e7F2Gi1MtDy4r4pW9USGnwjwBsaETkKTTPB4rg0LbyHxxKo4z1uxZUlPQKJNwdxX6D8hd
 7IKR68l0qltmSxhDNmfPOPtllwHM3FY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA2OCBTYWx0ZWRfX56Sev+m0SCZI
 lt9MPzuSkNWigtXU1XQxxRYRVw0m1PHu0HmkPWllrvoNVuxg84V0vwfrh0eRSF+cNQ5C60fTaRN
 TRY7g2JOxldi6oS174Lku7/3yXSPltbVx4e9vBZWviWLsq+EZCXIZm/PFjob6m3N6SFdNxRfuR2
 TpyvekLLBW07jRWXm79wykUpzWFCBALXGEwQcVqLEwN7WuCHrMM2EVfKNUDA2kAJGdW0yGKkpuX
 KqJwg7D0O3HDH+BzZuBuYCOEMB0kVmhRkqno/c5/nRCy37CvS29eh7XxTtL8QPU7Zp2rTRsF1t2
 od4ckhjnEFDAbfPo5FJnGFpWY1Puevpfw9m5p4t7XNkV86KljSdKEEV1UP6ttrzRKBeiEaguK78
 vcyIZrJrtr3TcupNIt369pDr4MckxExX+QoEzzpJDXPDYuTm0M2I7cZjSy7oUyz8xioiJSCtKLf
 eKK2LHO2ptGrNyMKuYA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090068

A deep dive into the AP bus code and zcrypt device driver about the
usage of mutex locking showed that there is one questionable call in
ap_bus.c in function ap_bus_force_rescan(). This function may be
called in kernel and process context. In both contexts only one info
is important: was there a AP bus scan running and did it result in
some updates on the AP devices. So only true/false is returned but no
info like -EINTR. But still the mutex lock call should be
interruptible to be able to kill a user space program blocked forever
on this. So this patch replaces mutex_lock_interruptible() with
mutex_lock_killable() to  be able to handle SIGKILL especially in user
space process context.

Suggested-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
---
 drivers/s390/crypto/ap_bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 2d4e00a1e48c..d82df5b4e2db 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -1173,8 +1173,8 @@ bool ap_bus_force_rescan(void)
 	 * for the lock which means the other task has finished and
 	 * stored the result in ap_scan_bus_result.
 	 */
-	if (mutex_lock_interruptible(&ap_scan_bus_mutex)) {
-		/* some error occurred, ignore and go out */
+	if (mutex_lock_killable(&ap_scan_bus_mutex)) {
+		/* fatal signal received, go out */
 		goto out;
 	}
 	rc = ap_scan_bus_result;
-- 
2.43.0

