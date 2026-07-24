Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419731E9906;
	Fri, 24 Jul 2026 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784913639; cv=none; b=OHkoPuZwQzFObB/C75FMAyNF3lN8yC9LUXh9jauS+yDunntADoWaf2cAbdwg2cJrk+3XJZsXO3rIj3SEnVAWXX7Ns/TY5gd7H3gHvkWsXNn2VlvT/pOVov80YD1//kC1z8VWuG5HTcdIhKI86bXXgL+1WV27Nf/mZzfMkeoZMhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784913639; c=relaxed/simple;
	bh=F6EPhn4D7yRtGRsiR4G4CQeG9B089+lPX3nW/Giv13k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KleUnjbdPkNY+HdrN6gP58bDP4YCnFK7p1D58R6V7w78vGc1vWdkTmDMr0bjNokG0KxfvPLy2nh7UHahHP0f8Kg9vkHKH6LGjdjqwyn0+3lrvQU8cDD0O/cYtZ8RHZ/C3LrB8waYdtvfPC+zX17bCpmB3m7pLRlHkkU+dH2f6eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZFBOR8QF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZFBOR8QF"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODfgIG1992890;
	Fri, 24 Jul 2026 16:14:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Q53JyTInkQbpzOZiA
	29V6fcw0t5yC8ViDTnjFXo/AvY=; b=ZFBOR8QFeER3o7TE7eGxg8g28ARmGGcfa
	1oEe3U5KHIGZ9IBejuOC/MHjup2BOeZO9cfsvvwUbjHSHtUrmCLtf9M6a8O/10Eb
	siQQgVei+rZ4hKmI2vF2K4I8xoen6e2IAtX3oLg6YxT0Dr1Fl2FNdRKmj1FRsC8E
	fbw51pbt57PhuQtFTuBH5BQVQwalyZqSHXTlG6Fnjp7s2zSnAtp+Yzfej/wk34SM
	CoTAflxOirYdE2Gv//ivJFDoEnrz750UfmWAKlB7DKYy5aQpMHjXONL8lQgmB6q5
	sNzYNoBgHjTVWTDOYSlxpGKBhgTmitBX1vgtJZntNBrFAI1ZtdY6g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8h00u20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 16:14:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OG4cRP028401;
	Fri, 24 Jul 2026 16:14:16 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk9n2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 16:14:16 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OGDc8f56164716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 16:13:39 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D604558055;
	Fri, 24 Jul 2026 16:14:14 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5313F58054;
	Fri, 24 Jul 2026 16:14:13 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.50.28])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 16:14:13 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v5 12/15] s390/vfio-ap: Transition device migration state from STOP to RUNNING and vice versa
Date: Fri, 24 Jul 2026 12:13:48 -0400
Message-ID: <20260724161351.1802644-13-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724161351.1802644-1-akrowiak@linux.ibm.com>
References: <20260724161351.1802644-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LdcMLDfi c=1 sm=1 tr=0 ts=6a638f59 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=YI3AHy_hWZklpQ5N57sA:9
X-Proofpoint-ORIG-GUID: mUrjqAYuCsnLb4Ra9gPAAPWfrD0I4Tbq
X-Proofpoint-GUID: mUrjqAYuCsnLb4Ra9gPAAPWfrD0I4Tbq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE0NSBTYWx0ZWRfXwthOsP1p02yh
 cHrXXeR/X3AaIAr4PKfx3ESUYFSaCBiW/WpRJ0SRkQtjeCWPT1+3JUqRGh2h5oaLHGfVOqTkAFg
 sM7n0LX4de7bwq9eUto3axCfco1oeGDQ17Tq3SQgDPSLNA51A5PwQYDZl5zQMhdKRsmwrFlE3yM
 NA8zFVgK959ZzMJjanlqtWV+S2L1tkEc83io+gMEb56b2wf0oJSvWGMUfhP7H2wcMkbWl2JsszQ
 G69VBgHsR5+Jh/GSMSvKmTdSSoaP+k/pcBfJ2zi+M19GRpkxW9vNUlVisYYQPZdZ/iE/id4YUY1
 2krXc0ZvpTW8dDfTdRBIyRJ79SYKsqmwN3b3CZ2uZTdiJh1O1bEL2M46diHE6KCi3RxTx2peiib
 RbetPKHVF1Ebq3TjY3n4DKQd5W2/0G05nbkf92e5MsbOk49/h6uAZ/J2uH7VcBI/QpXljBgCLNz
 O2cyV10kw5xI23KfCGg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE0NSBTYWx0ZWRfX9TqeoqycPO3a
 0JzebIVapBoseLiUb25FHEHV+nWCayfIY3QPxyGwM/ef7UjD8zUGHUQz5oFeyEzoj/QccGYmMiB
 GHfQcBiUf8ftLqNeUxOmzSCMtKwSm44=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240145

The transition from STOP to RUNNING and vice versa indicates that
the vfio device is operating normally and migration is not
currently taking place. In this case, just set the new state.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 21cd9810a18c..8876338d2898 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -1317,12 +1317,17 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
 		return NULL;
 	}
 
+	/*
+	 * These states indicate migration has either not been initiated or
+	 * has completed and the vfio-ap device is operating normally.Since the
+	 * vfio-ap device does not virtualize a DMA device, there is no internal
+	 * device state to incorporate into the vfio-ap device on the target.
+	 */
 	if ((cur_state == VFIO_DEVICE_STATE_STOP &&
 	     new_state == VFIO_DEVICE_STATE_RUNNING) ||
 	    (cur_state == VFIO_DEVICE_STATE_RUNNING &&
 	     new_state == VFIO_DEVICE_STATE_STOP)) {
-		/* TODO */
-		return ERR_PTR(-EOPNOTSUPP);
+		return NULL;
 	}
 
 	/* vfio_mig_get_next_state() does not use arcs other than the above */
-- 
2.53.0

