Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11064 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728157AbgBNW1l (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 14 Feb 2020 17:27:41 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2 38/42] s390: protvirt: Add sysfs firmware interface for Ultravisor information
Date: Fri, 14 Feb 2020 17:26:54 -0500
Message-Id: <20200214222658.12946-39-borntraeger@de.ibm.com>
In-Reply-To: <20200214222658.12946-1-borntraeger@de.ibm.com>
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

From: Janosch Frank <frankja@linux.ibm.com>

That information, e.g. the maximum number of guests or installed
Ultravisor facilities, is interesting for QEMU, Libvirt and
administrators.

Let's provide an easily parsable API to get that information.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kernel/uv.c | 86 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 9a6c309864a0..fb606b171f42 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -322,5 +322,91 @@ int arch_make_page_accessible(struct page *page)
 	return rc;
 }
 EXPORT_SYMBOL_GPL(arch_make_page_accessible);
+#endif
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
 
+static struct kset *uv_query_kset;
+struct kobject *uv_kobj;
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
 #endif
-- 
2.25.0
