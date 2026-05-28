Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CFF3E3DAE;
	Thu, 28 May 2026 11:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968860; cv=none; b=T8smKVaz+XB0S8BIHZtkWV+ZVZBMAnaq6QoHy/uBAh6ojRVX27pq+ChKks1l9WCV2yrkRa9crJy7KhWdW66uDNQtIdLtkVim9Wic2A4DrP5vrxoSuTBI0Ufc2Doepoj12e7PzqeA8kxUpXEsHpoOFWrbVrytG18qq1S9B9V0sSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968860; c=relaxed/simple;
	bh=jQkL+k7zNOrxcSH8aNi+5vzg6LO442uG++zx38Ieiao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAqNWKTeTBDf4jqqFhvRh6ezdaTP3moaCbAyv/CfasEY5CyoB/J5gJ/dcnQVPCmEo/DwVgdptZP3DlAE69aEthiiG4ujyyL8WEHsVoO7zIKXaKTCCPRHsJACiosr5t/nQpt0mwgQn151Ftb0x+KgNpEPjkhNepwj5gyURePBixs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Pg/XInmb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Pg/XInmb"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RL71P33139627;
	Thu, 28 May 2026 11:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GBRUOdcCvq/qh6rrt
	GAm+QqjsOLS3ZOavNHovPdiMAU=; b=Pg/XInmbx2x1T207z19d8DLhxcKNXnUle
	sp7QwopmFuvpgnRG3+QVvMhfAfOxvfsq7KimiL8nv83Y0BWqsn0gEgotY7w/1r10
	A5UiOr2gfZDakK0kJsYa+AcRvoJP52ylsJxNlq/CzziqAMATI//nvOXopk140H47
	ehcr0yJAh96ybLc5WSx3w4G+ILwXsYYuCCzkAl2TbQtTohDCbPFeXGlQDJtHy3Ub
	4q3AvE8peyr2KSXDdjx6zWP/Dum50PRtbQtFy8VUw9Qu+2XwPMZGvB45EXJsBwYK
	n40klPI7i6YJeeQaBiE8GixoNmRX6ZxwA++vOsO7yjbuqfj2kb3Jg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee887jmuq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 11:47:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64SBOUrl025747;
	Thu, 28 May 2026 11:47:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrb7wcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 11:47:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64SBlUUN10813882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 11:47:30 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA59A20040;
	Thu, 28 May 2026 11:47:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC2E62004B;
	Thu, 28 May 2026 11:47:29 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 May 2026 11:47:29 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 7/7] KVM: s390: Prevent memslots outside the ASCE range
Date: Thu, 28 May 2026 13:47:27 +0200
Message-ID: <20260528114727.142178-8-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528114727.142178-1-imbrenda@linux.ibm.com>
References: <20260528114727.142178-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QLJYgALL c=1 sm=1 tr=0 ts=6a182b58 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=luRVYIaq7LDw4LXNCHgA:9
X-Proofpoint-GUID: q3_HyjhyF85ocYk2gIX7fwULMAmJERZR
X-Proofpoint-ORIG-GUID: q3_HyjhyF85ocYk2gIX7fwULMAmJERZR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDExNyBTYWx0ZWRfXynznqF7zW8m5
 PHCiX1QU2GYHhEvuFR6eR5gJYym9l696ZZIjiBf3p4lyAXBIbMwK3jFLRKtBLHHa+VYHTgsD222
 QkO8y6P96qMXtkxq137fU756TaWtIv2suEw7vag31F5Y16KrhgXsNshDuSHfrVlZjQswIs7LR7h
 2Zkhy+BU3NIXIclELpIhCoeaHH6p14hP1uG5/xBII8WanU3pPalbQEUpUQVv1hKYzqoQXogGZ3y
 NhUwksJCl0xtDtwuq8WVhvQ+S0YRQhk1NLn0dYzGZa0vu56JXjxRlMEFU7/jz+6skR074QyUzPx
 gWFBtP/mcbkae1tejy5dp8iIyDyyfMaUFSzTMWxGDVO7PLRURa6+nGJE7whGJWDYdyXa9d1Qb4V
 rTunCLW+nd1mHHJL3cv/QvFNG3lbW5pwCOZyWYxroBMK/GQEj+ZpQ8BzhTFXbNxNMW9xXhDmOvd
 6jyOce4FhizCyfxZzPQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280117

With KVM_S390_VM_MEM_LIMIT_SIZE, userspace can set the highest address
allowed for the VM. Creating a memslot that lies over the maximum
address does not make sense and is only a potential source of bugs.

Prevent creation of memslots over the maximum address, and prevent the
maximum address from being reduced below the end of existing memslots.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e09960c2e6ed..875f6e2a4a52 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1015,8 +1015,26 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 			return -EINVAL;
 
 		ret = -EBUSY;
-		if (!kvm->created_vcpus)
-			ret = gmap_set_limit(kvm->arch.gmap, gpa_to_gfn(new_limit));
+		if (!kvm->created_vcpus) {
+			struct kvm_memslots *slots;
+			struct kvm_memory_slot *ms;
+			int bkt;
+
+			ret = 0;
+			mutex_lock(&kvm->slots_arch_lock);
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
+			mutex_unlock(&kvm->slots_arch_lock);
+		}
 		VM_EVENT(kvm, 3, "SET: max guest address: %lu", new_limit);
 		VM_EVENT(kvm, 3, "New guest asce: 0x%p",
 			 (void *)kvm->arch.gmap->asce.val);
@@ -5672,6 +5690,8 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 			return -EINVAL;
 		if ((new->base_gfn + new->npages) * PAGE_SIZE > kvm->arch.mem_limit)
 			return -EINVAL;
+		if (!asce_contains_gfn(kvm->arch.gmap->asce, new->base_gfn + new->npages - 1))
+			return -EINVAL;
 	}
 
 	if (!kvm->arch.migration_mode)
-- 
2.54.0

