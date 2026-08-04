Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCD047669B;
	Tue,  4 Aug 2026 16:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785860694; cv=none; b=VNtMY5mXGrRypj1OmiPh//Hi9PQhptyeOEX/vO/uwax7C2AncM0/sD27VzHlfkMNP4Gv1LW9YDp+yurQK4lmGHqGFPccyvi9NILUnrMRB9xWVhaRoTwDGvcYRvE6fnlRhO8QMgQhNnz+X/Mmcu0EmexMi7nnyQpcOxpOd9zwEhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785860694; c=relaxed/simple;
	bh=ntXSsdPZqK/hM+GB1fLr7GVZjqTsBU0WRMD/e6spe80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fIUqEwlC87JkJIYChqAY9gT/xv+j5BcOdQVTPIQN1RNBkxsqrjQWKpgLQtABLpVy3wGLp4Q9YUTIM83qjpo700YmeAlZgNc72ctG1Y69F1SAI7XeerY/AaOst+foKkdbjFxMUHKGFNspI9aZUrFqoWvvrM4Q7W1dp2stIRUnJmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W1sL2u2g; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W1sL2u2g"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674Flb3D1286351;
	Tue, 4 Aug 2026 16:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bDziJAW/mYvzeE28M
	kir1Lpy5F4FkDCmaX6n32l/A0k=; b=W1sL2u2gkgavbo0Cco77TLpnmwGq/b6pd
	4ruqrl0ouiIXkqkpFQdu4Rt9fBTN2BsffmFhupntmZywa5n2z1ja2zJWH5RsdKMd
	vvJqIwSptNDm1Ys5opkxMmLy9kgwQ4R5A5v46f+KOofIWtogMbJC6TTUowxUUI/R
	alUguHglncX6NM2JfrprbIf4ltRmd1Gg3rsNOUdPBp8y2Xu6IzAT94eSlGUUnUs0
	LUvMFAr3HY3k9gtOy37hU5NoKLAQ4LXYylLTQKKuqLvESRMxk7tHSeTW8P16qnYv
	LQKnBX+6bXu6d6uabA3hCN7u8z+tgyY7nb3+vMlD/16hlTOyLJtag==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4xthd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 16:24:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674GBTQI007712;
	Tue, 4 Aug 2026 16:24:50 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qjv5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 16:24:50 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674GOnNn63898060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 16:24:49 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4921658058;
	Tue,  4 Aug 2026 16:24:49 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 039FD58059;
	Tue,  4 Aug 2026 16:24:47 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 16:24:46 +0000 (GMT)
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
Subject: [PATCH v2 4/7] KVM: s390: Fix memory leak in guest debug handling
Date: Tue,  4 Aug 2026 18:24:32 +0200
Message-ID: <20260804162435.28617-5-borntraeger@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDEzMSBTYWx0ZWRfX6RUpW6dyWYeW
 +B8uWCkB7u6Z4U1CQR3iVQ9Do2oqYRiqdK2xPzzYXLpQHw0cYGyTB8ok7EZ7rtMtVKY4xH+oewU
 mmmRgbEOHiDHpQO3T8c0Wn6n6abGXKY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDEzMSBTYWx0ZWRfX9UV8AS3imtR8
 KNvTWSEy1DcTFCSHDRGCqTjfitDAeFEk0I0o0ZFBpeDnJrc29SqJdvLN54DrzGAXdAar5XM20IY
 39XTCEDZBb0kl9ikHXJxDJbxn0U+DIqH9wlmU38ryZguRHE3r3plEmJr8gYmRn5iUkD6UvKs51N
 1HxMFyzjmuV0c9fts+dh7w0sBgfQW/jZ60Tqn3IdjKf1ZpG/r9LMKzXXEUdoNd8P74YYp09+eDb
 O2Q1aF95YY6BVr6U4oQ8grv4G6DIP6GAkA7X8hF5r6blpFRIWAZQtZla/ReDg8iHFY0BBggCdsl
 Kk+RaPKScXxiVKbD1Z3Uyx0ZFAYo0STGQ0/SrGXK1SjHF8iW9qRL44GivCKI+4uCYhcKcfwZA79
 f60Zanfs4mBTcQkAcbxUWTbwfmrxnbRsXoAR20Y2x2hf2ZpTo8xOAZ6fG8jz1NFdAX6oOH3VKFO
 f4s6xKjuLaJoP4+j7wA==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a721253 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=EuSpeD5rqQqXJFU2zEEA:9
X-Proofpoint-ORIG-GUID: BPE5eWVTSHzmje2ws7eu2j9c4JMOueVj
X-Proofpoint-GUID: BPE5eWVTSHzmje2ws7eu2j9c4JMOueVj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040131

bp_data is freed only for the error case by kfree(bp_data).
Every successful KVM_SET_GUEST_DEBUG will leak bp_data.

Fixes: 27291e2165b6 ("KVM: s390: hardware support for guest debugging")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/kvm/guestdbg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
index 69835e1d4f20..4c02dbebb2eb 100644
--- a/arch/s390/kvm/guestdbg.c
+++ b/arch/s390/kvm/guestdbg.c
@@ -267,6 +267,7 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
 	vcpu->arch.guestdbg.hw_bp_info = bp_info;
 	vcpu->arch.guestdbg.nr_hw_wp = nr_wp;
 	vcpu->arch.guestdbg.hw_wp_info = wp_info;
+	kfree(bp_data);
 	return 0;
 error:
 	kfree(bp_data);
-- 
2.53.0

