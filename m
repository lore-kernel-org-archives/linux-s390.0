Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86E81D04B2
	for <linux-s390@vger.kernel.org>; Wed,  4 Sep 2024 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447032; cv=none; b=Aw5m8wka3t844YRJh7qpH1jlJARXR6FBUnkZFS3SkNqE7ycztOI/VrTR+n+5Z+9szH2GlHfpE6rAhDiPjjjk7tD8PVZKWsbMIyvTy722Xe3MatGYgtFcPqVfwR090D29BEbUNWux8OZfV0ZQRg+T7C0cOPlB3M/mv9qCu/rC8FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447032; c=relaxed/simple;
	bh=LOlwO9hPMr2XN89BLGxjZ+LzXopK9uHBbqNh8lmkT24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2V9vUuKkOsfWLAyVxTsm513lSdaMhne1uZsj9+moY3/mBAqWYXJbx6M8xqz4WmoOs8l8blnhVDNZSwH3IcsVA1Ug96GTm2SancvA/hU89lpAimRxmIHudWcXCCUfZ0yM7chMDM0rVafgmvW4+QZvYaqPeGDQzbcPF6ebn1JYug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HHF2H9yX; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HHF2H9yX"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725447029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Myu9U8IEbrxLCMMi6SGb7S+yIVucaaKwRIVAbRfcI4=;
	b=HHF2H9yXkjxJiYAPY3icEMi+j2QRE1ZCsM+RJp4sNwAXeNrVZM2TGzSxwZ0eOKf2tcQ5/d
	zRSsTShl3LGbta5Efi5TVD3aVX7fEV3W1Xz91D8WaM+UnLqEqQ+0eVVTLG93W3QyOHFggR
	VkeMJay9znbhrKvHgqJQFKS5p/aE14I=
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
	jamestiotio@gmail.com
Subject: [kvm-unit-tests PATCH v2 2/4] Makefile: Prepare for clang EFI builds
Date: Wed,  4 Sep 2024 12:50:23 +0200
Message-ID: <20240904105020.1179006-8-andrew.jones@linux.dev>
In-Reply-To: <20240904105020.1179006-6-andrew.jones@linux.dev>
References: <20240904105020.1179006-6-andrew.jones@linux.dev>
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
the warning issued for the initrd_dev_path struct.

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

