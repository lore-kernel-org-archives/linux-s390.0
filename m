Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2A81F9AAD;
	Mon,  2 Dec 2024 08:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733128086; cv=none; b=cCu9vRRaumZQ6ECCLwkAPGs4gZk4VXjQq2dL151e3lJBdenud2vpqyL+rW3+YRx+y+kJQYr0Yl4j2BZAFZRUHSK9gHoIFKuiJySNfyQLvnhGGG8kT9uuSNmANqQ8Q8dOTsSATqGafNZhAyRf3rTEuG8Teu9MZFo6CMWr/XJHfI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733128086; c=relaxed/simple;
	bh=jgncwBFw+nAZ7FP7lNL8o3Xsn2iuPgfKqTUh8xtE4h4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XOCn/bMNX86O15X9Zb5KI4nz4fRoZNMU7odZ+xbe6kTFaNiHhi8VAmBFeveKkHRTsoQFrquCXAxkDeCoRNVnZ4d0b6QjYsgQ4XiJVhw2F3gUlndVcVsLBnKYKDYvgz+dbImPFGG0zPw+wPgPTa4LFG/ATsXOQjBELkUV6Wmxa7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fZSdml5a; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fZSdml5a"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B1Ji0Cs030566;
	Mon, 2 Dec 2024 08:27:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=boD7gr6wETUVAOdp7AcuGDr9AoLg9R0LORT1dyV81
	TI=; b=fZSdml5a+jVYA7nc57cAiSGnRz0mHal2xc9CB0BGlXpn3g5SxJvBvz4kx
	Kw4B9r4him1uEsENqu3x/9w5aCVALajNQ436w9XJ+SP7FqX6xCC6ARB8k1IEaDt5
	9qr0X1sHRcTb7DR51LJHl+Uk2UOABZqqVfhR3isaKERk9lmeXrdloVIJQjsA3j5U
	lYYIPLttdZmeZfpriknlNe8Hft76tmIaUfTvIE2/IoiDqHCHNVvcPNM0NvkHLbTC
	AZstdr5I0cWm104QXyLR/p2tgi95wjm6C4yR5JUgEYXUP3teaSm0FpFM8b6dMxD/
	kmMfSLIIUqExHrnLZQe8UiFK1iW/Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437tbx7byt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 08:27:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B271aPw007202;
	Mon, 2 Dec 2024 08:27:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 438ehkb62a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 08:27:50 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B28Rl6R44761598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Dec 2024 08:27:47 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08CEE20043;
	Mon,  2 Dec 2024 08:27:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE07A20040;
	Mon,  2 Dec 2024 08:27:46 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Dec 2024 08:27:46 +0000 (GMT)
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
Subject: [RFC PATCH 0/4] Support dynamic (de)configuration of memory
Date: Mon,  2 Dec 2024 09:27:28 +0100
Message-ID: <20241202082732.3959803-1-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: V8g67JSdf12o8H9oVTCxxT37KzH761ZO
X-Proofpoint-GUID: V8g67JSdf12o8H9oVTCxxT37KzH761ZO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=830 priorityscore=1501 bulkscore=0
 phishscore=0 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412020070

This patchset provides a new interface for dynamic configuration and
deconfiguration of hotplug memory, allowing for mixed altmap and
non-altmap support. It is a follow-up on the discussion with David,
when introducing memmap_on_memory support for s390:
https://lore.kernel.org/all/ee492da8-74b4-4a97-8b24-73e07257f01d@redhat.com/

The following suggestions from that discussion are addressed:

* "Look into a proper interface to add/remove memory instead of relying
  on online/offline ... (e.g., where user don't want an altmap because
  of fragmentation)"

With the new interface, users can dynamically specify which memory
ranges should have altmap support, rather than having it statically
enabled or disabled for all hot-plugged memory.

It would also be possible to revert the
MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers, that were previously
added for s390, and move that part to the new interface handler. This is
not yet done in this series, and might also need further evaluation,
e.g. we would lose the memmap_on_memory feature for s390, when the new
interface config option is not selected.

* "Support variable-sized memory blocks long-term, or simulate that by
  "grouping" memory blocks that share a same altmap located on the first
  memory blocks in that group.  On s390x that adds all memory ahead of
  time, it's hard to make a decision what the right granularity will be.
  The user can give better hints when adding/removing memory
  explicitly."

With the new interface, the user could specify a memory range, including
multiple blocks, and whether he wants altmap support for that range.
This could allow for the mentioned altmap block grouping, or even
variable-sized blocks, in the future.

When the new interface is enabled, s390 will not add all possible
hotplug memory in advance, like before, to make it visible in sysfs for
online/offline actions. Instead, a new "max_configurable" sysfs
attribute will give a hint on the presence of hotplug memory. Before it
can be set online, it has to be configured via a new interface in
/sys/bus/memory/devices/configure_memory, basically imitating what is
done in ACPI handlers for other archs.

Usage format for the new interface: echo
config_mode,memoryrange,altmap_mode >
/sys/bus/memory/devices/configure_memory

E.g. to configure a range with altmap:
echo 1,0x200000000-0x20fffffff,1 > /sys/bus/memory/devices/configure_memory

lsmem/chmem tools can be adjusted to do all that transparently, so that
there would be no visible impact to the user, at least not when using
those tools. In addition, support for dynamic altmap configuration can
be added to those tools.

This could not only help to make s390 more flexible and similar to
others (wrt adding hotplug memory in advance). It might also be possible
to provide the dynamically configured altmap support for others. E.g.
instead of directly doing an add_memory() in the ACPI handler, with the
static altmap setting, you could instead defer that to the new interface
which allows dynamic altmap configuration.

Patch 1 provides necessary validation against user inputs for new
/sys/bus/memory/devices/configure_memory sysfs interface.

Patch 2 displays altmap support per memory block.
CONFIG_RUNTIME_MEMORY_CONFIGURATION enables dynamic addition of memory
with altmap/non-altmap support. Hence, providing concrete altmap
information would be beneficial.

Patch 3 adds /sys/devices/system/memory/max_configurable sysfs show
interface to list maximum number of possible memory block supported by
the architecture. This information would be beneficial for tools like
lsmem to distinguish betweeen configured memory blocks and deconfigured
memory blocks.

Patch 4 provides support for both legacy boottime standby memory
configuration or runtime configuration of standby memory. The patch also
validates user inputs against /sys/bus/memory/devices/configure_memory
interface and overrides /sys/devices/system/memory/max_configurable
value.

Thank you.


Sumanth Korikkar (4):
  mm/memory_hotplug: Add interface for runtime (de)configuration of
    memory
  mm/memory_hotplug: Add memory block altmap sysfs attribute
  mm/memory_hotplug: Add max_configurable sysfs read attribute
  s390/sclp: Add support for dynamic (de)configuration of memory

 drivers/base/memory.c        | 153 +++++++++++++++++++++++++++++++++++
 drivers/s390/char/sclp_cmd.c |  80 +++++++++++++++---
 include/linux/memory.h       |   6 ++
 mm/Kconfig                   |  16 ++++
 4 files changed, 246 insertions(+), 9 deletions(-)

-- 
2.45.2

