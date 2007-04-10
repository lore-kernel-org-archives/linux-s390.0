Return-Path: <linux-kernel-owner+w=401wt.eu-S965105AbXDJMWG@vger.kernel.org>
Date: Tue, 10 Apr 2007 14:24:21 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: 2.6.21-rc6-mm1
Message-ID: <20070410142421.519eb62c@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20070408143559.f5014629.akpm@linux-foundation.org>
References: <20070408143559.f5014629.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Sun, 8 Apr 2007 14:35:59 -0700,
Andrew Morton <akpm@linux-foundation.org> wrote:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.21-rc6/2.6.21-rc6-mm1/

> +kprobes-the-on-off-knob-thru-debugfs-updated.patch
> +kprobes-the-on-off-knob-thru-debugfs-updated-fix.patch
> 
>  kprobes work

Add the missing arch_trampoline_kprobe() for s390.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---
 arch/s390/kernel/kprobes.c |    7 +++++++
 1 files changed, 7 insertions(+)

--- linux-2.6.21-rc6-mm1.orig/arch/s390/kernel/kprobes.c
+++ linux-2.6.21-rc6-mm1/arch/s390/kernel/kprobes.c
@@ -662,3 +662,10 @@ int __init arch_init_kprobes(void)
 {
 	return register_kprobe(&trampoline_p);
 }
+
+int __kprobes arch_trampoline_kprobe(struct kprobe *p)
+{
+	if (p->addr == (kprobe_opcode_t *) & kretprobe_trampoline)
+		return 1;
+	return 0;
+}
