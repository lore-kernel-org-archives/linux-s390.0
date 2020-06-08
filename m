Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.6 185/606] s390/kaslr: add support for R_390_JMP_SLOT relocation type
Date: Mon,  8 Jun 2020 19:05:10 -0400
Message-Id: <20200608231211.3363633-185-sashal@kernel.org>
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>, Philipp Rudo <prudo@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-s390@vger.kernel.org

From: Gerald Schaefer <gerald.schaefer@de.ibm.com>

commit 4c1cbcbd6c56c79de2c07159be4f55386bb0bef2 upstream.

With certain kernel configurations, the R_390_JMP_SLOT relocation type
might be generated, which is not expected by the KASLR relocation code,
and the kernel stops with the message "Unknown relocation type".

This was found with a zfcpdump kernel config, where CONFIG_MODULES=n
and CONFIG_VFIO=n. In that case, symbol_get() is used on undefined
__weak symbols in virt/kvm/vfio.c, which results in the generation
of R_390_JMP_SLOT relocation types.

Fix this by handling R_390_JMP_SLOT similar to R_390_GLOB_DAT.

Fixes: 805bc0bc238f ("s390/kernel: build a relocatable kernel")
Cc: <stable@vger.kernel.org> # v5.2+
Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Reviewed-by: Philipp Rudo <prudo@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/machine_kexec_reloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kernel/machine_kexec_reloc.c b/arch/s390/kernel/machine_kexec_reloc.c
index d5035de9020e..b7182cec48dc 100644
--- a/arch/s390/kernel/machine_kexec_reloc.c
+++ b/arch/s390/kernel/machine_kexec_reloc.c
@@ -28,6 +28,7 @@ int arch_kexec_do_relocs(int r_type, void *loc, unsigned long val,
 		break;
 	case R_390_64:		/* Direct 64 bit.  */
 	case R_390_GLOB_DAT:
+	case R_390_JMP_SLOT:
 		*(u64 *)loc = val;
 		break;
 	case R_390_PC16:	/* PC relative 16 bit.	*/
-- 
2.25.1
