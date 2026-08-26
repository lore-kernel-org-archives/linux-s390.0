Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC61A385D7F;
	Wed, 26 Aug 2026 06:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787726587; cv=none; b=YV2Yz4kuEnJ4M2Q5UIYAgFoxpL//4YRrdCyt9qtiHahirJutJe+1jbwPUnW5zUpkH3gXbZh+Iqip0vSv9f+t1V4k3hDu6Q5gLePBn7SdIY57J8GCLUoaD/PeHXTzUGic2JM4E5LH9FVVFE7CwGX/gdQg45vENQohEA7J+K6ZRDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787726587; c=relaxed/simple;
	bh=haehOtgRC6/H8Z5U7OaIi6WpW9A9cp2r2nK3v7SJ9jw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AM82l38HFLLHPOeJrv3Q22np/PHWBGoAT+JclKTdZJLshwMnqdzHVMr1dShl6/gTcIsepWGILlvw7czDoSYaAhG36nn2n2HJK0SfdyHsTuEFkeas7LdRfhqwZX8AxsfBqp2IzyIW3aqNAYuadfgLICTq/pFT1DM7IHS78igCj7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=pass smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinsec.com.cn
X-QQ-mid: zesmtpgz9t1787726555te103fdc8
X-QQ-Originating-IP: KCt/DQNoOFhdq2S2rDisVv3HloK35UlhFtbNUH7wwog=
Received: from localhost.localdomain ( [111.8.45.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 26 Aug 2026 14:42:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15483364678053419187
EX-QQ-RecipientCnt: 13
From: Liu Dalin <liudalin@kylinsec.com.cn>
To: Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Dalin <liudalin@kylinsec.com.cn>,
	Deng Yingchao <dengyingchao@kylinsec.com.cn>,
	Qin Yungao <qinyungao@kylinsec.com.cn>,
	Luo Qiu <luoqiu@kylinsec.com.cn>
Subject: [PATCH] arch/s390/pci: fix fixup_user_fault() calls with NULL unlocked parameter
Date: Wed, 26 Aug 2026 14:42:28 +0800
Message-ID: <0726CF177011E0E2+20260826064228.3255764-1-liudalin@kylinsec.com.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:kylinsec.com.cn:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NQvpx3reNVf3QeZ4XZT39Nup1nZPJJdiHpBpgp23SHQVB5S9oOrCDRvO
	abp7JxMx8JqQyc23bOAxemOYk3NN561fU58WeUBL/g38kiJRV+AKL3AneyKZxrpqfwaYVVr
	ROxp0csg3/FNvzVAubWnDCIep0Dj6YJShP0RIBXaBgYq9j91nXJwpDCy45mSYUx4ctRpp8b
	fAA8i3L6bLbRtme4HoRwzMHunwyQ9DE5A7jeQfqy/rS0SIS9KEgWIq/KeG+6yEY41HIC8+Y
	Fk8yvRoq9KJjIoIreyaFNJvO0ByaJusI/VrjS907SI+yNe9vmjWUq94+CYiEoqcbSlEi4s1
	dEliaipOd8uNGZcRTITVXyCKl6wd6mGpubxPGI7kz54HaMXwmYcpCVZ7vxhHtrwrKIp/vZI
	0HnjW0J3jILGYl1uybMkQq8rwX0VnY87H6XYB4Z8n+Y35qWiS5gmA1+L0BmqrQ+lySj4Kf7
	SEZJYxRUPer1hvhEO1UmQG9qzCzWebePElFbfz7J1ZvOarT8Ow3Tudof/F/7Gp8VW2YJtb6
	DYmzMh5rsI8JLmq/qSb+JjtwohchZdInExiiMiLMV6gej/ZWbHp7N4PtJl7NTKGvOO9WxNa
	9pAYEHCjE5ZrMTc+E6gNbYEbt3ZIqowbdwWuTTqnGSt4Cg84iqw2XL3VqL3BmJ3DHr3I88P
	xX9gHU34HrJDXrTUF+EPIkQiwS7QeBro5XWX+O/ARX0/o4mxIj/s+B6pzBWbMrMN8vc2shA
	R6FEYw3B/cq2n6Q4RUd5T1e0VPQiUjpCeXEwWAcWum1BcyptiQuwauc2DYxHoExFU5y6lyl
	hXI4RB5gnC/iv/7cLCzCa4uc3jmTwfRx47r9SvGK6zlTJ9b4VLaxB1x9W+XkDe+IDFi/Jjw
	K3vh/timwdVSR+JSNwjZMq9LUqEeXCY9ROe0rtsIVzlnaIHmP4DzVAtAlA7xUIERj1kNHtd
	JtuDDUE6sN5O44fkSIRq7mdW6QWOr9oCdxKS/BGvqQztYwOQAZ4tKR95cVs5+KE2JQPFnwc
	0A4r7VlJ5Ge7gHdwLNVu26Z2vqscZHBK8x6aDIwTRhHuOOz64Z
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

The s390 PCI MMIO functions call fixup_user_fault() with the 'unlocked'
parameter set to NULL. This means when handle_mm_fault() returns
VM_FAULT_COMPLETED or VM_FAULT_RETRY, the function re-acquires the
mmap_lock but cannot notify the caller about this state change.

This is problematic because the caller subsequently calls
mmap_read_unlock() at the end of the function. If the lock was
re-acquired inside fixup_user_fault(), the unlock happens correctly.
But passing NULL makes the code fragile and hard to reason about.

Fix this by providing a proper 'unlocked' variable to fixup_user_fault()
so the lock state is properly tracked.

This is a follow-up to the defensive NULL check added in fixup_user_fault()
by the previous patch in this series.

Fixes: 41a0926e82f4 ("s390/pci: Fix s390_mmio_read/write syscall page fault handling")
Signed-off-by: Liu Dalin <liudalin@kylinsec.com.cn>
---
 arch/s390/pci/pci_mmio.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/s390/pci/pci_mmio.c b/arch/s390/pci/pci_mmio.c
index f3f79ba78410..5ef2d6436d4b 100644
--- a/arch/s390/pci/pci_mmio.c
+++ b/arch/s390/pci/pci_mmio.c
@@ -182,7 +182,9 @@ SYSCALL_DEFINE3(s390_pci_mmio_write, unsigned long, mmio_addr,
 	args.vma = vma;
 	ret = follow_pfnmap_start(&args);
 	if (ret) {
-		fixup_user_fault(current->mm, mmio_addr, FAULT_FLAG_WRITE, NULL);
+		bool unlocked = false;
+
+		fixup_user_fault(current->mm, mmio_addr, FAULT_FLAG_WRITE, &unlocked);
 		ret = follow_pfnmap_start(&args);
 		if (ret)
 			goto out_unlock_mmap;
@@ -335,7 +337,9 @@ SYSCALL_DEFINE3(s390_pci_mmio_read, unsigned long, mmio_addr,
 	args.address = mmio_addr;
 	ret = follow_pfnmap_start(&args);
 	if (ret) {
-		fixup_user_fault(current->mm, mmio_addr, 0, NULL);
+		bool unlocked = false;
+
+		fixup_user_fault(current->mm, mmio_addr, 0, &unlocked);
 		ret = follow_pfnmap_start(&args);
 		if (ret)
 			goto out_unlock_mmap;
-- 
2.43.0

