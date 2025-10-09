Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9482E7F1A;
	Thu,  9 Oct 2025 13:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760015949; cv=none; b=WSjzaUP0X3MqADS/pLkidN3CLf9Veq2UfyrZJ/7bPfe+5hpLR/VVROJVp4/579bder35xvnjJE001PQGiP5gPamUfgyxvzd3CcxL03KeB2jDWOR+bLrB39fBBWSiSmscdnUGUD9uEz6qjmS5xaGqzEId950KRTTfKQd8fKoEbHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760015949; c=relaxed/simple;
	bh=lFY2RoSNVcE833H3YFHmV7HopjRXKQkaoiifdIhZDHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hn+WL/cRxwGRdrv1bg5ELfhQDnPUKaN36Ut3MRYZLrK9Oc7G0lksTzMLF369a3Uqi2NXUPQgSJqYLMYD+CFoG55w5IrZq0UzcOQN7RSzm0bgoROYnoIFQRXvqKZPyu5OGQUUwD5WDaB6exbCDb0DiQ0LfPK+ptkDMpxJQDEn7eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e/92wk8E; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e/92wk8E"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5998lWlP016972;
	Thu, 9 Oct 2025 13:19:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ixhYVe2pc24hkcGpvIynsZsPtOkzbOJtj+sEGOBtO
	VA=; b=e/92wk8EizfNUB5hKsSXnyusLPJh3QopLivdUingxc1EaJ53+7J2cKeiO
	2EEnRv7Ho15SmAxH9CQ19yhsyydB1p3ze0DLX14p5H7qGisNdcX/yulFwy9IOC8x
	2L2jSHMoGD9u3HqOAZsuq3g74Iw+zdBtcXLByw9OmCKiHrMwkcNFBxGk3EPRwa2i
	GsHpTVRp6psWJUunxr7iihSlkytHrZQWyOZLZTBZPw7Bo1wGAjwGqQQ64HFB+U7L
	30fYvbO+FjFUtlvzVn3gmP6+QXNr035xybuoVHQmbnmWTBdUtfvkPDdwBshoRHyL
	6Py62uS/fyjyohW13Jev3sUCgOtFQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv84mw9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 13:19:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 599CJrJr008366;
	Thu, 9 Oct 2025 13:18:59 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49nvanvmyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 13:18:59 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 599DItLl41812450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Oct 2025 13:18:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D61B20043;
	Thu,  9 Oct 2025 13:18:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44FEA20040;
	Thu,  9 Oct 2025 13:18:55 +0000 (GMT)
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
Subject: [PATCH v2 0/4] Support dynamic (de)configuration of memory
Date: Thu,  9 Oct 2025 15:18:35 +0200
Message-ID: <20251009131839.3739108-1-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HKPO14tv c=1 sm=1 tr=0 ts=68e7b644 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=NBdnYRyKUmeqgR0V3jUA:9 a=HhbK4dLum7pmb74im6QT:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-GUID: 12N06D22HleIoDqnjz0piqRpAPAO5LuX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX9QgSusyJRrUt
 dqQWQCpg6E/kbpqdjFHFojNYQIwBcug7t7Q4SYReiVbs3uE2bGD/zoSqZk6wJhIbclOJ4UWONt+
 uPEgp7MAs3Gk/AD530zh7AGw4NCKW2Ixt5HVr2QRo+U0k9ObwAS8qQykBOkTAwVN24ani9o9isl
 0HNYd9rnJU+Diu1mx7HyOGrfNsBM10uHQppVnncxA5qxvlk1n8uOk1k6GR1/oevkLfkC+0CJqYh
 BvMQEMS7NxBNpSaorkJANi1etGgCtDBGNpz9aI8sxBoYB17EL/PIbZnpRbDwz0it/gfnGyFHcQY
 MV7FerlZ6iy+RNVSxoZKVpMKjbafmFn6J19LKy+Hdwe20j2Bov3MS/vENqCP1N+cJXVgA4kxvzm
 fCqAK31D7sNPKSbgJG18/TaWvGwIWg==
X-Proofpoint-ORIG-GUID: 12N06D22HleIoDqnjz0piqRpAPAO5LuX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

Hi,

Patchset provides a new interface for dynamic configuration and
deconfiguration of hotplug memory on s390, allowing with/without
memmap_on_memory support. It is a follow up on the discussion with David
when introducing memmap_on_memory support for s390 and support dynamic
(de)configuration of memory:
https://lore.kernel.org/all/ee492da8-74b4-4a97-8b24-73e07257f01d@redhat.com/
https://lore.kernel.org/all/20241202082732.3959803-1-sumanthk@linux.ibm.com/

The original motivation for introducing memmap_on_memory on s390 was to
avoid using online memory to store struct pages metadata, particularly
for standby memory blocks. This became critical in cases where there was
an imbalance between standby and online memory, potentially leading to
boot failures due to insufficient memory for metadata allocation.

To address this, memmap_on_memory was utilized on s390. However, in its
current form, it adds struct pages metadata at the start of each memory
block at the time of addition (only standby memory), and this
configuration is static. It cannot be changed at runtime  (When the user
needs continuous physical memory).

Inorder to provide more flexibility to the user and overcome the above
limitation, add an option to dynamically configure and deconfigure
hotpluggable memory block with/without memmap_on_memory.

With the new interface, s390 will not add all possible hotplug memory in
advance, like before, to make it visible in sysfs for online/offline
actions. Instead, before memory block can be set online, it has to be
configured via a new interface in /sys/firmware/memory/memoryX/config,
which makes s390 similar to others.  i.e. Adding of hotpluggable memory is
controlled by the user instead of adding it at boottime.

s390 kernel sysfs interface to configure/deconfigure memory with
memmap_on_memory (with upcoming lsmem changes):

* Initial memory layout:
lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP_ON_MEMORY
RANGE                 SIZE   STATE BLOCK CONFIGURED MEMMAP_ON_MEMORY
0x00000000-0x7fffffff   2G  online 0-15  yes        no
0x80000000-0xffffffff   2G offline 16-31 no         yes

* Configure memory
echo 1 > /sys/firmware/memory/memory16/config
lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP_ON_MEMORY
RANGE                  SIZE  STATE   BLOCK CONFIGURED MEMMAP_ON_MEMORY
0x00000000-0x7fffffff    2G  online  0-15  yes        no
0x80000000-0x87ffffff  128M offline    16  yes        yes
0x88000000-0xffffffff  1.9G offline 17-31  no         yes

* Deconfigure memory
echo 0 > /sys/firmware/memory/memory16/config
lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP_ON_MEMORY
RANGE                 SIZE   STATE BLOCK CONFIGURED MEMMAP_ON_MEMORY
0x00000000-0x7fffffff   2G  online 0-15  yes        no
0x80000000-0xffffffff   2G offline 16-31 no         yes

* Enable memmap_on_memory and online it.
(Deconfigure first)
echo 0 > /sys/devices/system/memory/memory5/online
echo 0 > /sys/firmware/memory/memory5/config

lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP_ON_MEMORY
RANGE                  SIZE  STATE  BLOCK CONFIGURED MEMMAP_ON_MEMORY
0x00000000-0x27ffffff  640M  online 0-4   yes        no
0x28000000-0x2fffffff  128M offline 5     no         no
0x30000000-0x7fffffff  1.3G  online 6-15  yes        no
0x80000000-0xffffffff    2G offline 16-31 no         yes

(Enable memmap_on_memory and online it)
echo 1 > /sys/firmware/memory/memory5/memmap_on_memory
echo 1 > /sys/firmware/memory/memory5/config
echo 1 > /sys/devices/system/memory/memory5/online

lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP_ON_MEMORY
RANGE                  SIZE  STATE   BLOCK CONFIGURED MEMMAP_ON_MEMORY
0x00000000-0x27ffffff  640M  online  0-4   yes        no
0x28000000-0x2fffffff  128M  online  5     yes        yes
0x30000000-0x7fffffff  1.3G  online  6-15  yes        no
0x80000000-0xffffffff    2G  offline 16-31 no         yes

* Disable memmap_on_memory and online it.
(Deconfigure first)
echo 0 > /sys/devices/system/memory/memory5/online
echo 0 > /sys/firmware/memory/memory5/config

lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP_ON_MEMORY
RANGE                  SIZE  STATE  BLOCK CONFIGURED MEMMAP_ON_MEMORY
0x00000000-0x27ffffff  640M  online 0-4   yes        no
0x28000000-0x2fffffff  128M offline 5     no         yes
0x30000000-0x7fffffff  1.3G  online 6-15  yes        no
0x80000000-0xffffffff    2G offline 16-31 no         yes

(Disable memmap_on_memory and online it)
echo 0 > /sys/firmware/memory/memory5/memmap_on_memory
echo 1 > /sys/firmware/memory/memory5/config
echo 1 > /sys/devices/system/memory/memory5/online

lsmem -o RANGE,SIZE,STATE,BLOCK,CONFIGURED,MEMMAP_ON_MEMORY
RANGE                  SIZE  STATE   BLOCK CONFIGURED MEMMAP_ON_MEMORY
0x00000000-0x7fffffff  2G    online  0-15  yes        no
0x80000000-0xffffffff  2G    offline 16-31 no         yes

* Userspace changes:
lsmem/chmem tool is also changed to use the new interface. I will send
it to util-linux soon.

Patch 1 adds support for removal of boot-allocated memory blocks.

Patch 2 provides option to dynamically configure and deconfigure memory
with/without memmap_on_memory.

Patch 3 removes MHP_OFFLINE_INACCESSIBLE from s390. The mhp flag was
used to mark memory as not accessible until memory hotplug online phase
begins.  However, with patch 2, it is no longer essential. Memory can be
brought to accessible state before adding memory, as the memory is added
during runttime now instead of boottime.

Patch 4 removes the MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers. It
is no longer needed.  Memory can be brought to accessible state before
adding memory now, with runtime (de)configuration of memory.

Note: The patches apply to the linux-next branch.

v2:
Thanks David
* Rename struct mblock/mblock_arg with struct sclp_mem/sclp_mem_arg.
* Rename all mblocks/mblock references with sclp_mems/sclp_mem -
  structures, functions.
* Rename create_online_mblock() with create_configured_sclp_mem().
* Rename config_mblock_show()/config_mblock_store() with
  config_sclp_mem_show()/config_sclp_mem_store().
* Remove contains_standby_increment() and
  sclp_mem_notifier. sclp mem state change is performed when
  adding/removing memory. sclp memory notifier - no longer needed with
  this patchset.
* Recover sclp mem state when add_memory() fails.
* Refactor and add function init_sclp_mem().
* Use unsigned long instead of unsigned long long.
* Simplify and correct kobj handling. Thanks Heiko.

Sumanth Korikkar (4):
  s390/mm: Support removal of boot-allocated virtual memory map
  s390/sclp: Add support for dynamic (de)configuration of memory
  s390/sclp: Remove MHP_OFFLINE_INACCESSIBLE
  mm/memory_hotplug: Remove MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE
    notifiers

 arch/s390/mm/pgalloc.c         |   2 +
 arch/s390/mm/vmem.c            |  21 ++-
 drivers/base/memory.c          |  23 +--
 drivers/s390/char/sclp_mem.c   | 290 +++++++++++++++++++++++----------
 include/linux/memory.h         |   9 -
 include/linux/memory_hotplug.h |  18 +-
 include/linux/memremap.h       |   1 -
 mm/memory_hotplug.c            |  17 +-
 mm/sparse.c                    |   3 +-
 9 files changed, 227 insertions(+), 157 deletions(-)

-- 
2.48.1

