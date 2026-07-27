Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B023541E6AE;
	Mon, 27 Jul 2026 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164596; cv=none; b=SJQvs9rS1QCeWROkT0Qjn0u3BrF4AtthtCmPPIBB/fk30JoxslloQfnMYwioe3FUN/vNoTDxji98Uyz1KrU3Zn4vmv5QUEzh5G2ed0lT3OObBMPsh6+hJdEfi9KcqCan8VwGodiT5zVfU6IZu35QcnMWiQ+psJsOenyFPkDNEeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164596; c=relaxed/simple;
	bh=s6C0oVeO/iWWPtmg9pfsmqRMsSpMZ+diZGK5X11eIGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dev5dVNkxKNBOz19FO7g7loEgT3ApcbcXoSfxSyWYM8Vlo7mdAUrjJ7TejgrG5L9GZelbBMjGWGqwSx//LWm0nPznjLpe6jh00Dy+VtaI8/p8olVHuxZMlAIY9Ykc97xR9EOzssqPEHp06sHdKdmTUKwg+FD8bGV9ULyLTRIxY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cXPHUSQB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cXPHUSQB"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDngrg2412707;
	Mon, 27 Jul 2026 15:03:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wNAsJFLq7yGP8Rpd/
	cRHq3oeNKp/jDM2m29ZD0tlrWk=; b=cXPHUSQBu6l6AjgcAn3HyQFDzKwqEGuMJ
	99m6TTbrWBrhHe+bLJhkA7BdXoTLQo35RpAcJuJ+QOlYoBW8MBX6ZvPBhZyYy0wc
	73z32UlF5Gmq34fuIiG6z0XBCyjbJ+LdQdqT4mB+/vSGwQYrNaUsXxOyceD86fj0
	iETPpxviSVkkdz/X8O7N95ayL6Wr3v02l5Fx29I/z6482F9Ref938nR3A+Tuohl8
	2n/ac81t4h8d9aDpUe7tjRUv7/Pvu4o6ILfoX7tFlpeqASYy1XvMwZsVWxljhMk9
	J5BB6mNWdCMA/jgCftq8DRricxOBhwbQfOcunpdIHBJlslukPGxNA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcr7hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 15:03:09 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66REuIE4006055;
	Mon, 27 Jul 2026 15:03:09 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uvwy2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 15:03:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RF32iT48103800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 15:03:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC300200F7;
	Mon, 27 Jul 2026 15:03:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A3D2200F4;
	Mon, 27 Jul 2026 15:03:02 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.1.146])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 15:03:02 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v3 07/10] KVM: s390: Return -EINTR if a signal was pending while faulting-in
Date: Mon, 27 Jul 2026 17:02:51 +0200
Message-ID: <20260727150254.236021-8-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727150254.236021-1-imbrenda@linux.ibm.com>
References: <20260727150254.236021-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: szt-W5QBY_nYALFaIWvaSdaXXbX10eGu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0MCBTYWx0ZWRfX588Y56JY6Xxw
 H2HpTP5bc2shX7E/NErKQFHo6KLJE6RBj1SrKG24z71NL8LT2e7zGi6DsBEuXmywKU7QwztLjzb
 aW7AJ+GS9Kse39vH3fRSMdy7svRibZY=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a67732d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=1lskR2YYmtwVP6KDAywA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0MCBTYWx0ZWRfX0kXJlSbgPyJD
 xkuSGuRDxzW6k7I7bu1y+EM6GW1PMcvE1dE6L4diSC3OXlBYeALv9j1JGLvr+8+C9ntJEc+Hw8q
 xeAhrOTKN8+r+9IQkpWoGpSq5HX3VtDNCWuYxKlyxYzwMUvpVAJPH8wNJs31nP6N8Jk0pFzf9a9
 3sL3+UU9i6X/R7jmPnZgt/0qJ4dk5izkKoYxtYrBy5peEww72HJtKROKPhMDga0O+uJDy/YpfZY
 aXzxaLGULtjpsofQuC93wj0cfYQmpfHZ9QcKPCW1kJ4+XWuLuVL2HzSzOotLQegg2vwRYUc+I6Y
 +1ahoGJ6azaG7zHdckHK9tJTYlbvOEvwFr970yeq/5mm9AiR9McVyX99jOxgSe4nWyXUv/ll3nK
 8q5koLZ1vh3KWNqZgVhRiPrYejg5ItwCTkkOohWcHD91iKd9C3dL9H4UJ/e8UmA8IPYsDSNds8f
 tOuVh9ykZLg2XAXpnrw==
X-Proofpoint-GUID: szt-W5QBY_nYALFaIWvaSdaXXbX10eGu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270140

If a signal is pending while trying to fault-in a page, return -EINTR
instead of -EAGAIN.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: e907ae530133 ("KVM: s390: Add helper functions for fault handling")
---
 arch/s390/kvm/faultin.c   |  4 ++--
 arch/s390/kvm/intercept.c | 18 ++++++++----------
 arch/s390/kvm/pv.c        |  2 +-
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/s390/kvm/faultin.c b/arch/s390/kvm/faultin.c
index fee80047bd94..4ff4c5970956 100644
--- a/arch/s390/kvm/faultin.c
+++ b/arch/s390/kvm/faultin.c
@@ -92,8 +92,8 @@ int kvm_s390_faultin_gfn(struct kvm_vcpu *vcpu, struct kvm *kvm, struct guest_fa
 		if (is_noslot_pfn(f->pfn))
 			return PGM_ADDRESSING;
 		/* Signal pending: try again. */
-		if (f->pfn == KVM_PFN_ERR_SIGPENDING)
-			return -EAGAIN;
+		if (is_sigpending_pfn(f->pfn))
+			return -EINTR;
 		/* Check if it's read-only memory; don't try to actually handle that case. */
 		if (f->pfn == KVM_PFN_ERR_RO_FAULT)
 			return -EOPNOTSUPP;
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 1980df61ef30..08f2128db147 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -369,27 +369,25 @@ static int handle_mvpg_pei(struct kvm_vcpu *vcpu)
 	if (rc)
 		return kvm_s390_inject_prog_cond(vcpu, rc);
 
-	do {
-		rc = kvm_s390_faultin_gfn_simple(vcpu, NULL, gpa_to_gfn(srcaddr), false);
-	} while (rc == -EAGAIN);
-	if (rc)
-		return rc;
-
-	/* Ensure that the source is paged-in, no actual access -> no key checking */
+	/* Ensure that the destination is paged-in, no actual access -> no key checking */
 	rc = guest_translate_address_with_key(vcpu, vcpu->run->s.regs.gprs[reg1],
 					      reg1, &dstaddr, GACC_STORE, 0);
 	if (rc)
 		return kvm_s390_inject_prog_cond(vcpu, rc);
 
+	kvm_s390_retry_instr(vcpu);
+
 	do {
-		rc = kvm_s390_faultin_gfn_simple(vcpu, NULL, gpa_to_gfn(dstaddr), true);
+		rc = kvm_s390_faultin_gfn_simple(vcpu, NULL, gpa_to_gfn(srcaddr), false);
 	} while (rc == -EAGAIN);
 	if (rc)
 		return rc;
 
-	kvm_s390_retry_instr(vcpu);
+	do {
+		rc = kvm_s390_faultin_gfn_simple(vcpu, NULL, gpa_to_gfn(dstaddr), true);
+	} while (rc == -EAGAIN);
 
-	return 0;
+	return rc;
 }
 
 static int handle_partial_execution(struct kvm_vcpu *vcpu)
diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
index 1beacc841ca8..dc204b521052 100644
--- a/arch/s390/kvm/pv.c
+++ b/arch/s390/kvm/pv.c
@@ -809,7 +809,7 @@ static int unpack_one(struct kvm *kvm, unsigned long addr, u64 tweak,
 			return -EAGAIN;
 	}
 
-	if (ret && ret != -EAGAIN)
+	if (ret && ret != -EAGAIN && ret != -EINTR)
 		KVM_UV_EVENT(kvm, 3, "PROTVIRT VM UNPACK: failed addr %llx with rc %x rrc %x",
 			     uvcb.gaddr, *rc, *rrc);
 	return ret;
-- 
2.55.0

