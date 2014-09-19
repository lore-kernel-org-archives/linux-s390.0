From: frank.blaschka@de.ibm.com
Subject: [RFC patch 1/6] KVM: s390: Enable PCI instructions
Date: Fri, 19 Sep 2014 13:54:30 +0200
Message-ID: <20140919115940.023551043@de.ibm.com>
References: <20140919115429.557279920@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline; filename=005-s390_kvm_enable_pci.patch
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: alex.williamson@redhat.com, pbonzini@redhat.com, agraf@suse.de
List-ID: <linux-s390.vger.kernel.org>

Enable PCI instructions for s390 KVM.

Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1787,7 +1787,7 @@ static int __init kvm_s390_init(void)
 	}
 	memcpy(vfacilities, S390_lowcore.stfle_fac_list, 16);
 	vfacilities[0] &= 0xff82fff3f4fc2000UL;
-	vfacilities[1] &= 0x005c000000000000UL;
+	vfacilities[1] &= 0x07dc000000000000UL;
 	return 0;
 }
 
