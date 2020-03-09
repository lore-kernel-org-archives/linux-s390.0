Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63900 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726523AbgCIIvg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Mar 2020 04:51:36 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0298oRM4056834
        for <linux-s390@vger.kernel.org>; Mon, 9 Mar 2020 04:51:36 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ym8k7cx52-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 09 Mar 2020 04:51:36 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 9 Mar 2020 08:51:33 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 05/36] s390/protvirt: Add sysfs firmware interface for Ultravisor information
Date: Mon,  9 Mar 2020 09:50:55 +0100
In-Reply-To: <20200309085126.3334302-1-borntraeger@de.ibm.com>
References: <20200309085126.3334302-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200309085126.3334302-6-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Ulrich Weigand <uweigand@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>

From: Janosch Frank <frankja@linux.ibm.com>

That information, e.g. the maximum number of guests or installed
Ultravisor facilities, is interesting for QEMU, Libvirt and
administrators.

Let's provide an easily parsable API to get that information.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kernel/uv.c | 87 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 4539003dac9d..c86d654351d1 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -325,3 +325,90 @@ int arch_make_page_accessible(struct page *page)
 EXPORT_SYMBOL_GPL(arch_make_page_accessible);
 
 #endif
+
+#if defined(CONFIG_PROTECTED_VIRTUALIZATION_GUEST) || IS_ENABLED(CONFIG_KVM)
+static ssize_t uv_query_facilities(struct kobject *kobj,
+				   struct kobj_attribute *attr, char *page)
+{
+	return snprintf(page, PAGE_SIZE, "%lx\n%lx\n%lx\n%lx\n",
+			uv_info.inst_calls_list[0],
+			uv_info.inst_calls_list[1],
+			uv_info.inst_calls_list[2],
+			uv_info.inst_calls_list[3]);
+}
+
+static struct kobj_attribute uv_query_facilities_attr =
+	__ATTR(facilities, 0444, uv_query_facilities, NULL);
+
+static ssize_t uv_query_max_guest_cpus(struct kobject *kobj,
+				       struct kobj_attribute *attr, char *page)
+{
+	return snprintf(page, PAGE_SIZE, "%d\n",
+			uv_info.max_guest_cpus);
+}
+
+static struct kobj_attribute uv_query_max_guest_cpus_attr =
+	__ATTR(max_cpus, 0444, uv_query_max_guest_cpus, NULL);
+
+static ssize_t uv_query_max_guest_vms(struct kobject *kobj,
+				      struct kobj_attribute *attr, char *page)
+{
+	return snprintf(page, PAGE_SIZE, "%d\n",
+			uv_info.max_num_sec_conf);
+}
+
+static struct kobj_attribute uv_query_max_guest_vms_attr =
+	__ATTR(max_guests, 0444, uv_query_max_guest_vms, NULL);
+
+static ssize_t uv_query_max_guest_addr(struct kobject *kobj,
+				       struct kobj_attribute *attr, char *page)
+{
+	return snprintf(page, PAGE_SIZE, "%lx\n",
+			uv_info.max_sec_stor_addr);
+}
+
+static struct kobj_attribute uv_query_max_guest_addr_attr =
+	__ATTR(max_address, 0444, uv_query_max_guest_addr, NULL);
+
+static struct attribute *uv_query_attrs[] = {
+	&uv_query_facilities_attr.attr,
+	&uv_query_max_guest_cpus_attr.attr,
+	&uv_query_max_guest_vms_attr.attr,
+	&uv_query_max_guest_addr_attr.attr,
+	NULL,
+};
+
+static struct attribute_group uv_query_attr_group = {
+	.attrs = uv_query_attrs,
+};
+
+static struct kset *uv_query_kset;
+static struct kobject *uv_kobj;
+
+static int __init uv_info_init(void)
+{
+	int rc = -ENOMEM;
+
+	if (!test_facility(158))
+		return 0;
+
+	uv_kobj = kobject_create_and_add("uv", firmware_kobj);
+	if (!uv_kobj)
+		return -ENOMEM;
+
+	uv_query_kset = kset_create_and_add("query", NULL, uv_kobj);
+	if (!uv_query_kset)
+		goto out_kobj;
+
+	rc = sysfs_create_group(&uv_query_kset->kobj, &uv_query_attr_group);
+	if (!rc)
+		return 0;
+
+	kset_unregister(uv_query_kset);
+out_kobj:
+	kobject_del(uv_kobj);
+	kobject_put(uv_kobj);
+	return rc;
+}
+device_initcall(uv_info_init);
+#endif
-- 
2.24.1
