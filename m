Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794839750;
	b=oslDM8Hz4ArPp7hopxRztoK8SkzPyyd18FcwaITR3JVQ0xfab1inhPN4GR89cq1gZ5DL
	 OZfa+A6sWFMuOAt9UJgI41TnbAGjGiQP4+Z8yPNp7uS3tK4j8IQ91l5j7TyFKo5EKV8sj
	 gPWhI8jA5+ZnxvYpXxc2OiPTworo0+tPlLrvZcdVweZf8IZEbOqrIyAlWENXVxU3tGYcC
	 2EXLk0j1pCQD4ld1dmWOyItOHOWdX4Av1gEKrwjwcvyI8X0VwoUh+RxkBozNxxZtNdLfZ
	 4sRM806+TwjixFyHa7gC7y5nkr1gkbqWHs6ty4m8QcGHxedG4jaKacLvVz0masc3zGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839750;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=OOu2uOg3nNHVnTZI4x4e1m/72yl1Dr7lftgYc3utijY=;
	b=YOnBPOLaH79hO1J6xUY6901ZCYn4mzDOUktMaDOhoP7+dgr0Sn3lF9DodyKY3i8swiet
	 YaeAn4L4dnqDD93grTn9bMpRAixrifg8q72ejHOrXdElXokT+11hrONMYTN7/ZB/RsGHB
	 /CX7ROku2bMIuQ7WfOVRp367dVZAWagMO0m8F1G/b+Zm23Co6Dm87MR8+uW7Aslk8tQGI
	 QHveH7CS1pq/MF5jeRatHhcWHTx3oXLqPIn2pZU95r8Zr1VNriuHai9M33KZg9U0b4xch
	 eZ04JpBRmEq8A/6J1HYDTkUKv4SZWst4wE/jV575E5UOjoIv0ghisVz4xumh6Bd+vzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LzpVn7GN;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95006606A32A;
	Mon, 16 Nov 2026 14:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95006606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LzpVn7GN
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGDuOun3451813;
	Mon, 16 Nov 2026 14:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=OOu2uOg3nNHVnTZI4
	x4e1m/72yl1Dr7lftgYc3utijY=; b=LzpVn7GNk1DD/oYYq6WFh6qo+zkcU0QxY
	JnDCR0c5LHM4uA8taWFeR4H8mp8QcSIRqN9f+CbTIYvIKrtyrs2ph8bZhJgGzjop
	CAxdXO++FYAGZp43eEB4jKkoMqAuSADDKhNBj3IKFqoivxYiFosR3GWlxBxC6Lnn
	7ff1GPL0e503Do+/LZ4hYEnNCgxy/QfPh3FaseiI+Ur3EfNY5EggNIa8pp4zxM2Y
	KVcJdYXRtFM3L+wBgXfKHJ4vDWr0uH/PV/y7SYTgIStyQP/diDtwe2AEKtVnzxtQ
	IKbbNlnYpbKiKK8e2OqskX+kHPsNYQSAGxihXGDqvOVVSOP3RyfOA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxf9vdkq4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 14:35:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGC4rrL2972403;
	Mon, 16 Nov 2026 14:35:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j00ns922g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 14:35:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AGEZeZt45875666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 14:35:41 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4117520040;
	Mon, 16 Nov 2026 14:35:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D66182004F;
	Mon, 16 Nov 2026 14:35:39 +0000 (GMT)
Received: from osiris.ibmuc.com (unknown [9.111.42.169])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Nov 2026 14:35:39 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>,
        Anastasia Eskova <anastasia.eskova@ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        keyrings@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 13/15] s390/cert_store: Fix max_vcxe_length output in pr_dbf_vcssb()
Date: Mon, 16 Nov 2026 15:35:32 +0100
Message-ID: <20261116143534.158375-14-hca@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116143534.158375-1-hca@linux.ibm.com>
References: <20261116143534.158375-1-hca@linux.ibm.com>
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
X-Proofpoint-GUID: V0fDWP7RL0QyHeTTfUPG2YnGDMI1WPlQ
X-Authority-Analysis: v=2.4 cv=dtxOmFg4 c=1 sm=1 tr=0 ts=6afb14c3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=e72UTM8qqsDSlZ0lbO8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1NyBTYWx0ZWRfXy6yDvaIBwINQ
 ljP0DzHxnRR4P121g5k4Wr0+3nijHvFVlB4ZM7eHOjGx39Kk10ydPx1CSqRUYakmOZ3lr1gBFt8
 yhDDejOst0Ub2b7tkVVhw77WOxiO/7N8Okmnn5cKFw9pZvtFgedAyo7sfs8TWYU0eFrLhbWvphH
 3CxXSOykqgEFczYEe/B29sE5RhFxTCQnzmq80g/NxFkDJy0PQ7ppNTz88xkFHUhMxjCEX7ix8kL
 9QHbRF3N3Gyc4a2dYApOzTj/FeYUOs5sRnRh93MvnR6luL+7i//kGE+a9Sz6vZVQP5nUlYSEKj5
 8PNNZX+sQivn5SXYXSW53ja1NIVvHu+5zlVdiM3xpEEtGA7FoEAKOHnjuKxAFkcvro4LD5jH8CA
 Fu0hLULLR+NRh3qEqU4sm+qFMqIINZYepWACcVBuWGwx1Z+YZ0aFBilzCZcw+oVU5hFDpw44UXF
 dbvVcUTIyCBr97Phuww==
X-Proofpoint-ORIG-GUID: V0fDWP7RL0QyHeTTfUPG2YnGDMI1WPlQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1NyBTYWx0ZWRfX7Ew/0CcXuDVq
 3p39yxIJ9srN8z7lgV+w7wkxsGdMZGtOCM5HMMcbzRbsXjNmuv/URyLupWiOu/v0cklGLq2O8mL
 1uECSdmgnieIOjuy3BB+IAYm+ItDEWo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160057

Print the correct value for max_vcxe_length.

Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/cert_store.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
index ecfb7641d427..996ca3025629 100644
--- a/arch/s390/kernel/cert_store.c
+++ b/arch/s390/kernel/cert_store.c
@@ -225,7 +225,7 @@ static void pr_dbf_vcssb(const struct vcssb *s)
 	pr_dbf_msg("total_vc_index_count: %u", s->total_vc_index_count);
 	pr_dbf_msg("max_vc_index_count: %u", s->max_vc_index_count);
 	pr_dbf_msg("max_vce_length: %u", s->max_vce_length);
-	pr_dbf_msg("max_vcxe_length: %u", s->max_vce_length);
+	pr_dbf_msg("max_vcxe_length: %u", s->max_vcxe_length);
 	pr_dbf_msg("max_single_vcb_length: %u", s->max_single_vcb_length);
 	pr_dbf_msg("total_vcb_length: %u", s->total_vcb_length);
 	pr_dbf_msg("max_single_vcxb_length: %u", s->max_single_vcxb_length);
-- 
2.56.1

