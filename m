Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51134 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730824AbgDQOEy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 17 Apr 2020 10:04:54 -0400
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v2 5/9] s390: Change s390_kernel_write() return type to match memcpy()
Date: Fri, 17 Apr 2020 09:04:30 -0500
Message-Id: <8194db48a4aa32caf55fb028669a48ab9ab3c874.1587131959.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1587131959.git.jpoimboe@redhat.com>
References: <cover.1587131959.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: live-patching@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jessica Yu <jeyu@kernel.org>, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com

s390_kernel_write()'s function type is almost identical to memcpy().
Change its return type to "void *" so they can be used interchangeably.

Cc: linux-s390@vger.kernel.org
Cc: heiko.carstens@de.ibm.com
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/s390/include/asm/uaccess.h | 2 +-
 arch/s390/mm/maccess.c          | 9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uacc=
ess.h
index a470f1fa9f2a..324438889fe1 100644
--- a/arch/s390/include/asm/uaccess.h
+++ b/arch/s390/include/asm/uaccess.h
@@ -276,6 +276,6 @@ static inline unsigned long __must_check clear_user(v=
oid __user *to, unsigned lo
 }
=20
 int copy_to_user_real(void __user *dest, void *src, unsigned long count)=
;
-void s390_kernel_write(void *dst, const void *src, size_t size);
+void *s390_kernel_write(void *dst, const void *src, size_t size);
=20
 #endif /* __S390_UACCESS_H */
diff --git a/arch/s390/mm/maccess.c b/arch/s390/mm/maccess.c
index de7ca4b6718f..22a0be655f27 100644
--- a/arch/s390/mm/maccess.c
+++ b/arch/s390/mm/maccess.c
@@ -55,19 +55,22 @@ static notrace long s390_kernel_write_odd(void *dst, =
const void *src, size_t siz
  */
 static DEFINE_SPINLOCK(s390_kernel_write_lock);
=20
-void notrace s390_kernel_write(void *dst, const void *src, size_t size)
+notrace void *s390_kernel_write(void *dst, const void *src, size_t size)
 {
+	void *tmp =3D dst;
 	unsigned long flags;
 	long copied;
=20
 	spin_lock_irqsave(&s390_kernel_write_lock, flags);
 	while (size) {
-		copied =3D s390_kernel_write_odd(dst, src, size);
-		dst +=3D copied;
+		copied =3D s390_kernel_write_odd(tmp, src, size);
+		tmp +=3D copied;
 		src +=3D copied;
 		size -=3D copied;
 	}
 	spin_unlock_irqrestore(&s390_kernel_write_lock, flags);
+
+	return dst;
 }
=20
 static int __no_sanitize_address __memcpy_real(void *dest, void *src, si=
ze_t count)
--=20
2.21.1
