Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E342E2286;
	Thu,  9 Oct 2025 13:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760015951; cv=none; b=EfsHP66rvYiLeWwmiLN4u1LQ+2V4xhyyzil/SFq82YRwCjQxitZqxASnGV1Tt+QPIbWxD6C4/tlZZ2ppsCbFsxyhyOnOkEjRaPnUhn6BBrI3h5E7VBL3wzj3VcIVMkmgvRiUXXuSHWR1bhpGxalQcgUIx3baudbfwx62wSvNmn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760015951; c=relaxed/simple;
	bh=d3ZyF88yFzESlsw/w2CeV26a1BAD4G4igCxUBJeHt7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XSnEbfpWcfA1X6iIRW2Qte3xamrQbHVVrZz6HJzEhD9pWSChOqOEMpu0SUQM5uNejkxqbnL/CI4iBPkTzAuGnptUJLdgntSZ3iCLJfPygIJ6r4CnlkfT5tmZ4Q1aii33dYQGCVim1aY3mvQHIgrf4+FiNtX1NeT5VjnJ7+hKmzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h/+2Rtt8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h/+2Rtt8"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59962paC006776;
	Thu, 9 Oct 2025 13:19:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ssanh8VwdyjwLWEsH
	Z31wMDyfL3WAluPI/tm6+YRb2U=; b=h/+2Rtt8I3cwqUcMOtx6qrvErfH4Swk8n
	16XzP+2kSKPLvNMaVsAkJCqWE1EGjC6k+jq3wr+pYwECSUiu8vHqRi8vSqTsxCDZ
	uGcXf1fgREhZIBugg+45UsHCujsvLD6RkvDfySJAWsRgjZTH6yrch1H5J2DKScF4
	IpfIx2PP0t84sA7+g+y/rUAzlPGDjdB2lhTfXknieUoeIZWKo5wPRBPU/faeW/f9
	kEZeAlBiwpD6/rR0h7P7Ec+twTtAOe7q9iIdC0SMJNkRXjqMacts9FJwzcIwJQSk
	vdVibyEgIn1P9O+LEFMHPTQluREWs3N2doDsHbfWDVzcmkNbGfmhw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv804y91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 13:19:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 599C0jOp022764;
	Thu, 9 Oct 2025 13:19:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49nv8vcngq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 13:19:00 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 599DIufV26935976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Oct 2025 13:18:56 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 348C420040;
	Thu,  9 Oct 2025 13:18:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07B572004B;
	Thu,  9 Oct 2025 13:18:56 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Oct 2025 13:18:55 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, linux-mm <linux-mm@kvack.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH v2 3/4] s390/sclp: Remove MHP_OFFLINE_INACCESSIBLE
Date: Thu,  9 Oct 2025 15:18:38 +0200
Message-ID: <20251009131839.3739108-4-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251009131839.3739108-1-sumanthk@linux.ibm.com>
References: <20251009131839.3739108-1-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=NsDcssdJ c=1 sm=1 tr=0 ts=68e7b645 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=f30ByJGsKnh_ESHQSg4A:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: Cb34PJeDiPm_thVi2hrKDmHPOp5HSuy7
X-Proofpoint-ORIG-GUID: Cb34PJeDiPm_thVi2hrKDmHPOp5HSuy7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX5tN/NaJQdW4q
 0iwOvGH9gjQgfrNc390230OS8GSU/KCyVhDv+j+t/wpYOJ+R00bF2bdXjTlBCy/EJ39+1y+vFBa
 imNg2eJlswvknDznm/Kp45lptp9oK9pgDU9CnSLEE9i9hOq3YF0PsIuCr0iXwGTYFlgMWjlIbeg
 XrBRVmtL9EpdzxVvmUOny/K1S/1O9dziqZIMmeibkodseG/8b3keUF51wCL4a5fi9BeyTqltl4G
 OylClrDJalGkDe93SUfjwu7AIzEyvlvIZlkXElZzECSla+6FF4K10vY9dLUcxR6aXwfXYEbnIjx
 rza1ToJ7ISdc2wuUEgeePieO0HqsVvXQ/QhhZmzpos58sL4FHhmOvpFMlr6bSRrZuunR8zJgIHF
 jSqb8zMY84+sprtx1yyLXZZYBgT7GA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510080121

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
index e1302b1c98ac..0f8c0a4dbdd3 100644
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

