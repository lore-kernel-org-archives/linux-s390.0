Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E7C4457D4
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512348; cv=none; b=CFY3KWCPSwI9G4pe/8Shp8YYk+3wP0ml0o0uiB+i3dcfHzqJXcL6QGd7SDxSyxUPQfscWH/NQEXO3XGuL+Z3YnyQEYmOoLclLWPvVLiEMenOOwPODEjwjqASSrqzVmdJNrWKW2p+NqHPtHU2xvIFO6c/VGGQE86UWoR83Gh52EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512348; c=relaxed/simple;
	bh=2Cy1EGx6iYkQYdsK/PCNkierRJsx0oG/QxtTrEzYHMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VXIzaiEpiXiGQquxQYZyhAMvM++qz5friXCJixbBWvgmhfp9SX03IXJKCPwAynyVzEkjHzbQN+rgtqx+LgpeIO9AWdBFozo6Yq0tpzgw2sOztdxteG7TTxgw64UcbLcU9CtncWuJrSVVlgDKjQtJ0eyjWTFthNLv1Nl41h/NgGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b6Xtezkx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b6Xtezkx"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBmHtF1674791
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=chvKDX
	/ZCbChaAJ2TCmhInNUdxj7IXzKQoC/xVByzSQ=; b=b6XtezkxOw9xdeSdQ2ccfD
	upezJ+rwSL03fqoPpC1KIz9sGLkm0FRdEM73U+QME3+dF4xGWVkE3edaR/OjkWH1
	7NqkjVTCVYrkCbC/xWPJiJuLNYxr6AcIcyhgetxDL28zQ3sWblkV21qh5iXyvIIw
	IoSd5nssa12EJltMXjDpmIpEz0HIVcwMitmrzH3AjAwe9kgiiaikecPEjuTtFVr4
	NOMxyquH7ZU7+K2fck/mRINysdvU+1eRfhfVYIiDFd3e07KhFa8Fzp7prxopsXix
	k3Ptk4QnIdfZlVQUILzMZH/Z7HfRfxgAlUUu98n9rFqGENeVa+FYTqE59xcFJo4Q
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0p4qac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VFQcIv029233
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkgg50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VFcxQs30474568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 15:38:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C107D20040;
	Fri, 31 Jul 2026 15:38:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A81462004B;
	Fri, 31 Jul 2026 15:38:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 15:38:59 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v5 01/17] s390/dasd: Propagate partial completion length across ERP recovery
Date: Fri, 31 Jul 2026 17:38:26 +0200
Message-ID: <20260731153842.1729627-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731153842.1729627-1-sth@linux.ibm.com>
References: <20260731153842.1729627-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDExNiBTYWx0ZWRfXwUsJdgdhLbEN
 dD2vb5ctQNk5OfM/yRwpd8YEhK8JrMqqmbkYBNFcsPX2N1KJRCabcyYraKpmHisA4QSucvt8Q4L
 MOuyaIJNDt+f1+tMoFk7it3s3LkKfC0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDExNiBTYWx0ZWRfX85mn8WrTnabO
 hhUuxdRecjK+z9Z/65GT4F+860ZGJymSlsaacCWCJyEpYCdnx8dSS56KfUdy1M0VyNU4evUFbIg
 q26ocyjtJwRjb4rS5qGqnuk7F7eKv+zJr81PrPC8B3BSUNkWuQU0QEBUS4pcD+ZRxUecQO9aoqM
 ELWTDtZITlwNCb2DivfIqlZhg6+/cBE0J0U9xqxgzOV/efQA4f8cVB8DMVZjrCkq9WFSu9/Ad6r
 isbOnxWMdqswE9g3TpoN9JV15ZAnBFd+dsG0YibLduMG3NhdLgz6POlZOCc1srHZaUhBVZ7i69t
 O9AqIeAL7WvWz+TJvYiwS0Su284QUxFm2ZBq028dUR01TJKYzX5E52FHxFkae9dc9et6zTaNwuI
 vzLJCYxsxaghdH08XmsUWfBihStQCJTrZfY4qtzqAYPzl6ifiUhT7ctKzSrFiDbASbHUSRQvZcs
 LGMc15N+z/y/JkpHgSQ==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6cc198 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=01JC27pNfGPOVEZEpjYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: j_Gnok0leiBBDfpyxIIeh4t2snQq1vXb
X-Proofpoint-ORIG-GUID: j_Gnok0leiBBDfpyxIIeh4t2snQq1vXb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310116

dasd_default_erp_postaction() copies the timing and device state from
the finished ERP request back to the original request but drops
proc_bytes. A request that was partially completed, an ESE read of a
not-yet-allocated track returns fewer bytes than requested, and then
recovered through the ERP chain loses its partial-completion length.
__dasd_cleanup_cqr() then sees proc_bytes == 0 and completes the whole
request instead of requeueing the remainder, silently returning zeroed
data for the part that was never read.

Carry proc_bytes over to the original request like the other
per-request state.

Fixes: 5e6bdd37c552 ("s390/dasd: fix data corruption for thin provisioned devices")
Cc: stable@vger.kernel.org
Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_erp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/s390/block/dasd_erp.c b/drivers/s390/block/dasd_erp.c
index 89d7516b9ec8..468f0b2cc342 100644
--- a/drivers/s390/block/dasd_erp.c
+++ b/drivers/s390/block/dasd_erp.c
@@ -123,6 +123,7 @@ struct dasd_ccw_req *dasd_default_erp_postaction(struct dasd_ccw_req *cqr)
 	int success;
 	unsigned long startclk, stopclk;
 	struct dasd_device *startdev;
+	unsigned int proc_bytes;
 
 	BUG_ON(cqr->refers == NULL || cqr->function == NULL);
 
@@ -130,6 +131,7 @@ struct dasd_ccw_req *dasd_default_erp_postaction(struct dasd_ccw_req *cqr)
 	startclk = cqr->startclk;
 	stopclk = cqr->stopclk;
 	startdev = cqr->startdev;
+	proc_bytes = cqr->proc_bytes;
 
 	/* free all ERPs - but NOT the original cqr */
 	while (cqr->refers != NULL) {
@@ -147,6 +149,7 @@ struct dasd_ccw_req *dasd_default_erp_postaction(struct dasd_ccw_req *cqr)
 	cqr->startclk = startclk;
 	cqr->stopclk = stopclk;
 	cqr->startdev = startdev;
+	cqr->proc_bytes = proc_bytes;
 	if (success)
 		cqr->status = DASD_CQR_DONE;
 	else {
-- 
2.53.0

