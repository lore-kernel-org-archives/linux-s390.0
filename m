Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198424746B8;
	Tue,  4 Aug 2026 16:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785860697; cv=none; b=pSFpEZl6cEV67PKOBtrTfYuAUIIRdiCAqegi35Lxn86emfovjl51zmNCeHFSmpugoUhFTgZOYeudI+N7kKALtnO9sKpkZpRSqwZHwgchdxa6iyyIYbsBW4xGk42mDFdPrItIyHjjon39Z26Mu6nrJwD4Kf++nrva/i0G0wbXaQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785860697; c=relaxed/simple;
	bh=2ot1UIDXIbai+WtwspiN0AgRPfYTlxXx/63Y4iTdqzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFGA7GB2TUykdQkOS6DHRi7gY8TBoWU/MYiP8lkDNldI7rWkK3BAKUI1GqMuZAiq6KyqJhd3hUUe4m118h5vN1IEes4R4kzEXQSLilAM3reJm4epmppO/gLtW3H2fmJ1daYgCU2ApF9xpohV71jnSzj5f2XYn6sIarRfLHx1LPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tDFkYIcm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tDFkYIcm"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674FlpSL1254663;
	Tue, 4 Aug 2026 16:24:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1E0c0n2IqUDktsuyK
	kf14YWIMDK3YFsPEtpED2FK0jY=; b=tDFkYIcm6b9BQlfWpAhfTiSQwAayrl3rA
	R7VMOjhSR/X6XB7N+2xnfKQLEMSGlJA1Urjl4f+qTJgrjY46g2c+TghO+I0rI+UA
	b5PsYcwJfZbkTT9F3s3Bl3Rg1kqIgdPtsKkAzEzl9vRUHkHUt+wOIo2ReNagAggb
	TXV8y57Yo42y94X1nOE8+B2rgLnMCov7BVTIzVVUpz/89e+s1PEY9aJi1QXe1YzD
	X5NtTYeL2geqjWMbk7TwqZqMKZAe8LJXOM7rbudcCZyBY8ASOnZBIcPM2fKY7nhh
	Vgmmjf3v6vlw498XGCS/F+taNNF9eeJfsWpQwStoUhF2/HPnorZ5g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3xt96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 16:24:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674GBIPE032062;
	Tue, 4 Aug 2026 16:24:53 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgagux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 16:24:53 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674GOp5832637284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 16:24:52 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2F8F58058;
	Tue,  4 Aug 2026 16:24:51 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96F0058059;
	Tue,  4 Aug 2026 16:24:49 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 16:24:49 +0000 (GMT)
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
Subject: [PATCH v2 5/7] KVM: s390: Fix old_data leak in guest debug error path
Date: Tue,  4 Aug 2026 18:24:33 +0200
Message-ID: <20260804162435.28617-6-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804162435.28617-1-borntraeger@linux.ibm.com>
References: <20260804162435.28617-1-borntraeger@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a721256 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=qm1OqVo_2UFWDN3potwA:9
X-Proofpoint-ORIG-GUID: hu4N0hpDzlni7g6pZqRgg9oZturM4otP
X-Proofpoint-GUID: hu4N0hpDzlni7g6pZqRgg9oZturM4otP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDEzMSBTYWx0ZWRfX2hdttDshLJHp
 H/uDQ/T5Lhgln4Yj5JqGUu7IoNKs7LXcMR72iPqqqGRwB+09AwhZydqwAZtdqdVOYfLC6a6/TNr
 jStd4y9G3HDhaJCLNQLlsaDNHYlehkc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDEzMSBTYWx0ZWRfXymOvcuovFms1
 y0eib75aZEmKi7sqo7sqfcZjfqkp0ARcwHX7/X/6Bb1vRK/Lc9LywDKax98b/kpvwzhQg9kJtBl
 0hFvTBK0b+sOpLVTAuAZBuiDFwCpvBDD8hQG7SbkcweE8Jq1Kpk52c/3ES0Sy9cHPcvIKZ7vO34
 g+vnvnYsEpTfKO4RkbVht7rnNQfx0lE1CwoWMD/oVEbuT1TDTGobaGLZxEhkc/wsJeNaulMXlnB
 1bfoUDOXJYJ2og4sZVbd+nq+sSY754Qe/PpdhabY57PkctPzbdW6Ef40EM5LmUFejAO4QHIJM/g
 SZov/TTcYoHqHWyQX0PefH3nJEDV7hAEjKSaMw7gms+47zszOoA5m5q/xVDNjjOfbZI/YBFNwXP
 j2WwilXGEagUe5ZH1X1NNlLhVAMCHe1K7gHJudj8jGRqYaE7c9ms41PB6DzO8auygCo+AYKIzaI
 ttSNcoibdiDGvfZbdug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040131

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

