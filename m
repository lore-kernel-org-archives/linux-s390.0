Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0BE4EB875;
	Thu, 17 Sep 2026 21:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679563; cv=none; b=nRpBDgZAmoiJG+83bO/U+rUPTYB0lBUYak7SQMfr1EFK5KGhemZUEoLZUcSm85NczQtQH7KRRjuO2/SP4HeAWthdaTWIAqZAVg78dDwO2YFIRljup/N4eH+xcG1yICVr3OJOADZ3aFEEHMv8w3dIc2WDe7GjYgbaDsJe/3fSOak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679563; c=relaxed/simple;
	bh=01FvJxetNS7YjoiVP3GIq8xXDj55NBVoskUA5qMRyHc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UxxzzrSxydtct733VLWWGoeSklpk+gT4eEVAFYWENE9ksCX3+4sd7S8pJbQVhFPQzRoQVtTa0r7jLzh9RVlSyLOqh9FOoRRES34Y29SaKlHtuItiCqd18fOG32O1dPd2HSnLuxaYOKly8rtb4F/jCVEOqLgQwPTKl7Tba2F2IGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NazMnaxv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NazMnaxv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A251F000FF;
	Thu, 17 Sep 2026 21:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679561;
	bh=Lr/gYrJ5d7eKsqJ9AZf8WCnyZeqcGWqFtx9106X0crA=;
	h=From:To:Cc:Subject:Date;
	b=NazMnaxvlARRvcYWFKAKmv4YO085GJjQb17DN6YmXPqeiq/fjywu3US2C2U5n9lZe
	 Ea67igZN5xDoH/plXDq5p/ta8euTMFc8ep1waYI4ETewczFNF2lrkxVKNwrCm0skr4
	 IpeguhvcPxv6PF0G76aFATAfNRwS+3I+5nK+64m68u6mOpSXG3X6yJV9c+4DgeIeed
	 WtdQSc4ICw62qVzbC14UEcVWY15OId2kNR7vuoXk+J1tC3kXzGog8zjpWnoX8fjHrv
	 LWfC9YXmUApn9WCuCIOABb1TpdZB5rINlXeimoeiZFHb7Mp7QH8fc04E0ZFcm/DXBv
	 RbX+LFStOnwag==
From: Kees Cook <kees@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Kees Cook <kees@kernel.org>,
	Kees Cook <kees+treewide@kernel.org>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] s390/keyboard: Allocate key_maps and func_table with ARRAY_SIZE()
Date: Thu, 17 Sep 2026 14:12:40 -0700
Message-Id: <20260917211239.i.576-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2083; i=kees@kernel.org; h=from:subject:message-id; bh=APzKABLwNoiSeT+qix+ad/LP9/BL1NKjU2raC555QIE=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlrwk/EFZ1bpywru3Ot+LODsSKOa0rNJIofMe/obM3P0 rHl7A3tKGVhEONikBVTZAmyc49z8XjbHu4+VxFmDisTyBAGLk4BmIimOcP/JBGWHdH3OSUaQnST J0vq2OmZMX9WOFIYVN+WtmOzr7QEw/+AvXLJy14IvPY/x+k7i2XJd8/PW+RLuzKEv679L1V8T5o fAA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees+treewide@kernel.org>

In preparation for converting the kmalloc family of allocators to the
type-aware kmalloc_obj family, we need to make sure that the returned
type from the allocation matches the type of the variable being
assigned. (The kmalloc family returns "void *", which can be implicitly
cast to any pointer type.)

These allocate as many pointers as ebc_key_maps and ebc_func_table hold,
but the sizes were taken from the whole arrays, which would make the
allocation types pointers to those arrays rather than the "u_short **"
and "char **" being assigned. Allocate ARRAY_SIZE-many entries instead.
The resulting allocation sizes are the same.

Build tested ARCH=s390 allmodconfig with GCC s390x-linux-gnu 16.1.0:
drivers/s390/char/keyboard.o

Assisted-by: LLM coccinelle
Signed-off-by: Kees Cook <kees+treewide@kernel.org>
---
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: <linux-s390@vger.kernel.org>
---
 drivers/s390/char/keyboard.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/keyboard.c b/drivers/s390/char/keyboard.c
index ecd9ace2b3aa..63bcb52d6e87 100644
--- a/drivers/s390/char/keyboard.c
+++ b/drivers/s390/char/keyboard.c
@@ -81,7 +81,8 @@ kbd_alloc(void) {
 	kbd = kzalloc_obj(struct kbd_data);
 	if (!kbd)
 		goto out;
-	kbd->key_maps = kzalloc(sizeof(ebc_key_maps), GFP_KERNEL);
+	kbd->key_maps = kcalloc(ARRAY_SIZE(ebc_key_maps),
+				sizeof(*kbd->key_maps), GFP_KERNEL);
 	if (!kbd->key_maps)
 		goto out_kbd;
 	for (i = 0; i < ARRAY_SIZE(ebc_key_maps); i++) {
@@ -93,7 +94,8 @@ kbd_alloc(void) {
 				goto out_maps;
 		}
 	}
-	kbd->func_table = kzalloc(sizeof(ebc_func_table), GFP_KERNEL);
+	kbd->func_table = kcalloc(ARRAY_SIZE(ebc_func_table),
+				  sizeof(*kbd->func_table), GFP_KERNEL);
 	if (!kbd->func_table)
 		goto out_maps;
 	for (i = 0; i < ARRAY_SIZE(ebc_func_table); i++) {
-- 
2.34.1

