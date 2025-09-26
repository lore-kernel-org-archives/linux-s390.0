Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47EC2F60B6;
	Fri, 26 Sep 2025 13:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892556; cv=none; b=AHIL7ffWw/UzMOe9SjgRNP5vr8GD2k2jSz9Kw0FQJsSryihc3Y1XbXNNSdhJMVf0TKKKvWPpsnnIDgL2JjBWJLyNlAqT+Q61bhS6FAdHysccHSo+L0ltrBgYB4rkZfQxGLsrnHnt6BvH+6j5FybLfE9Dj4PXeM12OZ8F/4X0Z9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892556; c=relaxed/simple;
	bh=uR7y+Uud4T3zE4XNetZ/rqGEDRGDvYymrj7Dcbsi+Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UNKlIH/nilMGuKlJRf0e1Z2gqH3EeB6XUAcaIiivRUZGnZ3VLLdCB+UOLtJVjl2X/O0GdQaPvXQ8cmlwFBechTF47RH9kwADCusJlF8Fvib1uy8TtJ89cpmMvTiY+VU5SgQNFl25rNkecrpa3yTDDQnLpCS9iiyUjA3XvQK6wQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e0sqFLkx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e0sqFLkx"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q776Kc029549;
	Fri, 26 Sep 2025 13:15:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=GxwYV887bhAtP2V1Q1mrwuIyi4ZllWeV5OYTH7iA8
	9U=; b=e0sqFLkxn2TGWc5W3y+mvgSDp3rIp5FTBaa79vsR4PFWAgSKYrcEMuo8j
	j3UD1fKLQp14O86a5IZbXfgzvjR9s3vxIeyF/ZHHdTpb9Py+huTYh31Aw/NqzKiV
	JZDooQhChJSgoy4Zo0mjNWHnBZW9BLPUegBhoNh0F3fgJzANdJrvhHJ7xfHMoRjO
	yCPGzIt9c5VaZykHmV+OKQv2KrTcCIW7uwHQsHVhWC6GA+v1a65c0K7nIgCWLL7E
	ORZq0/qyuwNeK8HyoM3bfcNtolkPtSiOb4keFIzsoUpgHIpKSOfR5wviiEwkw5Wt
	o3CfZSAidn/AGEvukV0dxvCvP/n8w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49dbb3vmq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 13:15:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58QAGNVL025803;
	Fri, 26 Sep 2025 13:15:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49dawpv5nc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 13:15:45 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58QDFfVQ25624920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Sep 2025 13:15:41 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BB422004D;
	Fri, 26 Sep 2025 13:15:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3761B20043;
	Fri, 26 Sep 2025 13:15:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Sep 2025 13:15:41 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, linux-mm <linux-mm@kvack.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH 0/4] Support dynamic (de)configuration of memory
Date: Fri, 26 Sep 2025 15:15:23 +0200
Message-ID: <20250926131527.3260733-1-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3NCBTYWx0ZWRfXxef9708wXX71
 JajduGF3MoAWGFq2gnHthxOhalzc8WnU9S28cm98fiztZK75qP4+qfgMuXWlayhk0IlDX9A52fi
 rNBPXHt7CzzIcu0TONWFmpRp4sw40zwekAdKlaqCAtQP7N1HYSoruqu1TXd5SBD+XinTK0fFsgM
 b2Nayq8BjATzlZh9M2dDBut1+zXA4dY363D/EjCQ9Lhb3kf9NbURKlvUxT+GnhK+QHsnTIKuxIR
 0Fe2CVS7LeYFYXpwtjQPsMdF3nH3ezUyEwzft9FHAKew0Xpx4/kbwVPcW1xt9lqj8KdQuc1SbvU
 Xqolu3knuxTC6DxUYJGuKCpqTmhFOTiqE1p7GqgPRJuCUMxIhV5grqNhVg8wXieKwE7AvSevWJQ
 9FOqKrUFcwV0/aoRjQAbMIt7MsYnwg==
X-Proofpoint-GUID: jdJo1Lvmskf3bMY4Td5P14C-JR5f_Ad2
X-Authority-Analysis: v=2.4 cv=T/qBjvKQ c=1 sm=1 tr=0 ts=68d69203 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=CfBYPdr6hCx0bjMEc4cA:9 a=HhbK4dLum7pmb74im6QT:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-ORIG-GUID: jdJo1Lvmskf3bMY4Td5P14C-JR5f_Ad2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_03,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250174

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

Thank you

Sumanth Korikkar (4):
  s390/mm: Support removal of boot-allocated virtual memory map
  s390/sclp: Add support for dynamic (de)configuration of memory
  s390/sclp: Remove MHP_OFFLINE_INACCESSIBLE
  mm/memory_hotplug: Remove MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE
    notifiers

 arch/s390/mm/pgalloc.c         |   2 +
 arch/s390/mm/vmem.c            |  21 ++-
 drivers/base/memory.c          |  23 +--
 drivers/s390/char/sclp_mem.c   | 291 +++++++++++++++++++++++++++------
 include/linux/memory.h         |   9 -
 include/linux/memory_hotplug.h |  18 +-
 include/linux/memremap.h       |   1 -
 mm/memory_hotplug.c            |  17 +-
 mm/sparse.c                    |   3 +-
 9 files changed, 261 insertions(+), 124 deletions(-)

-- 
2.48.1

