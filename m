Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADB4419FC5;
	Fri,  4 Sep 2026 06:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502022; cv=none; b=AobPMPnRKjKO5hHoMj88b/aUawjqyK3UDRaq4uWnF5KEytEwNBlmbVvIbmBb01NXj8dTcTZ7iiKwm4Pg0SW+bpBdBwq+lag2urVJyH7V5O+1yT9+wqTKKXMUBwTkpk8G3cjUy3e1bEQaYGOd5kOeCgaP1LMDgE7dkkH9xchVn0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502022; c=relaxed/simple;
	bh=XwvHfA7VUN0bQTZx0X1X1Olx/S+nYt7GupbeSUfy16I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBv5bhfosgZL/CcEZrQFw9ZNYfHV4+YtEcxgKcSOypQpS9eo3/ME7YxN95VFsjKtADYZpZ/LcJ+lCMDjnQtsUXJtGWqzdVcfL2oiwn6mXsr4MnmK+JDvl7JUFc4smH3ECQ1+T9Fnd7acL8R84JwBxamluGt4WHxD7RU0HqLQzpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=trDa1lxi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="trDa1lxi"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464R8A814632;
	Fri, 4 Sep 2026 06:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+wutx6dpIMX/hJMIZ
	JD/BA7Px4ZBqoWI7BFSFePcb6c=; b=trDa1lxi0UIIgKkcGS85/MSkqmbojmsZo
	DW9ehZ/INUpz0NPx466ogoThRbzreWpa3CxXZjP23dPh4NGEwYC+I4lyRVKHpOSB
	2Q7IJPwj3CQE6xqVsp3A0R70rPbvBuFvkUMBSrJF21Ytz/FQNiIRWerTalBAVGFK
	JZQoSltwcy2Zi2MdVAi3+4H0YHW+lRRD8s+Oym5eGmQdTkHBQMxu6Z5nmilaABP+
	uFsi1tObKZPZTMP8PZ71ZsstpwnT8iC1fVrbwofEGpdbxQoyqhRp4fcN2sKEnJkf
	VYLRJRxImFzQt3IMkfKOljINbH6RdF1AksVZvLuAc+d0CaEE3iDxA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuj8p6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:06:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6845uPT3023468;
	Fri, 4 Sep 2026 06:06:57 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbyguasb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:06:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68466pcS31261362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 06:06:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D3FE20040;
	Fri,  4 Sep 2026 06:06:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D86820049;
	Fri,  4 Sep 2026 06:06:51 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.53.213])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Sep 2026 06:06:51 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 06/11] KVM: s390: Add missing srcu in kvm_s390_set_irq_state()
Date: Fri,  4 Sep 2026 08:06:42 +0200
Message-ID: <20260904060647.562443-7-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904060647.562443-1-imbrenda@linux.ibm.com>
References: <20260904060647.562443-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Uug1lgDoi_42SwLnuRue7T4tv8Y8ZUq7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfX91qJP/MGjg+E
 Nomi2kTh8wHh+l0V+6luR3ViInbpvLWUbWqL3yb+8VT1f8KI16lZ3J2s2b3I04uVmX/hOPVYUBp
 FdJ0nd7H7M5+QzRGGaevLfEZF8CItHwcp8vodCZD0MJ5DetOXRa8vYs94EYE8DZvQqfwu0qv4V8
 n1iTx/tNxHHBAqZtJMmsS1WcBY0JkEE4G9LMk+J8xQqmdpJymYT4AhTBNvHiAgB/fbNUUKfNot4
 k1tJQyBCnbo/99miB1Rjjm7M7GI+RY124arHZ2PCul5KOThEHfZmOh/IV0S67L0UDPk4MPqGf0b
 sP4rGOVG4wy1FhYR5oWp4GJ6LpImaPu64CEe3KgaKm8BoTlm5FNqawtVDvtBS7ZK19fz9gluSoH
 obiaoDD8KMAVv7/Na4jfxWTols9UbfVj4BLIHwxylgB1+iG2G4zhdlpYYACuLCcAGvLxDw4Ansu
 wejucz1j0JKVb/H8OMg==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a9a6002 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=r57P7jcG1oT3p7VFzagA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfX9u2OvzExAy4a
 u+0/E4P2F/tj20jW37jJzSupLtp4KEd+uVqlP9fRDTToPQMFzmboY6LL053EF0xJoLmRa77r0Bo
 OfUufp/41AYxLveSIWJLjmublltaG7Q=
X-Proofpoint-ORIG-GUID: Uug1lgDoi_42SwLnuRue7T4tv8Y8ZUq7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040054

Like kvm_s390_inject_vcpu(), kvm_s390_set_irq_state() also needs the
kvm->srcu or the slots lock when performing the Store status operation.

Fix by taking kvm->srcu in kvm_s390_set_irq_state().

Fixes: ba5c1e9b6cee ("KVM: s390: interrupt subsystem, cpu timer, waitpsw")
Fixes: 062e44a9319f ("KVM: s390: Use srcu in kvm_arch_vcpu_unlocked_ioctl()")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260828115439.145885-7-imbrenda@linux.ibm.com>
---
 arch/s390/kvm/s390/interrupt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/s390/interrupt.c b/arch/s390/kvm/s390/interrupt.c
index 49b4e233e791..f892f4307883 100644
--- a/arch/s390/kvm/s390/interrupt.c
+++ b/arch/s390/kvm/s390/interrupt.c
@@ -3229,9 +3229,9 @@ int kvm_s390_set_irq_state(struct kvm_vcpu *vcpu, void __user *irqstate, int len
 				break;
 		}
 	}
-
 	if (storestatus) {
-		n = kvm_s390_store_status_unloaded(vcpu, KVM_S390_STORE_STATUS_NOADDR);
+		scoped_guard(srcu, &vcpu->kvm->srcu)
+			n = kvm_s390_store_status_unloaded(vcpu, KVM_S390_STORE_STATUS_NOADDR);
 		return r ? r : n;
 	}
 
-- 
2.55.0

