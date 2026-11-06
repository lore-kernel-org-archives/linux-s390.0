Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793983816;
	b=ie5AsAGavW2aL03Nv+SNgcC8pJCi1uE4O4dI7DhBa4uBVblUPbTlw6G0nPRm9valiyok
	 Zu6jzrWusBPpCiFjgIMlspcnjyDhEnC0ya1JKVhL5jjseMD2z0Qa4J1fsi19pypXCtyRF
	 WdJ24KP6ALjRG5Iroi0HWXSHFvriBXtvnwQZ3GTp8iiW3cc83SQGuHP/+ZOyGlx+92hgT
	 xetiI1jmKT301Q07pRQlBg/yUezyRAs+lnS0LfAXBrkHXLmdQenyvP6qYcgQYMZPfPpyv
	 snpvO0wnrdwZRGFppozl863iuI6EI7YInFSdFCjGy0Ntr4lIUvP79RgYTRhuxW/sTRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983816;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=gvwAesyibltb58QjTUBJhLVL56XUqlkhJBEIlWNhHG0=;
	b=syKw4gGoddUfo2Fgx2IHNVe7bnDC8lMf6thcFC+KrteoCPa78hmM6tmRR9yV7hjlhqiI
	 3AFN5RvoVM5jD5kLBJ9TfhuM21TJxl1yk6oAatXYukloeN0PupKKSMUL7NIYTCrIiVALl
	 fsjjueiw9aJGAGA8rXzSiIlygfcsvKT6aIYhLeXbUv+dB1ZMecxZLOhAiRU5jqPywlmSW
	 PU69c7QZxajUC5luc4qgFFkYyPc5vRylhtI4S28GjrIRFWPVlgcqxSz7AsXXc4PMcoSt9
	 uxAGgXnuaKUTzZV42+MAkWFjjNFGwjW+GPVO5MQ/o/fpb8QR929DqARJWnqU5S2wdsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=f1kIkAWS;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449A6606A331;
	Fri,  6 Nov 2026 16:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 449A6606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=f1kIkAWS
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FEEV22936024;
	Fri, 6 Nov 2026 16:50:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gvwAesyibltb58QjT
	UBJhLVL56XUqlkhJBEIlWNhHG0=; b=f1kIkAWS2imWQvV1AGr6vpMVik06l5oUF
	OZlNFvE4SUQhCOlqwCX57+SQl7G8+YTwyy16ExjViwofi11cu555u0RHvJxbUU/P
	1xtWsvzBEGhx5Qs1smW5GLa9tANe5lugH3g6wd2M8LAelQLiEycah2ugBXsU+kQa
	TRs00At7t3KjGkQ1CY5cylRZzQAaFUyLyyG2CQ9aoDvbfbGd/nLYGiDDXSgBTldo
	xOuaJlkiwi+rB7A8Iv0OY8wtMrsGsbZyifhUPzTyq3/gHIS/YokIvmNNPhR3gjTI
	FApwNB/u6wSXydoOhirO1IjfrVMhpii/2hmpRTjBzXDSgno341dVw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rcdy7y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:50:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4tS32390103;
	Fri, 6 Nov 2026 16:50:12 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hs7h149vy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:50:12 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6GnLbw27263662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 16:49:21 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E3075805C;
	Fri,  6 Nov 2026 16:50:10 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAA645805A;
	Fri,  6 Nov 2026 16:50:07 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 16:50:07 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Steffen Eiden <seiden@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>, Marc Zyngier <maz@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [GIT PULL 3/6] KVM: s390: arm64: Turn vcpu->arch.pause into a counter
Date: Fri,  6 Nov 2026 17:49:55 +0100
Message-ID: <20261106164958.431978-4-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106164958.431978-1-borntraeger@linux.ibm.com>
References: <20261106164958.431978-1-borntraeger@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: QV6XP1_WQY7mNAMYtrwW9fT5__I7MRII
X-Authority-Analysis: v=2.4 cv=A635rKWG c=1 sm=1 tr=0 ts=6aee0544 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=3n9Dgo04BRxGV_azSxAA:9
X-Proofpoint-GUID: QV6XP1_WQY7mNAMYtrwW9fT5__I7MRII
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2NiBTYWx0ZWRfXw9HjwOAkSkPs
 00phZEETldE2MXu1ouD2YS7/vT+Bv3OexR6H58dcj9OzVTXZEm9qFx8JzCBEQwUgARtLMb2jGPC
 K8Ck+rY53RD0MmttfVQVu327CArb4V43dNfW7MXL1UrdN9SLr9h0f8qCdMMoHfLf3GDNv0w4zca
 80Kx6jiLq8qj61DBx3myjlwN6+WwPQgaE3B39Acyecf88u7d8RnqzcJPCYd1d5vXExKAv4zMDUu
 9hEHa/R3eK06C0S2Uhn/VXBfM2sInWNP++475Mfn7qjxR8VUyXpdkpU1V4MKDA2pWaFgYrH6SVu
 ogDycnAue7r/VfkFt8bBX/OqMkF8KnLkRCj22vNZYyakaW9VeHx8OIFn+OA88QjQ2kZx0YFNbyN
 llxgm1qOLk4HopAg4PTOTGG6W1k793HewajB0EQzf34WbfWaMIS63SGG5tZ8x2bQnbb5VJINDtb
 rxKBgxQSW8MbQGok2wQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2NiBTYWx0ZWRfX+EVfAly4B5z3
 ny1EwvIa1CUPTD73qGHEPPxlurCTTLf4L19B8hpXvGFKzCHCzCasFnOrjNe9iCsPnoGSDen+efw
 A9vJmgIfykEIJToAo/wh9ryG16+Est4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060066

From: Steffen Eiden <seiden@linux.ibm.com>

The s390 arm64 vcpu struct mirrors arm64's kvm_vcpu_arch. When commit
e64309198eda2 ("KVM: arm64: Turn vcpu->arch.pause into a counter")
changed the type of kvm_vcpu_arch.pause from bool to atomic_t, the merge
into this tree missed the s390 copy, leaving it out of sync.

Nothing on the s390 side accesses vcpu->arch.pause yet, so this has
no functional effect. Align the type to keep the mirror identical to
its arm64 counterpart.

Fixes: e6c329180d1d ("KVM: s390: arm64: Introduce host definitions")
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Reviewed-by: Andreas Grapentin <gra@linux.ibm.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_arm64.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host_arm64.h b/arch/s390/include/asm/kvm_host_arm64.h
index 82343e723ebf4..a3e40650d75d0 100644
--- a/arch/s390/include/asm/kvm_host_arm64.h
+++ b/arch/s390/include/asm/kvm_host_arm64.h
@@ -63,11 +63,10 @@ struct kvm_vcpu_arch {
 	/*
 	 * Don't run the guest (internal implementation need).
 	 *
-	 * Contrary to the flags above, this is set/cleared outside of
-	 * a vcpu context, and thus cannot be mixed with the flags
-	 * themselves (or the flag accesses need to be made atomic).
+	 * Contrary to the flags above, this is updated outside of
+	 * a vcpu context, and thus cannot be mixed with the flags.
 	 */
-	bool pause;
+	atomic_t pause;
 
 	/* vcpu power state */
 	struct kvm_mp_state mp_state;
-- 
2.53.0

