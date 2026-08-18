Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37416378833;
	Tue, 18 Aug 2026 07:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787038292; cv=none; b=E9LM1Vtg9Bu6dG54wSPKYJLs5m7r+8EuJYyCf34ovufwIfOqYzd/ERohmjV9ewgroZygSmBkA2E05L3YFTg6GeP0+rnXRTKO4XNp+hwx4qfuTK/kmU1Kw78L25YrvvYrj+S1hJOTsC4bM7xsORBj+Dg44krGJ9TGOwxiI44wGjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787038292; c=relaxed/simple;
	bh=QBpVO6DJy6JCTg4w5dKv6IgUyJKaHcEBz3YP7SbrAVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GDF9abO2vC9Ztav622/BbqnGn0s3IlVOGG8SpWBBziFUD76QqjK++0BYIi10ouxypjegrhxA4FD9Up/grPmtjzsZRDECN9BF9P6NsvQhXlys5xJMK0QLgEMQrmfyarytwaKj8Z8o+I5r5PtAA5jD/SOSOHAnakm7Uz8KsiRc/dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q0ot++O+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q0ot++O+"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HM1kAo2526488;
	Tue, 18 Aug 2026 07:31:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=zxp4ukBNL6k4K6ViKYFlAQVx4Q1m3b7tOo8N72wJv
	c4=; b=Q0ot++O+DW7VFDlQ8lQSnrYco99Wqy4nplRbilkvtb4u3LnP1rUrQbqm6
	aPH08YRLF0kEeMW7phiG3IEpoEJTpOR1fJpq8ZQNs0+FdcdTtrRbjGtIq13a398x
	5MxQkw5UhaNzanGA+xk+t/nvhsHywf7UwEfrJIA1KHntHIn1N+GUDrUN7EM0lrp6
	cFR51ZitMJ/jyiktqo0BmZwQRbYOWXuLuItwOrJSSeRen1qoLf2FKyvRKEyhUSac
	ryB68/iH9xiaxXnl2Hi1yDeC+eXSKg6kVWvbGKOXRyfEG20lLhkcTpTirjnwnr8C
	vtFvqjlDXuRk/1JStdlxwn+XN3sbQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhkxmf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 07:31:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67I7QMH8025784;
	Tue, 18 Aug 2026 07:31:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xh1xwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 07:31:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67I7VCCi46924128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 07:31:13 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC9CE2004B;
	Tue, 18 Aug 2026 07:31:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC92E20040;
	Tue, 18 Aug 2026 07:31:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 18 Aug 2026 07:31:12 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 56341)
	id 96FDF16113B; Tue, 18 Aug 2026 09:31:12 +0200 (CEST)
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, alibuda@linux.alibaba.com,
        dust.li@linux.alibaba.com, sidraya@linux.ibm.com
Cc: pasic@linux.ibm.com, horms@kernel.org, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Hidayath Khan <hidayath@linux.ibm.com>
Subject: [PATCH net] net/smc: free stashed qentry before overwrite in REQ_ADD_LINK to ADD_LINK transition
Date: Tue, 18 Aug 2026 09:31:07 +0200
Message-ID: <20260818073107.466506-1-mjambigi@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA1NSBTYWx0ZWRfXxw/8oz0iif+v
 PZEKkdTEkvCnha/Bh/MP5rcZdiOD2qxYfVWoDOuXTV5tosrHpiyVCCUlhIxdN5YH9d8YRCk/Ljm
 qTtMOV5PCARUhUBu8z86rD5QJU/5QO0DhmKWd5rOiGqwK4PPr6FCp1CVomUz3xZamoNy/T7jz2a
 8s3rmM7gWTcPJbbY+H/eMV3ZbM+DGdFGrwUkQMe6c1GMS7HlF2Y5ri2cD6sWTOdKgjWHl5+2bC6
 pjgvMFZsN/XCGpORh9vpnwc921HYj3oRFb2NAxVGrA81MrimrA7ZHOtd/E0TubvehuykJ+snPwg
 ohRCqCm9C+cQsaEsNXmWjqK1XkboHFRDoSb6OLdc9JvTJrKrUlwwcsgzNeHaIvceMOVijxU7w2t
 211A8gvmKaPeg+fBgLi1cpYSkF/MTTAtKnCMr49/CLZ4Qg4+oN+TDYavkGLHbn6DfF3+Cl6BPDf
 WBiBVUZk6cZ6o6wZEZg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA1NSBTYWx0ZWRfXwuxbiG1qE2jP
 KIL9XzzhTPHfMucWcTcDnTFpnrrLm9At8DDAnLcJSe0Ro/Cigp3Owoda1y6LxMQN0HCr3vZIP3O
 +kQ4U1M7up1zMMdTc4wUtdVwwjLTPcs=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a840a46 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=kEd-LeU3vPIERflgv4oA:9
X-Proofpoint-ORIG-GUID: sIA8EbsEzanJp332aaCG5fuc0LoAfa8d
X-Proofpoint-GUID: VajwhRUj8CwpOS3xwJDjXmwWiaxWJNkr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180055

When smc_llc_event_handler() transitions the local LLC flow from
SMC_LLC_FLOW_REQ_ADD_LINK to SMC_LLC_FLOW_ADD_LINK on arrival of an ADD_L=
INK
request, it calls smc_llc_flow_qentry_set() unconditionally:

	if (lgr->llc_flow_lcl.type =3D=3D SMC_LLC_FLOW_REQ_ADD_LINK) {
		lgr->llc_flow_lcl.type =3D SMC_LLC_FLOW_ADD_LINK;
		smc_llc_flow_qentry_set(&lgr->llc_flow_lcl, qentry);
		...
	}

A CONFIRM_LINK or ADD_LINK_CONT arriving while flow->type is
SMC_LLC_FLOW_REQ_ADD_LINK is stashed into flow->qentry via the
SMC_LLC_CONFIRM_LINK / SMC_LLC_ADD_LINK_CONT handler (which stores into
flow->qentry for any non-NONE flow type).  When the subsequent ADD_LINK
arrives, the REQ_ADD_LINK branch overwrites flow->qentry with the new poi=
nter
without first freeing the stashed allocation, leaking one kmalloc object.

The stashed entry has no consumer: smc_llc_wait() is only called from
llc_add_link_work, which is not yet scheduled while the flow type remains
REQ_ADD_LINK.  No waiter is sleeping on llc_msg_waiter at this point.
It is safe to unconditionally free any stashed qentry before
the overwrite.

Call smc_llc_flow_qentry_del() before smc_llc_flow_qentry_set() in the
REQ_ADD_LINK branch.  smc_llc_flow_qentry_del() already checks flow->qent=
ry
before freeing, so the normal path where no entry is stashed is a no-op.

Fixes: b4ba4652b3f8 ("net/smc: extend LLC layer for SMC-Rv2")
Reviewed-by: Hidayath Khan <hidayath@linux.ibm.com>
Signed-off-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
---
 net/smc/smc_llc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 07e2d7fef7b2..9cc4b3e97699 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -1911,6 +1911,8 @@ static void smc_llc_event_handler(struct smc_llc_qe=
ntry *qentry)
 			if (lgr->llc_flow_lcl.type =3D=3D
 					SMC_LLC_FLOW_REQ_ADD_LINK) {
 				/* server started add_link processing */
+				/* free any qentry stashed in REQ_ADD_LINK state */
+				smc_llc_flow_qentry_del(&lgr->llc_flow_lcl);
 				lgr->llc_flow_lcl.type =3D SMC_LLC_FLOW_ADD_LINK;
 				smc_llc_flow_qentry_set(&lgr->llc_flow_lcl,
 							qentry);
--=20
2.50.1
