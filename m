Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543E0381E88;
	Thu,  2 Jul 2026 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783005866; cv=none; b=Mp9MvxDTiTgEpGYcnbLzkJGULwxxxN/xBak6Fsp5U2ZNtYd75mqpfQgF95XxZ5NdkYoe043LV5tx9sS1kCVR8M1xB+O4FiHnlUKKWAhWb5BiOPx7jCtvIEZqY012K9uj+4RarUwJSYbngOOU0fqJIT1gSPlf3xZ9uTs0KtjHouI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783005866; c=relaxed/simple;
	bh=BwHswe5hsLb31FjUZprpPKX7twvFGBSBS1MDowARh6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iA/zuUW7X2PPSSj3rLWzcr9MO9ZdxSahTMYMuTu71kdhj1N4ChhaJ6wKbRUDbs9wESeAsH4k8AsSq4vJjwPTOoiCo2MO+4fFqW+d4gzlWvn3hq3h499FmQpIPgq3t51uLHxqthxro9dBTcSGt4KifMBtZLfwv0+zwXVfec1gWeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AULxT/X2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AULxT/X2"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662EIQ91075422;
	Thu, 2 Jul 2026 15:24:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RLqK/I7P4QWId9oRl
	xiSx9peDQCyehent5QW7G0D8Qk=; b=AULxT/X2pNpHW7IaJJWOBtf0aJeZU4MBn
	ztHgNf1HvdPicxzc9fT0Sv6zwb+anpVyGSlPSBlU6spAwGNmuhihEwQ2XB6gmIOB
	mpEseHn+B6EhH/IrJJ5BodE/3DYk5jTlfXc4R/AjiHfB+bmlAHtrsI45xOFgwpoQ
	Au/mwVavx1x1WIxGhtAg+bma3Ir1oWx1bgNpqHQT8NUHZ3AleNzFMC+/gULQ4rU3
	aQTbidTz5tPyjIfJ2egAwuWhKs//h5qeVpuwglO/udxSFsZs4hGitsHnUERHiR4T
	Kn16nxopbUMmn3asfX37hlHOgBcCS1rZHLnhdX6hj8Bb60+sS8LEA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qgamwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 15:24:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 662FJlda005744;
	Thu, 2 Jul 2026 15:24:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2gmebs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 15:24:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 662FOBUH52298204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Jul 2026 15:24:11 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D78A2004B;
	Thu,  2 Jul 2026 15:24:11 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26E072004D;
	Thu,  2 Jul 2026 15:24:10 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.87.55])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Jul 2026 15:24:10 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 3/8] KVM: s390: Fix unlikely race with KVM_CAP_S390_USER_OPEREXEC
Date: Thu,  2 Jul 2026 17:24:01 +0200
Message-ID: <20260702152406.204782-4-imbrenda@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a4682a1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=vJOriIrvu-EpxVUA33oA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE2MCBTYWx0ZWRfX18sNThfsRQT2
 Q7Fy62+Wo5ihrIHgGoRa4OvbvG0xTCsA6k7ccpXnKNIdolRXjIEF3VOFW8wN1uvAoPo+RrFRpQ1
 r/26V0CeDq2Zobop0QRp5hSC3jgRJCk=
X-Proofpoint-GUID: YTDvj57G52zjxe0hGAIScyLYBBnAAy5g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE2MCBTYWx0ZWRfX1JHI+BIJNr/b
 xtdpfdrXX8oSaqFeokjtBTQCHXVry3YXcM7TM+kxhPsUHyC1DdhBX26y72DdLn9THLFz/+CkuOK
 nuMjwYj8KYQ3ddLBntsockCZu24WxuSMPi1Ym+MAYo4WE6qWjQihNmrak4PPU2AbcfwqzCU5yRA
 y5YABaGpWSQdF8aNFjPfnxA0n8dRwfiFDq/fQQQZY1opn3BrVnkWRmwdQMX3JeY9g3XgQAiED7L
 WRP9FxBuk3L7DZC9h01d81Tu5FBhd2bRUaSretrLhAKUEEHUt7a6WbfZgZiLmsj+FFWsbLoacwH
 jafPLNfRhWWxvdMNjVZejNUdMUiBUdirzOc16VXcTV9UNvzXWmNAPvMx3oYicu0cmJkkkQ5lDnq
 sE4bjmq09gDSnzSJVGLshriOaqY2eskqEmAL+AKA8qhjwq89F8r9vvWIIBfnurPZefb4jre9kLG
 z92SZQy9Que/lYllBtg==
X-Proofpoint-ORIG-GUID: YTDvj57G52zjxe0hGAIScyLYBBnAAy5g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020160

Due to a missing barrier, it was theoretically possible that a vCPU
being created concurrently with enabling KVM_CAP_S390_USER_OPEREXEC
would end up with the capability not enabled.

Fix by using WRITE_ONCE(), which is enough on s390.

Fixes: 8e8678e740ec ("KVM: s390: Add capability that forwards operation exceptions")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 4a6d903e3523..784f7d9c79c7 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -955,7 +955,7 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
 		break;
 	case KVM_CAP_S390_USER_OPEREXEC:
 		VM_EVENT(kvm, 3, "%s", "ENABLE: CAP_S390_USER_OPEREXEC");
-		kvm->arch.user_operexec = 1;
+		WRITE_ONCE(kvm->arch.user_operexec, 1);
 		icpt_operexc_on_all_vcpus(kvm);
 		r = 0;
 		break;
-- 
2.55.0

