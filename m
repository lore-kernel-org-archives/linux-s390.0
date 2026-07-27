Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78805392C3C;
	Mon, 27 Jul 2026 16:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785170859; cv=none; b=KxQagi6/3MGUiAItfRuvt2dsNkf/pFZo/ZhV+Kwkmn9T+aSId2NHXBqFS5EvutsTQdbJrK8wS71DYZIqcsf1lnDotNQkij+3vSNfI7Q7fZFUj24XgmekpdBB3DtU2xvt/FxP11BC9/3WzKjuvGapL4Vhg1y+lmmTA/jF/8aZt08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785170859; c=relaxed/simple;
	bh=kr5/GO6I43+Mwevkuvj0Hosq0uJDwGHD3NmsFix3/5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0fi0DJsiY7tkLM8kuJj3pzsO9nk0X5XdOUIa2YttzJ5njRMd6oLDKAlECA8HhEPUMLweY0COUj6LfZyQakk+/1lrfiyTMUfpfFXkJ6q2rtGszGgYEDvaBxngGQBSjgmDfHg4+b53EuUZ3rld4irzFMjNk6FmKm/s0k7PrusP2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WYyJIS4c; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WYyJIS4c"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDnDWX2374341;
	Mon, 27 Jul 2026 16:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=mx3MdLelknP3v+1yP
	oJwCJB+bdzjS9fssNeam631qw8=; b=WYyJIS4c7mkku0bJiBEXbEYJfxtWV80sj
	kJB6Du7rACHY45S3ecX37p3q1FDrtWO1f6p8AePDFhDhr6evVzLycMu4tbPMFI8B
	Zl1uUloWROXGvleOUHDNc1yDdmLXzfGib8fxwQqLqgivuc1k8M36kPkhOq9mvb8m
	SLwZ5JKx+uPVK/48MxCQ9o9olAD7E9eW//8Ksc1jwXOt+XI1F+6S4phyWqBbLkoj
	YqsiKrUWLkQq8ywh+ZZWWcBPC+6N/UlytIjWM713TnSKJixqkqnvLdBQELh6Ymyz
	3qAQ4yfAvhLU5HR/MbihGb2F55vnlYl2FU/kPb2ABJVqWPVzC64rA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw793cx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 16:47:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RGfEgQ003844;
	Mon, 27 Jul 2026 16:47:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fq6b3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 16:47:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RGlMH812648888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 16:47:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A5A82024D;
	Mon, 27 Jul 2026 16:24:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EE1D20249;
	Mon, 27 Jul 2026 16:24:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 16:24:31 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] s390/cio: Remove cond_resched() calls
Date: Mon, 27 Jul 2026 18:24:30 +0200
Message-ID: <20260727162430.1599396-5-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727162430.1599396-1-hca@linux.ibm.com>
References: <20260727162430.1599396-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Rnq__M6SAXDEOtEfjT9BdNEVZ4BHctSe
X-Proofpoint-ORIG-GUID: Rnq__M6SAXDEOtEfjT9BdNEVZ4BHctSe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE1MSBTYWx0ZWRfX4LAZzzWMczcy
 /X4o+GiSPZwzAD0lCoinE+xSYFiyHlh/RC7nHtKOyDt0iwKRwRRPSlfIYPAs1Golqhh6iZACK3n
 qALaLRXLEwRc2cZTRAqVQzg8fdE+W9+BKXo3uHMP2eXui5/c711MKhB3ENAQdeEW6vgK0mDwgaB
 h0w3glesQDe7HHKTX0wnYF0XUUArPmhzJdnUZIVj5mqBywGQ8BxQZbkOFOt87fbaacfJzkfo3eH
 yMAs2uL/F9xm/ATf6DwaL6H/NB2Gn74JwRfCrBtmlwf+ZuYBz2wzOn3Pr26WHgjPoKGY4L81pHQ
 TXuhOp+bZ2tN3lMT6Xy7/h6KWFCA25KJ33n3OFHC24ugSDMo0R8kUzD3gGbAv/p8mCqJCaVP9wE
 LXM+IvKJAbQ0VzRSUS630jIavIRqvyvVZbrRDMG3RT2v/eOblVu8selYapxy6Pk4fYOp3cHrwSo
 +o26N6QZlc67F6LSHVg==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a678b9f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=yDFob_ultygKJmZAZNUA:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE1MSBTYWx0ZWRfX5saB17z+b3pT
 /TVX+uLoH9pGz3focDjkQBgg1Xj6viZtw86l1YEd1aaxsSj5D2dp/EnVnuLAKAEXbq3NdPNCbl8
 ELOi19H7ii9iE7vIEcFh4wqwZ7jl/iI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270151

Since [1] cond_resched() is a no-op on s390. Remove all calls.

[1] commit 7dadeaa6e851 ("sched: Further restrict the preemption modes")

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 drivers/s390/cio/css.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index e5a0ec6b4e3e..54b8b8639694 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -618,11 +618,6 @@ static int slow_eval_known_fn(struct subchannel *sch, void *data)
 		rc = css_evaluate_known_subchannel(sch, 1);
 		if (rc == -EAGAIN)
 			css_schedule_eval(sch->schid);
-		/*
-		 * The loop might take long time for platforms with lots of
-		 * known devices. Allow scheduling here.
-		 */
-		cond_resched();
 	}
 	return 0;
 }
@@ -654,9 +649,6 @@ static int slow_eval_unknown_fn(struct subchannel_id schid, void *data)
 		default:
 			rc = 0;
 		}
-		/* Allow scheduling here since the containing loop might
-		 * take a while.  */
-		cond_resched();
 	}
 	return rc;
 }
-- 
2.53.0

