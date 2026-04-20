Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715D138A729;
	Mon, 20 Apr 2026 08:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776674987; cv=none; b=B2U+G6OLlrjfkmJKVbXj22hg5VIPUvemscRtb9T0+3QehO65/VU7In51VImPBCdqnC9GTVAe2Sepi5zL5b1c8RII5XDoNnwVW6R21v/EukDd2SBKAEs02Nor1/LmY6cZDLbe4Qiuavf/9dGuTx6q491VYm0f9YO86ABCFVdVWTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776674987; c=relaxed/simple;
	bh=bmdsk6Tn6HxFc1Z8801pTo8PRG7NComLf15CeG5y5CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cm+i+CPJ9dmolX+F9lWcbJ/2AW5iPNtL3dR2HkTcH3R5vazg4t5pJOoqWoUjoIt9dDPeLVsOypcaRNSxoi+yFeX2n33MEW69sYaU4O07BoLnrddmhGXHUw0/Nc9WgtobDocGfCP7aOeGktgAfVNx5EZDz21FYnfXX6MBuAF/ffU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FrUAgNkR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FrUAgNkR"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JKni0j3746359;
	Mon, 20 Apr 2026 08:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xLqhwwRritYQkVkSC
	Zs5qUd42E+f0F1TpFnpkgPxc7A=; b=FrUAgNkRHibiB/29+PA3sJVwPeu3YWhMW
	ftufpPRWd6DblhsJBFAl3/RovGAZcFo8Q4RGITqail98seUG9VSGbv/BVBEoklNy
	/pWiuEU6tgkgyGAypEOIQ5YaNsYwcvZyNfo4ADbFQZMir5HX0g5lSaNgsfdsjI69
	kRuiri1o656kgQdiqlgVqbkWd+VWwx2/lTHdk0DOpww19+1tgl/WI/+4JHzJaLHc
	4QMsNTm1YWxpJloLzPVChYkXsid3cPuwll/5zY0THbJK27x/FrdZNKrFcKDkHXyY
	FuoI/pmdiZR2OeRmGAkSRr3OrkZZdsuZzD54q3KjO1DWyLcmglqDg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2k0p9qh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 08:49:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63K8ZVBf013566;
	Mon, 20 Apr 2026 08:49:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmpgg3vyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 08:49:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63K8nfGZ25559302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 08:49:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1386F20040;
	Mon, 20 Apr 2026 08:49:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4E8B2005A;
	Mon, 20 Apr 2026 08:49:40 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Apr 2026 08:49:40 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com, nrb@linux.ibm.com
Subject: [kvm-unit-tests PATCH v2 2/4] lib: s390x: sie: Allocate physical guest memory via memalign
Date: Mon, 20 Apr 2026 08:44:23 +0000
Message-ID: <20260420084933.251244-3-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260420084933.251244-1-frankja@linux.ibm.com>
References: <20260420084933.251244-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qV3oqSizcNx5AYTNySX0MHcidXlb4Kpn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA4NCBTYWx0ZWRfX3EiZerjqQ779
 EuOBc0h8/X4MLiFAYns7bgGGO9gdsZaa0E5yYj82vWWE+YNKVHBFAGZDF7olXd2Jg1Q/8+5Edjz
 mx/xCDbSdhlmwUuTf7Ax7a9s/INQnVKTC/wAQ43t7qUKUulmmIa2S0QK36gNG7LWPQ94w95pDZl
 y8YetIAVKQRp9KHtwV9Zu60m2xLSj05nDTrVN7LISH5AlWF555GE0xHR4xj0BrDaXiZqrg4B+aH
 Oo+u4KK723DCfvpsIMrO+GfqU8sPXg522Ng0rU6jH5bIaDWfZtJ8RmzwSNGMj9vLxy5/p+Rhylv
 YA3Kz/rlUAYg0AoYsNya9FE1I1NfnbaVQqwBgLq8wcYrQR4eiZQZ2UQPU115cdJdjUjvDQE0NtF
 PgRAhotEZHzBMm4hAfuy+WqGJanRNluGnHfRI9ccvhpXc2zLJRIVz86PtgPJgPcTIaUSfDt5Kwz
 wPi1lK1uE0oaZYjuPvA==
X-Authority-Analysis: v=2.4 cv=PtujqQM3 c=1 sm=1 tr=0 ts=69e5e8a9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=GueWrYxDVtNpybNoHvoA:9
 a=ZXulRonScM0A:10
X-Proofpoint-GUID: qV3oqSizcNx5AYTNySX0MHcidXlb4Kpn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200084

alloc_pages_flags() alignes the allocation on the same order as its
requested size. Since we use virtual memory for SIE we can instead
align to 1MB by using memalign() which is less wasteful.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/sie.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/s390x/sie.c b/lib/s390x/sie.c
index 47d4cdde..b1b0a8a0 100644
--- a/lib/s390x/sie.c
+++ b/lib/s390x/sie.c
@@ -171,7 +171,8 @@ uint8_t *sie_guest_alloc(uint64_t guest_size)
 	guest_virt = (uint8_t *)ALIGN(get_ram_size() + guest_counter * 4UL * SZ_1G, SZ_2G);
 	guest_counter++;
 
-	guest_phys = alloc_pages(get_order(guest_size) - 12);
+	guest_phys = memalign_pages_flags(SZ_1M, guest_size, 0);
+	assert(guest_phys);
 	/*
 	 * Establish a new mapping of the guest memory so it can be 2GB aligned
 	 * without actually requiring 2GB physical memory.
-- 
2.51.0

