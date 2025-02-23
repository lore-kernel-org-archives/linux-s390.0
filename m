Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD1520127F
	for <linux-s390@vger.kernel.org>; Sun, 23 Feb 2025 09:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740304512; cv=none; b=eVMVyzqcsWq3WTGoCl5tAzHPHJtwQMETdMuClFgbQC7ShiiW6yV2qN0aYaKIJBrsthiPo8Gd79IEhqgSVILRHgoLf/15zeMFoPy40HToCxHF4HpBe+bDtD27ozlQK4v+w8T/KoTgO1wnplDFZqehZQNHSxau0JJ9nviyVZaY7kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740304512; c=relaxed/simple;
	bh=TDrz2XiYQBFqzynlU+Rp6bOfDttb1wj4oxlgHGJ06Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozUdoeY5wfKwEAaZHRbszpHNbZOPGn6/Wrc+UZkCJfZLTAyR573CFzFmjtteTh5C+kTfMh2Fokg3YNo0xCvk99mSD7E6mShyGfkCXze4E5lKjH/Vcb8vefNZ+v3UzaEjQfV2xVHnX4ADr1pnlfxeJ9b+0AzAc2V4vTbnbzR8V94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fLJQr//F; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fLJQr//F"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51N18MA3019838;
	Sun, 23 Feb 2025 09:55:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=N7wb9xzZ5EGz1P+lZ
	duy1wr5XlJt49VGNGZHkM9zarw=; b=fLJQr//FBLF+6cwgB6/kmalRXciuiJvTe
	KSejhI4IZniPw0Sp1mA4ON6y2QvQQuPwpYcxH6JxbvZsrCMRA9SQ/S/fFfdzQvsa
	Il4ELN0yrdgtgwxJ7KO/Bxae0UWi1BgWjcfhV/36fD2xTkJN5cQfn/iLLK5UKWM5
	ECk+N8yERqsHnmFeL0yXs4z8R9GFK/mzluhRbJDx4pStldmU01PB/MKi8Q1auNHP
	jll8rDeUK24VHw5qmUDf/8XmT/9BPmYOGWpkCkjZJ+mcRjQKJU2kCHSTcaLG4c7s
	9GEESzyM+r8bBti00SORAflWVGnTmuF2ikTvsM93ubFPPFAubAHjw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ysr9sapq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 09:55:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51N9ASci012499;
	Sun, 23 Feb 2025 09:55:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ys9y1wgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 09:55:06 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51N9t3MM13173184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 09:55:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8A1820049;
	Sun, 23 Feb 2025 09:55:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A320420040;
	Sun, 23 Feb 2025 09:55:02 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.19.146])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 23 Feb 2025 09:55:02 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v1 07/20] s390/zcrypt: New zcrypt function zcrypt_device_status_mask_ext2
Date: Sun, 23 Feb 2025 10:54:46 +0100
Message-ID: <20250223095459.43058-8-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250223095459.43058-1-freude@linux.ibm.com>
References: <20250223095459.43058-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KuQUSrhCdxx--8B5237NeJTgGy_k8RTa
X-Proofpoint-GUID: KuQUSrhCdxx--8B5237NeJTgGy_k8RTa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-23_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502230073

Introduce a new function zcrypt_device_status_mask_ext2().
This function gives the possibility to provide upper limits
for cards and queues. The current implementation of
zcrypt_device_status_mask_ext() needs an array of
256 * 256 * 4 = 256 KB which is huge. The new function
is more flexible in the sense that the caller can decide
the upper limit for cards and domains to be stored into
the status array. So for example a caller may decide to
only query for cards 0...127 and queues 0...127 and thus
only an array of size 128 * 128 * 4 = 64 KB is needed.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_api.c | 26 ++++++++++++++++++++++++++
 drivers/s390/crypto/zcrypt_api.h |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 3a521e65f3fe..fd9666ae1d26 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -1330,6 +1330,32 @@ void zcrypt_device_status_mask_ext(struct zcrypt_device_status_ext *devstatus)
 }
 EXPORT_SYMBOL(zcrypt_device_status_mask_ext);
 
+void zcrypt_device_status_mask_ext2(struct zcrypt_device_status_ext *devstatus,
+				    int maxcard, int maxqueue)
+{
+	struct zcrypt_card *zc;
+	struct zcrypt_queue *zq;
+	struct zcrypt_device_status_ext *stat;
+	int card, queue;
+
+	spin_lock(&zcrypt_list_lock);
+	for_each_zcrypt_card(zc) {
+		for_each_zcrypt_queue(zq, zc) {
+			card = AP_QID_CARD(zq->queue->qid);
+			queue = AP_QID_QUEUE(zq->queue->qid);
+			if (card >= maxcard || queue >= maxqueue)
+				continue;
+			stat = &devstatus[card * maxqueue + queue];
+			stat->hwtype = zc->card->ap_dev.device_type;
+			stat->functions = zc->card->hwinfo.fac >> 26;
+			stat->qid = zq->queue->qid;
+			stat->online = zq->online ? 0x01 : 0x00;
+		}
+	}
+	spin_unlock(&zcrypt_list_lock);
+}
+EXPORT_SYMBOL(zcrypt_device_status_mask_ext2);
+
 int zcrypt_device_status_ext(int card, int queue,
 			     struct zcrypt_device_status_ext *devstat)
 {
diff --git a/drivers/s390/crypto/zcrypt_api.h b/drivers/s390/crypto/zcrypt_api.h
index 06ff697d171c..92027304f0d8 100644
--- a/drivers/s390/crypto/zcrypt_api.h
+++ b/drivers/s390/crypto/zcrypt_api.h
@@ -172,6 +172,8 @@ void zcrypt_api_exit(void);
 long zcrypt_send_cprb(struct ica_xcRB *xcRB, u32 xflags);
 long zcrypt_send_ep11_cprb(struct ep11_urb *urb, u32 xflags);
 void zcrypt_device_status_mask_ext(struct zcrypt_device_status_ext *devstatus);
+void zcrypt_device_status_mask_ext2(struct zcrypt_device_status_ext *devstatus,
+				    int maxcard, int maxqueue);
 int zcrypt_device_status_ext(int card, int queue,
 			     struct zcrypt_device_status_ext *devstatus);
 
-- 
2.43.0

