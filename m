Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D2E407CF1;
	Mon,  3 Aug 2026 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760854; cv=none; b=jq4ESCkCZEUV2qoietjmKA0Ye79PT5yceqFDy0FXhoFCjF3dktcZKjOm8NQoHBVAJmFIqb/OmkC7B6IZet+nsfHSKIWMcvTqmRCnR0Pq1fsH5nD/pNOG6ar0oj8k4nvMEdD0tHXShvFCI+RS7Sm1emQPIuEcS6742RT7Yy5G+m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760854; c=relaxed/simple;
	bh=rGUq/bbmBOybJjU+Ue7l7Uyfv2XCqwBWhe6A32dvtIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xu5WfcMsyoLZ99Q30P3EkFLoDHJPNI88e5ov8OxsKCoQE2GFK3xvZsu+3LnaI3CYFjbEs1PsfFjkBNlHePJHNlFknaCAzozOXtYBh1K5+Tlswk1bhqhgo0xSaCqJ4wvpXviglzRz5je/uKq5I7Ug6owonpwPRTcpWe11oPRXcyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=shlY6Uaz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="shlY6Uaz"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673CHk8C1943450;
	Mon, 3 Aug 2026 12:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=a8o63o8zb7q/KcknA
	rEgZd6tgJdqLJy5aq5FS+Lux1A=; b=shlY6UaznbS+k4Q3/Tg0b58P0Q+WMApeu
	asgSf7Ch3jGKXvoM0b1L0d0/B+k004NzTeDM7/IleM3fA88vm6YmD51W+f0LeYnx
	x36AsVx/1eTCgGMPFB14XmT1aVQJ6UaS/CIWIkLbcPpHLVO6DbwZqnia7t6eS+nt
	Qa4RI+XmSuzK7sTtzZ8ou+Pwshmyq07frsU6Sfpwns2JGfcBJm01484qE0uLl7kt
	bg3tk+FFuLG2+Pa0WVs139fp7K5eLxQ0rpJ55MuXVuS7xtFzkvS1/AC7ZeYDW7se
	wLFJFPy2LjEYD/4slmrfHBvY82vkPUKd4oByDaXDf1e4Hr1tIr2ig==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77g0k6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 12:40:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673CQMl8027377;
	Mon, 3 Aug 2026 12:40:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4jwbsc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 12:40:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673CegxW52625856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 12:40:42 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8198220043;
	Mon,  3 Aug 2026 12:40:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20D9D2004D;
	Mon,  3 Aug 2026 12:40:42 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 12:40:42 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v8 02/13] KVM: s390: Do not free SCA if it was not allocated
Date: Mon,  3 Aug 2026 14:40:29 +0200
Message-ID: <20260803124040.126471-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803124040.126471-1-imbrenda@linux.ibm.com>
References: <20260803124040.126471-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDExMCBTYWx0ZWRfX5lcv7gnQyOlw
 M+kYFomKKDgus4L3ZwkwcJiIcyemKl1JDerojUhGYuH07axB1kXohRAH4yyftXCWXIKdGnTQPrE
 JfeRNXlI46sUYK9G0FEln0LKa4GkZTn/vSsbA+e8rHdJsdMX94BX2xCbsw8xFZuBFERmgdOyc1q
 APO6FpP4oTR2c/VLOP7/20bmYVMkifd/mHDBRqy4BjrVPu2D4q1uZ3447G2kzWrKGTczB7cF0dq
 rENViTiDySb46GPirhSe9xyeq1e83y0SS9fWwAuUtYU8UYRe0+agCioVADuPMiErv5sRh7oOZTD
 jROEXBJwTvHEbe8oRvK7BprpyzD1quf0uHqLd8fd5Vbg7JJfCGb1RzIQQLYbRK05jMd2SvABgm0
 Athic54t6UIccc4X8aiKi7a0dlsOgYxI5lg+Cy4vLqolGApsHGEI1+97RUeznFXfor7QJbELJJL
 ua9BXQSzIrtZwIOqGvA==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a708c51 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=M5uM2SGDJJfKum1V:21 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=3jiQNkuJ7WxZ42At8I0A:9
X-Proofpoint-GUID: _HaArXb3H2aZ5TxBOTQ4TjxMHq3FSvoF
X-Proofpoint-ORIG-GUID: _HaArXb3H2aZ5TxBOTQ4TjxMHq3FSvoF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDExMCBTYWx0ZWRfX9Z65QaW+Rgse
 VxSMGb6yXWMk11ocIf8VuQFUEjQfBYhebZZlfahuTWzAawsQQjfjjAqFfNMVD4DySrPRNWuq+Qm
 9VoYx7iB6/OwWX5kAC+W6j2qLUB8tCI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030110

If VM creation fails early in kvm_arch_init_vm(), the cleanup code
tries to free up the SCA, even though the address is 0. Due to using
free_pages_exact(), only the first page is skipped, accidentally
freeing pages 1, 2, and 3.

Fix by checking whether the pointer is NULL before attempting to free
the SCA in sca_dispose().

Fixes: e72753ed1267 ("KVM: s390: Use ESCA instead of BSCA at VM init")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index f86b4b0b356f..1b3290a5ad1a 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3247,7 +3247,8 @@ static void kvm_s390_crypto_init(struct kvm *kvm)
 
 static void sca_dispose(struct kvm *kvm)
 {
-	free_pages_exact(kvm->arch.sca, sizeof(*kvm->arch.sca));
+	if (kvm->arch.sca)
+		free_pages_exact(kvm->arch.sca, sizeof(*kvm->arch.sca));
 	kvm->arch.sca = NULL;
 }
 
-- 
2.55.0

