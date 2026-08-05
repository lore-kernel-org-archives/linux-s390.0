Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834DB43848C;
	Wed,  5 Aug 2026 11:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927914; cv=none; b=mP53YTIJGI60Bf/Ym283qU2zcZXzMAzQZYsTdfAgTLNPyIQSTw+XUlxfVvBcDCzg4i2PJhJfARIionBjuFN2YZsobpmNnEATPu/sWrwF89bEF7qOtsa0b/oWokCRHfkinCZXrHagsVEeql/n3qMpXKcc9th5hzEw9YAND+eyrnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927914; c=relaxed/simple;
	bh=21kLHy7ZqUIPSlXzdIOa2l25plUxnEzoH4TN9XHEQtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUW9RPy39BK7mMPQSqn6WWkUgdP0plFoyHkFkLdLeuhs/g+NcFJWgPk1CCTlY12RtoAV2AkXuzkHiplMffv71Td2EdWJ2bLZ/MrMbxYxCKRtCezs/zyIiqGztA9+v1AxPd60QE1Pd8NtUJcl8UICGS0BixkmIG65Nox0QS3s1ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Dx6yl29P; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Dx6yl29P"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758ln4x3354759;
	Wed, 5 Aug 2026 11:05:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Wq2CaYEEXP63zXyNK
	vNIAfM1oaEdJi2miohfUzAaZ9o=; b=Dx6yl29PUiGY9cNAxE6/LMZmPQAmpIPeN
	ULTkR3tijPtjCCi7B9mOgpnNhhKHTw0Kix+XgFMw6cKsg7dm5fvvUOu1SOy5m+tU
	cENWbhrK+H7TCtDYbDb/PFtZYgLRkDKOkgp/fCLbv/2kApaHF29RzFtsEdV5Mj8p
	elsQCRNCjZL1hLIfia17HrDHAAk6P8QZNN4eN+YxlVY3RbHDp6Qaec7A5a7pqtVw
	gqgxbfnu5r1n39aqelaW/3LLCZa9iiIJR6LFqsMRKYrOveifmB4FSuXezTP+PvoH
	7uxHoofG6DT5MT0iHKv3iwXtMVH1irGYKKHl+ErXkpCSqFd5gvlpg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a42ng7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:05:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675AuHms020183;
	Wed, 5 Aug 2026 11:05:10 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbge0y4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:05:10 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675B59ro18219520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:05:09 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D8DE58225;
	Wed,  5 Aug 2026 11:05:09 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 905D358218;
	Wed,  5 Aug 2026 11:05:07 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 11:05:07 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: KVM <kvm@vger.kernel.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Douglas Freimuth <freimuth@linux.ibm.com>
Subject: [PATCH v3 5/8] KVM: s390: Fix old_data leak in guest debug error path
Date: Wed,  5 Aug 2026 13:04:52 +0200
Message-ID: <20260805110455.7200-6-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805110455.7200-1-borntraeger@linux.ibm.com>
References: <20260805110455.7200-1-borntraeger@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a7318e7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=qm1OqVo_2UFWDN3potwA:9
X-Proofpoint-ORIG-GUID: o2UNIGsvcwLHnQC1rxvwlxN7M0EcCo8Z
X-Proofpoint-GUID: o2UNIGsvcwLHnQC1rxvwlxN7M0EcCo8Z
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfXyjo0lAjhF+PK
 Bxgn1aSwIGyrFG6wfvppfiBdRSgOcqB5RUKKYKaqkLhOjhvr7aXGCXYILQC/4i5yUfuhHzjE18l
 qr7m0sGSARYitu8Fe9XtXIz4BtWgksM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX5Tp6DaJmtMeF
 nOw/SqRcR/JXFRvHgzeD7eHS4/90Afed1KbX/dFQMgXV0bIsm+x2B4pOeO9OjSLG5w5insoJ85S
 YIHOHA0uiz78UFMF8rL6I5zTmlua8nalXZKHArzRjiZLADvZFucR65PY+8nABmUicoXEpcuOTQh
 9fprMWcQUWwRiKSgeLHzSgEMgME1FFzA/7kzIAjLJX9cVVf2BdKNsMGYTPR59KD7CwMx9wGSQlz
 cXNFU/iCUNkDl5PqyvJdeWwN5/vdMPAaSj3d8l+6PnTQIMK1qxwf0LvmEG1BAR9fBHlZoNsNrW9
 0cuARwFRVKiYx254uGTNouMaVoMnTb6b3PbXU/of9FHF0/EhfQOfuZTugCWfzLR9Dt10e0MrMCR
 0WVx4lLJvDe3UjT6JAJN1daOWn/iyGj70yalN7k+h2Wzzr6RY7s+QhBoMUEx7seCG5ei3yfX7N5
 +tO+gWNr86syksXzn2Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050086

__import_wp_info() allocates a per-watchpoint old_data buffer to back up
the original guest memory contents. If a later watchpoint of the same
KVM_SET_GUEST_DEBUG request fails to import, kvm_s390_import_bp_data()
jumps to the error label, which frees the wp_info array but not the
old_data buffers of the entries that were imported successfully. Up to
MAX_BP_COUNT - 1 buffers of up to MAX_WP_SIZE bytes are leaked per failed
request, and the request can be repeated.

Create error handling for cleaning up all created old_data memory
areas.

Fixes: 27291e2165b6 ("KVM: s390: hardware support for guest debugging")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/kvm/guestdbg.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
index 4c02dbebb2eb..f7c94d54efbe 100644
--- a/arch/s390/kvm/guestdbg.c
+++ b/arch/s390/kvm/guestdbg.c
@@ -252,7 +252,7 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
 			ret = __import_wp_info(vcpu, &bp_data[i],
 					       &wp_info[nr_wp]);
 			if (ret)
-				goto error;
+				goto error_wp;
 			nr_wp++;
 			break;
 		case KVM_HW_BP:
@@ -269,6 +269,10 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
 	vcpu->arch.guestdbg.hw_wp_info = wp_info;
 	kfree(bp_data);
 	return 0;
+
+error_wp:
+	while (nr_wp--)
+		kfree(wp_info[nr_wp].old_data);
 error:
 	kfree(bp_data);
 	kfree(wp_info);
-- 
2.53.0

