Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B734A12FB3C;
	Thu, 13 Jun 2024 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293213; cv=none; b=Gw3HhlUezngsuh7T12emu1IIrDOl1bo916nzMikNpBirEvnwSVreEEjafCT/h6srdMe1jacXtvuS6fL39ulOLf8/h3HvspyIru/cow2dc2YBG2IXEbl/pKI1G3MAUCDlLS099DNOJ/PGQNT77juqU2QjWLpJZM9JDLeC2APoLPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293213; c=relaxed/simple;
	bh=QPuum/+Rau0nYZ6zwxOhs2F1QSdgYsuFmGWgls91L6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZUoiOpt4Z2VGi0oiUwI89iykJ4XLZXAFOqykcTBtIfY3LLSB4H/WFTIGebTarr6nBgjVXjRAgmyrqtSfzfo8b1BKUDJbotRscpkGdkKdeHAn0hIUxJKaIhSNbAP/RfAiSsIT8J1vsS1+xJjfd8TnHL+Ju058M26RYwKqv3ibbnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GFn9rZgl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GFn9rZgl"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DEvpvJ025707;
	Thu, 13 Jun 2024 15:39:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=sbxyaH+wQYD9H
	EEyi0Dc48lc/ExEdomPXIQ5yBEz8ic=; b=GFn9rZglAWz6Tbhc+Rswn0jq0Y+nw
	7ja66a1d+f/H15onMutRG1KyrnC8ykQ2HdXvuQQfNI1Txd55XzzVbv5hFfA1RIwG
	JIOxTPZXDK/vjb3JmHob/F0EomCHu1MeQCHEi6O2S+Of7yZOXEpW3wcxn+9utY0b
	cB5cwHaqYuHh6yD/vtcZA3LyaZzPAE4sYOIzYd4hBt5I+YUVl0rmtnkCuXrurEOm
	fTqDBYA2mf+F4BosHh3gDt2NPyq8gZ+9B4PF8B2W+Uq+XKHJlzRyBlHGbt8iQWza
	ErS/BgNWegjC+Uzi7fsFaTO9fmZsbY/6KG2vMDKjYuYD1NFxcAePwzhNQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yqq4u2370-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 15:39:48 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45DFdm1e009655;
	Thu, 13 Jun 2024 15:39:48 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yqq4u236u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 15:39:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45DEfGBh028808;
	Thu, 13 Jun 2024 15:39:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yn1mus9fd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 15:39:47 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45DFdfdf43123134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 15:39:43 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6C9720043;
	Thu, 13 Jun 2024 15:39:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43C2E2004F;
	Thu, 13 Jun 2024 15:39:41 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Jun 2024 15:39:41 +0000 (GMT)
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
Subject: [PATCH v4 16/35] mm: slub: Unpoison the memchr_inv() return value
Date: Thu, 13 Jun 2024 17:34:18 +0200
Message-ID: <20240613153924.961511-17-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240613153924.961511-1-iii@linux.ibm.com>
References: <20240613153924.961511-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GHIorWSh7sK7NcZlcxQY6qZTqADL7ydS
X-Proofpoint-ORIG-GUID: Ac3hBXFJTla2Ds8gXEff7mGZc7quMkCQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_08,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130109

Even though the KMSAN warnings generated by memchr_inv() are suppressed
by metadata_access_enable(), its return value may still be poisoned.

The reason is that the last iteration of memchr_inv() returns
`*start != value ? start : NULL`, where *start is poisoned. Because of
this, somewhat counterintuitively, the shadow value computed by
visitSelectInst() is equal to `(uintptr_t)start`.

The intention behind guarding memchr_inv() behind
metadata_access_enable() is to touch poisoned metadata without
triggering KMSAN, so unpoison its return value.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 mm/slub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index a290f6c63e7b..b9101b2dc9aa 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1185,6 +1185,7 @@ static int check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
 	metadata_access_enable();
 	fault = memchr_inv(kasan_reset_tag(start), value, bytes);
 	metadata_access_disable();
+	kmsan_unpoison_memory(&fault, sizeof(fault));
 	if (!fault)
 		return 1;
 
@@ -1291,6 +1292,7 @@ static void slab_pad_check(struct kmem_cache *s, struct slab *slab)
 	metadata_access_enable();
 	fault = memchr_inv(kasan_reset_tag(pad), POISON_INUSE, remainder);
 	metadata_access_disable();
+	kmsan_unpoison_memory(&fault, sizeof(fault));
 	if (!fault)
 		return;
 	while (end > fault && end[-1] == POISON_INUSE)
-- 
2.45.1

