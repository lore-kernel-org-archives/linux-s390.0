Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F085332ED0;
	Mon, 10 Aug 2026 15:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377268; cv=none; b=KnSS/4relAzXgY4k/l2/x7/smmXXi/HSsYNOUZVpiwEZb36DwynJn2QFTSWgOEB9neqKLw5i8wzEsg8D/oV93RDM6QLntEUzKgZILzBSFDPyfJkHiqtSgKuv7rkSSwlnC0ZmmVkAKgTWcU84IWICG8mmLjpCgvSGB6rtNjU1jf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377268; c=relaxed/simple;
	bh=zuthN6HjS/AiOUi4lIU3gHsB3uC9c93aISi2xPp39FM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fgxE7L9KHpWrKa2Gq7qr0a2F2TueFmvbl2kwkjusCMdW6ny8TORdKZT4Ydl15CSUeNJt1LHDE5IIxO7obNEM/8CI2VSqTL//SK3u8ig1vpgTy5iSYps076jIP0WeLnuWAzaFj/afNwTC0KBvWlezKyaUGF1KVmaX9cY0oLEWRAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PNZ4GzCL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PNZ4GzCL"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AFWhPX2026091;
	Mon, 10 Aug 2026 15:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=70V3WW
	fFUp9pdvJCairBkrfVQKtr/niU+0TPeCngX4c=; b=PNZ4GzCLxFqv54wyFIXdS9
	+RGmyskQtDqMlrSLiJ9KP7qMNLTv+sqKl/gfn4BtzyTeVBRNdvHCDah2h8l5X5ne
	CFwECXSFU5X4YeLxb4DQgDam21Dla0RyxfMJhbNGgrv/maVFI7kIfcmb5lXKQlSH
	ICxJad4kYyYbGnQgI0LpZbt6HBrx6umr9aMLMGC2dtjPyZwTcfFNOQrFtkhR2kzn
	bwnImLlUCUvVHoKWemD8qw+uAGjOEy4e+VQxEuJoCwjFLViLeM8GwSYG6GFmXGA5
	kddJFgsxAXcGm6xinY/XfzoYXVvkk6jt95oel6M9A5Cx7QjD+CEOcn/L0FZb61ug
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9gua7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 15:54:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AFgcpY027346;
	Mon, 10 Aug 2026 15:54:23 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g5905-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 15:54:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AFsJJ438207860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 15:54:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B39D20040;
	Mon, 10 Aug 2026 15:54:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E7862004B;
	Mon, 10 Aug 2026 15:54:18 +0000 (GMT)
Received: from [192.168.88.52] (unknown [9.111.41.151])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 15:54:18 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Mon, 10 Aug 2026 17:53:58 +0200
Subject: [PATCH v2 10/20] KVM: s390: vsie: Add helper to release gmap
 shadow
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-vsie-sigpi-v2-10-e8d59a2f2f70@linux.ibm.com>
References: <20260810-vsie-sigpi-v2-0-e8d59a2f2f70@linux.ibm.com>
In-Reply-To: <20260810-vsie-sigpi-v2-0-e8d59a2f2f70@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1511;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=zuthN6HjS/AiOUi4lIU3gHsB3uC9c93aISi2xPp39FM=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFmVX5T+Pzx4eGrzlPhZNa0fGBZ5bxA29NvszDf9guqK2
 Hu3VX5HdJSyMIhxMciKKbJUi1vnVfW1Lp1z0PIazBxWJpAhDFycAjARH2ZGhgcWb8ymbBbhuhcY
 WRCwTLr0THB14M7oK7eNN3tZiOwMPcvwV8Yvs31JV1H3J9bDAReal0h9Vd1an3R069sjb/rf3Lp
 UxA8A
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEzNCBTYWx0ZWRfXwRiy605QDFqu
 G+rbbHCndYkprMb8d11lRPYOVQvEUsV+vyQg9LIKTbK2Qey9MLmCRooNSTYcbqCVpamihTgpIec
 5QaZAD5wgVFuJbObQBMofXcglkgXNJC66cHWjWKDb+A4z0A5Z+ZkoD1lDQ4YnjvvVrlFw1kOWho
 b57qWtjYu6UyXYLvdeG37KyU7IdGqXobKa1jo0WanPL5x3WrudvKOe5cyFI2ZFT5z0G+skq14YB
 IJeXAVY1GLqJlc+zgKdHiptUYtkvWRlwHN/GSYvGNpXJc7Rfuay/jDfDuP9LPcmtxHhUwxRl0Pw
 QzP1I5nuhgb+H+7h71PfGqnTEKQGdgkfKhkv9sA1SJMxF1zJoFqoVLB7GryLS8ZVLSzGVfF9sB+
 L6GxvH8rrgYdxFpmBu5SbRBKe6CQkuc6i9DYFAme+QQPVjPOJcrgDNInvDCpHlVv4+EZ+oVqptD
 6jU88F5jZOL6lSWgi0w==
X-Proofpoint-ORIG-GUID: HHyg0jDWBodLyy8yOPnbBsly0xPpTIXq
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEzNCBTYWx0ZWRfX+3NGRbrVfCjg
 2nUu/OvmpPXL9DcVVf08rKdh7PTT+VHK0LIKUPiJ9tGe674gffB0h0y9mm38mxIKrZ1yU/kqwj/
 z+r4DYYfFG/pZa50w8FAMCAaahK7Khs=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a79f42f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=520cwpyMf__qVmlIlYMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: HHyg0jDWBodLyy8yOPnbBsly0xPpTIXq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100134

Create a helper method release_gmap_shadow_safe() to simplify releasing
the gmap shadow of a vsie_page.
Will be called from multiple places in upcoming patches.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 6bde6a3ee850..d0806871885c 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -164,6 +164,15 @@ static void release_gmap_shadow(struct vsie_page *vsie_page)
 	}
 }
 
+static void release_gmap_shadow_safe(struct kvm *kvm, struct vsie_page *vsie_page)
+{
+	if (vsie_page->gmap_cache.gmap) {
+		guard(spinlock)(&kvm->arch.gmap->children_lock);
+		if (vsie_page->gmap_cache.gmap)
+			release_gmap_shadow(vsie_page);
+	}
+}
+
 static struct gmap *acquire_gmap_shadow(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 {
 	union ctlreg0 cr0;
@@ -1585,11 +1594,7 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 	mutex_unlock(&kvm->arch.vsie.mutex);
 
 	memset(&vsie_page->scb_s, 0, sizeof(struct kvm_s390_sie_block));
-	if (vsie_page->gmap_cache.gmap) {
-		scoped_guard(spinlock, &kvm->arch.gmap->children_lock)
-			if (vsie_page->gmap_cache.gmap)
-				release_gmap_shadow(vsie_page);
-	}
+	release_gmap_shadow_safe(kvm, vsie_page);
 	prefix_unmapped(vsie_page);
 	vsie_page->fault_addr = 0;
 	vsie_page->scb_s.ihcpu = 0xffffU;

-- 
2.55.0

