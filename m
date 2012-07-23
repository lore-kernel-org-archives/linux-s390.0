From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 1/3] s390/dis: Instruction decoding interface.
Date: Mon, 23 Jul 2012 17:20:28 +0200
Message-ID: <1343056830-45290-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1343056830-45290-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1343056830-45290-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Provide a new function, insn_to_mnemonic, by which e.g. kvm can obtain
a human-readable decoding of an instruction's opcode.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/include/asm/processor.h |  1 +
 arch/s390/kernel/dis.c            | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 20d0585..dc99b6e 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -140,6 +140,7 @@ extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
 extern unsigned long thread_saved_pc(struct task_struct *t);
 
 extern void show_code(struct pt_regs *regs);
+extern int insn_to_mnemonic(unsigned char *instruction, char buf[8]);
 
 unsigned long get_wchan(struct task_struct *p);
 #define task_pt_regs(tsk) ((struct pt_regs *) \
diff --git a/arch/s390/kernel/dis.c b/arch/s390/kernel/dis.c
index 3221c6f..8e7088e 100644
--- a/arch/s390/kernel/dis.c
+++ b/arch/s390/kernel/dis.c
@@ -1469,6 +1469,33 @@ static struct insn *find_insn(unsigned char *code)
 	return NULL;
 }
 
+/**
+ * insn_to_mnemonic - decode an s390 instruction
+ * @instruction: instruction to decode
+ * @buf: buffer to fill with mnemonic
+ *
+ * Decode the instruction at @instruction and store the corresponding
+ * mnemonic into @buf.
+ * @buf is left unchanged if the instruction could not be decoded.
+ * Returns:
+ *  %0 on success, %-ENOENT if the instruction was not found.
+ */
+int insn_to_mnemonic(unsigned char *instruction, char buf[8])
+{
+	struct insn *insn;
+
+	insn = find_insn(instruction);
+	if (!insn)
+		return -ENOENT;
+	if (insn->name[0] == '\0')
+		snprintf(buf, sizeof(buf), "%s",
+			 long_insn_name[(int) insn->name[1]]);
+	else
+		snprintf(buf, sizeof(buf), "%.5s", insn->name);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(insn_to_mnemonic);
+
 static int print_insn(char *buffer, unsigned char *code, unsigned long addr)
 {
 	struct insn *insn;
-- 
1.7.11.2
