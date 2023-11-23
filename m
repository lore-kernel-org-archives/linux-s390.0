Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MMqmQcUE"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B10D40;
	Thu, 23 Nov 2023 01:24:11 -0800 (PST)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AN9MF1G014965;
	Thu, 23 Nov 2023 09:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=2nTcOC+LtQ42Ngx+YJj6RSKwsOPJ/n2gnSCL32HIqAQ=;
 b=MMqmQcUEZq79rIyC7vsBKFqaFf3M7c4cZpEceXMMlSS50pta03iQHIekfddqP3eQMDB9
 iWoLvqFPakNPId4NjyX0e9afz3u9TBkQYFRwrYNFGyMrpohk8cp5//K29Jo7UPF6/ovX
 tZ/xYBPGKE1EcowoOHD4C1TuMufdZPSc/xi1yI5lw9gdUZka9Q4VdEUILgpMSffSyzhW
 /pLYtDnAePvozGR3zKvh/wUA7WuT2hW4kIHzotjI4mB7ML/YV9L9U3hiQVxTZsOPIk17
 aIW/10jOJJpXXv3DoAxZ2Xrg+PrE8V/aGMivQYr6y9AIWigQKUUvGUTIXcmXQRyqhfb9 Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uj41vr1ba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Nov 2023 09:24:00 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AN9O0V4020253;
	Thu, 23 Nov 2023 09:24:00 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uj41vr1ag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Nov 2023 09:24:00 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AN8n9wo019195;
	Thu, 23 Nov 2023 09:23:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf7yyxcmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Nov 2023 09:23:58 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AN9NtSW22872598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Nov 2023 09:23:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBA3D20043;
	Thu, 23 Nov 2023 09:23:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B66F20040;
	Thu, 23 Nov 2023 09:23:55 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Nov 2023 09:23:55 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/7] implement "memmap on memory" feature on s390
Date: Thu, 23 Nov 2023 10:23:36 +0100
Message-Id: <20231123092343.1703707-1-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zuuuXLAf8N_7b7qftGG7aPIAUwD0EFUz
X-Proofpoint-GUID: _5e-FcvAdXYXVfLL24ZRFjV4C388n41j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_07,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=2 spamscore=2
 lowpriorityscore=0 mlxscore=2 phishscore=0 mlxlogscore=167 clxscore=1015
 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311230067

Hi All,

The patch series implements "memmap on memory" feature on s390.

Patch 1 introduces new mhp_flag MHP_OFFLINE_INACCESSIBLE to mark
memory as not accessible until memory hotplug online phase begins.

Patch 2 avoids page_init_poison() on memmap during mhp addition phase,
when mhp_flag MHP_OFFLINE_INACCESSIBLE is passed over from add_memory()

Patch 3 introduces  MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE memory
notifiers to prepare the transition of memory to and from a physically
accessible state. This enhancement is crucial for implementing the
"memmap on memory" feature for s390 in a subsequent patch.

Patches 4 allocates vmemmap pages from self-contained memory range for
s390. It allocates memory map (struct pages array) from the hotplugged
memory range, rather than using system memory by passing altmap to
vmemmap functions.

Patch 5 removes unhandled memory notifier types on s390.

Patch 6 implements MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE memory
notifiers on s390. MEM_PREPARE_ONLINE memory notifier makes memory block
physical accessible via sclp assign command. The notifier ensures
self-contained memory maps are accessible and hence enabling the "memmap
on memory" on s390. MEM_FINISH_OFFLINE memory notifier shifts the memory
block to an inaccessible state via sclp unassign command

Patch 7 finally enables MHP_MEMMAP_ON_MEMORY on s390

These patches are rebased on top of three fixes:
mm: use vmem_altmap code without CONFIG_ZONE_DEVICE
mm/memory_hotplug: fix error handling in add_memory_resource()
mm/memory_hotplug: add missing mem_hotplug_lock

v2:
* Fixes are integrated and hence removed from this patch series
Suggestions from David:
* Add new flag MHP_OFFLINE_INACCESSIBLE to avoid accessing memory
  during memory hotplug addition phase.
* Avoid page_init_poison() on memmap during mhp addition phase, when
  MHP_OFFLINE_INACCESSIBLE mhp_flag is passed in add_memory().
* Do not skip add_pages() in arch_add_memory(). Similarly, remove
  similar hacks in arch_remove_memory(). 
* Use MHP_PREPARE_ONLINE/MHP_FINISH_OFFLINE naming convention for
  new memory notifiers.
* Rearrange removal of unused s390 memory notifier.
* Necessary commit messages changes.

Thank you

Sumanth Korikkar (7):
  mm/memory_hotplug: introduce mhp_flag MHP_OFFLINE_INACCESSIBLE
  mm/memory_hotplug: avoid poisoning memmap during mhp addition phase
  mm/memory_hotplug: introduce MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE
    notifiers
  s390/mm: allocate vmemmap pages from self-contained memory range
  s390/sclp: remove unhandled memory notifier type
  s390/mm: implement MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers
  s390: enable MHP_MEMMAP_ON_MEMORY

 arch/s390/Kconfig              |  1 +
 arch/s390/mm/init.c            |  3 --
 arch/s390/mm/vmem.c            | 62 +++++++++++++++++++---------------
 drivers/base/memory.c          | 23 +++++++++++--
 drivers/s390/char/sclp_cmd.c   | 31 ++++++++++++-----
 include/linux/memory.h         |  3 ++
 include/linux/memory_hotplug.h | 12 ++++++-
 include/linux/memremap.h       |  1 +
 mm/memory_hotplug.c            | 30 ++++++++++++++--
 mm/sparse.c                    |  3 +-
 10 files changed, 124 insertions(+), 45 deletions(-)

-- 
2.39.2

