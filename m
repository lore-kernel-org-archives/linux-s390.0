Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCED4457BA
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512349; cv=none; b=WMb/s0C+Typ80G4N3nehIUhuqxAK7Z1BEU1d/PCJwE/eCCeajdT/d5NUXGyCns1UKFr1R2y/Tbxn5KCpFGhoK0R5wXOQjF+ta+DbzT6osbOkFUp5zngEoZ+IbOFrUf7eB/UAWXOPWba5NEv30hx+TnHIG8uA2BEOnaNXcwtvL5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512349; c=relaxed/simple;
	bh=1nkbS4t0z/jNRIPvt15xVo/n2dUlxGg0BuXBYg2XhL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o0jrhvyU53v5P7hgG/LU4wGA87RifOvj9vojiebE23uViqsj3cKIv2QAaxvvcvM8DdMdiZnlFle4iJRwtIY99aoZjg2u7fEL0LnshqVEDJttkMQVkNMRI1KCzp64Bsb+cQbw2ePE6gWTcCqVHBNrJd11j+Sc55eysND5ru6S5Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X6W8HJfB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X6W8HJfB"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBm84p1732060
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qPeZ8L
	meuKfX5O8qbmPQCZbpm6RTF4pXptsGoiEH3rs=; b=X6W8HJfBm8OdAi6rKdGMP9
	SJQ202Q9+Bo23m8vAe3U7FTPp2/lTmGSJG/yX7A2c3pVcam6M9CIwQdfAImdOVwn
	3p0NPk6bjtXGC6kkXvECYt3hbXX1QxCJsobvEhYSw8WN207rAW8G26S76WXyoE/+
	wUrSfVXFRRjLp9qS0FHjg1dCN27nH8bxslIrxiuf8n+x52t7wBy5iGyMtCl9QbEt
	gxYByPzF2GiLuBHXq4jNqt0JTkErNoZ/hZOvT5+HerbUucw/GgYd4KJ5R8FKUMdv
	2iT7FY4650eJLGkXHElbr5XDZZQK8NCLxFifwckO6mwbQsDQty5s7vccDVhHe43g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7wsgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VFBSxN027929
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgra24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VFd0iv46989656
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 15:39:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 063EA20040;
	Fri, 31 Jul 2026 15:39:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9CAA2004B;
	Fri, 31 Jul 2026 15:38:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 15:38:59 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v5 03/17] s390/dasd: Optimize max blocks per request for track alignment
Date: Fri, 31 Jul 2026 17:38:28 +0200
Message-ID: <20260731153842.1729627-4-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731153842.1729627-1-sth@linux.ibm.com>
References: <20260731153842.1729627-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2rIyTKxlWPwFVbKmz7OG8L4uGQvcIEZx
X-Proofpoint-ORIG-GUID: 2rIyTKxlWPwFVbKmz7OG8L4uGQvcIEZx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDExNiBTYWx0ZWRfX1q0AwFo97Nul
 tsjrm8vjPa/eHpIRurvVSbikQE01UmxJq1CRX6LPEeEPSi8rVPOVIViYGWP146ulyZ7ADNY7O+t
 /IvtJbBd0vdAw+h+0xp0Etyn75F8bjdft/dx4MKkJFMgZonBF3bEYfwfe8oOyNGIKLDtbYpHtlV
 kEoXPOHDofCKkuPdiL5ILXTUItrBIHafqBqjZOFX13ya6K1pcv75cHGNc6MsiBbAHKWBoE2VFZh
 4MYjqK07R+xQtchFD5QmZFSU9IWydysXnu482ASYCjvSnJu/7cvlbN6wD0lyq21yQwyQWNvzq/H
 R5U+NTj+dopuqsL+XfFYj75k6gGkXuRV0uP54wZgVrZwHAcP0uHKJKfNx5aPN4M6ef2//kl3y1/
 +PJKtUjy2jhYdZ/fNc2UJVqmEyKxXmekdDxISSf8fpl/CPf5SB+Rnib2idzTuWejU/DorlkA4Ef
 zKEfpPJjt9AcvM6qSuw==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6cc198 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=8f17mpASHZ0i51vZi0YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDExNiBTYWx0ZWRfXzveqZdNt1cZZ
 CnWZCjpfEn75P+hqwywZ+GNTWTtpouWN+XScCUUL0wWkRPmohFjySqzClqUqkI7P9lvoR9Jo37O
 gdwdUhVSOn3mcLM2RbMBtxAAxdySHq0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310116

With 4096-byte blocks a full ECKD track holds exactly 12 records. Lower
DASD_ECKD_MAX_BLOCKS from 190 to 180 so requests align to track
boundaries (15 full tracks); full-track I/O is more efficient than
partial-track writes, and 190 had no alignment significance and could
let a request cross a track boundary.

Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_eckd.h b/drivers/s390/block/dasd_eckd.h
index f9299bd184ba..763733bcc4d2 100644
--- a/drivers/s390/block/dasd_eckd.h
+++ b/drivers/s390/block/dasd_eckd.h
@@ -131,7 +131,7 @@
 /*
  * Maximum number of blocks to be chained
  */
-#define DASD_ECKD_MAX_BLOCKS		 190
+#define DASD_ECKD_MAX_BLOCKS		 180
 #define DASD_ECKD_MAX_BLOCKS_RAW	 256
 
 /*****************************************************************************
-- 
2.53.0

