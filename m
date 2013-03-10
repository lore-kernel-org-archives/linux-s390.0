Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Stelian Nirlu <steliannirlu@gmail.com>
Subject: [PATCH] s390: replace kmalloc + memset with kzalloc
Date: Sun, 10 Mar 2013 15:13:25 +0200
Message-Id: <1362921205-10295-1-git-send-email-steliannirlu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com
Cc: heiko.carstens@de.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Stelian Nirlu <steliannirlu@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Stelian Nirlu <steliannirlu@gmail.com>
---
 arch/s390/net/bpf_jit_comp.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 0972e91..e645528 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -747,10 +747,9 @@ void bpf_jit_compile(struct sk_filter *fp)
 
 	if (!bpf_jit_enable)
 		return;
-	addrs = kmalloc(fp->len * sizeof(*addrs), GFP_KERNEL);
+	addrs = kzalloc(fp->len * sizeof(*addrs), GFP_KERNEL);
 	if (addrs == NULL)
 		return;
-	memset(addrs, 0, fp->len * sizeof(*addrs));
 	memset(&jit, 0, sizeof(cjit));
 	memset(&cjit, 0, sizeof(cjit));
 
-- 
1.7.10.4
