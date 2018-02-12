Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
Subject: [PATCH 01/17] kexec_file: Silence compile warnings
Date: Mon, 12 Feb 2018 11:07:38 +0100
In-Reply-To: <20180212100754.55121-1-prudo@linux.vnet.ibm.com>
References: <20180212100754.55121-1-prudo@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20180212100754.55121-2-prudo@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: kexec@lists.infradead.org, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
List-ID: <linux-s390.vger.kernel.org>

When building the kernel with CONFIG_KEXEC_FILE enabled gcc prints a
compile warning multiple times.

In file included from <path>/linux/init/initramfs.c:526:0:
<path>/include/linux/kexec.h:120:9: warning: ‘struct kimage’ declared inside parameter list [enabled by default]
         unsigned long cmdline_len);
         ^
This is because the typedefs for kexec_file_load uses struct kimage before
it is declared. Fix this by simply forward declaring struct kimage.

Signed-off-by: Philipp Rudo <prudo@linux.vnet.ibm.com>
---
 include/linux/kexec.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f16f6ceb3875..7bae5e87bf0d 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -114,6 +114,8 @@ struct purgatory_info {
 	unsigned long purgatory_load_addr;
 };
 
+struct kimage;
+
 typedef int (kexec_probe_t)(const char *kernel_buf, unsigned long kernel_size);
 typedef void *(kexec_load_t)(struct kimage *image, char *kernel_buf,
 			     unsigned long kernel_len, char *initrd,
-- 
2.13.5
