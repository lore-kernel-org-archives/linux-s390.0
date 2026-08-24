Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1891743E488;
	Mon, 24 Aug 2026 14:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582304; cv=none; b=GbRxliDhtCpBA738NifeJUWiWSyBiFdAXdJqvk8nN5wnSr4E71xsvGfb18Oyzf7YkFKHF9AjGXjQMMT1pTo98ywr+RO9HOWARCLMKRcx+KKfXE0HnASB9OeUwmnqBVoaIsgAeT2TsYMr0sqGssC8FBp43HbriA0QRJoVVYmPlVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582304; c=relaxed/simple;
	bh=Bkdmif0zwp05vqAbMz4dnU1C11OsSUG7rNHrChHCap8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ng9mOY7flTUnMkfD/N65NxO4kxrha/ZJZoESyW5Dp3+XcPH+JgPWGmt/Di/S9NWziYsG+cwlzp3y9ZRHdPB3b3+wCjea/ebLs/H7JZhsO+iBKXXiyZSXC2KogjouUoD1qFxOz0ymCU2cyBDKd9pz654ISYelpTplpNRMFtL7zTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EKi08cc6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EKi08cc6"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OD1erQ826582;
	Mon, 24 Aug 2026 14:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TlYUZTZuGiiXbso/S
	NzdowZONsujd0r/ENSnOglpIKA=; b=EKi08cc6FywEyL+v7IHFv3vy7R/iU7MNN
	RWsnw7RCxA5HGxyQ/kFT0UiuD7LbJDzGi0DvN/8ESK6+E+amQknwshRTLxuMXa4l
	4W1j1gZ0qzH+vD5Ts0gBzdObwMFOZ+VBbts/2R3rZjgga84JQTgNgU5wrA/SfZQ2
	JrhmwRk/Du+eJ2iQSChOzqnFSvGVqWFmUDXFdMgiZtvg7pFddfX3znNQuEXnQJPT
	Ts4pfjM1dgPJm8hE58AmxBqoi2nYoVMzdTetvrklVgvVwqFuJwmzxhhmfurqe9PI
	9hu3q3ZQ5BxfeCUvujo1wjq6LyCYL15iN6XzNG/rV7KBCGU/ynpLA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726ea1ef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 14:38:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OEQL1i001477;
	Mon, 24 Aug 2026 14:38:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfvxnq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 14:38:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OEcFMr51642766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 14:38:16 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D682620043;
	Mon, 24 Aug 2026 14:38:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB2012004B;
	Mon, 24 Aug 2026 14:38:15 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 14:38:15 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, frankja@linux.ibm.com, borntraeger@linux.ibm.com,
        linux-s390@vger.kernel.org, imbrenda@linux.ibm.com, thuth@redhat.com,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>
Subject: [kvm-unit-tests GIT PULL 02/13] lib: s390x: sie: Allocate physical guest memory via memalign
Date: Mon, 24 Aug 2026 14:35:34 +0000
Message-ID: <20260824143740.291583-3-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824143740.291583-1-frankja@linux.ibm.com>
References: <20260824143740.291583-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8c575c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=GueWrYxDVtNpybNoHvoA:9
 a=ZXulRonScM0A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfXytvV1RdSBcjt
 Zq57YdB9pEip+DjrB6UOym1NHVwcPrtcWMpDYa9v4GIRVvcys/JMZSrOdKl5FfWjvpl5I1/ofma
 I1qJratMDGM6gdiyfSCD0z9tlwpuy4Q=
X-Proofpoint-GUID: uQLxZqNHUcewI00hQrOOTHogf-ccJIxz
X-Proofpoint-ORIG-GUID: uQLxZqNHUcewI00hQrOOTHogf-ccJIxz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX3ioe8U5MvLsX
 iooWy2EHTL4LJ0qpmyCufnYHNu/fydBa4YoGWJ6k44iyq4p+i1dz4XRUljUhcZW1W+8UGd0e9SY
 hLb7c1tZuJxK6im2CuSdnQUieyJZZbLrTItQo2RvS3uXCE5wSYmzTCSqpZIhmfycPjfAiMBePep
 PiJDftT5kgfv1cIqxd7NkKNk3pkYqFXQAojRX7oxaDjlVcvpsbouZE6NvZq3fDHhHGbq/NnZ7r+
 OTV8r1efQe1iI8a/hBbzO0iILWRCS/vMpE7WbMfepg/S9CyMd+8bFwFXxNa3MkUYaVmSxaeUIPm
 4YRSimYIk+p1HNFrigcwjDcj8Bd/HSw2m8F75ebYp7G+Yu4ksZvpPzvneCiVeW7m3k9rn+Tv2pX
 2ZjRz0MVLs5L0pndF9I0nUniSxIeSsyEu6QPDmMErunVE0b6VigBhLK0bx/Sk9Mjf4WTe3BAx14
 dld2W/PjgVRRJq/zFkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240122

alloc_pages_flags() alignes the allocation on the same order as its
requested size. Since we use virtual memory for SIE we can instead
align to 1MB by using memalign() which is less wasteful.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
---
 lib/s390x/sie.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/s390x/sie.c b/lib/s390x/sie.c
index 47d4cdde..8757f610 100644
--- a/lib/s390x/sie.c
+++ b/lib/s390x/sie.c
@@ -171,7 +171,8 @@ uint8_t *sie_guest_alloc(uint64_t guest_size)
 	guest_virt = (uint8_t *)ALIGN(get_ram_size() + guest_counter * 4UL * SZ_1G, SZ_2G);
 	guest_counter++;
 
-	guest_phys = alloc_pages(get_order(guest_size) - 12);
+	guest_phys = memalign_pages(SZ_1M, guest_size);
+	assert(guest_phys);
 	/*
 	 * Establish a new mapping of the guest memory so it can be 2GB aligned
 	 * without actually requiring 2GB physical memory.
-- 
2.53.0

