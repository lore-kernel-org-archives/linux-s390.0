Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94157231839;
	Mon,  5 Oct 2026 05:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791179926; cv=none; b=fZmTiON/U8ma8q7WDbYk457SQimNVceirj3nmnpq6g++61LsQ5C9IEkgONK+tJVRAQg80W7OOZEBjvFYLo2XL1apbeQ9qvXvGQSym7XFm18eSi/8AfoH0MW6AVgAr0h+s+DkplJwvdW0m/dxzeGmYPHjlHEaB3qjOZ0pad6yBNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791179926; c=relaxed/simple;
	bh=TXwBxYTIiX9ug/RG0QZQlLRINvlnvwtOqwIzSuPtwI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ruBJItPNZx8JMiv3UjwAPM0J82LwIf4OfMG8JiTpY/04089R8tP23J6ZA42u4nDZVPcRni8zPqCPc0nojQ3wrNyxkuR2oKKE3P1EH/Dvq0+fO2ln/RO5gOAF6bcwfQZF2wpsYL6YtDeWkJcFsQpDSUs5GHRO+wHQIx19iP5n86U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SHzd4OhI; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SHzd4OhI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=lS
	EorKISI2ymsZKQ74T2ElUmJzI5QYL1f9qgNV/ozWY=; b=SHzd4OhIxLDtINbls7
	1O7RysvpPmm0dDW2RKWbHGMefvted90ngR1/+4AOmS9Rp+ukBLODASQ58bzcgZKe
	s4JcUEIN8Dlv8LL+4QO90EmNVnv2Kx3me+cziC/Xfa+JbonI7LYEq9Zwk/rNNJi2
	jgAsihbfChEyiFdKlzDFQW2Dk=
Received: from WIN-TOG0NDEIICD.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3H1CBPMNq4SggCg--.18055S2;
	Mon, 05 Oct 2026 13:58:26 +0800 (CST)
From: Shirong Zhao <shxzhaosr@163.com>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] s390/3270: return -ENOTTY for unknown ioctls in fs3270_ioctl()
Date: Mon,  5 Oct 2026 13:58:25 +0800
Message-ID: <20261005055825.20-1-shxzhaosr@163.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H1CBPMNq4SggCg--.18055S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF1fZryrAF1DAw4DXFWDArb_yoW8WF45pr
	4UZrWUC34xtr4v9F1UC34Uua45Ga9rWFWjkay3Z3s8XF4DCa47trW8tF1Sq3yUJrs2vF4S
	yr90vr4Yva1DCw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jsUUUUUUUU=
X-CM-SenderInfo: hvk06xhdrv2qqrwthudrp/xtbC7gK6+GrDPILhswAA3r

fs3270_ioctl() initializes rc to 0 and its cmd switch has no default
branch, so an unrecognized ioctl command returns success without doing
anything. Follow the ioctl convention and reject unknown commands with
-ENOTTY.

Verified against Linux 7.3-rc6 (a90ee4305c4a5df72c11b31dacfdc76e00fcf78a),
the current mainline master: rc is initialised to 0, the switch covers
TUBICMD, TUBOCMD, TUBGETI, TUBGETO and TUBGETMOD only and has no default
branch, so an unknown command returns success without doing anything. The
file is byte-identical between 7.3-rc5 and 7.3-rc6.

Sibling audit (same snapshot, all NOT bugs -- do not re-report):
- drivers/s390/char/keyboard.c:kbd_ioctl HAS default -> -ENOIOCTLCMD;
  do_kdsk/do_kdgkb lack default but only reachable via whitelisted
  cmds from kbd_ioctl, harmless.
- drivers/char/nvram.c:nvram_misc_ioctl inits ret=-ENOTTY, safe.
- drivers/misc/tps6594-pfsm.c inits ret=-ENOIOCTLCMD, safe.
- drivers/misc/pci_endpoint_test.c inits ret=-EINVAL, safe (error).
Only fs3270 inits 0 -> true positive.

Signed-off-by: Shirong Zhao <shxzhaosr@163.com>
---
 drivers/s390/char/fs3270.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/s390/char/fs3270.c b/drivers/s390/char/fs3270.c
--- a/drivers/s390/char/fs3270.c
+++ b/drivers/s390/char/fs3270.c
@@ -358,6 +358,9 @@ static long fs3270_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		if (copy_to_user(argp, &iocb, sizeof(struct raw3270_iocb)))
 			rc = -EFAULT;
 		break;
+	default:
+		rc = -ENOTTY;
+		break;
 	}
 	mutex_unlock(&fs3270_mutex);
 	return rc;

