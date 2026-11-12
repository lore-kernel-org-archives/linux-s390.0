Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482491;
	b=4VmnNg7SGjlMO6iu6uphje3BK8RIOJNzIE3nl6KAJ8+GD8ROy1nG8wh7FGmpozfuMKar
	 o9eMt5KIjveID+mvy9JH8/Pu+7rjZhoxhYauYUl8qeet7cnnJo/+412b1JgDlsqFmtvpI
	 lKCHjoo/EHaI1JCxXOyiZSAK+ZUJes1vrbwZM08hjz6u/8VNPD4VqNxeSD0/8kk0Md0vU
	 73SDjG+EuAn5FBJ1/kWU5MLTMPCoEjGXIiz7XCnFef5DkZFxpeIFgn91M+55QsdHEUsRZ
	 iHXwXplZmOODj4oLBrSPNkK7Fl9yRHZA+9KG9tc8dlava/8M7U60QbH+59RGcx1QN8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482491;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=dMQzlaOhC0NJ2jQZCEyAjAtCjP1I71c1fUfbkYQEpNg=;
	b=oQzbu/Z0UnpsJFH7hqLDacCjcaNHfkXtTjf6WSFpSZqPLtiO7af4ojI0g2H/P/oypITw
	 wVO5kGysUdJmk4ze/BdV/uNEsJZrdNGEnxbzTtzgLuTsKkAIFj93uk5RKggKVVU7H12N4
	 /E9O4FINT3hLwkfvymTGQPhZQbU/lwWU5ZETyF/r6vmqkW8hzVQY+G4yUYQI/U5GEK3BA
	 PNQJZx6y+UNZ7tXuPleDE/0ijfJJAqLP5etw7A97uuqDEvv1yFi7Q1wejYU25LjYSHMir
	 dQn3Pk/niWV+yD3GaXFFQXc0TYxcoAC3p7Tjopn5hmZKP6rCfbxaexfJYds1t5inJxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oJxqo34b;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF39460A383A;
	Thu, 12 Nov 2026 11:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF39460A383A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oJxqo34b
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2jP5n1218154;
	Thu, 12 Nov 2026 11:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=dMQzlaOhC0NJ2jQZCEyAjAtCjP1I71c1fUfbkYQEp
	Ng=; b=oJxqo34b781OhpL+tpyILzK+QUjLHY+82ILMNF5jzzVhd77cKlN8eTHle
	EkGhrC04kdA+YhkDWR49pihV5QgrR9/ItC148lHlnMFVC62NFBMZmBZ/6Xqz3fEV
	dZ9j2ZRMVySiB687+FJVNbR7z0p0Lo/O7SC8lwFD3v6wywqG1/rEEVJXY2Rhnrph
	uT0TrnxEXZpsChswueRQy7behRRJw78C4b1aFrkgJ2jVN7lHg4KupnAXFLrvhPmJ
	nkBzACiRvVHi5UgIDbcQROFfJhsIhVoTeEYkKmQ11W60l9AMzx2sZPsMOKHIvFRJ
	MOY1m1AmUPyEmfLLkbIVIGaoTtSsg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuntf68k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 11:21:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC8FvOt106626;
	Thu, 12 Nov 2026 11:21:09 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hv4nt05mh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 11:21:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ACBL5Zd31392246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 11:21:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F4DC2004B;
	Thu, 12 Nov 2026 11:21:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FAA020043;
	Thu, 12 Nov 2026 11:21:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Nov 2026 11:21:05 +0000 (GMT)
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Dave Young <ruirui.yang@linux.dev>, Jiri Bohac <jbohac@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>, Usama Arif <usama.arif@linux.dev>,
        linux-s390@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/8] s390/kdump: Add crashkernel CMA support
Date: Thu, 12 Nov 2026 12:20:57 +0100
Message-ID: <20261112112105.1169118-1-zaslonko@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0NCBTYWx0ZWRfXxfg+s85PnR5B
 Ek8l8Pe0rogT2619BuqATwmnogWLxm3b0nbd38K0s66W1WqsxycVm/wpBXliyJAiLo2RN4t0Yfo
 4f3iJmc80+UGo4wR/7Alrh6R7FzcEwFH74s54dEfnhovo3hGgc0RnRHXxKh6padnOn07AbwL1ZX
 gjl458wXZWUvYBwYsf/XcaKtZVbY6IwKhXd71PylWXo4fppB+CdpgRneTj1a0Hh3A29uybnkYOr
 fVyE6VqYoOIbITw49kR1tSbmNipHini+lOdTFhpMr4voA6dDbkpDxa2LBHNJbqv0+XynfF48Iuk
 ruoegp/sJpDMrFM9jDJNLE540yOLLxgGPsOQITViqAjpNvuEdiJuNS33J8Ff4QpMs4SysXRX7qw
 8ToSKHVDyQV2W8QHqtZ9Qx9Qi100AxLw+kDG1uvBjdt6s4d87Tr2rj2ARzJVi1scwzMciVHZKj5
 S9v/4p0U9WiM77Sa3GA==
X-Proofpoint-ORIG-GUID: EamHxN_Cq4HCc-6renuVCVV03ROzoTwg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0NCBTYWx0ZWRfXxWMKw6hdfaS5
 VDEFaFVKXhx3nRSgjyS1wHZpAxTkrfJKtgwjw+iq+p7gHQX+V3SNc5xn2y+Ht7NrDOf/PwdWX/U
 OxBzXLz2PFyinRChIj4QZWgZ26c0C4k=
X-Authority-Analysis: v=2.4 cv=euZKXYpX c=1 sm=1 tr=0 ts=6af5a126 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=jh6tBn02ksXXyNAtQEMA:9
X-Proofpoint-GUID: EamHxN_Cq4HCc-6renuVCVV03ROzoTwg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120044

This series adds support for crashkernel=size,cma on s390, as already
available on x86, arm64, riscv and powerpc. In addition to the regular
crashkernel reservation, CMA memory is reserved. The production kernel
uses it for movable allocations, and the kdump kernel uses it as
additional memory. The regular reservation then only needs to hold the
kdump kernel and its initrd.

On s390 the kdump kernel runs in the crashkernel memory, which is
swapped to address 0, and its decompressor limits usable memory to the
crashkernel size. All other memory belongs to the crashed kernel and
makes up the dump. To use the CMA memory, the kdump kernel has to know
where it is, and the decompressor has to handle usable memory above
that limit.

Patches 1-3 reserve the CMA memory with the generic
reserve_crashkernel_cma() and store the ranges in the parmarea of a
kdump kernel loaded with kexec_file_load(). They use 64 of the 72
padding bytes before the command line, enough for the four ranges the
generic code reserves at most. Kernel images have this area zeroed, so
older and newer kernels keep working together, just without CMA memory
for kdump. kexec_load() needs a matching kexec-tools change, which can
read the ranges from /sys/kernel/kexec_crash_cma_ranges.

Patch 4 replaces the decompressor's usable memory limit with a small
sorted array of usable ranges, physmem_info.usable[]. The iterator
returns their intersection with online memory, and the boot allocator
walks only these ranges, top-down from ident_map_size. The identity
mapping, the KASAN shadow and memblock use the same iterator. A normal
boot has a single range from 0 to ident_map_size and behaves as before.

Patch 5 excludes the CMA ranges from /proc/vmcore. They are kept in
oldmem_data and added to oldmem_type next to the crashkernel memory, so
no PT_LOAD headers are created for them.

Patch 6 lets the kdump kernel use the CMA memory. If the parmarea
contains CMA ranges, the decompressor does not limit ident_map_size to
the crashkernel size and adds the crashkernel memory and the CMA ranges
as usable ranges. All other memory up to ident_map_size is treated as
a memory hole. The CMA memory is then mapped, added to memblock and
freed to the buddy allocator like any other memory. Boot allocations can
use it as well: page tables, the KASAN shadow and the initrd.

Patch 7 skips the generic 10 second wait for pending DMA before the
kdump kernel is started. s390 does not need it, as s390_reset_system()
terminates all in-flight I/O before the kdump kernel starts. The patch
makes the timeout overridable in kernel/crash_core.c and sets it to 0
on s390. It is the only patch in the series that touches generic code.

Patch 8 updates the documentation.

Without ",cma", the behavior is the same as before: the decompressor
has a single usable range, and a kdump kernel uses only the crashkernel
memory.

Tested on a 32G z/VM guest and on a 64G LPAR:
- crashkernel=82M crashkernel=1G,cma: the kdump kernel has ~1.1G of
  memory and writes a dump that contains all memory except the
  crashkernel and CMA ranges. With crashkernel=128M alone, the same
  kdump kernel and initrd run out of memory.
- 26G of CMA in four ranges (z/VM, with the two generic fixes below):
  same result.
- With ",cma", the kdump kernel starts without the 10 second wait.
- Without ",cma": same memory layout and dump as before.

Two generic crashkernel CMA fixes are queued in kexec-next. This series
applies without them, but both problems show up on s390:
- kdump: Give crashkernel CMA areas unique names [1]
  When the reservation is split into several CMA areas, the CMA sysfs
  setup fails, and debugfs shows only the first crashkernel area.
- crash: keep crashkernel CMA pages reserved if activation fails [2]
  A CMA area that crosses a zone boundary fails to activate, and its
  pages go to the buddy allocator although the kdump kernel still uses
  that memory. On s390 ZONE_DMA ends at 2G so this can happen when an
  area does not fit above 4G.

Usama Arif's hugetlb CMA v2 [3] changes reserve_crashkernel_cma() for
all architectures. This series needs to adapt the s390 call in patch 2
if hugetlb CMA patch goes in.

[1] https://lore.kernel.org/lkml/20261106104309.3669583-1-zaslonko@linux.ibm.com/
[2] https://lore.kernel.org/lkml/20261104145600.3708886-1-usama.arif@linux.dev/
[3] https://lore.kernel.org/r/20261106165142.2847916-1-usama.arif@linux.dev/

Mikhail Zaslonko (8):
  s390/kdump: Enable crashkernel CMA infrastructure
  s390/kdump: Reserve crashkernel CMA memory
  s390/kexec: Pass crashkernel CMA ranges to the kdump kernel
  s390/boot: Allow additional usable memory ranges
  s390/kdump: Exclude crashkernel CMA memory from vmcore
  s390/kdump: Use crashkernel CMA memory in the kdump kernel
  s390/kdump: Skip the crashkernel CMA DMA wait
  Documentation: kdump: Add s390 to crashkernel CMA

 Documentation/admin-guide/kdump/kdump.rst     |  3 +
 .../admin-guide/kernel-parameters.txt         |  4 +-
 arch/s390/Kconfig                             |  3 +
 arch/s390/boot/boot.h                         |  3 +-
 arch/s390/boot/kaslr.c                        |  4 +-
 arch/s390/boot/physmem_info.c                 | 65 ++++++++++++++++---
 arch/s390/boot/startup.c                      | 30 +++++++--
 arch/s390/boot/vmem.c                         |  7 +-
 arch/s390/include/asm/crash_reserve.h         | 24 +++++++
 arch/s390/include/asm/kexec.h                 |  3 +
 arch/s390/include/asm/physmem_info.h          | 63 +++++++++++++-----
 arch/s390/include/asm/setup.h                 | 10 ++-
 arch/s390/kernel/crash_dump.c                 | 48 +++++++++++---
 arch/s390/kernel/machine_kexec_file.c         |  5 ++
 arch/s390/kernel/setup.c                      | 17 ++++-
 kernel/crash_core.c                           |  2 +
 16 files changed, 241 insertions(+), 50 deletions(-)
 create mode 100644 arch/s390/include/asm/crash_reserve.h


base-commit: 067c5c24cef23d913b67eaaf71ae67e7169a6620
-- 
2.55.0

