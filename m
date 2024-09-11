Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAC015FA92
	for <linux-s390@vger.kernel.org>; Wed, 11 Sep 2024 09:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726046067; cv=none; b=ZiZIxFyxZG5GB0n+aqEvm2lMrz20cSwaX2IIPNosSMO2zxt2nTgDtPAKxyW3HMscITWBU/5P8aRX86tLId+k/twDRc6+5zcsbJJ1SqL8ZX/ZpuzFuC65UKB4ribPkk3PzCMmDKRn7VFIqKL+rW+R5cbzvVj2O1bpI7+HFX1NLVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726046067; c=relaxed/simple;
	bh=ciezj6suK8ae2LMf3k1SJHPNAeqNjKPjkp60vGmAGcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNM22geuri4O5YISLJlJSLEqF6+QFZ5oJM1aRNkWKBmgBZCEwX44pV8GpUW8VebJnM6EGCl5MfYBMHXt8K3Ss0guB7JA38PWIvNrbwcelOe05Owt/TYOMwXkwQ+CGS42aBLSGJADoowPV5CFNixGN67c+GruEOxBB20fKptFniI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Euz6oyDc; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Euz6oyDc"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726046062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MjH3y5GFZG4iHF0CwOafpGZ1X8c3+7VTVQzIHYqdBQI=;
	b=Euz6oyDcYjtOpteyceqjb20WH4aWa8y1bSxbcm2wTTp8P+Bg8DY4V2Uu36HzRSnssfq8xJ
	Fqk4vTcyLs8THPrsw8ErJkMKfRzbgxfN2qAvc3U9npGnGrsXuGEbz5vrCRyFnHrOEocuYk
	S9sibAFjqJUI65I0k8/wmhqsIDpM0ks=
From: Andrew Jones <andrew.jones@linux.dev>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org
Cc: pbonzini@redhat.com,
	thuth@redhat.com,
	lvivier@redhat.com,
	frankja@linux.ibm.com,
	imbrenda@linux.ibm.com,
	nrb@linux.ibm.com,
	atishp@rivosinc.com,
	cade.richard@berkeley.edu,
	jamestiotio@gmail.com,
	Nicholas Piggin <npiggin@gmail.com>
Subject: [kvm-unit-tests PATCH v3 2/5] Makefile: Prepare for clang EFI builds
Date: Wed, 11 Sep 2024 11:14:09 +0200
Message-ID: <20240911091406.134240-9-andrew.jones@linux.dev>
In-Reply-To: <20240911091406.134240-7-andrew.jones@linux.dev>
References: <20240911091406.134240-7-andrew.jones@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

clang complains about GNU extensions such as variable sized types not
being at the end of structs unless -Wno-gnu is used. We may
eventually want -Wno-gnu, but for now let's just handle the warnings
as they come. Add -Wno-gnu-variable-sized-type-not-at-end to avoid
the warning issued for the initrd_dev_path struct. (Eliminating the
warning is preferred to reworking the struct, because the
implementation is imported verbatim from Linux.)

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Andrew Jones <andrew.jones@linux.dev>
---
 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index 3d51cb726120..7471f7285b78 100644
--- a/Makefile
+++ b/Makefile
@@ -50,6 +50,8 @@ EFI_CFLAGS += -fshort-wchar
 # EFI applications use PIC as they are loaded to dynamic addresses, not a fixed
 # starting address
 EFI_CFLAGS += -fPIC
+# Avoid error with the initrd_dev_path struct
+EFI_CFLAGS += -Wno-gnu-variable-sized-type-not-at-end
 # Create shared library
 EFI_LDFLAGS := -Bsymbolic -shared -nostdlib
 endif
-- 
2.46.0

