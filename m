Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3578E25F7BF;
	Fri, 10 Oct 2025 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760086333; cv=none; b=OhZZHmEMpXmdcg523YMs87w4FiVQpHdE5DATNkXl92bkKUuYgWl4udx9s/pufQJgFGbxWzZ2S4urZL6u5W95jBokVo7ySmVOB81ajban4VZpIpWJOSmK/oMKttG0cHTr4Rli5flm0F0a92GZMiA6wi2KrINuIhYcLj75hymlk74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760086333; c=relaxed/simple;
	bh=kcVOf2w5vrIxsAW827P7QBK2Nyt07BVtGFAj4YwW0KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXVPutPBWU+PxOIrDkK0SPyaWiuZ8yEl/3fcX10v1Ftb/QNcPezLQzai4Gsiq35xVkZmgnbR3kFswh3uU1bX72vAcW7lMawdCnT+gAqC3M0o7Cbch7a0u18aYm98l0rs2HJu+y+mElrMENbwSw83g80b0vOFajqkLaumBZgQcQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pPXJTkSI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pPXJTkSI"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59A8KIwP027378;
	Fri, 10 Oct 2025 08:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jYtulw8aoRmiaFNUP
	YzcVOBUYWQXBcxdGuZQq+RhF/M=; b=pPXJTkSIHgF1QQSHWcYgXfTp/hGRSBigh
	e+1A0TdnWha2qShQstyfNQfX1Z+3uJM9z38NPvxfRxNQiAf0swkm47VhJsrjKxmK
	rQjmc7ssH7A761lLzEodQT/yQMnIywkE9mx6sNik0Y5SWWMybQp8p3UuZMXEkpUF
	pxf/Tw6m4aRDhPT0IU+HMdpswSig0RxRu57ZqfVfAJdGViz6joHh4jWhiFJmRAPJ
	yLKeVgyr2mhzmotLQVHyzUYtvGfCTMmuUyv4DI6PA5ERfhkTFwrkX5XxdkPn1/M6
	sAVv/KCGjhkbgyjjUA+/D8igtAKyr3Fn/1tEP3U4+fb+RAKoRzgyw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv81sfxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Oct 2025 08:52:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59A8OGvO026024;
	Fri, 10 Oct 2025 08:52:05 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49nvamryxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Oct 2025 08:52:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59A8q1M553412230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Oct 2025 08:52:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C470A20090;
	Fri, 10 Oct 2025 08:52:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 963232008D;
	Fri, 10 Oct 2025 08:52:01 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Oct 2025 08:52:01 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, linux-mm <linux-mm@kvack.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH v3 3/4] s390/sclp: Remove MHP_OFFLINE_INACCESSIBLE
Date: Fri, 10 Oct 2025 10:51:46 +0200
Message-ID: <20251010085147.2175918-4-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251010085147.2175918-1-sumanthk@linux.ibm.com>
References: <20251010085147.2175918-1-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DMJtnELfKhFqKc1h1X-nm1rbwfVcrN5L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX8bOlm2FdqGSG
 38/cliz8S9d4eMYWkDH0L1/+00+lYk99F+lih1lyN3dFCS6FMsbrnofstL7ELx6XMfk3ZL/xvg7
 UbdjkNPuxtLPh6t66LPqKaxdCfBZfxorsTh1Q+8TxXNoD7So1YYpun53RzVRLYKHuwtZLwbyP8Z
 NLNmhs/3NWlkr78d6U2uMlMrthXrh7iBtzzg8/Tzy0wYYPPftmXw9DDAkcI3LgTU0PC4iL2AHV3
 s3QvBVfAeoIgYrLIiPIGeIUqKCxt580theQ5fF0YvPKGUS1tAio05bRsjyYxanqIP8p0o2pOLg7
 MR/Dpv7SjyzflGvvhlOqEropYzDkVk9zNfWR5hpn0L5aJidKC93AVFBZeuoGDrqR2odgq8C4+co
 Zk7zjCJGfOT0bOEbm8Mij3BR7a3knQ==
X-Authority-Analysis: v=2.4 cv=cKntc1eN c=1 sm=1 tr=0 ts=68e8c936 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=f30ByJGsKnh_ESHQSg4A:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: DMJtnELfKhFqKc1h1X-nm1rbwfVcrN5L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

mhp_flag MHP_OFFLINE_INACCESSIBLE was used to mark memory as not
accessible until memory hotplug online phase begins.

Earlier, standby memory blocks were added upfront during boottime and
MHP_OFFLINE_INACCESSIBLE flag avoided page_init_poison() on memmap
during mhp addtion phase.

However with dynamic runtime configuration of memory, standby memory can
be brought to accessible state before performing add_memory(). Hence,
remove MHP_OFFLINE_INACCESSIBLE.

Acked-by: Heiko Carstens <hca@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 drivers/s390/char/sclp_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/char/sclp_mem.c b/drivers/s390/char/sclp_mem.c
index e44b3b01dae6..80b993ebf0e6 100644
--- a/drivers/s390/char/sclp_mem.c
+++ b/drivers/s390/char/sclp_mem.c
@@ -224,7 +224,7 @@ static ssize_t config_sclp_mem_store(struct kobject *kobj, struct kobj_attribute
 		__arch_set_page_nodat((void *)__va(addr), block_size >> PAGE_SHIFT);
 		rc = __add_memory(0, addr, block_size,
 				  sclp_mem->memmap_on_memory ?
-				  MHP_MEMMAP_ON_MEMORY | MHP_OFFLINE_INACCESSIBLE : MHP_NONE);
+				  MHP_MEMMAP_ON_MEMORY : MHP_NONE);
 		if (rc) {
 			sclp_mem_change_state(addr, block_size, 0);
 			goto out_unlock;
-- 
2.48.1

