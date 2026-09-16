Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF894F6469;
	Wed, 16 Sep 2026 13:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789564945; cv=none; b=qSzH6hfKMJEaqZpBl7PpCWhL+rih6FSfTSkDAVq+pGE66yphHN310eGq0S2zLYoYCT1KkoYIX+QMUtSce5SJ0BMLl/dgnK9PiPXxCpyQ1zVIAUsH4A5txmmCw9dAwLZuKq/lmTEHNDrLyPl++7p/nM0klox0t07Tt9YmNMdEAv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789564945; c=relaxed/simple;
	bh=tyXBv/ktYjbJt+dv+PJO6PzGdQvZ4YLO63q7qyqRd38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CiFebE+fwCPpWcOAMbpEmmZ04nSH/zv6v/5T9KoHXbTuGaxENGVP/dIkAfNfx3t8huD8AsSEAnV0OnS32vTLKbaxtwH6Go0vk4+GOfvsYRw576/lvoidwj4hBD/0dm0GaoB/6T/xuljyeRupId4mHpdrq+Y9PQFxZV3j0y3Mo+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ToySopMt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ToySopMt"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GCVhmx1882538;
	Wed, 16 Sep 2026 13:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LxnGU5zy8vm3KBXgD
	+dvszvZxK+B0vPtl2ErdV79rZA=; b=ToySopMti0ukfDChxdJ2F1qZP7Y4G16RJ
	47fP5xlGFaxqlXkb370CeD2ZYPfCzoMSEHEXnguKrnoFIFnK4abGiEfslY3yPV5o
	oVAz+8OdDQzidIj/0jdfviM+spZeMC21uKeDdDVdcvdIRf4GjmEz0jd2MjyM4E4v
	hjwIO1T6l8NWAUKNpXcpPDSiDYshT4hZOoGQ/8FNAgOHK94fulXmTP/ImZNg5BHo
	NW+Z7X52Yqk0JNOehiYLMIwN6EgcIRVQRvEr27AR1AWRF4docgvLoFBYLeHN+T2n
	Hl0+WGzRDZtMAfsgljCYoT73HceT9D8cOSpG2KwEZrQ48mxZKnhiA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdqcpve-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 13:22:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68GCZInG2376627;
	Wed, 16 Sep 2026 13:22:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gpw6d71ns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 13:22:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68GDM2E645154746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 13:22:03 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE5E32004B;
	Wed, 16 Sep 2026 13:22:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8967120040;
	Wed, 16 Sep 2026 13:22:02 +0000 (GMT)
Received: from t83lp71.lnxne.boe (unknown [9.87.84.240])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Sep 2026 13:22:02 +0000 (GMT)
From: Nagamani PV <nagamani@linux.ibm.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc: wintera@linux.ibm.com, aswin@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, kees@kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, Nagamani PV <nagamani@linux.ibm.com>,
        stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net v2 2/2] s390/ctcm: Fix use-after-free in channel_remove()
Date: Wed, 16 Sep 2026 15:21:49 +0200
Message-ID: <20260916132149.4185912-3-nagamani@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916132149.4185912-1-nagamani@linux.ibm.com>
References: <20260907144511.3810194-1-nagamani@linux.ibm.com>
 <20260916132149.4185912-1-nagamani@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE3NCBTYWx0ZWRfX5GfdOOnBZtzh
 NDGFi9u6wHWBkhPgIU8Jr6ey71HDV7dJ7/1uArG9+1bjIGwBhNglN484K2WQxx+EhG+h5wL9tHG
 Pk1UXgwMvZvSd9OG+jV1EWPFiNdmkbo3XDwDMtURVCL/gk1ISKQ7vQPNQmv/pMGWfmmTjrCI92d
 fegNhCjHPi+MGZcxJtD1YQwFp57fm8EWUAkQGKpmk719T+tBjfeRfkImO3s11xiBce9knpNSvDA
 V+7oJEQHihlyPyGBAvpxfoTbQLMsPS6y8OGF0Qt+aBcu6WY4/a0sUhHS1JWH/Ncc1IdafYJsk3u
 OMIxc9R8k5CwLTmvHiFi26fGDpNfdIt+07H6SQeOQZFl1VkGBSARZOSFPNFMCbg8pk1ofDEeI5F
 96X0Z6xqVg95Llao+yfSc9YWJ9UMDK4DmykS8edr9zGAyqVHx9b1zZNcmprHlx/bkk55r5iN1EX
 ND1iMlhroQviXIOw7mw==
X-Proofpoint-GUID: ts1csgUY5ESGtZPaXa5PB3U-Fk06qYN6
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aaa97ff cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=c92rfblmAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=lm3vwLJbPXUmvxTiMesA:9 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: BcD1n5l4LtNLdzjQbQuzzidkCX-Ot8wa
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE3NCBTYWx0ZWRfX9kPa5Al+JpwG
 Nc7gZwxcfxNplSlEl3wjBEvA4Jfx+dW1nodNFtYeCQRMKN514Spo9izl6zmbiPIqgvDD4Pbn790
 e1jWvXDouXyEA/YE8suwmR2n92qrW9M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_02,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160174

channel_remove() calls fsm_deltimer() which internally uses
timer_delete(), then immediately frees the channel structure:

  fsm_deltimer(&ch->timer);
  kfree_fsm(ch->fsm);       /* freed while callback may still run */
  kfree(ch);

timer_delete() returns immediately even if the timer callback is
currently executing on another CPU, creating a window where
fsm_expire_timer() accesses this->fi (which points to ch->fsm)
after it has been freed by kfree_fsm().

Fix this by calling timer_delete_sync() directly on the underlying
timer_list fields before freeing, instead of going through
fsm_deltimer(). timer_delete_sync() is used rather than
timer_shutdown_sync() because the channel is fully torn down by
channel_remove() and the timer is never re-armed after this point,
making the re-arm prevention of timer_shutdown_sync() unnecessary.
This cannot be fixed in fsm_deltimer() itself because FSM action
functions triggered by CTC_EVENT_TIMER call fsm_deltimer() from within
the timer callback chain, which would cause a self-deadlock in
timer_delete_sync().

Fixes: 293d984f0e36 ("ctcm: infrastructure for replaced ctc driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260803182736.2356374-1-nagamani@linux.ibm.com?part=1
Reviewed-by: Aswin Karuvally <aswin@linux.ibm.com>
Tested-by: Aswin Karuvally <aswin@linux.ibm.com>
Signed-off-by: Nagamani PV <nagamani@linux.ibm.com>
---
Changes in v2:
- add Fixes: and Cc: stable@vger.kernel.org tags (Sashiko netdev-bot)
---
 drivers/s390/net/ctcm_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
index 8b0d76a47d9f..63f8832f9b14 100644
--- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -211,9 +211,9 @@ static void channel_remove(struct channel *ch)
 	while (*c) {
 		if (*c == ch) {
 			*c = ch->next;
-			fsm_deltimer(&ch->timer);
+			timer_delete_sync(&ch->timer.tl);
 			if (IS_MPC(ch))
-				fsm_deltimer(&ch->sweep_timer);
+				timer_delete_sync(&ch->sweep_timer.tl);
 
 			kfree_fsm(ch->fsm);
 			clear_normalized_cda(&ch->ccw[4]);
-- 
2.53.0

