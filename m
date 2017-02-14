Return-Path: <jpoimboe@redhat.com>
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v5 11/15] livepatch: use kstrtobool() in enabled_store()
Date: Mon, 13 Feb 2017 19:42:38 -0600
Message-Id: <e02151323313bd3d5ec2d2afa08ee780d95528cc.1487036215.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1487036215.git.jpoimboe@redhat.com>
References: <cover.1487036215.git.jpoimboe@redhat.com>
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

The sysfs enabled value is a boolean, so kstrtobool() is a better fit
for parsing the input string since it does the range checking for us.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/livepatch/core.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 6a137e1..83c4949 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -408,26 +408,23 @@ static ssize_t enabled_store(struct kobject *kobj, struct kobj_attribute *attr,
 {
 	struct klp_patch *patch;
 	int ret;
-	unsigned long val;
+	bool enabled;
 
-	ret = kstrtoul(buf, 10, &val);
+	ret = kstrtobool(buf, &enabled);
 	if (ret)
-		return -EINVAL;
-
-	if (val > 1)
-		return -EINVAL;
+		return ret;
 
 	patch = container_of(kobj, struct klp_patch, kobj);
 
 	mutex_lock(&klp_mutex);
 
-	if (patch->enabled == val) {
+	if (patch->enabled == enabled) {
 		/* already in requested state */
 		ret = -EINVAL;
 		goto err;
 	}
 
-	if (val) {
+	if (enabled) {
 		ret = __klp_enable_patch(patch);
 		if (ret)
 			goto err;
-- 
2.7.4
