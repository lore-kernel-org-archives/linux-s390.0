Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0254A1D0E0D;
	Wed,  2 Oct 2024 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885068; cv=none; b=CZhIIwwI1JRgth581/JI6HCEB/ckYchUsZhEI9noqyI/TuxP1HNN4rMJ37LN94omYQ5kx4nCrpFix77gTeIIYtKjNDFkAiyKvfhLwoTqov93defqavzB7rLJmcHYjgZIB9CJLhBakvPcWfOw901ncWHyNQsUYXq30KYBg6ELhSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885068; c=relaxed/simple;
	bh=vXOYPZJGTH7rK0CkL3VfvBSbRUDWoN1Yl0JNQkhQq3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXdz9XAcJfKA733T9aQyi9sSI6AJ0Z6zI47koBLsaWP1ZXf3jQRI7tyhOK2C/PASYwcecQJDnPCAorO5OogalEXzjZYQoskIu8yUXEDH1wbouZQ9zVpK8HXAMutE5a/ex5yHqoCjzEHsLosXx00LNDghjOMw8jFGH/f5bh/lIHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fessYbcM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fessYbcM"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492FsXgv009783;
	Wed, 2 Oct 2024 16:04:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=Csbzj0uRzawdy
	vSt0AXWzt0GSubrbQSIYp5VNvAy1XA=; b=fessYbcMjrDTPGdOLB9RGakkHjDYw
	2Z3PlZqdE0K77Fn/cMsMhN5mSorNaz4jldUHAkuukuy55HSBTi+JH/2KfAgYwuF4
	uuwCpkjFuh6GxcEZ5bPfVoWP0xmYIfiHgRqHIEbY3e+/cZmlSkysp2aeCUTBx8vX
	s1fFQGwOmhIbMrcObXmtk2PtFwHkL4AX1fePva3Iqwh5iCkDN9KJxFjFhdfKsCCL
	L4bOKamH9ewxbVrRT3kM2XI2cRYLBn8cebg9BFxcA/jjJR603nkUdTOoMmFNe/l6
	0ccifwGia0fLgcToiwJ2aAes5N7McSMpxRSEiLdRZve4fVXspaX3xE6qQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42197tg1nh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 16:04:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 492EQBt4002346;
	Wed, 2 Oct 2024 16:04:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xxu1aunm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 16:04:22 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 492G4Jgr57016630
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Oct 2024 16:04:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 831CC20040;
	Wed,  2 Oct 2024 16:04:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 422E82004B;
	Wed,  2 Oct 2024 16:04:19 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Oct 2024 16:04:19 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v2 1/2] s390/uv: Refactor uv-sysfs creation
Date: Wed,  2 Oct 2024 18:04:17 +0200
Message-ID: <20241002160418.2424889-2-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241002160418.2424889-1-seiden@linux.ibm.com>
References: <20241002160418.2424889-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dDANxzO2kW25lkCMRQXAGJ3WNN2d3Dvc
X-Proofpoint-ORIG-GUID: dDANxzO2kW25lkCMRQXAGJ3WNN2d3Dvc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_15,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxlogscore=824 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410020114

Streamline the sysfs generation to make it more extensible.
Add a function to create a sysfs entry in the uv-sysfs dir.
Use this function for the query directory.

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kernel/uv.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 9646f773208a..901e852f858b 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -753,7 +753,26 @@ static const struct attribute *uv_prot_virt_attrs[] = {
 static struct kset *uv_query_kset;
 static struct kobject *uv_kobj;
 
-static int __init uv_info_init(void)
+static int __init uv_sysfs_dir_init(const struct attribute_group *grp,
+				    struct kset **uv_dir_kset, const char *name)
+{
+	struct kset *kset;
+	int rc = -ENOMEM;
+
+	kset = kset_create_and_add(name, NULL, uv_kobj);
+	if (!kset)
+		return -ENOMEM;
+	*uv_dir_kset = kset;
+
+	rc = sysfs_create_group(&kset->kobj, grp);
+	if (!rc)
+		return 0;
+
+	kset_unregister(kset);
+	return rc;
+}
+
+static int __init uv_sysfs_init(void)
 {
 	int rc = -ENOMEM;
 
@@ -768,17 +787,12 @@ static int __init uv_info_init(void)
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
@@ -786,4 +800,4 @@ static int __init uv_info_init(void)
 	kobject_put(uv_kobj);
 	return rc;
 }
-device_initcall(uv_info_init);
+device_initcall(uv_sysfs_init);
-- 
2.43.0

