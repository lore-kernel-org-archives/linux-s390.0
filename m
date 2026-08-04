Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA6F3264E9;
	Tue,  4 Aug 2026 12:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785845206; cv=none; b=XWDrLwDpy6FRJAoYmbSUhC2NIJ/Ei/LJwfJ9sEIvBl0sNKmLcW/KRJUpy7ywjC31MVbvl2rr6OoxOxcsEL4/GbmB6DkwJW3nsbmvdyw70r/CoolpCOpNWCSFrtd9sIOQZqnMx4QrROAnDdg+UjQnhALt89gw0v4Ke1KEw5cCpZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785845206; c=relaxed/simple;
	bh=R1Xkz+bpo0V4V7inGZdD0CAbH0ZjrZAkrSEHeKYq8JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UvZ026ftOMyM0lCpp5IWbzKDmDViUCzegRDc8J3E3f2SmIZk/cFHNnycazoYk4os4geRTJj3YzyE8+LW/ZeaWNd6XmI0nD1N2900aK0OsqEvfWPkniLNqEHFbTeSMvKF0qMwOFb3wptxcq5vVTe6+XgTBHGcsVh7ZqsgxxQwxSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cWGUpyuw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cWGUpyuw"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6748HfdA296040;
	Tue, 4 Aug 2026 12:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ErD+OLSzl6FOPOJ2L
	7Rs3afpED/1r9gQ0byqCkKBeYw=; b=cWGUpyuwqIgd8v23gCySM0X5zm/tY0P6+
	TGCftwomck0BJz7rKA9+tBBn9QgWR8qiv6LfMqAW8Sbd0gVZu+ca8+MHyBJ78sUF
	22/F5OyllRLpZ4wPrcugC4RNTvnomeihr+b1QNKGvq3IbWzKMZo7wGcQmw7Hm2b3
	JzOdL2gFvQ8EdpVPrLIXZxcN9fgUHIlKWN6xKwYVqGuE7giu2hxbVjaweB2jxz+I
	qamMOjZpnjkws8hZsHj/3lUuihtNCC16NSm0JF3yHe1lq5k4CH87cJkLiU8rBPrj
	XxFNnh8yhzsxH3FHPX/Go9MfVzFKLl7anyvxInB2+ZttIcVLKi3UA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3wphu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 12:06:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674BuIoD013671;
	Tue, 4 Aug 2026 12:06:39 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh9rn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 12:06:39 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674C6c4i29164084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 12:06:38 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0956C5805A;
	Tue,  4 Aug 2026 12:06:38 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13B9358062;
	Tue,  4 Aug 2026 12:06:36 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 12:06:35 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: KVM <kvm@vger.kernel.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Douglas Freimuth <freimuth@linux.ibm.com>
Subject: [PATCH 1/3] KVM: s390: remove user triggerable WARN_ON
Date: Tue,  4 Aug 2026 14:06:29 +0200
Message-ID: <20260804120631.736919-2-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804120631.736919-1-borntraeger@linux.ibm.com>
References: <20260804120631.736919-1-borntraeger@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a71d5d0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=AABZzEHfO4awnm3PS6YA:9
X-Proofpoint-ORIG-GUID: 3tXZiU4VQq88mehREfzrCUgQ6HrAxaSx
X-Proofpoint-GUID: 3tXZiU4VQq88mehREfzrCUgQ6HrAxaSx
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA5NCBTYWx0ZWRfX4EkAd5D9C9Hf
 tqTrK5zBO5T3svLM0BuRIbdp3BDqTENfOUlMVNg/laW4uM18WgWS63qcBt50b2yxpOjRhqbqIv7
 xdJM1w3suV0qUsE9Ri3sOrhgfd77nTM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA5NCBTYWx0ZWRfX5EbbU/F5pKCz
 PucXhFbtSVMl9umFUMEeYWR263lvlYY/6l5i2DvG97Jfoq7qYDNdvSZEUeBvPxnvpv8NwMMxGhc
 d8BF+jNsLZGIMPoM20phOMoaG4t4JHlALB55LVjSiDlC2NgOBNNqxNbneMBUxD3SeCK3T9dtdfD
 DXDuqUoiQGzDSo+I90OFpa/7xnKM56lJZr3ot8wLmzrQfKGE7pOWJPCxtebp96HxT3o0Py21L3M
 QmEqPwc7BL70XiiPEpLDyEtBj59lW7vmTqvL/K/9izC17K2GnCbJOHbDgrZ8oYblyBkj2AiHix0
 p8j8k6WiBC/i2jhH+rMaUsThgMk8KnpEFJPHZHL9q2qRjC6oMhAJVSdN8ADe+8Q8NVayLTN37Y4
 jZxFGxScsKrOMb8Cw6EXUMc6r6N/bvGXSpcdjO0YzmiUw+xWjbOFSNfShscPYQsV33ADHyHp09m
 mV7lpR7nxYFolRpL0OQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040094

pin_map_page() fails legitimately whenever the userspace mapping behind
the adapter route has gone away, e.g. when the VMM unmaps that memory.
As this can happen without a kernel programming error, remove the
WARN_ON.

Fixes: 8c0141b7c13c ("KVM: s390: Enable adapter_indicators_set to use mapped pages")
Cc: Douglas Freimuth <freimuth@linux.ibm.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 8f24bcd1a6d3..23f0e0821474 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -3013,7 +3013,7 @@ static int adapter_indicators_set(struct kvm *kvm,
 	if (!summary_info) {
 		spin_unlock_irqrestore(&adapter->maps_lock, flags);
 		summary_page = pin_map_page(kvm, adapter_int->summary_addr, 0);
-		if (WARN_ON_ONCE(!summary_page))
+		if (!summary_page)
 			return -1;
 		idx = srcu_read_lock(&kvm->srcu);
 		map = page_address(summary_page);
-- 
2.53.0

