Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74A91DA53;
	Mon, 11 Nov 2024 13:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731332770; cv=none; b=Hmlo0BBZP7RT18dUpsBeornjH/w1oFvuYvXYTUwXRfq+Urz5AfaXAl84xiaNDVEcwYl9c5pOW0NYDsGp6OQM2MnkaRO8wv0OICKi3J1vsmq9dKURZv/8Ig2x2+7TgQ9z1+r4LeJtEsoTn62t0eDi7kxrGcozmNrZAmK8Ibtjj7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731332770; c=relaxed/simple;
	bh=0Eyzv3MRPoYVIDLbBedGYC20H2JMtL4xQlMrE2XL3yw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iDbQxkhzb4J38lyo8FzQJAGo6pYCSsablZGBorSTxZQYWtofmHPFquxIQfczUOSUHXcCzlsbgNJcixolHXeCHcvesBT4tUDulV5tRnn/64zJ2TyxFQKbcoMnHwS8EqRWJWDV5ABzAXnoPXNUGKY+43K/56KXmqeYexIN1t/0OI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVEkw0Sf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVEkw0Sf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2537EC4CECF;
	Mon, 11 Nov 2024 13:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731332770;
	bh=0Eyzv3MRPoYVIDLbBedGYC20H2JMtL4xQlMrE2XL3yw=;
	h=From:To:Cc:Subject:Date:From;
	b=rVEkw0SfUcxLOJedBn0gFsQfAGq5OOaH/9+es90fZbA8PVgYH20YX+tRaqLaUfDiW
	 X0kI/IK07pdMLrz2VZWXWMIJIGXZwld4d5d4r5DfmprIIywqqhEDZjWZocZZ6RE54L
	 961hmZ6dM75ZqkymLDFiyV5ViSzxA+LdddKQ1DrOVovB5b9+FlJ21pUeWxOmakszw9
	 mDv0aTrFA16a85jhA/3TvAzrSNs216xdBugo7ASPvPsyiKBLaSL6hNRFyCiZwsxJXT
	 PUvi+BQQjoG8rjVySOSe8W44sCrk7QHhV7bIouA9+b4z7iSA1nSDATf7q42IihOwGi
	 Z9wzf8IEmFLRw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-s390@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] s390/syscalls: avoid creation of arch/arch/ directory
Date: Mon, 11 Nov 2024 22:45:52 +0900
Message-ID: <20241111134603.2063226-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building the kernel with ARCH=s390 creates a weird arch/arch/ directory.

  $ find arch/arch
  arch/arch
  arch/arch/s390
  arch/arch/s390/include
  arch/arch/s390/include/generated
  arch/arch/s390/include/generated/asm
  arch/arch/s390/include/generated/uapi
  arch/arch/s390/include/generated/uapi/asm

The root cause is 'targets' in arch/s390/kernel/syscalls/Makefile,
where the relative path is incorrect.

Strictly speaking, 'targets' was not necessary in the first place
because this Makefile uses 'filechk' instead of 'if_changed'.

However, this commit keeps it, as it will be useful when converting
'filechk' to 'if_changed' later.

Fixes: 5c75824d915e ("s390/syscalls: add Makefile to generate system call header files")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/s390/kernel/syscalls/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/syscalls/Makefile b/arch/s390/kernel/syscalls/Makefile
index 1bb78b9468e8..e85c14f9058b 100644
--- a/arch/s390/kernel/syscalls/Makefile
+++ b/arch/s390/kernel/syscalls/Makefile
@@ -12,7 +12,7 @@ kapi-hdrs-y := $(kapi)/unistd_nr.h
 uapi-hdrs-y := $(uapi)/unistd_32.h
 uapi-hdrs-y += $(uapi)/unistd_64.h
 
-targets += $(addprefix ../../../,$(gen-y) $(kapi-hdrs-y) $(uapi-hdrs-y))
+targets += $(addprefix ../../../../,$(gen-y) $(kapi-hdrs-y) $(uapi-hdrs-y))
 
 PHONY += kapi uapi
 
-- 
2.43.0

