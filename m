Return-Path: <linux-kernel-owner@vger.kernel.org>
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH RFC 1/2] s390/zcore: traverse resources instead of memblocks
Date: Fri, 17 Apr 2020 17:01:50 +0200
Message-Id: <20200417150151.17239-2-david@redhat.com>
In-Reply-To: <20200417150151.17239-1-david@redhat.com>
References: <20200417150151.17239-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Philipp Rudo <prudo@linux.ibm.com>, Kirill Smelkov <kirr@nexedi.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>

The zcore memmap basically contains the first level of all system RAM fro=
m
/proc/iomem. We want to disable CONFIG_ARCH_KEEP_MEMBLOCK (e.g., to not
create memblocks for hotplugged/standby memory and save space), switch to
traversing system ram resources instead. During early boot, we create
resources for all early memblocks (including the crash kernel area). When
adding standby memory, we currently create both, memblocks and resources.

Note: As we don't have memory hotplug after boot (standby memory is added
via sclp during boot), we don't have to worry about races.

I am only able to test under KVM (where I hacked up zcore to still
create the memmap file)

root@vm0:~# cat /proc/iomem
00000000-2fffffff : System RAM
  10424000-10ec6fff : Kernel code
  10ec7000-1139a0e3 : Kernel data
  1177a000-11850fff : Kernel bss
30000000-3fffffff : Crash kernel

Result without this patch:
root@vm0:~# cat /sys/kernel/debug/zcore/memmap
0000000000000000 0000000040000000

Result with this patch:
root@vm0:~# cat /sys/kernel/debug/zcore/memmap
0000000000000000 0000000030000000 0000000030000000 0000000010000000

The difference is due to memblocks getting merged, resources (currently)
not. So we might have some more entries, but they describe the same
memory map.

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Philipp Rudo <prudo@linux.ibm.com>
Cc: Kirill Smelkov <kirr@nexedi.com>
Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/s390/char/zcore.c | 61 ++++++++++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 13 deletions(-)

diff --git a/drivers/s390/char/zcore.c b/drivers/s390/char/zcore.c
index 08f812475f5e..c40ac7d548d8 100644
--- a/drivers/s390/char/zcore.c
+++ b/drivers/s390/char/zcore.c
@@ -16,7 +16,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/debugfs.h>
-#include <linux/memblock.h>
+#include <linux/ioport.h>
=20
 #include <asm/asm-offsets.h>
 #include <asm/ipl.h>
@@ -139,35 +139,70 @@ static void release_hsa(void)
 	hsa_available =3D 0;
 }
=20
+struct zcore_memmap_info {
+	char *buf;
+	size_t length;
+};
+
 static ssize_t zcore_memmap_read(struct file *filp, char __user *buf,
 				 size_t count, loff_t *ppos)
 {
-	return simple_read_from_buffer(buf, count, ppos, filp->private_data,
-				       memblock.memory.cnt * CHUNK_INFO_SIZE);
+	struct zcore_memmap_info *info =3D filp->private_data;
+
+	return simple_read_from_buffer(buf, count, ppos, info->buf,
+				       info->length);
+}
+
+static int zcore_count_ram_resource(struct resource *res, void *arg)
+{
+	size_t *count =3D arg;
+
+	*count +=3D 1;
+	return 0;
+}
+
+static int zcore_process_ram_resource(struct resource *res, void *arg)
+{
+	char **buf =3D arg;
+
+	sprintf(*buf, "%016lx %016lx ", (unsigned long) res->start,
+		(unsigned long) resource_size(res));
+
+	*buf +=3D CHUNK_INFO_SIZE;
+	return 0;
 }
=20
 static int zcore_memmap_open(struct inode *inode, struct file *filp)
 {
-	struct memblock_region *reg;
+	struct zcore_memmap_info *info;
+	size_t count =3D 0;
 	char *buf;
-	int i =3D 0;
=20
-	buf =3D kcalloc(memblock.memory.cnt, CHUNK_INFO_SIZE, GFP_KERNEL);
+	walk_system_ram_res(0, ULONG_MAX, &count, zcore_count_ram_resource);
+
+	info =3D kmalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+	buf =3D kcalloc(count, CHUNK_INFO_SIZE, GFP_KERNEL);
 	if (!buf) {
+		kfree(info);
 		return -ENOMEM;
 	}
-	for_each_memblock(memory, reg) {
-		sprintf(buf + (i++ * CHUNK_INFO_SIZE), "%016llx %016llx ",
-			(unsigned long long) reg->base,
-			(unsigned long long) reg->size);
-	}
-	filp->private_data =3D buf;
+	info->length =3D count * CHUNK_INFO_SIZE;
+	info->buf =3D buf;
+
+	walk_system_ram_res(0, ULONG_MAX, &buf, zcore_process_ram_resource);
+
+	filp->private_data =3D info;
 	return nonseekable_open(inode, filp);
 }
=20
 static int zcore_memmap_release(struct inode *inode, struct file *filp)
 {
-	kfree(filp->private_data);
+	struct zcore_memmap_info *info =3D filp->private_data;
+
+	kfree(info->buf);
+	kfree(info);
 	return 0;
 }
=20
--=20
2.25.1
