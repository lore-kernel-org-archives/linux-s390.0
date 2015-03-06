From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 15/20] KVM: s390: Use the read_guest_abs() in guest debug functions
Date: Fri,  6 Mar 2015 14:16:47 +0100
Message-ID: <1425647812-61838-16-git-send-email-borntraeger@de.ibm.com>
References: <1425647812-61838-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1425647812-61838-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Alexander Yarygin <yarygin@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Alexander Yarygin <yarygin@linux.vnet.ibm.com>

The guest debug functions work on absolute addresses and should use the
read_guest_abs() function rather than general read_guest() that
works with logical addresses.

Cc: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Alexander Yarygin <yarygin@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/guestdbg.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
index 3e8d409..e97b345 100644
--- a/arch/s390/kvm/guestdbg.c
+++ b/arch/s390/kvm/guestdbg.c
@@ -191,8 +191,8 @@ static int __import_wp_info(struct kvm_vcpu *vcpu,
 	if (!wp_info->old_data)
 		return -ENOMEM;
 	/* try to backup the original value */
-	ret = read_guest(vcpu, wp_info->phys_addr, wp_info->old_data,
-			 wp_info->len);
+	ret = read_guest_abs(vcpu, wp_info->phys_addr, wp_info->old_data,
+			     wp_info->len);
 	if (ret) {
 		kfree(wp_info->old_data);
 		wp_info->old_data = NULL;
@@ -362,8 +362,8 @@ static struct kvm_hw_wp_info_arch *any_wp_changed(struct kvm_vcpu *vcpu)
 			continue;
 
 		/* refetch the wp data and compare it to the old value */
-		if (!read_guest(vcpu, wp_info->phys_addr, temp,
-				wp_info->len)) {
+		if (!read_guest_abs(vcpu, wp_info->phys_addr, temp,
+				    wp_info->len)) {
 			if (memcmp(temp, wp_info->old_data, wp_info->len)) {
 				kfree(temp);
 				return wp_info;
-- 
2.3.0
