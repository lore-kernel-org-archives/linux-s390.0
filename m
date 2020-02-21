Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42054 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727027AbgBUKq5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Feb 2020 05:46:57 -0500
Subject: Re: [PATCH v3 35/37] s390: protvirt: Add sysfs firmware interface for
 Ultravisor information
References: <20200220104020.5343-1-borntraeger@de.ibm.com>
 <20200220104020.5343-36-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <4409e9ba-3b8c-69dd-815c-2b09d77d7598@redhat.com>
Date: Fri, 21 Feb 2020 11:46:47 +0100
MIME-Version: 1.0
In-Reply-To: <20200220104020.5343-36-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On 20.02.20 11:40, Christian Borntraeger wrote:
> From: Janosch Frank <frankja@linux.ibm.com>
> 
> That information, e.g. the maximum number of guests or installed
> Ultravisor facilities, is interesting for QEMU, Libvirt and
> administrators.
> 
> Let's provide an easily parsable API to get that information.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  arch/s390/kernel/uv.c | 86 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
> 
> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> index 4539003dac9d..550e9617c459 100644
> --- a/arch/s390/kernel/uv.c
> +++ b/arch/s390/kernel/uv.c
> @@ -323,5 +323,91 @@ int arch_make_page_accessible(struct page *page)
>  	return rc;
>  }
>  EXPORT_SYMBOL_GPL(arch_make_page_accessible);
> +#endif
> +
> +#if defined(CONFIG_PROTECTED_VIRTUALIZATION_GUEST) || IS_ENABLED(CONFIG_KVM)
> +static ssize_t uv_query_facilities(struct kobject *kobj,
> +				   struct kobj_attribute *attr, char *page)
> +{
> +	return snprintf(page, PAGE_SIZE, "%lx\n%lx\n%lx\n%lx\n",
> +			uv_info.inst_calls_list[0],
> +			uv_info.inst_calls_list[1],
> +			uv_info.inst_calls_list[2],
> +			uv_info.inst_calls_list[3]);
> +}
> +
> +static struct kobj_attribute uv_query_facilities_attr =
> +	__ATTR(facilities, 0444, uv_query_facilities, NULL);
> +
> +static ssize_t uv_query_max_guest_cpus(struct kobject *kobj,
> +				       struct kobj_attribute *attr, char *page)
> +{
> +	return snprintf(page, PAGE_SIZE, "%d\n",
> +			uv_info.max_guest_cpus);
> +}
> +
> +static struct kobj_attribute uv_query_max_guest_cpus_attr =
> +	__ATTR(max_cpus, 0444, uv_query_max_guest_cpus, NULL);
> +
> +static ssize_t uv_query_max_guest_vms(struct kobject *kobj,
> +				      struct kobj_attribute *attr, char *page)
> +{
> +	return snprintf(page, PAGE_SIZE, "%d\n",
> +			uv_info.max_num_sec_conf);
> +}
> +
> +static struct kobj_attribute uv_query_max_guest_vms_attr =
> +	__ATTR(max_guests, 0444, uv_query_max_guest_vms, NULL);
> +
> +static ssize_t uv_query_max_guest_addr(struct kobject *kobj,
> +				       struct kobj_attribute *attr, char *page)
> +{
> +	return snprintf(page, PAGE_SIZE, "%lx\n",
> +			uv_info.max_sec_stor_addr);
> +}
> +
> +static struct kobj_attribute uv_query_max_guest_addr_attr =
> +	__ATTR(max_address, 0444, uv_query_max_guest_addr, NULL);
> +
> +static struct attribute *uv_query_attrs[] = {
> +	&uv_query_facilities_attr.attr,
> +	&uv_query_max_guest_cpus_attr.attr,
> +	&uv_query_max_guest_vms_attr.attr,
> +	&uv_query_max_guest_addr_attr.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group uv_query_attr_group = {
> +	.attrs = uv_query_attrs,
> +};
>  
> +static struct kset *uv_query_kset;
> +struct kobject *uv_kobj;
> +
> +static int __init uv_info_init(void)
> +{
> +	int rc = -ENOMEM;
> +
> +	if (!test_facility(158))
> +		return 0;
> +
> +	uv_kobj = kobject_create_and_add("uv", firmware_kobj);
> +	if (!uv_kobj)
> +		return -ENOMEM;
> +
> +	uv_query_kset = kset_create_and_add("query", NULL, uv_kobj);
> +	if (!uv_query_kset)
> +		goto out_kobj;
> +
> +	rc = sysfs_create_group(&uv_query_kset->kobj, &uv_query_attr_group);
> +	if (!rc)
> +		return 0;
> +
> +	kset_unregister(uv_query_kset);
> +out_kobj:
> +	kobject_del(uv_kobj);
> +	kobject_put(uv_kobj);
> +	return rc;
> +}
> +device_initcall(uv_info_init);
>  #endif
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
