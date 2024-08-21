Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB8E1CC144;
	Wed, 21 Aug 2024 09:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724231635; cv=none; b=kVh2mGHD5YbEYsRjmmfeQZ1V1vtt64sRrXNDqwP0HZhlAfFaorTeAHZDXJ5hj8q/S3LBlwNzJU5bu/DNNgRfa0FJFyZW0hqKUbpZt49yPeaWcYoDlXfY4fU7An3deg/A8dJSvgZ1aUp7/ienYxlxjgvJqq2HXGDLJq9RgNsk/8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724231635; c=relaxed/simple;
	bh=pz/0452oZ2O70qeHTk8jrUDiiyTtxC9YEGylsOoohGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lJP25duWfZ5I7J4chlIrmdPq8UWNBMu6AfuaC4HbX4NFAYAbzHI/zOp8agvuMlxLYyTYgRjO7NAIWs8ddQBqRVrkHsnoYaqzxfU2NOWZIBZChF/xiCgigepKm5dGvQ+rQwBifd/eeveoezEqNAS3BGGls9/tg/8rA+qGcgeCH4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gFVNs/Y8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gFVNs/Y8"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L42UxP001282;
	Wed, 21 Aug 2024 09:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=LGGYK2nXBRp1J508Js+tz4ePr9DbAKe1rM2xOEW
	SbaY=; b=gFVNs/Y8HMZu5kAHuq9LGCs0hZ5LB6o+7ThAD2Inro5Xzb2l/Ausjjp
	JbCz2orcaK5xZaCLYE4FOyE6/yVguhsn4AEwmPPME8FerEzTHyxibtKji4aokFa2
	LGV+CQOj2jHTgNaV4E5jeKWapfP62Zo8RWCg/jafqhJ+xGOgnfBRZ1iy8a2Zf4zJ
	e0eXGhEcjdpDGV48mV2hBtdepsKQdHIWMHF1+y04mp5Y/p9lJRaLloxRba9bZWrh
	M/793hso1xThHCsNHIsBAYImCPEg+d60vtGfpET2KpiqbpnpbihkzRTIRs0Dfm8T
	FJyQRq9S+hp8riarsqeYiwZp0/Py8Zg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mbg17n0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 09:13:44 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47L99Eq2020550;
	Wed, 21 Aug 2024 09:13:44 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mbg17mt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 09:13:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47L8cnad002244;
	Wed, 21 Aug 2024 09:13:43 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4136k0q4vr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 09:13:43 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47L9DbFL56361368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 09:13:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 803A82005A;
	Wed, 21 Aug 2024 09:13:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6EFBE2004F;
	Wed, 21 Aug 2024 09:13:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 21 Aug 2024 09:13:37 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 24A23E024A; Wed, 21 Aug 2024 11:13:37 +0200 (CEST)
From: Alexandra Winter <wintera@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH net v4] s390/iucv: Fix vargs handling in iucv_alloc_device()
Date: Wed, 21 Aug 2024 11:13:37 +0200
Message-ID: <20240821091337.3627068-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Gvo7G-La58V1o6hvCMYRCz7HMCEK7NcT
X-Proofpoint-ORIG-GUID: bRTzOJEFZRM5JZ6VhGneXoKz78DLcLWO
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_07,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408210065

iucv_alloc_device() gets a format string and a varying number of
arguments. This is incorrectly forwarded by calling dev_set_name() with
the format string and a va_list, while dev_set_name() expects also a
varying number of arguments.

Symptoms:
Corrupted iucv device names, which can result in log messages like:
sysfs: cannot create duplicate filename '/devices/iucv/hvc_iucv1827699952'

Fixes: 4452e8ef8c36 ("s390/iucv: Provide iucv_alloc_device() / iucv_release_device()")
Link: https://bugzilla.suse.com/show_bug.cgi?id=1228425
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Thorsten Winkler <twinkler@linux.ibm.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v3 -> v4: Remove reference to internal bugzilla
v2 -> v3: use %s (Przemek Kitszel)
Discussion of v1:
Link: https://lore.kernel.org/all/2024081326-shifter-output-cb8f@gregkh/T/#mf8ae979de8acdc01f7ede0b94af6f2e110eea209
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202408091131.ATGn6YSh-lkp@intel.com/
Vasily Gorbik asked me to send this version via the netdev mailing list.
---
 net/iucv/iucv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index 1e42e13ad24e..d3e9efab7f4b 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -86,13 +86,15 @@ struct device *iucv_alloc_device(const struct attribute_group **attrs,
 {
 	struct device *dev;
 	va_list vargs;
+	char buf[20];
 	int rc;
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		goto out_error;
 	va_start(vargs, fmt);
-	rc = dev_set_name(dev, fmt, vargs);
+	vsnprintf(buf, sizeof(buf), fmt, vargs);
+	rc = dev_set_name(dev, "%s", buf);
 	va_end(vargs);
 	if (rc)
 		goto out_error;
-- 
2.43.0

