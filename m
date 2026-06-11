Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F362D3D810D;
	Thu, 11 Jun 2026 10:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781175046; cv=none; b=PzFHZUfmhHj0PPK/kzgMoaskWG3yvw0YF9HvZLk0tue11AGvOfzGmH0uJ7K0CvvWKTgwfj8vAb8VMKqmXHuFqW0yiBBBW7WxHxAPT6AZ3Lpi/FYgzEaOXVIVo0yHzIbl/mhWBAUlrCCS0aSJ18QlQnoLosXRW3+T9cNOnes74M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781175046; c=relaxed/simple;
	bh=9V787Td4Dvtfn+nDI4Ewy4cOz10oYrgsJGEHFme33WY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lPOu+Tz0iSf5P3LQ0EYnkPa/UbeXAC+CDfhToJa6W09HnzSo/YkGLGPOcXeAIKWv4jtd1IjmlNxYkCTsmrbwSMvi/ofR2b6gwHqoa0UJ7qyRhd5MEBDBYXK6YnL7RoV511Ban//lircjoIrGUxHlN8xOVgYbIaAjCwnDNwzqeSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CDz6EUVQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CDz6EUVQ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AJucjt723704;
	Thu, 11 Jun 2026 10:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=hp3IR+YIjYQIeDzDRua70lr1KZOl1k5N2FNLssGo1
	jE=; b=CDz6EUVQQSKq59QGZDeUHe+3oCHh68zVHXhtY7nxImtlL9zMywBmFLqjN
	aDAOhV8xGAb+gPTVmW3qtVd0YfkZOcCb4gUx9POQznZOQVN7nGgSdYsa9EOTv15U
	teTwUrjEVleQXKgsJ0mqwvxnMzKmqbACf7PJ70bbtNOmXnQAH68e3wmjyIYBOEDF
	rXSqAl+bg09VLSb4xmFTMrJuJAPmfkPDSxEYORUMSpBwwBaf2mqI6HPvARJ8w18q
	9dYOgEsXnmu6itFw0RHduOT4dhVUZHERkYSqZBVDbufL+BegEbJNfjoAvE0sxpKr
	6LHtXNBpk3pB4u2M2LCJac4rHwBkA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8day30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 10:50:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65BAnbFA006683;
	Thu, 11 Jun 2026 10:50:42 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe08ttk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 10:50:42 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65BAoeoJ17957382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 10:50:40 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFD6C5805A;
	Thu, 11 Jun 2026 10:50:40 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38EF858056;
	Thu, 11 Jun 2026 10:50:39 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jun 2026 10:50:39 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: KVM <kvm@vger.kernel.org>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH 2/2] KVM: s390: Initialize KVM_S390_GET_CMMA_BITS memory
Date: Thu, 11 Jun 2026 12:50:36 +0200
Message-ID: <20260611105036.11491-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEwNiBTYWx0ZWRfXz96gMv60YEBE
 GFwqvIYYBiHSfe8AgnZYxzSFFyOSZRy0xWRkbAmiunwI1ujZo3fAthfdbIAoNGJt2z+MGstp8UE
 TUhEkeJi9FWWlS7dN9G3Z1Mpkn5ltq0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEwNiBTYWx0ZWRfX+YI7iclzJfhx
 gQzHWEiLPeRLNlh1UbzHJ5E8hc+nSaJ3/unbCocbZTBDFy/z5/qRxQyIttFnX+qKTIG9fVp5sUW
 vDn30ZN6cADD8yJWIVZ8cMK8oeV/pPmzYeLCaPNAoNlp6wRj22OqTcvOnzXoSP4578jg3TQzvPc
 yeMvaJUExPHempW+QkV9Ll2+vbscCUXtAWu47TPw5EVFwPcBAEn9NAnedlJ/PohtNmcrhu8pX+V
 lHTua3tUrIdddKrHHpE0LyA8dSBKOMqT3Y9B0nWRz0ybCraKWkDyfs/QGUTwbeQ8lsmg5/1PqBR
 I7WGWyK673zcqyv+G5zmsgOVLWkzVFH+YGjBysUHbxhuKd2yPOI2kVu7/XmSvPHLK2eTH6NvwCN
 kgZSehId/f2LL+IwzBWh2lIFCFs8UxRpJFW39iYM7sww6pEmrppli5GERVGmaSqvFeMgH6tBTtB
 ZP374vM1jP7DeNbtBVQ==
X-Proofpoint-ORIG-GUID: iG5SiuxT43cB2tcoGLIxA6MCQNDqPBf5
X-Authority-Analysis: v=2.4 cv=GIM41ONK c=1 sm=1 tr=0 ts=6a2a9303 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=edr1jgEE9EUsxhqThykA:9
X-Proofpoint-GUID: iG5SiuxT43cB2tcoGLIxA6MCQNDqPBf5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110106

kvm_s390_get_cmma_bits() allocates its output buffer with vmalloc(),
which does not zero the returned pages:

	values = vmalloc(args->count);

In the non-peek (migration) path, dat_get_cmma() reports a byte count
spanning from the first to the last dirty page, but __dat_get_cmma_pte()
writes values[gfn - start] only for pages whose CMMA dirty bit is set.
The walk uses DAT_WALK_IGN_HOLES, so clean and unmapped pages that lie
between two dirty pages within the reported span are visited but never
store their byte.  Those gaps (up to KVM_S390_MAX_BIT_DISTANCE pages
each) stay uninitialized yet fall inside [0, count) and are copied out
by copy_to_user(), disclosing stale kernel memory to user space.

Before the switch to the new gmap implementation the buffer was fully
populated for every gfn in the span, so no uninitialized bytes were
exposed; the dirty-only walk introduced the leak.

Use vzalloc() so the gaps read back as zero.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 9fb8ce45eee9..05f8a8499701 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2247,7 +2247,7 @@ static int kvm_s390_get_cmma_bits(struct kvm *kvm,
 		return 0;
 	}
 
-	values = vmalloc(args->count);
+	values = vzalloc(args->count);
 	if (!values)
 		return -ENOMEM;
 
-- 
2.53.0

