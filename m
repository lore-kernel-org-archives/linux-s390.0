Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DDF4AC16D
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 13:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440884; cv=none; b=TO4K/9rIVTFgYSR7Ae7mCxSlilUw2wlljCtUcMD0dDhInLQL+MQUwpH7GtppVfk2jFEo3aWhwu1eA+54wGzcUamLRQXhwpIT7UbwnxqO4E4DtQqLkqQbtU+AgmF5WTlC8VVGZDwxOu8VpaX0cwDEIbgZplWYQM0p8GupTsb32SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440884; c=relaxed/simple;
	bh=xUCAbF/XWoPDp5HAogpU5l7uo5W3QrMRyrm/DMLx3qI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ni2ISmeWjdanIpTgv/veCsi/31ZwKLqwNG0lipo45Jv+zd/EzT2OrcoeBaHs8TID0K5zA18lupxyCqR1GIn/IJhuFOjxtrbBufpsEMG5qfN32XbzMW9RXNnf4D9LSxnzcV9+k6uI6LjtpOfTyxTAPG8AEWtJqD2dQ00U/yJa36k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P7yKLJph; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P7yKLJph"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683AVeB11606233
	for <linux-s390@vger.kernel.org>; Thu, 3 Sep 2026 13:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wQF3Lx4uFJd2xZlhu
	ozTdN2HRn3o+k9BkC21KQgyso8=; b=P7yKLJphV4L72iDRsEosZ5Ri0crUaZJe+
	PoYW2FogxomRDo5q4YsRlu7iAFBrnGzubGmXVaONT7tWTCkuXRJ2+D1LTlMP9g0N
	hAjoEjvVfmaLNtEdc5Kr0XhLqGRu7Y/lhaQ9729s/rhnQ+QndTAxOhlHt+TDEvFM
	OgS4n6PQHxfGWL75RlYWfNGsxflAUe5XN5hr4jfn+uQuOWKyw9vV74skUPM6nNnA
	qKstFJLuI9uPNZJb0hbeWQa+ntap5544AgxhAQC3+ZuSi7H1E08SGkCat8YGMl31
	HzjU7Rf/3brgqf5dSsujWvmJCMysD1VPzw0e+K5Jwq2E9VTEyEW/A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnue4k4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 03 Sep 2026 13:07:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683CuRoG015393
	for <linux-s390@vger.kernel.org>; Thu, 3 Sep 2026 13:07:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rqqx26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 03 Sep 2026 13:07:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 683D7YLY26477260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 13:07:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 829A920043;
	Thu,  3 Sep 2026 13:07:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 683432004B;
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
Subject: [PATCH v3 3/3] s390/debug: Fix race between debug area resize and event logging
Date: Thu,  3 Sep 2026 15:07:33 +0200
Message-ID: <20260903130733.709001-4-zaslonko@linux.ibm.com>
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
X-Proofpoint-GUID: ITBxHuFoQ5BB6Ghp1BDFernTzurzl6zA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDExMyBTYWx0ZWRfX3FzuT9u1STKA
 XZlbtzKheKfCgphd5M6InXHvjia8EjExRnY+tbF/XtB81CSBwhQPz5/MxckmVyrJqdAAfQMS1Rp
 UPS5bHRGmUrkrabkmm+SlJ5GAA1frQWmywWlxDv6/ZK9F2MDX/65RI4KtJNaveV9mCz7oOuOdKr
 ZxBCOpINo3913dkbVLdto4QFM6GP5ePG3p9P+g/pxEIeskDjvw2vBslw3LD4mgcjZrsGwhNh2ql
 tJyPrG9O3ReZUYzQXQkalbfm+fMTsXwvJJxzZaRwDNLV7S3BOEhKVq44w6D0wQR9qRGHrGc6KFh
 zxcQj/duqCCOF8/9X1WgKIfq72WR0xV6eZQhiimoHim/lTcFSde4kx+uloeIcI/1U56UQ72100r
 SHf4OTNETpuFXG4LJWPzP/il7LoQnrXGVZdmNpBjyQUc/ah99cjStCrF2JgXvfDMc1wAJEWFToA
 ryW7uoJ7wAhUoHhSuCg==
X-Proofpoint-ORIG-GUID: ITBxHuFoQ5BB6Ghp1BDFernTzurzl6zA
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDExMyBTYWx0ZWRfX/+ujYW4LAkkK
 GzEqWR09P3eKIRcmqToGffhN9DdfnmA9vXNXddZOvoT2b8oG2xqYWkc0bixXgGwVMs5FNgeENWT
 gBlfCMQIKlF83TJWjuGudBCmBnQpUUY=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a99711b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=sHLu9uPjF0jMMvyWv9sA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030113

Trace functions check for non-NULL id->areas without lock to minimize
overhead. This opens a race window where a NULL pointer dereference
occurs if id->areas is set to NULL (e.g. via echo 0 > ../pages) after
the check and before id->lock is taken.

Fix this by rechecking id->areas under lock.

Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
---
 arch/s390/kernel/debug.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index cf411f203571..b5bf8284dbfc 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -1283,7 +1283,7 @@ void debug_set_critical(void)
 debug_entry_t *debug_event_common(debug_info_t *id, int level, const void *buf,
 				  int len)
 {
-	debug_entry_t *active;
+	debug_entry_t *active = NULL;
 	unsigned long flags;
 
 	if (!debug_active || !id->areas)
@@ -1294,6 +1294,8 @@ debug_entry_t *debug_event_common(debug_info_t *id, int level, const void *buf,
 	} else {
 		raw_spin_lock_irqsave(&id->lock, flags);
 	}
+	if (!id->areas)
+		goto out;
 	do {
 		active = get_active_entry(id);
 		memcpy(DEBUG_DATA(active), buf, min(len, id->buf_size));
@@ -1303,7 +1305,7 @@ debug_entry_t *debug_event_common(debug_info_t *id, int level, const void *buf,
 		len -= id->buf_size;
 		buf += id->buf_size;
 	} while (len > 0);
-
+out:
 	raw_spin_unlock_irqrestore(&id->lock, flags);
 	return active;
 }
@@ -1316,7 +1318,7 @@ EXPORT_SYMBOL(debug_event_common);
 debug_entry_t *debug_exception_common(debug_info_t *id, int level,
 				      const void *buf, int len)
 {
-	debug_entry_t *active;
+	debug_entry_t *active = NULL;
 	unsigned long flags;
 
 	if (!debug_active || !id->areas)
@@ -1327,6 +1329,8 @@ debug_entry_t *debug_exception_common(debug_info_t *id, int level,
 	} else {
 		raw_spin_lock_irqsave(&id->lock, flags);
 	}
+	if (!id->areas)
+		goto out;
 	do {
 		active = get_active_entry(id);
 		memcpy(DEBUG_DATA(active), buf, min(len, id->buf_size));
@@ -1336,7 +1340,7 @@ debug_entry_t *debug_exception_common(debug_info_t *id, int level,
 		len -= id->buf_size;
 		buf += id->buf_size;
 	} while (len > 0);
-
+out:
 	raw_spin_unlock_irqrestore(&id->lock, flags);
 	return active;
 }
@@ -1362,7 +1366,7 @@ static inline int debug_count_numargs(char *string)
 debug_entry_t *__debug_sprintf_event(debug_info_t *id, int level, char *string, ...)
 {
 	debug_sprintf_entry_t *curr_event;
-	debug_entry_t *active;
+	debug_entry_t *active = NULL;
 	unsigned long flags;
 	int numargs, idx;
 	va_list ap;
@@ -1377,6 +1381,8 @@ debug_entry_t *__debug_sprintf_event(debug_info_t *id, int level, char *string,
 	} else {
 		raw_spin_lock_irqsave(&id->lock, flags);
 	}
+	if (!id->areas)
+		goto out;
 	active = get_active_entry(id);
 	curr_event = (debug_sprintf_entry_t *) DEBUG_DATA(active);
 	va_start(ap, string);
@@ -1385,6 +1391,7 @@ debug_entry_t *__debug_sprintf_event(debug_info_t *id, int level, char *string,
 		curr_event->args[idx] = va_arg(ap, long);
 	va_end(ap);
 	debug_finish_entry(id, active, level, 0);
+out:
 	raw_spin_unlock_irqrestore(&id->lock, flags);
 
 	return active;
@@ -1397,7 +1404,7 @@ EXPORT_SYMBOL(__debug_sprintf_event);
 debug_entry_t *__debug_sprintf_exception(debug_info_t *id, int level, char *string, ...)
 {
 	debug_sprintf_entry_t *curr_event;
-	debug_entry_t *active;
+	debug_entry_t *active = NULL;
 	unsigned long flags;
 	int numargs, idx;
 	va_list ap;
@@ -1413,6 +1420,8 @@ debug_entry_t *__debug_sprintf_exception(debug_info_t *id, int level, char *stri
 	} else {
 		raw_spin_lock_irqsave(&id->lock, flags);
 	}
+	if (!id->areas)
+		goto out;
 	active = get_active_entry(id);
 	curr_event = (debug_sprintf_entry_t *)DEBUG_DATA(active);
 	va_start(ap, string);
@@ -1421,6 +1430,7 @@ debug_entry_t *__debug_sprintf_exception(debug_info_t *id, int level, char *stri
 		curr_event->args[idx] = va_arg(ap, long);
 	va_end(ap);
 	debug_finish_entry(id, active, level, 1);
+out:
 	raw_spin_unlock_irqrestore(&id->lock, flags);
 
 	return active;
@@ -1663,9 +1673,11 @@ static void debug_flush(debug_info_t *id, int area)
 	unsigned long flags;
 	int i, j;
 
-	if (!id || !id->areas)
+	if (!id)
 		return;
 	raw_spin_lock_irqsave(&id->lock, flags);
+	if (!id->areas)
+		goto out;
 	if (area == DEBUG_FLUSH_ALL) {
 		id->active_area = 0;
 		memset(id->active_entries, 0, id->nr_areas * sizeof(int));
@@ -1680,6 +1692,7 @@ static void debug_flush(debug_info_t *id, int area)
 		for (i = 0; i < id->pages_per_area; i++)
 			memset(id->areas[area][i], 0, PAGE_SIZE);
 	}
+out:
 	raw_spin_unlock_irqrestore(&id->lock, flags);
 }
 
-- 
2.55.0

