Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794839755;
	b=vZrLvU5JyssIXh08nyfZ6eyyyqTSkXiGKJAXu9B9swFdQVn25OdDvJMW/grZijWgYU2g
	 fltdpbqqXutRYNnzlKn7+Kbwjut+/aPt1h+Lm6pVa+h88S4IoREwcjtH+ueW+F3h6WOOM
	 VIsocHhytIfe3qql4zm89rzcui3xFKxw+Ln0fyVFNdElnjuON2VA1yAP10v+QRaUINDOI
	 Kc4pNjNQgsRLeXDMahUf9KbHTkO/A3n7hlIwXan0EV7H27wgixiV3sGYq6T9H8dWuiNF3
	 s3DSuuN1z9i+sJxGAFGkGcuzwtfHWKkb1FbCOVkjrMa/YIjAtp3a2FE8jbdItDsKHBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839755;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=IFfGupRSOM6RObjQsqq+1Bvj6vi1N0aWq+3O7ZbwXkY=;
	b=TrQpAl5z5QG+rQmUnWhixnnYA1zZuSquGjVjUvnp2ZhQnviMuhDb/v2e0GMIlfB+4XRr
	 U12ERUOhNiGMDu8esNH7Q9299ZvlDCSmTfWhTxBbVnW1xF+OqDXcYuN6aoNWHhAqt9CBn
	 7yRndU2lc/W3fMIVqh97gVnDxPyWsuJGjhWKhK2j+TObVckl8Vo1PLlgY8/MNwTZzKLjO
	 0Dtvs/8CbauxJbUvFQMagPYBwjd2cqG59Wf7t9MZWqxVP+RUl6zvzkdcymln5eU9hwVoA
	 V1ONWlOh/H/wfM95ChEM6W5GMby8340qAiGs1QE/yUCdrQPrfc+6mzobxH/cnsfvE7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=phsX+ihY;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF15606A31C;
	Mon, 16 Nov 2026 14:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DF15606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=phsX+ihY
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGDuOr83631009;
	Mon, 16 Nov 2026 14:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=IFfGupRSOM6RObjQs
	qq+1Bvj6vi1N0aWq+3O7ZbwXkY=; b=phsX+ihYe8yPjOEZqP1mNscC0hu5UAj8o
	p3De2jrg2uxBtnan/htV9gRhdSyCjqOI/9z8TIV48ff4WtgHBBblfFnPMS23t7ov
	kjhcXAVa0PCWtO5cqD7ylPloFkGM/D3a+rRZZSCRlBN4WhKtpuMfi2fOqChUV2Um
	i5UaIpWjivIIRWkMGX6Ve1thIvfemE4SxzZj0aR3/IaAHoKaewxqo0e962l44RCa
	rxUYeT6+HB8B2ImWMf+XSE1/oxcoBJ0QU5WoztTmo75zKc2RRKqYm1OdLcDDTHtZ
	W3i9gsP0jeIk3cPRrM+/jrv5G+iwC1jHcJqzCyhla9qt80/PXbwBg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxf5665p4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 14:35:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGD54gq3095320;
	Mon, 16 Nov 2026 14:35:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j02df8e9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 14:35:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AGEZaad40894942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 14:35:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 077B52004D;
	Mon, 16 Nov 2026 14:35:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BC9E2004B;
	Mon, 16 Nov 2026 14:35:35 +0000 (GMT)
Received: from osiris.ibmuc.com (unknown [9.111.42.169])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Nov 2026 14:35:35 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>,
        Anastasia Eskova <anastasia.eskova@ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        keyrings@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 03/15] s390/cert_store: Fix potential use-after-free in invalidate_keyring_keys()
Date: Mon, 16 Nov 2026 15:35:22 +0100
Message-ID: <20261116143534.158375-4-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1NyBTYWx0ZWRfX4wnFupbp4y9M
 jVA/+dtpbEmUxy0vUpQl1PWRk3Sb3kEQQ4NjxjtvFW3l1LaFETQrUERTiVIH+3l859ekFMvn7le
 5oqy0/R8MopLayOOtAarnWrd2Ayp9wI=
X-Proofpoint-GUID: HAAcoJ3OIXQQXIolekqN36c33koh4Rld
X-Authority-Analysis: v=2.4 cv=ROImjIi+ c=1 sm=1 tr=0 ts=6afb14c8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=mREcNca6LnAChypJpT4A:9
X-Proofpoint-ORIG-GUID: HAAcoJ3OIXQQXIolekqN36c33koh4Rld
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1NyBTYWx0ZWRfXy31OkDlkaMs8
 aXmj3/N3bgykt0M10IFW4XUlrIyhMNZ0x4OjTPqldp3FyfPRjJsIB22UWO4KK5TfuPz03Pfo6cx
 +8zAHe6WlWvurtZ7TGSMjhABtTe4jJB/CM3YErikDlJVmT+6l3xzSY9on10wJdAQ7ICnDLAdJf/
 OZhQX+k8vUeCblTo7kMh6uzJl5hltvLqif2bfNAdM/SHxWRabY2L0aUnNHrvNiPQ0UheKz6osjN
 3Zcg/lO4TDJXQMTY5BOEKiJ3yHMh94opnXkpHqA487JKRNbDeOzTL7RSK1PhFhBt/fZmOdol0vS
 1WkscoA51J6IQu+6aLNHRC1mG2LBfD+NPA7RvlFz8JLlPK0x2VpgRDJ/Ndjov7vciP0+Mi7/+lB
 roZY9aqeUWfIUIqa3OR57Ha4LPPRaLl409SSEDfQKao2k0naMqmITQQk3YIj1O75AQ3D6tke6qH
 fIWFRfHELUQ34O4p8xA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160057

Drop the refcount of current_key behind all users of current_key which
dereference it, like e.g. error logging.

Fixes a potential use-after-free bug.

Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/cert_store.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
index 89cc3a1683a3..e5060777ce6f 100644
--- a/arch/s390/kernel/cert_store.c
+++ b/arch/s390/kernel/cert_store.c
@@ -344,12 +344,12 @@ static int invalidate_keyring_keys(struct key *keyring)
 		pr_dbf_msg("Invalidating key %08x", current_key->serial);
 
 		key_invalidate(current_key);
-		key_put(current_key);
 		rc = key_unlink(keyring, current_key);
-		if (rc) {
+		if (rc)
 			pr_dbf_msg("Couldn't unlink key %08x: %ld", current_key->serial, rc);
+		key_put(current_key);
+		if (rc)
 			break;
-		}
 	}
 out:
 	kfree(key_array);
-- 
2.56.1

