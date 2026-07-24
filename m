Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701082FF66B;
	Fri, 24 Jul 2026 02:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784859316; cv=none; b=fJWX7Fnk/Y6qCv4L2a0/Yh8QhiDwi7nm3n1Tj4ZPGPZ8X5xy7rcUmLb/g5PkjM3u6T6DULIWeV7ZFH5rIA5wzFsPp/dhJm35SL3i3Q3D2lP/6H5RRmTx6LvvnbGg8EcoEYEVFh8YCgvl4i+qL13eFzkgLN9cf5xIB/WYopGmt6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784859316; c=relaxed/simple;
	bh=x64qnH7Z/XVRp3jXlI8bXqnYx5shnHKsoZa88m5xpUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDFvX4shJW3iO5nm2ldr8iMrNXJG+maC3CyUDFUkO3Ayk20Gvhp5GzeXlRch3oYvKou1yzKDu8mWFHKf7hxobt9RrJvlCmeKn6W19WufKH8Q1VK+919j8xD2lhnR3Nwi3dUT/BrL+XjjibCMk01xKqKG5SV2/3Mnu/f2HjlK5QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Ga9yHEXd; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Ga9yHEXd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=vK
	m5ZaQZj0/THfOt/BL4ITNpCCG/uj8gX537c+qR0iw=; b=Ga9yHEXdoLJFjcSNzQ
	kblZe0nP9Lq0t3mLP48fAt0rVtKqCI47c/it0BDYEvvgmYxr2oJqsUYJx39DLurs
	0o3nGrT0xqh56ofmseQs8Dlc8H6w0vIo+waJfzbmkSOZY1dUrktpq0AEsnd6tWEw
	tHHQG8jqLBHiIIjjTcUjI4fr4=
Received: from song-MS-7D48.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSkvCgDnr+wRymJqH7z4DA--.34972S5;
	Fri, 24 Jul 2026 10:12:47 +0800 (CST)
From: Song Chen <chensong_2000@126.com>
To: arnd@arndb.de,
	kees@kernel.org,
	clm@fb.com,
	dsterba@suse.com,
	linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	guoren@kernel.org,
	kernel@xen0n.name,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	agordeev@linux.ibm.com,
	svens@linux.ibm.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	jpoimboe@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Chen <chensong_2000@126.com>
Subject: [RFC PATCH v2 3/3] error-injection: Introduce parent in fei_attr
Date: Fri, 24 Jul 2026 10:12:29 +0800
Message-ID: <20260724021229.47302-4-chensong_2000@126.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724021229.47302-1-chensong_2000@126.com>
References: <20260724021229.47302-1-chensong_2000@126.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSkvCgDnr+wRymJqH7z4DA--.34972S5
X-Coremail-Antispam: 1Uf129KBjvJXoWfJF1kurW7uFWfArWkuw4UJwb_yoWDXF1fpF
	y3A3srWrWrWw1rGrZrAa1rZw1FkrsxZFy7AFyxGa4fu39IqFyIqF1fWa4jqF4SvrWDGay7
	XFs8trW5tF15uFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ug0eXUUUUU=
X-CM-SenderInfo: xfkh02prqjsjqqqqqiyswou0bp/xtbBsx-sbGpiyh9OEgAA3t

Add a parent field to fei_attr to allow fault injection on a function
only when called from a specific parent function. This enables more
precise fault injection control, for example, injecting failures into
btrfs_data_csum_ok() only when called from btrfs_check_read_bio(),
not from btrfs_end_repair_bio().

Introduce fei_return_address() in each architecture's error-injection.c
(x86, arm64, riscv, loongarch) to retrieve the return address from
pt_regs in a kprobe handler, following the same pattern as the existing
override_function_with_return(). A new parent debugfs file is added
under /sys/kernel/debug/fail_function/<func>/ to configure the filter.

Usage:
  echo "btrfs_data_csum_ok" > /sys/kernel/debug/fail_function/inject
  echo 0   > /sys/kernel/debug/fail_function/btrfs_data_csum_ok/retval
  echo 100 > /sys/kernel/debug/fail_function/probability
  echo 10  > /sys/kernel/debug/fail_function/times
  echo "btrfs_check_read_bio" > \
      /sys/kernel/debug/fail_function/btrfs_data_csum_ok/parent

  To clear the parent filter:
  echo "" > /sys/kernel/debug/fail_function/btrfs_data_csum_ok/parent

Signed-off-by: Song Chen <chensong_2000@126.com>
---
 arch/arm/lib/error-inject.c           |  6 ++
 arch/arm64/lib/error-inject.c         |  6 ++
 arch/csky/lib/error-inject.c          |  6 ++
 arch/loongarch/lib/error-inject.c     |  6 ++
 arch/powerpc/lib/error-inject.c       |  6 ++
 arch/riscv/lib/error-inject.c         |  6 ++
 arch/s390/lib/error-inject.c          |  6 ++
 arch/x86/lib/error-inject.c           |  6 ++
 include/asm-generic/error-injection.h |  5 ++
 kernel/fail_function.c                | 96 ++++++++++++++++++++++++++-
 10 files changed, 148 insertions(+), 1 deletion(-)

diff --git a/arch/arm/lib/error-inject.c b/arch/arm/lib/error-inject.c
index 5a5b405792ba..1f7a482555ea 100644
--- a/arch/arm/lib/error-inject.c
+++ b/arch/arm/lib/error-inject.c
@@ -8,3 +8,9 @@ void override_function_with_return(struct pt_regs *regs)
 	instruction_pointer_set(regs, regs->ARM_lr);
 }
 NOKPROBE_SYMBOL(override_function_with_return);
+
+unsigned long fei_return_address(struct pt_regs *regs)
+{
+	return regs->ARM_lr;
+}
+NOKPROBE_SYMBOL(fei_return_address);
diff --git a/arch/arm64/lib/error-inject.c b/arch/arm64/lib/error-inject.c
index ed15021da3ed..ccd33c92bb37 100644
--- a/arch/arm64/lib/error-inject.c
+++ b/arch/arm64/lib/error-inject.c
@@ -16,3 +16,9 @@ void override_function_with_return(struct pt_regs *regs)
 	instruction_pointer_set(regs, procedure_link_pointer(regs));
 }
 NOKPROBE_SYMBOL(override_function_with_return);
+
+unsigned long fei_return_address(struct pt_regs *regs)
+{
+	return procedure_link_pointer(regs);
+}
+NOKPROBE_SYMBOL(fei_return_address);
diff --git a/arch/csky/lib/error-inject.c b/arch/csky/lib/error-inject.c
index c15fb36fe067..c7a1b3948c76 100644
--- a/arch/csky/lib/error-inject.c
+++ b/arch/csky/lib/error-inject.c
@@ -8,3 +8,9 @@ void override_function_with_return(struct pt_regs *regs)
 	instruction_pointer_set(regs, regs->lr);
 }
 NOKPROBE_SYMBOL(override_function_with_return);
+
+unsigned long fei_return_address(struct pt_regs *regs)
+{
+	return regs->lr;
+}
+NOKPROBE_SYMBOL(fei_return_address);
diff --git a/arch/loongarch/lib/error-inject.c b/arch/loongarch/lib/error-inject.c
index afc9e1c7c973..844356fef828 100644
--- a/arch/loongarch/lib/error-inject.c
+++ b/arch/loongarch/lib/error-inject.c
@@ -8,3 +8,9 @@ void override_function_with_return(struct pt_regs *regs)
 	instruction_pointer_set(regs, regs->regs[1]);
 }
 NOKPROBE_SYMBOL(override_function_with_return);
+
+unsigned long fei_return_address(struct pt_regs *regs)
+{
+	return regs->regs[1];
+}
+NOKPROBE_SYMBOL(fei_return_address);
diff --git a/arch/powerpc/lib/error-inject.c b/arch/powerpc/lib/error-inject.c
index e834079d2b5c..c72abce5d19f 100644
--- a/arch/powerpc/lib/error-inject.c
+++ b/arch/powerpc/lib/error-inject.c
@@ -14,3 +14,9 @@ void override_function_with_return(struct pt_regs *regs)
 	regs_set_return_ip(regs, regs->link);
 }
 NOKPROBE_SYMBOL(override_function_with_return);
+
+unsigned long fei_return_address(struct pt_regs *regs)
+{
+	return regs->link;
+}
+NOKPROBE_SYMBOL(fei_return_address);
diff --git a/arch/riscv/lib/error-inject.c b/arch/riscv/lib/error-inject.c
index d667ade2bc41..ed8b17acc379 100644
--- a/arch/riscv/lib/error-inject.c
+++ b/arch/riscv/lib/error-inject.c
@@ -8,3 +8,9 @@ void override_function_with_return(struct pt_regs *regs)
 	instruction_pointer_set(regs, regs->ra);
 }
 NOKPROBE_SYMBOL(override_function_with_return);
+
+unsigned long fei_return_address(struct pt_regs *regs)
+{
+	return regs->ra;
+}
+NOKPROBE_SYMBOL(fei_return_address);
diff --git a/arch/s390/lib/error-inject.c b/arch/s390/lib/error-inject.c
index 8c9d4da87eef..15b23076ebeb 100644
--- a/arch/s390/lib/error-inject.c
+++ b/arch/s390/lib/error-inject.c
@@ -12,3 +12,9 @@ void override_function_with_return(struct pt_regs *regs)
 	regs->psw.addr = regs->gprs[14];
 }
 NOKPROBE_SYMBOL(override_function_with_return);
+
+unsigned long fei_return_address(struct pt_regs *regs)
+{
+	return regs->gprs[14];
+}
+NOKPROBE_SYMBOL(fei_return_address);
diff --git a/arch/x86/lib/error-inject.c b/arch/x86/lib/error-inject.c
index 512a2538596f..85cc46e2dd7c 100644
--- a/arch/x86/lib/error-inject.c
+++ b/arch/x86/lib/error-inject.c
@@ -23,3 +23,9 @@ void override_function_with_return(struct pt_regs *regs)
 	regs->ip = (unsigned long)&just_return_func;
 }
 NOKPROBE_SYMBOL(override_function_with_return);
+
+unsigned long fei_return_address(struct pt_regs *regs)
+{
+	return *(unsigned long *)regs->sp;
+}
+NOKPROBE_SYMBOL(fei_return_address);
diff --git a/include/asm-generic/error-injection.h b/include/asm-generic/error-injection.h
index 6c399121ab7a..8f526d76cdcb 100644
--- a/include/asm-generic/error-injection.h
+++ b/include/asm-generic/error-injection.h
@@ -34,10 +34,15 @@ static struct error_injection_entry __used				\
 	}
 
 void override_function_with_return(struct pt_regs *regs);
+unsigned long fei_return_address(struct pt_regs *regs);
 #else
 #define ALLOW_ERROR_INJECTION(fname, _etype)
 
 static inline void override_function_with_return(struct pt_regs *regs) { }
+static inline unsigned long fei_return_address(struct pt_regs *regs)
+{
+	return 0UL;
+}
 #endif
 #endif
 
diff --git a/kernel/fail_function.c b/kernel/fail_function.c
index 90cdad0412cd..a336fc565dc9 100644
--- a/kernel/fail_function.c
+++ b/kernel/fail_function.c
@@ -27,6 +27,9 @@ struct fei_attr {
 	struct list_head list;
 	struct kprobe kp;
 	unsigned long retval;
+	char	parent[KSYM_NAME_LEN];
+	unsigned long	parent_start;
+	unsigned long	parent_end;
 };
 static DEFINE_MUTEX(fei_lock);
 static LIST_HEAD(fei_attr_list);
@@ -154,13 +157,94 @@ static int fei_retval_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(fei_retval_ops, fei_retval_get, fei_retval_set,
 			 "%llx\n");
 
+static ssize_t fei_parent_read(struct file *file, char __user *buf,
+				 size_t count, loff_t *ppos)
+{
+	struct fei_attr *attr = file->private_data;
+	char tmp[KSYM_NAME_LEN + 1];
+	int len;
+	int err = 0;
+
+	mutex_lock(&fei_lock);
+	if (!fei_attr_is_valid(attr)) {
+		err = -ENOENT;
+		goto out;
+	}
+	len = scnprintf(tmp, sizeof(tmp), "%s\n", attr->parent);
+	mutex_unlock(&fei_lock);
+
+	return simple_read_from_buffer(buf, count, ppos, tmp, len);
+out:
+	mutex_unlock(&fei_lock);
+	return err;
+}
+
+static ssize_t fei_parent_write(struct file *file, const char __user *buf,
+				 size_t count, loff_t *ppos)
+{
+	struct fei_attr *attr = file->private_data;
+	char tmp[KSYM_NAME_LEN];
+	unsigned long start, size;
+	ssize_t err = 0;
+
+	if (count == 0 || count >= sizeof(tmp))
+		return -EINVAL;
+
+	if (copy_from_user(tmp, buf, count))
+		return -EFAULT;
+
+	tmp[count] = '\0';
+	strim(tmp);
+
+	mutex_lock(&fei_lock);
+	if (!fei_attr_is_valid(attr)) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	if (tmp[0] == '\0') {
+		attr->parent[0]  = '\0';
+		attr->parent_start = 0;
+		attr->parent_end   = 0;
+		err = count;
+		goto out;
+	}
+
+	start = kallsyms_lookup_name(tmp);
+	if (!start) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	if (!kallsyms_lookup_size_offset(start, &size, NULL)) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	strscpy(attr->parent, tmp, sizeof(attr->parent));
+	attr->parent_start = start;
+	attr->parent_end   = start + size;
+	err = count;
+
+out:
+	mutex_unlock(&fei_lock);
+	return err;
+}
+
+static const struct file_operations fei_parent_ops = {
+	.owner = THIS_MODULE,
+	.open  = simple_open,
+	.read  = fei_parent_read,
+	.write = fei_parent_write,
+};
+
 static void fei_debugfs_add_attr(struct fei_attr *attr)
 {
 	struct dentry *dir;
 
 	dir = debugfs_create_dir(attr->kp.symbol_name, fei_debugfs_dir);
-
 	debugfs_create_file("retval", 0600, dir, attr, &fei_retval_ops);
+	debugfs_create_file("parent", 0600, dir, attr, &fei_parent_ops);
 }
 
 static void fei_debugfs_remove_attr(struct fei_attr *attr)
@@ -171,6 +255,16 @@ static void fei_debugfs_remove_attr(struct fei_attr *attr)
 static int fei_kprobe_handler(struct kprobe *kp, struct pt_regs *regs)
 {
 	struct fei_attr *attr = container_of(kp, struct fei_attr, kp);
+	unsigned long ret_addr = 0;
+	bool in_parent = false;
+
+	ret_addr = fei_return_address(regs);
+	if (attr->parent_start) {
+		in_parent = (ret_addr >= attr->parent_start &&
+					ret_addr <  attr->parent_end);
+		if (!in_parent)
+			return 0;
+	}
 
 	if (should_fail(&fei_fault_attr, 1)) {
 		regs_set_return_value(regs, attr->retval);
-- 
2.43.0

