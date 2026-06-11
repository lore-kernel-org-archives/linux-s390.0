Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27848242D67;
	Thu, 11 Jun 2026 10:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781174942; cv=none; b=FVh8xoKtHTheGDu0o02xG0ITnBGs6nX165PLm1XfdobsPXInSziORjXbGtgpQNs9vC8tU1VQ5z/aKE1RhBSZNVzIS5vAeu/lvDB5bQsjiO984GvlUFwZFic0HzhfIK4aJS/KW6tE6QgMdlo7L00DJ5ajooaiu6co29ca8DM1wA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781174942; c=relaxed/simple;
	bh=FDLy1BGQO+w9DStrNektS2alXBoWqeTa1GWUcs6Szow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SYUuHleAAhn3QyHamU6SMuYddY44NGw0NKWzCQu6fqWZrPbosR4mjRZ2/g1kcCRlsdOpW7PTcxY2Iv1KfcHk/zLCUJMH1gw+a+YQRzyXXzUs2VjLRgLgCZrUUhKLeWancrUIvttie/KptjFAfxTCqE8gwgpRy73U8+/bR7+BGRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fWDy9Axm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fWDy9Axm"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AJu3oK1363798;
	Thu, 11 Jun 2026 10:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=b6mCg6pnc58br7ZYF
	XzXHqfVSwYRPg2iIm7vCGixyXQ=; b=fWDy9AxmGCXna756M+TMGP/A7HPbgvZWn
	tTPhIqrsiRTAQTLKo8W0GPK6iHr+fOGkzHzqRabaQhyZca2mrssMfh/bOLEHKYIr
	wsWjMYqt/8Q1f+u9FF/QaQgG9jgOkLwNAm1Da0cBXeYvP370i66KKAqLiuKCwyI2
	PN4Ui5FKKIGUSD+N4dDyiLILz/YrohlLIQGNh+RIOfvi4pUmDeMav8whobEmi6o3
	aNVwZlRLad/dKq5TQg89qeCt7vcJ91tiYYnUvhnpq3QQp4mHuXgkNxP35t/xyCON
	Neyre9PbB5mBf/A3PL/B1K3OPI8iTEX4Onf3KY7t3G+kv+Yw0aSdQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8dtuvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 10:48:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65BAYcOH023927;
	Thu, 11 Jun 2026 10:48:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe08ttdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 10:48:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65BAmpij42009080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 10:48:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79ED320040;
	Thu, 11 Jun 2026 10:48:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 530CB2004B;
	Thu, 11 Jun 2026 10:48:51 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jun 2026 10:48:51 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        seiden@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v3 1/5] KVM: s390: Silence potential warnings in _gmap_crstep_xchg_atomic()
Date: Thu, 11 Jun 2026 12:48:46 +0200
Message-ID: <20260611104850.110313-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611104850.110313-1-imbrenda@linux.ibm.com>
References: <20260611104850.110313-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PnapbeO3CmeFA_yx7AGcF4L_XZr2a3LU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEwNiBTYWx0ZWRfXwcYa/Nx614bU
 jEAw85j6LIElQD+5ZabOUL+pEqQbS05yz33LR8YW+oivoqB4mhwrX1F4MjEozNbka0aXaaFWBDx
 x5/7WPovsrB3doIr+XW/pCtND1sCtk4/GGaXIHm2J9CkRd1Ixu7+xz8JXgLePGIquz2YxmnIrok
 IriRml9WS5EYW7SCIGjs5Tw7gnwnYxijjp/i2n/Pfl8Yk/EDKaD8aV2prE4bmv4OiE6O6qawXY7
 UO7e/4G7L/X2Q3W6T+5iSYNcgZ4H+KXxodX3FsbAK+VXchY1mlC9Y4EtJzbvbqHKQtcCtkgNwK0
 8lO4/Z98xsD9FsO4DBjAZDNbH5sho9s65qkndf9R8WeFvXdKm/JqO26FfwBRrxzd5pQ5f1sB7J8
 SfBa/5mm9+Vy+LZs5Xb9lpmF31kkfId5GWNX0YADNEA3wU5DAC6Fm6kCA+hToav21YlscEY+ral
 o64kkyDXbiHhw1+X/zQ==
X-Authority-Analysis: v=2.4 cv=DPu/JSNb c=1 sm=1 tr=0 ts=6a2a929a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=4xVTsJvn8g-7h_O1kUwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEwNiBTYWx0ZWRfX0mNsZuNaamjF
 i8fW97BS3EfXcz9CwgjPZLS31cxuOXxsZDptJENolBchvKHk2UtH7Oc3W9AbPvQwqamj5P7jH1a
 80sU0qp6YOUzHTkvhizxwhqemejaiWM=
X-Proofpoint-ORIG-GUID: PnapbeO3CmeFA_yx7AGcF4L_XZr2a3LU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110106

While dat_crstep_xchg_atomic() is marked as __must_check, in this
particular case the return value should be ignored.

Silence potential compiler warnings with a pointless check, and add a
comment to explain the situation.

Fixes: d1adc098ce08 ("KVM: s390: Fix _gmap_crstep_xchg_atomic()")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
CC: stable@vger.kernel.org # 7.1
---
 arch/s390/kvm/gmap.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gmap.h b/arch/s390/kvm/gmap.h
index 5374f21aaf8d..20881e3ce9d8 100644
--- a/arch/s390/kvm/gmap.h
+++ b/arch/s390/kvm/gmap.h
@@ -279,7 +279,16 @@ static inline bool __must_check _gmap_crstep_xchg_atomic(struct gmap *gmap, unio
 			gmap_handle_vsie_unshadow_event(gmap, gfn);
 		else
 			_gmap_handle_vsie_unshadow_event(gmap, gfn);
-		dat_crstep_xchg_atomic(crstep, oldcrste, newcrste, gfn, gmap->asce);
+		if (!dat_crstep_xchg_atomic(crstep, oldcrste, newcrste, gfn, gmap->asce))
+			return false;
+		/*
+		 * Return false even if the swap was successful, as it only
+		 * indicates that the best effort clearing of the vsie_notif
+		 * bit was successful. The caller will have to try again
+		 * regardless, since the desired value has not been set.
+		 * This pointless check is needed to silence a potential
+		 * __must_check warning.
+		 */
 		return false;
 	}
 	if (!oldcrste.s.fc1.d && newcrste.s.fc1.d && !newcrste.s.fc1.s)
-- 
2.54.0

