Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C721743BDDA;
	Mon, 24 Aug 2026 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582306; cv=none; b=OHfK5x02UrJ5dMRF3UdmIV/A28k5OWKnomR+uHjIQQHbVAlh5zPibm3SHCvLVAx2Yp1tZcu9NuOTfKsKEH8EEzgwDd/p68lQw7uSDKD3z6bI66/1NWGQdJD6Ccw926hbkV4FfT12Vp4a6G+T2yxBvDsVu5omNCaOVdvtIy8vcTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582306; c=relaxed/simple;
	bh=DorWWjqxw8qNCzmJvjIcmD4peyKrul31Eg/D9TC9B50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C56leqS74zV4BFolr4L2V9fb3IQ8QD0eHPPjdcJ4bomtggtaYPB44Et3/a0q1A2bQaaP5cA/KHEjjdBVVzqEJwlVTdciE+dyMnwwXR+55mCzfB71MK1i5WLajt3qIb05e1YKLQxToSlUp3CsZU06xootHrpyLEoiq5ejyHwcL8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jGgn15Or; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jGgn15Or"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OD1dTf2004259;
	Mon, 24 Aug 2026 14:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0Sy++6CSyKiadOldq
	yr4crd2HHTMF2389h4VHSi5X3o=; b=jGgn15OrepBn7etUkIApHB9M0izS4bTx/
	jguosf20G5/nvpCEraEBtZbBVFm7gg98N+zrcA2Mle5XjmWjNYRH/ugvlx1Fk+WL
	VMCf724phk3VNUJI3SgGpnKV2G0hIS5lGBrHMW6xJU+UTUJI3aYgJTiuuDSKc3R8
	EKD7uLWVRTj1mzxDPJI3/1DfjAnpIc66IqOnwIPlVVaHoboNZU7+k9ul1ByhZEM/
	pl7A+QGgUEU3fyU9l13ZGx4di5ASyQB3eGzfdFOPFgHNS+zEqd5aVk/zKD1/rlnL
	J7MyWM1Ix1KmEpWT6poJuWNYVraqP0+vpI5bgEJvMjpv5J6OWF5zA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dx1u5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 14:38:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OEQL1j001477;
	Mon, 24 Aug 2026 14:38:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfvxnqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 14:38:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OEcGMU46661930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 14:38:16 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8388020043;
	Mon, 24 Aug 2026 14:38:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 581192005A;
	Mon, 24 Aug 2026 14:38:16 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 14:38:16 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, frankja@linux.ibm.com, borntraeger@linux.ibm.com,
        linux-s390@vger.kernel.org, imbrenda@linux.ibm.com, thuth@redhat.com,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>
Subject: [kvm-unit-tests GIT PULL 06/13] s390x: sclp: Remove unnecessary padding from struct sclp_facilities
Date: Mon, 24 Aug 2026 14:35:38 +0000
Message-ID: <20260824143740.291583-7-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824143740.291583-1-frankja@linux.ibm.com>
References: <20260824143740.291583-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX0ONZ0eiArLwT
 znDPab9OW+t08TKBamQ3rAlKUL5GKoWX/Zwh+KD7EGaB8iWJ/Ynm/t0fDkiz4CRPLL0FgKJItd8
 7gGpt17gnzvUsYaHLO9icj/3S7txlNw=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8c575d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=LqyZBc1Dag7_ZHf_o-UA:9
X-Proofpoint-ORIG-GUID: mw7YA9KGUWCch3RcBRFPQ2pUQli2nyJY
X-Proofpoint-GUID: mw7YA9KGUWCch3RcBRFPQ2pUQli2nyJY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX+yd8HED+hAV/
 D10RCpbVB8DwUe8ZdT+dA3BdMA64RCemaq0t2ZpdbH5rjTWEsDgR7CjpfgvPQ9rHWkKXj1TY9SV
 G5PzMwDV6oS/Q4lR92AvBoQmiEc8yem5kqB6lPeQY/MrH9jLaNMJU3BwRKw0UYV8c4Si0KENM8I
 0OQifOmH6MTonPJw3T57XnR9ErKAXbB6NMjgF+Nyyk0jwdinZxRmqVCZnmtR70IGQDzBWUtCYHe
 4e59G24nuxumF2nPB2CF7O3vYV4YqHrQq9IR5k746TpTh0Au02xVsSWr7B/FiGicxtRFv+k//eM
 Py6KLGo6WUs+LukZ6zvecIDrdiD68jrWv4R8SEpdlkLY+eAcnmnsGDIcyOguAZJD/MQlYNR7nbL
 9R53aFEzCEn4GNx/4z1jZN/bHqLGlzRbVhcuGlpqP93GNeJzUavOlrMKUmCTGi7c3tvPziLe3iG
 ytXXIcp2J6yM7BayvCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240122

From: Christoph Schlameuss <schlameuss@linux.ibm.com>

Struct sclp_facilities is only used within the guest to keep the facility
information. Nothing bad should happen when the struct size changes in the
future.

Suggested-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/sclp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
index 22f120d1..42a2f2e9 100644
--- a/lib/s390x/sclp.h
+++ b/lib/s390x/sclp.h
@@ -132,7 +132,6 @@ struct sclp_facilities {
 	uint64_t has_kss : 1;
 	uint64_t has_pfmfi : 1;
 	uint64_t has_ibs : 1;
-	uint64_t : 64 - 15;
 };
 
 /* bit number within a certain byte */
-- 
2.53.0

