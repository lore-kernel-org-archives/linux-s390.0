Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 3 Jun 2016 10:48:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [lockdep] chain_key collision check triggers
Message-ID: <20160603084801.GG3190@twins.programming.kicks-ass.net>
References: <20160603071544.GA3472@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160603071544.GA3472@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Alfredo Alvarez Fernandez <alfredoalvarezfernandez@gmail.com>, Ingo Molnar <mingo@kernel.org>, Shuah Khan <shuahkh@osg.samsung.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Jun 03, 2016 at 09:15:44AM +0200, Heiko Carstens wrote:
> Hi all,
> 
> the new lockdep chain_key collision detection code triggers quite reliably
> on s390, so it looks like we need a different iterate_chain_key()
> implementation?

That too, I have one queued up; but if you can realiably trigger this
that's 'good' news. Most reports so far have been one offs that people
could not reproduce.

Let me wake up a bit more, but in the meantime, the below is what I had
queued.

---
Subject: locking,lockdep: Use __jhash_mix for iterate_chain_key
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon May 30 18:31:33 CEST 2016

Use __jhash_mix() to mix the class_idx into the class_key. This
function provides better mixing than the previously used, home grown
mix function.

Leave hashing to the professionals :-)

Cc: torvalds@linux-foundation.org
Suggested-by: George Spelvin <linux@sciencehorizons.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/lockdep.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -46,6 +46,7 @@
 #include <linux/gfp.h>
 #include <linux/kmemcheck.h>
 #include <linux/random.h>
+#include <linux/jhash.h>
 
 #include <asm/sections.h>
 
@@ -309,10 +310,14 @@ static struct hlist_head chainhash_table
  * It's a 64-bit hash, because it's important for the keys to be
  * unique.
  */
-#define iterate_chain_key(key1, key2) \
-	(((key1) << MAX_LOCKDEP_KEYS_BITS) ^ \
-	((key1) >> (64-MAX_LOCKDEP_KEYS_BITS)) ^ \
-	(key2))
+static inline u64 iterate_chain_key(u64 key, u32 idx)
+{
+	u32 k0 = key, k1 = key >> 32;
+
+	__jhash_mix(idx, k0, k1); /* Macro that modifies arguments! */
+
+	return k0 | (u64)k1 << 32;
+}
 
 void lockdep_off(void)
 {
