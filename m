Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27DC3FC5C8;
	Tue,  2 Jun 2026 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422511; cv=none; b=HkPNKqAXaCofCfrE/BuSJX4acO1LweWLPAzYkxEE6vquY7eUCneXvrGqONQ5mIjNk3OClCwyj21/5W4lhbnDmjTjh/GEoeiH91UdtqvRycE2RykGZz8poRfcvlSrUrFzcp/2SHYYWFfh/Y7LIuSBUUN9eplVC3C9SfB4vs56UBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422511; c=relaxed/simple;
	bh=+caHEPkocHglJ/6Qs3dMJc7wqHb3W4gjWRSf5kUuSQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJQnGJXVIrORrcw/yKIpNoluSGAlj8uNMvzLJxS0nArE7vC7L/aq0EDnckG8gsPFoOE3lBkMGkuYh1EI5bEYkbJH/6ECL9QgMMxSLPUa877Hkvyz5YhSiD5SR+7WCxmEgPo69LxmJzT3iIA8LvN/7FA3RtqL+lrV7gLWUo8EisI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aPPpHJG2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aPPpHJG2"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6528S64Z2708324;
	Tue, 2 Jun 2026 17:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=X/XZQ455iHlb+KxAV
	hLpzVf8kpN82k4w0kdjRhq8rS8=; b=aPPpHJG2Pb+8m8pIWj/jx9Yns1iSpkOiJ
	KdybFjoDs31zucSNGQScmN0ac+RsBMrcTbURazD26xm109dedEj4BT4VPzxqeRE8
	ReCKvJqGEU8t4u07XgnjygY4wRXEHgISuNybRDtGwrx0TVaGpUKTZt3Nzr6bMiUG
	CYmyXbfHP1mHUHpn5eoZbM85dUCvF4T6gnpksy4qg7GZfBwRS0h8xtrQ+KMtpAyD
	HQ3aXbunwESNM3vhHLjL6oLCK6DspbKdynnKP/v/v7uWwOu2mXEegQnijiExOePb
	3+4TZ5Pb4V/Q1ZApXq3dgUdxcLA+JptOJP0LlzfWDJlCjf6GRLV2A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahpyug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 17:48:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652HdQtH027932;
	Tue, 2 Jun 2026 17:48:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7k4ek3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 17:48:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652HmK7r48955662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 17:48:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C53F2004D;
	Tue,  2 Jun 2026 17:48:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 601D42004E;
	Tue,  2 Jun 2026 17:48:20 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 17:48:20 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 08/10] KVM: s390: Prevent memslots outside the ASCE range
Date: Tue,  2 Jun 2026 19:48:17 +0200
Message-ID: <20260602174819.255785-9-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602174819.255785-1-imbrenda@linux.ibm.com>
References: <20260602174819.255785-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE3MCBTYWx0ZWRfX3ltIbtwGDXu8
 N7SOwJUymkX6crz3mFrrEr8zHTzxxMfUw7GPulDAIw9u803xhOYQHYjA6tq4VU3n0R8e+00IKe2
 1aiIfheq1RYWEyr3VxZrX7NN6TG8JApvBD+WatQDbSDyNsrvsBJWYDnq9E8lNnE0v8hQ1stXXoe
 q1HGlsiJ8mDPlrZBYhBb2apZAP9/uprlkiGw/vrBaJcDKRYlLr1K4bpT7YhKjyRN6GQmPAldfsc
 K3C/u6C9a3ZeZnmhqrgMSlxjASJyMMs5H8oZkSTikrlrC+hKzJTpXDkyUkor+0ZK6iA7indvD+F
 k62udydGTZmD4Jz0WZL+d8AhOV6bEApLVsbbCiJaiMQt2C4dIMif9EJOTwI1BtnKwLqEGbNhXOb
 HFuPPN+2XAiWfR8YbN4hhZ/EoQmOVqOt0pgqu8SWQPnDgcyfyiDMRL0tG8F59PTgCr0btaO/Ov1
 8Dok2QFaJMyb+4NAhGw==
X-Proofpoint-ORIG-GUID: yntBcTSgFkRsQkQ4k2Oo9x1iL498-k8m
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a1f176a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=1rJwsmJvMo9JdAIlmdgA:9
X-Proofpoint-GUID: yntBcTSgFkRsQkQ4k2Oo9x1iL498-k8m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020170

With KVM_S390_VM_MEM_LIMIT_SIZE, userspace can set the highest address
allowed for the VM. Creating a memslot that lies over the maximum
address does not make sense and is only a potential source of bugs.

Prevent creation of memslots over the maximum address, and prevent the
maximum address from being reduced below the end of existing memslots.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260602142356.169458-9-imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e09960c2e6ed..ffb20a64d328 100644
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
@@ -1007,6 +1010,9 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 		if (get_user(new_limit, (u64 __user *)attr->addr))
 			return -EFAULT;
 
+		guard(mutex)(&kvm->lock);
+
+		new_limit = ALIGN(new_limit, HPAGE_SIZE);
 		if (kvm->arch.mem_limit != KVM_S390_NO_MEM_LIMIT &&
 		    new_limit > kvm->arch.mem_limit)
 			return -E2BIG;
@@ -1014,12 +1020,27 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 		if (!new_limit)
 			return -EINVAL;
 
-		ret = -EBUSY;
-		if (!kvm->created_vcpus)
-			ret = gmap_set_limit(kvm->arch.gmap, gpa_to_gfn(new_limit));
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
+			if (!ret)
+				ret = gmap_set_limit(kvm->arch.gmap, gpa_to_gfn(new_limit));
+		}
+		if (ret)
+			break;
 		VM_EVENT(kvm, 3, "SET: max guest address: %lu", new_limit);
-		VM_EVENT(kvm, 3, "New guest asce: 0x%p",
-			 (void *)kvm->arch.gmap->asce.val);
+		VM_EVENT(kvm, 3, "New guest asce: 0x%p", (void *)kvm->arch.gmap->asce.val);
 		break;
 	}
 	default:
@@ -5672,6 +5693,8 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 			return -EINVAL;
 		if ((new->base_gfn + new->npages) * PAGE_SIZE > kvm->arch.mem_limit)
 			return -EINVAL;
+		if (!asce_contains_gfn(kvm->arch.gmap->asce, new->base_gfn + new->npages - 1))
+			return -EINVAL;
 	}
 
 	if (!kvm->arch.migration_mode)
-- 
2.54.0

