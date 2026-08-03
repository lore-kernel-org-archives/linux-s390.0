Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922AB3515DD;
	Mon,  3 Aug 2026 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773376; cv=none; b=d5p3K69P0shkno13X0YizUvKq2gLA6h2ZZbwe7dMBnEx9ZukubLzJokX7L7sszVkGitMaYvAB+upcYRtjA/IP7K/JXvJFSDiKXz1ElpXYiIpPbegZr7ZqeGNpvz2Hzi0ipjWYHErS/GIpsaVhCh8S3ryTKlF0HrPhbH7fGpsXLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773376; c=relaxed/simple;
	bh=gOV6Wx2AhbD9Jr9uiaRsxD+XpYNP98SCS/jFFhmlEjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cl/mamWJi37Nf4HE1aB/v/tKpEfRffcVd5LK/RHyJbzS+yKpcXzYQbzzpfRY6lveYRTCZThTRcETcPp7tnaU9LqyHk3oPdhNQpqeFajXzHTML7ISTisqKJ7Ar9ZpKGA/pV/o8lp9JRwkJaZARQACeHRRFlMSgpqA71XacpB3PL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kXOdq1Ic; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kXOdq1Ic"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EHVIr2282331;
	Mon, 3 Aug 2026 16:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NMCq2+tWsqwWAeYEm
	ulzlcOPU8wdUPHLycEZkgKEvwg=; b=kXOdq1Ic3nLOL0x59JK9hTjoaA2xSVfab
	X1LOhCGQj3Szf96Xhoj/ZB5oUn3oYypu/F5TZvyIPJume6uPa/p+sffCFag8dBiR
	72o2BNg5TKijA6HT25TR7LqGlsuwXAzjDtu7DYMcxyCT5IfWaTn3igKovY45IP02
	E5S/QbOxKQ6h2jI5tcSGq3+AZ9gq2c8WI7wwbAO6JA43BWL5K7n9Mr/Ugfv4QQc/
	47fDHhmKnFOE+mWLtxo6FmYddFpFRynYg6P43of8pyKPNyFX4mHw3Qd+qkebGtaT
	wWC5RWmCni5EBuCvcxDiyQVb78GELciIi8Xdta9nYUq81NqDzy0Aw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4sqew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:09:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673FuHE5026463;
	Mon, 3 Aug 2026 16:09:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qeatr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:09:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673G9P3b32899494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 16:09:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F99720043;
	Mon,  3 Aug 2026 16:09:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 156952004F;
	Mon,  3 Aug 2026 16:09:25 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 16:09:25 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 02/23] s390/vfio_ccw: Limit the number of channel program segments
Date: Mon,  3 Aug 2026 18:09:03 +0200
Message-ID: <20260803160924.236807-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803160924.236807-1-imbrenda@linux.ibm.com>
References: <20260803160924.236807-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfXwlcdDcnJ7R4o
 RPA/0Va5KzFaLkBRtWXTbuEx7al7eoTjAbfY5ixuL4tu95cyFuV0IYz+Bwyc9mm1Kpl+m0eahyV
 qh83wC+/RvDLQNILoMxoGmGBX4QWeJY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX1ZYgmBVLN4bg
 qMuN+j2jHSWq3BzXA8AUJhx/UmaLrZNQa7ahdPO0rbowLTQWKxH4PJIDxK1hXUbLaa40mDcccZx
 MFs6ZVe/DGEGC7VXr2HxCNiBZhxatUFwiPqK7DLoE8N0Z04SUzqqJPA8YTQiTrJCL8AwJzVD6w8
 u9Uktowq56zPd2fOR8KFIHcfX4gwDF3EL5wEziMW6E/MQvDd0qLNtJVfqEMe4nR9BsC9f50lX+/
 xtmradFN+JTvNolSl8Um0815S5yf0+yLIOA/Xx29Up4/OSTZk3Yugidb0nhEJzXOq7FSP08y/uO
 WjwEulHQMhV0gyIH6lJg77yM9XXJjS0waM2Yj2FzPwyOUcL6GjIJAtr7jlXLshzIoHWMU+6lhmi
 Lj82cxFdgZViSjoA/QkIalLSYKVPeiOic5DBUiizQN1vOVeYQcItxS6vFPZNssSenqtMr7aXcuT
 8Bt+F6Jmgwi09rcZMKg==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a70bd3c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=sBi1HX8ECoo2m5KYV-oA:9
X-Proofpoint-ORIG-GUID: xwxk5ca7tO1sDWsY3anJZWIwp7HcJshR
X-Proofpoint-GUID: xwxk5ca7tO1sDWsY3anJZWIwp7HcJshR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030141

From: Eric Farman <farman@linux.ibm.com>

The processing of channel programs, and the CCWs within them, is done
recursively. As such, there is an arbitrary (but not architectural)
limit to the number of CCWs that can exist in a single channel program.

The vfio-ccw logic breaks these channel programs into segments whenever
it encounters a Transfer-In-Channel (TIC) CCW, and the combined number
of segments count towards the global limit. Impose an equivalent limit
to the number of segments until such logic can be made non-recursive.

Fixes: 0a19e61e6d4c ("vfio: ccw: introduce channel program interfaces")
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 6 ++++++
 drivers/s390/cio/vfio_ccw_cp.h | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 086d1b54bdb0..1c2890d139c6 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -332,6 +332,7 @@ static struct ccwchain *ccwchain_alloc(struct channel_program *cp, int len)
 		goto out_err;
 
 	list_add_tail(&chain->next, &cp->ccwchain_list);
+	cp->ccwchain_count++;
 
 	return chain;
 
@@ -441,6 +442,10 @@ static int ccwchain_handle_ccw(dma32_t cda, struct channel_program *cp)
 	if (len < 0)
 		return len;
 
+	/* Limit number of chains in a single channel program */
+	if (cp->ccwchain_count >= CCWCHAIN_COUNT_MAX)
+		return -EINVAL;
+
 	/* Need alloc a new chain for this one. */
 	chain = ccwchain_alloc(cp, len);
 	if (!chain)
@@ -745,6 +750,7 @@ int cp_init(struct channel_program *cp, union orb *orb)
 			vdev->dev,
 			"Prefetching channel program even though prefetch not specified in ORB");
 
+	cp->ccwchain_count = 0;
 	INIT_LIST_HEAD(&cp->ccwchain_list);
 	memcpy(&cp->orb, orb, sizeof(*orb));
 
diff --git a/drivers/s390/cio/vfio_ccw_cp.h b/drivers/s390/cio/vfio_ccw_cp.h
index fc31eb699807..a9b1d8dbc6f6 100644
--- a/drivers/s390/cio/vfio_ccw_cp.h
+++ b/drivers/s390/cio/vfio_ccw_cp.h
@@ -23,11 +23,18 @@
  */
 #define CCWCHAIN_LEN_MAX	256
 
+/*
+ * Maximum number of chains
+ */
+#define CCWCHAIN_COUNT_MAX	16
+
 /**
  * struct channel_program - manage information for channel program
  * @ccwchain_list: list head of ccwchains
  * @orb: orb for the currently processed ssch request
  * @initialized: whether this instance is actually initialized
+ * @guest_cp: copy of guest channel program
+ * @ccwchain_count: number of channel program segments (linked by TIC)
  *
  * @ccwchain_list is the head of a ccwchain list, that contents the
  * translated result of the guest channel program that pointed out by
@@ -38,6 +45,7 @@ struct channel_program {
 	union orb orb;
 	bool initialized;
 	struct ccw1 *guest_cp;
+	unsigned int ccwchain_count;
 };
 
 int cp_init(struct channel_program *cp, union orb *orb);
-- 
2.55.0

