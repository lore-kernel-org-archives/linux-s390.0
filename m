Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB08381B07;
	Fri, 22 May 2026 12:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453003; cv=none; b=rXlYmRR+Af3eilTndvoVnMpBI1goBxgES527tefDxjJ73IMuVnkkkE3sLJDn7Z+xTmGlU9+2HeXqf4tja5fwinqxddnkd10Ja6Q4OK4xINlPvZ9LnM26VQt64z7XP5Yh4L8W/3ZJUtZEBBMNLcgL6u3fEq2ngG6Wta7mNk7bhYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453003; c=relaxed/simple;
	bh=Ro+JCYUCcmOA+oDrVC8ScyrsHY4m9sKKvealh6hANHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ElsSw7GGIpnmMuTqphBIiou1d7oaGNemG2UMjrsCNB//+1H0OdK/fU6eLfB0hrg8pKnOAvLAY4EmqYy9uzwbR3zL4VjUx3GQWsB3D+J3y7M5jXUgOFotKH5v/Utf67lAry8SX5FCimKvOy8/U9mRfm0x5Sbvv5+wa/9A+4bIKzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YreHqbBX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YreHqbBX"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M2YH4d2070048;
	Fri, 22 May 2026 12:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gBVzvhrwuJywnN0dc
	pD0B2Ix0w++FknjeU5C3syWs4Q=; b=YreHqbBX6KVUBGVvpouLE0nh5aGSZERPe
	QVXFY195QK30DuOnaXjwUyLiZIpzXbIXUbI6eYrnSmHdR2N9gMRjzftejiREuBsB
	bdJK1U0V4xD15E80ikqQBsfjvIwsv8mdrzfIAl3uD2uXbI6ZjaxAPMie2NH4q93W
	dz4HnSzjMW/MJKeJky/Mvbgsr8ImoviJju/dwmsbHgnJXWkPjcg04LZumCfn9AcN
	Ia2sHD+/5NtEO8WSqOQBe5CANi4Xbt6zw78kpxtFn4WwgrMFm9MetK+kkfUwCspv
	G8XiYe7Qg+CacB/FOhHFrCVN1HYQOLoYzv89XQX+TraGgtHyOC1ZQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h88tdec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 12:29:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64MCO6aX015292;
	Fri, 22 May 2026 12:29:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wqh2p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 12:29:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64MCTrCn54984996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 12:29:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46B4520040;
	Fri, 22 May 2026 12:29:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04E2220043;
	Fri, 22 May 2026 12:29:53 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 12:29:52 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 5/5] KVM: s390: Properly reset zero bit in PGSTE
Date: Fri, 22 May 2026 14:29:51 +0200
Message-ID: <20260522122951.117120-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522122951.117120-1-imbrenda@linux.ibm.com>
References: <20260522122951.117120-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: shJBZ2Q-3H8QVYvgesW3SrekFKnxzr8j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEyMSBTYWx0ZWRfX1PMqALLSyawN
 LLAd1dyQKl8J1kDzEMybXQEeKf7ffmi9ISFPtVCFrUuV3ilJJHtLmjmkit6o46VlSwbscMtBbEH
 UwDArNkOKvbTqbdozjtH2mJgnR7c1DKgE7CzZBb4gd6ASHCInf+T50XghL3mJ/u+nREWVBQXv3F
 QNCBclWS3TH4WFRXJE1xh9UYk2peKClWRzpXKIeEh8dE1QfYNXmWDaAdWZTgIGOWO+DO/Iq4k+j
 YFO7UmBuZ0gwBhDLRwtPJJV3PBafX+jqy4AMif9y/DmRPX8LMdEmYE3XqeFUQ5sd2mNYy8YaDhF
 nXte7Z07r5bkrCIqufHBZXH2/wQ3m1hFuvwFDteTS4XE6xMzwRAju53CrgljouxPqYBXmCLPJB2
 07vc0NvodtX3KjqvgcIvySsKQDFMrUmXeQ02OPDPehJPSmQtUmhoj27Xuj2plWdppKDL75gxuoM
 EB0Zrls8YbLXFsm9dlw==
X-Proofpoint-GUID: shJBZ2Q-3H8QVYvgesW3SrekFKnxzr8j
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a104c47 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=P9Cbi09riAs7zLUs0OgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220121

In case of memory pressure, it's possible that a guest page gets freed
and then almost immediately reused by the guest. If CMMA is enabled,
_essa_clear_cbrl() will discard all pages that are either unused or
zero. If a discarded page is reused before _essa_clear_cbrl() is called,
and the pgste.zero bit is not cleared, the page will be discarded
despite not being unused.

When calling _gmap_ptep_xchg(), always clear the pgste.zero bit. This
prevents the page from being accidentally discarded when not unused.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/gmap.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kvm/gmap.h b/arch/s390/kvm/gmap.h
index 6e51ec6066b4..742e42a31744 100644
--- a/arch/s390/kvm/gmap.h
+++ b/arch/s390/kvm/gmap.h
@@ -220,6 +220,7 @@ static inline union pgste _gmap_ptep_xchg(struct gmap *gmap, union pte *ptep, un
 	}
 	if (!ptep->s.d && newpte.s.d && !newpte.s.s)
 		SetPageDirty(pfn_to_page(newpte.h.pfra));
+	pgste.zero = 0;
 	return __dat_ptep_xchg(ptep, pgste, newpte, gfn, gmap->asce, uses_skeys(gmap));
 }
 
-- 
2.54.0

