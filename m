Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B41135C197;
	Tue, 18 Aug 2026 07:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787038810; cv=none; b=owyzZUlM2ZBCTYcrm7dPZWH63tuQiqZW7+w/tOf38xIMRVo5aedXeoMty8cOAP4mvRO8meRfwXq4vJwXHe3G1CfN0ygon9oW0BzHULsmHRdspWWN1k+PuxmLAx334U5UhaF3uA3CgtnIqBtcYV0+ZwTTIrYmxZ7s7U1lilVEiHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787038810; c=relaxed/simple;
	bh=kZmL5XFXWVsXLWyVPoB8FjsGgAnrpfuTdMMeGphnzTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fvb1OX9zGxgaqtb/7mt21l1EMAjoyDbuZq5D0Klt96IB3fiZpMdAScbLTd/JW2ZQpRA/bZZSoWa+2Nac4UEuiqJJQN6b9OX+fktq+mGF2PNz6sF13h2AJPRdW1p6R0Z6joMf2QYLJoon8DhHj2esYhdhrSMkfE05T3JzaIn6KMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lC3w/65K; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lC3w/65K"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HM1U3K758608;
	Tue, 18 Aug 2026 07:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Ep/A7CsX0iLhBlPjioxMOkaFb+NG6KD5degpWGJR9
	y0=; b=lC3w/65KyU1V2J9TlKyX0MD7rOczgrkfkaIwv1+zOY5Lelcj9ell1kNG/
	UKMUCvI1Miq6bovXbXKx31QiRVM5x8bdLG+T2dL1xCi/1uIso8W6w69hedvisfRb
	+06XADw7HJ+zKBdEKxILDdzZhx61kXbuHCUvuBCtmy9qc1/fBz+2QFlr7KTbGfsM
	QuoFzla6xIkRFiwHw2Jr1XjnY9f+y+UYO9wc5Lzz9LosxI3ww2AYO7giajCHUyCr
	uhB3RbPZZtDgsP/LdLlXjsY2/JnSLfQ5Pr43HKlKALzNpmA2xMDQ2YrTFUc5Z1NY
	nQ1OR9qgNbP7uXQDeEfEMxtS8dIjA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqprtf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 07:39:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67I7QMIa030618;
	Tue, 18 Aug 2026 07:39:55 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ng9t69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 07:39:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67I7dpmm45613464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 07:39:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6863C2004D;
	Tue, 18 Aug 2026 07:39:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25C6A20043;
	Tue, 18 Aug 2026 07:39:51 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 18 Aug 2026 07:39:51 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 56341)
	id 0837416113B; Tue, 18 Aug 2026 09:39:51 +0200 (CEST)
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, alibuda@linux.alibaba.com,
        dust.li@linux.alibaba.com, sidraya@linux.ibm.com
Cc: pasic@linux.ibm.com, horms@kernel.org, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Hidayath Khan <hidayath@linux.ibm.com>
Subject: [PATCH net] net/smc: free pending qentry in smc_llc_flow_stop() before memset
Date: Tue, 18 Aug 2026 09:39:43 +0200
Message-ID: <20260818073943.1108383-1-mjambigi@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA1NSBTYWx0ZWRfXy5AWnLEe7sU1
 lb/LWOMvqwUTZzt5pK1otmtomSCqBYRQjzN9eH++Iz2IULGD1rIe7i9ZlaiUL3obyPiDG+a9P06
 bJ5nvxJOnCcxV2zvuC5/j8d8jQXfriB92iAPyVAL06Zgh/XtEvehR9kZIRf0dDsnl6XGc1CrKzZ
 f+ECkDdHuXXssSKU7nFtlmNIFh1aQMtaurVDg+YzXw5skKIhI+FV83WMsXiL0f10SPq2DEmhTy0
 42Q0VlHAUWl7E3eHZ1qzSJVF5tggUtyvuUWb7erU16Ks1jrUE05Ko2Amquodr5Np9F9TfV1jHEx
 3FlkebgF3IaZmw8HHq9q4YlRQNllL3C1qAYIHMtN35YPTH3uNxDFqrChikd/sS2gdLfHwr57IMc
 2tFoiWyjNVyvaY+vAI7JVU+ncKdXqiQ6CezRWy7bf6bCq3YkazT41KBBCh4Ioeh5dgguAinoBHq
 kZlAkEsWcz96JQXkbYQ==
X-Proofpoint-ORIG-GUID: wByyKPmcAxNmeKZMAKVkESVzQx4vfR1l
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA1NSBTYWx0ZWRfX04TwbjViSozD
 ioaRoGPbYFY9jZkfsnwdeBcfNJ03lGp4KWZA9JOZIa/LoHAfH5wxFT0EZXsOU83hkO06SiDpjuA
 i3EHIfqcUUggDBkYPB5riz87AO58oGw=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a840c4c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=jWMLYlMGGp7ONIserkcA:9
X-Proofpoint-GUID: z7-EWK6eSRIvgfhhgVi-RhfylLYiq2CT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180055

smc_llc_flow_stop() resets a flow struct with a blind memset:

	spin_lock_bh(&lgr->llc_flow_lock);
	memset(flow, 0, sizeof(*flow));
	flow->type =3D SMC_LLC_FLOW_NONE;
	spin_unlock_bh(&lgr->llc_flow_lock);

If flow->qentry is non-NULL at this point the pointer is overwritten with=
out the
allocation being freed, leaking one kmalloc object.

A late-arriving duplicate CONFIRM_LINK or ADD_LINK_CONT message can set
flow->qentry after the legitimate message has been consumed by the waiter=
 via
smc_llc_flow_qentry_clr() (which NULLs the pointer but leaves flow->type
non-zero) but before the flow completes and smc_llc_flow_stop() runs.  In=
 that
window the duplicate is stashed into flow->qentry, and then lost when
smc_llc_flow_stop() zeros the struct.

Call smc_llc_flow_qentry_del() inside the lock before the memset.
smc_llc_flow_qentry_del() already checks flow->qentry before freeing, so =
the
normal case where no entry is pending is a no-op.

Fixes: 555da9af827d ("net/smc: add event-based llc_flow framework")
Reviewed-by: Hidayath Khan <hidayath@linux.ibm.com>
Signed-off-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
---
 net/smc/smc_llc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 954b2ff1815c..fa1ff543638f 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -320,6 +320,7 @@ int smc_llc_flow_initiate(struct smc_link_group *lgr,
 void smc_llc_flow_stop(struct smc_link_group *lgr, struct smc_llc_flow *=
flow)
 {
 	spin_lock_bh(&lgr->llc_flow_lock);
+	smc_llc_flow_qentry_del(flow);
 	memset(flow, 0, sizeof(*flow));
 	flow->type =3D SMC_LLC_FLOW_NONE;
 	spin_unlock_bh(&lgr->llc_flow_lock);
--=20
2.50.1 (Apple Git-155)

