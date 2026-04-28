Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6433C9ED6;
	Tue, 28 Apr 2026 08:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364144; cv=none; b=j2qqi3l30g4LoCaL7P9sOFcKPNJ+zXyhGBsYGaD3On+05e3Gf4mlhTI3utUW+gy6uzd4XnIv5Sod3h7vRHvfQEfg9WWijXicYY2c3gsFAdkp6u3s9308QbbWmwp9qvhOBc6WVZ/jmhqo5S3FYddRzfSM6n9lG4isMcS4ragJ2pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364144; c=relaxed/simple;
	bh=VgQFDMEea3mMz+5elEoxvst6YyPDFFnPYT2Mbsf423A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hn9Ra2WA9haomGBx1Hbg7oxr2h5oVYOTLK7zsfogfG1AualX6wp7VUPUypLkA/roj7ZR5FDMkrKs3Jbz6emrEvZQ+5Suy1IG2oBh6IbV3ag8ukCet6Sqm28i5H8Ixf5WjFyoHuQ+Sy7JGCMcL8eQU/YgngYsmyfoVPNfr0m1Pag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pao8CHSr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pao8CHSr"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S6Otbd3239715;
	Tue, 28 Apr 2026 08:15:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=w8wOOd
	CeK0iTFTicTYdNCSvjIifSgwOgAZqjMAZEG6c=; b=pao8CHSrsbop8n7ZmjsSVl
	oj5aco1BTUa7vUB3JDPA8C5CyES2rtFvmlWNxWRr2RImc7jZU5jsAjzs8/ThZScR
	ltloV/7UNdE/nTFs6aApvkqlk9XBHp+7Ni0zuHbQX3jo1nxIkbvjMRWATIQ0WR8t
	BKNE35JR9v8OmCGUEyojxaSbKOjiT1mhFT5l3JX7oWk76wk3dqezY92OuafnU8B5
	Z2W+fjdVAlPk8RuPLtJpj/YJ2n0aZ2v7gLf9Enb7Sa7z24yL1ogz0Py8eeWWxOUN
	if1PVOLwOEE/IRj6gPK55nQWA7O3RAkZMVkmO4Yh4L8fif1yBKzK8kRQ3v0f04eg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drk1jkjuj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 08:15:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63S88sUe029020;
	Tue, 28 Apr 2026 08:15:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xq8x1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 08:15:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63S8FYPk46596546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 08:15:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31C2620043;
	Tue, 28 Apr 2026 08:15:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 094C120040;
	Tue, 28 Apr 2026 08:15:34 +0000 (GMT)
Received: from [9.52.198.32] (unknown [9.52.198.32])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 08:15:33 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Tue, 28 Apr 2026 10:15:24 +0200
Subject: [kvm-unit-tests PATCH v5 3/6] s390x: sclp: Check sclp byte before
 reading feature bits
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-vsie-stfle-fac-v5-3-34c5933a218c@linux.ibm.com>
References: <20260428-vsie-stfle-fac-v5-0-34c5933a218c@linux.ibm.com>
In-Reply-To: <20260428-vsie-stfle-fac-v5-0-34c5933a218c@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        =?utf-8?q?Nico_B=C3=B6hr?= <nrb@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=764;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=VgQFDMEea3mMz+5elEoxvst6YyPDFFnPYT2Mbsf423A=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJkfcpaoeriZHeU+6XJ58pNdPxUjJSex3t8yI6t35rRaR
 ncOlaKwjlIWBjEuBlkxRZZqceu8qr7WpXMOWl6DmcPKBDKEgYtTACai+Znhn8Z1Y6nzd+f2FXjH
 fYl7ve390SnXTDJEwl4sSdStXKP/zIKRYfe/m5NuTTl4p84u3PRYwZfVwjvs6g338ZmftWAS+7F
 ChxMA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA3MSBTYWx0ZWRfX7BU+Bdu3+UZd
 Wseudq+OC4Lk5S/Q+LG0Epl4bEqgBOaRTkWQO89nyZTDpeUlCKRAN73WjWKX7dkgvTiprBfdz7w
 +TBxDp3NaaDStsrgN11Tz9xoszkbVQ9MhykG54TetTIcFj3kFdEqs9mJJ2w9mV5E3uG0FBpX3J5
 tDLxxsmNutH2t9oEM7ZhDGP81cx4xC3wahse14/y2ay2vp34MlKm4rB14D78J5SXgoAyjFSzjiW
 tRH0uKBwst2szYNR8msAwQz9LDO2y6Ym/mNPJLL9NOAn/8pfBSGxpbNO1YCzI8yXXcOXbYGmgbt
 +7Yd3Tzi1Q35bJN3+eyw5d2an6ctTS2wO3aDMg6steRzgdjCrUqLTJH5KkFApr3vWThRjYkYWWO
 oVwnmrzTFKYoAdf6mAtXWXMKOny7q2rUzMeFE1VlkHvIgidrc5a23/uqvjJSxWWDo+HbZOF/9ZM
 A92EnKRebtM+k8mo+jw==
X-Proofpoint-GUID: GmpY6RUbIwbTktk-fdJt3YV6OegKvni7
X-Proofpoint-ORIG-GUID: GmpY6RUbIwbTktk-fdJt3YV6OegKvni7
X-Authority-Analysis: v=2.4 cv=MohiLWae c=1 sm=1 tr=0 ts=69f06caa cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=h1e9RfFzl8Kq3L4puskA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280071

Improve the readability and simplicity of the code in
sclp_facilities_setup() by moving the check for availabity of feature bits
into sclp_feat_check().

Suggested-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 lib/s390x/sclp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
index 2f902e39e785..1ffcf448e558 100644
--- a/lib/s390x/sclp.c
+++ b/lib/s390x/sclp.c
@@ -142,6 +142,9 @@ static bool sclp_feat_check(int byte, int bit)
 {
 	uint8_t *rib = (uint8_t *)read_info;
 
+	if (read_info->offset_cpu <= byte)
+		return false;
+
 	return !!(rib[byte] & (0x80 >> bit));
 }
 

-- 
2.53.0

