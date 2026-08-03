Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC0F36EA8D;
	Mon,  3 Aug 2026 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773379; cv=none; b=I5PU0Vs592RPMFGcQivNk+qmf09CD2MFTeFaQIi0yCgRnxI8FgUCxuVmzqL8em/1mGvTJOE1KKZAo0gxwyNX5kEtQINXvQVDAUqL4jF8EwuaInflQGE3in2lbJlSOrIGGnI6DMdqqtNYfwWpnpdfMnp40myh/DtJJOUgRQvIIOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773379; c=relaxed/simple;
	bh=SJbISYsjYhjVjjco3VLZjK2HoHJp38bchU7RaJ2bcWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8MA2PX8FxnPqHnZZvQe1Ty9r5YsyfLjL2nxfy/K1ZVw87FnETExPQgr/NScbeYjpJBgCLw+5fQyr5QqS6EG2WID5bl6pS/o0qHt3BzRgw6LV5SSLtoL45QrIw37FXko/IJca0xQFnKgThhjbVGli1ZY/42uvqlkiky1+A11krM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Cdh2yQ4T; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Cdh2yQ4T"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EHpLw2202026;
	Mon, 3 Aug 2026 16:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Fxk7xgwJjtSThev6L
	e7anaFIYR1Q1qDEDCiF7sxWRas=; b=Cdh2yQ4TBmd98/njOlnbnUf3xSPjrL3KP
	lHdLbTAOENBvUgeLIUr70wkzMRXahHbKsYq5LCz5Iutd7MpKXLvS56ueVhhUXaiP
	af1/m9cuoKfo8kmb4gio7Z2JCiUMqs7+7kuB8Aaz0kQRx39LX5kNjwZDT8XOVscT
	3GxhuX7aD5NiK34RslxrTnhTqj4XXP/PKYOMEzv16T0hlxz4wNrzvUYaeY/XepgR
	gleIPtqY/f/+MuQiISRrGqFmB9CPl7H/35qh92Mf/cFJ6b9QG40r8PAY1u2fK0kS
	JdysSCNTMBp76HvXfOAJ/TsOiFU68kKA0BL7urWbUlCm2gBUBXhQA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hhnq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:09:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673FuMMN001231;
	Mon, 3 Aug 2026 16:09:34 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugvx8kw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:09:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673G9Rha45941128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 16:09:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD3B520043;
	Mon,  3 Aug 2026 16:09:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 910862004D;
	Mon,  3 Aug 2026 16:09:27 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 16:09:27 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 21/23] KVM: s390: Return -EINTR if a signal is pending while faulting-in
Date: Mon,  3 Aug 2026 18:09:22 +0200
Message-ID: <20260803160924.236807-22-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803160924.236807-1-imbrenda@linux.ibm.com>
References: <20260803160924.236807-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfXz/VyQagMcLJ3
 l9ExRJCOTWzWF9QXaZzM38n/3GVEwL184pzJt2PvBIfTFpTNp7mXy1BarUeOm21rmHhrKyCd401
 TC+ye4MB6oD6NflQwMbC8yOKS0OUwlo=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a70bd3e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=4yawSYOjwzvXb9KGJXwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfXy6BT+YGRhIFW
 zHqnRT+BEuhvRWa8cCKgB/R9R1aRgpwluJpbDqgdhDww12IuPA87ifuyvBN5hgiujP0GpPKxSVz
 XP7wxIzUKkI6NhCfJ3powF/x8YyWNXZ3XYOTa5wt+fvcUoNCI/6SQDeRuTiCO0kxRlkr9PNtRVy
 ncvmeVS5ye/rOMPgsOLTkRI42zH+zdCVoDAYS+jcFMeF5gWDSE+PqqXN9BflXFMyISDkFWc/3fL
 fJC/Z5jFOde0MTyjVdfie5ThxbHAduUB2pP1R3WV7SfXRXcR4e1Q7VyJ8DHSJ5oP1H1htX54KlQ
 J6hxZ8EhssLRu2zp1BTe5kAIEMiFGUhFjWWi+P2MXM5CP5s5vyNdKuvf+uCiXPm0MZTjNNOmM/j
 sYpAo+Ms/C4HQsCaxExjdazmymR71GYsINnbF+vxsyr6zpBJr60RFR+2i7lXeLJ7J/ZX5eXePa5
 QeKMEQSMY7NRai2UEoQ==
X-Proofpoint-ORIG-GUID: bbJQ5Srjs457ZmgDHWegBCkbnUfcuSbk
X-Proofpoint-GUID: bbJQ5Srjs457ZmgDHWegBCkbnUfcuSbk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030141

If a fatal signal is pending while trying to fault-in a page, return
-EINTR instead of -EAGAIN.

Also fix unpack_one() to handle -EINTR properly.

Fixes: e907ae530133 ("KVM: s390: Add helper functions for fault handling")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260803124040.126471-12-imbrenda@linux.ibm.com>
---
 arch/s390/kvm/faultin.c | 6 +++---
 arch/s390/kvm/pv.c      | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/faultin.c b/arch/s390/kvm/faultin.c
index fee80047bd94..3cc45f7f5b2d 100644
--- a/arch/s390/kvm/faultin.c
+++ b/arch/s390/kvm/faultin.c
@@ -91,9 +91,9 @@ int kvm_s390_faultin_gfn(struct kvm_vcpu *vcpu, struct kvm *kvm, struct guest_fa
 		/* Access outside memory, addressing exception. */
 		if (is_noslot_pfn(f->pfn))
 			return PGM_ADDRESSING;
-		/* Signal pending: try again. */
-		if (f->pfn == KVM_PFN_ERR_SIGPENDING)
-			return -EAGAIN;
+		/* Fatal signal pending: bail out. */
+		if (is_sigpending_pfn(f->pfn))
+			return -EINTR;
 		/* Check if it's read-only memory; don't try to actually handle that case. */
 		if (f->pfn == KVM_PFN_ERR_RO_FAULT)
 			return -EOPNOTSUPP;
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

