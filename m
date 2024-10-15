Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3351919B3FF;
	Tue, 15 Oct 2024 11:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992387; cv=none; b=EX8R2Y4cBtD6hQfktgMc0W1/oahmNyfUw+GUSUYnx5IYQK/2B7pIsJ5h8eB4F9zqC/cayiLQdSkGCNereVhVCK3A7tlIu77tDhxf4eUrid+k7GmRbP6VF8VqbthOlnv0bsn/v7sJ5z0mFzj79/ie2GybaYbune8NlqlQX4KpTuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992387; c=relaxed/simple;
	bh=8V9hr8khHsza20KHPD8ur3GmYh8d+a9vGts22hO1IiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tpcD3uENPhKj8+xXNDgQoDYugfGuCdTIsCeXz6PXLUAjee8FtCJdUGzYVUyRTPPdtFhuCtvYaRjR2AHIbllHIx4CBAmQl5crfuo8I0q1jK70SrqbLT4NSA1iiI8Nxclb8yoqoh4DcSWmt94mVqPBPDElqO4OqokTUw/9XYI3mMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qgZCo7wo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qgZCo7wo"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FBOOvB021745;
	Tue, 15 Oct 2024 11:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YocS59/zyFcs7z4Ao
	O0pshzEX7pnPGFvNLnLEdHKvnc=; b=qgZCo7woPZMTmcpn4mATApTQ4GNiY7quN
	3TkF8m2o/eXYwZ9171P99J5Q0fYlP49NaVMRHoBIYA3KJpiOFG3P8PeT9VJa7HhD
	QWncjkumGbeL+Gz2Mxh7o6U98wT8uieEZQaJTj0J70WAwRTzOiek5T0kCAru+BN5
	t6skpY6Ro79mgv4KVHibgEEkwpkKO3LpLls1bmBqE5b7M8TRiJNs8d/qXjCrWdnn
	VsQgJ+2brzk7dhbNjx1Lg2SHyxemhzWeRyLtOS8p4Pnt3hv4U8+f8XIer+ILhXGr
	srrRja3OonBv7sf9ae1FY/10ziumRrQG74gQbY6FcKR3Co00dDhyA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429qg3822q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 11:39:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49FAYqj5006714;
	Tue, 15 Oct 2024 11:39:44 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4283erurfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 11:39:44 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49FBdeIv39846350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 11:39:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8ECD520040;
	Tue, 15 Oct 2024 11:39:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 706892004D;
	Tue, 15 Oct 2024 11:39:40 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Oct 2024 11:39:40 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v3 1/2] s390/uv: Refactor uv-sysfs creation
Date: Tue, 15 Oct 2024 13:39:39 +0200
Message-ID: <20241015113940.3088249-2-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241015113940.3088249-1-seiden@linux.ibm.com>
References: <20241015113940.3088249-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -5pRMduFh8XmWtRgl2ZWaHzDgsNnlJVE
X-Proofpoint-ORIG-GUID: -5pRMduFh8XmWtRgl2ZWaHzDgsNnlJVE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0
 mlxlogscore=826 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150078

Streamline the sysfs generation to make it more extensible.
Add a function to create a sysfs entry in the uv-sysfs dir.
Use this function for the query directory.

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kernel/uv.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 9646f773208a..ba514b9dca6a 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -753,7 +753,24 @@ static const struct attribute *uv_prot_virt_attrs[] = {
 static struct kset *uv_query_kset;
 static struct kobject *uv_kobj;
 
-static int __init uv_info_init(void)
+static int __init uv_sysfs_dir_init(const struct attribute_group *grp,
+				    struct kset **uv_dir_kset, const char *name)
+{
+	struct kset *kset;
+	int rc;
+
+	kset = kset_create_and_add(name, NULL, uv_kobj);
+	if (!kset)
+		return -ENOMEM;
+	*uv_dir_kset = kset;
+
+	rc = sysfs_create_group(&kset->kobj, grp);
+	if (rc)
+		kset_unregister(kset);
+	return rc;
+}
+
+static int __init uv_sysfs_init(void)
 {
 	int rc = -ENOMEM;
 
@@ -768,17 +785,12 @@ static int __init uv_info_init(void)
 	if (rc)
 		goto out_kobj;
 
-	uv_query_kset = kset_create_and_add("query", NULL, uv_kobj);
-	if (!uv_query_kset) {
-		rc = -ENOMEM;
+	rc = uv_sysfs_dir_init(&uv_query_attr_group, &uv_query_kset, "query");
+	if (rc)
 		goto out_ind_files;
-	}
 
-	rc = sysfs_create_group(&uv_query_kset->kobj, &uv_query_attr_group);
-	if (!rc)
-		return 0;
+	return 0;
 
-	kset_unregister(uv_query_kset);
 out_ind_files:
 	sysfs_remove_files(uv_kobj, uv_prot_virt_attrs);
 out_kobj:
@@ -786,4 +798,4 @@ static int __init uv_info_init(void)
 	kobject_put(uv_kobj);
 	return rc;
 }
-device_initcall(uv_info_init);
+device_initcall(uv_sysfs_init);
-- 
2.43.0

