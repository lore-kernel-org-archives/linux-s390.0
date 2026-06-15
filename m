Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2153F1AD5;
	Mon, 15 Jun 2026 12:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527379; cv=none; b=DBuZ/nuNuN9HgH/veupcNvO48wW3/LDDgj1k4ZvjRhqcnH1aflHDJB9TLzLbNSuFoklJkov1b6infXNWKmGRNnnFA5XkZdhE3r8CTA89qtDqoAp05k4uDW+rDB5DoliTE/3EfhGtpndhejrLqjym8P0J/OwLZI6ssZW6JlMFszw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527379; c=relaxed/simple;
	bh=AQVttpgYiSQEzKndp6ZeEFFZIeY+x3OJI/Ap3lNfoyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1ytaH1bFQe7iTU5sxcf8hcZfXIN5Fw44snIqwEvDx5yniKOP3jZHQPihwG6sty7okFxUYrodP4jJJ0K8Gs0di5YRBdZUTbTOpmr9fnjZRPms20l2erjnKKsqheZv8MZpsUW8WP+F1fBwVdU9+Hu1YZ1HnfJRSoavNJvSNR44OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mvn4I0/3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mvn4I0/3"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FAq8V62248411;
	Mon, 15 Jun 2026 12:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gRjOE7pnfkR318rx6
	OdzXQMHWnVU9fdqXJ5HjhUX5KI=; b=mvn4I0/3w2iduBK5bfL0r9qtA6z5sOzOG
	B3APpY+k9tkrrZBSmX/uzD9kyAhe+tT/zeAOxmsLTPvZz9dSGJMK1zUDKntJwhiG
	Fm9xTW1gHoSK/oKuEmtqSOaJxtwnv4BOrbXdZTjU58vMaqX3l51wbAue4ZRxsR8k
	qRshLDqygkPFqFwji9QOOp/hM9vaaAxw36UYkvJJ7xy3UtaB4BhIBFEYhlK7l6pA
	cIx38Mxsk9TkMQl1KKy4nvcM1EykeCsuk2t/P01UWXgg2svkQXzZcs9RYrk2/aMh
	+BX3UKKYOG2H9t7aDaTlr5It+epVRfWhaTQ23WpLcJep9hzFFQc+A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1u0g2cu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:42:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FCYcSr028351;
	Mon, 15 Jun 2026 12:42:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eshhpxqtp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:42:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FCgnNc58851634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 12:42:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 482512004E;
	Mon, 15 Jun 2026 12:42:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D519420043;
	Mon, 15 Jun 2026 12:42:48 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.31.49])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 12:42:48 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 10/17] KVM: s390: Initialize KVM_S390_GET_CMMA_BITS memory
Date: Mon, 15 Jun 2026 14:42:36 +0200
Message-ID: <20260615124243.187614-11-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615124243.187614-1-imbrenda@linux.ibm.com>
References: <20260615124243.187614-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YOqe7ZyVZ8gH3lUvHcbhNeSlhbJCTunI
X-Authority-Analysis: v=2.4 cv=XdK5Co55 c=1 sm=1 tr=0 ts=6a2ff34f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=edr1jgEE9EUsxhqThykA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX21xriiJDnbyk
 d4s94RZheK3ZmuXXzuGFkLle+ofGs5nHxc9dGH6126YWvlgjK1anvk2ssX+rtPambc9i34qp7V3
 YXq3ZoZwY+54iTv0Q72SPYYkAkK1eISBKQomLW81b0ALKpg29CYXbN4cKz6KVDUwTqk0i20E+mI
 MdaCf/SFJaswXpI1So0wX0X5LOg0/4Hn2DsIdZvlNfeeUmQgHiJAGHc3n3VTBmSjbD8cXjB6P8k
 C/KFcjSJWbRV6RZCPbzNG3/EP6rH8AsguiQcP20Xh6Se0+JnnzhisBAJvBp0BeCWDyo3+tSyX2m
 syTVNsNNNeJx7HKwZ55To6QFGvI8jp9Ptm3//htJbXiqEUIjL85gOEwtKxSz4Od8YIwDgGceac3
 p5bLKpZ9wJUUiOGo/fE43w34YuHILNR1qE65MEYnnuMnJ/Z8IY+R7iaZ3SqV6ubO6VA2UKdQXBs
 TTsn4/9zvrpaGleSotg==
X-Proofpoint-ORIG-GUID: YOqe7ZyVZ8gH3lUvHcbhNeSlhbJCTunI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfXxzoaRmktNbSN
 GM46c8Ab/9C17lVzSZiSt4eAZ8Yup9rLRwEdm2RtgNod/moqnhYNUXVJ1lGmsaVB12JZI2bhPQm
 YwY5ZaN2l4y3A3xtkjeNkMKKpG0wnn8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150130

From: Christian Borntraeger <borntraeger@linux.ibm.com>

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
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260611105036.11491-1-borntraeger@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 6de36421548c..d503e4d0072a 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2263,7 +2263,7 @@ static int kvm_s390_get_cmma_bits(struct kvm *kvm,
 		return 0;
 	}
 
-	values = vmalloc(args->count);
+	values = vzalloc(args->count);
 	if (!values)
 		return -ENOMEM;
 
-- 
2.54.0

