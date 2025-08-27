Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A102798EB;
	Wed, 27 Aug 2025 10:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756291356; cv=none; b=UfGzyNENUaCpI5aWFr9kO9zVUqLrnP1yg41D9FLIyPmPkTFZWgY3kkoXXrLS0j7Qoy8WV+IBDK3kBT91kDPLVKgCusZxKqipfipGsNcUMq+HiP2h4GWyKBJJBXXmbu2adw+hI/QZDiPeuyyWWMOyddAY45hnERZ+Sn54xTlYH6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756291356; c=relaxed/simple;
	bh=rML8t243wUUhsl2OLv0RtLzgEBGwxGXZlMqXmCPiepA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZVvvcEHoyqFKSas5FLu/t5Pm7PHdo4S1Ptc4in7orylEOpOUWuS8VjSf7UsxPOR2oF+g+IWvanSPmWWZApi0cWw6/S0P79uVLQl0J02AWBsxjUv1H6r/SIpgbLE7XfLbM6VdFeSMnoaLYRAQDVQeejWgFFuLKtZDsDC7Nkbxc0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61c30ceacdcso1247151a12.1;
        Wed, 27 Aug 2025 03:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756291353; x=1756896153;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1u4zcic0l+T6GeQNUmUI9Uac9hp+HfKFNViGwyEQyPY=;
        b=oev0gm4ou3zRVt8r46aYJwnk2saB/MiZa5X7bGF1w6SLeUu5wck9wCHGl77ix4K227
         bVdBmG7tWG5c4/0dgRPY+hzyEZOvF6GUqQQ07txa/jB35jXWbJzbvIkvlLzZVIrVokNc
         Gc1TupguOQOtFvfAzL7fSAzMWQC8o49VNfPDI80+MJP7R2nyL26Lm8YqyrSAk/KMz4dw
         cz+YgXf9lYg2zld5LAuv8rcnIGOxB/ovxbq5GoEG9jjkHj1nRqergOt89A5p3GyAKuo6
         K8f84SragB2QQcNJ0+mIxoVyM+pkMXQ9a9flqdVfbgpoOGy/6SlK7z2pSqoXff58hUVq
         P77w==
X-Forwarded-Encrypted: i=1; AJvYcCVUdFicZR49V2aNXmzIavV2p9usXwLAGYnFBAl28Bc1sYq6FYXmIyhlGn7+GS23JhPCBU/WmaReje+y4ls=@vger.kernel.org, AJvYcCWVciCLWPqF1lkzASxa5eFkm4UQcf5pf43xLvHBzCAHw7pR5MiVMOqQh3cpnEP+rXb7dykdDSsFnjA2Eg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXTFZEfE1MwW+q3MJrXYj+K2tnaBH4kAZv3MpdLl4BO31E93sQ
	QlRyUdbhwXeeXBYzDPXnb+2eGwjEjnlphNIDW7FIt7ppa7di71FYJpid
X-Gm-Gg: ASbGncsYwS9N1O9wWJ/cyTS8RpnAVC4JIZm54nNkkLoz5c5UvmO+wu5Go2NaviKGRCv
	vhgJX8lMklguocptI8OLUMV/s5VTq9nP1xrGpKG8N3em0Ph9tjBDRTxCb164l/VRug9QcOcCiFq
	vKsEoz/opmEcIjT7h4XokPBxnD9QqNRe3/wFn18VHh5MiZpK25nq980jLJv5gOz0RwPUve7rtRe
	nwUg5ezehD7x6BeJCp/GVdXnPMj45uHtSAOto7rVNF7DXTmfiN+s5ULJDnn7OjlxRZfYCh73r54
	mzfgcYxP6rSYXDaxVb++tqccHemlabsfDqzh/qdNV20dYM6I5dbDw5RnMobDdn+YBvEXQHT7Jad
	HCvkVwjI2jJ5V1Ltt26sKUAM=
X-Google-Smtp-Source: AGHT+IGjq9XcVFJfT48t3D2sSSWpKBUwYgoLrOJ85gEuT6CFTvTN24ctslyJVbJFjI6uf4ov/6pprA==
X-Received: by 2002:a05:6402:4cb:b0:61c:4222:4856 with SMTP id 4fb4d7f45d1cf-61c983b899dmr3243783a12.3.1756291352988;
        Wed, 27 Aug 2025 03:42:32 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c3119ffdfsm8866926a12.9.2025.08.27.03.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 03:42:32 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH 0/3] kexec: Fix invalid field access
Date: Wed, 27 Aug 2025 03:42:20 -0700
Message-Id: <20250827-kbuf_all-v1-0-1df9882bb01a@debian.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAzhrmgC/x3M4QpAMBQG0Fe5fb+tZrXYXkWSzcWN0BYpeXflP
 MB5kDkJZ3h6kPiSLPsGT2VBiHO/TaxkgCcYbayuTaWWcI5dv64quMHa6IwrOaAgHIlHuf+qad/
 3Awsgpn9aAAAA
X-Change-ID: 20250827-kbuf_all-b9d55c9291eb
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Baoquan He <bhe@redhat.com>, Coiby Xu <coxu@redhat.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1971; i=leitao@debian.org;
 h=from:subject:message-id; bh=rML8t243wUUhsl2OLv0RtLzgEBGwxGXZlMqXmCPiepA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoruEXzwuDBBiV9rroaHj06zedE14jXSY01dNDe
 05pyXnMz2GJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaK7hFwAKCRA1o5Of/Hh3
 bQ8zEACrimEGA/OQuvFVrT8mrQ5Mr4ou2ECD6x2JT6IN4mZlhwCnR7sMQJqrC032rCxgekihaHs
 7Ki113795L3C7BTYvyPWbwWtUQaPsSQ0/UJ+6m2XCmjDAbJ7t/WO9A7UVM1FR5idIjTV1oBNTtC
 wpOrdPVNCg0WaxKKdASKjM8a8hVT3jA87Jk7R4lGAjpJaeJy9aftaNWBa8NsFXHwpy75km7tcGF
 SBFX3mhGEe8J9dGy4/nAeVnGht9vZ9Hq5YaznVRgYZyPIfY1G8ZuhDcm+EZtMwSxhi5W//q8LKY
 iUp/8X6lf79htbfC+5DOcq59ZKX/xLV4z90bdmafjP2oy/VIu5caJj1zAve2+Dz27xhy6vjd43W
 C657LTC1KH1FkT7zo9gIQ6ZaH2okMu4Whhj19eiml86fP+KfCoKc0hk/TokrLnuQyHD9aAkRLFn
 2ucGx3hvFvyGjiL7R5RPhWFjfrY2ZdERinWI7A3v1fnkQxK4MsXgGuMxujjh4Tu34tsjJn/o82U
 8x+dO26drFZw0H50CdChjQHWa8N22UHPNlVrbvc3PK6dK+5GSeqrTGqgvLdqEMu4d4/XNygR13L
 5qH8uiuMDjp1NxTTDlw9LR4RVGAebXqZVAEYDejtp/c80AVXiejNbHTcms+vFKQ3dspdi7xDESB
 kUAepqT0fXLi+cg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The kexec_buf structure was previously declared without initialization.
commit bf454ec31add ("kexec_file: allow to place kexec_buf randomly")
added a field that is always read but not consistently populated by all
architectures. This un-initialized field will contain garbage.

This is also triggering a UBSAN warning when the uninitialized data was
accessed:

	------------[ cut here ]------------
	UBSAN: invalid-load in ./include/linux/kexec.h:210:10
	load of value 252 is not a valid value for type '_Bool'

Zero-initializing kexec_buf at declaration ensures all fields are
cleanly set, preventing future instances of uninitialized memory being
used.

An initial fix was already landed for arm64[0], and this patchset fixes
the problem on the remaining arm64 code and on riscv, as raised by Mark.

Discussions about this problem could be found at[1][2].

Link: https://lore.kernel.org/all/20250826180742.f2471131255ec1c43683ea07@linux-foundation.org/ [0]
Link: https://lore.kernel.org/all/oninomspajhxp4omtdapxnckxydbk2nzmrix7rggmpukpnzadw@c67o7njgdgm3/ [1]
Link: https://lore.kernel.org/all/20250826-akpm-v1-1-3c831f0e3799@debian.org/ [2]

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (3):
      arm64: kexec: Initialize kexec_buf struct in load_other_segments()
      riscv: kexec: Initialize kexec_buf struct
      s390: kexec: Initialize kexec_buf struct

 arch/arm64/kernel/machine_kexec_file.c | 2 +-
 arch/riscv/kernel/kexec_elf.c          | 4 ++--
 arch/riscv/kernel/kexec_image.c        | 2 +-
 arch/riscv/kernel/machine_kexec_file.c | 2 +-
 arch/s390/kernel/kexec_elf.c           | 2 +-
 arch/s390/kernel/kexec_image.c         | 2 +-
 arch/s390/kernel/machine_kexec_file.c  | 6 +++---
 7 files changed, 10 insertions(+), 10 deletions(-)
---
base-commit: 3c642997252eef4449cb6b6e02af3dc22515d817
change-id: 20250827-kbuf_all-b9d55c9291eb

Best regards,
--  
Breno Leitao <leitao@debian.org>

