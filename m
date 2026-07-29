Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4B3486BAE;
	Wed, 29 Jul 2026 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330173; cv=none; b=We+WOAUIloc38bvM0VOnOEYNn2LYsBGH6KmKz3NYVKgAQZz0yf3+9QdOQCA/cpoIUsOjJRbQ1KB7Da98shRMtwJvSugDnORCO6zXXvYyTjhcjvZjhxQrG3lY7MmgeT4ssVT1DgHcKi+vzHMKnQVOvBedDwynnIXBs0sF0KVk2p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330173; c=relaxed/simple;
	bh=SDrPbwPsmo75Du/iHg+9g+qdqgzcJPEHzR8tXp00Sl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZMqDu/wpe0OqDrTrgcd8RRVpV/eJsA8jJsorUONM4HLaa2r26IO72fAHqcqRedZ7y7VoPXrgp33cgrBQC3SDVtIapEv9+XxUScXacpCH5gmYL76TJCeh4csm3t5gXxX3WV03O/+SoHNEtJFeaOBrwdt7Fh1+AAlBqZmTlzcYoLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rqEFQGUu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rqEFQGUu"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TBHWc44062807;
	Wed, 29 Jul 2026 13:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Ad0wgp3aJgiV4B/XXNKIXhTmDheby8lx719oeDI5d
	6w=; b=rqEFQGUuh5DneBf9RUmfrKgZh5xqn3WJxqQ2cWl5BB3PslqGQX9bdezv6
	UJoli0nuWVRQWtWde8TRJV0yyhKN+KG+En2rKJIQVrmBldV/tGq9FgEAzucuO/3N
	2NFGiZCKIhuQK6vu1tsapsTqDTdfltFUp90fbDHxiG4fGf55vDPv5IHOQUmEK+20
	mv2nTDrT3fvn/lFNLBDzI/sa39eHUvoxRbX5ZYgWD7mkzJeAXK6D1HwRzDr1zISc
	cJ2JTDzq61LCNsnnPvBkbpqgA/xrKWKHqmoewKeU6Xq9zPqIsfU2dviP7T2je3RC
	IPXJHlnJ51oo+pdmJPzjmKfFe77hQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xtsyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 13:02:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TCuQw5002882;
	Wed, 29 Jul 2026 13:02:40 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fk6sxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 13:02:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TD2aeO48234916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 13:02:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AEBD20063;
	Wed, 29 Jul 2026 13:02:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33B952004F;
	Wed, 29 Jul 2026 13:02:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Jul 2026 13:02:36 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 56341)
	id DD5BD1628BC; Wed, 29 Jul 2026 15:02:35 +0200 (CEST)
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, alibuda@linux.alibaba.com,
        dust.li@linux.alibaba.com, sidraya@linux.ibm.com,
        hidayath@linux.ibm.com
Cc: pasic@linux.ibm.com, horms@kernel.org, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Mahanta Jambigi <mjambigi@linux.ibm.com>
Subject: [PATCH net] net/smc: fix qentry overwrite for CONFIRM_LINK and ADD_LINK_CONT in smc_llc_event_handler()
Date: Wed, 29 Jul 2026 15:01:53 +0200
Message-ID: <20260729130153.970800-1-mjambigi@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: p3OING_fplFz6uR4NO91Ccwtw0s6YG7w
X-Proofpoint-ORIG-GUID: KtSl6z0MAI8W_zgo2CKPMKsDtp8Fmy-n
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEwNiBTYWx0ZWRfX0XSKgU/E1j20
 TrRCL+HpokK1cILHKe1qRT5+UaR4GVCN4xk2C+MygBhaoyrswjmLjzdILcaPY9EVgDctDI01h0W
 PyCtzl8n/rZM7/OT3NHA0iD4QtwrK9s=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a69f9f2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=W179ObIX3BJvcE7xjOIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEwNiBTYWx0ZWRfXy5TloUljpG7y
 Xte/8/pjmm7IaUGBG3v3Vt9EBfSUv5Wk5PuRKX+SFZcDI+yRPw6Xft5bLlss021z3iF1pK5af+1
 a0xygai9A2zflMdKIvVRVRF/vkRNCtVjmU39iPFjONGzURxvzFjrBKaMKmcXSDPo4Gy61luFTQO
 NrXgdGU+AJPzvt9RIblCfRCYJaME9ZYFxgGr1wnKHB9DENlSJ+oJ3dpy0S1MKGb9FzN/9SJ4M2a
 EbvR3VI843wVI2uiFU2VwyfDXRXpC562tLrlWKXWEilwE2ltPjE41t+mMQGECiAOkLGiNISFXMP
 30XTM+SpFw8P+LYVn2yTHCiNM5gElmyvOSW09rdOya+8ZrK75uBpBg+NX0CYNMeNL03JIXLNTuL
 Ae2XlCpn2RmZfjtgM/nStTNfrDCNrmZe/Mkm7wodL/ogFjLxmdMA+upy45OJChG06bNWEh8Ia6j
 6WrhIVY63WYdSQcrMEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290106

The SMC_LLC_CONFIRM_LINK / SMC_LLC_ADD_LINK_CONT branch in
smc_llc_event_handler() stores an incoming qentry into the local LLC flow
without first checking whether a qentry is already pending. If a malicious or
buggy peer sends a second CONFIRM_LINK or ADD_LINK_CONT request while a flow is
active and flow->qentry is already set, smc_llc_flow_qentry_set() overwrites the
pointer without freeing the previous allocation, leaking one kmalloc-96 object
per spurious message.

The sibling SMC_LLC_DELETE_LINK branch already has the correct !flow->qentry
guard. Apply the same guard to the CONFIRM_LINK/ADD_LINK_CONT branch so that a
duplicate message when qentry is already occupied falls through to break and is
freed by the kfree(qentry) at the out: label, rather than silently leaking the
existing allocation.

The response direction (smc_llc_rx_response()) is unaffected: it already guards
with flow->qentry at the equivalent site and drops duplicate responses
correctly.

Fixes: 0fb0b02bd6fd ("net/smc: adapt SMC client code to use the LLC flow")
Signed-off-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
Reviewed-by: Hidayath Khan <hidayath@linux.ibm.com>
Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
---
 net/smc/smc_llc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 954b2ff1815c..aa6d83af55ed 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -1927,7 +1927,8 @@ static void smc_llc_event_handler(struct smc_llc_qentry *qentry)
 		return;
 	case SMC_LLC_CONFIRM_LINK:
 	case SMC_LLC_ADD_LINK_CONT:
-		if (lgr->llc_flow_lcl.type != SMC_LLC_FLOW_NONE) {
+		if (lgr->llc_flow_lcl.type != SMC_LLC_FLOW_NONE &&
+		    !lgr->llc_flow_lcl.qentry) {
 			/* a flow is waiting for this message */
 			smc_llc_flow_qentry_set(&lgr->llc_flow_lcl, qentry);
 			wake_up(&lgr->llc_msg_waiter);
-- 
2.53.0

