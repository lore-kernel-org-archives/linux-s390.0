Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B011F9EB6;
	Mon,  2 Dec 2024 08:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733128088; cv=none; b=YafoikxsV4btBOWt+BmYaZuP9sXzgGuU9h0CbJ/WtlmFSiJLSvH8iMnoc3R67Y1FBj2uOHXrx8p2zOXyK4+6kmv8cdqFLkoEfZhupaa+lstU+JZh0Mz1/R8NpzqSQU8YXaUY0wm30zvHkUZtWC3MNIgk2aY7z3gU+Bu1nsTNKn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733128088; c=relaxed/simple;
	bh=omh02Qqp5XKw7wm7hUqTKB2lA0p66F9/vlR7aGGFk3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hAyFqhH7FgELQV5BpF88qtJxx+AlP2vRKGEia+Iv8saRT6E553BKjzX2bPyogUb54ZAfGMrsmsHRMksBq9I0iQBK5sWcZgNc1rCWPOyOkqZEB1YYNmZpZrsJm/psGg17BC7t4N7dsfkg36VLEOFi4SSTjgc0dGtjKxzidtOkQrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oL60V92d; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oL60V92d"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B1Ij4rp022972;
	Mon, 2 Dec 2024 08:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FckEokSgRioUHQRcH
	ayHqWILEETFnWG+x7hLq5rxsJM=; b=oL60V92dQozFG2No7T4TVJsetS9MWzWMA
	B6z7rIUjXXlwW4Qf/Qt3f/dv0mYRFpycgzw7Yxor//QlejQFgARLhoExIWAOqH1T
	hpJmz3axibcIQqYZlXzHJANaqshE9HoUMy4oLYgo0bAi+1Nhz/l42WIuLVEag57F
	8fUbnsBuiKXoAHJBMewEsUEHsRIsYDh3kyEamhMJvm/4jSVZMoh32WOM4xkCXCrm
	JCVgGxiQaPR7kb5/igIsjA8p2MW27OxK+ZciYHrzRbC27iqk7hSQ/GPCr6VDjU7w
	tIOrkOBFVmoaZp33DH7GQ+gExiaOsIIG2pUK+KtLwRkJtBiXa8Qyw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437r4p7pwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 08:28:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B27JolW007467;
	Mon, 2 Dec 2024 08:27:59 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 438f8j9wn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 08:27:59 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B28RuWD14287148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Dec 2024 08:27:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DECAB2004E;
	Mon,  2 Dec 2024 08:27:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A776B20040;
	Mon,  2 Dec 2024 08:27:55 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Dec 2024 08:27:55 +0000 (GMT)
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
Subject: [RFC PATCH 1/4] mm/memory_hotplug: Add interface for runtime (de)configuration of memory
Date: Mon,  2 Dec 2024 09:27:29 +0100
Message-ID: <20241202082732.3959803-2-sumanthk@linux.ibm.com>
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
X-Proofpoint-GUID: p1XxvKuTo3rCWRRzBvjFXhl2SyYkMdyS
X-Proofpoint-ORIG-GUID: p1XxvKuTo3rCWRRzBvjFXhl2SyYkMdyS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412020070

Provide a new interface for dynamic configuration and deconfiguration of
hotplug memory, allowing for mixed altmap and non-altmap support.  It is
a follow-up on the discussion with David:

https://lore.kernel.org/all/ee492da8-74b4-4a97-8b24-73e07257f01d@redhat.com/

As mentioned in the discussion, advantages of the new interface are:

* Users can dynamically specify which memory ranges should have altmap
  support, rather than having it statically enabled or disabled for all
  hot-plugged memory.

* In the long term,  user could specify a memory range, including
  multiple blocks, and whether user wants altmap support for that range.
  This could allow for the altmap block grouping, or even variable-sized
  blocks, in the future. i.e. "grouping" memory blocks that share a same
  altmap located on the first memory blocks in the group and reduce
  fragementation due to altmap.

To leverage these advantages:
Create a sysfs interface /sys/bus/memory/devices/configure_memory, which
performs runtime (de)configuration of memory with altmap or non-altmap
support. The interface validates the memory ranges against architecture
specific memory configuration and performs add_memory()/remove_memory().
Dynamic (de)configuration of memory is made configurable via config
CONFIG_RUNTIME_MEMORY_CONFIGURATION.

Usage format for the new interface:
echo config_mode,memoryrange,altmap_mode >
/sys/bus/memory/devices/configure_memory

E.g. to configure a range with altmap:
echo 1,0x200000000-0x20fffffff,1 > /sys/bus/memory/devices/configure_memory

This interface could not only help to make s390 more flexible and
similar to others (wrt adding hotplug memory in advance). It might also
be possible to provide the dynamically configured altmap support for
others. E.g.  instead of directly doing an add_memory() in the ACPI
handler, with the static altmap setting, one could instead defer that to
the new interface which allows dynamic altmap configuration.

Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 drivers/base/memory.c  | 124 +++++++++++++++++++++++++++++++++++++++++
 include/linux/memory.h |   6 ++
 mm/Kconfig             |  16 ++++++
 3 files changed, 146 insertions(+)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 67858eeb92ed..f024444b3301 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -631,6 +631,127 @@ int __weak arch_get_memory_phys_device(unsigned long start_pfn)
 	return 0;
 }
 
+#ifdef CONFIG_RUNTIME_MEMORY_CONFIGURATION
+enum {
+	REMOVE_MEMORY = 0,
+	ADD_MEMORY,
+	MAX_CONFIGURE_MODE
+};
+
+enum {
+	NOALTMAP = 0,
+	ALTMAP,
+	MAX_ALTMAP_MODE
+};
+
+/*
+ * Return true when the memory range is valid.
+ *
+ * Architecture specific code can override the below function and validate the
+ * memory range against its possible memory configurations.
+ */
+bool __weak arch_validate_memory_range(unsigned long long start,
+				       unsigned long long end)
+{
+	return false;
+}
+
+/*
+ * Format:
+ * echo config_mode,memoryrange,altmap_mode >
+ * /sys/bus/memory/devices/configure_memory
+ *
+ * config_mode:
+ *	value: 1 - add_memory, 0 - remove_memory
+ *
+ * range:
+ * 0x<start address>-0x<end address>
+ * Where start address is aligned to memory block size and end address
+ * represents last byte in the range.
+ * example: 0x200000000-0x20fffffff
+ *
+ * altmap_mode:
+ *	value: 1 - altmap support, 0 - no altmap support
+ */
+static ssize_t configure_memory_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	s64 start, end, block_size, range;
+	u32 config_mode, altmap_mode;
+	int num, nid, ret = -EINVAL;
+	struct memory_block *mem;
+
+	num = sscanf(buf, "%u,0x%llx-0x%llx,%u", &config_mode, &start, &end, &altmap_mode);
+	if (num != 4)
+		goto out;
+
+	if (config_mode >= MAX_CONFIGURE_MODE || altmap_mode >= MAX_ALTMAP_MODE)
+		goto out;
+
+	altmap_mode = altmap_mode ? MHP_MEMMAP_ON_MEMORY |
+			MHP_OFFLINE_INACCESSIBLE : MHP_NONE;
+
+	block_size = memory_block_size_bytes();
+
+	if (!IS_ALIGNED(start, block_size) || !IS_ALIGNED(end + 1, block_size))
+		goto out;
+
+	if (start < 0 || end < 0 || start >= end)
+		goto out;
+
+	if (!arch_validate_memory_range(start, end))
+		goto out;
+
+	ret = lock_device_hotplug_sysfs();
+	if (ret)
+		goto out;
+
+	if (config_mode == ADD_MEMORY) {
+		for (range = start; range < end + 1; range += block_size) {
+			mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(range)));
+			if (mem) {
+				pr_info("Memory already configured - (start:0x%llx)\n", range);
+				ret = -EEXIST;
+				put_device(&mem->dev);
+				goto out_unlock;
+			}
+			nid = memory_add_physaddr_to_nid(range);
+			ret = __add_memory(nid, range, block_size, altmap_mode);
+			if (ret) {
+				pr_info("Memory addition failed - (start:0x%llx)\n", range);
+				goto out_unlock;
+			}
+		}
+	} else if (config_mode == REMOVE_MEMORY) {
+		for (range = start; range < end + 1; range += block_size) {
+			mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(range)));
+			if (!mem) {
+				pr_info("Memory not configured - (start:0x%llx)\n", range);
+				ret = -EINVAL;
+				goto out_unlock;
+			}
+			if (mem->state != MEM_OFFLINE) {
+				pr_info("Memory removal failed - (start:0x%llx) not offline\n",
+					range);
+				put_device(&mem->dev);
+				ret = -EBUSY;
+				goto out_unlock;
+			} else {
+				/* drop the ref just got via find_memory_block() */
+				put_device(&mem->dev);
+			}
+			__remove_memory(range, block_size);
+		}
+	}
+out_unlock:
+	unlock_device_hotplug();
+out:
+	return ret ? ret : count;
+}
+static DEVICE_ATTR_WO(configure_memory);
+#endif /* CONFIG_RUNTIME_MEMORY_CONFIGURATION */
+
 /*
  * A reference for the returned memory block device is acquired.
  *
@@ -941,6 +1062,9 @@ static struct attribute *memory_root_attrs[] = {
 	&dev_attr_auto_online_blocks.attr,
 #ifdef CONFIG_CRASH_HOTPLUG
 	&dev_attr_crash_hotplug.attr,
+#endif
+#ifdef CONFIG_RUNTIME_MEMORY_CONFIGURATION
+	&dev_attr_configure_memory.attr,
 #endif
 	NULL
 };
diff --git a/include/linux/memory.h b/include/linux/memory.h
index c0afee5d126e..88b2b374bc44 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -85,6 +85,12 @@ struct memory_block {
 #endif
 };
 
+#ifdef CONFIG_RUNTIME_MEMORY_CONFIGURATION
+bool arch_validate_memory_range(unsigned long long start, unsigned long long end);
+ssize_t arch_get_memory_max_configurable(void);
+int memory_create_sysfs_max_configurable(void);
+#endif /* CONFIG_RUNTIME_MEMORY_CONFIGURATION */
+
 int arch_get_memory_phys_device(unsigned long start_pfn);
 unsigned long memory_block_size_bytes(void);
 int set_memory_block_size_order(unsigned int order);
diff --git a/mm/Kconfig b/mm/Kconfig
index 84000b016808..2aec2fc3fb25 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -576,6 +576,22 @@ config MHP_MEMMAP_ON_MEMORY
 	depends on MEMORY_HOTPLUG && SPARSEMEM_VMEMMAP
 	depends on ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
 
+config RUNTIME_MEMORY_CONFIGURATION
+	bool "Dynamic configuration and deconfiguration of memory"
+	def_bool n
+	depends on MEMORY_HOTPLUG && SPARSEMEM_VMEMMAP
+	help
+	  This option provides support to perform dynamic configuration and
+	  deconfiguration of memory with altmap or non-altmap support
+	  (/sys/bus/memory/devices/configure_memory). The interface validates
+	  the configuration and deconfiguration of memory ranges against
+	  architecture specific configuration and performs add_memory() with
+	  altmap or non-altmap support and remove_memory() respectively.
+
+	  Say Y here if the architecture supports validating dynamically
+	  (de)configured memory against architecture specific memory
+	  configurations.
+
 endif # MEMORY_HOTPLUG
 
 config ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
-- 
2.45.2

