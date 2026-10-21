Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792584276;
	b=qe0cmYI60o+fnLEu+NO/Q5hpbLE5rdnqncuEnR7njgvGoBQA1oXzToKRGFHapxQz+W4S
	 +svrmjdnBOH2GzES6/OLlBwOu6STdACpypHVz/BAl8toZ1DbV+8JkDUPTLopZ+9OXfmZY
	 MfYSiV3jwpWPtoJb+7GHGk+eovvyLLc07H8vjbYJmTLdyF4gd5ukpdOgiKa90InfJvnpn
	 2DFb6Xdw1Bjg+cZ9GvQt5wp7Fe+a3ZNCaIdoCCvcpm6DFdQm9BNPAXCrPWdrwr2Nxq+dJ
	 5v91IonPEKMt8Hr7uRGtq9Ns1N8MyRq0yIT8DtJiTPG+d0BEnfUZxxk90I2KUbMRv2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792584276;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=gLjF4J6GZU9jVNUnaDinYNizOnY2za1JTFEQyaCyV7g=;
	b=lZIaXDPb7glIOmpOHOZtCGX/gR68WXDrbh4RtjzZrc00Av5MGawn9eeKuW3tCX7xQS+g
	 P3hoosSfJubAHqcRyGl2rdXVa69N5VDIvtxm/GZb0TjVrHuU75FSYTa1K0rItSrd1int+
	 oSa8M5lrmQo/mJZ3r6xsTKxjmZveQ61wRZgW6YrQEdE5dyk23U/apDrtQQhwSDv02wdhf
	 OLvDgEETDkHGp88uLiEtPXpXY48Mrv3ddlcD3ceHCU4LSZXQ42/U35XfUMY6LhvgaRVOc
	 4OWcc9iaZ2CaRxwu649BETvWPz5S8LY1WqN4VBfridjvGRov8Rc53WgIUKc/M5eNl6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UrWaH7qh;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53B8606A319
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 12:04:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A53B8606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UrWaH7qh
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LBi7Bd1197787
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 12:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=gLjF4J6GZU9jVNUnaDinYNizOnY2za1JTFEQyaCyV
	7g=; b=UrWaH7qh8+mWdcWxwWbJm7XLjoROIE6m1RY6CwW0GqS/uJepNSEnjeGov
	pKili2yGioYWd4/KTzNKfG7JoLxvvUuMDFZ0DKh66hDLZMKlkJYLrq49cslW0CtU
	XaTIPXn1T/Nfi5lIG0O4mGs9zPio7jZOYvXczDliMUshT//D06bzqUh/48leV08o
	w4YIvjhshRf3QN5vzKXusLSX+u/9IH6fWHnY1+xgwdRrxIkEyIwhI+ad//YAeKY0
	+lnAl7W0B1PMmrNcanMCcrgqj2U7WfXM9CoKh2jG6tHHJIKCPHjuD1K95WctdfBu
	qi3WQ2Hry95SpFCNQU4zYrqJHu+Zg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw58rtm9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 12:04:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69LBo2Pj3083820
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 12:04:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hcmuh6rwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 12:04:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69LC4ThB52101450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Oct 2026 12:04:29 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADEB120065;
	Wed, 21 Oct 2026 12:04:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 847E120040;
	Wed, 21 Oct 2026 12:04:29 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Oct 2026 12:04:29 +0000 (GMT)
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To: linux-s390 <linux-s390@vger.kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH] s390/appldata: Fix error handling in appldata_generic_handler()
Date: Wed, 21 Oct 2026 14:04:26 +0200
Message-ID: <20261021120426.1148360-1-gerald.schaefer@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GlKkwSxfw6ZcFhUbneefMTlx3LcIuH_N
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA0NiBTYWx0ZWRfXy48/oIRZ3z7R
 WHClFhsg8LJFg8o2uBTwvpNOg9jttaS+KU4e599CcDisZ0MjX+LHDuKszpGXYOr5MPl65HLMgYE
 xDHOOaes98DDjeoVeGV9abPsBYlLFGc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA0NiBTYWx0ZWRfX+RU3DT4QM5G9
 GZP+M/WiA4RRjiWF+VQay7hadHvYeIt/T4fdEvXNu5DSnpKRDSDK3mO883cHnwOFFRrYpjeSasx
 TXjzfRtjt9PbeLEWPbZ09f0lCmFv01DaMafi/aAPW5j1HnVqmuNEmWKcYhhXFSxH1VmP65gFmMC
 pWEkMNNfY08XIjFg+2RS5P0fkxRwjpr10t8pY1aMJK73zAFCQWga0kmOmZkubdqL2rbHTvlPj2I
 tv7plJVsO7COdbzn6JKb9fSr8wzeIIs4+QPbetb4TqW/CyHKG2QTns4KGAftWtA+aDL0mSuju0l
 Vi5pflzalFdr3YXEqePAfttxGsx5spgrRz++J5lfSec1qZ67oLXOG/wCYaDRlFBue+uXcahpFFY
 yOFDU5UtMtycmU+DEWyqzLSu1ttj3u967Onka/2IOyaN3FmEJgjhop74LSS0CxfoRUKemKLdA7m
 4DU1i6FVVtnZwiRB8Yg==
X-Proofpoint-ORIG-GUID: GlKkwSxfw6ZcFhUbneefMTlx3LcIuH_N
X-Authority-Analysis: v=2.4 cv=Ob4NnRTY c=1 sm=1 tr=0 ts=6ad8aa52 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=3jh7bp7lksaD3_9WK6wA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210046

appldata_generic_handler() always returns 0 after starting or stopping
monitor recording.

So "echo {0,1} > /proc/sys/appldata/{os,mem,net_sum}" returns success even
when DIAG 0xDC failed. A failed start would keep ops->active as 0, so
reading the sysctl later would correctly reflect this.

A failed stop would falsely set ops->active to 0 and decrement module
refcount. This would allow the data gathering module to be removed, and
the data buffer to be freed, while z/VM monitor service is still collecting
data from that buffer.

Fix this by returning -EIO when appldata_diag() failed, and only set
ops->active to 0 and decrement module refcount when it succeeded on stop
path.

Cc: stable@vger.kernel.org
Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
---
 arch/s390/appldata/appldata_base.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
index 836c51da18f4..f10b2f040cc2 100644
--- a/arch/s390/appldata/appldata_base.c
+++ b/arch/s390/appldata/appldata_base.c
@@ -360,21 +360,25 @@ appldata_generic_handler(const struct ctl_table *ctl, int write,
 			pr_err("Starting the data collection for %s "
 			       "failed with rc=%d\n", ops->name, rc);
 			module_put(ops->owner);
+			rc = -EIO;
 		} else
 			ops->active = 1;
 	} else if (!active && (ops->active == 1)) {
-		ops->active = 0;
 		rc = appldata_diag(ops->record_nr, APPLDATA_STOP_REC,
 				(unsigned long) ops->data, ops->size,
 				ops->mod_lvl);
-		if (rc != 0)
+		if (rc != 0) {
 			pr_err("Stopping the data collection for %s "
 			       "failed with rc=%d\n", ops->name, rc);
-		module_put(ops->owner);
+			rc = -EIO;
+		} else {
+			ops->active = 0;
+			module_put(ops->owner);
+		}
 	}
 	mutex_unlock(&appldata_ops_mutex);
 	module_put(ops->owner);
-	return 0;
+	return rc;
 }
 
 /*************************** /proc stuff <END> *******************************/
-- 
2.53.0

