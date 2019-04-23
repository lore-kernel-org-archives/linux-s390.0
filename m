Return-Path: <linux-arch-owner@vger.kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 04/10] mtd: rawnand: vf610_nfc: add initializer to avoid -Wmaybe-uninitialized
Date: Tue, 23 Apr 2019 12:21:00 +0900
Message-ID: <20190423032106.11960-5-yamada.masahiro@socionext.com>
In-Reply-To: <20190423032106.11960-1-yamada.masahiro@socionext.com>
References: <20190423032106.11960-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190423032100._diWjsOHiU5Qe_uXgyChCNndQzWYksZFm_QyfE2YoKM@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Christophe Leroy <christophe.leroy@c-s.fr>, Mathieu Malaterre <malat@debian.org>, Masahiro Yamada <yamada.masahiro@socionext.com>
List-ID: <linux-s390.vger.kernel.org>

This prepares to move CONFIG_OPTIMIZE_INLINING from x86 to a common
place. We need to eliminate potential issues beforehand.

Kbuild test robot has never reported -Wmaybe-uninitialized warning
for this probably because vf610_nfc_run() is inlined by the x86
compiler's inlining heuristic.

If CONFIG_OPTIMIZE_INLINING is enabled for a different architecture
and vf610_nfc_run() is not inlined, the following warning is reported:

drivers/mtd/nand/raw/vf610_nfc.c: In function ‘vf610_nfc_cmd’:
drivers/mtd/nand/raw/vf610_nfc.c:455:3: warning: ‘offset’ may be used uninitialized in this function [-Wmaybe-uninitialized]
   vf610_nfc_rd_from_sram(instr->ctx.data.buf.in + offset,
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            nfc->regs + NFC_MAIN_AREA(0) + offset,
            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            trfr_sz, !nfc->data_access);
            ~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3: None
Changes in v2:
  - split into a separate patch

 drivers/mtd/nand/raw/vf610_nfc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
index a662ca1970e5..19792d725ec2 100644
--- a/drivers/mtd/nand/raw/vf610_nfc.c
+++ b/drivers/mtd/nand/raw/vf610_nfc.c
@@ -364,7 +364,7 @@ static int vf610_nfc_cmd(struct nand_chip *chip,
 {
 	const struct nand_op_instr *instr;
 	struct vf610_nfc *nfc = chip_to_nfc(chip);
-	int op_id = -1, trfr_sz = 0, offset;
+	int op_id = -1, trfr_sz = 0, offset = 0;
 	u32 col = 0, row = 0, cmd1 = 0, cmd2 = 0, code = 0;
 	bool force8bit = false;
 
-- 
2.17.1
