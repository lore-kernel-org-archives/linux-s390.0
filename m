Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D7542FCA9;
	Wed,  5 Aug 2026 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927922; cv=none; b=blDXLwNmYuy1wZ/rFkR9DCK6Jl9kg5L5QUnJ87UVI/dTRuZYeqPO97cTh00fB9zXvNrQjSigfCUdQ2iJkfwP2fGB52TwGnQxXAeK4U0XaptixzncKcOLHC0t58qJ/oSQoQwJx+Zd6Q9sFUwNLMVHVwI5bBj3NdnJAb9W2jSRGhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927922; c=relaxed/simple;
	bh=Fm7zloFicu0UluUepmH4sqs2TetOgKPCT9oWfa8Zh3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dp2wrHYcT0mTEmmhlGveCUnhJt2iljpd19Bj1jDp2M5VHLRrUWwUatOrAFLHXsu1+HcYyEugvOgaaRMkdxSIg8xhXa7IuUNOau7hNfHOZrWI/m1QCHGjdgz50fBhMgQU7r5U4Y4AttjQ+YTS8P4TVh7ICxmdp2XI3RTVTT3qDTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gt0IReCN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gt0IReCN"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758m2l53438542;
	Wed, 5 Aug 2026 11:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=smpo3eNXjbVmeu8FC
	QdsYn8MMHXjm7LLib5bWGxq8jA=; b=Gt0IReCN/Zcg5UyWv2IyyGOe2HxwvVJEB
	S7Pkmqau14bbVHu5Ha9IyDTBPBF/EyLV/aOtIEWLC5Lyah18LKNbgwu6qs8hUrOn
	Np+cJb44q6CNwri83nNn4yYAvLbKtQnqwzVvf8yWTqau5IRHEDl1mdpVWIwhZCbY
	UZrglH8KZKF0Bz0lOSUIMa1u7zROomgp+Fl2FWia7AyxX8KJ3CqUABAdAcZ3zWeC
	S+/BnOJxoLQnHtJXFqFQeIQ4TdoxivqN58v064hrvEKzxOwB5+SPqMZzsVwAPO5x
	z8vKrNqJEz9R+uQSXtNEz2TFCVTxrbtgTbDiL0eIYmEOMS60A0BPQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8eut4wh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:05:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675AuFnZ020928;
	Wed, 5 Aug 2026 11:05:17 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qpbf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:05:17 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675B5G4J27591400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:05:16 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31F6A58232;
	Wed,  5 Aug 2026 11:05:16 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BA2C58234;
	Wed,  5 Aug 2026 11:05:14 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 11:05:14 +0000 (GMT)
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
Subject: [PATCH v3 8/8] KVM: s390: Fix length check __import_wp_info()
Date: Wed,  5 Aug 2026 13:04:55 +0200
Message-ID: <20260805110455.7200-9-borntraeger@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 2hbGDGubmQqNExwQD3-XZ0hOFs0V-sc1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX4Z4syrbTcfKE
 FgdocJ2VPVOt5XrSFPMvZI3USDEgrvQYVMNYvMo9pLANRFaa9i1D7yle8DzsEfO66VKQfrrEjVG
 6jE5r435ZuuxJ7zi328Ae3RoWN3ULX8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX0EiHDRSDfngH
 3NINjwwE7kvC0/otmDiNhcoKb6jNHDeqM85rObwCOHW8PSxGqNOEr663ExafRXaxNZouuqD2Y8n
 4lll/zQIXgOp9M40jS4/W6LoHXFk36b94vmeJjOevfNQ3BYl9X5grnFoAGrjJixm/LO1R15tTmT
 jrO/4Au5WLQYxwsDCBCGCPnyFKV0McGuaVVirFB7rTSR2m1mDudwLqi3w2urq4b6bLWb1TrTzLF
 WWMjqKIwLOz1RxBaqqAB+jUpaaVGedpy82OGujlypMppbkg5w1uSpC777Eo7Z5pJ97mC0ZPeqTp
 fTWW3dfabp/hoSLKH86ph3yfKdbI0Dop9guvSJhD+ZJS/NiIIgTHb1hJpzO7KoHK1AZj4BDU7di
 1Txuziapu1zjA6UQJLPyjZNy36XDhMi0sn8bQie5iK+0/MAKhUXqJMLjtqlPyfMphZ/0vIL+gpm
 bxhcj2fzD+CX2pHnF9Q==
X-Proofpoint-GUID: 2hbGDGubmQqNExwQD3-XZ0hOFs0V-sc1
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a7318ee cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Wui25AcxXJO4yD6ELYcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050086

struct kvm_hw_breakpoint::len is a __u64 that is fully controlled by user
space. This is then assigned to wp_info->len, which is an int. The bounds
check is done on the truncated value while the allocation uses the
untruncated one:

	wp_info->len = bp_data->len;
	[...]
	if (wp_info->len < 0 || wp_info->len > MAX_WP_SIZE)
		return -EINVAL;

	wp_info->old_data = kmalloc(bp_data->len, GFP_KERNEL_ACCOUNT);

Use the validated value for the allocation as intended. Without this
fix userspace can trigger >4GB allocations which will fail and result
in a WARN due to MAX_PAGE_ORDER.

Fixes: 27291e2165b6 ("KVM: s390: hardware support for guest debugging")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/guestdbg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
index f7c94d54efbe..9a6149e310bb 100644
--- a/arch/s390/kvm/guestdbg.c
+++ b/arch/s390/kvm/guestdbg.c
@@ -184,7 +184,7 @@ static int __import_wp_info(struct kvm_vcpu *vcpu,
 	if (wp_info->len < 0 || wp_info->len > MAX_WP_SIZE)
 		return -EINVAL;
 
-	wp_info->old_data = kmalloc(bp_data->len, GFP_KERNEL_ACCOUNT);
+	wp_info->old_data = kmalloc(wp_info->len, GFP_KERNEL_ACCOUNT);
 	if (!wp_info->old_data)
 		return -ENOMEM;
 	/* try to backup the original value */
-- 
2.53.0

