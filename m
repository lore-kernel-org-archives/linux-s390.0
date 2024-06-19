Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A8515EFBB;
	Wed, 19 Jun 2024 15:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811980; cv=none; b=XS72XQcFrrNiZBnMu94BXXi2H3B6RtxzkKT22xmaZQgmINtey6DPpRrmhfCS5+/UFTTVIVCEBcuEpFMKByyRG+ksDs0umkac1TLbHLub+tEaKRUGFHDWdZN2TNlb5Q99C8mWCtfYSS9EQIs8c8jmcJK0XxJVjw8Z/j7yvZaxGgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811980; c=relaxed/simple;
	bh=RGF9bEl9bOXMQlMuwc/oDRczFPJc3RfXUICjs8syEqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MRyfi/zuK5DiGZ78a0urDyBLlTdwiP9Wllf0+RYp308GeEQQgBI6O5xF/+BOIyGFDbQNSNPh+p6JYGH1/khJ8y9E8v7EgLKVZLjjS48FilhEDbnEH1EJR3QDcYXbBvnEtl1lU6i058o7Prp4cI1R52/ZZpYnvVFNU37V/C5W0h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gFFnuzcf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gFFnuzcf"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JFSJRr028077;
	Wed, 19 Jun 2024 15:45:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=s6DLbG1DAru59
	Tf4t+R8cAAAi/8gRk1lHndotnkU+E0=; b=gFFnuzcf7kU8Sw5RzDPSFq6QuKv4X
	PbK65O6XUs6FCGR25NktXyaG4rgzjV47hI0Lu/Uu1r/2Mg7Z3KEd5iG7E4MQbnaL
	cTGdy+8nkXMsX37RqMRdfZNyGoq87HteENCL4AXWXH9KWW+xVYPlbBUshnvRDzYM
	Vnz5v+zTFhyCE8kuNHWVsCkUx/i8QzaOcQknYQnZdRuqjy+YuLZOxSIIj5vckskY
	usJJvOvk4WYRAuInnIE+kQMhllmnhC5P4Cq2WD+C+K6PRdCOo7x7/NBdHgWsLjGa
	8MLnjr92FUDNCNAr3YL3hJPkH4Ro8pEiHeCtq8aPjzncnZM4dnnGyUxfg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yv20g81kv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 15:45:53 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45JFjrfB023106;
	Wed, 19 Jun 2024 15:45:53 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yv20g81kr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 15:45:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45JFhxiv023990;
	Wed, 19 Jun 2024 15:45:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ysp9qdyr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 15:45:51 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45JFjjt651249438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 15:45:47 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B283E2004D;
	Wed, 19 Jun 2024 15:45:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6378320071;
	Wed, 19 Jun 2024 15:45:45 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Jun 2024 15:45:45 +0000 (GMT)
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
Subject: [PATCH v5 34/37] s390/uaccess: Add the missing linux/instrumented.h #include
Date: Wed, 19 Jun 2024 17:44:09 +0200
Message-ID: <20240619154530.163232-35-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240619154530.163232-1-iii@linux.ibm.com>
References: <20240619154530.163232-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: x3IdliaCP9_W0APTwBxLUteBtiEkeKIa
X-Proofpoint-ORIG-GUID: eWk2j-5jOwTKPdqUCsgQlthFXyMgUyxL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0
 phishscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190115

uaccess.h uses instrument_get_user() and instrument_put_user(), which
are defined in linux/instrumented.h. Currently we get this header from
somewhere else by accident; prefer to be explicit about it and include
it directly.

Suggested-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/include/asm/uaccess.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
index 70f0edc00c2a..9213be0529ee 100644
--- a/arch/s390/include/asm/uaccess.h
+++ b/arch/s390/include/asm/uaccess.h
@@ -18,6 +18,7 @@
 #include <asm/extable.h>
 #include <asm/facility.h>
 #include <asm-generic/access_ok.h>
+#include <linux/instrumented.h>
 
 void debug_user_asce(int exit);
 
-- 
2.45.1

