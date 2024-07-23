Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25D014D6EB
	for <linux-s390@vger.kernel.org>; Tue, 23 Jul 2024 12:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721738694; cv=none; b=bpD7dzhd+McN0HsxLzVtWceJs/dqhPLYSb3T8KYT7v1Dbx4jkj+VsPqs0PAVJDBMLWEGdannxktBvV6UlsOwgSn+6zAkemi9RVG7fijZlfp5BgvJYIupPXrH3yTrj7dUtbRzeMI5bov6MH1FHTVH4ojmKfffdlcTNwBq9cJPvLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721738694; c=relaxed/simple;
	bh=CzCF9At1QCTOBeHwz+I8lDEkW0Mf90daWr7NZ3HYMIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L39ljAnQH3P3yWMZhIfARFm4+L8amE9hlgV27+XRHM+NiFCtK3pDiwNAapsOlhLhs1Mjr+5xF7Pdtn/EM+pmaWMzUUUOu74h1y3rSFmVUqA+4tbQgsL7eo3HNcluK+spYtIIeDcshUCTKfqHGaKbyTGyxiJhP0/ZPHeI/v0jiOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rEmkl3He; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rEmkl3He"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NCQjW3019080
	for <linux-s390@vger.kernel.org>; Tue, 23 Jul 2024 12:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=ZmVdRlTsypkzd
	mdka8X8dDT3toh0DVPDOLnieNC3WI4=; b=rEmkl3HeU+vKK9NcGd2DaQlWF0Ve0
	NmXC8y7SXT8ogQ7ljrfZtpYHxOVJnXMM/6azfcqKYYPUj1i5NEzcVfxPh18zjrJn
	qd3FusXY3310g/AtSwAstpEsTN50IgLX2ZjoCvTKBSJiDlY1JZPLYpze/G/I0YRD
	HTiY6yaLmQ2EhJTMixu7TLRL30AqjStDFPIUTINjyjkNBPRWUEDKN9j4srTXwjPc
	RDX5Mh3IgSzA/HcVtldxeIhmByB4VVJv1IEBP68OH7LZoWA5s8rhHZVfA+E7fTSG
	T1j6IKt34hOeOP7q64V0FECL++PWPjoVaRgcSPWw79d2GFFLalV8EEAeg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40j91p0fmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 23 Jul 2024 12:44:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46N9IIvn007979
	for <linux-s390@vger.kernel.org>; Tue, 23 Jul 2024 12:44:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40gxn9tcpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 23 Jul 2024 12:44:49 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46NCii9Z25101010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 12:44:46 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E32E20043;
	Tue, 23 Jul 2024 12:44:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF02E20040;
	Tue, 23 Jul 2024 12:44:43 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.13.42])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jul 2024 12:44:43 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 1/2] s390/kmsan: Fix merge conflict with get_lowcore() introduction
Date: Tue, 23 Jul 2024 14:44:11 +0200
Message-ID: <20240723124441.120044-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723124441.120044-1-iii@linux.ibm.com>
References: <20240723124441.120044-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CusCmgMHHQcBWOTsFV9OBnukzAQS6Kn6
X-Proofpoint-GUID: CusCmgMHHQcBWOTsFV9OBnukzAQS6Kn6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_01,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=697 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230089

Resolve the conflict between commit 2a48c8c9cf87 ("s390/kmsan:
implement the architecture-specific functions") and commit 39976f1278a9
("s390: Remove S390_lowcore").

Fixes: 2a48c8c9cf87 ("s390/kmsan: implement the architecture-specific functions")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/include/asm/kmsan.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/kmsan.h b/arch/s390/include/asm/kmsan.h
index 27db65fbf3f6..f73e181d09ae 100644
--- a/arch/s390/include/asm/kmsan.h
+++ b/arch/s390/include/asm/kmsan.h
@@ -12,8 +12,8 @@
 
 static inline bool is_lowcore_addr(void *addr)
 {
-	return addr >= (void *)&S390_lowcore &&
-	       addr < (void *)(&S390_lowcore + 1);
+	return addr >= (void *)get_lowcore() &&
+	       addr < (void *)(get_lowcore() + 1);
 }
 
 static inline void *arch_kmsan_get_meta_or_null(void *addr, bool is_origin)
@@ -25,7 +25,7 @@ static inline void *arch_kmsan_get_meta_or_null(void *addr, bool is_origin)
 		 * order to get a distinct struct page.
 		 */
 		addr += (void *)lowcore_ptr[raw_smp_processor_id()] -
-			(void *)&S390_lowcore;
+			(void *)get_lowcore();
 		if (KMSAN_WARN_ON(is_lowcore_addr(addr)))
 			return NULL;
 		return kmsan_get_metadata(addr, is_origin);
-- 
2.45.2

