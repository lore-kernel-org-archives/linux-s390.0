Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA754A0C;
	Fri, 21 Jun 2024 00:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718929621; cv=none; b=QFDpfZPlK2OBhE8Xz36wJZS9TLoWGhurk7R2OnaBB+CTkWVSVCv8HhbfMgMzvTS+8DB6YZL4p0m8i1TVCQz3bv99BV3hlx3C6gcotBmB5zgBE1Jx32QYR/OTM3F6urV8ufo30ym/80pTasMeumZ6sUajkuKo43lKB00AyJi8980=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718929621; c=relaxed/simple;
	bh=cXejuEluh+BjX1Ar6e5P4JKZqCjqJdrKYUKKBgQTaXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UyI3jAhnIkN3DZ86zQhQkFmoajM8N8zfNdJ2pFx7bszHLUrScch6v7hKhLhdx459TND1qoUDkw3FY68rRZa3kb/whEHN61usHapYSdnvQbI0hzZv/9dynvtxMwMGrItIjUI+0aSEV2IQsmW/cM4X5QOwTrDz4UWKlVocBWopjiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ggoX2Pks; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ggoX2Pks"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KNufV2003803;
	Fri, 21 Jun 2024 00:26:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=ah4xfVCHNViAS
	Zu9OS8C5bCxAH6NMTO/t1qMSUm0DA8=; b=ggoX2Pksfiz39yEC7CqMLNdghd9Hn
	9tk6/wM+ZTr+PWsNNhjk8GfhsFSoXmUNFgXY1Xy6bjwqkPRm+iEznu7EHCm6MB/p
	wrnUqOBjxcLWYR6WAGKk6J3IOywsQQHYcfS59dbF4QKvHybe+gB4SPJKOg5BfGeq
	fx9HIpiiw7TpOyGWn6n0KZjNHLDw74t0ndJ0f7VMZuQgIl2qQU/QGZ6i49oxdaQi
	lE1bBtPu/E5lvQdv6SBQjbjoh5B2QR7H81QsnrUkEGR8Tz76l8oWM568UOFpCIOG
	KFqMboyLbYmwQZbYkG/MmA2l9nVPvwkSHf2WdrLggThRRvrizJEiwO3Gw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvvrr07sx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:26:39 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45L0Qc7G016947;
	Fri, 21 Jun 2024 00:26:38 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvvrr07st-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:26:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45L0FLa7019941;
	Fri, 21 Jun 2024 00:26:38 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yvrqujnwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:26:37 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45L0QWMu51053006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 00:26:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32A8A2004B;
	Fri, 21 Jun 2024 00:26:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 144C620040;
	Fri, 21 Jun 2024 00:26:31 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.10.44])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Jun 2024 00:26:30 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@suse.cz>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v6 10/39] kmsan: Export panic_on_kmsan
Date: Fri, 21 Jun 2024 02:24:44 +0200
Message-ID: <20240621002616.40684-11-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240621002616.40684-1-iii@linux.ibm.com>
References: <20240621002616.40684-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -Q14BQ2YT5_Te4RHh-dfpK1esFV--JR1
X-Proofpoint-ORIG-GUID: WQTMj1N_z0nQDf3HOEeVuLpEFkVxIMQc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_11,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210001

When building the kmsan test as a module, modpost fails with the
following error message:

    ERROR: modpost: "panic_on_kmsan" [mm/kmsan/kmsan_test.ko] undefined!

Export panic_on_kmsan in order to improve the KMSAN usability for
modules.

Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 mm/kmsan/report.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/kmsan/report.c b/mm/kmsan/report.c
index 02736ec757f2..c79d3b0d2d0d 100644
--- a/mm/kmsan/report.c
+++ b/mm/kmsan/report.c
@@ -20,6 +20,7 @@ static DEFINE_RAW_SPINLOCK(kmsan_report_lock);
 /* Protected by kmsan_report_lock */
 static char report_local_descr[DESCR_SIZE];
 int panic_on_kmsan __read_mostly;
+EXPORT_SYMBOL_GPL(panic_on_kmsan);
 
 #ifdef MODULE_PARAM_PREFIX
 #undef MODULE_PARAM_PREFIX
-- 
2.45.1

