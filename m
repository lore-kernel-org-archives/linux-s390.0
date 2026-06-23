Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8B12EEE7A;
	Tue, 23 Jun 2026 15:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782228822; cv=none; b=ihlIJ+56PjJ7BtLlG1CxVr5PhKemdVIcZHnFVRJSCliTJE3HMeyDQW1/O3AJ5V4DlCYINYLOmv0MFHAU1cj/4VRzWTwdUeq59QbE/3sjy+L4hbtP2XvBmb1G4Ge3P6hS0YDAfEYRfb3RRhacDGYUfRMlMGyWpRm76M2rj0b0bTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782228822; c=relaxed/simple;
	bh=w7kDl946Q2KCeqlCMf7rsq6wQnZxNxjkKL1PkOi9/wI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0Y3lYDnYh8z+hZvRY6Imn2iqBwq/hy+R7u0sogObRz9/fLVVjV5mwjg9T6hA/JxlO4j5UpzQV7IoS9E+zIHHWowwJiI+GCop+8fKUmdMQDgHDtEl8dTV6oiOjYRl1DrpnRh4xGZD1HIqGc4tHTdWXxeVSwWTZDXOhaoCaD7NBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sQeDXQA8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sQeDXQA8"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmP381826040;
	Tue, 23 Jun 2026 15:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aYUmYY7pgmh2oM9Xi
	VEqV99izLM0lF39QVOuBdeLdgU=; b=sQeDXQA87WRfQxqM5hGsot2QaIDahLkQE
	uwKnId2062ZwDoilW2tICv6eST1FYL4mmFtBOIVtwkLHw4NmYYdga3PDBVZx/STt
	YhH7+vriUEmhLoJhSzxLdR/dNRmTkoLR89QEUjMELyU/N2Q2uR720m1f30tN2mBM
	1R1At3S7+Wjb0x+lgH5vDMhkkymUtn7he0i14d/ZKGliOOq19knY86G8+CyDBWw4
	OE4Ek94c52zlPrm/o6o8bPeaAjlm4GFNAhaFEVfZlHgtB+1hMIweolxjr0hxsgte
	u9Iz662JJDE9Sf4hJEWwyU0P/E/uSRm/XfFJRxNflQVvEBbbjwK+Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgsq8f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 15:33:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NFJdIp027628;
	Tue, 23 Jun 2026 15:33:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qc7m3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 15:33:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NFXXw144368302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 15:33:34 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D68B820040;
	Tue, 23 Jun 2026 15:33:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E7422004B;
	Tue, 23 Jun 2026 15:33:33 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 15:33:33 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        hca@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: [PATCH v6 10/10] KVM: s390: vsie: Avoid potential deadlock with real spaces
Date: Tue, 23 Jun 2026 17:33:31 +0200
Message-ID: <20260623153331.233784-11-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623153331.233784-1-imbrenda@linux.ibm.com>
References: <20260623153331.233784-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEyNiBTYWx0ZWRfXyYNt9DjY60SA
 3iskX9IJE158FeM3nYxSX0jhKp0lqaSbcsu1J26q/fk8c1/oubCEGpUjO3ug4FFwE8GuPumYEir
 pAKcjbvBQpadzl9FTXiJ8tjSgQ7uXAUqkILUVpjtiejR/usR7LHc1YnegDrIMJXmps+HxFyhEWb
 G1UcdfubHYzn4CQT0JXVrNodAp0J23dQ0R9U7oGl6zlHSzHqrDqut3ggunFyR2RXTXEdmf32JZb
 VlAFEKt3pU1kvPIJErlK4YInGuSqrbXeoSFSvbzNySY3eB8ifQM1WrE7/zXrGd5qz8Nku1AsUur
 I3o/dghWmnmE6PxCcGRlRREZP4BsmzkTaNT4kPxNsopRMuUSewNyUjjCiIa6NCoiaC7nBYa2Us5
 bzut8t/BEwniHcfteTL1qEaoBi+M5P8DbfvtE+Zh5yWVj0pKV0xT1sw9BKxUIq9wwjxM7XTb1Kh
 KVUiVTY/C4uLPoUvRYA==
X-Proofpoint-GUID: jNFs-Kn4hJ58UVaWh_n2FdZFMZ_2_bdR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEyNiBTYWx0ZWRfX7mQlw9iucNjc
 5Lepzkvjk08yt0PA0F2d0UY3fs6g2KWKpOW4BofIlj4VyAxsSjCETz+/Uc6CggV36/i+wluPKJO
 GT1oYvJfxyVK7L6vAmbGJewh+G/0J/U=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a3aa752 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=h1X_5t0Fh-6HCxHrEOoA:9
X-Proofpoint-ORIG-GUID: jNFs-Kn4hJ58UVaWh_n2FdZFMZ_2_bdR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230126

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
 arch/s390/kvm/gmap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 0f944944badf..1fc8d848b2bc 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -1349,8 +1349,12 @@ struct gmap *gmap_create_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *pare
 			/* Only allow one real-space gmap shadow. */
 			list_for_each_entry(sg, &parent->children, list) {
 				if (sg->guest_asce.r) {
-					scoped_guard(write_lock, &parent->kvm->mmu_lock)
+					if (write_trylock(&parent->kvm->mmu_lock)) {
 						gmap_unshadow(sg);
+						write_unlock(&parent->kvm->mmu_lock);
+					} else {
+						return ERR_PTR(-EAGAIN);
+					}
 					break;
 				}
 			}
-- 
2.54.0

