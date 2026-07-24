Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6FA1C5D7D;
	Fri, 24 Jul 2026 02:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784859311; cv=none; b=olxe6ZgDNqXYf60vlPy/nfASZjJLAPhbucyzoG8O5cFHbEuQQrkCy8xj5uKV+y+xeo0AmX/ALJzFlPQrVzYAPUSY2KOyOeICEI4fA+j2bAIyqtTICz0XyRrsGLDpH/JjMcUN0W3D5szONBIzS4RthGcv6hMgzoYqCAfL7cIP5Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784859311; c=relaxed/simple;
	bh=C2IH9lN6ISt8C5qJl7zLutJbyLDuah7mmkj1ow/z4U4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oK4iQLwXRZ0RCf2FfLGfJN6A/Vkdbll3ewxOH4XJKiUiqaFCbWFpLrFXJDbUQZ4ne4X9jp9cBSMzgRfc6dIrc01p+3EbsbtJygx9glHBOF3tz2pg7R2B4EL2r5kAqVYxbTIWE9axvG+J30jDr1bgTz6bK40CGPK776RxtSzlz1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=e4V5LBZg; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="e4V5LBZg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=R0
	fZk7cw47NM3PZyeQotTKEsd6zLI7x4WIDlkM2CwcM=; b=e4V5LBZgUcm5oq799U
	7a3h6abrPnRrCCVAvummdZRPY8PbC0JeoIi/jMUsu3oBmHVz0vsso+pLxULG/D1v
	xCoCVPqs72DWoIg/AsQRHgzlMviTeGpOYmqNBW1jHGynpeFYHGo6XiuVKyQ4sbm/
	oxpAlt6fWlzkbCvbLcBdYsNNA=
Received: from song-MS-7D48.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSkvCgDnr+wRymJqH7z4DA--.34972S4;
	Fri, 24 Jul 2026 10:12:43 +0800 (CST)
From: Song Chen <chensong_2000@126.com>
To: arnd@arndb.de,
	kees@kernel.org,
	clm@fb.com,
	dsterba@suse.com,
	linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	guoren@kernel.org,
	kernel@xen0n.name,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	agordeev@linux.ibm.com,
	svens@linux.ibm.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	jpoimboe@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Chen <chensong_2000@126.com>
Subject: [RFC PATCH v2 2/3] btrfs: Allow error injection on btrfs_data_csum_ok
Date: Fri, 24 Jul 2026 10:12:28 +0800
Message-ID: <20260724021229.47302-3-chensong_2000@126.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724021229.47302-1-chensong_2000@126.com>
References: <20260724021229.47302-1-chensong_2000@126.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSkvCgDnr+wRymJqH7z4DA--.34972S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFWfZr4kWFykJw4xJFWrXwb_yoW8Xw4fpr
	WUGw1ruFWDXr97Wrs7Gay09ryFg3yDWa10gFnxZw4YywsIkw1FqrZay3WxGa48KrZrX343
	Z3Z0gw17ZF1DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07USeH9UUUUU=
X-CM-SenderInfo: xfkh02prqjsjqqqqqiyswou0bp/xtbBpRvra2piyhtNggAA3o

btrfs_data_csum_ok validates the checksum of a data block
after a read I/O completes. A mismatch between the on-disk
checksum and the one computed from the read data indicates
silent data corruption, which can be caused by bit flips due
to DRAM errors, storage media degradation, or bus transmission
faults.

Testing the error handling path that responds to such
corruption, including any warning output and uspace
notification, normally requires reproducing the hardware
fault, which is not always feasible.

Mark btrfs_data_csum_ok with ALLOW_ERROR_INJECTION so that
the fail_function infrastructure can override its return value
to false, simulating a checksum mismatch without requiring
actual data corruption. This enables validation of the full
error detection and reporting path in a controlled environment.

Usage:
        cd /sys/kernel/debug/fail_function
        echo btrfs_data_csum_ok > inject
        echo 0 > btrfs_data_csum_ok/retval
        echo 100 > probability
        echo N > times

Signed-off-by: Song Chen <chensong_2000@126.com>
---
 fs/btrfs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 906d5c21ebc4..6be3e920b954 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3574,6 +3574,7 @@ bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 		memzero_page(phys_to_page(paddrs[i]), offset_in_page(paddrs[i]), step);
 	return false;
 }
+ALLOW_ERROR_INJECTION(btrfs_data_csum_ok, FALSE);
 
 /*
  * Perform a delayed iput on @inode.
-- 
2.43.0

