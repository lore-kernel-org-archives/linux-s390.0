Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20110812134907.166585439@linux.vnet.ibm.com>
Date: Fri, 12 Aug 2011 15:48:51 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [patch v3 2/8] kdump: Make kimage_load_crash_segment() weak
References: <20110812134849.748973593@linux.vnet.ibm.com>
Content-Disposition: inline; filename=s390-kdump-common-load_crash_segment.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: vgoyal@redhat.com
Cc: ebiederm@xmission.com, mahesh@linux.vnet.ibm.com, hbabu@us.ibm.com, oomichi@mxs.nes.nec.co.jp, horms@verge.net.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Michael Holzheu <holzheu@linux.vnet.ibm.com>

On s390 we do not create page tables at all for the crashkernel memory.
This requires a s390 specific version for kimage_load_crash_segment().
Therefore this patch declares this function as "__weak". The s390 version is
very simple. It just copies the kexec segment to real memory without using
page tables:

int kimage_load_crash_segment(struct kimage *image,
                              struct kexec_segment *segment)
{
        return copy_from_user_real((void *) segment->mem, segment->buf,
                                   segment->bufsz);
}

There are two main advantages of not creating page tables for the
crashkernel memory:

a) It saves memory. We have scenarios in mind, where crashkernel
   memory can be very large and saving page table space is important.
b) We protect the crashkernel memory from being overwritten.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 kernel/kexec.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -842,8 +842,13 @@ out:
 	return result;
 }
 
-static int kimage_load_crash_segment(struct kimage *image,
-					struct kexec_segment *segment)
+/*
+ * Load crash segment into memory. Architecture code can override this
+ * function. E.g. this is necessary for architectures that do not
+ * create page tables for crashkernel memory.
+ */
+int __weak kimage_load_crash_segment(struct kimage *image,
+				     struct kexec_segment *segment)
 {
 	/* For crash dumps kernels we simply copy the data from
 	 * user space to it's destination.
