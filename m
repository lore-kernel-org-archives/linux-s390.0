Return-Path: <linux-kernel-owner@vger.kernel.org>
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v2] s390: simplify memory notifier for protecting kdump crash kernel area
Date: Fri, 24 Apr 2020 10:39:04 +0200
Message-Id: <20200424083904.8587-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Philipp Rudo <prudo@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, "Eric W . Biederman" <ebiederm@xmission.com>, Michal Hocko <mhocko@kernel.org>

Assume we have a crashkernel area of 256MB reserved:

root@vm0:~# cat /proc/iomem
00000000-6fffffff : System RAM
  0f258000-0fcfffff : Kernel code
  0fd00000-101d10e3 : Kernel data
  105b3000-1068dfff : Kernel bss
70000000-7fffffff : Crash kernel

This exactly corresponds to memory block 7 (memory block size is 256MB).
Trying to offline that memory block results in:

root@vm0:~# echo "offline" > /sys/devices/system/memory/memory7/state
-bash: echo: write error: Device or resource busy

[  128.458762] page:000003d081c00000 refcount:1 mapcount:0 mapping:000000=
00d01cecd4 index:0x0
[  128.458773] flags: 0x1ffff00000001000(reserved)
[  128.458781] raw: 1ffff00000001000 000003d081c00008 000003d081c00008 00=
00000000000000
[  128.458781] raw: 0000000000000000 0000000000000000 ffffffff00000001 00=
00000000000000
[  128.458783] page dumped because: unmovable page

The craskernel area is marked reserved in the bootmem allocator. This
results in the memmap getting initialized (refcount=3D1, PG_reserved), bu=
t
the pages are never freed to the page allocator.

So these pages look like allocated pages that are unmovable (esp.
PG_reserved), and therefore, memory offlining fails early, when trying to
isolate the page range.

We only have to care about the exchange area, make that clear.

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Philipp Rudo <prudo@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Michal Hocko <mhocko@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

Follow up of:
- "[PATCH v1] s390: drop memory notifier for protecting kdump crash kerne=
l
   area"

v1 -> v2:
- Keep the notifier, check for exchange area only

---
 arch/s390/kernel/setup.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 0f0b140b5558..c0881f0a3175 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -594,9 +594,10 @@ static void __init setup_memory_end(void)
 #ifdef CONFIG_CRASH_DUMP
=20
 /*
- * When kdump is enabled, we have to ensure that no memory from
- * the area [0 - crashkernel memory size] and
- * [crashk_res.start - crashk_res.end] is set offline.
+ * When kdump is enabled, we have to ensure that no memory from the area
+ * [0 - crashkernel memory size] is set offline - it will be exchanged w=
ith
+ * the crashkernel memory region when kdump is triggered. The crashkerne=
l
+ * memory region can never get offlined (pages are unmovable).
  */
 static int kdump_mem_notifier(struct notifier_block *nb,
 			      unsigned long action, void *data)
@@ -607,11 +608,7 @@ static int kdump_mem_notifier(struct notifier_block =
*nb,
 		return NOTIFY_OK;
 	if (arg->start_pfn < PFN_DOWN(resource_size(&crashk_res)))
 		return NOTIFY_BAD;
-	if (arg->start_pfn > PFN_DOWN(crashk_res.end))
-		return NOTIFY_OK;
-	if (arg->start_pfn + arg->nr_pages - 1 < PFN_DOWN(crashk_res.start))
-		return NOTIFY_OK;
-	return NOTIFY_BAD;
+	return NOTIFY_OK;
 }
=20
 static struct notifier_block kdump_mem_nb =3D {
--=20
2.25.3
