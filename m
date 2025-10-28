Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5821225416
	for <linux-s390@vger.kernel.org>; Tue, 28 Oct 2025 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665996; cv=none; b=LF7rDZVVBnRO965Vts+wP+vKgFtxG1RgzuZYCKHzTZS2CbTnUUBHG1s8Y265RONEjctEI3UgHRC8Pl+/ywqzrL2KCp63zvUsU1Ska3h0arFDnUb21Zl0kymANCtN3ygHpDusgdW2DALic/ypJ+OP6SqtSIyXjBcy+wS0UIAOEsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665996; c=relaxed/simple;
	bh=4go0Y3v9YKfhfU7ApoJZ9kJ0Bt67yUbEOcUv3u4PSrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M780XtyihPwzFn6x6oLxR4S6MasL6xQLLDu6IKyAGqbuM8Qx9FtsiHWKhqJdCqY5oMteJ6pD8ukhNxPmxWTV/VM9pVjSeVFEP3Aew0jBRtfogkqMKq7OG8xXYahsTIP86odNhzKi1Y9WxHnO8tgWjrFkSSIchg33SAJx5yAXjr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D/UnTgq2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/UnTgq2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761665993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g/gBWLkaVnRm6+juGgWVkm6jdI+NwtfvqdMgnObklz0=;
	b=D/UnTgq22zD2M5BaXlVp1t420WNntbbM7zcggC5WVf5H6S6J7vVF/TJ6HDWTmbbNF/BGuP
	KswTHbuu6fUF6RQuBjP4bgp+saPsdX8adB2DWK9P+jyiTs9yFrZuyq1ED3ksH0eLd9blD4
	cP9xs+WeSy0OcWAnfrV7/AEcQE4UfUE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-0LJG7Z3JMu-DSGdh39gURQ-1; Tue,
 28 Oct 2025 11:39:46 -0400
X-MC-Unique: 0LJG7Z3JMu-DSGdh39gURQ-1
X-Mimecast-MFC-AGG-ID: 0LJG7Z3JMu-DSGdh39gURQ_1761665983
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53C8919541BD;
	Tue, 28 Oct 2025 15:39:43 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.65.101])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0202A180057E;
	Tue, 28 Oct 2025 15:39:40 +0000 (UTC)
From: Luiz Capitulino <luizcap@redhat.com>
To: hca@linux.ibm.com,
	borntraeger@linux.ibm.com,
	joao.m.martins@oracle.com,
	mike.kravetz@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-s390@vger.kernel.org
Cc: osalvador@suse.de,
	akpm@linux-foundation.org,
	david@redhat.com,
	aneesh.kumar@kernel.org
Subject: [PATCH] mm: hugetlb: fix HVO crash on s390
Date: Tue, 28 Oct 2025 11:39:30 -0400
Message-ID: <20251028153930.37107-1-luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

A reproducible crash occurs when enabling HVO on s390. The crash and the
proposed fix were worked on an s390 KVM guest running on an older
hypervisor, as I don't have access to an LPAR. However, the same
issue should occur on bare-metal.

Reproducer (it may take a few runs to trigger):

 # sysctl vm.hugetlb_optimize_vmemmap=1
 # echo 1 > /proc/sys/vm/nr_hugepages
 # echo 0 > /proc/sys/vm/nr_hugepages

Crash log:

[   52.340369] list_del corruption. prev->next should be 000000d382110008, but was 000000d7116d3880. (prev=000000d7116d3910)
[   52.340420] ------------[ cut here ]------------
[   52.340424] kernel BUG at lib/list_debug.c:62!
[   52.340566] monitor event: 0040 ilc:2 [#1]SMP
[   52.340573] Modules linked in: ctcm fsm qeth ccwgroup zfcp scsi_transport_fc qdio dasd_fba_mod dasd_eckd_mod dasd_mod xfs ghash_s390 prng des_s390 libdes sha3_512_s390 sha3_256_s390 virtio_net virtio_blk net_failover sha_common failover dm_mirror dm_region_hash dm_log dm_mod paes_s390 crypto_engine pkey_cca pkey_ep11 zcrypt pkey_pckmo pkey aes_s390
[   52.340606] CPU: 1 UID: 0 PID: 1672 Comm: root-rep2 Kdump: loaded Not tainted 6.18.0-rc3 #1 NONE
[   52.340610] Hardware name: IBM 3931 LA1 400 (KVM/Linux)
[   52.340611] Krnl PSW : 0704c00180000000 0000015710cda7fe (__list_del_entry_valid_or_report+0xfe/0x128)
[   52.340619]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
[   52.340622] Krnl GPRS: c0000000ffffefff 0000000100000027 000000000000006d 0000000000000000
[   52.340623]            000000d7116d35d8 000000d7116d35d0 0000000000000002 000000d7116d39b0
[   52.340625]            000000d7116d3880 000000d7116d3910 000000d7116d3910 000000d382110008
[   52.340626]            000003ffac1ccd08 000000d7116d39b0 0000015710cda7fa 000000d7116d37d0
[   52.340632] Krnl Code: 0000015710cda7ee: c020003e496f	larl	%r2,00000157114a3acc
           0000015710cda7f4: c0e5ffd5280e	brasl	%r14,000001571077f810
          #0000015710cda7fa: af000000		mc	0,0
          >0000015710cda7fe: b9040029		lgr	%r2,%r9
           0000015710cda802: c0e5ffe5e193	brasl	%r14,0000015710996b28
           0000015710cda808: e34090080004	lg	%r4,8(%r9)
           0000015710cda80e: b9040059		lgr	%r5,%r9
           0000015710cda812: b9040038		lgr	%r3,%r8
[   52.340643] Call Trace:
[   52.340645]  [<0000015710cda7fe>] __list_del_entry_valid_or_report+0xfe/0x128
[   52.340649] ([<0000015710cda7fa>] __list_del_entry_valid_or_report+0xfa/0x128)
[   52.340652]  [<0000015710a30b2e>] hugetlb_vmemmap_restore_folios+0x96/0x138
[   52.340655]  [<0000015710a268ac>] update_and_free_pages_bulk+0x64/0x150
[   52.340659]  [<0000015710a26f8a>] set_max_huge_pages+0x4ca/0x6f0
[   52.340662]  [<0000015710a273ba>] hugetlb_sysctl_handler_common+0xea/0x120
[   52.340665]  [<0000015710a27484>] hugetlb_sysctl_handler+0x44/0x50
[   52.340667]  [<0000015710b53ffa>] proc_sys_call_handler+0x17a/0x280
[   52.340672]  [<0000015710a90968>] vfs_write+0x2c8/0x3a0
[   52.340676]  [<0000015710a90bd2>] ksys_write+0x72/0x100
[   52.340679]  [<00000157111483a8>] __do_syscall+0x150/0x318
[   52.340682]  [<0000015711153a5e>] system_call+0x6e/0x90
[   52.340684] Last Breaking-Event-Address:
[   52.340684]  [<000001571077f85c>] _printk+0x4c/0x58
[   52.340690] Kernel panic - not syncing: Fatal exception: panic_on_oops

This issue was introduced by commit f13b83fdd996 ("hugetlb: batch TLB
flushes when freeing vmemmap"). Before that change, the HVO
implementation called flush_tlb_kernel_range() each time a vmemmap
PMD split and remapping was performed. The mentioned commit changed this
to issue a few flush_tlb_all() calls after performing all remappings.

However, on s390, flush_tlb_kernel_range() expands to
__tlb_flush_kernel() while flush_tlb_all() is not implemented. As a
result, we went from flushing the TLB for every remapping to no flushing
at all.

This commit fixes this by introducing vmemmap_flush_tlb_all(), which
expands to __tlb_flush_kernel() on s390 and to flush_tlb_all() on other
archs.

Fixes: f13b83fdd996 ("hugetlb: batch TLB flushes when freeing vmemmap")
Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
---
 mm/hugetlb_vmemmap.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index ba0fb1b6a5a8..5819a3088850 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -48,6 +48,15 @@ struct vmemmap_remap_walk {
 	unsigned long		flags;
 };
 
+static inline void vmemmap_flush_tlb_all(void)
+{
+#ifdef CONFIG_S390
+	__tlb_flush_kernel();
+#else
+	flush_tlb_all();
+#endif
+}
+
 static int vmemmap_split_pmd(pmd_t *pmd, struct page *head, unsigned long start,
 			     struct vmemmap_remap_walk *walk)
 {
@@ -539,7 +548,7 @@ long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 	}
 
 	if (restored)
-		flush_tlb_all();
+		vmemmap_flush_tlb_all();
 	if (!ret)
 		ret = restored;
 	return ret;
@@ -703,7 +712,7 @@ static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
 		 */
 		goto out;
 
-	flush_tlb_all();
+	vmemmap_flush_tlb_all();
 
 	list_for_each_entry(folio, folio_list, lru) {
 		int ret;
@@ -721,7 +730,7 @@ static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
 		 * allowing more vmemmap remaps to occur.
 		 */
 		if (ret == -ENOMEM && !list_empty(&vmemmap_pages)) {
-			flush_tlb_all();
+			vmemmap_flush_tlb_all();
 			free_vmemmap_page_list(&vmemmap_pages);
 			INIT_LIST_HEAD(&vmemmap_pages);
 			__hugetlb_vmemmap_optimize_folio(h, folio, &vmemmap_pages, flags);
@@ -729,7 +738,7 @@ static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
 	}
 
 out:
-	flush_tlb_all();
+	vmemmap_flush_tlb_all();
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
-- 
2.51.0

