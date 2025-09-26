Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFAC2F7AA3;
	Fri, 26 Sep 2025 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892560; cv=none; b=ofDYhx335JnRMe6HrsTAftGD1odLOxbGw7n5oUNNb5/ozz+gRz5UmxY4gVFocXYMLF/l+9m93HNZ8UJq8hBkJlqTLFNsapkdjONNXga2zcTFwnNoObskpfqSktUrjSjtQS4oE+CV7DDrG6MwiMnH5Yocu26FL0mEJ5J1uUOjpws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892560; c=relaxed/simple;
	bh=tdgLgatgEVJpMzjlKVgPI2OptBOd77BUr/W6B8VcBHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+UXY5vjy1R+2F20rAS5F3vDyD2hJCNa7l1tNMNJsYhguakj7qRXbRsFcNusS8f+wtwmHDdpTE8uLtHRsPy4k6TT73LNJQMbm3W51GwUxEGm/7dh14xLiC04v0zNgpOsObaUgSJJi8f9iIviJLMPsrhtVnMMI7O2JQuwrfAxGzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G4fYiew5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G4fYiew5"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q5O1f6028832;
	Fri, 26 Sep 2025 13:15:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CtgZ8+iO1ueeY3gMX
	Ex6CkqtU3/2YuF7qvH0Ti5mWwc=; b=G4fYiew5oiyGM9+Hq/2lvYxVOOqrejTcR
	yPFrlULLKknEfAxcATDP/WUwvfI02pM9GBlUr5GUrBZCoMQx0vrD32DsU/Siy45h
	v48XOPiOCZnDtfwGc9otACGsrM3GDth54qCCN772cDUmRvdt4lBhlhZoj25nlqY4
	4oGQf5JAK+ZuwYz4lSDqh8dIrErp5JiEFmNqD8jso/YKIJAJEtUXMqj7142WO7dK
	hkQYmm8vj3MGQX5xnZRD6ZTtuBTS48Wx146aa1O4SNmZvLy8LGQpGDZiLvXACEpG
	oQCy5OMrofDiEdCjgkOlp8eUY5aEb2YlW2//Bbl3lGz77vCu/uYVA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49dbbbmpny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 13:15:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58QAVUWG010035;
	Fri, 26 Sep 2025 13:15:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49dawq450v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 13:15:52 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58QDFmH329688108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Sep 2025 13:15:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D301520043;
	Fri, 26 Sep 2025 13:15:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8DC420040;
	Fri, 26 Sep 2025 13:15:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Sep 2025 13:15:48 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, linux-mm <linux-mm@kvack.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH 3/4] s390/sclp: Remove MHP_OFFLINE_INACCESSIBLE
Date: Fri, 26 Sep 2025 15:15:26 +0200
Message-ID: <20250926131527.3260733-4-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250926131527.3260733-1-sumanthk@linux.ibm.com>
References: <20250926131527.3260733-1-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hN-2WtSxn6u81hiCYsJmqwsZzqsrdF5H
X-Authority-Analysis: v=2.4 cv=LakxKzfi c=1 sm=1 tr=0 ts=68d69209 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=f30ByJGsKnh_ESHQSg4A:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: hN-2WtSxn6u81hiCYsJmqwsZzqsrdF5H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3NCBTYWx0ZWRfX/ptYI8Up3RKz
 ehXD+jkDZjRogvAlsPYmrMzoscb9zKvUFFS1FXnP1pd6hi5rYdlDaQJWaRUr0RgHhIK5yBqije0
 uJQigGWv34T8A8mWXYT5iUJdMPwyjroeDo37g906ocBgpoTomVcpY3Tn9OoGT/jtdCzvizTRaf3
 02Gw7Ek6HZ8L8b6BRlpQW/EwL8Ae/RCuIUeYGAD2rPdQa60bHuIJd5JYozvHEH4VvOLKsYup8TR
 qpundNvgS0nzGKGBpz0XHtD1ydyDMNZYjyx3f6lKO1QaKgGSDeDnSLxThXbroLejUvwEjL2w9Dg
 m4DXNrfXXU4X0lx8BCpSEYrysxZ3SGRwinEpnxl/tGVglZnLUpOVfuFukAp9K32ODv0VywLXt5j
 B4cys4jC4SA73y3TRl36M126XeOZ5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_04,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250174

mhp_flag MHP_OFFLINE_INACCESSIBLE was used to mark memory as not
accessible until memory hotplug online phase begins.

Earlier, standby memory blocks were added upfront during boottime and
MHP_OFFLINE_INACCESSIBLE flag avoided page_init_poison() on memmap
during mhp addtion phase.

However with dynamic runtime configuration of memory, standby memory can
be brought to accessible state before performing add_memory(). Hence,
remove MHP_OFFLINE_INACCESSIBLE.

Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 drivers/s390/char/sclp_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/char/sclp_mem.c b/drivers/s390/char/sclp_mem.c
index 802439230294..f49b8457e721 100644
--- a/drivers/s390/char/sclp_mem.c
+++ b/drivers/s390/char/sclp_mem.c
@@ -267,7 +267,7 @@ static ssize_t config_mblock_store(struct kobject *kobj, struct kobj_attribute *
 		__arch_set_page_nodat((void *)__va(addr), block_size >> PAGE_SHIFT);
 		rc = __add_memory(0, addr, block_size,
 				  mblock->memmap_on_memory ?
-				  MHP_MEMMAP_ON_MEMORY | MHP_OFFLINE_INACCESSIBLE : MHP_NONE);
+				  MHP_MEMMAP_ON_MEMORY : MHP_NONE);
 		if (rc)
 			goto out_unlock;
 		mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(addr)));
-- 
2.48.1

