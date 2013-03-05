From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/8] s390/kvm,gaccess: fix guest access return code handling
Date: Tue,  5 Mar 2013 13:14:40 +0100
Message-ID: <1362485687-2799-2-git-send-email-borntraeger@de.ibm.com>
References: <1362485687-2799-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1362485687-2799-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tossati <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Guest access functions like copy_to/from_guest() call __guestaddr_to_user()
which in turn call gmap_fault() in order to translate a guest address to a
user space address.
In error case __guest_addr_to_user() returns either -EFAULT or -ENOMEM.
The copy_to/from_guest functions just pass these return values down to the
callers.
The -ENOMEM case however is problematic since there are several places
which access guest memory like:

rc = copy_to_guest(...);
if (rc == -EFAULT)
	error_handling();

So in case of -ENOMEM the code assumes that the guest memory access
succeeded even though it failed.
This can cause guest data or state corruption.

If __guestaddr_to_user() returns -ENOMEM the meaning is that a valid user
space mapping exists, but there was not enough memory available when trying
to build the guest mapping. In other words an out-of-memory situation
occured.
For normal user space accesses an out-of-memory situation causes the page
fault handler to map -ENOMEM to -EFAULT (see fixup code in do_no_context()).
We need to do exactly the same for the kvm gaccess functions.

So __guestaddr_to_user() should just map all error codes to -EFAULT.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/gaccess.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index 4703f12..84d01dd 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -22,13 +22,16 @@ static inline void __user *__guestaddr_to_user(struct kvm_vcpu *vcpu,
 					       unsigned long guestaddr)
 {
 	unsigned long prefix  = vcpu->arch.sie_block->prefix;
+	unsigned long uaddress;
 
 	if (guestaddr < 2 * PAGE_SIZE)
 		guestaddr += prefix;
 	else if ((guestaddr >= prefix) && (guestaddr < prefix + 2 * PAGE_SIZE))
 		guestaddr -= prefix;
-
-	return (void __user *) gmap_fault(guestaddr, vcpu->arch.gmap);
+	uaddress = gmap_fault(guestaddr, vcpu->arch.gmap);
+	if (IS_ERR_VALUE(uaddress))
+		uaddress = -EFAULT;
+	return (void __user *)uaddress;
 }
 
 static inline int get_guest_u64(struct kvm_vcpu *vcpu, unsigned long guestaddr,
-- 
1.8.0.1
