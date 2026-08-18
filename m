Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9CD47ACC9;
	Tue, 18 Aug 2026 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064647; cv=none; b=YxGAOzNumnIhc2sbyAZI0kPg2qkRcQl7eVJm5+KbkcggUs4gR8YbClQSE+QhK9z+heFK5R0u3V2F+yTV/fqTRQgoolrkAgQjHQYgDLnagVSIRpE+Kb2FAPhH4GGxJy9wHvhYZCYVPzD5o73BZ7ULpCcyvu6fCf4pkI+l4liW2rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064647; c=relaxed/simple;
	bh=HgqXTNjaQkQm6cTE23s1ZwUulek57QMHF4KLFCYhnfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvN1k/EkxUU2plHYslMHdHuaGnYzefnkktJgoH+P0Kv0ATfKRfjT2lyAuBggBT/d4HLmHMbwfUAVrdW9oGWnuoIkPW9Q2Oi+eO1ugDyA9nOJEjlzE+S2UXjz3AJfvNnMa9F2RwGqbeNJVSdNU/AKDgYBpLlgJUjasb8pRC8aUvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gMYa67pl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gMYa67pl"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE40bx402137;
	Tue, 18 Aug 2026 14:50:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=O1e6CFxOxf9L/LPXN
	k3gG+iLkTQ1jjXbDycl/x4C2sA=; b=gMYa67plXprhf+mJtIQ6utlr9ZPXKuTaG
	jv/txmyYMXynu3C2wCs5EGqLGjxsyuHc2TobDsiPzaIQq7kzgKqb2EcY4QRZD4uX
	CJGQHCpasMRSZ44x+skMNuPHkoHxRgrUYVZcbXoP77AtNa56zEInpMY/BBAjdnYb
	kU6J6PNw8AnOd7vBEXUxsN35Y8vWU+BH15GiHbq+248HbKWOrZpbOQOYCc9W5FET
	qscgyFdtSChzpd9RWiHEWA+WX5lRSXo9tYYJFM1kwzz+xwrUcPaLtmuNjcnkIU5e
	QJn8RACqc28j8n8lUoR4ORq5tC4Jzs9Y7KMlnkq/7ELdzWN2OD0uw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhm0qn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IEfMTA025400;
	Tue, 18 Aug 2026 14:50:06 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xh3q5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IEo1Xb50397634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 14:50:01 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B830320040;
	Tue, 18 Aug 2026 14:50:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 705B02004D;
	Tue, 18 Aug 2026 14:50:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 14:50:01 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Indu Bhagat <ibhagatgnu@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Namhyung Kim <namhyung@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, Kees Cook <kees@kernel.org>,
        Sam James <sam@gentoo.org>
Subject: [RFC PATCH v1 14/25] unwind_user/eh_frame: Add .eh_frame[_hdr] validation option
Date: Tue, 18 Aug 2026 16:49:43 +0200
Message-ID: <20260818144954.2320378-15-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818144954.2320378-1-jremus@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfXxdiWQUmGpLmF
 Es+Ul7Ut05h3BxA9bQWZ+ESdQm7nnAUvuFNQv0wmGgK9pqVM+Yezu0ECEpmqBeMnexGwnrDRCCr
 0NaLChYxner/I5kHidyszNRcuTtL2Yz5wrLY0v8DEGghMSgW9qL1ETzkIrrKdUSkfWHrmuwb3V1
 mWvnQy8qb5hFBdVFM+s6aENB63MDq7hOxH5OhsUROfLAIt3tp0fBGqd8o51r6M5zR90MZjVUoCH
 +UBnMSykVJExnv0nHIven2rAe19NAx8MXUO4FrGdEW7G3q5kAHNO3q+dh8m5u3n03EA2oG/pawD
 JWs89I/elbQ8PAktF0FgJTcFtktVvKf73v+8HdDaEQylOPFEk1FH1hmqmR8mBggIEk4jT5LT3AI
 KOif6LQ/W1iYnvRBkW5TPshvCaoHE69eiZN23cdoZcH2lUcDwtllyVrAtzZUkosyjlHA5h7AegS
 dpfnllP9xJOP1J1uU/g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX0CGjpXFcH5yb
 L38p9xrKWEazqqMkubPUNXxYBEszDe0D4+SCBCSCgOuKMv6ad2BlbbY1SCbryH866lza5C+MZ8+
 8W//oX++KwStq54LTtT+raBdp+cx09U=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a84711f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=rU79QueooZ11dTUg0tsA:9
X-Proofpoint-ORIG-GUID: EMpV_nXwfK9MoGn3zsJoPwCjhCYNKNRx
X-Proofpoint-GUID: rzNcgYVZdpiVLSneaMjv_Zb9H1zW4w4i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180107

Add a debug feature to validate all .eh_frame[_hdr] sections when first
loading the file rather than on demand.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    FIXME: dbg*() with UACCESS enabled.

 arch/Kconfig                   | 22 ++++++++
 kernel/unwind/eh_frame.c       | 93 ++++++++++++++++++++++++++++++++++
 kernel/unwind/eh_frame_debug.h |  4 ++
 3 files changed, 119 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index ea969811f798..30d9e876f28a 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -490,6 +490,28 @@ config HAVE_UNWIND_USER_EH_FRAME
 	bool
 	select UNWIND_USER
 
+config EH_FRAME_VALIDATION
+	bool "Enable .eh_frame[_hdr] section debugging"
+	depends on HAVE_UNWIND_USER_EH_FRAME
+	depends on DYNAMIC_DEBUG
+	help
+	  When adding an .eh_frame_hdr section for a test, validate the
+	  entire section and its referenced entrire .eh_frame section
+	  immediately rather than on demand.
+
+	  This is a debug feature which is helpful for rooting out
+	  .eh_frame[_hdr] section issues.  If the .eh_frame[_hdr]
+	  section is corrupt, it will fail to load immediately, with
+	  more information provided in dynamic printks.
+
+	  This has a significant page cache footprint due to its reading
+	  of the entire .eh_frame[_hdr] sections for every loaded executable
+	  and shared library.  Also, it's done for all processes, even those
+	  which don't get stack traced by the kernel.  Not recommended for
+	  general use.
+
+	  If unsure, say N.
+
 config HAVE_UNWIND_USER_FP
 	bool
 	select UNWIND_USER
diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c
index 46ffb535ca53..c9161229196c 100644
--- a/kernel/unwind/eh_frame.c
+++ b/kernel/unwind/eh_frame.c
@@ -1163,6 +1163,95 @@ int eh_frame_find(unsigned long ip, struct unwind_user_frame *frame)
 	return ret;
 }
 
+#ifdef CONFIG_EH_FRAME_VALIDATION
+
+static int eh_frame_validate_section(struct eh_frame_section *sec)
+{
+	void __user *table_start_ptr;
+	unsigned long table_size;
+	u8 table_enc;
+	int entry_size;
+	unsigned long prev_func_addr;
+	unsigned int i;
+
+	if (!sec->has_binary_search_table)
+		return 0;
+
+	if (!sec->fde_count) {
+		dbg_sec(".eh_frame_hdr: invalid FDE count\n");
+		return -EINVAL;
+	}
+
+	table_enc = sec->binary_search_table_enc;
+	entry_size = 2 * encoded_pointer_size(table_enc);
+	if (!entry_size) {
+		dbg_sec(".eh_frame_hdr: invalid binary search table entry size\n");
+		return -EINVAL;
+	}
+	table_start_ptr = (void __user *)sec->binary_search_table_start;
+	table_size = sec->binary_search_table_end - sec->binary_search_table_start;
+
+	for (i = 0; i < sec->fde_count; i++) {
+		struct eh_frame_fde fde;
+		unsigned long cur;
+		unsigned long func_addr, fde_addr;
+		int ret;
+
+		cur = sec->binary_search_table_start + i * entry_size;
+
+		scoped_user_read_access_size(table_start_ptr, table_size, Efault) {
+			/* Read function start address from table */
+			ret = read_encoded_pointer(sec, NULL, &cur,
+						   sec->binary_search_table_end,
+						   table_enc, &func_addr);
+			if (ret) {
+				dbg_sec_ehfh(cur, "table[%u]: failed to read function start address\n", i);
+				return ret;
+			}
+			if (i && func_addr <= prev_func_addr) {
+				dbg_sec(".eh_frame_hdr: table[%u]: not sorted\n", i);
+				return -EINVAL;
+			}
+			prev_func_addr = func_addr;
+
+			/* Read FDE address from table */
+			ret = read_encoded_pointer(sec, NULL, &cur,
+						   sec->binary_search_table_end,
+						   table_enc, &fde_addr);
+			if (ret) {
+				dbg_sec_ehfh(cur, "table[%u]: failed to read FDE pointer\n", i);
+				return ret;
+			}
+			if (fde_addr < sec->eh_frame_start) {
+				dbg_sec(".eh_frame_hdr: table[%u]: invalid FDE address\n", i);
+				return -EINVAL;
+			}
+		}
+
+		ret = __read_fde(sec, fde_addr, &fde);
+		if (ret) {
+			dbg_sec(".eh_frame_hdr: table[%u]: failed to read FDE at .eh_frame+%#lx\n",
+				i, fde_addr - sec->eh_frame_start);
+			return ret;
+		}
+		if (func_addr != fde.func_addr) {
+			dbg_sec(".eh_frame_hdr: table[%u]: function start address mismatch\n", i);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+
+Efault:
+	return -EFAULT;
+}
+
+#else /* !CONFIG_EH_FRAME_VALIDATION */
+
+static int eh_frame_validate_section(struct eh_frame_section *sec) { return 0; }
+
+#endif /* !CONFIG_EH_FRAME_VALIDATION */
+
 static void free_section(struct eh_frame_section *sec)
 {
 	dbg_free(sec);
@@ -1299,6 +1388,10 @@ int eh_frame_add_section(unsigned long eh_frame_hdr_start,
 	if (ret)
 		goto err_free;
 
+	ret = eh_frame_validate_section(sec);
+	if (ret)
+		goto err_free;
+
 	ret = mtree_insert_range(eh_frame_mt, sec->text_start, sec->text_end - 1,
 				 sec, GFP_KERNEL_ACCOUNT);
 	if (ret) {
diff --git a/kernel/unwind/eh_frame_debug.h b/kernel/unwind/eh_frame_debug.h
index 40a80861d4d4..bcb2d03ab9ab 100644
--- a/kernel/unwind/eh_frame_debug.h
+++ b/kernel/unwind/eh_frame_debug.h
@@ -14,6 +14,9 @@
 #define dbg_sec(fmt, ...)						\
 	dbg("%s: " fmt, sec->filename, ##__VA_ARGS__)
 
+#define dbg_sec_ehfh(addr, fmt, ...)					\
+	dbg_sec(".eh_frame_hdr+%#lx: " fmt, ((addr) - sec->eh_frame_hdr_start), ##__VA_ARGS__)
+
 static inline void dbg_init(struct eh_frame_section *sec)
 {
 	struct mm_struct *mm = current->mm;
@@ -47,6 +50,7 @@ static inline void dbg_free(struct eh_frame_section *sec)
 
 #define dbg(args...)			no_printk(args)
 #define dbg_sec(args...)		no_printk(args)
+#define dbg_sec_ehfh(args...)		no_printk(args)
 
 static inline void dbg_init(struct eh_frame_section *sec) {}
 static inline void dbg_free(struct eh_frame_section *sec) {}
-- 
2.53.0

