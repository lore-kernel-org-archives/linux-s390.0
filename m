Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729631EBA00;
	Fri,  8 Nov 2024 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073908; cv=none; b=sxkjBelafBxbjd0lr83Md3Eh1HkWJjLGmJ1mMP3s95L2CH+dEDHx9s/JEwtub5XWZNxPeJw6PJiLiBj5feX+RXaDQ3MkSemrPdHCe1UoGK2GdmPj4fjwo14WATTLM/wAgbUbLfTrD6L6nkY2Ho0lAG4QnBhpMg3DBxa9zdHX2ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073908; c=relaxed/simple;
	bh=O4P4Ba35i/Iq3dWnSMfPOP3HouZnRpJn728oIYfLz+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/VVg0rh/dkezSpTv+7PSpbQ4P6hr+lfxuUsa2aVLdH7VYe/21gNiFu77YeIq11LtHzzHQxdn2T2oIeUhFglucfsxIx6icnv/ztAwhdeXTI6hvDA8GWRYl/lGayk4+C6Etxd++ib8qoKUDptaOpc7ITLfQwaqIxn3PAZyXWwY+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dh5vVyKn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dh5vVyKn"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8DBXen001699;
	Fri, 8 Nov 2024 13:51:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AED7W7F7saDt/JcsA
	83UZelC8DgrD8HcZ27DXEVBNgg=; b=dh5vVyKnkUe3braIIFNNJnpBfysm86pME
	QKWPxw2caM3GxIpsYDQhTNRnXA3sInkm30ld5+X3QXJs8ygk0+eZiQrzQ2Y6W9YF
	uk6gMKYIy2UeWN5TXGnuW8rS3Xhvy3qTBibp7YMpobqIm7fKf2j3Lz8AuytPOO5P
	7U5srmfHg+5cbmjwaJjjR3IYLL5/jCUVyl6JSDDg97zo3lO9UmPj9NggXi1r2FFY
	gUo0+NkeIaVdM89tm0P9IzRp3L07MpTSR95YUZut6mRuMiopbu7QzSG8LOAkgPHd
	Ml75i0KiYIcZDjypnVs+g2UcRbxPglqpjigMb1q9K2HcfT30xHmqw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42sk9s85n6-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 13:51:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A89j88s019414;
	Fri, 8 Nov 2024 13:39:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42p0mja6kg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 13:39:19 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A8DdEPW60752156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Nov 2024 13:39:14 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46CF42004D;
	Fri,  8 Nov 2024 13:39:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 363F920043;
	Fri,  8 Nov 2024 13:39:14 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  8 Nov 2024 13:39:14 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id EB152E0742; Fri, 08 Nov 2024 14:39:13 +0100 (CET)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Miroslav Franc <mfranc@suse.cz>, Yu Jiaoliang <yujiaoliang@vivo.com>
Subject: [PATCH 1/2] s390/dasd: fix redundant /proc/dasd* entries removal
Date: Fri,  8 Nov 2024 14:39:12 +0100
Message-ID: <20241108133913.3068782-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108133913.3068782-1-sth@linux.ibm.com>
References: <20241108133913.3068782-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: euRC3tlLM-IpzeGJNDbd9dXsDKNhZ4m9
X-Proofpoint-ORIG-GUID: euRC3tlLM-IpzeGJNDbd9dXsDKNhZ4m9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411080113

From: Miroslav Franc <mfranc@suse.cz>

In case of an early failure in dasd_init, dasd_proc_init is never
called and /proc/dasd* files are never created.  That can happen, for
example, if an incompatible or incorrect argument is provided to the
dasd_mod.dasd= kernel parameter.

However, the attempted removal of /proc/dasd* files causes 8 warnings
and backtraces in this case.  4 on the error path within dasd_init and
4 when the dasd module is unloaded.  Notice the "removing permanent
/proc entry 'devices'" message that is caused by the dasd_proc_exit
function trying to remove /proc/devices instead of /proc/dasd/devices
since dasd_proc_root_entry is NULL and /proc/devices is indeed
permanent.  Example:

------------[ cut here ]------------
removing permanent /proc entry 'devices'
WARNING: CPU: 6 PID: 557 at fs/proc/generic.c:701 remove_proc_entry+0x22e/0x240

CPU: 6 PID: 557 Comm: modprobe Not tainted 6.10.5-1-default #1
openSUSE Tumbleweed f6917bfd6e5a5c7a7e900e0e3b517786fb5c6301
Hardware name: QEMU 8561 QEMU (KVM/Linux)
Krnl PSW : 0704c00180000000 000003fffed0e9f2 (remove_proc_entry+0x232/0x240)
           R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
Krnl GPRS: 000003ff00000027 000003ff00000023 0000000000000028 000002f200000000
           000002f3f05bec20 0000037ffecfb7d0 000003ffffdabab0 000003ff7ee4ec72
           000003ff7ee4ec72 0000000000000007 000002f280e22600 000002f280e22688
           000003ffa252cfa0 0000000000010000 000003fffed0e9ee 0000037ffecfba38
Krnl Code: 000003fffed0e9e2: c020004e7017        larl    %r2,000003ffff6dca10
           000003fffed0e9e8: c0e5ffdfad24        brasl   %r14,000003fffe904430
          #000003fffed0e9ee: af000000            mc      0,0
          >000003fffed0e9f2: a7f4ff4c            brc     15,000003fffed0e88a
           000003fffed0e9f6: 0707                bcr     0,%r7
           000003fffed0e9f8: 0707                bcr     0,%r7
           000003fffed0e9fa: 0707                bcr     0,%r7
           000003fffed0e9fc: 0707                bcr     0,%r7
Call Trace:
 [<000003fffed0e9f2>] remove_proc_entry+0x232/0x240
([<000003fffed0e9ee>] remove_proc_entry+0x22e/0x240)
 [<000003ff7ef5a084>] dasd_proc_exit+0x34/0x60 [dasd_mod]
 [<000003ff7ef560c2>] dasd_exit+0x22/0xc0 [dasd_mod]
 [<000003ff7ee5a26e>] dasd_init+0x26e/0x280 [dasd_mod]
 [<000003fffe8ac9d0>] do_one_initcall+0x40/0x220
 [<000003fffe9bc758>] do_init_module+0x78/0x260
 [<000003fffe9bf3a6>] __do_sys_init_module+0x216/0x250
 [<000003ffff37ac9e>] __do_syscall+0x24e/0x2d0
 [<000003ffff38cca8>] system_call+0x70/0x98
Last Breaking-Event-Address:
 [<000003fffef7ea20>] __s390_indirect_jump_r14+0x0/0x10
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------

While the cause is a user failure, the dasd module should handle the
situation more gracefully.  One of the simplest solutions is to make
removal of the /proc/dasd* entries idempotent.

Signed-off-by: Miroslav Franc <mfranc@suse.cz>
[ sth: shortened if clause ]
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_proc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/s390/block/dasd_proc.c b/drivers/s390/block/dasd_proc.c
index 0faaa437d9be..48e12e81df00 100644
--- a/drivers/s390/block/dasd_proc.c
+++ b/drivers/s390/block/dasd_proc.c
@@ -350,6 +350,7 @@ dasd_proc_init(void)
 	remove_proc_entry("devices", dasd_proc_root_entry);
  out_nodevices:
 	remove_proc_entry("dasd", NULL);
+	dasd_proc_root_entry = NULL;
  out_nodasd:
 	return -ENOENT;
 }
@@ -357,7 +358,11 @@ dasd_proc_init(void)
 void
 dasd_proc_exit(void)
 {
+	if (!dasd_proc_root_entry)
+		return;
+
 	remove_proc_entry("devices", dasd_proc_root_entry);
 	remove_proc_entry("statistics", dasd_proc_root_entry);
 	remove_proc_entry("dasd", NULL);
+	dasd_proc_root_entry = NULL;
 }
-- 
2.45.2

