Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:50992 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgDASjv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 1 Apr 2020 14:39:51 -0400
From: Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2 4/4] hugetlbfs: clean up command line processing
Date: Wed,  1 Apr 2020 11:38:19 -0700
Message-Id: <20200401183819.20647-5-mike.kravetz@oracle.com>
In-Reply-To: <20200401183819.20647-1-mike.kravetz@oracle.com>
References: <20200401183819.20647-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Longpeng <longpeng2@huawei.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Mina Almasry <almasrymina@google.com>, Andrew Morton <akpm@linux-foundation.org>, Mike Kravetz <mike.kravetz@oracle.com>

With all hugetlb page processing done in a single file clean up code.
- Make code match desired semantics
  - Update documentation with semantics
- Make all warnings and errors messages start with 'HugeTLB:'.
- Consistently name command line parsing routines.
- Check for hugepages_supported() before processing parameters.
- Add comments to code
  - Describe some of the subtle interactions
  - Describe semantics of command line arguments

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 .../admin-guide/kernel-parameters.txt         | 35 ++++---
 Documentation/admin-guide/mm/hugetlbpage.rst  | 44 +++++++++
 mm/hugetlb.c                                  | 96 +++++++++++++++----
 3 files changed, 142 insertions(+), 33 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1bd5454b5e5f..de653cfe1726 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -832,12 +832,15 @@
 			See also Documentation/networking/decnet.txt.
 
 	default_hugepagesz=
-			[same as hugepagesz=] The size of the default
-			HugeTLB page size. This is the size represented by
-			the legacy /proc/ hugepages APIs, used for SHM, and
-			default size when mounting hugetlbfs filesystems.
-			Defaults to the default architecture's huge page size
-			if not specified.
+			[HW] The size of the default HugeTLB page size. This
+			is the size represented by the legacy /proc/ hugepages
+			APIs.  In addition, this is the default hugetlb size
+			used for shmget(), mmap() and mounting hugetlbfs
+			filesystems.  If not specified, defaults to the
+			architecture's default huge page size.  Huge page
+			sizes are architecture dependent.  See also
+			Documentation/admin-guide/mm/hugetlbpage.rst.
+			Format: size[KMG]
 
 	deferred_probe_timeout=
 			[KNL] Debugging option to set a timeout in seconds for
@@ -1480,13 +1483,19 @@
 			If enabled, boot-time allocation of gigantic hugepages
 			is skipped.
 
-	hugepages=	[HW,X86-32,IA-64] HugeTLB pages to allocate at boot.
-	hugepagesz=	[HW,IA-64,PPC,X86-64] The size of the HugeTLB pages.
-			On x86-64 and powerpc, this option can be specified
-			multiple times interleaved with hugepages= to reserve
-			huge pages of different sizes. Valid pages sizes on
-			x86-64 are 2M (when the CPU supports "pse") and 1G
-			(when the CPU supports the "pdpe1gb" cpuinfo flag).
+	hugepages=	[HW] Number of HugeTLB pages to allocate at boot.
+			If this follows hugepagesz (below), it specifies
+			the number of pages of hugepagesz to be allocated.
+			Format: <integer>
+	hugepagesz=
+			[HW] The size of the HugeTLB pages.  This is used in
+			conjunction with hugepages (above) to allocate huge
+			pages of a specific size at boot.  The pair
+			hugepagesz=X hugepages=Y can be specified once for
+			each supported huge page size. Huge page sizes are
+			architecture dependent.  See also
+			Documentation/admin-guide/mm/hugetlbpage.rst.
+			Format: size[KMG]
 
 	hung_task_panic=
 			[KNL] Should the hung task detector generate panics.
diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
index 1cc0bc78d10e..de340c586995 100644
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -100,6 +100,50 @@ with a huge page size selection parameter "hugepagesz=<size>".  <size> must
 be specified in bytes with optional scale suffix [kKmMgG].  The default huge
 page size may be selected with the "default_hugepagesz=<size>" boot parameter.
 
+Hugetlb boot command line parameter semantics
+hugepagesz - Specify a huge page size.  Used in conjunction with hugepages
+	parameter to preallocate a number of huge pages of the specified
+	size.  Hence, hugepagesz and hugepages are typically specified in
+	pairs such as:
+		hugepagesz=2M hugepages=512
+	hugepagesz can only be specified once on the command line for a
+	specific huge page size.  Valid huge page sizes are architecture
+	dependent.
+hugepages - Specify the number of huge pages to preallocate.  This typically
+	follows a valid hugepagesz parameter.  However, if hugepages is the
+	first or only hugetlb command line parameter it specifies the number
+	of huge pages of default size to allocate.  The number of huge pages
+	of default size specified in this manner can be overwritten by a
+	hugepagesz,hugepages parameter pair for the default size.
+	For example, on an architecture with 2M default huge page size:
+		hugepages=256 hugepagesz=2M hugepages=512
+	will result in 512 2M huge pages being allocated.  If a hugepages
+	parameter is preceded by an invalid hugepagesz parameter, it will
+	be ignored.
+default_hugepagesz - Specify the default huge page size.  This parameter can
+	only be specified once on the command line.  No other hugetlb command
+	line parameter is associated with default_hugepagesz.  Therefore, it
+	can appear anywhere on the command line.  If hugepages= is the first
+	hugetlb command line parameter, the specified number of huge pages
+	will apply to the default huge page size specified with
+	default_hugepagesz.  For example,
+		hugepages=512 default_hugepagesz=2M
+	will result in 512 2M huge pages being allocated.  However, specifying
+	the number of default huge pages in this manner will not apply to
+	gigantic huge pages.  For example,
+		hugepages=10 default_hugepagesz=1G
+				or
+		default_hugepagesz=1G hugepages=10
+	will NOT result in the allocation of 10 1G huge pages.  In order to
+	preallocate gigantic huge pages, there must be hugepagesz, hugepages
+	parameter pair.  For example,
+		hugepagesz=1G hugepages=10 default_hugepagesz=1G
+				or
+		default_hugepagesz=1G hugepagesz=1G hugepages=10
+	will result 10 1G huge pages being allocated and the default huge
+	page size will be set to 1G.  Valid default huge page size is
+	architecture dependent.
+
 When multiple huge page sizes are supported, ``/proc/sys/vm/nr_hugepages``
 indicates the current number of pre-allocated huge pages of the default size.
 Thus, one can use the following command to dynamically allocate/deallocate
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 72a4343509d5..74ef53f7c5a7 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3054,7 +3054,7 @@ static void __init hugetlb_sysfs_init(void)
 		err = hugetlb_sysfs_add_hstate(h, hugepages_kobj,
 					 hstate_kobjs, &hstate_attr_group);
 		if (err)
-			pr_err("Hugetlb: Unable to add hstate %s", h->name);
+			pr_err("HugeTLB: Unable to add hstate %s", h->name);
 	}
 }
 
@@ -3158,7 +3158,7 @@ static void hugetlb_register_node(struct node *node)
 						nhs->hstate_kobjs,
 						&per_node_hstate_attr_group);
 		if (err) {
-			pr_err("Hugetlb: Unable to add hstate %s for node %d\n",
+			pr_err("HugeTLB: Unable to add hstate %s for node %d\n",
 				h->name, node->dev.id);
 			hugetlb_unregister_node(node);
 			break;
@@ -3209,19 +3209,35 @@ static int __init hugetlb_init(void)
 	if (!hugepages_supported())
 		return 0;
 
-	if (!size_to_hstate(default_hstate_size)) {
-		if (default_hstate_size != 0) {
-			pr_err("HugeTLB: unsupported default_hugepagesz %lu. Reverting to %lu\n",
-			       default_hstate_size, HPAGE_SIZE);
-		}
-
+	/*
+	 * Make sure HPAGE_SIZE (HUGETLB_PAGE_ORDER) hstate exists.  Some
+	 * architectures depend on setup being done here.
+	 *
+	 * If a valid default huge page size was specified on the command line,
+	 * add associated hstate if necessary.  If not, set default_hstate_size
+	 * to default size.  default_hstate_idx is used at runtime to identify
+	 * the default huge page size/hstate.
+	 */
+	hugetlb_add_hstate(HUGETLB_PAGE_ORDER);
+	if (default_hstate_size)
+		hugetlb_add_hstate(ilog2(default_hstate_size) - PAGE_SHIFT);
+	else
 		default_hstate_size = HPAGE_SIZE;
-		hugetlb_add_hstate(HUGETLB_PAGE_ORDER);
-	}
 	default_hstate_idx = hstate_index(size_to_hstate(default_hstate_size));
+
+	/*
+	 * default_hstate_max_huge_pages != 0 indicates a count (hugepages=)
+	 * specified before a size (hugepagesz=).  Use this count for the
+	 * default huge page size, unless a specific value was specified for
+	 * this size in a hugepagesz/hugepages pair.
+	 */
 	if (default_hstate_max_huge_pages) {
 		if (!default_hstate.max_huge_pages)
-			default_hstate.max_huge_pages = default_hstate_max_huge_pages;
+			default_hstate.max_huge_pages =
+				default_hstate_max_huge_pages;
+		else
+			pr_warn("HugeTLB: First hugepages=%lu ignored\n",
+				default_hstate_max_huge_pages);
 	}
 
 	hugetlb_init_hstates();
@@ -3274,20 +3290,31 @@ void __init hugetlb_add_hstate(unsigned int order)
 	parsed_hstate = h;
 }
 
-static int __init hugetlb_nrpages_setup(char *s)
+/*
+ * hugepages command line processing
+ * hugepages normally follows a valid hugepagsz specification.  If not, ignore
+ * the hugepages value.  hugepages can also be the first huge page command line
+ * option in which case it specifies the number of huge pages for the default
+ * size.
+ */
+static int __init hugepages_setup(char *s)
 {
 	unsigned long *mhp;
 	static unsigned long *last_mhp;
 
+	if (!hugepages_supported()) {
+		pr_warn("HugeTLB: huge pages not supported, ignoring hugepages = %s\n", s);
+		return 0;
+	}
+
 	if (!parsed_valid_hugepagesz) {
-		pr_warn("hugepages = %s preceded by "
-			"an unsupported hugepagesz, ignoring\n", s);
+		pr_warn("HugeTLB: hugepages = %s preceded by an unsupported hugepagesz, ignoring\n", s);
 		parsed_valid_hugepagesz = true;
-		return 1;
+		return 0;
 	}
 	/*
-	 * !hugetlb_max_hstate means we haven't parsed a hugepagesz= parameter yet,
-	 * so this hugepages= parameter goes to the "default hstate".
+	 * !hugetlb_max_hstate means we haven't parsed a hugepagesz= parameter
+	 * yet, so this hugepages= parameter goes to the "default hstate".
 	 */
 	else if (!hugetlb_max_hstate)
 		mhp = &default_hstate_max_huge_pages;
@@ -3295,8 +3322,8 @@ static int __init hugetlb_nrpages_setup(char *s)
 		mhp = &parsed_hstate->max_huge_pages;
 
 	if (mhp == last_mhp) {
-		pr_warn("hugepages= specified twice without interleaving hugepagesz=, ignoring\n");
-		return 1;
+		pr_warn("HugeTLB: hugepages= specified twice without interleaving hugepagesz=, ignoring hugepages=%s\n", s);
+		return 0;
 	}
 
 	if (sscanf(s, "%lu", mhp) <= 0)
@@ -3314,12 +3341,24 @@ static int __init hugetlb_nrpages_setup(char *s)
 
 	return 1;
 }
-__setup("hugepages=", hugetlb_nrpages_setup);
+__setup("hugepages=", hugepages_setup);
 
+/*
+ * hugepagesz command line processing
+ * A specific huge page size can only be specified once with hugepagesz.
+ * hugepagesz is followed by hugepages on the command line.  The global
+ * variable 'parsed_valid_hugepagesz' is used to determine if prior
+ * hugepagesz argument was valid.
+ */
 static int __init hugepagesz_setup(char *s)
 {
 	unsigned long size;
 
+	if (!hugepages_supported()) {
+		pr_warn("HugeTLB: huge pages not supported, ignoring hugepagesz = %s\n", s);
+		return 0;
+	}
+
 	size = (unsigned long)memparse(s, NULL);
 
 	if (!arch_hugetlb_valid_size(size)) {
@@ -3329,19 +3368,31 @@ static int __init hugepagesz_setup(char *s)
 	}
 
 	if (size_to_hstate(size)) {
+		parsed_valid_hugepagesz = false;
 		pr_warn("HugeTLB: hugepagesz %s specified twice, ignoring\n", s);
 		return 0;
 	}
 
+	parsed_valid_hugepagesz = true;
 	hugetlb_add_hstate(ilog2(size) - PAGE_SHIFT);
 	return 1;
 }
 __setup("hugepagesz=", hugepagesz_setup);
 
+/*
+ * default_hugepagesz command line input
+ * Only one instance of default_hugepagesz allowed on command line.  Do not
+ * add hstate here as that will confuse hugepagesz/hugepages processing.
+ */
 static int __init default_hugepagesz_setup(char *s)
 {
 	unsigned long size;
 
+	if (!hugepages_supported()) {
+		pr_warn("HugeTLB: huge pages not supported, ignoring default_hugepagesz = %s\n", s);
+		return 0;
+	}
+
 	size = (unsigned long)memparse(s, NULL);
 
 	if (!arch_hugetlb_valid_size(size)) {
@@ -3349,6 +3400,11 @@ static int __init default_hugepagesz_setup(char *s)
 		return 0;
 	}
 
+	if (default_hstate_size) {
+		pr_err("HugeTLB: default_hugepagesz previously specified, ignoring %s\n", s);
+		return 0;
+	}
+
 	default_hstate_size = size;
 	return 1;
 }
-- 
2.25.1
