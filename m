From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PULL 4/9] KVM: s390: Do not set CC3 for EQBS and SQBS
Date: Thu, 28 Nov 2013 15:06:53 +0100
Message-ID: <1385647618-15541-5-git-send-email-cornelia.huck@de.ibm.com>
References: <1385647618-15541-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1385647618-15541-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Thomas Huth <thuth@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

The EQBS and SQBS instructions do not set CC3 for invalid channels, but
should throw an operation exception instead when not available. Thus they
should not be handled by the handle_io_inst() wrapper but drop to userspace
instead (which will then inject the operation exception).

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/priv.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index b18fe52..05537ab 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -638,7 +638,6 @@ static int handle_pfmf(struct kvm_vcpu *vcpu)
 
 static const intercept_handler_t b9_handlers[256] = {
 	[0x8d] = handle_epsw,
-	[0x9c] = handle_io_inst,
 	[0xaf] = handle_pfmf,
 };
 
@@ -731,7 +730,6 @@ static int handle_lctlg(struct kvm_vcpu *vcpu)
 
 static const intercept_handler_t eb_handlers[256] = {
 	[0x2f] = handle_lctlg,
-	[0x8a] = handle_io_inst,
 };
 
 int kvm_s390_handle_eb(struct kvm_vcpu *vcpu)
-- 
1.7.9.5
