Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B88A193071;
	Tue, 20 Aug 2024 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167771; cv=none; b=V1gvGcLflDS/J8dbv/k/Eo6qCQ7iPWUTymWn1TY8hkjIrandMg52LlWnbINCtxzRbSQ4chqHiUqE1h20qMa4tiRQoeuDYXgfSyI6WLKsQs2cShrPgCjqTXhZB3VoaN/CRiEKwLyu/OdG53FQK3qeT0xWbYnlhlTrLqhhtjv222A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167771; c=relaxed/simple;
	bh=KbR9Z5dA+UQWywHjxVmp/37dcVUsfNC0p+2b4VpqyDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eIVLiwrv7qwla87GDZCh6XlCSJZrobweQ7Z1Bi5BJm6zBy/hgDLCgJ0J+R8q1sE4atxTX+SJED6G2QIRoI/eocdfQmXtVanE8iMTrPO91i9C1pbDZp5FL3JNtmss9Gskef/bn1K6+VivzuWCFLFOfjU7OkNqVFaiTnN8MKw/bDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jR/RfzQT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jR/RfzQT"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KDnPU5014197;
	Tue, 20 Aug 2024 15:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=xETE7DSKr+Zv/9nlZb4rsqzdzPP6r970NW5xRyy
	dMHg=; b=jR/RfzQT7R4JEv/t4odIml7GkfQpp2ZA92hMzP+Xo0y5CDzjt7oQb7K
	EOKp+/K7JVJQHEAyYvsE642w3fHs3P7Mms7f2V2rGJwh/ldLZmRuJSs95rp4Ux7/
	FSqI5yMVXmWqugcgXqPlWo0qs2YEWuVS7iKpPhTax9w2cpj3oLKiiBBCjBlMOQxv
	JXK3kwhWEZJhEwhEBJ/bJWqcM+rocOZrVvzHIkQjco9k0bxCGLNETrexnL+LjSC3
	I1Bnnvt+4BmYTg+It3RMjFPaD4ek+9qiQF92NxRpw8oXQlhbIl5B1Ql2cDwqbZ+F
	pgU8777uTT3+bM9Ae/10466ol8HqR/g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mcydwjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 15:29:19 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47KFMgrU016403;
	Tue, 20 Aug 2024 15:29:19 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mcydwjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 15:29:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47KFFnVF019123;
	Tue, 20 Aug 2024 15:29:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41376puf70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 15:29:18 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47KFTC7x30081298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 15:29:14 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19B0A2004D;
	Tue, 20 Aug 2024 15:29:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06F8A2004B;
	Tue, 20 Aug 2024 15:29:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 20 Aug 2024 15:29:11 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 7CF05E024A; Tue, 20 Aug 2024 17:29:11 +0200 (CEST)
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
Subject: [PATCH net v3] s390/iucv: Fix vargs handling in iucv_alloc_device()
Date: Tue, 20 Aug 2024 17:29:11 +0200
Message-ID: <20240820152911.3701814-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: a-9Xw3jUsYxRBoXMz02DcrQ8EurX0pt9
X-Proofpoint-GUID: d0F_at3YRvjxGQItmz95bp-hjKFNrje8
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
 definitions=2024-08-20_10,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 clxscore=1011
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408200112

iucv_alloc_device() gets a format string and a varying number of
arguments. This is incorrectly forwarded by calling dev_set_name() with
the format string and a va_list, while dev_set_name() expects also a
varying number of arguments.

Symptoms:
Corrupted iucv device names, which can result in log messages like:
sysfs: cannot create duplicate filename '/devices/iucv/hvc_iucv1827699952'

Fixes: 4452e8ef8c36 ("s390/iucv: Provide iucv_alloc_device() / iucv_release_device()")
Link: https://bugzilla.suse.com/show_bug.cgi?id=1228425
Reference-ID: https://bugzilla.linux.ibm.com/show_bug.cgi?id=208008
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Thorsten Winkler <twinkler@linux.ibm.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v2 -> v3: use "%s" (Przemek Kitszel)
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
2.39.3 (Apple Git-146)

