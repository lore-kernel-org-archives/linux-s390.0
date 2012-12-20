From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 1/7] KVM: s390: Constify intercept handler tables.
Date: Thu, 20 Dec 2012 15:32:06 +0100
Message-ID: <1356013932-23775-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1356013932-23775-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1356013932-23775-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

These tables are never modified.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/intercept.c | 2 +-
 arch/s390/kvm/priv.c      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 22798ec..0c08b3f 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -104,7 +104,7 @@ static int handle_lctl(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-static intercept_handler_t instruction_handlers[256] = {
+static const intercept_handler_t instruction_handlers[256] = {
 	[0x01] = kvm_s390_handle_01,
 	[0x83] = kvm_s390_handle_diag,
 	[0xae] = kvm_s390_handle_sigp,
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index d768906..1aeb933 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -297,7 +297,7 @@ out_fail:
 	return 0;
 }
 
-static intercept_handler_t priv_handlers[256] = {
+static const intercept_handler_t priv_handlers[256] = {
 	[0x02] = handle_stidp,
 	[0x10] = handle_set_prefix,
 	[0x11] = handle_store_prefix,
@@ -405,7 +405,7 @@ static int handle_sckpf(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-static intercept_handler_t x01_handlers[256] = {
+static const intercept_handler_t x01_handlers[256] = {
 	[0x07] = handle_sckpf,
 };
 
-- 
1.7.12.4
