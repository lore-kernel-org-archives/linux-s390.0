Return-Path: <jpoimboe@redhat.com>
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v4 09/15] livepatch: remove unnecessary object loaded check
Date: Thu, 19 Jan 2017 09:46:17 -0600
Message-Id: <8caf49b90f4783afdc366f9005d8d51e104b858d.1484839971.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1484839971.git.jpoimboe@redhat.com>
References: <cover.1484839971.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

klp_patch_object()'s callers already ensure that the object is loaded,
so its call to klp_is_object_loaded() is unnecessary.

This will also make it possible to move the patching code into a
separate file.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
---
 kernel/livepatch/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 2dbd355..47ed643 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -467,9 +467,6 @@ static int klp_patch_object(struct klp_object *obj)
 	if (WARN_ON(obj->patched))
 		return -EINVAL;
 
-	if (WARN_ON(!klp_is_object_loaded(obj)))
-		return -EINVAL;
-
 	klp_for_each_func(obj, func) {
 		ret = klp_patch_func(func);
 		if (ret) {
-- 
2.7.4
