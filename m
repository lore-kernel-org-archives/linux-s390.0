Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686373D953A
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 09:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032736; cv=none; b=TtZ5NqJSItorycEjBEitlHkrSXVKfUD6DmgbrhDJETwzl0DBYbZNqzXRdIw4TfkUTOnAehgwVunEoDwu+oMTwv0CtPWVZErXrnFAVshuroVaaQ/5G3e0Y7dbswkmDlg8S59JLyZN74LlRYixRUHP5MvVzlJXKavnd9/VyeHteko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032736; c=relaxed/simple;
	bh=D7OqJ6QS+zEgFW7ujSspbkFg8Vb0vNmOktvzwg3aw6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BAB621R9CH/4NoWyn5TIiOxhD2tzM8mLbOuNwukYWM4rQAU0686WbZLSTlp14l9kPKEXu3cthc2HUhe+6DYyZXGN3Gc01vF9XZxYmPjHQ5LZHUVGPMsngDsgwtEa+Hd8TuFWQcevGGmNU8fqK2xbQJZUdt6pmG10YOLVeE2vEQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gs7Z+DrF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gs7Z+DrF"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A91hG72313883;
	Thu, 10 Sep 2026 09:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1gZ8KVoAjmW38j8El
	fh/Dvg7AKaxpM3BpBe3BusGegU=; b=gs7Z+DrFJJVaGLNuVUVd2wZl2ytRyEsaY
	tq6LxVTqkGcYIRtFcxclWZC9Lxg1tm8JKhd+jTqKqPHOshuz2ySfK6y+7+9CTMEN
	yaVPD8NChpMoXEPCxWXONEVqapiKX1XTDPN0wPqlQVlmf1Gl6lX6mO0HeP0z73Ab
	dGzpjTXnRs1+aTAmD/7qOXjjyHvJmZfZhFm7FSPk9YqIekSfMRY1r1/Dm5/YACQJ
	71iu6ke/WCIBoyFLv0KM3dD/3A+0kRBAXibID86efn4qY8VEO1RJcR1ict3bpIKh
	v+ARsS2730mFQB6ecLse3z6A8hWVsWXLKQo/HDWZr4+L5+dm4uQTw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8s3mgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 09:32:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 68A9BG8k029404;
	Thu, 10 Sep 2026 09:32:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkcr3bmvs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 09:32:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68A9W67546924154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Sep 2026 09:32:06 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3156220043;
	Thu, 10 Sep 2026 09:32:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A6B52004D;
	Thu, 10 Sep 2026 09:32:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Sep 2026 09:32:05 +0000 (GMT)
From: Vineeth Vijayan <vneethv@linux.ibm.com>
To: wbezenah@linux.ibm.com, cohuck@redhat.com, pasic@linux.ibm.com,
        farman@linux.ibm.com, mjrosato@linux.ibm.com, oberpar@linux.ibm.com
Cc: linux-s390@vger.kernel.org
Subject: [PATCH 1/3] s390/cio: Fix cio_update_schib() to not cache invalid schib
Date: Thu, 10 Sep 2026 11:32:01 +0200
Message-ID: <20260910093205.3357827-2-vneethv@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910093205.3357827-1-vneethv@linux.ibm.com>
References: <20260910093205.3357827-1-vneethv@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SvH55Xp_YTPL0m95T69Tui9eBewRbUTG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDEwOCBTYWx0ZWRfXxKtyzsP4TD6I
 GBdl3wcFifMg8QJiVJq140SIw1q2CXpCmoH6Na9PYJTrac3eXpu5HrckJZoLwSXL9r6SBK6WmDo
 gkg4PUo1J1QsRRR9ftl7GHq8yAevJGTs6ovBW2AaHjxTi6qvWtvnaE3U11+M+JYZwdLq754ZkVK
 x+fk+MyIZaIZEVgf32yxm5a90bdiqzDgl9UB8lDjDxoqdju8+DjDlgcd5Hj5c4IstDQNv5Qs9nu
 aPQJD2elHnmHnrWloquO40qbbkh6Csc2fsTDgdiIXgVlirEX0XHYkfCHtBW5U/NLqbWgrM5dvmh
 nbnw0LndQMzURYyzlD7BW/MJjbd4G8kpb20WF7G0kvfgFu5Atc6ZZpKia1EDK6jLbNK/WhaqSVU
 4L3Wbz8yxF5ONtqpanfYDeHPVKHid7mT8y9KpA2U6mp/P70CNaF6SkRxR+Aoh5GF+QQolJgiIsA
 sMalGVDXsdGBeod6f0g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDEwOCBTYWx0ZWRfX5T7blNDFdUoq
 sv1ZYqli0GrM6nqiPZ4WRQijTo45QZjFs3ZaiX1UX9zhT9lUx74jvWTy/GpGNa1uE5vkE7QWtXu
 cLWglm45gTGqag1n1VQK5GbphZHiKCw=
X-Authority-Analysis: v=2.4 cv=MpXHeGae c=1 sm=1 tr=0 ts=6aa2791b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=WmNSD494liwWTnSoBbwA:9
X-Proofpoint-GUID: SvH55Xp_YTPL0m95T69Tui9eBewRbUTG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100108

When pmcw.dnv is 0, the contents of all SCHIB fields are unpredictable.
Zero sch->schib in that case to prevent subsequent code from making
decisions based on unpredictable data.

Reported-by: William Bezenah <wbezenah@linux.ibm.com>
Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Fixes: 8c58a229688c ("s390/cio: Do not unregister the subchannel based on DNV")
---
 drivers/s390/cio/cio.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/cio/cio.c b/drivers/s390/cio/cio.c
index 70dc8cc76594..e1c62eb60cca 100644
--- a/drivers/s390/cio/cio.c
+++ b/drivers/s390/cio/cio.c
@@ -453,7 +453,8 @@ EXPORT_SYMBOL_GPL(cio_commit_config);
 /**
  * cio_update_schib - Perform stsch and update schib if subchannel is valid.
  * @sch: subchannel on which to perform stsch
- * Return zero on success, -ENODEV otherwise.
+ * Return zero on success, -ENODEV if the subchannel is not operational,
+ * -EACCES if the subchannel has no valid device.
  */
 int cio_update_schib(struct subchannel *sch)
 {
@@ -462,10 +463,12 @@ int cio_update_schib(struct subchannel *sch)
 	if (stsch(sch->schid, &schib))
 		return -ENODEV;
 
-	memcpy(&sch->schib, &schib, sizeof(schib));
-
-	if (!css_sch_is_valid(&schib))
+	if (!css_sch_is_valid(&schib)) {
+		memset(&sch->schib, 0, sizeof(sch->schib));
 		return -EACCES;
+	}
+
+	memcpy(&sch->schib, &schib, sizeof(schib));
 
 	return 0;
 }
-- 
2.53.0

