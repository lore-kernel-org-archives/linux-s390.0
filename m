Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862344AC156
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 13:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440873; cv=none; b=GGv7RFc4DQSsUNvU7ssEHO2Xi1cYBkHHLbV3FGNeASXSdpgKBKx+I95cM40uZQV7UCQ+TSgwH33opQGykikylyoXjsEEV2qFgTKWxK/sCnAIOEJ0rarkWC7jCWJftdoKfLTG4jaJHXy5KntR/PZ0deuZgDyBFfnzjhGzHYLNcI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440873; c=relaxed/simple;
	bh=0TlZCCwbbmL1m9eVqBX4p6ZqUHmpi26rJ2lesIccUiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kG0nBklbvNDErj/X0u/kxHBNkObXSkDJWBlTuUMqf1qoD329nh9Gsi3VFYVEFv17vMPr/iav0UEDtqMDg66SVMZpFsOUxCRt+s60QM7hmJ4XPQtFJDeYYR8wFkYqF/7053diYn4AlmblGI6mHRVZN4KzJoLrq1laThCHg8NFtNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r6GSkD5Y; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r6GSkD5Y"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683AVjTQ2617806
	for <linux-s390@vger.kernel.org>; Thu, 3 Sep 2026 13:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=N0Oo7Wpwk4bnGH/ic
	1rk8kr5F39VSO2Zp8aeuMQ8gUM=; b=r6GSkD5YMMELH2S4sEudhM5Lew/62HKc3
	fr3AZ4ChZW7aRjeRpTVsacqfUfjU8HTVPw/Pl5glvQwbOLlDaS7yWaL8jyrVX2sN
	OL9D79aldhcujrWEsjG7XByPpv9pBL8MdZ3VTNGb9YZdacX7jt9UiEoTEIZeD/r9
	HFNGXfdd48AOj0YkPXk31H6F8uRWiIM2sjOQi13mIdHSc5EtVm11RNobymFC7LxO
	3Z1Rlw33cxc10S0QD8nk5BwPi6j/KkOp544z+xMCDZf3wq+VPyA7mGaQJKnYKspV
	VXAUmLA8NEbXjgHgN3V3OfmQrwx0sPR3NmBVjfDT9JmentVZ9/9ow==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuj4qkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 03 Sep 2026 13:07:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683CuHV8024960
	for <linux-s390@vger.kernel.org>; Thu, 3 Sep 2026 13:07:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8hqpp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 03 Sep 2026 13:07:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 683D7YFt26477258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 13:07:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 647E420040;
	Thu,  3 Sep 2026 13:07:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A17A2004D;
	Thu,  3 Sep 2026 13:07:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Sep 2026 13:07:34 +0000 (GMT)
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: [PATCH v3 2/3] s390/debug: Do not repeat parameter override notice on debug_set_level()
Date: Thu,  3 Sep 2026 15:07:32 +0200
Message-ID: <20260903130733.709001-3-zaslonko@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903130733.709001-1-zaslonko@linux.ibm.com>
References: <20260903130733.709001-1-zaslonko@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oMg-q-OH-7eKfxc7OY9cs8eh6UIzpFs_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDExMyBTYWx0ZWRfX5waBwJyxO557
 EmyiARZhTJfuWzj+NL7LEy9HjltsZl0JWnAcIbZhRWUUmUwM9R6W4nxuggfAlPmpWyb434v581d
 1BPHuv3LfD9CsrzrNJhSwG00u/zrNqG7kvte7RyvJf5aVRhmhUVpZu0/WjVQzeDv9gBkjj/gRCP
 4M/RgD5Xw1Xzi++AzMnZYz/+MomcRlK7xB6GFTFZ45smyRVBG8y1ndLU7TPF8qiUOQkuxpOqApf
 TdTT8bnsKXG6MTvxRwznZxT7omZVgCZ2YfVL/ZBdAfmVlQYEoj4i+pHghBcMcfW9sGN/710Lv+7
 nDQEsXdrEhC+9LDtpcmoX6Lu1Y9KM3tOxwpWx3ZCqFDr09/NSbObbkFiB2Ewq54ymWOvv8onWYX
 /rxmh4wPlYVUTFoU2s5S2jAqN2bzM78Z/YBRQttuq2lDICCZDXYy2sWXkTRSazTvnQO5wPaClZw
 phlzP5Y2wLLJ0r24uXg==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a99711b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=Uf4yk4d_HpTkD3D5FP0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDExMyBTYWx0ZWRfX7c8nmUYbCct2
 GihIzOBtF7IjYNwoPDaF12+2H3gzmCR8fEuXnQBp1hSKGoHiUTLxaSqTBQm9bks2ajDrZlb66tS
 EQtB7qsq92AcsAVx9sSsiMDZ8ORTY88=
X-Proofpoint-ORIG-GUID: oMg-q-OH-7eKfxc7OY9cs8eh6UIzpFs_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030113

Commit a2cec6863709 ("s390/debug: Add s390dbf kernel parameter") calls
debug_get_param() from both debug_info_create() and debug_set_level().
Since debug_get_param() emits the override notice unconditionally, and
drivers typically call debug_set_level() right after debug_register(),
the same line is printed twice per debug area:

  s390dbf: 0.0.1234: override level to 6
  s390dbf: 0.0.1234: override level to 6

For areas registered per device this is multiplied by the device count.
With 's390dbf=0.0.*:6' a system with many DASDs emits a large number of
redundant lines during boot.

Add a quiet parameter to debug_get_param() and pass quiet=true from
debug_set_level(), where the override has already been announced during
registration. The remaining callers keep printing the notice.

Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
---
 arch/s390/kernel/debug.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index e06abf1dbc21..cf411f203571 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -182,7 +182,7 @@ static struct debug_param_t {
 static int debug_param_num;
 
 /* functions */
-static void debug_get_param(const char *name, int *level, int *pages)
+static void debug_get_param(const char *name, int *level, int *pages, bool quiet)
 {
 	struct debug_param_t *p;
 	int i;
@@ -192,11 +192,13 @@ static void debug_get_param(const char *name, int *level, int *pages)
 		if (!glob_match(p->name, name))
 			continue;
 		if (level && p->level != PARAM_UNSET) {
-			pr_info("%s: override level to %d\n", name, p->level);
+			if (!quiet)
+				pr_info("%s: override level to %d\n", name, p->level);
 			*level = p->level;
 		}
 		if (pages && p->pages != PARAM_UNSET) {
-			pr_info("%s: override pages to %d\n", name, p->pages);
+			if (!quiet)
+				pr_info("%s: override pages to %d\n", name, p->pages);
 			*pages = p->pages;
 		}
 	}
@@ -251,7 +253,7 @@ static int __init s390dbf_parse(char *arg)
 	 * regular memory allocations are possible.
 	 */
 	for (i = 0, id = __s390dbf_info; &id[i] < __s390dbf_info_end; i++)
-		debug_get_param(id[i]->name, &id[i]->level, NULL);
+		debug_get_param(id[i]->name, &id[i]->level, NULL, false);
 
 	return rc;
 }
@@ -395,7 +397,7 @@ static debug_info_t *debug_info_create(const char *name, int pages_per_area,
 	int level = DEBUG_DEFAULT_LEVEL;
 	debug_info_t *rc;
 
-	debug_get_param(name, &level, &pages_per_area);
+	debug_get_param(name, &level, &pages_per_area, false);
 	rc = debug_info_alloc(name, pages_per_area, nr_areas, buf_size, level, ALL_AREAS);
 	if (!rc)
 		goto out;
@@ -960,7 +962,7 @@ void debug_register_static(debug_info_t *id, int pages_per_area, int nr_areas)
 		return;
 	}
 
-	debug_get_param(id->name, &id->level, &pages_per_area);
+	debug_get_param(id->name, &id->level, &pages_per_area, false);
 	copy = debug_info_alloc("", pages_per_area, nr_areas, id->buf_size,
 				id->level, ALL_AREAS);
 	if (!copy) {
@@ -1101,8 +1103,11 @@ void debug_set_level(debug_info_t *id, int new_level)
 	if (!id)
 		return;
 
-	/* Level specified via kernel parameter takes precedence */
-	debug_get_param(id->name, &new_level, NULL);
+	/*
+	 * Level specified via kernel parameter takes precedence. The override
+	 * was already announced during registration, so stay quiet here.
+	 */
+	debug_get_param(id->name, &new_level, NULL, true);
 
 	_debug_set_level(id, new_level);
 }
-- 
2.55.0

