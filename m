Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F39359A81;
	Tue, 23 Jun 2026 07:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782201188; cv=none; b=foQi8WeclozSKNxBGZ2K4+VuopjMy72gPnP8byLrFON2PaKq8YgoTTUf0STNxWOkIDs6LY77KXS8/wfVq/cELTLplE7e6pudB18AeTatLCFFo1yKEFgeC5vLbFAdoNB6HUv55qX1HJo14expWwtVGKHDP0orWnndbbYLMmVCYXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782201188; c=relaxed/simple;
	bh=Z8nPTGOELiNpLext6XY/7JueKxLoEarzlsGzHgZZNBc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MqedVo4VCyZiDtO/KU56UtMwoKdthVX+wnHNNYAlt+lrZNGl24ChxtO+bMH1eymxfGnbSzcf6W6z+t9iMQnXj/XIPs0+r/cMsZR8UObF343mNcRhdIYqtTYK4esmNM4WWOQuaFOILQNvTKR2fGl9kRO1q6OqtUJCKaFs4usIjXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KoA63PjL; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KoA63PjL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Cc
	rcH5t6ZYGuhJDVVH+tDRtjwGRf2id6dqNPTyNJhlc=; b=KoA63PjLb96hByd0Qb
	BOK9IX9Cu7IViYzaNf219D2sTTo9+8GbLV5gS5fzBIVVS3yMUH2VkKKTIqnJa8rN
	QAEPtRL9Jz+tg2YoJI2IA70VJkcB6XRXahIswdqzmnhKNCpR45OM3b000dtZJVqs
	tOogSP6Du+UGR/9zxjbJ8DJ44=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDnOeA1OzpqI+i9Dg--.16449S2;
	Tue, 23 Jun 2026 15:52:28 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: mjrosato@linux.ibm.com,
	alifm@linux.ibm.com,
	farman@linux.ibm.com,
	borntraeger@linux.ibm.com,
	frankja@linux.ibm.com,
	imbrenda@linux.ibm.com,
	david@kernel.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	svens@linux.ibm.com,
	schnelle@linux.ibm.com
Cc: linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: s390: pci: Fix GISC refcount leak on AIF enable failure
Date: Tue, 23 Jun 2026 15:52:20 +0800
Message-Id: <20260623075220.2022613-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDnOeA1OzpqI+i9Dg--.16449S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFyUtFWkZr4rJFyxJF1kZrb_yoW8Gr15pa
	4UC3Z8G3sYqFW0yF47ta1v9FyUuayUGr4xCF18J3y2qr1aqFyvyFZ5AFyUZr45GrW8u3Wr
	AFZYkF1DuF98CaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JU5GYdUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7h0HdWo6Oz2DEwAA3H

kvm_s390_gisc_register() registers the guest ISC before pinning
the guest interrupt forwarding pages and allocating the AISB bit.
If any of the later setup steps fails, the function unwinds the
pinned pages and other local state, but does not unregister the
GISC reference. Add the missing kvm_s390_gisc_unregister() to the
error unwind path.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 arch/s390/kvm/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 5b075c38998e..a9d5996590e7 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -252,7 +252,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	srcu_read_unlock(&kvm->srcu, idx);
 	if (npages < 1) {
 		rc = -EIO;
-		goto out;
+		goto out_unregister_gisc;
 	}
 	aibv_page = pages[0];
 	pcount++;
@@ -327,6 +327,8 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 		unpin_user_page(aisb_page);
 unpin1:
 	unpin_user_page(aibv_page);
+out_unregister_gisc:
+	kvm_s390_gisc_unregister(kvm, fib->fmt0.isc);
 out:
 	return rc;
 }
-- 
2.25.1

