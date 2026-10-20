Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792519116;
	b=JIGCSCCr5INl41KzA3zentX4ToGys0jjhTb5L5J416tolYS+Jrdv3gMuEwzgXBmAjrBx
	 HzRKoNrf06zkC0idiWvAcWoBnoXUE5kllxGP7quxvYkVjAW1H+VAIofu8XydzA/KnpPtv
	 m3zeKO1gHmDVoAGGd9kErChdmKbDrYz0ufM0xQpvq3alAlRgo/pbd3DMV6b4bw+2bCPsl
	 KrJcoS7MvET06Zm6sznvo+omXndkM4II8e1BOk8bjCfBsY7ZpMFnIYSNrrp8C9jg+Jk1T
	 /vuJ/Be6rwOIM4Jwzu3LBw7FsBlRsNBIUKss6mrOaQw4n9enqMs52XZ7NmN0eiUQZuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519116;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=S3s68/HuKwsBIiN2yZnDPSoI7/U59PXN9rAQBRBqcho=;
	b=ttNko7JVu26EIgw5AN3Fgy0r0F9E9o32exJEBVmhf9JR+IMJQ+mJEsU6MGJJpaKe7dik
	 gcrtv0a3Y/g03q2ywXqPKoSzWqR9WEQgcw/4K5Do9yhkMQiSEtB985gXG3MILqFXYA8uo
	 axxaqAq/pKqh4HXoxPRI1lF2umeM1oLAuJAQOd5wK+v9DMRO9Xcu26XI9IOsmGHtRFP4I
	 fYSBZHhKIdVMX8cYCo9vXi0yvfwZ+f4WIRpyf+JPuZFikq815iv6Y2TndAcqi+jYbW3Yf
	 oo/VigpvlnZM9h8wbjKX7GAjJBofIzqy9LhU/pGymF/vCgO/t5jMzknXHB/IulqQ9oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jl7RTXa8;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049A4606A319;
	Tue, 20 Oct 2026 17:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 049A4606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jl7RTXa8
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KHEAfU3063223;
	Tue, 20 Oct 2026 17:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=S3s68/HuKwsBIiN2y
	ZnDPSoI7/U59PXN9rAQBRBqcho=; b=jl7RTXa8jVTwBWkWgKLrMq9fLLmPT9gbe
	3SQnGt3nTyljwqRlw1Y5XZ6Vz1sRSCPjxK6PqYbZbittfohd6mUs520nctrvaqyH
	WHsBWLaARXxC08qZloa/oxwbg9lKxYUAXpzu1DccOevEEzU8azZhdeM9AZEAZpjB
	uAdCaYQOnUWh2EO4uD6jOyotg+iM/9bQFd4m+X5b+M16WEJa52sKJxH+q0R4HcFJ
	tFz6wuoACtIRjcq6IvC+FJQGWTNNoG+eAQIZEI51HXEQp0OqWPe3oHWGlfFDxekW
	lVrjWIj1J94N7r9BXZXE5zqScX5CYEk55ue/yqXZVToJmNnL0cPSA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5a4htj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 17:58:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69KH4oEw1836464;
	Tue, 20 Oct 2026 17:58:24 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4he8vhs479-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 17:58:24 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69KHwNj650856340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Oct 2026 17:58:23 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42A8F58054;
	Tue, 20 Oct 2026 17:58:23 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 937385805A;
	Tue, 20 Oct 2026 17:58:21 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Oct 2026 17:58:21 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc: KVM <kvm@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: [PATCH v2 1/2] KVM: Set up async page faults only for faults that need to wait
Date: Tue, 20 Oct 2026 19:58:17 +0200
Message-ID: <20261020175818.375700-2-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020175818.375700-1-borntraeger@linux.ibm.com>
References: <20261020175818.375700-1-borntraeger@linux.ibm.com>
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3MCBTYWx0ZWRfXzV9/ly0SYw1i
 6v2P4Dh6nO9ygeijdIVEhBB8QpCbb2zPIzx1mGABIrJJts7RcRW5DnqJV/V0r1ebcikBeIQZtT0
 bxVw8cHjzXJtxsALkfnh71Vg6htDB1Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3MCBTYWx0ZWRfX+bWHzzB7kXxw
 GtzrnB3aXo5/kn8a/ztIFxo2ZpKrfsUQDQXeUEOCdbFboZYOqYB3PS/2aRJ4tVCmW6IufTLex5b
 sQZrcEhHisuviEe3auZcqnaQdbBXM03lQNCYeoBuK9nPAqOJOKxn0X2+V6/YqzGi5H98YcpHXAN
 r+WfI4TM2Q1MkYPCBj8uvr9s50Zj1mEo8wuv54rs1mBui+InVoZr+JOTtkKE27gUnr7MClY6FHF
 iS8E6BffzPr4qGcu7O8eHRXqan8vBLQIsAh9O6db4mp7zVR0rol2/P4MUtIHCfmMV8SVv7m6h6j
 ShdT6R5SWCiLkI9DAOOr26O0Uf25R2Ym1Cn4dmhIx1xDG7KkGxylU+fWo97LeOY7gdHE7sVmppU
 bAWF65HwR6BqBMeC+v95D0wSHgmJJtgab5YItrzS4fesP7Sn3Eea/ElyXFv9E5T4ax47GufOdEX
 2YnvASu1+EltGPUToTQ==
X-Proofpoint-GUID: NwBRdd5XS66tUQf5osIxtN90FvZtenQj
X-Authority-Analysis: v=2.4 cv=JIKuIMKb c=1 sm=1 tr=0 ts=6ad7abc1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2XfxGlgA2qNMPojl:21 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=XG9Rsx7q7O2Eji3_kFcA:9
X-Proofpoint-ORIG-GUID: fyfjvdF7YRFD7zhDK42dc_t4E0fT4cBg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200070

hva_to_pfn() checks a FOLL_NOWAIT gup() for EINTR, EAGAIN and EHWPOISON.
There might be others like -EFAULT for VM_FAULT_SIGBUS.  For those other
errors, reporting KVM_PFN_ERR_NEEDS_IO would be wrong as it triggers an
async_pf resulting in endless retries.

Return KVM_PFN_ERR_NEEDS_IO only if gup() returned 0 pages and report
the error otherwise.

Fixes: 0857b9e95c1a ("KVM: Enable async page fault processing")
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 virt/kvm/kvm_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 5a782849521c..7b6172810f34 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3047,7 +3047,8 @@ kvm_pfn_t hva_to_pfn(struct kvm_follow_pfn *kfp)
 		if (r < 0)
 			pfn = KVM_PFN_ERR_FAULT;
 	} else {
-		if ((kfp->flags & FOLL_NOWAIT) &&
+		/* Note, GUP returns '0' if retry is needed. */
+		if (!npages && (kfp->flags & FOLL_NOWAIT) &&
 		    vma_is_valid(vma, kfp->flags & FOLL_WRITE))
 			pfn = KVM_PFN_ERR_NEEDS_IO;
 		else
-- 
2.53.0

