Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98248C433ED
	for <linux-s390@archiver.kernel.org>; Tue,  4 May 2021 14:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62FF7613B3
	for <linux-s390@archiver.kernel.org>; Tue,  4 May 2021 14:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhEDOnM (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 4 May 2021 10:43:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48250 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230086AbhEDOnM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 May 2021 10:43:12 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 144EWZfR031799;
        Tue, 4 May 2021 10:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=baF7vqFZ6a+ikX0hkZsCToAf3HVrYLJ3MbIHoT7/I9A=;
 b=g2Os2pvuFPXFyHWbYLh8Z+EHYIksB6LYyhiDdHg+zHvQ5pPAZtWKb6MUiEY1Nt3QBVL/
 LPl4pafGlbeRx5iWx2cvxlSRnKZDTfq+7qk1FgXnKPPBE7rht8E4muuOB8fEa9pMZFVJ
 iiuo44a1Xzh7D8p3yIfjwRMd0hIfT2U45uojnG2/hQs6OespgLi0TaTXJxjt+iQlZuJg
 lQOcnyoEauz5ZjqqK0+JVIawcOJV2fCp0kRpGEEVMLYAJLuYqycRt67uw3v5ygsNCVVI
 HQm1Cck15uRQ2C/YDjwDuIcsrfsTg3uhECjDYNE/oaYAoDvKLKFenQ1vR5GnbTUGpaly Qg== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38b640cj36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 May 2021 10:42:08 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 144EXktH013322;
        Tue, 4 May 2021 14:42:08 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma03wdc.us.ibm.com with ESMTP id 38aym430r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 May 2021 14:42:08 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 144Eg60035258722
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 May 2021 14:42:06 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB5EE13604F;
        Tue,  4 May 2021 14:42:06 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DDB7136055;
        Tue,  4 May 2021 14:42:05 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.140.234])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  4 May 2021 14:42:05 +0000 (GMT)
Subject: Re: [PATCH v2 06/13] vfio/ap_ops: Convert to use
 vfio_register_group_dev()
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Halil Pasic <pasic@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christoph Hellwig <hch@lst.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Tarun Gupta <targupta@nvidia.com>
References: <6-v2-7667f42c9bad+935-vfio3_jgg@nvidia.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <80caaa31-3918-c96d-d7ff-727ddd1a4d1e@linux.ibm.com>
Date:   Tue, 4 May 2021 10:42:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <6-v2-7667f42c9bad+935-vfio3_jgg@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: m0sJ_4n3JyZ3htt9-DyI0Bgpjx70KkeB
X-Proofpoint-ORIG-GUID: m0sJ_4n3JyZ3htt9-DyI0Bgpjx70KkeB
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-04_08:2021-05-04,2021-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105040110
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 4/26/21 4:00 PM, Jason Gunthorpe wrote:
> This is straightforward conversion, the ap_matrix_mdev is actually serving
> as the vfio_device and we can replace all the mdev_get_drvdata()'s with a
> simple container_of().

This is a nit, but most of the mdev_get_drvdata()'s are not being
replaced by container_of(); in most places, the replacement is
dev_get_drvdata().

>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c     | 137 ++++++++++++++++----------
>   drivers/s390/crypto/vfio_ap_private.h |   2 +
>   2 files changed, 89 insertions(+), 50 deletions(-)
>
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 0ce00c9311d378..79872c857dd522 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -24,8 +24,9 @@
>   #define VFIO_AP_MDEV_TYPE_HWVIRT "passthrough"
>   #define VFIO_AP_MDEV_NAME_HWVIRT "VFIO AP Passthrough Device"
>   
> -static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev);
> +static int vfio_ap_mdev_reset_queues(struct ap_matrix_mdev *matrix_mdev);
>   static struct vfio_ap_queue *vfio_ap_find_queue(int apqn);
> +static const struct vfio_device_ops vfio_ap_matrix_dev_ops;
>   
>   static int match_apqn(struct device *dev, const void *data)
>   {
> @@ -322,48 +323,63 @@ static void vfio_ap_matrix_init(struct ap_config_info *info,
>   	matrix->adm_max = info->apxa ? info->Nd : 15;
>   }
>   
> -static int vfio_ap_mdev_create(struct mdev_device *mdev)
> +static int vfio_ap_mdev_probe(struct mdev_device *mdev)
>   {
>   	struct ap_matrix_mdev *matrix_mdev;
> +	int ret;
>   
>   	if ((atomic_dec_if_positive(&matrix_dev->available_instances) < 0))
>   		return -EPERM;
>   
>   	matrix_mdev = kzalloc(sizeof(*matrix_mdev), GFP_KERNEL);
>   	if (!matrix_mdev) {
> -		atomic_inc(&matrix_dev->available_instances);
> -		return -ENOMEM;
> +		ret = -ENOMEM;
> +		goto err_atomic;
>   	}
> +	vfio_init_group_dev(&matrix_mdev->vdev, &mdev->dev,
> +			    &vfio_ap_matrix_dev_ops);
>   
>   	matrix_mdev->mdev = mdev;
>   	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
> -	mdev_set_drvdata(mdev, matrix_mdev);
>   	matrix_mdev->pqap_hook.hook = handle_pqap;
>   	matrix_mdev->pqap_hook.owner = THIS_MODULE;
>   	mutex_lock(&matrix_dev->lock);
>   	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
>   	mutex_unlock(&matrix_dev->lock);
>   
> +	ret = vfio_register_group_dev(&matrix_mdev->vdev);
> +	if (ret)
> +		goto err_list;
> +	dev_set_drvdata(&mdev->dev, matrix_mdev);

I'm wondering whether the code above should be done under
the matrix_dev->lock. Does the mdev exist in the sysfs at the
point the probe is called? If so, then is it possible for functions
that acquire the matrix_mdev from the drvdata to get called before
the drvdata is set?

>   	return 0;
> +
> +err_list:
> +	mutex_lock(&matrix_dev->lock);
> +	list_del(&matrix_mdev->node);
> +	mutex_unlock(&matrix_dev->lock);
> +	kfree(matrix_mdev);
> +err_atomic:
> +	atomic_inc(&matrix_dev->available_instances);
> +	return ret;
>   }
>   
> -static int vfio_ap_mdev_remove(struct mdev_device *mdev)
> +static void vfio_ap_mdev_remove(struct mdev_device *mdev)
>   {
> -	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(&mdev->dev);
>   
> -	if (matrix_mdev->kvm)
> -		return -EBUSY;
> +	/* FIXME: Remove isn't allowed to fail */
> +	if (WARN_ON(matrix_mdev->kvm))
> +		return;
> +
> +	vfio_unregister_group_dev(&matrix_mdev->vdev);
>   
>   	mutex_lock(&matrix_dev->lock);
> -	vfio_ap_mdev_reset_queues(mdev);
> +	vfio_ap_mdev_reset_queues(matrix_mdev);
>   	list_del(&matrix_mdev->node);
>   	mutex_unlock(&matrix_dev->lock);
>   
>   	kfree(matrix_mdev);
> -	mdev_set_drvdata(mdev, NULL);
>   	atomic_inc(&matrix_dev->available_instances);
> -
> -	return 0;
>   }
>   
>   static ssize_t name_show(struct mdev_type *mtype,
> @@ -605,8 +621,7 @@ static ssize_t assign_adapter_store(struct device *dev,
>   {
>   	int ret;
>   	unsigned long apid;
> -	struct mdev_device *mdev = mdev_from_dev(dev);
> -	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
>   
>   	/* If the guest is running, disallow assignment of adapter */
>   	if (matrix_mdev->kvm)
> @@ -671,8 +686,7 @@ static ssize_t unassign_adapter_store(struct device *dev,
>   {
>   	int ret;
>   	unsigned long apid;
> -	struct mdev_device *mdev = mdev_from_dev(dev);
> -	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
>   
>   	/* If the guest is running, disallow un-assignment of adapter */
>   	if (matrix_mdev->kvm)
> @@ -751,8 +765,7 @@ static ssize_t assign_domain_store(struct device *dev,
>   {
>   	int ret;
>   	unsigned long apqi;
> -	struct mdev_device *mdev = mdev_from_dev(dev);
> -	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
>   	unsigned long max_apqi = matrix_mdev->matrix.aqm_max;
>   
>   	/* If the guest is running, disallow assignment of domain */
> @@ -813,8 +826,7 @@ static ssize_t unassign_domain_store(struct device *dev,
>   {
>   	int ret;
>   	unsigned long apqi;
> -	struct mdev_device *mdev = mdev_from_dev(dev);
> -	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
>   
>   	/* If the guest is running, disallow un-assignment of domain */
>   	if (matrix_mdev->kvm)
> @@ -857,8 +869,7 @@ static ssize_t assign_control_domain_store(struct device *dev,
>   {
>   	int ret;
>   	unsigned long id;
> -	struct mdev_device *mdev = mdev_from_dev(dev);
> -	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
>   
>   	/* If the guest is running, disallow assignment of control domain */
>   	if (matrix_mdev->kvm)
> @@ -906,8 +917,7 @@ static ssize_t unassign_control_domain_store(struct device *dev,
>   {
>   	int ret;
>   	unsigned long domid;
> -	struct mdev_device *mdev = mdev_from_dev(dev);
> -	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
>   	unsigned long max_domid =  matrix_mdev->matrix.adm_max;
>   
>   	/* If the guest is running, disallow un-assignment of control domain */
> @@ -936,8 +946,7 @@ static ssize_t control_domains_show(struct device *dev,
>   	int nchars = 0;
>   	int n;
>   	char *bufpos = buf;
> -	struct mdev_device *mdev = mdev_from_dev(dev);
> -	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
>   	unsigned long max_domid = matrix_mdev->matrix.adm_max;
>   
>   	mutex_lock(&matrix_dev->lock);
> @@ -955,8 +964,7 @@ static DEVICE_ATTR_RO(control_domains);
>   static ssize_t matrix_show(struct device *dev, struct device_attribute *attr,
>   			   char *buf)
>   {
> -	struct mdev_device *mdev = mdev_from_dev(dev);
> -	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
>   	char *bufpos = buf;
>   	unsigned long apid;
>   	unsigned long apqi;
> @@ -1085,7 +1093,7 @@ static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
>   {
>   	kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
>   	matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
> -	vfio_ap_mdev_reset_queues(matrix_mdev->mdev);
> +	vfio_ap_mdev_reset_queues(matrix_mdev);
>   	kvm_put_kvm(matrix_mdev->kvm);
>   	matrix_mdev->kvm = NULL;
>   }
> @@ -1195,13 +1203,12 @@ int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q,
>   	return ret;
>   }
>   
> -static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
> +static int vfio_ap_mdev_reset_queues(struct ap_matrix_mdev *matrix_mdev)
>   {
>   	int ret;
>   	int rc = 0;
>   	unsigned long apid, apqi;
>   	struct vfio_ap_queue *q;
> -	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>   
>   	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm,
>   			     matrix_mdev->matrix.apm_max + 1) {
> @@ -1222,9 +1229,10 @@ static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
>   	return rc;
>   }
>   
> -static int vfio_ap_mdev_open(struct mdev_device *mdev)
> +static int vfio_ap_mdev_open(struct vfio_device *vdev)
>   {
> -	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +	struct ap_matrix_mdev *matrix_mdev =
> +		container_of(vdev, struct ap_matrix_mdev, vdev);
>   	unsigned long events;
>   	int ret;
>   
> @@ -1235,7 +1243,7 @@ static int vfio_ap_mdev_open(struct mdev_device *mdev)
>   	matrix_mdev->group_notifier.notifier_call = vfio_ap_mdev_group_notifier;
>   	events = VFIO_GROUP_NOTIFY_SET_KVM;
>   
> -	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
> +	ret = vfio_register_notifier(vdev->dev, VFIO_GROUP_NOTIFY,
>   				     &events, &matrix_mdev->group_notifier);
>   	if (ret) {
>   		module_put(THIS_MODULE);
> @@ -1244,29 +1252,30 @@ static int vfio_ap_mdev_open(struct mdev_device *mdev)
>   
>   	matrix_mdev->iommu_notifier.notifier_call = vfio_ap_mdev_iommu_notifier;
>   	events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
> -	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
> +	ret = vfio_register_notifier(vdev->dev, VFIO_IOMMU_NOTIFY,
>   				     &events, &matrix_mdev->iommu_notifier);
>   	if (!ret)
>   		return ret;
>   
> -	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
> +	vfio_unregister_notifier(vdev->dev, VFIO_GROUP_NOTIFY,
>   				 &matrix_mdev->group_notifier);
>   	module_put(THIS_MODULE);
>   	return ret;
>   }
>   
> -static void vfio_ap_mdev_release(struct mdev_device *mdev)
> +static void vfio_ap_mdev_release(struct vfio_device *vdev)
>   {
> -	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +	struct ap_matrix_mdev *matrix_mdev =
> +		container_of(vdev, struct ap_matrix_mdev, vdev);
>   
>   	mutex_lock(&matrix_dev->lock);
>   	if (matrix_mdev->kvm)
>   		vfio_ap_mdev_unset_kvm(matrix_mdev);
>   	mutex_unlock(&matrix_dev->lock);
>   
> -	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
> +	vfio_unregister_notifier(vdev->dev, VFIO_IOMMU_NOTIFY,
>   				 &matrix_mdev->iommu_notifier);
> -	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
> +	vfio_unregister_notifier(vdev->dev, VFIO_GROUP_NOTIFY,
>   				 &matrix_mdev->group_notifier);
>   	module_put(THIS_MODULE);
>   }
> @@ -1291,9 +1300,11 @@ static int vfio_ap_mdev_get_device_info(unsigned long arg)
>   	return copy_to_user((void __user *)arg, &info, minsz) ? -EFAULT : 0;
>   }
>   
> -static ssize_t vfio_ap_mdev_ioctl(struct mdev_device *mdev,
> +static ssize_t vfio_ap_mdev_ioctl(struct vfio_device *vdev,
>   				    unsigned int cmd, unsigned long arg)
>   {
> +	struct ap_matrix_mdev *matrix_mdev =
> +		container_of(vdev, struct ap_matrix_mdev, vdev);
>   	int ret;
>   
>   	mutex_lock(&matrix_dev->lock);
> @@ -1302,7 +1313,7 @@ static ssize_t vfio_ap_mdev_ioctl(struct mdev_device *mdev,
>   		ret = vfio_ap_mdev_get_device_info(arg);
>   		break;
>   	case VFIO_DEVICE_RESET:
> -		ret = vfio_ap_mdev_reset_queues(mdev);
> +		ret = vfio_ap_mdev_reset_queues(matrix_mdev);
>   		break;
>   	default:
>   		ret = -EOPNOTSUPP;
> @@ -1313,25 +1324,51 @@ static ssize_t vfio_ap_mdev_ioctl(struct mdev_device *mdev,
>   	return ret;
>   }
>   
> +static const struct vfio_device_ops vfio_ap_matrix_dev_ops = {
> +	.open = vfio_ap_mdev_open,
> +	.release = vfio_ap_mdev_release,
> +	.ioctl = vfio_ap_mdev_ioctl,
> +};
> +
> +static struct mdev_driver vfio_ap_matrix_driver = {
> +	.driver = {
> +		.name = "vfio_ap_mdev",
> +		.owner = THIS_MODULE,
> +		.mod_name = KBUILD_MODNAME,
> +		.dev_groups = vfio_ap_mdev_attr_groups,
> +	},
> +	.probe = vfio_ap_mdev_probe,
> +	.remove = vfio_ap_mdev_remove,
> +};
> +
>   static const struct mdev_parent_ops vfio_ap_matrix_ops = {
>   	.owner			= THIS_MODULE,
> +	.device_driver		= &vfio_ap_matrix_driver,
>   	.supported_type_groups	= vfio_ap_mdev_type_groups,
> -	.mdev_attr_groups	= vfio_ap_mdev_attr_groups,
> -	.create			= vfio_ap_mdev_create,
> -	.remove			= vfio_ap_mdev_remove,
> -	.open			= vfio_ap_mdev_open,
> -	.release		= vfio_ap_mdev_release,
> -	.ioctl			= vfio_ap_mdev_ioctl,
>   };
>   
>   int vfio_ap_mdev_register(void)
>   {
> +	int ret;
> +
>   	atomic_set(&matrix_dev->available_instances, MAX_ZDEV_ENTRIES_EXT);
>   
> -	return mdev_register_device(&matrix_dev->device, &vfio_ap_matrix_ops);
> +	ret = mdev_register_driver(&vfio_ap_matrix_driver);
> +	if (ret)
> +		return ret;
> +
> +	ret = mdev_register_device(&matrix_dev->device, &vfio_ap_matrix_ops);
> +	if (ret)
> +		goto err_driver;
> +	return 0;
> +
> +err_driver:
> +	mdev_unregister_driver(&vfio_ap_matrix_driver);
> +	return ret;
>   }
>   
>   void vfio_ap_mdev_unregister(void)
>   {
>   	mdev_unregister_device(&matrix_dev->device);
> +	mdev_unregister_driver(&vfio_ap_matrix_driver);
>   }
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index 28e9d998976820..b95ba674f60b1b 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -18,6 +18,7 @@
>   #include <linux/delay.h>
>   #include <linux/mutex.h>
>   #include <linux/kvm_host.h>
> +#include <linux/vfio.h>
>   
>   #include "ap_bus.h"
>   
> @@ -79,6 +80,7 @@ struct ap_matrix {
>    * @kvm:	the struct holding guest's state
>    */
>   struct ap_matrix_mdev {
> +	struct vfio_device vdev;
>   	struct list_head node;
>   	struct ap_matrix matrix;
>   	struct notifier_block group_notifier;

