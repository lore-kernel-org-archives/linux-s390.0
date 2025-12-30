Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C37E1E5B70;
	Tue, 30 Dec 2025 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767109369; cv=none; b=AG341dUlOZBWV61AnMAzo00A/x2g0o3ZCrfgjEC/qVm/S6znmKqlYgSuxlN5JPbMlhThrrA+TLCrOCqP1XN1GHf5iYdWng8jZr2hJEelgONCgWeo59WETIE38J0eVyprMAjHabgMDGM5K8OqehEV0wzpXvxmd0X4SErQ559+fvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767109369; c=relaxed/simple;
	bh=31iN/0A3ISpsNgFc+/X3q11r0JI35txfOPxPq1GpK70=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K+xZHrIFyAZApQK7H8SzYx6a5ehZKh6Eg/xzbqLh4oTwp7gNZ1Z4aZxiQz5zQD+QyzScncac/ngp5meRDcQA1SjvkQh77V82W/0fPEooe1h0QWRulTnm5QV6ofCjx9kZTyzhPouwl/5rRSMjNQeBK/W10G8WEazABiGarxaK2ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=Ipm/wO9z; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="Ipm/wO9z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AHe7mKYajMiHrnNKUIBp7J9tIb5hssyeqYRF6sdYRUY=;
  b=Ipm/wO9zJ2Aml9kyGT27CkZiUZUN4rL2arjrWNXGpIS8VeytoICkJUWA
   /EaH9TMMO2ceBLeCopUq7wNO/escWaQst+Po9eXS6ViIc0i6TJeO0QOq3
   mVYaA1Q2s9Fa0m42OHlCb6/HWXGEFk3DOX5SID9S210BUrTKmX5vD6Qbh
   o=;
X-CSE-ConnectionGUID: FEj7tM7jRIGn+JO5uhDrIQ==
X-CSE-MsgGUID: VDmN9/y7S56cbEGWYMZk0w==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.21,189,1763420400"; 
   d="scan'208";a="256357416"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.102.196])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2025 16:42:44 +0100
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: yunbolyu@smu.edu.sg,
	kexinsun@smail.nju.edu.cn,
	ratnadiraw@smu.edu.sg,
	xutong.ma@inria.fr,
	Holger Dengler <dengler@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] s390/ap: fix typo in function name reference
Date: Tue, 30 Dec 2025 16:42:39 +0100
Message-Id: <20251230154239.98756-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing s into ap_intructions_available.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 arch/s390/include/asm/ap.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
index b24459f692fa..3b95c6531a67 100644
--- a/arch/s390/include/asm/ap.h
+++ b/arch/s390/include/asm/ap.h
@@ -78,7 +78,7 @@ union ap_queue_status_reg {
 };
 
 /**
- * ap_intructions_available() - Test if AP instructions are available.
+ * ap_instructions_available() - Test if AP instructions are available.
  *
  * Returns true if the AP instructions are installed, otherwise false.
  */

