Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6678842A82;
	Mon, 21 Apr 2025 07:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745221274; cv=none; b=KvL9i6MXGPIJUnYrmR+hpaGWW+tLdTurtPaK78H2ZrvzhJ95hSc/MrKfoW3XqcJPx6Fv51+u9TbHzzv5/4j+/jrnq5n9bCXw7d3l7coUh+cUHSh1DB/l6mdreA5/hE0tyh0+JBxbZDRSxqjsoyeznnhbPwXLY1XRf1lgQtg3RoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745221274; c=relaxed/simple;
	bh=7A4KIJxhzQOnGJuAMSwNnQDreE7Acs/kCJswmbM0wFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mFqUhIFUdy+xVADpjfX/up7EaJoKgghLxOjxQIl9Z0s+hx+XQYlgS4o/DmrOivOaKw1t21IsK/nC0GMpZTGRGpMc7tqxMEdJ5muiw0Zz8IzWRkn4ieeBsJ4t6oYEjV+rtp9HeaoFgmSoXREiabT+yKA05lG8ntKh1oUADXhMY2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=c+JZuHZG; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="c+JZuHZG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1745221237;
	bh=Fxs9NxWDxUFieX7yGlVwvGNZOmO3A4Li11xcTkfRoqY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=c+JZuHZGDLyKwHTWf2IUYHfzaucLKIrB4o/xUzz9vMttHACdw7wY2NzotuvJrlNt6
	 rmjuUut7YhwPBBT1GlZmtxPT5ZIqKRblCh+OwLBqi4F5fEQsYFY+vWtQZOcic0TGw5
	 v+HcuuS2HzLH5zJ8i1sa97ZiEnIbbpmiSqK6+ruI=
X-QQ-mid: zesmtpip4t1745221226t7d1c116b
X-QQ-Originating-IP: jqo7yqqOLdTjgbTqbuM2nYummntLNnOIXlBWdBK0Yoc=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Apr 2025 15:40:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10529845600704120540
EX-QQ-RecipientCnt: 22
From: WangYuli <wangyuli@uniontech.com>
To: hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	obitton@habana.ai,
	akpm@linux-foundation.org
Cc: gerald.schaefer@linux.ibm.com,
	viro@zeniv.linux.org.uk,
	wangyuli@uniontech.com,
	meted@linux.ibm.com,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	yujiaoliang@vivo.com,
	shenlichuan@vivo.com,
	cvam0000@gmail.com,
	jesse.brandeburg@intel.com,
	colin.i.king@gmail.com,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	guanwentao@uniontech.com
Subject: [PATCH] treewide: Fix typo "previlege"
Date: Mon, 21 Apr 2025 15:38:37 +0800
Message-ID: <F3FFD123DE5F85F3+20250421073837.64732-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MxdW4jxL6NvXiQrhiHczdKneicZuKJXFOt13NcIfsjbX2xahoTwFtYB/
	Dcrzh8kDp2x7xmH26D7a+5DTTav3rnlyK2Te2hYXvE7FHy49LaUSr/KRshYuLCnJ5sYCSfe
	qypehXgU5mA7FHRPR9DJZCPMjoCL88kUR2kF52PUXfwLxp3xabnnz6K1Mb9I45pgv/CniM3
	qnXyKeD/mtlb6rePQuVyK6WQdrpQ3nG9d6O0r8UXgF5AaalyS9wD5X5GrI/TfMLpO5zaYzp
	xjo+ja3Ns4++6I0c9AoUyyf5iFR9Ask8vsV0qUEGKyFeWvUWPHzStxwZRrY42y56q96ZwQC
	U9kBmo5HQXKBIABNrtm9QMh55Jq9SykpBzDefyh5n/8Ck02u1ZfvOEpyZQ4bM4UIMduKoOT
	+TDK4407AaNQae/7K4Ok7xbwD079zdxZYjnY0Zhn3dwZHRPgEULmOzrtTEQ9HspSaUYdLeP
	fdb7QeG9khVFvZRHKLaofv6qIQeQr86mxLkaqu629UVzGppXpiGTVHGrx9TY7gGRo8zyx4Q
	MnWNLWoJw6FylYSJpr6kkbNqrUvi5WiKshu+g/gBJQ2YeUEbv2QR4gNk5+bgz2YZBnYTUBT
	AzhfWTgb2NQ+dow55QPVXMkgbEtBAffZmsdeAzVsvwdlEAGFEBNO4paN2NvtDvN9ZfKkvU3
	YTEW+F5il3ZkBmWo9pPu2itQg8UZawIFBIkWGUcpc6sN4oM5nmNLLS92WD0QIWnxm9o4R5h
	QOBncOXfUevJ65p2GkNRn8H4q2JRM7NXtuqrkHqtymjrH9arA+0Ev5OLWADfalUAAXQIiPV
	zvu3nyW2t+wOP+sNFi4GNCICQ4+vDWKvIOLJDbc+fsV6FqlBv1UUinnV5G9S0hXBioVDz66
	vWoZJrVLDttkbiwbvpY/6jmo1sUH3HPxM2sNBaDNgDENO9tMYT0rLApU1Kre2kb7axPDkFX
	Kt2pYAzxR/Dtl3afFNo/ZGeA0ztvgPV8SsAspHloJjLxJTBtezjnPZdl9o4lU18Fmr3Oob0
	B6NZuP57ArAFUuCpUkvFtCBnmOYBo=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

There are some spelling mistakes of 'previlege' in comments which
should be 'previlege'.

Fix them and add it to scripts/spelling.txt.

The typo in arch/loongarch/kvm/main.c was corrected by a different
patch [1] and is therefore not included in this submission.

[1]. https://lore.kernel.org/all/20250420142208.2252280-1-wheatfox17@icloud.com/

Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/s390/char/vmlogrdr.c          | 4 ++--
 include/linux/habanalabs/hl_boot_if.h | 2 +-
 scripts/spelling.txt                  | 2 ++
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/char/vmlogrdr.c b/drivers/s390/char/vmlogrdr.c
index dac85294d2f5..e284eea331d7 100644
--- a/drivers/s390/char/vmlogrdr.c
+++ b/drivers/s390/char/vmlogrdr.c
@@ -255,7 +255,7 @@ static int vmlogrdr_recording(struct vmlogrdr_priv_t * logptr,
 
 	/*
 	 * The recording commands needs to be called with option QID
-	 * for guests that have previlege classes A or B.
+	 * for guests that have privilege classes A or B.
 	 * Purging has to be done as separate step, because recording
 	 * can't be switched on as long as records are on the queue.
 	 * Doing both at the same time doesn't work.
@@ -557,7 +557,7 @@ static ssize_t vmlogrdr_purge_store(struct device * dev,
 
         /*
 	 * The recording command needs to be called with option QID
-	 * for guests that have previlege classes A or B.
+	 * for guests that have privilege classes A or B.
 	 * Other guests will not recognize the command and we have to
 	 * issue the same command without the QID parameter.
 	 */
diff --git a/include/linux/habanalabs/hl_boot_if.h b/include/linux/habanalabs/hl_boot_if.h
index d2a9fc96424b..af5fb4ad77eb 100644
--- a/include/linux/habanalabs/hl_boot_if.h
+++ b/include/linux/habanalabs/hl_boot_if.h
@@ -295,7 +295,7 @@ enum cpu_boot_dev_sts {
  *					Initialized in: linux
  *
  * CPU_BOOT_DEV_STS0_GIC_PRIVILEGED_EN	GIC access permission only from
- *					previleged entity. FW sets this status
+ *					privileged entity. FW sets this status
  *					bit for host. If this bit is set then
  *					GIC can not be accessed from host.
  *					Initialized in: linux
diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index a290db720b0f..ac94fa1c2415 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -1240,6 +1240,8 @@ prefered||preferred
 prefferably||preferably
 prefitler||prefilter
 preform||perform
+previleged||privileged
+previlege||privilege
 premption||preemption
 prepaired||prepared
 prepate||prepare
-- 
2.49.0

