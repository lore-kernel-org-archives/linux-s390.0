Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D3E3FBA7;
	Thu, 11 Jun 2026 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190086; cv=none; b=hwhdBLU3PqCkPUccTEGwVrGmiNSOp75I0Vs37QywyHGm2Og1VDmgIoWeH18sxnp4SIXKVcN1UclxsDJ4bo7MGBx3DdA4PdYcBbWXtlhS968RvSrXrVcxKtYLoKEVIbRVjFf+NiDZJV+WsD/oPXM62fB7XJhPMXFofCjuB6KlfuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190086; c=relaxed/simple;
	bh=VA5KVvwur9iWnMNNWccE9qYh6ULqQoRyTKFgLMCx0oI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BF1gNSQOb7MjYGEl93G4NBFuXmF8IN+k5TpHkJvvrlxTY7ZmPQAgYE/nOjZkEgiblEu0bYdeneWxrJR93S4XkymDzEI6U2J9xAAUlT+rfuVbhBMV1+GEMcphItN8w4G7uhdoctlZ0Hhzj7w3jXZpoMng5MjpkBrMVIJcEZ9Qxis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Vp5xuhIr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Vp5xuhIr"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BBtUrs677336;
	Thu, 11 Jun 2026 15:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ctq1i4SApRSGZCzF1
	VjufqyCL6LaGmr0M2fU2G1W9M0=; b=Vp5xuhIrZqfr4KAffUusqdn8kKVUynd+d
	55sEDQslXjfBF3v3vQKsi/rcxsvpmWhUYeAZCc0kfG1QgWYaExVqtkpgpNXDsLxx
	TYlLtfUieE7miT6wOJG6xhawWDihtZ6NUpCJuvUv45H2JEpvPYbmxQhkntBKgBEA
	gIaWgVDPjv3plnY2uSs7CLAioZiPvWZnaztdqeXt96BxBIgytGtM+ydQr2ZBraep
	v8TZT3aQFx1sfY2hgICu55iyiGcUKs8h1Ubk2+aG7pYiYuMHl9pThvgz+iPoleH/
	zr2WQ55RCS9igVCmnTNt/wiJFOfecLaa8HIGFOtuBZ+8tiT7JIqog==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8am91t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 15:01:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65BEnetp019811;
	Thu, 11 Jun 2026 15:01:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09knah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 15:01:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65BF1GIp48628028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 15:01:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAF0B20040;
	Thu, 11 Jun 2026 15:01:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C25692004B;
	Thu, 11 Jun 2026 15:01:16 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jun 2026 15:01:16 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 1/5] KVM: s390: Silence potential warnings in _gmap_crstep_xchg_atomic()
Date: Thu, 11 Jun 2026 17:01:12 +0200
Message-ID: <20260611150116.218162-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611150116.218162-1-imbrenda@linux.ibm.com>
References: <20260611150116.218162-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rLnPVC6Iz4pKM23HUKkaCBrIwN9F9JpR
X-Authority-Analysis: v=2.4 cv=TdKmcxQh c=1 sm=1 tr=0 ts=6a2acdc3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=4xVTsJvn8g-7h_O1kUwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE0NyBTYWx0ZWRfX0Ko994dFfoN1
 YGE/L1m/Pa0XkqI03YzfRNOkOssJxrduSyXppGzp+czQ92MfoQUcGBrBpCJZCTZmwqCPpa8OFo9
 /ul8tebN6WaxhdfyPjlim6ao5cyt3zV5sDmrimTAEPEl04oRTER8hVaC5M72JYlKBAFF6Gm37Tq
 KpfKHcCvohuZDTNTJEF10jCWtUapygSoKuWIOXIH7Zm+IIHtm2JJPrehn1UgCNILxgEBmMLx5Uy
 qVSNEE+Wf+16K4SkZCm+L+ndUW0jH0D31xIJm07PEGeRpW0etGftY1wqD7Md5vZQWOn8cX+502h
 qpxDwTCmqu5ipUrnAlhI4DwJQsvtyZZudc38T/uC/NsPTtFfDgO5LBI+E8Su8FyWKzhOwvcL/9J
 YD1FrOhH9XaTwMbE4S2S2MSpCDrF0KDseYv1Tn+wXujCPthWACjLQvi4CtnkcoWQsqnWCiwRM0y
 gglRyaj2E2d829iebEQ==
X-Proofpoint-GUID: rLnPVC6Iz4pKM23HUKkaCBrIwN9F9JpR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE0NyBTYWx0ZWRfX+CHPaMpPGG+x
 eoxlwj+5b3xhdVx1SOv+0+D2YYrOvWvat62OXkuUlkfotX3HIHKiDHCkdcq1T/4/cswbmLhFwgi
 Uqd/cgC+jngougaSazP2atrfBg2evnU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110147

While dat_crstep_xchg_atomic() is marked as __must_check, in this
particular case the return value should be ignored.

Silence potential compiler warnings with a pointless check, and add a
comment to explain the situation.

Fixes: d1adc098ce08 ("KVM: s390: Fix _gmap_crstep_xchg_atomic()")
CC: stable@vger.kernel.org # 7.1
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260611104850.110313-2-imbrenda@linux.ibm.com>
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

