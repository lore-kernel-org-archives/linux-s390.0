Received: from mail-108-mta100.mxroute.com (mail-108-mta100.mxroute.com [136.175.108.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AB5255F5E
	for <linux-s390@vger.kernel.org>; Wed,  1 Oct 2025 17:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759340764; cv=none; b=VELoYd7eVCEOz2y1Jaw0EDSzC7N2n+PRxy/urkohO/JZ73CxVYDkEDDi7rooXidMwATYihtfLRjEAk/3OPxczQMNxC6OYOX1wFZsQho9BF4SQj/Wn7QNX9moq28RSn/TE5jCO2Wq7lmpBcTMXOrPJ8qv5VUPJtoXd99vkw/vVDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759340764; c=relaxed/simple;
	bh=iiVkYuz/2XXwRBeJ5iI3BuDDQXdoqvoAcA4HlOwwwJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IeE6XsYM8LA1PIiMzewZPe30zCf8iMOsv6VfOoAGGBMs7mxPYycpGgfW2tGXfCEOLtQ31xpcKCUcqp7RAdyIpYUfQ92xd/ScjEFOgwHANU9kGp41ZcTNFGeZbEdlAdvUZMVVrsvlxgcv4IBTeV66yHv970zFXT4NVyapCV5YucU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=josie.lol; spf=pass smtp.mailfrom=josie.lol; dkim=pass (2048-bit key) header.d=josie.lol header.i=@josie.lol header.b=EH7EU1tJ; arc=none smtp.client-ip=136.175.108.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=josie.lol
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=josie.lol
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=josie.lol header.i=@josie.lol header.b="EH7EU1tJ"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta100.mxroute.com (ZoneMTA) with ESMTPSA id 199a0dcd350000c244.00b
 for <linux-s390@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 01 Oct 2025 17:40:50 +0000
X-Zone-Loop: d3ffcbf34e2a4cded84fedaa40518b673c6a259a9df6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=josie.lol;
	s=x; h=Content-Transfer-Encoding:MIME-Version:Date:Subject:Cc:To:From:Sender:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=IibJPiL24xaDFWeZlLX0HfLUN4QwapSI53d0jSp1xlw=; b=EH7EU1tJE1AK
	I1tkycOlhPLTdFSxHQ8hcPJMRxU55WWQBjoIozUj7EquMztld30vP22GJWrfLsNHgr2UAjhUibXq/
	4yCQjHraVM6RnRRWo79oayHkV/yZHLWAm9Q3Bsvw0/qGXP6jdD80NrQ6JIvtnEG6bX1HmB++F3q1h
	6PvkfUnbllXEKzSpT2W+AcZt171j1qGkbwfnDZ/CEMMBfQ0HOKRWuyId1+PwY1/iIIpkbUVDjWLEw
	6MOO+dK9QmQTOB3FEtu7bgdtTFih2O0gO+4OzAHZE78hdilqKsta0gBBylB5uVtN056VuWOmCqRK1
	4VzKLEH0YAqK9kWvULkHMw==;
From: Josephine Pfeiffer <hi@josie.lol>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	kvm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] s390/kvm: Replace sprintf with snprintf for buffer safety
Date: Wed,  1 Oct 2025 19:40:46 +0200
Message-ID: <20251001174046.192295-1-hi@josie.lol>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: hi@josie.lol

Replace sprintf() with snprintf() when formatting debug names to prevent
potential buffer overflow. The debug_name buffer is 16 bytes, and while
unlikely to overflow with current PIDs, using snprintf() provides proper
bounds checking.

Signed-off-by: Josephine Pfeiffer <hi@josie.lol>
---
 arch/s390/kvm/kvm-s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 6d51aa5f66be..005c117be086 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3371,7 +3371,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 			((char *) kvm->arch.sca + sca_offset);
 	mutex_unlock(&kvm_lock);
 
-	sprintf(debug_name, "kvm-%u", current->pid);
+	snprintf(debug_name, sizeof(debug_name), "kvm-%u", current->pid);
 
 	kvm->arch.dbf = debug_register(debug_name, 32, 1, 7 * sizeof(long));
 	if (!kvm->arch.dbf)
-- 
2.51.0

