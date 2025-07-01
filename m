Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8EA27BF6F;
	Tue,  1 Jul 2025 13:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378222; cv=none; b=KA50QRqBYREjbmoc0WDLmd9e3EU3sW9SStRXZdiJi6H/V02vsbJ3Mkk4f4aJOmZqauL4xw9cnJixTscqKBCAfyjFTnimdujsl+Z7rH8zHfvZI55dnrGIPMFivRWvck6/IOQ1ArIsC30vpf6IEJUKulNxRaaMzoprVrFb+ajzlJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378222; c=relaxed/simple;
	bh=ksjSGJsA16QDgnP8ZRbvd8mS8M+1nfxBIUQwECqghLk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kSQ0IUL/Z8Sr8jswA36aTj2gfOmzJjSy/wmnNcR0GBiDPsIKQ377RHFTIwTURSOadO3JkeMJ+3uUvMIixdpfMBetahCl1Wj899iwsq0Qwd7uH4B7EQXkjBpWOaPaTk+aYXF1xQYoNLx1hHsgkAOG1cBvcrpzE4hFQqQwv678pSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4DBE2E96;
	Tue,  1 Jul 2025 06:56:44 -0700 (PDT)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 437A43F58B;
	Tue,  1 Jul 2025 06:56:58 -0700 (PDT)
From: Dave Martin <Dave.Martin@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	linux-s390@vger.kernel.org
Subject: [PATCH 17/23] s390/ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
Date: Tue,  1 Jul 2025 14:56:10 +0100
Message-Id: <20250701135616.29630-18-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250701135616.29630-1-Dave.Martin@arm.com>
References: <20250701135616.29630-1-Dave.Martin@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of having the core code guess the note name for each regset,
use USER_REGSET_NOTE_TYPE() to pick the correct name from elf.h.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/kernel/ptrace.c | 42 +++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index e1240f6b29fa..494216c4b4f3 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -1209,7 +1209,7 @@ static int s390_runtime_instr_set(struct task_struct *target,
 
 static const struct user_regset s390_regsets[] = {
 	{
-		.core_note_type = NT_PRSTATUS,
+		USER_REGSET_NOTE_TYPE(PRSTATUS),
 		.n = sizeof(s390_regs) / sizeof(long),
 		.size = sizeof(long),
 		.align = sizeof(long),
@@ -1217,7 +1217,7 @@ static const struct user_regset s390_regsets[] = {
 		.set = s390_regs_set,
 	},
 	{
-		.core_note_type = NT_PRFPREG,
+		USER_REGSET_NOTE_TYPE(PRFPREG),
 		.n = sizeof(s390_fp_regs) / sizeof(long),
 		.size = sizeof(long),
 		.align = sizeof(long),
@@ -1225,7 +1225,7 @@ static const struct user_regset s390_regsets[] = {
 		.set = s390_fpregs_set,
 	},
 	{
-		.core_note_type = NT_S390_SYSTEM_CALL,
+		USER_REGSET_NOTE_TYPE(S390_SYSTEM_CALL),
 		.n = 1,
 		.size = sizeof(unsigned int),
 		.align = sizeof(unsigned int),
@@ -1233,7 +1233,7 @@ static const struct user_regset s390_regsets[] = {
 		.set = s390_system_call_set,
 	},
 	{
-		.core_note_type = NT_S390_LAST_BREAK,
+		USER_REGSET_NOTE_TYPE(S390_LAST_BREAK),
 		.n = 1,
 		.size = sizeof(long),
 		.align = sizeof(long),
@@ -1241,7 +1241,7 @@ static const struct user_regset s390_regsets[] = {
 		.set = s390_last_break_set,
 	},
 	{
-		.core_note_type = NT_S390_TDB,
+		USER_REGSET_NOTE_TYPE(S390_TDB),
 		.n = 1,
 		.size = 256,
 		.align = 1,
@@ -1249,7 +1249,7 @@ static const struct user_regset s390_regsets[] = {
 		.set = s390_tdb_set,
 	},
 	{
-		.core_note_type = NT_S390_VXRS_LOW,
+		USER_REGSET_NOTE_TYPE(S390_VXRS_LOW),
 		.n = __NUM_VXRS_LOW,
 		.size = sizeof(__u64),
 		.align = sizeof(__u64),
@@ -1257,7 +1257,7 @@ static const struct user_regset s390_regsets[] = {
 		.set = s390_vxrs_low_set,
 	},
 	{
-		.core_note_type = NT_S390_VXRS_HIGH,
+		USER_REGSET_NOTE_TYPE(S390_VXRS_HIGH),
 		.n = __NUM_VXRS_HIGH,
 		.size = sizeof(__vector128),
 		.align = sizeof(__vector128),
@@ -1265,7 +1265,7 @@ static const struct user_regset s390_regsets[] = {
 		.set = s390_vxrs_high_set,
 	},
 	{
-		.core_note_type = NT_S390_GS_CB,
+		USER_REGSET_NOTE_TYPE(S390_GS_CB),
 		.n = sizeof(struct gs_cb) / sizeof(__u64),
 		.size = sizeof(__u64),
 		.align = sizeof(__u64),
@@ -1273,7 +1273,7 @@ static const struct user_regset s390_regsets[] = {
 		.set = s390_gs_cb_set,
 	},
 	{
-		.core_note_type = NT_S390_GS_BC,
+		USER_REGSET_NOTE_TYPE(S390_GS_BC),
 		.n = sizeof(struct gs_cb) / sizeof(__u64),
 		.size = sizeof(__u64),
 		.align = sizeof(__u64),
@@ -1281,7 +1281,7 @@ static const struct user_regset s390_regsets[] = {
 		.set = s390_gs_bc_set,
 	},
 	{
-		.core_note_type = NT_S390_RI_CB,
+		USER_REGSET_NOTE_TYPE(S390_RI_CB),
 		.n = sizeof(struct runtime_instr_cb) / sizeof(__u64),
 		.size = sizeof(__u64),
 		.align = sizeof(__u64),
@@ -1413,7 +1413,7 @@ static int s390_compat_last_break_set(struct task_struct *target,
 
 static const struct user_regset s390_compat_regsets[] = {
 	{
-		.core_note_type = NT_PRSTATUS,
+		USER_REGSET_NOTE_TYPE(PRSTATUS),
 		.n = sizeof(s390_compat_regs) / sizeof(compat_long_t),
 		.size = sizeof(compat_long_t),
 		.align = sizeof(compat_long_t),
@@ -1421,7 +1421,7 @@ static const struct user_regset s390_compat_regsets[] = {
 		.set = s390_compat_regs_set,
 	},
 	{
-		.core_note_type = NT_PRFPREG,
+		USER_REGSET_NOTE_TYPE(PRFPREG),
 		.n = sizeof(s390_fp_regs) / sizeof(compat_long_t),
 		.size = sizeof(compat_long_t),
 		.align = sizeof(compat_long_t),
@@ -1429,7 +1429,7 @@ static const struct user_regset s390_compat_regsets[] = {
 		.set = s390_fpregs_set,
 	},
 	{
-		.core_note_type = NT_S390_SYSTEM_CALL,
+		USER_REGSET_NOTE_TYPE(S390_SYSTEM_CALL),
 		.n = 1,
 		.size = sizeof(compat_uint_t),
 		.align = sizeof(compat_uint_t),
@@ -1437,7 +1437,7 @@ static const struct user_regset s390_compat_regsets[] = {
 		.set = s390_system_call_set,
 	},
 	{
-		.core_note_type = NT_S390_LAST_BREAK,
+		USER_REGSET_NOTE_TYPE(S390_LAST_BREAK),
 		.n = 1,
 		.size = sizeof(long),
 		.align = sizeof(long),
@@ -1445,7 +1445,7 @@ static const struct user_regset s390_compat_regsets[] = {
 		.set = s390_compat_last_break_set,
 	},
 	{
-		.core_note_type = NT_S390_TDB,
+		USER_REGSET_NOTE_TYPE(S390_TDB),
 		.n = 1,
 		.size = 256,
 		.align = 1,
@@ -1453,7 +1453,7 @@ static const struct user_regset s390_compat_regsets[] = {
 		.set = s390_tdb_set,
 	},
 	{
-		.core_note_type = NT_S390_VXRS_LOW,
+		USER_REGSET_NOTE_TYPE(S390_VXRS_LOW),
 		.n = __NUM_VXRS_LOW,
 		.size = sizeof(__u64),
 		.align = sizeof(__u64),
@@ -1461,7 +1461,7 @@ static const struct user_regset s390_compat_regsets[] = {
 		.set = s390_vxrs_low_set,
 	},
 	{
-		.core_note_type = NT_S390_VXRS_HIGH,
+		USER_REGSET_NOTE_TYPE(S390_VXRS_HIGH),
 		.n = __NUM_VXRS_HIGH,
 		.size = sizeof(__vector128),
 		.align = sizeof(__vector128),
@@ -1469,7 +1469,7 @@ static const struct user_regset s390_compat_regsets[] = {
 		.set = s390_vxrs_high_set,
 	},
 	{
-		.core_note_type = NT_S390_HIGH_GPRS,
+		USER_REGSET_NOTE_TYPE(S390_HIGH_GPRS),
 		.n = sizeof(s390_compat_regs_high) / sizeof(compat_long_t),
 		.size = sizeof(compat_long_t),
 		.align = sizeof(compat_long_t),
@@ -1477,7 +1477,7 @@ static const struct user_regset s390_compat_regsets[] = {
 		.set = s390_compat_regs_high_set,
 	},
 	{
-		.core_note_type = NT_S390_GS_CB,
+		USER_REGSET_NOTE_TYPE(S390_GS_CB),
 		.n = sizeof(struct gs_cb) / sizeof(__u64),
 		.size = sizeof(__u64),
 		.align = sizeof(__u64),
@@ -1485,7 +1485,7 @@ static const struct user_regset s390_compat_regsets[] = {
 		.set = s390_gs_cb_set,
 	},
 	{
-		.core_note_type = NT_S390_GS_BC,
+		USER_REGSET_NOTE_TYPE(S390_GS_BC),
 		.n = sizeof(struct gs_cb) / sizeof(__u64),
 		.size = sizeof(__u64),
 		.align = sizeof(__u64),
@@ -1493,7 +1493,7 @@ static const struct user_regset s390_compat_regsets[] = {
 		.set = s390_gs_bc_set,
 	},
 	{
-		.core_note_type = NT_S390_RI_CB,
+		USER_REGSET_NOTE_TYPE(S390_RI_CB),
 		.n = sizeof(struct runtime_instr_cb) / sizeof(__u64),
 		.size = sizeof(__u64),
 		.align = sizeof(__u64),
-- 
2.34.1

