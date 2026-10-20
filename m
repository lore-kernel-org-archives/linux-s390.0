Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792506799;
	b=Q2RAetsPBnF+DlvbnwjAB1bl6bwmnupC4GYEH3LquHE8cLZYn8RihsirNitX/dxstoay
	 sTiIt8gzv962xhAyIqAW57wRt4bs1RJyA6J73YVFWOGLJqIgU+YmKSEbT/RXZK4SA2PO8
	 KYMdDHHIDIr5iCazWzVNVQ6vVLz5wonJPE6INoHBfGF0KgrEjQScjh9GtxoYpObdQ7PAM
	 rCHiTdXUJ2gK27mSorrVJP0oPIZI0HTzdmm8uPMgGoZ2pJRQICVZhF7Kz9sbL7+rwGjbk
	 O3G8eprDeTqAfyMPbU9qtxQV49Pdk/Ki01sJABYvjLYsawbO1B3M9OlZaOVhpCytZIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792506799;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=YmDZMO5e+0pNU7Q50UoTGVHdGqoRMMsJYF5VbvD22Ak=;
	b=bEgDKhTCB4KSIrilyMxXCDubt5RelAl8WQzk4wh83Bph0XkW0FAPFtf00RjNxMsoEGSi
	 sFOB1L+ZhEantl40xhPmKEpThYFmc/842AoeLfvRIT0tFtTbP7R8LTdKoWFSqv6vSrD2s
	 VOcK1vT1BXiFqtE9Kv2V8HuEtvE0eerEyrPnO08vyDrlwOVI3nAT+fg1msorZ1mtuwxMs
	 KKxkmtznYUtFQ7wwdN85LXL5ZYcXg3f8+TuvcA0nQakqCTFJm2Iros4Pt0Z4XPV46kFMH
	 ZJCCmS66yLxtfOmP/o1cGHSFd1HlEKf8ZVQgGjz90Xye+ne9UJf2VCnAg5RkDX+4qjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oLtbMqno;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FB9606A31E;
	Tue, 20 Oct 2026 14:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16FB9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oLtbMqno
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KDEYuP2567886;
	Tue, 20 Oct 2026 14:33:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YmDZMO5e+0pNU7Q50
	UoTGVHdGqoRMMsJYF5VbvD22Ak=; b=oLtbMqnoJHtghr1MHHIigWe39+xmMFAmx
	JgJMt/Zc9oKxtQW1VGui//QqmEAxZ8oUXIBU+dMM8cpa/m+UIW+ylLDIHIDWD2Wi
	lxDValElj5qSu1XA0R/sLqp7QqYYheaoZIur+XLzmD5IwAmFDYvPR+y0T6a+UE+L
	7+y6cB1KYYoZ7RqCgKF/XwoUSjUvL5e7pxDEn06XrYXbHzRGQ7RXuLyAntSUMtPi
	uOCgFKDrPK8XH0oP6MY4d7wL3rd6Htpn/bqseq8txXmQAeISIDqWxjGzTj1gcQiM
	vfCF8O7cGOUrqiMN6JZNED5fcf+vPLQcU+vrJQ19E5UaJQh+i+5ug==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5a3du3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 14:33:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69KDYsjW1538904;
	Tue, 20 Oct 2026 14:33:14 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hckqvjhqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 14:33:14 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69KEXCtQ3867572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Oct 2026 14:33:12 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7697158060;
	Tue, 20 Oct 2026 14:33:12 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13AAE5805E;
	Tue, 20 Oct 2026 14:33:11 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Oct 2026 14:33:10 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc: KVM <kvm@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: [PATCH 1/2] KVM: Set up async page faults only for faults that need to wait
Date: Tue, 20 Oct 2026 16:33:07 +0200
Message-ID: <20261020143308.228328-2-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020143308.228328-1-borntraeger@linux.ibm.com>
References: <20261020143308.228328-1-borntraeger@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA1NiBTYWx0ZWRfX+X8uS9nnYvgk
 88Hc3HjxK2vFv46cdXNMtoczbmomOXbYQXJNtPW57uakRKoalQ4FOoKsrjypSbbDhZGYmbll0RQ
 y4jmaRY7yvAibdmwcfCwvMcsOnAOABM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA1NiBTYWx0ZWRfXxu0l6YUWbPOk
 ry7vkwJl9hZw9fKXGsYUHkd009vgUR4H8Tq4cEWaeVGQvrSl0OmQIMyJV7b4YVZJIoXgBbGsc3p
 DN/b8Adz9jdCcF1zsWjBZQPke7JXO/++t3R5kseSZCNfnPrX1PZZre4uKe4CNP4GF9AodUNxwNw
 waRnZqGhKqJzpRLeCevngY39LA7LXXnVKa52oDvH1tSDV7nW80TuWlyP4ZP67NYbJcfie1GImOL
 ZiWeigH5A99T4E/SD8bChVs6j/8kX/BccfYS16OauzkBemQDmoNoHFxRo9JVBMqWLUGXR6ZDxiA
 ZxHhtDG2zk3Qiwo3Fi2FrEkWrVdrfuBbPvhxzgJgcF3OyUce7ytgM8cngEKlq9ds5PDh1Zvp2Tw
 wsMhYlJ+Qlkk96JvNQ3WYnmOMYtLF/7dnZzVYzL56k0AiWBIzqZpM8k0V4dFk5ffZC++JhoRg7W
 DZ+0eaO9mp3cwn8WZZA==
X-Proofpoint-GUID: Zvef_ByYTYQLBf8vihPeg0xd5GibJuWH
X-Authority-Analysis: v=2.4 cv=JIKuIMKb c=1 sm=1 tr=0 ts=6ad77bab cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=2XfxGlgA2qNMPojl:21 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=B90Q0sit6v1lwuMtttgA:9
X-Proofpoint-ORIG-GUID: X8GrOVqDz2ryGb4OIS5AORN8rBnxMJ8E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200056

hva_to_pfn() checks a FOLL_NOWAIT gup() for EINTR, EAGAIN and EHWPOISON.
There might be others like -EFAULT for VM_FAULT_SIGBUS.  For those other
errors, reporting KVM_PFN_ERR_NEEDS_IO would be wrong as it triggers an
async_pf resulting in endless retries.

Return KVM_PFN_ERR_NEEDS_IO only if gup() returned 0 pages and report
the error otherwise.

Fixes: 0857b9e95c1a ("KVM: Enable async page fault processing")
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 virt/kvm/kvm_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 5a782849521c..34b38d7512c3 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3048,6 +3048,7 @@ kvm_pfn_t hva_to_pfn(struct kvm_follow_pfn *kfp)
 			pfn = KVM_PFN_ERR_FAULT;
 	} else {
 		if ((kfp->flags & FOLL_NOWAIT) &&
+		    npages == 0 && /* no PFN_ERR_NEEDS_IO on errors */
 		    vma_is_valid(vma, kfp->flags & FOLL_WRITE))
 			pfn = KVM_PFN_ERR_NEEDS_IO;
 		else
-- 
2.53.0

