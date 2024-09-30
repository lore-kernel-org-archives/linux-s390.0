Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A072AE8E;
	Mon, 30 Sep 2024 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727702450; cv=none; b=MOw00yfbJkO16l7xClHTCGRZFlxzD6yvb2lyw4x6fYNt/Ti7gqO++qrxGaITPdxtUL9Zg94PW0qw6UCUxNHtS86A7gy8WfNZOQZj6EfdEXTSCF8q3zCPumCdZ9OmqtrWxB6J/OPzg0WyqTDsFapfMKim0zcWU8SNSKZJ45AmCbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727702450; c=relaxed/simple;
	bh=+Ftc0dtmqLRxNE5HzoZtwVOLB60RzcXmUz/BTf5qRvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FoYVdWRMNS6BchKqm2VBFl8nF+HeP1jrEN/ewAY6GkjuztKDh4baM3NZ3lpCP3LGZ97SetjhaNPQd5PZ1ulfRQfY6mP0Qd2Zj3gQR/d8b3Cu8zy3LAKiiW+7KM2AvCd6ZPe/49ZgENhV0R2q+DFsTdpzNC/lt11/QfvTRXtKvJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C/E91ZzK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C/E91ZzK"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48U6LYIg020142;
	Mon, 30 Sep 2024 13:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=M9tx0MAKFvkHi
	4ZJZsxotnHom34AoQnyhXBdXKHIvuk=; b=C/E91ZzK2DlkM1JpXc0HInPuqaLDz
	vtRnCn6HjXqcZiGYvYKgjEb8AB/yOSVN9LXCUFCcexfTugF7eHZ2Eyq1QHUCv+KC
	wxQvl28gvuIvRvhc3+EVXKiB5fHhu+aJ62fnfYPEimFGeJuP1NcwRp5p6LNXd5he
	/VkpTiYP8coZDrRJsgjqpfwmwpk1UYdTm3kykcLBbWPhgx4bfpV5EuMM0HHDO9pX
	h4DWjOVCKi/6NWyMFVfwpvvIY6+P4klVfuU6fYKIOWkVpQszB4c68/wz3efg3NdG
	h+xcas6qwwguEzoRU0LlRP6624CNk2jkTwqIRjmwxqb9F4qatij5WjGOA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9f81jvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 13:20:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UCUqA3002401;
	Mon, 30 Sep 2024 13:20:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xxu0xbr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 13:20:46 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48UDKgfJ55640382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 13:20:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEF8E20040;
	Mon, 30 Sep 2024 13:20:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DDBB2004D;
	Mon, 30 Sep 2024 13:20:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Sep 2024 13:20:42 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v1 1/2] s390/uv: Refactor uv-sysfs creation
Date: Mon, 30 Sep 2024 15:20:40 +0200
Message-ID: <20240930132042.2081982-2-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240930132042.2081982-1-seiden@linux.ibm.com>
References: <20240930132042.2081982-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: f8hdaSniVPjNUfUowVsrLpVTLkHztGsF
X-Proofpoint-ORIG-GUID: f8hdaSniVPjNUfUowVsrLpVTLkHztGsF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_12,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 adultscore=0 mlxscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=821 malwarescore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300095

Streamline the sysfs generation to make it more extensible.
Add a function to create a sysfs entry in the uv-sysfs dir.
Use this function for the query directory.

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kernel/uv.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 36db065c7cf7..d703ecc9aea5 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -752,7 +752,26 @@ static const struct attribute *uv_prot_virt_attrs[] = {
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
 
@@ -767,17 +786,11 @@ static int __init uv_info_init(void)
 	if (rc)
 		goto out_kobj;
 
-	uv_query_kset = kset_create_and_add("query", NULL, uv_kobj);
-	if (!uv_query_kset) {
-		rc = -ENOMEM;
+	rc = uv_sysfs_dir_init(&uv_query_attr_group, &uv_query_kset, "query");
+	if (rc)
 		goto out_ind_files;
-	}
-
-	rc = sysfs_create_group(&uv_query_kset->kobj, &uv_query_attr_group);
-	if (!rc)
-		return 0;
+	return 0;
 
-	kset_unregister(uv_query_kset);
 out_ind_files:
 	sysfs_remove_files(uv_kobj, uv_prot_virt_attrs);
 out_kobj:
@@ -785,4 +798,4 @@ static int __init uv_info_init(void)
 	kobject_put(uv_kobj);
 	return rc;
 }
-device_initcall(uv_info_init);
+device_initcall(uv_sysfs_init);
-- 
2.43.0

