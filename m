Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BD019E975;
	Mon, 11 Nov 2024 13:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731332773; cv=none; b=bCtlXCKusU/CPAgPZqj3epSmgYe4bFJPWHcRwlfKFAJyrCOtsyeGeJbtcmy3EZA3dMEKzp+BLjsCqg/GDfYmDp37cZDGLoH83YgfHdvL+kdvqdSaIGWsI0hxT8YRHbeIl0ZmVn+eW2Ar1GneRXrjxXIrdirZe8Qj4CFXlfWLaj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731332773; c=relaxed/simple;
	bh=kSPBqfH4LLYM56mYI3/mtlJIoRUQ4UFWrLYsEGvHrfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZ1AqM9XnfvfmUL0pAcRaoPx3PrnmBRRt4pkCMLYTlc06RLgHK3qy8Q2RHjKUhoGX74LNuRZ6IBhlLNXoqK/aEdftZP4t5HIU2MMWTwDWc0BO1BXa0wSqckerz1fXuj3ps3uI5F4s9LwGzuc0mw5kR5EVzMLhAs5f5iGTzWrpqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaXETQm4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaXETQm4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7103C4CED6;
	Mon, 11 Nov 2024 13:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731332772;
	bh=kSPBqfH4LLYM56mYI3/mtlJIoRUQ4UFWrLYsEGvHrfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VaXETQm48a6JmpJYylj5WsyL3OBUV+fO/KsJ95mLVI4N2a5pnBApw3UeGDeeAQKbu
	 7FW2O/ug5gkYi6gndNuiTAUC0a9ih7ozihkEN2DCOIT9uOoYXJqZGLU1/f/Jb5smj9
	 ABbkO+pJ8YXD6p+6wsZuCYCJfcEQp2uPMH0IRy797X/MDVHMeLV0q7c6RjRN+xiUqX
	 naYn29u0kHqiQnIzroMWuKHf5lL2w1v8hDRlIQlLKlP2ioigGo31uAiVuWeOE2ZIpM
	 Wv4mm7L40sBQFE/Y3CFbtHYHCrCpPwlMZoYLM9jOi5ncqF46BVxhYIPgVYaU1C3SF+
	 7uL+PIBCBs9gA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-s390@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] s390/syscalls: remove unnecessary argument of filechk_syshdr
Date: Mon, 11 Nov 2024 22:45:53 +0900
Message-ID: <20241111134603.2063226-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241111134603.2063226-1-masahiroy@kernel.org>
References: <20241111134603.2063226-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The filechk_syshdr macro receives $@ in both cases, making the argument
redundant.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/s390/kernel/syscalls/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/syscalls/Makefile b/arch/s390/kernel/syscalls/Makefile
index e85c14f9058b..3725dd88428c 100644
--- a/arch/s390/kernel/syscalls/Makefile
+++ b/arch/s390/kernel/syscalls/Makefile
@@ -23,7 +23,7 @@ uapi:	$(uapi-hdrs-y)
 # Create output directory if not already present
 $(shell mkdir -p $(uapi) $(kapi))
 
-filechk_syshdr = $(CONFIG_SHELL) '$(systbl)' -H -a $(syshdr_abi_$(basetarget)) -f "$2" < $<
+filechk_syshdr = $(CONFIG_SHELL) '$(systbl)' -H -a $(syshdr_abi_$(basetarget)) -f "$@" < $<
 
 filechk_sysnr = $(CONFIG_SHELL) '$(systbl)' -N -a $(sysnr_abi_$(basetarget)) < $<
 
@@ -31,11 +31,11 @@ filechk_syscalls = $(CONFIG_SHELL) '$(systbl)' -S < $<
 
 syshdr_abi_unistd_32 := common,32
 $(uapi)/unistd_32.h: $(syscall) FORCE
-	$(call filechk,syshdr,$@)
+	$(call filechk,syshdr)
 
 syshdr_abi_unistd_64 := common,64
 $(uapi)/unistd_64.h: $(syscall) FORCE
-	$(call filechk,syshdr,$@)
+	$(call filechk,syshdr)
 
 $(kapi)/syscall_table.h: $(syscall) FORCE
 	$(call filechk,syscalls)
-- 
2.43.0

