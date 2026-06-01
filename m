Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E083D9DAD;
	Mon,  1 Jun 2026 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327819; cv=none; b=SQM+aF5y2KKacaVEgeDVerybTarT8cRDiMsTfcHCa6t5AeB/Iy4CmV/cNONKAPZIXpBIWebtkUPNKLRUywdVyey0tci0p4PbbpCHRChoeFd3wj9HblVxVHWJU7QPnN4dYzOW5kN4sKZTeNBB/h81LJGVHp3dZOL0WUoGbRx0YZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327819; c=relaxed/simple;
	bh=zx6TNjrr5sxF/JXLwJ0ARC1L8V6fY9iLaJ2DLC5EdXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBaqB5bxC8jD79ZQ2nm0bP6FgxkRyQpoHStKsGc9xCxuBYC1pKJEaH8bAVNif5/eltmAwiwLWJYgU2LXVUUJrLPD3arAqUmqKSVGUzkAFxfKDF3WW8htT5cR8LRAMU7pz39ZX/HtCcm5GNHGjPNRu2YMuW2OxyhjRwMvHuV5SAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pbsrcwqJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pbsrcwqJ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651Cl02w3195132;
	Mon, 1 Jun 2026 15:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=OP2M1HsEe+DgddDeh
	HcZonXB7ZpUy8+gPxxm8UoJYtA=; b=pbsrcwqJK+bCZPxNZJZ4WEV71gQ6qCwJt
	XUvlMlHY2LTHCrF5oAJvN58QJlGy2a13e0DHqiN4+opRWH23Lkci6tiyhzKFxGFo
	nlLda8LiG6XoVBNrlEZyFv8iQrZXxYdqH7XidZ7ovse+p58ADSanrutK9H0Abtm6
	FlMUxW1O8J48HXZkqKwAgUE7yq1D8W/Y1vDG2Q3mQenT7qmI+fE9Tk437L0ZmCSY
	jvXb19zyTRJCRyeHLA3sPUVNBuoVAqLPju+7XmsLG1cGSQTkxZIqA6bLoIFw42HF
	DQ2rOyZOFQuPBWM71ZJqZwA0xFS1zHBHj1xs3CNLMjliyVJp8h8Fw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqht12yk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 15:29:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651FO7RD031048;
	Mon, 1 Jun 2026 15:29:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakvpvx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 15:29:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 651FTr4m50725128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 15:29:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9178520040;
	Mon,  1 Jun 2026 15:29:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68C932004B;
	Mon,  1 Jun 2026 15:29:53 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jun 2026 15:29:53 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 8/8] KVM: s390: Prevent memslots outside the ASCE range
Date: Mon,  1 Jun 2026 17:29:51 +0200
Message-ID: <20260601152951.196859-9-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601152951.196859-1-imbrenda@linux.ibm.com>
References: <20260601152951.196859-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5dZ_XfCxKcOQB-2GlXFSF-um3BPe80yf
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a1da578 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=1rJwsmJvMo9JdAIlmdgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE1MSBTYWx0ZWRfX8peYSN6aQfEE
 gToq0kzKYgwEkPCaHomjufsX8nCQSTa0AOQK6bJKPcH+8c3nv+a+JzcstdSQL4a7kne6h5dL7h+
 h3cn1cp1mkoqY4JlqGUCwI4w+cGfVMfIzvOrHoJs1lKvGHDCmr9zRsjbHbRkJ8aFA5d1g+iScwW
 2QwxJYJVod8g21PIm6ip3TXEbzSgS0qNxHKYM3DqsOfpMwfyQSvFoN8VLKE6Fd7rjH0YFEtjHwU
 SRFg6xrI1YNNKPra+I6rSnqmjmnB53DaNVE9UMgUVuVRgZtHpRpiRm4xxKxool2QW8npw19DOnt
 nF4ZK0ThY09ACJUE22dZEXv+3sFdA5EXSRrAPFc+w5rbOXNZ9Jr582FknlIGdQ/Po+lRQimj06k
 dJeQ9wGTnClHmqoxtmTC22UMdwvGDvBv21ucy1+CZ/VUu3SeJp24B9feArboWMMAERUXqFWTx2f
 qjqoDFVX5rbnsG2QiYA==
X-Proofpoint-ORIG-GUID: 5dZ_XfCxKcOQB-2GlXFSF-um3BPe80yf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010151

With KVM_S390_VM_MEM_LIMIT_SIZE, userspace can set the highest address
allowed for the VM. Creating a memslot that lies over the maximum
address does not make sense and is only a potential source of bugs.

Prevent creation of memslots over the maximum address, and prevent the
maximum address from being reduced below the end of existing memslots.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e09960c2e6ed..1796a7c645a9 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -999,7 +999,10 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 		break;
 	}
 	case KVM_S390_VM_MEM_LIMIT_SIZE: {
+		struct kvm_memslots *slots;
+		struct kvm_memory_slot *ms;
 		unsigned long new_limit;
+		int bkt;
 
 		if (kvm_is_ucontrol(kvm))
 			return -EINVAL;
@@ -1007,6 +1010,8 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 		if (get_user(new_limit, (u64 __user *)attr->addr))
 			return -EFAULT;
 
+		guard(mutex)(&kvm->lock);
+
 		if (kvm->arch.mem_limit != KVM_S390_NO_MEM_LIMIT &&
 		    new_limit > kvm->arch.mem_limit)
 			return -E2BIG;
@@ -1014,12 +1019,27 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 		if (!new_limit)
 			return -EINVAL;
 
-		ret = -EBUSY;
-		if (!kvm->created_vcpus)
+		if (kvm->created_vcpus)
+			return -EBUSY;
+
+		ret = 0;
+		scoped_guard(mutex, &kvm->slots_lock) {
+			slots = kvm_memslots(kvm);
+			if (slots && !kvm_memslots_empty(slots)) {
+				kvm_for_each_memslot(ms, bkt, slots) {
+					if (gpa_to_gfn(new_limit) < ms->base_gfn + ms->npages) {
+						ret = -EBUSY;
+						break;
+					}
+				}
+			}
+		}
+		if (!ret)
 			ret = gmap_set_limit(kvm->arch.gmap, gpa_to_gfn(new_limit));
+		if (ret)
+			break;
 		VM_EVENT(kvm, 3, "SET: max guest address: %lu", new_limit);
-		VM_EVENT(kvm, 3, "New guest asce: 0x%p",
-			 (void *)kvm->arch.gmap->asce.val);
+		VM_EVENT(kvm, 3, "New guest asce: 0x%p", (void *)kvm->arch.gmap->asce.val);
 		break;
 	}
 	default:
@@ -5672,6 +5692,8 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 			return -EINVAL;
 		if ((new->base_gfn + new->npages) * PAGE_SIZE > kvm->arch.mem_limit)
 			return -EINVAL;
+		if (!asce_contains_gfn(kvm->arch.gmap->asce, new->base_gfn + new->npages - 1))
+			return -EINVAL;
 	}
 
 	if (!kvm->arch.migration_mode)
-- 
2.54.0

