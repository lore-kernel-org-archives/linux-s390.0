Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F26189BA3;
	Tue, 20 Aug 2024 08:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724143545; cv=none; b=fKOZQ36zrOiCgnLfytlmECYgbf7uuHXtD/4jeH/08g3YdweI1CaqThPyzUL6k6U8abyigDPkkWk/vdUENj/i5aR079SDwXfM0fUeyYrNQVKgfcBiy0+XKZ4E2ZuzIk7oMo3pEbWr88Zme569/+gj46hgTjw+9ULzf51CsVHBAm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724143545; c=relaxed/simple;
	bh=d29y/b3+dKXfOMPqWOlo2Dtzlow8gPxFqqkprMyHMY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RyTR2+BUAUA4HIKlhdffYkxD/E1HaMuDtDxDOG3xk7UtTi83NeLS9p7kx7fl23uTf/X2i5lr8yf1WNJiTGqKHgD2vEZYAoGwQoHcyKQqgmpTKLx/1tRzMrKwTItaURFHO9Sxx6KQ6ZoA449pE4cLK86orFbH6OMuR/KgZDPSqQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EACtiQTA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EACtiQTA"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JI9HGp029570;
	Tue, 20 Aug 2024 08:45:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=n9f5U4YE8l6gZQ2iTUJ1QoBma3VmGjgKP36BNqG
	tl2E=; b=EACtiQTAY0cQUHxjVrT2EvwA+fN1oUyXwu2JLptjlt8ZNZfalFgC6VO
	tdIrkl+JnI/oYRgklvAjEUgGA3folcQGwyB7q738zbEwoNhwyEtNUtdAvI/gPXJo
	4g4qM6UruegPewjL8Ckj6+2IzhxuzOn3Hh60v9MKklJp/kKVTU77ZHvd1SNTph0O
	+g7Q9eGlllX+sFT31vBNB7nGtfAzPjiMeffaI2wgu4XyL5/RfdtVAMd0iC9Qaica
	fXff0eVQA+ousSLum+WTecKcrPvTxHRS6fxiT9NEGso0tYfo5qhMu60sjZb9YmGu
	P2xztokuCIbZ8ExEUjSvms6YHFUG0fg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412ma04uuj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 08:45:35 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47K8jZkG001556;
	Tue, 20 Aug 2024 08:45:35 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412ma04uuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 08:45:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47K5UIOl013098;
	Tue, 20 Aug 2024 08:45:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41366u2a2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 08:45:33 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47K8jSjv54854042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 08:45:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7601B20043;
	Tue, 20 Aug 2024 08:45:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6393920040;
	Tue, 20 Aug 2024 08:45:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 20 Aug 2024 08:45:28 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 2D390E024A; Tue, 20 Aug 2024 10:45:28 +0200 (CEST)
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
        kernel test robot <lkp@intel.com>
Subject: [PATCH net v2] s390/iucv: Fix vargs handling in iucv_alloc_device()
Date: Tue, 20 Aug 2024 10:45:28 +0200
Message-ID: <20240820084528.2396537-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VCvFKZmyXU-3VMFAXO5jLsqU9XmmkbYj
X-Proofpoint-ORIG-GUID: n536KPVuErnDYQ_BJtHRxyuPOH6i7UNL
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
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408200062

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
---
Discussion of v1:
Link: https://lore.kernel.org/all/2024081326-shifter-output-cb8f@gregkh/T/#mf8ae979de8acdc01f7ede0b94af6f2e110eea209
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202408091131.ATGn6YSh-lkp@intel.com/
Vasily Gorbik asked me to send this version via the netdev mailing list.
---
 net/iucv/iucv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index 1e42e13ad24e..2e615641a4e5 100644
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
+	rc = dev_set_name(dev, buf);
 	va_end(vargs);
 	if (rc)
 		goto out_error;
-- 
2.39.3 (Apple Git-146)

