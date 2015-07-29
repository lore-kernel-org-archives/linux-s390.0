Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 29 Jul 2015 09:20:07 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.2-rc5
Message-ID: <20150729092007.0b647979@mschwide>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stephen Powell <zlinuxman@wowway.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:
Two bug fixes:
 - Fix a crash on pre-z10 hardware due to cache-info
 - Fix an issue with classic BPF programs in the eBPF JIT

Heiko Carstens (1):
      s390/cachinfo: add missing facility check to init_cache_level()

Michael Holzheu (1):
      s390/bpf: clear correct BPF accumulator register

 arch/s390/kernel/cache.c     |  2 ++
 arch/s390/net/bpf_jit_comp.c | 14 +++++++-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kernel/cache.c b/arch/s390/kernel/cache.c
index bff5e3b..8ba3243 100644
--- a/arch/s390/kernel/cache.c
+++ b/arch/s390/kernel/cache.c
@@ -138,6 +138,8 @@ int init_cache_level(unsigned int cpu)
 	union cache_topology ct;
 	enum cache_type ctype;
 
+	if (!test_facility(34))
+		return -EOPNOTSUPP;
 	if (!this_cpu_ci)
 		return -EINVAL;
 	ct.raw = ecag(EXTRACT_TOPOLOGY, 0, 0);
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index fee782a..8d2e516 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -448,13 +448,13 @@ static void bpf_jit_prologue(struct bpf_jit *jit)
 		EMIT6_DISP_LH(0xe3000000, 0x0004, REG_SKB_DATA, REG_0,
 			      BPF_REG_1, offsetof(struct sk_buff, data));
 	}
-	/* BPF compatibility: clear A (%b7) and X (%b8) registers */
-	if (REG_SEEN(BPF_REG_7))
-		/* lghi %b7,0 */
-		EMIT4_IMM(0xa7090000, BPF_REG_7, 0);
-	if (REG_SEEN(BPF_REG_8))
-		/* lghi %b8,0 */
-		EMIT4_IMM(0xa7090000, BPF_REG_8, 0);
+	/* BPF compatibility: clear A (%b0) and X (%b7) registers */
+	if (REG_SEEN(BPF_REG_A))
+		/* lghi %ba,0 */
+		EMIT4_IMM(0xa7090000, BPF_REG_A, 0);
+	if (REG_SEEN(BPF_REG_X))
+		/* lghi %bx,0 */
+		EMIT4_IMM(0xa7090000, BPF_REG_X, 0);
 }
 
 /*
