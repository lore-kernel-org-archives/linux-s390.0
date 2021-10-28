Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B60C433F5
	for <linux-s390@archiver.kernel.org>; Thu, 28 Oct 2021 07:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF8ED604DC
	for <linux-s390@archiver.kernel.org>; Thu, 28 Oct 2021 07:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhJ1Hmr (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 28 Oct 2021 03:42:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24466 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229626AbhJ1Hmq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 28 Oct 2021 03:42:46 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19S7IAAQ015831
        for <linux-s390@vger.kernel.org>; Thu, 28 Oct 2021 07:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ES4zQE//j4gAF/e/WLmAKOTzsmahkLKfYuEK3V+D+GM=;
 b=i0HnKcMNnjePkUeTfU5MnjuxOqYBsKcJG64h17GysAt390uGPwqnmXtvoScgJdGyBnf1
 E+BMO7NFJ9AoMfR/Zv9hmkSaRg3JnXpa0/KhmsswNyeWG37G0bZLkUiucuWaLH/6USWx
 inNXblAQtZOKlMhXq61zHp/jI2G5r29NxUTGJ+A87pusni5yGFzkCZ09n4SY1yvAS45n
 2bGE7Tlg39MCb9SLrGtWxFGssEf24YLHtF1NedUyyu7YtqN2bm6LkYOTWY/0bYtG/xVJ
 thHbx57GnuQxktHYq0Yx4TnibPKnr4MVrxrWvMgYBkZQmfmIqCIYPE2v4RrECVF5S6/X 2g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3byqbrgdjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 28 Oct 2021 07:40:19 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19S7PE5N000364
        for <linux-s390@vger.kernel.org>; Thu, 28 Oct 2021 07:40:19 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3byqbrgdj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 07:40:19 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19S7bupU029461;
        Thu, 28 Oct 2021 07:40:17 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3bx4ee6hmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 07:40:16 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19S7eDPp61014526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Oct 2021 07:40:13 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 137DD42041;
        Thu, 28 Oct 2021 07:40:13 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D637B42047;
        Thu, 28 Oct 2021 07:40:12 +0000 (GMT)
Received: from funtu.home (unknown [9.145.48.188])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 Oct 2021 07:40:12 +0000 (GMT)
Subject: Re: [PATCH 2/2] s390/vfio-ap: add status attribute to AP queue
 device's sysfs dir
To:     Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc:     borntraeger@linux.ibm.com, cohuck@redhat.com,
        mjrosato@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com
References: <20211027164810.19678-1-akrowiak@linux.ibm.com>
 <20211027164810.19678-3-akrowiak@linux.ibm.com>
From:   Harald Freudenberger <freude@linux.ibm.com>
Message-ID: <5ce1ab5f-da7b-451d-ebfe-08919a56f5d8@linux.ibm.com>
Date:   Thu, 28 Oct 2021 09:40:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211027164810.19678-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zuEhvBGhNwKkLUDfI4C6hBnoss5oqaf3
X-Proofpoint-GUID: EVOXzsAPoGAGo4XObiGOgdRoF4Sa8o4a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-28_01,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 clxscore=1011 mlxscore=0 phishscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2110280037
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 27.10.21 18:48, Tony Krowiak wrote:
> This patch adds a sysfs 'status' attribute to a queue device when it is
> bound to the vfio_ap device driver. The field displays a string indicating
> the status of the queue device:
>
> Status String:  Indicates:
> -------------   ---------
> "assigned"      the queue is assigned to an mdev, but is not in use by a
>                 KVM guest.
> "in use"        the queue is assigned to an mdev and is in use by a KVM
>                 guest.
> "unassigned"    the queue is not assigned to an mdev.
>
> The status string will be displayed by the 'lszcrypt' command if the queue
> device is bound to the vfio_ap device driver.
>
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> [akrowiak@linux.ibm.com: added check for queue in use by guest]
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_drv.c | 79 +++++++++++++++++++++++++++++--
>  1 file changed, 76 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index 03311a476366..e043ae236630 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -17,6 +17,9 @@
>  
>  #define VFIO_AP_ROOT_NAME "vfio_ap"
>  #define VFIO_AP_DEV_NAME "matrix"
> +#define AP_QUEUE_ASSIGNED "assigned"
> +#define AP_QUEUE_UNASSIGNED "unassigned"
> +#define AP_QUEUE_IN_USE "in use"
>  
>  MODULE_AUTHOR("IBM Corporation");
>  MODULE_DESCRIPTION("VFIO AP device driver, Copyright IBM Corp. 2018");
> @@ -41,26 +44,95 @@ static struct ap_device_id ap_queue_ids[] = {
>  
>  MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
>  
> +static struct ap_matrix_mdev *vfio_ap_mdev_for_queue(struct vfio_ap_queue *q)
> +{
> +	struct ap_matrix_mdev *matrix_mdev;
> +	unsigned long apid = AP_QID_CARD(q->apqn);
> +	unsigned long apqi = AP_QID_QUEUE(q->apqn);
> +
> +	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
> +		if (test_bit_inv(apid, matrix_mdev->matrix.apm) &&
> +		    test_bit_inv(apqi, matrix_mdev->matrix.aqm))
> +			return matrix_mdev;
> +	}
> +
> +	return NULL;
> +}
> +
> +static ssize_t status_show(struct device *dev,
> +			   struct device_attribute *attr,
> +			   char *buf)
> +{
> +	ssize_t nchars = 0;
> +	struct vfio_ap_queue *q;
> +	struct ap_matrix_mdev *matrix_mdev;
> +	struct ap_device *apdev = to_ap_dev(dev);
> +
> +	mutex_lock(&matrix_dev->lock);
> +	q = dev_get_drvdata(&apdev->device);
> +	matrix_mdev = vfio_ap_mdev_for_queue(q);
> +
> +	if (matrix_mdev) {
> +		if (matrix_mdev->kvm)
> +			nchars = scnprintf(buf, PAGE_SIZE, "%s\n",
> +					   AP_QUEUE_IN_USE);
> +		else
> +			nchars = scnprintf(buf, PAGE_SIZE, "%s\n",
> +					   AP_QUEUE_ASSIGNED);
> +	} else {
> +		nchars = scnprintf(buf, PAGE_SIZE, "%s\n",
> +				   AP_QUEUE_UNASSIGNED);
> +	}
> +
> +	mutex_unlock(&matrix_dev->lock);
> +
> +	return nchars;
> +}
> +
> +static DEVICE_ATTR_RO(status);
> +
> +static struct attribute *vfio_queue_attrs[] = {
> +	&dev_attr_status.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group vfio_queue_attr_group = {
> +	.attrs = vfio_queue_attrs,
> +};
> +
>  /**
>   * vfio_ap_queue_dev_probe: Allocate a vfio_ap_queue structure and associate it
>   *			    with the device as driver_data.
>   *
>   * @apdev: the AP device being probed
>   *
> - * Return: returns 0 if the probe succeeded; otherwise, returns -ENOMEM if
> - *	   storage could not be allocated for a vfio_ap_queue object.
> + * Return: returns 0 if the probe succeeded; otherwise, returns an error if
> + *	   storage could not be allocated for a vfio_ap_queue object or the
> + *	   sysfs 'status' attribute could not be created for the queue device.
>   */
>  static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
>  {
> +	int ret;
>  	struct vfio_ap_queue *q;
>  
>  	q = kzalloc(sizeof(*q), GFP_KERNEL);
>  	if (!q)
>  		return -ENOMEM;
> +
> +	mutex_lock(&matrix_dev->lock);
>  	dev_set_drvdata(&apdev->device, q);
>  	q->apqn = to_ap_queue(&apdev->device)->qid;
>  	q->saved_isc = VFIO_AP_ISC_INVALID;
> -	return 0;
> +
> +	ret = sysfs_create_group(&apdev->device.kobj, &vfio_queue_attr_group);
> +	if (ret) {
> +		dev_set_drvdata(&apdev->device, NULL);
> +		kfree(q);
> +	}
> +
> +	mutex_unlock(&matrix_dev->lock);
> +
> +	return ret;
>  }
>  
>  /**
> @@ -75,6 +147,7 @@ static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
>  	struct vfio_ap_queue *q;
>  
>  	mutex_lock(&matrix_dev->lock);
> +	sysfs_remove_group(&apdev->device.kobj, &vfio_queue_attr_group);
>  	q = dev_get_drvdata(&apdev->device);
>  	vfio_ap_mdev_reset_queue(q, 1);
>  	dev_set_drvdata(&apdev->device, NULL);
Looks good to me, add my "Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>"
