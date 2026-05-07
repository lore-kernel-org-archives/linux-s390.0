Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9014B3612D5;
	Thu,  7 May 2026 20:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778184531; cv=none; b=Y68pEoaO/5uyAqi2aEM91dX3CCKTZte7nXpch41Ngq/BEvU+2cKxJPJOHxVLG+ONhl28Nky3ABRZpOSY1KZBm+XvClh/6t6TJXuc8QsVeOtlUJWUaaxsduWnsMR1Hnf/xwbChgyhaHnpwBbzTPQ/Rl1kfL+7JLtALGptkeCxkxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778184531; c=relaxed/simple;
	bh=HP/cwJLSNh81P4WT7sjFILZDH6A1wrVT5g+goXXAZXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nfy2narrasJUDyCzCqQfx5oP8fJJx0eo2SxW8fnhUDGt8SylcBTq9g6YdoVdgn+rkzqPb5Tmxzuf/C8FIL2XAU0IipQ1rHzBkK6Kjkv5kBzR+oqFa2M8Y2zMCHZvohGoR+2/gpign6iLydnHRVH7KqNdGZyqSMoNCJjwrvE2B4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bgu4k8bt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bgu4k8bt"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647Cbsi32822130;
	Thu, 7 May 2026 20:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=C5yuEhPcNaNiBat0N
	fN4aagV1RWR8mT0eOcw8ierToU=; b=bgu4k8btLgTIJqbPw9UxcGcpWsjPEr3V2
	qPmzjTbfqdVLgdKkVDs/DFPswjAZlqsrMMyF/V4XMWM4fIvjM119X+aUKICw0BJP
	6Gmlr+dicIbGv72+4Q9IWZQ3upADr3kfZU17JSiJpxXaj8RfuKYkk3n4UXodlmSB
	nPplVSdfmd3VKitU8CRP7eAK69fUM6WnMl5W/JZlID+xWlf3g5AuyJfH+GHkYnu7
	4Yn79hOjBl7Nm9v7t7LuM05l1hua+Za2QNbuNM2aymmJst2l2ApKGppmR6CBDl5J
	o3BzksE4LIf+HS6KSSBVIAmeRSaxRYmL3cEx85jj9hIx40QM8LxxA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y4yknw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 20:08:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 647JshAX012851;
	Thu, 7 May 2026 20:08:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuywdfhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 20:08:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 647K8gNw60358916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 20:08:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 284CF2004F;
	Thu,  7 May 2026 20:08:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 082772004E;
	Thu,  7 May 2026 20:08:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu,  7 May 2026 20:08:41 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id E467DE05EE; Thu, 07 May 2026 22:08:41 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 3/3] KVM: s390: Fix typo in UCONTROL documentation
Date: Thu,  7 May 2026 22:08:36 +0200
Message-ID: <20260507200836.3500368-4-farman@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260507200836.3500368-1-farman@linux.ibm.com>
References: <20260507200836.3500368-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDIwMyBTYWx0ZWRfX6eUhmaLmpbyn
 FVaydGxwGvwiM+YwrICnBLVOsAp/I5FYAsZ0C/IUQ2c4PtcmtuCbq3j65mZMc68/lmuwZpuy4OJ
 qUomqYKA56Yjv7yA/7EAl8QleiaRpVbBDZy+bCZtUDwyiZpkpjhc7taFOXRO2LNzHlZlDQM4GSQ
 HaVVNxA7J8S+DS6++pW4pBPczdzbHf2ObfNiDqmhtptbezJUpmLK6Tt6bi9JWo6eZtlKHZ546u5
 FAX1+pjz0kfphiMYQ6GV1LKyqA84Cobp/TBEi4vWvBghMsf/0+sctQC6i5OrU2aVABHcnOPpwkL
 4k6fPR5xuPGbpOO1EYn3OqydZv/Xa+nUK86mU+kkcx7duQkU/NGzvBIsAmlXPvoHN3rLApLxHEF
 qwA9vWnhZ/ONHbBlOI1gCGHooAqc13nOJizccrUNPoqPY5yu1hQGf4l5gVDzwQt6Sa/y3xPhJHw
 +4KK0s/Btv28Z6CkmHA==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69fcf14e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=emoZMvze5Uwv_vEF60kA:9
X-Proofpoint-GUID: pGRjhs2C8h1FWv4jKEJFNv7CIV-nTAhF
X-Proofpoint-ORIG-GUID: pGRjhs2C8h1FWv4jKEJFNv7CIV-nTAhF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070203

Small typo noticed while writing the USER_OPEREXEC selftest.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 Documentation/virt/kvm/api.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.=
rst
index 52bbbb553ce1..f0eba90602f0 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6827,7 +6827,7 @@ s390 specific.
 		} s390_ucontrol;
=20
 s390 specific. A page fault has occurred for a user controlled virtual
-machine (KVM_VM_S390_UNCONTROL) on its host page table that cannot be
+machine (KVM_VM_S390_UCONTROL) on its host page table that cannot be
 resolved by the kernel.
 The program code and the translation exception code that were placed
 in the cpu's lowcore are presented here as defined by the z Architecture
--=20
2.51.0

