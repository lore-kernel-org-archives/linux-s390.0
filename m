Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48783BED33;
	Mon, 13 Apr 2026 10:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077282; cv=none; b=L5rhmvow4a0ozdnlHbiPTmWSFDaUXRt0lczw5DTZRuoCuk8YBjROrgRqAuXs+E+yNtyw8MW/841Ap7uFZJDBSEFLckSufuvBQSqnaLHRa1jHWrV89jWNYGxBc5Y+7rKNk9j9IxiwkHuRrSrFZNpO66QSBGEETaXWqfR8XF8H+yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077282; c=relaxed/simple;
	bh=aZSx7YQmE1Z978uWyh44sfmDm1hxUv65WZDkSBnuMUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UKmC3338STwVvkw9H67OR7qAriyVXX8EWxH/rG3u6iUZj2kzluAxPHGXau3Jkm2XtXFnsBGT1WEzC9uoaZUKp8s4dXtKH3trfoVWmLO+XXq+hM3suL2n4MX7upIMYCpSvZHa4q2cHh9LT/Thj/LlnFTVs5d8aBD043VgKI7VE0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sQaAG562; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sQaAG562"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DAGk672176145;
	Mon, 13 Apr 2026 10:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=uI7mu0IysYnhS00TW
	hjwcknJZWwatJSHkWTb0suDkN4=; b=sQaAG5622pkX5i4HCbw4hbbDHICsBiran
	eHxhsKJXIThXVyZjNED/kzz6s2BfsBE5ypmaTRpO58MSbQnma7Nb9HGYf7/Ps0+L
	/6wui5FhWOigyVK2SPglC/uTCJauE8zENMK8n2My0Emt8+qUNeH3+wHprm8hGdSK
	RgsfwlBghMwniMiHgdQc7Zz3FV7jYViF5guYGH/6GGos+xmcNlXdJTxueda5yuZp
	Ets5ibsAQjFuF2T5WwTLcpAW0VFRjSEmAkZbWQsgvHF1CTwEGwd0c5Llkpe2khs+
	w0xd7HDZIColGZ5FPfyJydYzAGROqlZJVJSU0YbG9zfy1Vx8ju1tg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfbqkf42r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 10:47:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63DAL6Qn025803;
	Mon, 13 Apr 2026 10:47:52 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg3b1chk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 10:47:52 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63DAlnhZ42926390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 10:47:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 194872004B;
	Mon, 13 Apr 2026 10:47:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1D7320040;
	Mon, 13 Apr 2026 10:47:48 +0000 (GMT)
Received: from li-9fd7f64c-3205-11b2-a85c-df942b00d78d.ibm.com.com (unknown [9.111.7.85])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Apr 2026 10:47:48 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, frankja@linux.ibm.com, david@kernel.org,
        borntraeger@linux.ibm.com, cohuck@redhat.com,
        linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        Steffen Eiden <seiden@linux.ibm.com>
Subject: [GIT PULL 07/12] KVM: s390: Add some useful mask macros
Date: Mon, 13 Apr 2026 12:46:35 +0200
Message-ID: <20260413104721.203024-8-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413104721.203024-1-frankja@linux.ibm.com>
References: <20260413104721.203024-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I+9Vgtgg c=1 sm=1 tr=0 ts=69dcc9dc cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=Oh1pnlNaMCSVx7q4Av0A:9
X-Proofpoint-GUID: 5rMs71k5OJotesH1AhyIucofOdg1A18C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEwNiBTYWx0ZWRfX1giSm/TVgpN0
 cFHoNe00t0iu8fYWZSaYwI4XZPWBhQp2XAwjRD271AubU1FyiKqOy3a1bQVXIEtw8U8HRcJVfGU
 PBcAOQcRNDsBcHD8L/YEkqiAfr/D/yZ/h/PZ5uSMd3uWNU1j2qIPkSAM5Sy7AC0kgatVvNTjETl
 vsn0i5cyeRmAs+MYfhgUuHYfRKnW2nJwVeeq0itgld8raNxgda16qqV4srY7x1A+4raD9lTy1hS
 wK/9n4jkmiNdxmve8w/Do6hhewwj2+WQpTcvvo9lRCwJZ0c0LKvHTKhkHMcv9cmTnT2QhJuCW1H
 iJ8CTmXurp16RFoWMlNnlNl9Fpw7dkk9LCQ46mM55wa5/BSBuSJkkO4wGP0hUY36ytkm3DKHZW6
 XdADQujLLCEn/4iG1ibRtaqWpT0Opx0Fw0kdEYBEeDTlHBoyWkC3VDbvMTpjIGVpux+C7eLp/hW
 beA45aTN05fMYZn51eg==
X-Proofpoint-ORIG-GUID: 5rMs71k5OJotesH1AhyIucofOdg1A18C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130106

From: Claudio Imbrenda <imbrenda@linux.ibm.com>

Add _{SEGMENT,REGION3}_FR_MASK, similar to _{SEGMENT,REGION3}_MASK, but
working on gfn/pfn instead of addresses. Use them in gaccess.c instead
of using the normal masks plus gpa_to_gfn().

Also add _PAGES_PER_{SEGMENT,REGION3} to make future code more readable.

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/dat.h     | 5 +++++
 arch/s390/kvm/gaccess.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/dat.h b/arch/s390/kvm/dat.h
index 123e11dcd70d..809cd7a8adb7 100644
--- a/arch/s390/kvm/dat.h
+++ b/arch/s390/kvm/dat.h
@@ -104,6 +104,11 @@ union pte {
 	} tok;
 };
 
+#define _SEGMENT_FR_MASK	(_SEGMENT_MASK >> PAGE_SHIFT)
+#define _REGION3_FR_MASK	(_REGION3_MASK >> PAGE_SHIFT)
+#define _PAGES_PER_SEGMENT	_PAGE_ENTRIES
+#define _PAGES_PER_REGION3	(_PAGES_PER_SEGMENT * _CRST_ENTRIES)
+
 /* Soft dirty, needed as macro for atomic operations on ptes */
 #define _PAGE_SD 0x002
 
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 4630b2a067ea..a2ad11e2bf61 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1461,7 +1461,7 @@ static int _do_shadow_crste(struct gmap *sg, gpa_t raddr, union crste *host, uni
 	lockdep_assert_held(&sg->kvm->mmu_lock);
 	lockdep_assert_held(&sg->parent->children_lock);
 
-	gfn = f->gfn & gpa_to_gfn(is_pmd(*table) ? _SEGMENT_MASK : _REGION3_MASK);
+	gfn = f->gfn & (is_pmd(*table) ? _SEGMENT_FR_MASK : _REGION3_FR_MASK);
 	scoped_guard(spinlock, &sg->host_to_rmap_lock)
 		rc = gmap_insert_rmap(sg, gfn, gpa_to_gfn(raddr), host->h.tt);
 	if (rc)
-- 
2.53.0

