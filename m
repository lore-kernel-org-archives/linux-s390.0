Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0567F1FA14E;
	Mon,  2 Dec 2024 08:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733128098; cv=none; b=cwV/6s+ORHCry1ibL0BnzelMu9PMVpuXCJEOclfFTthBA1NTJY/C0ww7jUkXT4Gv9SfAzzQo+hII7kyOCQwX/pywbd+zHBBSmNqIeJMpaAlA9X2Yu4tc4B0uVEy6Ys20LfKSk3N57NUYlsFAuGxPmIRF1Z0ZYos+VKJtsNHe+Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733128098; c=relaxed/simple;
	bh=b2fwXB79lh648hWRmdzkCNo+wueq7FSM4rU53P45Fpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ms413jj4OXhcBM1z7ciM9u0myE3N6Zi1gucJ/fwtDfV0JwVgmVAYvTtBF9znRWPfqwmSJa5KNz/7dv0grDahuoDMFZwADtAOFEXV+EIrzOXhZ2ulmjkDp9SlkIzBtLR5ZDbLC/2puorndZSa1G10Ou2VG8QoDkmieUcz98MkrNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z/qNdeW1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z/qNdeW1"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B1Eb8e8018708;
	Mon, 2 Dec 2024 08:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fxEOWl+pF9H+TPIB1
	u0RcA7fohWLpjI43sHvTpb8qt4=; b=Z/qNdeW1gofwxI6550nITDLPJ574ZtZTI
	vb8pNpjuB0O9C+VyT4vska+5ZeGtWtAhzwh/U8KkRs7zQBA31Yd00QATdNDfwNOI
	6jVLqWH7ETWt75IfQiZUhEprKXC+dlHtejp2gQXpfrLF5FLFAo13zlZ8W0cbcKC9
	9JJRH5sOFj3zLWmfhM7AQNd5MUmxWe3E1d9SDM29mM992+sTdBZD0dez63AtIuRb
	ppsvMWDJCGSYHvrtQvFCDFI8zr9fW1Ug/uWEjc7+PLmi01xq3zHL2XJAXGlz+gf2
	ZjoNaEWFjYjvZarxPo/yJ1pmU2Na6r+VzCDpoKQiTr6ARigK9202g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 438kfgc0gb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 08:28:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B28S3Qb005278;
	Mon, 2 Dec 2024 08:28:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 438fr19v96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 08:28:07 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B28S3Ct33096240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Dec 2024 08:28:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B840B20043;
	Mon,  2 Dec 2024 08:28:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A6B920040;
	Mon,  2 Dec 2024 08:28:03 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Dec 2024 08:28:03 +0000 (GMT)
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
Subject: [RFC PATCH 3/4] mm/memory_hotplug: Add max_configurable sysfs read attribute
Date: Mon,  2 Dec 2024 09:27:31 +0100
Message-ID: <20241202082732.3959803-4-sumanthk@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: H14ztYqrnCyIw3sYL5zYSqhlBBOCiSmm
X-Proofpoint-GUID: H14ztYqrnCyIw3sYL5zYSqhlBBOCiSmm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 malwarescore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412020070

Introduce /sys/devices/system/memory/max_configurable sysfs interface to
list maximum number of configurable memory blocks by the architecture.
Using this information, lsmem tool could possibly read memory blocks
/sys/devices/system/memory/memory[0-9]+ as configured and list rest of
the max_configurable count as deconfigured.

Arch can define max_configurable by overriding
arch_get_memory_max_configurable().

s390 usecase:
/sys/devices/system/memory/max_configurable would be online + standby
memory blocks count. The max_configurable attribute for s390 is
configured in the next patch.

x86 possible usecase:
max_configurable could be initially set to count of all online memory
blocks. Later, max_configurable can be updated whenever there is an
acpi event generation for hotplugged memory. Userspace application like
lsmem could possibly read memory blocks
/sys/devices/system/memory/memory[0-9]+ as configured and rest of the
max_configurable count as deconfigured.

Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 drivers/base/memory.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 469adc7212fc..3da83345b570 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -665,6 +665,15 @@ bool __weak arch_validate_memory_range(unsigned long long start,
 	return false;
 }
 
+/*
+ * Arch can override the function and return the number of maximum configurable
+ * memory.
+ */
+ssize_t __weak arch_get_memory_max_configurable(void)
+{
+	return 0;
+}
+
 /*
  * Format:
  * echo config_mode,memoryrange,altmap_mode >
@@ -759,6 +768,15 @@ static ssize_t configure_memory_store(struct device *dev,
 	return ret ? ret : count;
 }
 static DEVICE_ATTR_WO(configure_memory);
+
+/*
+ * Show the maximum number of configurable memory.
+ */
+static ssize_t max_configurable_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%lu\n", arch_get_memory_max_configurable());
+}
+static DEVICE_ATTR_RO(max_configurable);
 #endif /* CONFIG_RUNTIME_MEMORY_CONFIGURATION */
 
 /*
@@ -1075,6 +1093,7 @@ static struct attribute *memory_root_attrs[] = {
 #endif
 #ifdef CONFIG_RUNTIME_MEMORY_CONFIGURATION
 	&dev_attr_configure_memory.attr,
+	&dev_attr_max_configurable.attr,
 #endif
 	NULL
 };
-- 
2.45.2

