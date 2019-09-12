Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64748 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731896AbfILNja (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Sep 2019 09:39:30 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8CDWDfP048291
        for <linux-s390@vger.kernel.org>; Thu, 12 Sep 2019 09:39:29 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uyn5dvr6s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 12 Sep 2019 09:39:28 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 12 Sep 2019 14:39:26 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/2] KVM: s390: kvm_s390_vm_start_migration: check dirty_bitmap before using it as target for memset()
Date: Thu, 12 Sep 2019 15:39:20 +0200
In-Reply-To: <20190912133921.6886-1-borntraeger@de.ibm.com>
References: <20190912133921.6886-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190912133921.6886-2-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

If userspace doesn't set KVM_MEM_LOG_DIRTY_PAGES on memslot before calling
kvm_s390_vm_start_migration(), kernel will oops with:

  Unable to handle kernel pointer dereference in virtual kernel address space
  Failing address: 0000000000000000 TEID: 0000000000000483
  Fault in home space mode while using kernel ASCE.
  AS:0000000002a2000b R2:00000001bff8c00b R3:00000001bff88007 S:00000001bff91000 P:000000000000003d
  Oops: 0004 ilc:2 [#1] SMP
  ...
  Call Trace:
  ([<001fffff804ec552>] kvm_s390_vm_set_attr+0x347a/0x3828 [kvm])
   [<001fffff804ecfc0>] kvm_arch_vm_ioctl+0x6c0/0x1998 [kvm]
   [<001fffff804b67e4>] kvm_vm_ioctl+0x51c/0x11a8 [kvm]
   [<00000000008ba572>] do_vfs_ioctl+0x1d2/0xe58
   [<00000000008bb284>] ksys_ioctl+0x8c/0xb8
   [<00000000008bb2e2>] sys_ioctl+0x32/0x40
   [<000000000175552c>] system_call+0x2b8/0x2d8
  INFO: lockdep is turned off.
  Last Breaking-Event-Address:
   [<0000000000dbaf60>] __memset+0xc/0xa0

due to ms->dirty_bitmap being NULL, which might crash the host.

Make sure that ms->dirty_bitmap is set before using it or
return -EINVAL otherwise.

Cc: <stable@vger.kernel.org>
Fixes: afdad61615cc ("KVM: s390: Fix storage attributes migration with memory slots")
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Link: https://lore.kernel.org/kvm/20190911075218.29153-1-imammedo@redhat.com/
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 3f520cd837fb..b298fcc9ec56 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1018,6 +1018,8 @@ static int kvm_s390_vm_start_migration(struct kvm *kvm)
 	/* mark all the pages in active slots as dirty */
 	for (slotnr = 0; slotnr < slots->used_slots; slotnr++) {
 		ms = slots->memslots + slotnr;
+		if (!ms->dirty_bitmap)
+			return -EINVAL;
 		/*
 		 * The second half of the bitmap is only used on x86,
 		 * and would be wasted otherwise, so we put it to good
-- 
2.21.0
