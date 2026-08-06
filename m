Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49103A0E88
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030737; cv=none; b=fmL9Gy0PUjqrlSNu/zVdlisc1/CjwbIyS+rJ1qAh7pLr/hppYlE3KWOBEhrGI0rqr3Czoq3p1zYqwjxVK8MH6Nrsoje1Na59OfY4FmJre7B1LaC5MQ52DyA8ZThVUsgRzOeZZPT6JDYCTEUcX4avIMzzU+XhEFSPdtz7GFDUVKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030737; c=relaxed/simple;
	bh=YdicdcJV2d3rtbAOLNILErGcdH6j57UZszav0DWo6H4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXRbYI/l7+WLRUj/P1/A5vHgdb5NLpjGqZ7Tmxi5BdvA7lNDeEBvas0fkJQOTU+vSFPra3LYlgggHuMzF7TJiJhCq9t/mnPN/mAHOrNf2ikfGIUu/FBqPl1xD35edMYGI9o0jYUOO/wTWipNGFHBpeLxiM/uAlhHkPVMqOaLfVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iasio83k; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iasio83k"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676EnSLO2964695
	for <linux-s390@vger.kernel.org>; Thu, 6 Aug 2026 15:38:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=n9TXovUYtXnirPmgG
	ghDLf8HQJQy5Gr1bWES4/rwnyQ=; b=iasio83kq60rCoz/UJezu0vR5Lh5WSYkj
	h1jTwP14RMXDHUQzcGsnfV9hNBySO78iCBopIQKsi3keQ3roAfq7jeJ0/Gr66/jx
	lztIy6gwcw9FM6cnOQHwf66ghmemyg6Ox3LmpyM6XkE9Qtc9HVKVJJkPGx7tlCE+
	zJ9qPz1GNyhpM6PLzGVwkSOROP3T0Dg6ILw9r815vHPejub4c1YEE4JlCyeXPFE5
	xwIxHHkd/pXe9HrGgqmgFNwUZbVe3hf7b9jEYt/oPxpiPCAnpSx7ZqoUAA8mw9CZ
	o30wYRt/89f06M3CRnqT612Ivrr0jqNhvy8+kiGXeOzDrrpG1GP0g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h592jy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 06 Aug 2026 15:38:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676FQHar006945
	for <linux-s390@vger.kernel.org>; Thu, 6 Aug 2026 15:38:54 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhkpy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 06 Aug 2026 15:38:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676FcoQ044368244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 15:38:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04B5820040;
	Thu,  6 Aug 2026 15:38:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEB062004D;
	Thu,  6 Aug 2026 15:38:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 15:38:49 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH 1/3] s390/vfio_ccw: Add __must_hold() attribute to vfio_ccw_sch_quiesce()
Date: Thu,  6 Aug 2026 17:38:47 +0200
Message-ID: <20260806153849.2622576-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806153849.2622576-1-hca@linux.ibm.com>
References: <20260806153849.2622576-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExOSBTYWx0ZWRfX9PegdEN5rDiI
 piy0Jnj3yTstM0kJrZmCUWneziV2jOgZdchIJVB0MGm4KAW/jNG35uD4HkA8D7eTUgsmW8hn1fU
 PJgOFkmvyOZe2HHnNt2fDWTfA27MXiw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExOSBTYWx0ZWRfX024bUg6KoZ5q
 b7TjpruadybWXuU0LN/mxeSlMTAgr3snSeG5uH3aXtMfrUYxEsKoxJg444W950TEy/2zXqAU+yM
 G4IUd5dTL3w0h+4J2U+/J0fUy7OS7+cIAdJHemFyWdySvPUcIG0raa9Qf+Ni6Huz48hA3N1aWrb
 MWAHxIf6fwaWnHa6sNPCTN695Wzwh5BpsN9hCSAKQQxy5/lPbEwrOAAYMA61h7qa82Tfu8dBtOV
 Ib3JcHggr1cftwW1inEkOEz03xT1TRX3AAKUIO+5VJMLGylS9bO40oPTJkKd3NG1JL4de7Rqssz
 gb9xsm0sj7GIhr+c9A7BcetQJEgdJOm2VAOl3RngfSJTLGRyY8zTufGDBR0KoVMHb7ulqDuLM9r
 KYCpTuczbUmg91K7wA3aHzqXSEWq5a2yEW2vOCXu30X49V43+uz9g+yOLotvt5Czdr02hz6Wcfr
 6CWGevXB4poelJeyySw==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a74aa8f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=c46Rcz8-h95O5EWZ2t4A:9
X-Proofpoint-ORIG-GUID: WtYYf0eB86Oj3UH1wearqEB9SYCJ21-4
X-Proofpoint-GUID: WtYYf0eB86Oj3UH1wearqEB9SYCJ21-4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060119

Add __must_hold() attribute to vfio_ccw_sch_quiesce() in order to let
clang's context analysis know that sch->lock must be held on function
entry. This can also be easily verified when inspecting the function.

Without this annotation this leads to a valid warning when context
analysis is enabled:

drivers/s390/cio/vfio_ccw_drv.c:55:9: warning:
  expecting spinlock 'sch->lock' to be held at start of each loop [-Wthread-safety-analysis]
   55 |                 ret = cio_cancel_halt_clear(sch, &iretry);
      |                       ^

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c     | 1 +
 drivers/s390/cio/vfio_ccw_private.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 1a095085bc72..ed9ca77c5b23 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -35,6 +35,7 @@ debug_info_t *vfio_ccw_debug_trace_id;
  * Helpers
  */
 int vfio_ccw_sch_quiesce(struct subchannel *sch)
+	__must_hold(&sch->lock);
 {
 	struct vfio_ccw_parent *parent = dev_get_drvdata(&sch->dev);
 	struct vfio_ccw_private *private = dev_get_drvdata(&parent->dev);
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index 0501d4bbcdbd..8db29519dbfd 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -127,7 +127,8 @@ struct vfio_ccw_private {
 	struct work_struct	crw_work;
 } __aligned(8);
 
-int vfio_ccw_sch_quiesce(struct subchannel *sch);
+int vfio_ccw_sch_quiesce(struct subchannel *sch)
+	__must_hold(&sch->lock);
 void vfio_ccw_sch_io_todo(struct work_struct *work);
 void vfio_ccw_crw_todo(struct work_struct *work);
 
-- 
2.53.0

