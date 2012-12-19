From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 2/5] KVM: s390: Add support for machine checks.
Date: Wed, 19 Dec 2012 10:44:14 +0100
Message-ID: <20121219094414.GA4996@osiris.de.ibm.com>
References: <1354883425-38531-1-git-send-email-cornelia.huck@de.ibm.com>
 <1354883425-38531-3-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1354883425-38531-3-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Avi Kivity <avi.kivity@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Dec 07, 2012 at 01:30:22PM +0100, Cornelia Huck wrote:
> +		rc = put_guest_u64(vcpu, __LC_MCCK_CODE, inti->mchk.mcic);
> +		if (rc == -EFAULT)
> +			exception = 1;
> +
> +		rc = copy_to_guest(vcpu, __LC_MCK_OLD_PSW,
> +				   &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
> +		if (rc == -EFAULT)
> +			exception = 1;

Please don't add more explicit -EFAULT checks on guest access paths. Just
make this like normal user space accesses. That is return code != 0 means
an error occured:

	rc = put_guest_u64(vcpu, __LC_MCCK_CODE, inti->mchk.mcic);
	if (rc)
		exception = 1;

In fact, with the current kvm gaccess code it's even broken, since on error
the guest access functions may return also -ENOMEM instead of -EFAULT, which
would be ignored by your code.
I addressed that with a patch when trying to clean up the guest access
functions. Maybe the patch below should be merged anyway. Christian?


===================


From db05454b6f3f49a7a10f5a1e546917303cf94532 Mon Sep 17 00:00:00 2001
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Mon, 10 Sep 2012 16:36:23 +0200
Subject: s390/kvm,gaccess: fix guest access return code handling

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
1.7.12.4
