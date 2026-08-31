Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A343AC0F1;
	Mon, 31 Aug 2026 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188200; cv=none; b=tFLL7CptoG9zSupjuQI8Y6kGUyaiJTTffogxrsH2KhtLutcnJG34tJyTSHzIBJale+FQfY49lWX++eDjLfBbhCnBnaRkfHPb7S66+LVAuK72q30ihEqA4eUiqVuF1Dn+fH+fXVONBvnypVauNB8FTycj00RpEB4iZ4oDst89e4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188200; c=relaxed/simple;
	bh=9vXAmA7zRSGwSymswLU6oBql+slrZ7xQLq2eDhPGuUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3N89xs39P14WkbI9Mqa+V0nyj77yzjF3FkJlUIqneVqFMiKHhd9vPXrzyr6RrWfzbWlnPX7D+pCED93B6aBjHjZaBlMiFT8CxPvd0zDK8XzG29AIPs7jr0JCd8Cv7mzafWyNLK5k+jEk9X4CxG6UE54aQl4PM4tVzWk1dq4CYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WFmQlFq9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WFmQlFq9"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZEpg2414997;
	Mon, 31 Aug 2026 14:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=p/g3GZIveu5yYpauk
	htKF4zcHJqCH9eviUKQ+gl5p6Y=; b=WFmQlFq9FvSbWi/WRFtuuinMGaQllf19z
	8IHrXcI1rjC/JaoBz1nA69CsTUVKDW9KaWg2MsujfQ1pfqeOCp/8Xd+sT8cyg8Fj
	Iiu4t7dR9ZFv1PuYNZ58sGi9hZOw5jVwLxY5NCh6SV9rpvTvG8S5WbuwR2iOgvQd
	t3+vPikwtMs+fFt9kmi3AfMleEHmvGJMFT8bvt586EMKW9BtorGJblIQ53PPZGxj
	yVa3jfwyklTdgTk6NKSc1fIfrbxBS8Hf2jBoDZeRONrWLjwtectvcvXEuKEKd+dw
	wZJXaF0kEGLmkMgEK1bvTFD+1QrI7baVt8M2HBCYiA9kj2AQFfnnQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhj66p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEfdBB003378;
	Mon, 31 Aug 2026 14:55:54 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarjxgck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VEtlu545416924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 14:55:47 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 924D320040;
	Mon, 31 Aug 2026 14:55:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 223DD20043;
	Mon, 31 Aug 2026 14:55:47 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 14:55:47 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v2 20/20] s390: Report AEF features to sysfs
Date: Mon, 31 Aug 2026 16:55:35 +0200
Message-ID: <20260831145536.913567-21-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831145536.913567-1-seiden@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: cgKoid8oBZbsBqN5flcpESsmNzrk2mQ_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfXwxTMr/h3bS1j
 VmZTGZ4PRF5/SDMgv1xykVVMizcyGEUBSuBO75VyzvP8KXmPqhNIJzQ4ZoAxCzSnjbUz8eLFVrp
 NnsMJtAax7UvFrenjpX3tI6Asld0TE/KYuuHX+AhNtVhM59eXcECce51ByElD2XNc0i5UfkMzUV
 0gBPVKZk4Sg9foiqXOHhz8d+mdX1tViPZGR/coaZXk9X3FR5I/IhFIzn3xBOz2SSaPQT79FuJ2z
 KvBCYJUkpnu3CWvRo824AEhRYNapMSls21dzhBriCD6wUYDL7tdzNpHdpadTgrgHHAONWOQvZP2
 aM8L9mh2H0k2VYMLuBsPyn70zSMk70GbmGW0Eyo7GOqCdydyd7rFbEtWoEt6A8LsBQRQJFfRiJJ
 6qjgLFAqgUEbcPqMB1PlaP/0jA0G+LNJd2TH1Lgb0Cco5bi+xThhhU/7rT4d5uPp6z1b6uyT5Xa
 kxqraRVpLEmObkc8hnA==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a9595fb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=Q6p9WaQqMra0dl70cWIA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfXwp6HT7Fc9dbO
 iOieHxbselxGXAc7QPqfaU9ina+gGu3leKxZj2M5DtOVMR3KOmxSjCRVp23ehjpzKbOSRqAZyLb
 XUFYGOmeplAcQb4Ej80OSz7XkW7D0L0=
X-Proofpoint-ORIG-GUID: EH6jG6WzePSfrBc3sqxsZLrZsQ3wltoZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310125

Display various information about the Arm execution Facility (AEF) to
userspace. The files are located in /sys/firmware/aef/. Show if the
feature is available and usable for the host, which formats are
available, and how many arm vCPUS per guest are supported by the
machine. Additionally, provide the raw binary output of QAAF fc1 (Query
Model Capabilities) in the file qmc and fc2 (Initial
System-Registers-Save Area) in the file save_area.

Co-developed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kernel/aef.c | 86 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/s390/kernel/aef.c b/arch/s390/kernel/aef.c
index 825e2643a892..2691f1ac63dc 100644
--- a/arch/s390/kernel/aef.c
+++ b/arch/s390/kernel/aef.c
@@ -40,6 +40,66 @@ const struct aef_info *aef_info(void)
 }
 EXPORT_SYMBOL(aef_info);
 
+static struct kset *aef_query_kset;
+static struct kobject *aef_kobj;
+
+#define aef_sysfs_qval_def(_name)					\
+	static ssize_t _name##_show(struct kobject *kobj,		\
+				    struct kobj_attribute *attr,	\
+				    char *buf)				\
+	{								\
+		return sysfs_emit(buf, "%lx\n", info._name);		\
+	}								\
+	static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
+
+#define aef_sysfs_qval_attr(_name) &_name##_attr.attr
+
+aef_sysfs_qval_def(arm_guest_supp);
+aef_sysfs_qval_def(sae_avail);
+aef_sysfs_qval_def(ptff_avail);
+aef_sysfs_qval_def(supp_state_desc_formats);
+aef_sysfs_qval_def(supp_save_area_formats);
+aef_sysfs_qval_def(max_num_vcpu);
+
+static ssize_t qmc_read(struct file *filp, struct kobject *kobj,
+			const struct bin_attribute *attr, char *buf, loff_t off,
+			size_t count)
+{
+	return memory_read_from_buffer(buf, count, &off, &qmc, sizeof(qmc));
+}
+
+BIN_ATTR_RO(qmc, sizeof(qmc));
+
+static ssize_t save_area_read(struct file *filp, struct kobject *kobj,
+			      const struct bin_attribute *attr, char *buf,
+			      loff_t off, size_t count)
+{
+	return memory_read_from_buffer(buf, count, &off, &save_area,
+				       sizeof(save_area));
+}
+
+BIN_ATTR_RO(save_area, sizeof(save_area));
+
+static struct attribute *aef_query_attrs[] = {
+	aef_sysfs_qval_attr(sae_avail),
+	aef_sysfs_qval_attr(ptff_avail),
+	aef_sysfs_qval_attr(supp_state_desc_formats),
+	aef_sysfs_qval_attr(supp_save_area_formats),
+	aef_sysfs_qval_attr(max_num_vcpu),
+	NULL,
+};
+
+static const struct bin_attribute *aef_query_bin_attrs[] = {
+	&bin_attr_qmc,
+	&bin_attr_save_area,
+	NULL,
+};
+
+static struct attribute_group aef_query_attr_group = {
+	.attrs = aef_query_attrs,
+	.bin_attrs = aef_query_bin_attrs,
+};
+
 static int __init aef_init_save_area(void)
 {
 	int ret;
@@ -95,7 +155,33 @@ static int __init aef_sysfs_init(void)
 	if (rc)
 		return rc;
 
+	aef_kobj = kobject_create_and_add("aef", firmware_kobj);
+	if (!aef_kobj)
+		return -ENOMEM;
+
+	rc = sysfs_create_file(aef_kobj, aef_sysfs_qval_attr(arm_guest_supp));
+	if (rc)
+		goto out_kobj;
+
+	aef_query_kset = kset_create_and_add("query", NULL, aef_kobj);
+	if (!aef_query_kset)
+		goto out_arm_guest_supp;
+
+	rc = sysfs_create_group(&aef_query_kset->kobj, &aef_query_attr_group);
+	if (rc)
+		goto out_kset;
+
 	return 0;
+
+out_kset:
+	kset_unregister(aef_query_kset);
+out_arm_guest_supp:
+	sysfs_remove_file(aef_kobj, &arm_guest_supp_attr.attr);
+out_kobj:
+	kobject_del(aef_kobj);
+	kobject_put(aef_kobj);
+
+	return rc;
 }
 
 arch_initcall(aef_sysfs_init);
-- 
2.53.0

