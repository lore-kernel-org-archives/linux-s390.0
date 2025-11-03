Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4D5284684;
	Mon,  3 Nov 2025 06:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762150133; cv=none; b=gJq+ly4kIMQwtZq5Wb8lnL8RdIzLMn2QoM4Dgyk/Gpeb5XVZOTDllm5YCcZ3PsDWJuWtQX9FRVuadM6Qg1T4M+CutFSohwAEts0p2nOrTJVuOw8jCrWL/008FF2e6x35RZbSqPalMHqZ5aKWTyntGdqthDK1UmJ+/w3BZER70eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762150133; c=relaxed/simple;
	bh=ij7SSqEkbo4mNi6ysGnvvLGMAM4tjimDlNEUDeNc4Kc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KF8wDEp2yD5TJU6X+IhAubpbmY9IxLBDGN9tiAXyyO9sF5ELLEXz/y1T1ndQJHiUiNkdhQ7l99859qPz+lxVk6i5dDszVRYdMnvt1QVFhZ5FIkpQjjHIQU3XGg2f7KEbvJ7jvWIFO9Xj+hQdoKWNGMkwhG7lWRqYMv5jn4jF0sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [106.117.100.156])
	by mtasvr (Coremail) with SMTP id _____wCXkENBRghp0QdPAw--.12221S3;
	Mon, 03 Nov 2025 14:05:54 +0800 (CST)
Received: from ubuntu.localdomain (unknown [106.117.100.156])
	by mail-app2 (Coremail) with SMTP id zC_KCgA3UEQ7RghpGF99Aw--.25113S2;
	Mon, 03 Nov 2025 14:05:51 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	mingo@kernel.org,
	tglx@linutronix.de,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH] s390/tape: fix use-after-free bugs caused by tape_dnr delayed work
Date: Mon,  3 Nov 2025 14:05:44 +0800
Message-Id: <20251103060544.22720-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgA3UEQ7RghpGF99Aw--.25113S2
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwQSAWkHs-8AbwA+sn
X-CM-DELIVERINFO: =?B?yloTDgXKKxbFmtjJiESix3B1w3uoVhYI+vyen2ZzBEkOnu5chDpkB+ZdGnv/zQ0PbP
	CR15Vie2bMrbJnHqI6rTqE7nL4FhIxvV4PEkCBxd2xL2aDveEeLLuEIaoCXDa3CO8ounDo
	CWc4HIlAA4hKbnpcp4/J/FqLF/BbAV+6VQ+YBDSF9uI9lEwaeBPdnyJNs6TwlQ==
X-Coremail-Antispam: 1Uk129KBj93XoW7ArW5tF4xCw1DuFWfuFWUJrc_yoW8CFWkpr
	Z5J34qy34DWw40ka13X348uF1UG39rC3yUKrn2gwnagrn8A34rGryqqFnaqFyUJrWkAFW5
	Xr9Iq34UuayDtFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvvb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I
	3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxV
	WUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8I
	cVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuY
	vjxU7xwIDUUUU

The delayed work tape_dnr is initialized in tape_alloc_device(), which
is called from tape_generic_probe(), and is scheduled in the following
scenarios:

1. Starting an I/O operation fails with -EBUSY in __tape_start_io().
2. Canceling an I/O operation fails with -EBUSY in __tape_cancel_io().
3. A deferred error condition is detected in __tape_do_irq().

When the tape device is detached via tape_generic_remove(), the
tape_device structure might be deallocated after the final call to
tape_put_device(). However, if the delayed work tape_dnr is still
pending or executing at the time of detachment, it could lead to
use-after-free bugs when the work function tape_delayed_next_request()
accesses the already freed tape_device memory.

The race condition can occur as follows:

CPU 0(detach thread)      | CPU 1 (delayed work)
tape_generic_remove()     |
  tape_put_device(device) | tape_delayed_next_request
                          |   device = container_of(...) // USE
                          |   device-> // USE

Add disable_delayed_work_sync() in tape_generic_remove() to guarantee
proper cancellation of the delayed work item before tape_device is
deallocated.

This bug is identified by static analysis.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 drivers/s390/char/tape_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/char/tape_core.c b/drivers/s390/char/tape_core.c
index 6ec812280221..722dc4737a87 100644
--- a/drivers/s390/char/tape_core.c
+++ b/drivers/s390/char/tape_core.c
@@ -625,6 +625,7 @@ tape_generic_remove(struct ccw_device *cdev)
 	}
 	DBF_LH(3, "(%08x): tape_generic_remove(%p)\n", device->cdev_id, cdev);
 
+	disable_delayed_work_sync(&device->tape_dnr);
 	spin_lock_irq(get_ccwdev_lock(device->cdev));
 	switch (device->tape_state) {
 		case TS_INIT:
-- 
2.34.1

