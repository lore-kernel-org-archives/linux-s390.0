Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853D837A82C;
	Thu,  2 Jul 2026 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783005864; cv=none; b=fBF3DZAzy4qAylqK0FU5v7vvNcmgpuwvk8HvcD0M8AZgimlXC3CfdjUfT7RtrwIIUrgwj3dj1LkWanoD1dCAvYFCuibIJ4FyR2A9eQxI5n4a68s7+WCUqKjyGWLdxR1yxkOnDC+1bS1+pXuPlOdO9wLBy8r+GdOcjFOZ5E+UzNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783005864; c=relaxed/simple;
	bh=7vmtZwc4s3itrk4nm94322Zok9orDliU9r60OVcLDfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q4i8RWh32MsY0eUiBeMdommWx/mE8yYC+E6gzBcANgSMIDfjgMY7b5AfYG3ZZH8vy9A07YigCOBoJsMlMvQ0LlhS4fpluMxP9UMgvUeXOEePtzMxXxpNqoGG4vpXMD6DmOT0nlMVHhhSMV+SN8DgF6MFl8X03LfL0yBvFRLI2Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZMLG5ejS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZMLG5ejS"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662EIMWO4134859;
	Thu, 2 Jul 2026 15:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5+MTJ9gHpEY0Q4qSu
	TO+jyBuE+hAvNhd2G2oa5xvs5I=; b=ZMLG5ejSZUgILSKJ0ymq+Ik4OnGSXk9wz
	23HTXRZ4DEFhEPTXT6EA+uhC21FuOA9eEHCDsnfKtfnLB5CpFEDekew86Dj7SgUR
	43U/3nAn+gMBkZipqYHYG0chZwmCMsu0fkro0oaKv26suXAIQzRqXneKLNj9oNEe
	tv2Y/ocIEMwqeV/5Kqo3LHPB8Y7QsvebFbYFUou98mR5OpJztPs0q15OwkgzLxS/
	zpL9+bGs+5wAvsHfNEauEGgBPkJS1DY2rMh9PZJ31zmaa6DT42haUlvCWRpPNUSv
	yerM0uIztO7p5JXitEVkyKVkvOWpowi+bra94mvp7Fe6U1D+KY4GA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pear43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 15:24:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 662FNT6r003894;
	Thu, 2 Jul 2026 15:24:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqmsxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 15:24:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 662FO9ME51446190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Jul 2026 15:24:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13F232004B;
	Thu,  2 Jul 2026 15:24:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 280AC2004E;
	Thu,  2 Jul 2026 15:24:08 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.87.55])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Jul 2026 15:24:08 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 1/8] KVM: s390: vsie: Avoid potential deadlock with real spaces
Date: Thu,  2 Jul 2026 17:23:59 +0200
Message-ID: <20260702152406.204782-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702152406.204782-1-imbrenda@linux.ibm.com>
References: <20260702152406.204782-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uj-ayMOFGHg2UKpfe5Jzw4uuqj-ABus7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE2MCBTYWx0ZWRfX5HmthEhyzpA5
 gg6R0luqmuTek6JW9doUwZEFk3ajfCJHhb6yeIrfAlv8uCRh8i2Td0ZvTakEqNWvVCzzHHuEKup
 16klEqIypll79zYNKSUSMk/qLpvAOxY=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a4682a0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=h1X_5t0Fh-6HCxHrEOoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE2MCBTYWx0ZWRfXxHbbKqO0BU9n
 zZbHr6bf2so9sK4jW5wsAZkwkEcMb7ve1XPYTKICJsCVQEyzotOmZAUMg/xWbj34n12luE33YIq
 pChc24YriT/HcNP/m4HpQ/7eyRT+FfVxB/1KxJn1UR565xhw1JJvFQwJPPo4stD+luvRQ/Gakg/
 9Czpv+E8CtxEkeSW3FKd0qPDjoFUngvMUtsE5xKvtfvzHk8aKMKK545OeRr3SUBkzVgdHFZoniE
 /7asSqmPOmhGM05ZVVV6aFeGWCvVW0aYOxAzIRMSt1Va4IAVK2L2wZYr7zTtTbqidh6/6iWUT5Y
 5+nPu09bD8eVmCcp9rvsaQFL6Mk8z1dqpjUF49NVp5pgVH5crM/p+c89yepV9anwkYvZhmdQkGW
 VTv45vOGxqPjYaU38csTD4LzorGXmNEwRdLPZzbTzfu1L+nNka6b9QypInYSbJhdZERUhV5yviF
 8EocqmzzClu+H64girA==
X-Proofpoint-ORIG-GUID: uj-ayMOFGHg2UKpfe5Jzw4uuqj-ABus7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020160

The natural lock ordering is mmu_lock -> children_lock, but in
gmap_create_shadow() the reverse order is used when handling shadowing
of real address spaces.

Convert the inner locking of kvm->mmu_lock to a trylock; return -EAGAIN
if the lock is busy, and let the caller try again.

This path is not expected to happen in real-life scenarios, so its
performance is not important.

Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gmap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 298fbaecec28..8abb4f55b306 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -1374,8 +1374,13 @@ struct gmap *gmap_create_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *pare
 			/* Only allow one real-space gmap shadow. */
 			list_for_each_entry(sg, &parent->children, list) {
 				if (sg->guest_asce.r) {
-					scoped_guard(write_lock, &parent->kvm->mmu_lock)
+					if (write_trylock(&parent->kvm->mmu_lock)) {
 						gmap_unshadow(sg);
+						write_unlock(&parent->kvm->mmu_lock);
+					} else {
+						gmap_put(new);
+						return ERR_PTR(-EAGAIN);
+					}
 					break;
 				}
 			}
-- 
2.55.0

