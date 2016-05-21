From: Andrea Gelmini <andrea.gelmini@gelma.net>
Date: Sat, 21 May 2016 12:09:12 +0000
Subject: [PATCH 0251/1529] Fix typo
Message-Id: <20160521120912.13155-1-andrea.gelmini@gelma.net>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/s390/net/bpf_jit_comp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 9133b0e..8476aef 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -410,7 +410,7 @@ static void emit_load_skb_data_hlen(struct bpf_jit *jit)
  * Emit function prologue
  *
  * Save registers and create stack frame if necessary.
- * See stack frame layout desription in "bpf_jit.h"!
+ * See stack frame layout description in "bpf_jit.h"!
  */
 static void bpf_jit_prologue(struct bpf_jit *jit)
 {
@@ -1305,7 +1305,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	/*
 	 * Three initial passes:
 	 *   - 1/2: Determine clobbered registers
-	 *   - 3:   Calculate program size and addrs arrray
+	 *   - 3:   Calculate program size and addrs array
 	 */
 	for (pass = 1; pass <= 3; pass++) {
 		if (bpf_jit_prog(&jit, fp)) {
-- 
2.8.2.534.g1f66975
