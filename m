Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD3619E96A;
	Mon, 11 Nov 2024 13:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731332774; cv=none; b=iYRNYeXYunkwEGDtjXpGvJLuQfvzd/nM+38CDuM+kIROffbpS+WU7Ktg0eRSm8qkIFNeZPVoCu1AFxs4WCtso5RP//Xjt1Z/ZvRK0uwW8ymjixr8nHF/eQH1ClDNedQrXnqewf5YsbktoynKmcVmfrfa1kTnNF1Gnr+qNNvFIHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731332774; c=relaxed/simple;
	bh=01QVKcjVyudfzC6ClvvoC7SOzqRTu68YSI6da6IEL8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRCfDFZO3cIRCaAAtzblgQDqtc1ZsndwuJ7ipIEjsv5sF2I7n5/BI3CJBptK853UmAD3Y6LUobv7tTp7tv9dg2GQDOTiY9wZcJWqW7c27YZhfgwXDFNY4NeKlC19FVxIfPIhRG4oKbphjn3G0F2UsZXP+aMpsewOz6Ia6ENWiL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTXz24ml; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTXz24ml"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01292C4CED9;
	Mon, 11 Nov 2024 13:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731332774;
	bh=01QVKcjVyudfzC6ClvvoC7SOzqRTu68YSI6da6IEL8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZTXz24mlXDyudFgjoH4IsMQC5b3ZrgtUtQKIQTW5pQExMtuxrzEFl2XQvpKcXsyI0
	 heTjh6IUDOX+4ok55xi/T0d83AFvjjtd1IXCMkfbsRaw7LzXaIZjR7TSIU3KD8qqz7
	 CMEj/2FQbyDgj2Js9JTF6fTRsXBazq6FTwQ7flyZ28ODSwN9wvFvmONJCc5ts8BiV6
	 mBUq5m5+iJVB5CmnTJ9G0DrnQGlG//v/4rXGyIU3IIsRCKHQyyqjWADU/saKAqwGsV
	 7wgKk3tJczKrlcVwVOugm/m6y1kLptASEWFE77VQ4T9LyFhQ5QsbeD5671ykOdJGRy
	 zbyAZNFhs8Iyg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-s390@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] s390/syscalls: convert filechk to if_changed
Date: Mon, 11 Nov 2024 22:45:54 +0900
Message-ID: <20241111134603.2063226-3-masahiroy@kernel.org>
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

The filechk macro always executes the syscalltbl script (and discards
the output if there are no changes).

Using if_changed is more efficient because it avoids running the script
when the target is up-to-date and the command remains unchanged.

All other architectures use if_changed for generating syscall headers.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/s390/kernel/syscalls/Makefile | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/s390/kernel/syscalls/Makefile b/arch/s390/kernel/syscalls/Makefile
index 3725dd88428c..c5d958a09ff4 100644
--- a/arch/s390/kernel/syscalls/Makefile
+++ b/arch/s390/kernel/syscalls/Makefile
@@ -23,23 +23,26 @@ uapi:	$(uapi-hdrs-y)
 # Create output directory if not already present
 $(shell mkdir -p $(uapi) $(kapi))
 
-filechk_syshdr = $(CONFIG_SHELL) '$(systbl)' -H -a $(syshdr_abi_$(basetarget)) -f "$@" < $<
+quiet_cmd_syshdr = SYSHDR  $@
+      cmd_syshdr = $(CONFIG_SHELL) '$(systbl)' -H -a $(syshdr_abi_$(basetarget)) -f "$@" < $< > $@
 
-filechk_sysnr = $(CONFIG_SHELL) '$(systbl)' -N -a $(sysnr_abi_$(basetarget)) < $<
+quiet_cmd_sysnr = SYSNR   $@
+      cmd_sysnr = $(CONFIG_SHELL) '$(systbl)' -N -a $(sysnr_abi_$(basetarget)) < $< > $@
 
-filechk_syscalls = $(CONFIG_SHELL) '$(systbl)' -S < $<
+quiet_cmd_syscalls = SYSTBL  $@
+      cmd_syscalls = $(CONFIG_SHELL) '$(systbl)' -S < $< > $@
 
 syshdr_abi_unistd_32 := common,32
-$(uapi)/unistd_32.h: $(syscall) FORCE
-	$(call filechk,syshdr)
+$(uapi)/unistd_32.h: $(syscall) $(systbl) FORCE
+	$(call if_changed,syshdr)
 
 syshdr_abi_unistd_64 := common,64
-$(uapi)/unistd_64.h: $(syscall) FORCE
-	$(call filechk,syshdr)
+$(uapi)/unistd_64.h: $(syscall) $(systbl) FORCE
+	$(call if_changed,syshdr)
 
-$(kapi)/syscall_table.h: $(syscall) FORCE
-	$(call filechk,syscalls)
+$(kapi)/syscall_table.h: $(syscall) $(systbl) FORCE
+	$(call if_changed,syscalls)
 
 sysnr_abi_unistd_nr := common,32,64
-$(kapi)/unistd_nr.h: $(syscall) FORCE
-	$(call filechk,sysnr)
+$(kapi)/unistd_nr.h: $(syscall) $(systbl) FORCE
+	$(call if_changed,sysnr)
-- 
2.43.0

