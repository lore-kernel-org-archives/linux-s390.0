From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 08/11] KVM: s390: fix compile with !CONFIG_COMPAT
Date: Mon, 25 Mar 2013 17:22:55 +0100
Message-ID: <1364228578-20528-9-git-send-email-cornelia.huck@de.ibm.com>
References: <1364228578-20528-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1364228578-20528-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

=46rom: Heiko Carstens <heiko.carstens@de.ibm.com>

arch/s390/kvm/priv.c should include both
linux/compat.h and asm/compat.h.
=46ixes this one:

In file included from arch/s390/kvm/priv.c:23:0:
arch/s390/include/asm/compat.h: In function =E2=80=98arch_compat_alloc_=
user_space=E2=80=99:
arch/s390/include/asm/compat.h:258:2: error: implicit declaration of fu=
nction =E2=80=98is_compat_task=E2=80=99

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/priv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index de1b1b6..6bbd7b5 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -14,6 +14,7 @@
 #include <linux/kvm.h>
 #include <linux/gfp.h>
 #include <linux/errno.h>
+#include <linux/compat.h>
 #include <asm/asm-offsets.h>
 #include <asm/current.h>
 #include <asm/debug.h>
--=20
1.7.12.4
