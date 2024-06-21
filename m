Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA7037708;
	Fri, 21 Jun 2024 00:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718929627; cv=none; b=VjrQAVNBvDGOibjO12LTSKvZjqL2kBU34DErYtmzLuL5yicXhxQjN7dPz47qpA/GblLJkFbj1h9bueeauDMvrOlks/xo8elntQ6b6uuAOVp9HyaeDLKLoleFB/jbf8+7HUGkcwwjCAmavU4V0ZYaWMQwP5tfi3oT8llTdlrCbnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718929627; c=relaxed/simple;
	bh=DjnBYAkSeWNAutmsdPv4tYSVpI/K4x9jy6LAmPbY7JE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GsqvxIjJowSCMTMbzuV/Cvmvd6FbM9uTLwHRxyGfZccfE49xXDvZp6MHeule3XNis5+jLGAj37HQvmscIBtoGJr5UBKesSq9ZhYKHub4gidOtmLDU7+nbLV/jArKmfUqO3I+7MZQ3Xbn8DpuqYj+R9yBb9USmPj6vvevbBHHdf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=foNfqk7y; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="foNfqk7y"
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L0LFt5001852;
	Fri, 21 Jun 2024 00:26:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=MbSV/0QgndyxP
	pucafkqjoUk93XB7CWZmEyrMAmxEI4=; b=foNfqk7y1VvRgjjR6LQgz5M9c0dP3
	6TKWNguBx6pHOxQ6q4DNRzUPqVk759skUQInYx8yOQ4Ye0nFTQZaFeEqTVRfp50O
	MFSX8NzG50bCmFGOVoUegiSpdAcWjvoHV1GGSjaYSsZndy4jn9tB+IfF/dBXvMHW
	L8/FLoV+NByHcJ37Vi+CNcCBIBozpV5XdjAGd4UWJSckIM/zdrLv7WuqSWsu3BWs
	5A9BdsA5QD1NJyvv8p7SvmA9c6mjwR1e8hmKLYWdXfTnAFk4DgAFABqg0p9i/IU0
	hfk70NVrCmwCQtUsd+cEmbnaZkxwFjFja0BP8XppJTTZA61nukIi5E36A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvvrdr8aq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:26:48 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45L0QlKR009504;
	Fri, 21 Jun 2024 00:26:47 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvvrdr8am-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:26:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45KLdx1d007675;
	Fri, 21 Jun 2024 00:26:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yvrspampe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:26:46 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45L0QeJQ29819576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 00:26:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C16962004B;
	Fri, 21 Jun 2024 00:26:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9ECF620043;
	Fri, 21 Jun 2024 00:26:39 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.10.44])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Jun 2024 00:26:39 +0000 (GMT)
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
Subject: [PATCH v6 17/39] mm: slub: Let KMSAN access metadata
Date: Fri, 21 Jun 2024 02:24:51 +0200
Message-ID: <20240621002616.40684-18-iii@linux.ibm.com>
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
X-Proofpoint-GUID: 1A4HKTza_ocuX6M60P_a4YFE-_n9G1yK
X-Proofpoint-ORIG-GUID: UxAe7IFBDVT7uND_PYXcw2RbRkIaNOQ-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_09,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406200174

Building the kernel with CONFIG_SLUB_DEBUG and CONFIG_KMSAN causes
KMSAN to complain about touching redzones in kfree().

Fix by extending the existing KASAN-related metadata_access_enable()
and metadata_access_disable() functions to KMSAN.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 mm/slub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index 1134091abac5..b050e528112c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -829,10 +829,12 @@ static int disable_higher_order_debug;
 static inline void metadata_access_enable(void)
 {
 	kasan_disable_current();
+	kmsan_disable_current();
 }
 
 static inline void metadata_access_disable(void)
 {
+	kmsan_enable_current();
 	kasan_enable_current();
 }
 
-- 
2.45.1

