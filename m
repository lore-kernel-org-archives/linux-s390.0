Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792770943;
	b=QTM5Xgf6P6fC0SAspKpRaNWNAlLorH8sjZDakZ7W5T5cjUKcWzXp8F7MsiLX/9Bqchw+
	 u6HaX+U13fQA4PzyH7bZqj8QCqyav2AEz6Caz/jhqS8VZUrLq12EbZUoeIHxU4k1KEiUC
	 8shSrKJ6Xhd1QUi5THDC0XoaQK2VVSmY65pryf8msxXQFSNAfCHvVWmHdiilA8rFpcc73
	 hn38qXdek3ZP1d4QEzf83O/SZlcm5KcarxtK3Gc06rX3KKVycPYE9t0SVoFkEabt2Rk4x
	 IuHVy2PVWBZ5mgDsri0UTvdGx76f7pumy5oQsRcFegpfO/7/iZyB/OP9ToFK4qq9o7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770943;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=gme1D6KaSjuykXViFrNAudx1w+FGp2xJgKly3H/xHe0=;
	b=v5QaKJCZyhigwKxN1wCcbCmA3p5cSaUSI2Z9FzMxfi7YD9KBjZ34yWDg/F3+kcWVrH82
	 X8lzTU9CFlV/LlNacRnHLBnWGhOFNthOYZGcYcv9hvTw6aF3ewueKB7kxhmHzE+t4IAxa
	 J9NKwzyP6G4BvPYmAljO3Ga2clG9G+0bnFNpPGx4jznXLjE2N/wjmeajP6AIOcKw4U48B
	 KBuvW8awLSxEJ6nDV4v5+FC5vmIAjaziW8L4smU+z+cQbnACPB47O997fBpFrYhXhGaUh
	 8WTqCBZSyXdxFH3XBDdf/TmWXg9vcxBAO7ZbdZ76SpuNtnRIOiVkxSRb80BBBUh3MJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="pOyzlhO/";
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C41606A327;
	Fri, 23 Oct 2026 15:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9C41606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pOyzlhO/
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NEEDow3288886;
	Fri, 23 Oct 2026 15:55:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gme1D6KaSjuykXViF
	rNAudx1w+FGp2xJgKly3H/xHe0=; b=pOyzlhO/PVRS6DqdoR2DnHrfc8zFpvTqH
	3gocKg/hPl0p125WqCl/fOMUL053GvWYGNLkJSgIwunO+EQgn27gbKXVdxAJXi5v
	FhiLsAyiIRXt2kgaJ8dOGz2cL58A3sRdQEUukTf3IwDRZ/lqC6lTExndPNU6pI0q
	w52RCV5iB0gtRxl9N3H5MnJQgUFeKHWjxERi8R9UIjLTPRlPq/7it9uK3L60FXne
	lhk8VsdthPXJtwqkx7V+sk+e1qTmgHsdKdnFZeCdrs1ipFlFE8oX2eTQqv5/PQJi
	gcKGm4NpOuGLDUUJ8R9t0mo37uMzRIfBkioN/pEQaczj0bcW+x+kA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw596692-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 15:55:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69NE65Xq2263015;
	Fri, 23 Oct 2026 15:55:39 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hfgck67dk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 15:55:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69NFtWGl31851212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 15:55:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B12A20043;
	Fri, 23 Oct 2026 15:55:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BA072004D;
	Fri, 23 Oct 2026 15:55:32 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 15:55:32 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v2 04/10] KVM: s390: Automatically enable storage keys for UCONTROL VMs
Date: Fri, 23 Oct 2026 17:55:25 +0200
Message-ID: <20261023155531.206113-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023155531.206113-1-imbrenda@linux.ibm.com>
References: <20261023155531.206113-1-imbrenda@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kCzN7cPOJe-OEJrIpVGEF3MSn7RBenyz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MSBTYWx0ZWRfXwYEJJ1uP1HZf
 zK45akWLnNjRLfKC3ZtWAcDJieeTg9tKjSZjNk8N04OtlRtfucdWv3LRe+Ntq5AhLMtQ31ZSk5T
 Bdkn6Udg54Uv9UgRkRu12Ml2FcHl420=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MSBTYWx0ZWRfX2+q3YVEwgH8a
 IJGXx9FpSRDYCCq+vjv6FqYtqrOMnL8TiUEvfVWRqyhQXkYrHRgIj9ekDdCRXbx1nWYyLNyj8iA
 tI90QcnwBJgIZ2JKNC8c5TcR5DW1gV6Xu5FgaE8KCDwRvZ2NSJuazgsFipGq7pZnh4yPhQd789v
 yS/tKJfiJOXfArGkbxUksw9W4WxHAMmMZs+htBD3ZFCYPXUNj73Z+bYBNK9r7VYovofIpMcb73U
 d+YZQRTsEwhh0n6b2q2NXUIbfYpaPeNTCLyM3q5mrKwxKyMpfinv79+ao0PKkk5NqDAm+NGnkQE
 UDCdTyEYR8AjhwMzzKt2n/b0DQ8Wn27iCwgXqX4Ht84EZvy8u75ay3C7jDiA41YAkI89k3WfHG6
 ddOsm4DDW2qNQOMopZGQV2yEpBt/Em2s2ozBj+FOFvWfzL7qUoZxj1jGh9cjcjsBRtFOT7lxGGL
 5B/ZrZLjNm+9HupMTLQ==
X-Proofpoint-ORIG-GUID: kCzN7cPOJe-OEJrIpVGEF3MSn7RBenyz
X-Authority-Analysis: v=2.4 cv=Ob4NnRTY c=1 sm=1 tr=0 ts=6adb837c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=YbjXXk8-Ty8lgCeYkKMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230061

Automatically enable storage keys for UCONTROL VMs upon creation. There
is no point in leaving it to the lazy initialization, as storage keys
will almost surely be used very early in the boot process of a UCONTROL
guest. Furthermore, if storage keys initialization fails, it will
prevent the VM from starting, instead of failing at runtime.

Opportunistically improve error handling if the fake memslot cannot be
initialized properly.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/s390/s390.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index e4912db67adc..dafcd104d316 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -3346,10 +3346,15 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 			.flags = 0,
 		};
 
+		rc = gmap_enable_skeys(kvm->arch.gmap);
+		if (rc)
+			goto out_err;
 		/* one flat fake memslot covering the whole address-space */
 		mutex_lock(&kvm->slots_lock);
-		KVM_BUG_ON(kvm_set_internal_memslot(kvm, &fake_memslot), kvm);
+		rc = kvm_set_internal_memslot(kvm, &fake_memslot);
 		mutex_unlock(&kvm->slots_lock);
+		if (KVM_BUG_ON(rc, kvm))
+			goto out_err;
 		set_bit(GMAP_FLAG_IS_UCONTROL, &kvm->arch.gmap->flags);
 	} else {
 		struct crst_table *table = dereference_asce(kvm->arch.gmap->asce);
@@ -3369,6 +3374,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	return 0;
 out_err:
+	if (kvm->arch.gmap)
+		kvm->arch.gmap = gmap_put(kvm->arch.gmap);
 	free_page((unsigned long)kvm->arch.sie_page2);
 	debug_unregister(kvm->arch.dbf);
 	sca_dispose(kvm);
-- 
2.56.0

