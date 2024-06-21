Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8562F10F2;
	Fri, 21 Jun 2024 00:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718929620; cv=none; b=jPUgsrlchXAi/yKYrZiDQfxdt7YWXJluzPu58IbqCmHvDePabd1ebrDnWlHe1NZprZQ+i+fqVlBlCM6IO9esvp5t5dA4eAafVXOWrK22zAQK24ldqis8Dha4+SB6CxKNd9ozpVKxpU5gF8ML+ojFirgmZl7PtaE245FnClo9QXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718929620; c=relaxed/simple;
	bh=NXZcvOEnxUr1dkE9zrg8KiNNlIismJj85YQ/p8KMwMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHUejKka/CZ3aeiPrfYOf57wzJ0GFjm1CNpmsN315xoOK9SU/l+yNsSqYlVe3XdJEEW/3nr0g81xtEYb9ZaXPymvvFG7TtV6ZXmrRK7fMKM/U4IHYYnZ/LgS8Yr60DiCQsQvJZc+lOh2lbXrg+qEuXUnTzOE3OkbPtBAxr1N5pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cp3Nojk1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cp3Nojk1"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KNQmMG030138;
	Fri, 21 Jun 2024 00:26:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=v73BMs0EqfMCw
	xJniJdo3jdaknlggr5A1qJ50X9w6PM=; b=cp3Nojk1uyr3q45Jorn3+mo7AmkBK
	xgsssvQ8/9waypfqg5z6JkN2pTEwH5EetvwvyhaQlEptRVmHru1UjRK8rlS8IuD5
	CmnNUOKdSUD9f43mww/aZQEaMVXA0jQwz+SSgAtnHsBmm1VbwQAiCp1iGkoKyT60
	seuk1dNYfqHVgusVyGL6vqiwBtQ9XPStCNRfeTuspNeVzGBekM4SFP3OgKbdHy3e
	tYu1lJHv/9RjD4i8sfpWATWoq3UoKVu8WiGcTvytE7zyNWza+x/sjyZX+hxmHdd9
	RKQqEjy27YAmPC7VUGqFDOLLmP79AYzl+PrdDoTo8dS4BPKBd7wDe6tOw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvw8c06yn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:26:29 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45L0QQwd022515;
	Fri, 21 Jun 2024 00:26:29 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvw8c06ye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:26:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45KLdxwq007658;
	Fri, 21 Jun 2024 00:26:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yvrspamn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 00:26:27 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45L0QMWn49742080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 00:26:24 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DBD22004B;
	Fri, 21 Jun 2024 00:26:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A5792004D;
	Fri, 21 Jun 2024 00:26:21 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.10.44])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Jun 2024 00:26:21 +0000 (GMT)
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
Subject: [PATCH v6 02/39] kmsan: Make the tests compatible with kmsan.panic=1
Date: Fri, 21 Jun 2024 02:24:36 +0200
Message-ID: <20240621002616.40684-3-iii@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: PiMadrv0_ZCFAt1YGkJeTR4kAUvMQsGB
X-Proofpoint-GUID: FRW7TOOkANa6sIxj3Ucz5e72WDq6F4rz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_11,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 clxscore=1015 adultscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210001

It's useful to have both tests and kmsan.panic=1 during development,
but right now the warnings, that the tests cause, lead to kernel
panics.

Temporarily set kmsan.panic=0 for the duration of the KMSAN testing.

Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 mm/kmsan/kmsan_test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
index 07d3a3a5a9c5..9bfd11674fe3 100644
--- a/mm/kmsan/kmsan_test.c
+++ b/mm/kmsan/kmsan_test.c
@@ -659,9 +659,13 @@ static void test_exit(struct kunit *test)
 {
 }
 
+static int orig_panic_on_kmsan;
+
 static int kmsan_suite_init(struct kunit_suite *suite)
 {
 	register_trace_console(probe_console, NULL);
+	orig_panic_on_kmsan = panic_on_kmsan;
+	panic_on_kmsan = 0;
 	return 0;
 }
 
@@ -669,6 +673,7 @@ static void kmsan_suite_exit(struct kunit_suite *suite)
 {
 	unregister_trace_console(probe_console, NULL);
 	tracepoint_synchronize_unregister();
+	panic_on_kmsan = orig_panic_on_kmsan;
 }
 
 static struct kunit_suite kmsan_test_suite = {
-- 
2.45.1

