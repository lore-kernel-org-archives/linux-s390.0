Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 12 Apr 2019 22:56:21 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] Documentation: Add ARM64 to kernel-parameters.rst
Message-ID: <20190413035621.tohihjksatqushwf@treble>
References: <cover.1555085500.git.jpoimboe@redhat.com>
 <24039e1370ed57e8075730c0b88c505afd9e0ab7.1555085500.git.jpoimboe@redhat.com>
 <25174c3c-0e39-0562-7d02-bb7d51cd2b43@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <25174c3c-0e39-0562-7d02-bb7d51cd2b43@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190413035621.wE3OAQSYZeL_4ZQXq-824clmJqQWdltIXGbDVdPqcQw@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Kosina <jikos@kernel.org>, Waiman Long <longman@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Jon Masters <jcm@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tyler Hicks <tyhicks@canonical.com>, Linus Torvalds <torvalds@linux-foundation.org>, Steven Price <steven.price@arm.com>, Phil Auld <pauld@redhat.com>, Jonathan Corbet <corbet@lwn.net>
List-ID: <linux-s390.vger.kernel.org>

Add ARM64 to the legend of architectures.  It's already used in several
places in kernel-parameters.txt.

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index b8d0bc07ed0a..0124980dca2d 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -88,6 +88,7 @@ parameter is applicable::
 	APIC	APIC support is enabled.
 	APM	Advanced Power Management support is enabled.
 	ARM	ARM architecture is enabled.
+	ARM64	ARM64 architecture is enabled.
 	AX25	Appropriate AX.25 support is enabled.
 	CLK	Common clock infrastructure is enabled.
 	CMA	Contiguous Memory Area support is enabled.
-- 
2.17.2
