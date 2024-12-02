Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54C71FA14E;
	Mon,  2 Dec 2024 08:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733128093; cv=none; b=Yy1AGpmSa6SsUovNV414zJLArEtpR9owBkLKr1gz1FAq6fGYQlhfr9mVH8CvkgnvKQvjorFkKrtC2L64DaohxIPzTjNFZTFqIe2wRiXaptz/fMSU+NxWq0Ro2Kk+8IRKMApc4Ioa+OGQrg1KBy+3zUjBBd5dKOb09LrtXJIOS9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733128093; c=relaxed/simple;
	bh=rVxXH9sWDoht1KxMmKbfnALGLfi1rfOi6esHorldA/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpA1RxuCgjbFBVMLgI9mcQwjbvAwEX+zxiOZ5D3wuMp91zN5M6oqmEhvGIBovX5Zt3gsKt6qFwMlNv4SeIXHDb5g6eTIHPgy691O/J5afAOVB1vGHlsU81UV4wmRGIKHLBGBf5pFXLeNDBbgM4n0vCd6tN64r9XTqQDqkfydH/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BD7l8Og9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BD7l8Og9"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B1EFbRC026106;
	Mon, 2 Dec 2024 08:28:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ttEIqKp1gqeMV+LBQ
	OU9I5MsmYSVPQfGPglAO21iWo8=; b=BD7l8Og9Y6eW5WSxBtuWl651pEWyQg5HX
	Oc3yuVmGg+fgBQck88JbJ/pi5ZFhK1ElbTvlsfPZe69pAga2FTS8iLZEceKrPKS6
	RPsKx8QlIAP8iH5vbuFjH6FUA3BoKRcVFoXnITLN7oo+gfuub1jktFpn6O1V+OE4
	xO3Uqgu+ILPAfOj1p0Jm5GqVr0R4EAITC/oOpNOpx7oXxmGkZ7W3SnNfA/JdTA/U
	pdGQ+RRcrvqU54IxN4Ui6Fqg/lq7bTvGmlqyBbwoSY+gckiAgKMSjzDaHxcax3SU
	dUypS7RWO9u4+QIzNIdhaNG84Dw0kc/3e1CrKHPfjm0nVDdchY2wA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437tbx7c12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 08:28:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B1J5ZZv017943;
	Mon, 2 Dec 2024 08:28:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 438d1s22jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 08:28:03 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B28S0We60424552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Dec 2024 08:28:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C83D20043;
	Mon,  2 Dec 2024 08:28:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EFED20040;
	Mon,  2 Dec 2024 08:28:00 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Dec 2024 08:28:00 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, linux-mm <linux-mm@kvack.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [RFC PATCH 2/4] mm/memory_hotplug: Add memory block altmap sysfs attribute
Date: Mon,  2 Dec 2024 09:27:30 +0100
Message-ID: <20241202082732.3959803-3-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241202082732.3959803-1-sumanthk@linux.ibm.com>
References: <20241202082732.3959803-1-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ROhRVQNbGn0edF93JjKxvQRIWzG9HKXD
X-Proofpoint-GUID: ROhRVQNbGn0edF93JjKxvQRIWzG9HKXD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=761 priorityscore=1501 bulkscore=0
 phishscore=0 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412020070

Currently memmap_on_memory sysfs attribute can determine if the altmap
is supported in the entire system.

However, with CONFIG_RUNTIME_MEMORY_CONFIGURATION, user can dynamically
add or remove individual memory blocks with/without altmap support.
Hence, it is more beneficial to the user, if the altmap support can also
be represented per memory block.

lsmem output could look like the following:
RANGE                                 SIZE        STATE BLOCK   ALTMAP
0x0000000000000000-0x000000007fffffff   2G       online   0-7   0
0x0000000080000000-0x00000001ffffffff   6G       online  8-31   0
0x0000000200000000-0x00000002ffffffff   4G 	 offline 32-47  1

Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 drivers/base/memory.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index f024444b3301..469adc7212fc 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -431,6 +431,14 @@ static ssize_t phys_device_show(struct device *dev,
 			  arch_get_memory_phys_device(start_pfn));
 }
 
+static ssize_t altmap_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	struct memory_block *mem = to_memory_block(dev);
+
+	return sysfs_emit(buf, "%u\n", mem->altmap ? 1 : 0);
+}
+
 #ifdef CONFIG_MEMORY_HOTREMOVE
 static int print_allowed_zone(char *buf, int len, int nid,
 			      struct memory_group *group,
@@ -492,6 +500,7 @@ static DEVICE_ATTR_RO(phys_index);
 static DEVICE_ATTR_RW(state);
 static DEVICE_ATTR_RO(phys_device);
 static DEVICE_ATTR_RO(removable);
+static DEVICE_ATTR_RO(altmap);
 
 /*
  * Show the memory block size (shared by all memory blocks).
@@ -785,6 +794,7 @@ static struct attribute *memory_memblk_attrs[] = {
 #ifdef CONFIG_MEMORY_HOTREMOVE
 	&dev_attr_valid_zones.attr,
 #endif
+	&dev_attr_altmap.attr,
 	NULL
 };
 
-- 
2.45.2

