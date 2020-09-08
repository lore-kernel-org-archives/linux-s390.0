Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35199 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730993AbgIHUKz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Sep 2020 16:10:55 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 2/7] kernel/resource: move and rename IORESOURCE_MEM_DRIVER_MANAGED
Date: Tue,  8 Sep 2020 22:10:07 +0200
Message-Id: <20200908201012.44168-3-david@redhat.com>
In-Reply-To: <20200908201012.44168-1-david@redhat.com>
References: <20200908201012.44168-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, linux-mm@kvack.org, linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ardb@kernel.org>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Baoquan He <bhe@redhat.com>, Wei Yang <richardw.yang@linux.intel.com>, Eric Biederman <ebiederm@xmission.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org

IORESOURCE_MEM_DRIVER_MANAGED currently uses an unused PnP bit, which is
always set to 0 by hardware. This is far from beautiful (and confusing),
and the bit only applies to SYSRAM. So let's move it out of the
bus-specific (PnP) defined bits.

We'll add another SYSRAM specific bit soon. If we ever need more bits for
other purposes, we can steal some from "desc", or reshuffle/regroup what we
have.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kexec@lists.infradead.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/ioport.h | 4 +++-
 kernel/kexec_file.c    | 2 +-
 mm/memory_hotplug.c    | 4 ++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 52a91f5fa1a36..d7620d7c941a0 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -58,6 +58,9 @@ struct resource {
 #define IORESOURCE_EXT_TYPE_BITS 0x01000000	/* Resource extended types */
 #define IORESOURCE_SYSRAM	0x01000000	/* System RAM (modifier) */
 
+/* IORESOURCE_SYSRAM specific bits. */
+#define IORESOURCE_SYSRAM_DRIVER_MANAGED	0x02000000 /* Always detected via a driver. */
+
 #define IORESOURCE_EXCLUSIVE	0x08000000	/* Userland may not map this resource */
 
 #define IORESOURCE_DISABLED	0x10000000
@@ -103,7 +106,6 @@ struct resource {
 #define IORESOURCE_MEM_32BIT		(3<<3)
 #define IORESOURCE_MEM_SHADOWABLE	(1<<5)	/* dup: IORESOURCE_SHADOWABLE */
 #define IORESOURCE_MEM_EXPANSIONROM	(1<<6)
-#define IORESOURCE_MEM_DRIVER_MANAGED	(1<<7)
 
 /* PnP I/O specific bits (IORESOURCE_BITS) */
 #define IORESOURCE_IO_16BIT_ADDR	(1<<0)
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index ca40bef75a616..dfeeed1aed084 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -520,7 +520,7 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
 	/* Returning 0 will take to next memory range */
 
 	/* Don't use memory that will be detected and handled by a driver. */
-	if (res->flags & IORESOURCE_MEM_DRIVER_MANAGED)
+	if (res->flags & IORESOURCE_SYSRAM_DRIVER_MANAGED)
 		return 0;
 
 	if (sz < kbuf->memsz)
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 4c47b68a9f4b5..8e1cd18b5cf14 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -105,7 +105,7 @@ static struct resource *register_memory_resource(u64 start, u64 size,
 	unsigned long flags =  IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
 
 	if (strcmp(resource_name, "System RAM"))
-		flags |= IORESOURCE_MEM_DRIVER_MANAGED;
+		flags |= IORESOURCE_SYSRAM_DRIVER_MANAGED;
 
 	/*
 	 * Make sure value parsed from 'mem=' only restricts memory adding
@@ -1160,7 +1160,7 @@ EXPORT_SYMBOL_GPL(add_memory);
  *
  * For this memory, no entries in /sys/firmware/memmap ("raw firmware-provided
  * memory map") are created. Also, the created memory resource is flagged
- * with IORESOURCE_MEM_DRIVER_MANAGED, so in-kernel users can special-case
+ * with IORESOURCE_SYSRAM_DRIVER_MANAGED, so in-kernel users can special-case
  * this memory as well (esp., not place kexec images onto it).
  *
  * The resource_name (visible via /proc/iomem) has to have the format
-- 
2.26.2
