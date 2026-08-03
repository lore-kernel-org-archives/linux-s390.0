Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3AB352002;
	Mon,  3 Aug 2026 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773380; cv=none; b=i8BsmMjUbu6zjvrkBQFwgJtS/MHp9JdCeIsU0Q0JQ8NHwnXWsgORW0NgDAT8o6+r/AaYSCQ8TNLLlmR7wxERCTydUZNEkpkiDIlRspxjhsdMFyRqnyxPdRPXdIKjkydbHlY036PBb2vel0H0CzOabNuNCg2Hof0ZgW240cnpEHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773380; c=relaxed/simple;
	bh=6lYi6tF2Bg5U5Y/qkVpf0jGfdrOqS9kqvyPSdJnNvY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V423ptK3GRLazoJzm+1YWE71Oh8/j1g+UiNXp1hwxwtRk38Po5BH2+yN2SSZ4f8qTxcfuuw6k07bnPbKGXKkIuryt9OqUFjg33GYIuyD9g5hGfN2yV95ETV/nuBP1syiiA9bCn7uRley7Wplqj2iyeJ95VW0EZgR4fvPAtkLG+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YiKZHDqD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YiKZHDqD"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EIun5417305;
	Mon, 3 Aug 2026 16:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8svJPFmn2KubzMSwZ
	b1RNO4SpVM9yaR2cZVEixTXBQU=; b=YiKZHDqDS8FWJSka8UbyD71hec+y/9Tbw
	HcP4nZ/LuoqrGJgS+k38B75fxsxBuL7jB6QiVDfHEGnVBAjxWQ5ttaXg8qA1zPQ+
	DytPOuzs3a1FiKu2YzljQftQxf4/W+ufyIVsVamZ1O5jgtgeWieCGI1sP/w8jxZz
	hUl2fwpqLdRC3N50TunYyC6meRuq9953J0OydyMUpuFzvvzugHg6atxG5ad0HDNC
	dno7Th2St4hPLnzrHuR8F5bHn3ChCNeRN8l7tXFQS7AlZDc+FRLffMNyvflnHiQi
	VjIIMBohSZkQ3cyxQUTJgMXb0FGSqTl5R6PtTWhgg1tF5B+aWIavw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqhp8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:09:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673FuHTb001201;
	Mon, 3 Aug 2026 16:09:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugvx8kn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:09:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673G9PIk32899496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 16:09:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5187E20040;
	Mon,  3 Aug 2026 16:09:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34F242004B;
	Mon,  3 Aug 2026 16:09:25 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 16:09:25 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 03/23] s390/vfio_ccw: Fix out of bounds check on CCW array
Date: Mon,  3 Aug 2026 18:09:04 +0200
Message-ID: <20260803160924.236807-4-imbrenda@linux.ibm.com>
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
X-Proofpoint-GUID: ZGr6sKNTL5a7wAbMsT95YzwUWSHTyn-4
X-Proofpoint-ORIG-GUID: ZGr6sKNTL5a7wAbMsT95YzwUWSHTyn-4
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX/uKrqus43b2n
 H04bYQFY/IrrsmVwWUG6Cmq0t3p0cm6U4PDJ7xk1RRAS3mhUO/k7SR0lElS/oASjOi5NnEzC58M
 4556Op45Xy3J0zW0NV5aRS26pkXKpWA=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a70bd3c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=A5C3NnK3Tz1osX5E1PIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX0wbK4dEpa0mW
 e4e/3JRFp/Lcz0KVHoCkiBIlCzOoI0bWYwkibbmfWhLuelzEJJ9u9w70p1EvSCUreDZ54yOzXsE
 eAIBqX2SYmbX4vfGJvXjBlknLeQH7d61mqE7BdfKKdUEp0IPQnvN9TP+UxPY0F0xFsxNhB+iCdX
 lnttP+xo7438y2B2bg00oHzwNBhvRvkgzm1e0K5eOw99W2lrp4ZtCk1a4NaXXhI7YClOuOEwlhM
 DIx+T3h+7QR0jbhHbXE9poXS5vqTjMywwb9wEgq9EOhADTl6fktKGuD5G1UZAloxD0CgeZayIw1
 DO44g5MTzbbir06RVGxXH59mu1rwEeKGdo+V/RTBzmir7RgNk0rcAjfmAdOYfwuI+2DUuAQMwWf
 5OFJJpaLgqCfkg0lpK6dEVvh2+zWkHj09IpaxiRtWP/GIqVBCA4oYJtMAPT/BsU9GAZhsZ78YTy
 1qnV6EpwgGJbLM6DQEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030141

From: Eric Farman <farman@linux.ibm.com>

The routine ccwchain_calc_length() counts the number of channel
command words (CCWs) that are chained together in a single channel
program, and rejects anything larger than CCWCHAIN_LEN_MAX (256) CCWs.

The loop itself is "do..while (count < 257)", and while the logic in
is_cpa_within_range() correctly adjusts between the 0-index array of
CCWs and the count of CCWs starting at 1, this means it would look
at a possible 257th CCW before ending the loop and (correctly)
returning an error.

Fix this by restructuring the loop to break as soon as 256 CCWs
(thus indexes 0-255) are examined, without looking at memory
outside the range.

Fixes: 0a19e61e6d4c ("vfio: ccw: introduce channel program interfaces")
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 1c2890d139c6..af632f9d5453 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -377,11 +377,9 @@ static void ccwchain_cda_free(struct ccwchain *chain, int idx)
 static int ccwchain_calc_length(u64 iova, struct channel_program *cp)
 {
 	struct ccw1 *ccw = cp->guest_cp;
-	int cnt = 0;
-
-	do {
-		cnt++;
+	int cnt;
 
+	for (cnt = 1; cnt <= CCWCHAIN_LEN_MAX; cnt++, ccw++) {
 		/*
 		 * We want to keep counting if the current CCW has the
 		 * command-chaining flag enabled, or if it is a TIC CCW
@@ -391,15 +389,10 @@ static int ccwchain_calc_length(u64 iova, struct channel_program *cp)
 		 * after the TIC, depending on the results of its operation.
 		 */
 		if (!ccw_is_chain(ccw) && !is_tic_within_range(ccw, iova, cnt))
-			break;
-
-		ccw++;
-	} while (cnt < CCWCHAIN_LEN_MAX + 1);
-
-	if (cnt == CCWCHAIN_LEN_MAX + 1)
-		cnt = -EINVAL;
+			return cnt;
+	}
 
-	return cnt;
+	return -EINVAL;
 }
 
 static int tic_target_chain_exists(struct ccw1 *tic, struct channel_program *cp)
-- 
2.55.0

