Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2575836DA03
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784733432; cv=none; b=mOgm5PjUF72bCQfqQMvl9xXpdjG6r5JE0pYkkP3yA4H2gak2ctLdoNLq2gM5XfoMuaX4AKM5WBsrfeKgdMy9l6ZPPa0D2DugrDPHFbmK0MJx5s6tv1QOoVAHkxSrp4AIi1KO96h3LHr3VVBktc4HFG2sTKPd+hnFlOWhX62TPR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784733432; c=relaxed/simple;
	bh=dtENHwk+rhFXzkdtjOYZ8iurRnzWHV66S6nZH9t3+zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qxvv9t55pMZWmxiCi2urkX0gtk/bk7jhn9RNycDml6RQYCn6CL1ohrue/kldryXIK1smH6HlykvRemIUtQh6rxCNyFRJAcNMu2BRUJQcL+N8fq2fClI01wBmIm5OKeTj27Zix6hNVCdG0lsj0y9t59osvfo2XauK0XN8j3QpZyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P3cOpjn4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P3cOpjn4"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MDgFEM095834
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 15:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hk3nP/
	l1aRIa7SFOrrE/DpOpD5Sqon9Y94x/PcBPoeQ=; b=P3cOpjn4efFHM+Tykz0rDM
	5YvdLI3z/RdhMlTMj0JAvLh0M6s+IXRxauNRjKnzuMRZL4FtK2b4rG9aT29qglUu
	MDpgeaCDSSH5EqixWR98DiLJeuhN7XdVslJ5oyuY/4faglADSjm92yPBMuQ3i/Mo
	gMf6TMlzReOz8TdyjBXbj7t8Z+8OHg3chvNqtLa4Mxc8uxqSC2qReFVeLIsh/uXV
	ZHw18oeDn+0l7jvVPFSeAgyzty31p2UIPhHeJ09yqXgnoQWI8xYByJPLbgEskBs1
	kHvKR8gJdu/w9H6Z9EwRtxB3lG5CT6p6SjT8/0/5mfozxco2pP+9CuvZn1AtCs+A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7912vyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 15:17:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MF4Z78013034
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 15:17:09 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktq82dy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 15:17:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66MFH5YW34800112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 15:17:05 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C142200FD;
	Wed, 22 Jul 2026 15:17:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34463200F9;
	Wed, 22 Jul 2026 15:17:05 +0000 (GMT)
Received: from li-c11aa8cc-2ecc-11b2-a85c-95df2f347b4c.ibm.com (unknown [9.111.60.227])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jul 2026 15:17:05 +0000 (GMT)
From: Volkan Unal <vunal@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: oberpar@linux.ibm.com, sth@linux.ibm.com, hoeppner@linux.ibm.com,
        meted@linux.ibm.com
Subject: [PATCH 3/3] s390/dasd: Make FBA discard support conditional per device
Date: Wed, 22 Jul 2026 16:16:51 +0100
Message-ID: <20260722151651.292621-4-vunal@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722151651.292621-1-vunal@linux.ibm.com>
References: <20260722151651.292621-1-vunal@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: y4_2eGqi4iQYLuRbQ_ilN_dpvqJVn_vi
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a60def6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=ocMt-DmEnUh2Yn_IsfUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE0OSBTYWx0ZWRfX9P+wPo5oBbrD
 C8S8NPK5o1oWwuoK+DQtn/FAQpY7vwkK2qOyBikrqrRXMZNISn2TTKHj5bKflV/UBBMNuNY0Ek9
 9Y8uqyoaP9S96aXeAg6qsfuFG+HT9P8=
X-Proofpoint-GUID: y4_2eGqi4iQYLuRbQ_ilN_dpvqJVn_vi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE0OSBTYWx0ZWRfX5qqdbRGeAsMp
 +5/zA8APahIwpT5vmOdpyfbwNsVfxolcTm/TB1tN28cj8UT/orC7M1RDxUBlu2i1mMCBhEDllAt
 zv5W3LHna2cCzXwBxL2PzffdQSAeFweOtukICg0caK0vsEPN2i1lEfHcaMkZSCYiGl2TwsEz/Ty
 UZpOIU+8NzvJXKWazMo9qmOj6OHR5ZjH4N2i6wtXSkJnPva8rjK4S/wq00WZSIZN+hz+g/nyH50
 WSQn4/2YcyDiVdsS7xvt7iExSHyAy1SjcyGmsc/kuUEjK5Nmv43n23g+rX3QqxyCXPGDrloomL1
 +eA+N2SAkVGzDnBY1V/lAMzkQghF53X1H4pL6YpsQ9R7WXex3FVcQ04iB3iSKUAq0zcnbW11Rwu
 1i/ue/vy0RY7DKhV2K/3EVBZRy7wRqMdCPwvxCFhbaE7MXbbrad+laVd8DRnDk58OD4gK7Hmek3
 6gaM/AYCHomFdx6GgiQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220149

Replace the static discipline->has_discard flag with dynamic per-device
feature checks to allow conditional discard support. This is needed for
FBA devices where only virtual devices (6310/9336) support discard
operations, while physical FBA devices (3880/3370) do not.

No functional change for virtual FBA devices. Physical FBA devices will
now correctly report no discard support.

Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Reviewed-by: Mete Durlu <meted@linux.ibm.com>
Signed-off-by: Volkan Unal <vunal@linux.ibm.com>
---
 drivers/s390/block/dasd.c     | 2 +-
 drivers/s390/block/dasd_fba.c | 1 -
 drivers/s390/block/dasd_int.h | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 3181c06d91ce..3e009217c130 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -327,7 +327,7 @@ static int dasd_state_basic_to_ready(struct dasd_device *device)
 	 */
 	lim.dma_alignment = lim.logical_block_size - 1;
 
-	if (device->discipline->has_discard) {
+	if (dasd_get_feature(device->cdev, DASD_FEATURE_DISCARD) > 0) {
 		unsigned int max_bytes;
 
 		lim.discard_granularity = block->bp_block;
diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index 2869f93ac0ed..b28661b7c044 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -774,7 +774,6 @@ static struct dasd_discipline dasd_fba_discipline = {
 	.owner = THIS_MODULE,
 	.name = "FBA ",
 	.ebcname = "FBA ",
-	.has_discard = true,
 	.check_device = dasd_fba_check_characteristics,
 	.do_analysis = dasd_fba_do_analysis,
 	.pe_handler = dasd_fba_pe_handler,
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 81cfb5c89681..ddfc50ac6741 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -293,7 +293,6 @@ struct dasd_discipline {
 	struct module *owner;
 	char ebcname[8];	/* a name used for tagging and printks */
 	char name[8];		/* a name used for tagging and printks */
-	bool has_discard;
 
 	struct list_head list;	/* used for list of disciplines */
 
-- 
2.55.0

