Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0332C4C14F1;
	Thu, 15 Oct 2026 10:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061315; cv=none; b=Y4yTJY1Y5djh0oMv4WyTDb0R9DnTsxKzPoe+6cFa2PofeOERluW6sb6gJmjrWB/wpje+ExfiEPkO5JSZmohasnmvxqEBlk8g9pqM/0W5ETswnIXgvHxKaoMHi0Ui3Enb0unBWnumqDcO6kKtYfVue2tcc1/ZfAAhJVcbWJijGAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061315; c=relaxed/simple;
	bh=yAKZNFLxapvuWR9xetw5kGFuq+nKIBsPxoOmqweYBT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Clrja7SgfbqD72MOuM1JojSEWqc5r4nBUEDoY7gr6WarTKggqlHRf/EVBybnoBjMi6gtsofLQGbFzEEkTcIfO9/PeDB+2XEIkNzzibutQS6ZHYavqp7u3sulL07UbIkMxpfxcFKuRhtLIpdXcSHUHlmVhc5cje0oWa5gmlIrK8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fBB9qTdQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fBB9qTdQ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9kZp9438204;
	Thu, 15 Oct 2026 10:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=O3GBvOJ8rwrGJ5Dj9
	0iBGRUUJUfPyp52s1uxuUOo6E8=; b=fBB9qTdQZyX2UGr2OG8+BdQxPwq8FJTLP
	lCOoqsQGL7qRe1bCu7t8uEGdLirQlJ6LBSFoy9J27rCZbI/UIT1XJcsqk1Z7BH9s
	DhbpkjM9VPioAN2aLWN/PhwDdGVUnUGBcRQCnk2D5yQubYEy9WXLSXlg4eYC+m18
	KG5PGn4A1q+dD/+SgcG/iXsT6ssqj55ZKke1AxML/MSH9jak+CVFxsfWoDdy40Qt
	FRapzyc97EiBSV6BxmEe++NqMSpkQ9BxOGBZ7Q9bG8Bd6ACEARYLQaRUxTeqeLBS
	AhjvaNGU6K+1xlGkZsPunEfh9pB4oRODuuutPXmgydOpbpOmpMGOw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwj8xkq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 15 Oct 2026 10:48:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69FA51BA1927882;
	Thu, 15 Oct 2026 10:48:29 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h9ypq6fmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Oct 2026 10:48:29 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69FAmS0f11928272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Oct 2026 10:48:28 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CF0458061;
	Thu, 15 Oct 2026 10:48:28 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB2F858058;
	Thu, 15 Oct 2026 10:48:25 +0000 (GMT)
Received: from t83lp65.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 Oct 2026 10:48:25 +0000 (GMT)
From: Gautam Gala <ggala@linux.ibm.com>
To: borntraeger@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc: frankja@linux.ibm.com, david@kernel.org, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com,
        pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org
Subject: [PATCH v2 1/2] KVM: s390: fix ESSA addressing exception injection in migration mode
Date: Thu, 15 Oct 2026 12:48:21 +0200
Message-ID: <20261015104822.77062-2-ggala@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015104822.77062-1-ggala@linux.ibm.com>
References: <20261015104822.77062-1-ggala@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0MiBTYWx0ZWRfXxoNALHs0f8/O
 yj4OURQn1OobnMOTixiXMLprY/EVydyQhenM6En8Gztx1yjO9dU0rQMG6v5UAwQ5MIjAeu+sKls
 6u0yyJftjivE2KUMh/9oXNKWn6+nql8U7yyI5PRsu6iTUW3Z/cwkB0oh/useirw/9HQWanNLuXV
 D/0u8aqHDkloDGKWEAHy2wpFFNo4HlBZtAvaatG/rYL6PggFEN2laOUsznT2HO4cUirS438x+2z
 l0VMJqNyiHddc4xh4R78ptZMk63LtBAM+nyQVVfuruZSJFcjNca1ogutkZy2qyC6JwpdUx3P55p
 roUx+Zo/i7q9rUT3cHE4sE/3mJFctQYpCjTccvkDBNXF2lh1LqDg9170n64JfbviG8zgFCTlQkk
 P6I9R76dXGJR2BQwWgBSfrunS9LxBrX8X780MkcwKeLeZc6VumuFxjdNRu6Iu6r125ZFxpdiSP7
 9Vs+quKGYpEa6O8cecA==
X-Proofpoint-GUID: nmOgQ8Wcmjf59zMAQZbcYpz0qBzJ_XVL
X-Proofpoint-ORIG-GUID: JMZKFcUSTrjO425VdF3v-8-VEpiVLVqr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0MiBTYWx0ZWRfXwM27od+mjNpy
 VGxsAvc8Q9PQaRejSHFJSldTqUTfNsF6pRJS96zaw8ovplSLqLBZ01otdTEgrpUs2yaXks9+qaK
 UgwyRgeTTWpABqCvvO+4l3EOilIZRSE=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6ad0af7e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=DC66tu63K5JfY2WZsL0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150042

__do_essa() treated any negative return from dat_perform_essa() as the
normal "no CBRL entry appended" case and returned 0, so a page-table
walk failure silently dropped the addressing exception.

Return -PGM_ADDRESSING on a walk failure and inject the program
interrupt in __do_essa() for the -PGM_ADDRESSING return value.

DAT_WALK_ANY is required in the dat_entry_walk() call so that a GFN
backed by a large page (segment or region entry) does not return an
error: the walk stops early but succeeds, leaving ptep as NULL, which is
already handled by the existing "set exception state, return -1" path.
Without DAT_WALK_ANY such addresses would fall through to the new error
path and incorrectly inject PGM_ADDRESSING.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Suggested-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
---
 arch/s390/kvm/gmap/dat.c  | 5 ++++-
 arch/s390/kvm/s390/priv.c | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gmap/dat.c b/arch/s390/kvm/gmap/dat.c
index ff80d02c9f56..a2031aece4ed 100644
--- a/arch/s390/kvm/gmap/dat.c
+++ b/arch/s390/kvm/gmap/dat.c
@@ -1084,6 +1084,7 @@ int dat_set_prefix_notif_bit(union asce asce, gfn_t gfn)
  * * %1 if the page state has been altered and the page is to be added to the CBRL
  * * %0 if the page state has been altered, but the page is not to be added to the CBRL
  * * %-1 if the page state has not been altered and the page is not to be added to the CBRL
+ * * %PGM_ADDRESSING if the guest page-table walk failed
  */
 int dat_perform_essa(union asce asce, gfn_t gfn, int orc, union essa_state *state, bool *dirty)
 {
@@ -1092,7 +1093,9 @@ int dat_perform_essa(union asce asce, gfn_t gfn, int orc, union essa_state *stat
 	union pte *ptep;
 	int res = 0;
 
-	if (dat_entry_walk(NULL, gfn, asce, 0, TABLE_TYPE_PAGE_TABLE, &crstep, &ptep)) {
+	if (dat_entry_walk(NULL, gfn, asce, DAT_WALK_ANY, TABLE_TYPE_PAGE_TABLE, &crstep, &ptep))
+		return PGM_ADDRESSING;
+	if (!ptep) {
 		*state = (union essa_state) { .exception = 1 };
 		return -1;
 	}
diff --git a/arch/s390/kvm/s390/priv.c b/arch/s390/kvm/s390/priv.c
index b3cb2c2c3aa7..9089b8f5d550 100644
--- a/arch/s390/kvm/s390/priv.c
+++ b/arch/s390/kvm/s390/priv.c
@@ -1168,6 +1168,8 @@ static inline int __do_essa(struct kvm_vcpu *vcpu, const int orc)
 	entries = (vcpu->arch.sie_block->cbrlo & ~PAGE_MASK) >> 3;
 
 	nappended = dat_perform_essa(vcpu->arch.gmap->asce, gfn, orc, &state, &dirtied);
+	if (nappended == PGM_ADDRESSING)
+		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 	vcpu->run->s.regs.gprs[r1] = state.val;
 	if (nappended < 0)
 		return 0;
-- 
2.55.0

