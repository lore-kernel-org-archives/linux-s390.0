Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048DA44BC8E;
	Fri, 22 May 2026 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779460295; cv=none; b=bOk17PWv2k07z/cNbNsxjZuuRTmg89E4mbGED534cygQ4ldvqhEVJmWfW8wBGXHRW7ugQ5RlAGwZQgnc/km+T/f1Hv2TjZZzUfItK2MUdkPpnWceaGz987SXIxk9eY//XcIUjYfED0O2j+wXBHx0NJ8CAXHoZY6m5k9AdUMfF4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779460295; c=relaxed/simple;
	bh=tumC/KjkJEAap+lYQT7Vz3mdP+3Ci/aFENwA9SbANK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iCAiNd6kUGwnJgq5ZuQQWiZBfUUJF9x57M+fe9buojgcYktNAZolFaBjk3xdsE8RrsHHevj09pFDKg/9FuRDNvvknQoKeM24z08PxSVExizPNRQEK89gVodfRO2umapY6DysUU73BdvCQaZrKOOGkQbK17/ig8QptDykSr74Wsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=srZ1fqfZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="srZ1fqfZ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M86Y393681418;
	Fri, 22 May 2026 14:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=axgqIGGle4yfbA5PIa8oerhCL3MRuCYnPvfk+mak6
	WA=; b=srZ1fqfZ/XyDI5UbpyKSVnYu60gktcuyGdWrFMRqp6gWjL5+h3r7I51YC
	vV8kQnJW1qLQ7+MgxswlfHBIanbnju6feCRI9O/PuQFW0LzLVqTgauwXv57OBweI
	0GpYmWsZnkMtcnOTPjwSvQbC13+glb4ubKwnI6dqOF9VOh4gvFa/JpGSSONG51ZZ
	aI5LCqCrxwyz48hezOwi65W/gUl8hikTLBzIK/vRbmv/r0cRmtFZdqyV8zY8425Y
	q+nGWDAh78stgjrhfIFsyoy7+cV++330zEqjE3PD5sT4Bf2TO9K0lBzQtCa6J2XU
	7cNzDHS6NbfgkCaz/cs+4405QDddQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9ycgqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 14:31:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64MEOC5J030064;
	Fri, 22 May 2026 14:31:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wkh86t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 14:31:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64MEVBDD28639634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 14:31:11 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B5DA20040;
	Fri, 22 May 2026 14:31:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5609120043;
	Fri, 22 May 2026 14:31:11 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 14:31:11 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Manuel Ebner <manuelebner@mailbox.org>, Kees Cook <kees@kernel.org>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH] s390/string: Remove strlcat() implementation
Date: Fri, 22 May 2026 16:31:11 +0200
Message-ID: <20260522143111.443100-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE0MSBTYWx0ZWRfX6haZJyz+gveH
 igeELSddQ48gR/kLjXXMiWjZMa+D95RA3WydbUDSusnw1aieoKmVOwCdTw7UqGuAIpoRmT6PXqq
 PDSetydt8H2yLCI7rsSD8PTDZyxs5h/8eAYyymgTyWPXom32iMU94/sjxYoqDIDKdnMYvOf1uEh
 EgmNRIZShgJF1H5/Q5giSn/I63PwSmq48ahi5OkgwlhSRS4DjMyVMxr0DQOlpWBWHonORK3pa5O
 piSnThUlGN7nGSSb1BH4WOz9C0sud8Bm5EGk9lJWarLR56EltRXuJlX0XrTVVSbH0FlHA57i0LX
 GAF37HbBTviNafpIOmEpZndxJbLFN17zmAy3tGW5TwzyfkRl9e6PT8FrrcUPdvMg0YiMwUPAQw1
 PSwkQy59ft3lk/1eN8eGLbljhAIL5DwAIYlPnSOp3n6voM7xvQUORdUar1Q3EgfMk6zYmhLCFCx
 zAgixbEPs1ttCsx9KXA==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a1068b4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=b3CbU_ItAAAA:8 a=VnNF1IyMAAAA:8
 a=OMIvWfQPTyIrM7UbE7wA:9 a=Rv2g8BkzVjQTVhhssdqe:22
X-Proofpoint-ORIG-GUID: 8l3EhI2g9uwywGQqQIvfX7SwgblSFDSU
X-Proofpoint-GUID: 8l3EhI2g9uwywGQqQIvfX7SwgblSFDSU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220141

strlcat() shouldn't be used anymore (see fortify-string.h), and will be
deprecated / removed sooner or later [1].

Therefore remove the s390 implementation of strlcat() in favor of the
generic variant.

[1] https://lore.kernel.org/all/20260514160719.105084-3-manuelebner@mailbox.org/

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/string.h |  2 --
 arch/s390/lib/string.c         | 26 --------------------------
 2 files changed, 28 deletions(-)

diff --git a/arch/s390/include/asm/string.h b/arch/s390/include/asm/string.h
index 238e721e5a22..378f85304ef5 100644
--- a/arch/s390/include/asm/string.h
+++ b/arch/s390/include/asm/string.h
@@ -26,7 +26,6 @@ void *memmove(void *dest, const void *src, size_t n);
 #define __HAVE_ARCH_MEMSCAN	/* inline & arch function */
 #define __HAVE_ARCH_STRCAT	/* inline & arch function */
 #define __HAVE_ARCH_STRCMP	/* arch function */
-#define __HAVE_ARCH_STRLCAT	/* arch function */
 #define __HAVE_ARCH_STRLEN	/* inline & arch function */
 #define __HAVE_ARCH_STRNCAT	/* arch function */
 #define __HAVE_ARCH_STRNLEN	/* inline & arch function */
@@ -38,7 +37,6 @@ void *memmove(void *dest, const void *src, size_t n);
 /* Prototypes for non-inlined arch strings functions. */
 int memcmp(const void *s1, const void *s2, size_t n);
 int strcmp(const char *s1, const char *s2);
-size_t strlcat(char *dest, const char *src, size_t n);
 char *strncat(char *dest, const char *src, size_t n);
 char *strstr(const char *s1, const char *s2);
 #endif /* !defined(CONFIG_KASAN) && !defined(CONFIG_KMSAN) */
diff --git a/arch/s390/lib/string.c b/arch/s390/lib/string.c
index 757f58960198..a48e5bb3c15f 100644
--- a/arch/s390/lib/string.c
+++ b/arch/s390/lib/string.c
@@ -104,32 +104,6 @@ char *strcat(char *dest, const char *src)
 EXPORT_SYMBOL(strcat);
 #endif
 
-/**
- * strlcat - Append a length-limited, %NUL-terminated string to another
- * @dest: The string to be appended to
- * @src: The string to append to it
- * @n: The size of the destination buffer.
- */
-#ifdef __HAVE_ARCH_STRLCAT
-size_t strlcat(char *dest, const char *src, size_t n)
-{
-	size_t dsize = __strend(dest) - dest;
-	size_t len = __strend(src) - src;
-	size_t res = dsize + len;
-
-	if (dsize < n) {
-		dest += dsize;
-		n -= dsize;
-		if (len >= n)
-			len = n - 1;
-		dest[len] = '\0';
-		memcpy(dest, src, len);
-	}
-	return res;
-}
-EXPORT_SYMBOL(strlcat);
-#endif
-
 /**
  * strncat - Append a length-limited, %NUL-terminated string to another
  * @dest: The string to be appended to
-- 
2.51.0

