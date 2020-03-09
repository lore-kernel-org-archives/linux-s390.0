Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32054 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726847AbgCIIvs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Mar 2020 04:51:48 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0298oujB087069
        for <linux-s390@vger.kernel.org>; Mon, 9 Mar 2020 04:51:47 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ym8n6wjtd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 09 Mar 2020 04:51:47 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 9 Mar 2020 08:51:45 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 36/36] KVM: s390: introduce module parameter kvm.use_gisa
Date: Mon,  9 Mar 2020 09:51:26 +0100
In-Reply-To: <20200309085126.3334302-1-borntraeger@de.ibm.com>
References: <20200309085126.3334302-1-borntraeger@de.ibm.com>
Message-Id: <20200309085126.3334302-37-borntraeger@de.ibm.com>
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Ulrich Weigand <uweigand@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>

From: Michael Mueller <mimu@linux.ibm.com>

The boolean module parameter "kvm.use_gisa" controls if newly
created guests will use the GISA facility if provided by the
host system. The default is yes.

  # cat /sys/module/kvm/parameters/use_gisa
  Y

The parameter can be changed on the fly.

  # echo N > /sys/module/kvm/parameters/use_gisa

Already running guests are not affected by this change.

The kvm s390 debug feature shows if a guest is running with GISA.

  # grep gisa /sys/kernel/debug/s390dbf/kvm-$pid/sprintf
  00 01582725059:843303 3 - 08 00000000e119bc01  gisa 0x00000000c9ac2642 initialized
  00 01582725059:903840 3 - 11 000000004391ee22  00[0000000000000000-0000000000000000]: AIV gisa format-1 enabled for cpu 000
  ...
  00 01582725059:916847 3 - 08 0000000094fff572  gisa 0x00000000c9ac2642 cleared

In general, that value should not be changed as the GISA facility
enhances interruption delivery performance.

A reason to switch the GISA facility off might be a performance
comparison run or debugging.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
Link: https://lore.kernel.org/r/20200227091031.102993-1-mimu@linux.ibm.com
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index f4cd436ba979..6b1842a9feed 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -185,6 +185,11 @@ static u8 halt_poll_max_steal = 10;
 module_param(halt_poll_max_steal, byte, 0644);
 MODULE_PARM_DESC(halt_poll_max_steal, "Maximum percentage of steal time to allow polling");
 
+/* if set to true, the GISA will be initialized and used if available */
+static bool use_gisa  = true;
+module_param(use_gisa, bool, 0644);
+MODULE_PARM_DESC(use_gisa, "Use the GISA if the host supports it.");
+
 /*
  * For now we handle at most 16 double words as this is what the s390 base
  * kernel handles and stores in the prefix page. If we ever need to go beyond
@@ -2732,7 +2737,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	kvm->arch.use_skf = sclp.has_skey;
 	spin_lock_init(&kvm->arch.start_stop_lock);
 	kvm_s390_vsie_init(kvm);
-	kvm_s390_gisa_init(kvm);
+	if (use_gisa)
+		kvm_s390_gisa_init(kvm);
 	KVM_EVENT(3, "vm 0x%pK created by pid %u", kvm, current->pid);
 
 	return 0;
-- 
2.24.1
