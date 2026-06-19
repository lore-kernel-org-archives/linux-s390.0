Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1D039A046;
	Fri, 19 Jun 2026 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884340; cv=none; b=e1J/VgLVYMWLor8g+yP51ykLVwBwv/AM8ZzCJfzcwUvaBPd2xr98YlLgAdKvwaavuQXqFuUabvZrBuVpFGQWhtD/yeKwqgMh1bJXsbhLOY+6Ne1OJipD39oNA/zsE1tKnOvjcaxP/VyQSTOdT0NpDWH5JhvryULTKgTWdIuYHtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884340; c=relaxed/simple;
	bh=oPjOyf3Hgbx6tuk6sQAUVHzo31rRBbp8eiOdKXU7eDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8PjZ/zoW1jGpn2HhFBPWOwd6WYx0y2DZcHgw06GWJbbfmFdu75YhfjCKYAaFvFj4ouSgNb971Z7xWBkFaofNF2Zd9NZlryJxLgonGWT7fnWNWdGvnruh22xlHRbG3uRCFFEnlBHTftZn6AHJP2awTYuIWopb/1ovOiGBA59uTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JVx3DJkp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JVx3DJkp"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JDITRL2292954;
	Fri, 19 Jun 2026 15:52:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=eXfq10rdjq2dwJz74
	2ligmWaaqJDzL3+tscnHm/Avgo=; b=JVx3DJkpX9EFeTsP2QtxhhEDOpBNv+1ZZ
	DBvBePxVPYuvxYlXG4qZPYyAU+qlBNAEWirQGflrBzHZkf1JC40WTV7OsUEFwPvh
	wLA8SKWx641pILnUswomohVH6v6DWRNxJDGPe5H7zCiCHF77N6NhhG3IMIZQBBFK
	RYAONdF2DgmDgWGyXtD7q2v7ys5kW6YDZevWvTfEOHxNfXw+4h1m+w9A2chwiWm/
	0UPYzZWckhoPAKYjUTjh2Za1oYOiQYdKLfNGcZZDEEMKbSMON6HBFodpRvH11YrG
	VrXwOUPTGUIXnDNiYetVl2RmaYbn34CEr+Oucyf6NSzp5yIOLJKFw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxe8a3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 15:52:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JFYopi005764;
	Fri, 19 Jun 2026 15:52:04 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev1729h7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 15:52:04 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JFq1hJ50069922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 15:52:01 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2EBB2004B;
	Fri, 19 Jun 2026 15:52:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDBDF20040;
	Fri, 19 Jun 2026 15:51:59 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.54.29])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 15:51:59 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        hca@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: [PATCH v4 4/7] KVM: s390: Fix code typo in gmap_protect_asce_top_level()
Date: Fri, 19 Jun 2026 17:51:51 +0200
Message-ID: <20260619155154.307572-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619155154.307572-1-imbrenda@linux.ibm.com>
References: <20260619155154.307572-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE1MCBTYWx0ZWRfX2OIcODU+V/0K
 l2xb4eeXSq4MAcKQsCRG0jnyTt/t+tXCO779As0YGyasV3HKWlR8tFc0IPaDpMKeAEvxzb2kSrg
 x6GXtrU/vL73hMrEDfzPZqkQ3ZBspRMG8sUvSWeE0RQo0bGTD366dQOgGJuvgNoVBYb07NyZ5zF
 NPHBMbRPDQ0oX5JqmcqRbVdRUIAU5cTm0u4euSG0xT8ntazuaJOWKYZmqhGDOkr/v3jtsEeI1aW
 XUb3bSD2lvPTL21BVQJjorr+gcIxKk1sE+T1PuLxhiSGkOMtFJWSXbzUI/rIEgEM0kVYqoYXPlW
 HtEUdoqRTYtk+G8VLrFMqBOMeAdbgUPdXWTx08+MoPCUcIQ0pZ9eaqVIgsn/l9Zp/k7GNhumttW
 +AggBCRQ3rboRRWWtnUoLSt6us1e5xb4Cxaw0katcfh+GSBDHbkKehlc+rmLKv8aiK/ch/BY7o1
 znv98SYEdDAc91KDqkA==
X-Proofpoint-GUID: 04Ix9WP7OL407QdGw4UgV06li_sA0nta
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDE1MCBTYWx0ZWRfX/vI2fEta6M5P
 ZKIz0YdnT1zwtI+Ox30xeHOSbi5am4hGA0KH1rEmiwWjsjtnbHQw0Oizv7RnHZqZU52Ut1Yryph
 cBBkV3N3QUw0+pRCacLdQ5y8W1BdjKw=
X-Proofpoint-ORIG-GUID: 04Ix9WP7OL407QdGw4UgV06li_sA0nta
X-Authority-Analysis: v=2.4 cv=auGCzyZV c=1 sm=1 tr=0 ts=6a3565a5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=9Lu97PCYw38bWmK0XoMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_03,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190150

The correct length to pass to kvm_s390_get_guest_pages() is asce.tl + 1,
not asce.dt + 1. It was a typo, which, due to fortuitous circumstances,
did not cause bugs. It should nonetheless be fixed.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: e5f98a6899bd ("KVM: s390: Add some helper functions needed for vSIE")
---
 arch/s390/kvm/gmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 3192f610f696..e6e786811db8 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -1262,7 +1262,7 @@ static int gmap_protect_asce_top_level(struct kvm_s390_mmu_cache *mc, struct gma
 	/* Pairs with the smp_wmb() in kvm_mmu_invalidate_end(). */
 	smp_rmb();
 
-	rc = kvm_s390_get_guest_pages(sg->kvm, context.f, asce.rsto, asce.dt + 1, false);
+	rc = kvm_s390_get_guest_pages(sg->kvm, context.f, asce.rsto, asce.tl + 1, false);
 	if (rc > 0)
 		rc = -EFAULT;
 	if (!rc)
-- 
2.54.0

