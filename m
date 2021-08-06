Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2D3C4338F
	for <linux-s390@archiver.kernel.org>; Fri,  6 Aug 2021 13:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EF5561052
	for <linux-s390@archiver.kernel.org>; Fri,  6 Aug 2021 13:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243498AbhHFN1f (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 6 Aug 2021 09:27:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31644 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236885AbhHFN1f (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 6 Aug 2021 09:27:35 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 176DLwdk104463;
        Fri, 6 Aug 2021 09:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=FYcCIxb6I4WVE/UNsg4tpPyqlGMUtrxeal4K3IazEI4=;
 b=tHXYO2h2EejBMniF27xXYAhATByHGGf0RPRe0EyJH5EJ41N3k8uUr6MHeUsc1pe5FwNN
 a/22uvKThMRhOpCP9Mhu3J5XpF0Hgv+xDK58syYs6bX4mlObQBJF67IL6yjOkGmIArJX
 h5+ENTJiW+FxxBv+/SK7r1psxZrYK2vaRjwIPbtcAp14ouhi3mxvVaeP2mDesy4yJozK
 UFPRYHmGjGltlsFWQvhSHXGba8rpSKn334UlOe/T2IY4VurLe6cHk+jre0Y0y4qpz89k
 +bII/lmUfx8yWbZLL6kWKr9NX0Y0tLVcTY1gJ80xctBcz4HhJ5y82Q5+luUViA4oexGg XA== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a8r5r45gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Aug 2021 09:26:39 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 176DDRYU026951;
        Fri, 6 Aug 2021 13:26:38 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma03wdc.us.ibm.com with ESMTP id 3a77h5udy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Aug 2021 13:26:38 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 176DQbdu48562476
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Aug 2021 13:26:37 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38726C605A;
        Fri,  6 Aug 2021 13:26:37 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C70FC6059;
        Fri,  6 Aug 2021 13:26:35 +0000 (GMT)
Received: from cpe-172-100-181-211.stny.res.rr.com (unknown [9.160.182.229])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  6 Aug 2021 13:26:35 +0000 (GMT)
Subject: Re: [PATCH] s390/crypto: fix all kernel-doc warnings in vfio_ap_ops.c
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org
References: <20210806050149.9614-1-rdunlap@infradead.org>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <d8f1b065-f7b2-a0f3-f87a-ffdd2f7f2781@linux.ibm.com>
Date:   Fri, 6 Aug 2021 09:26:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210806050149.9614-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 691-u3YhBAXf_wbBEkv08KevblvnyjT8
X-Proofpoint-ORIG-GUID: 691-u3YhBAXf_wbBEkv08KevblvnyjT8
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-06_04:2021-08-05,2021-08-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 clxscore=1011 mlxscore=0 suspectscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108060092
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>

Pardon my ignorance, but this is the first I've seen of kernel-doc 
warnings.
Is there a flag I can set when I build to get kernel-doc warnings? Is 
there a tool I can run?
Where is the kernel-doc format documented? I'd like to avoid this in the 
future.

On 8/6/21 1:01 AM, Randy Dunlap wrote:
> The 0day bot reported some kernel-doc warnings in this file so clean up
> all of the kernel-doc and use proper kernel-doc formatting.
> There are no more kernel-doc errors or warnings reported in this file.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Tony Krowiak <akrowiak@linux.ibm.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Jason Herne <jjherne@linux.ibm.com>
> Cc: Harald Freudenberger <freude@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> ---
>   drivers/s390/crypto/vfio_ap_ops.c |  116 ++++++++++++----------------
>   1 file changed, 52 insertions(+), 64 deletions(-)
>
> --- linux-next-20210805.orig/drivers/s390/crypto/vfio_ap_ops.c
> +++ linux-next-20210805/drivers/s390/crypto/vfio_ap_ops.c
> @@ -35,7 +35,7 @@ static int match_apqn(struct device *dev
>   }
>   
>   /**
> - * vfio_ap_get_queue: Retrieve a queue with a specific APQN from a list
> + * vfio_ap_get_queue - retrieve a queue with a specific APQN from a list
>    * @matrix_mdev: the associated mediated matrix
>    * @apqn: The queue APQN
>    *
> @@ -43,7 +43,7 @@ static int match_apqn(struct device *dev
>    * devices of the vfio_ap_drv.
>    * Verify that the APID and the APQI are set in the matrix.
>    *
> - * Returns the pointer to the associated vfio_ap_queue
> + * Return: the pointer to the associated vfio_ap_queue
>    */
>   static struct vfio_ap_queue *vfio_ap_get_queue(
>   					struct ap_matrix_mdev *matrix_mdev,
> @@ -64,7 +64,7 @@ static struct vfio_ap_queue *vfio_ap_get
>   }
>   
>   /**
> - * vfio_ap_wait_for_irqclear
> + * vfio_ap_wait_for_irqclear - clears the IR bit or gives up after 5 tries
>    * @apqn: The AP Queue number
>    *
>    * Checks the IRQ bit for the status of this APQN using ap_tapq.
> @@ -72,7 +72,6 @@ static struct vfio_ap_queue *vfio_ap_get
>    * Returns if ap_tapq function failed with invalid, deconfigured or
>    * checkstopped AP.
>    * Otherwise retries up to 5 times after waiting 20ms.
> - *
>    */
>   static void vfio_ap_wait_for_irqclear(int apqn)
>   {
> @@ -105,13 +104,12 @@ static void vfio_ap_wait_for_irqclear(in
>   }
>   
>   /**
> - * vfio_ap_free_aqic_resources
> + * vfio_ap_free_aqic_resources - free vfio_ap_queue resources
>    * @q: The vfio_ap_queue
>    *
>    * Unregisters the ISC in the GIB when the saved ISC not invalid.
> - * Unpin the guest's page holding the NIB when it exist.
> - * Reset the saved_pfn and saved_isc to invalid values.
> - *
> + * Unpins the guest's page holding the NIB when it exists.
> + * Resets the saved_pfn and saved_isc to invalid values.
>    */
>   static void vfio_ap_free_aqic_resources(struct vfio_ap_queue *q)
>   {
> @@ -130,7 +128,7 @@ static void vfio_ap_free_aqic_resources(
>   }
>   
>   /**
> - * vfio_ap_irq_disable
> + * vfio_ap_irq_disable - disables and clears an ap_queue interrupt
>    * @q: The vfio_ap_queue
>    *
>    * Uses ap_aqic to disable the interruption and in case of success, reset
> @@ -144,6 +142,8 @@ static void vfio_ap_free_aqic_resources(
>    *
>    * Returns if ap_aqic function failed with invalid, deconfigured or
>    * checkstopped AP.
> + *
> + * Return: &struct ap_queue_status
>    */
>   static struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
>   {
> @@ -183,9 +183,8 @@ end_free:
>   }
>   
>   /**
> - * vfio_ap_setirq: Enable Interruption for a APQN
> + * vfio_ap_irq_enable - Enable Interruption for a APQN
>    *
> - * @dev: the device associated with the ap_queue
>    * @q:	 the vfio_ap_queue holding AQIC parameters
>    *
>    * Pin the NIB saved in *q
> @@ -197,6 +196,8 @@ end_free:
>    *
>    * Otherwise return the ap_queue_status returned by the ap_aqic(),
>    * all retry handling will be done by the guest.
> + *
> + * Return: &struct ap_queue_status
>    */
>   static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
>   						 int isc,
> @@ -253,7 +254,7 @@ static struct ap_queue_status vfio_ap_ir
>   }
>   
>   /**
> - * handle_pqap: PQAP instruction callback
> + * handle_pqap - PQAP instruction callback
>    *
>    * @vcpu: The vcpu on which we received the PQAP instruction
>    *
> @@ -270,8 +271,8 @@ static struct ap_queue_status vfio_ap_ir
>    * We take the matrix_dev lock to ensure serialization on queues and
>    * mediated device access.
>    *
> - * Return 0 if we could handle the request inside KVM.
> - * otherwise, returns -EOPNOTSUPP to let QEMU handle the fault.
> + * Return: 0 if we could handle the request inside KVM.
> + * Otherwise, returns -EOPNOTSUPP to let QEMU handle the fault.
>    */
>   static int handle_pqap(struct kvm_vcpu *vcpu)
>   {
> @@ -426,7 +427,7 @@ struct vfio_ap_queue_reserved {
>   };
>   
>   /**
> - * vfio_ap_has_queue
> + * vfio_ap_has_queue - determines if the AP queue containing the target in @data
>    *
>    * @dev: an AP queue device
>    * @data: a struct vfio_ap_queue_reserved reference
> @@ -443,7 +444,7 @@ struct vfio_ap_queue_reserved {
>    * - If @data contains only an apqi value, @data will be flagged as
>    *   reserved if the APQI field in the AP queue device matches
>    *
> - * Returns 0 to indicate the input to function succeeded. Returns -EINVAL if
> + * Return: 0 to indicate the input to function succeeded. Returns -EINVAL if
>    * @data does not contain either an apid or apqi.
>    */
>   static int vfio_ap_has_queue(struct device *dev, void *data)
> @@ -473,9 +474,9 @@ static int vfio_ap_has_queue(struct devi
>   }
>   
>   /**
> - * vfio_ap_verify_queue_reserved
> + * vfio_ap_verify_queue_reserved - verifies that the AP queue containing
> + * @apid or @aqpi is reserved
>    *
> - * @matrix_dev: a mediated matrix device
>    * @apid: an AP adapter ID
>    * @apqi: an AP queue index
>    *
> @@ -492,7 +493,7 @@ static int vfio_ap_has_queue(struct devi
>    * - If only @apqi is not NULL, then there must be an AP queue device bound
>    *   to the vfio_ap driver with an APQN containing @apqi
>    *
> - * Returns 0 if the AP queue is reserved; otherwise, returns -EADDRNOTAVAIL.
> + * Return: 0 if the AP queue is reserved; otherwise, returns -EADDRNOTAVAIL.
>    */
>   static int vfio_ap_verify_queue_reserved(unsigned long *apid,
>   					 unsigned long *apqi)
> @@ -536,15 +537,15 @@ vfio_ap_mdev_verify_queues_reserved_for_
>   }
>   
>   /**
> - * vfio_ap_mdev_verify_no_sharing
> + * vfio_ap_mdev_verify_no_sharing - verifies that the AP matrix is not configured
> + *
> + * @matrix_mdev: the mediated matrix device
>    *
>    * Verifies that the APQNs derived from the cross product of the AP adapter IDs
>    * and AP queue indexes comprising the AP matrix are not configured for another
>    * mediated device. AP queue sharing is not allowed.
>    *
> - * @matrix_mdev: the mediated matrix device
> - *
> - * Returns 0 if the APQNs are not shared, otherwise; returns -EADDRINUSE.
> + * Return: 0 if the APQNs are not shared; otherwise returns -EADDRINUSE.
>    */
>   static int vfio_ap_mdev_verify_no_sharing(struct ap_matrix_mdev *matrix_mdev)
>   {
> @@ -578,7 +579,8 @@ static int vfio_ap_mdev_verify_no_sharin
>   }
>   
>   /**
> - * assign_adapter_store
> + * assign_adapter_store - parses the APID from @buf and sets the
> + * corresponding bit in the mediated matrix device's APM
>    *
>    * @dev:	the matrix device
>    * @attr:	the mediated matrix device's assign_adapter attribute
> @@ -586,10 +588,7 @@ static int vfio_ap_mdev_verify_no_sharin
>    *		be assigned
>    * @count:	the number of bytes in @buf
>    *
> - * Parses the APID from @buf and sets the corresponding bit in the mediated
> - * matrix device's APM.
> - *
> - * Returns the number of bytes processed if the APID is valid; otherwise,
> + * Return: the number of bytes processed if the APID is valid; otherwise,
>    * returns one of the following errors:
>    *
>    *	1. -EINVAL
> @@ -666,17 +665,15 @@ done:
>   static DEVICE_ATTR_WO(assign_adapter);
>   
>   /**
> - * unassign_adapter_store
> + * unassign_adapter_store - parses the APID from @buf and clears the
> + * corresponding bit in the mediated matrix device's APM
>    *
>    * @dev:	the matrix device
>    * @attr:	the mediated matrix device's unassign_adapter attribute
>    * @buf:	a buffer containing the adapter number (APID) to be unassigned
>    * @count:	the number of bytes in @buf
>    *
> - * Parses the APID from @buf and clears the corresponding bit in the mediated
> - * matrix device's APM.
> - *
> - * Returns the number of bytes processed if the APID is valid; otherwise,
> + * Return: the number of bytes processed if the APID is valid; otherwise,
>    * returns one of the following errors:
>    *	-EINVAL if the APID is not a number
>    *	-ENODEV if the APID it exceeds the maximum value configured for the
> @@ -740,7 +737,9 @@ vfio_ap_mdev_verify_queues_reserved_for_
>   }
>   
>   /**
> - * assign_domain_store
> + * assign_domain_store - parses the APQI from @buf and sets the
> + * corresponding bit in the mediated matrix device's AQM
> + *
>    *
>    * @dev:	the matrix device
>    * @attr:	the mediated matrix device's assign_domain attribute
> @@ -748,10 +747,7 @@ vfio_ap_mdev_verify_queues_reserved_for_
>    *		be assigned
>    * @count:	the number of bytes in @buf
>    *
> - * Parses the APQI from @buf and sets the corresponding bit in the mediated
> - * matrix device's AQM.
> - *
> - * Returns the number of bytes processed if the APQI is valid; otherwise returns
> + * Return: the number of bytes processed if the APQI is valid; otherwise returns
>    * one of the following errors:
>    *
>    *	1. -EINVAL
> @@ -824,7 +820,8 @@ static DEVICE_ATTR_WO(assign_domain);
>   
>   
>   /**
> - * unassign_domain_store
> + * unassign_domain_store - parses the APQI from @buf and clears the
> + * corresponding bit in the mediated matrix device's AQM
>    *
>    * @dev:	the matrix device
>    * @attr:	the mediated matrix device's unassign_domain attribute
> @@ -832,10 +829,7 @@ static DEVICE_ATTR_WO(assign_domain);
>    *		be unassigned
>    * @count:	the number of bytes in @buf
>    *
> - * Parses the APQI from @buf and clears the corresponding bit in the
> - * mediated matrix device's AQM.
> - *
> - * Returns the number of bytes processed if the APQI is valid; otherwise,
> + * Return: the number of bytes processed if the APQI is valid; otherwise,
>    * returns one of the following errors:
>    *	-EINVAL if the APQI is not a number
>    *	-ENODEV if the APQI exceeds the maximum value configured for the system
> @@ -879,17 +873,16 @@ done:
>   static DEVICE_ATTR_WO(unassign_domain);
>   
>   /**
> - * assign_control_domain_store
> + * assign_control_domain_store - parses the domain ID from @buf and sets
> + * the corresponding bit in the mediated matrix device's ADM
> + *
>    *
>    * @dev:	the matrix device
>    * @attr:	the mediated matrix device's assign_control_domain attribute
>    * @buf:	a buffer containing the domain ID to be assigned
>    * @count:	the number of bytes in @buf
>    *
> - * Parses the domain ID from @buf and sets the corresponding bit in the mediated
> - * matrix device's ADM.
> - *
> - * Returns the number of bytes processed if the domain ID is valid; otherwise,
> + * Return: the number of bytes processed if the domain ID is valid; otherwise,
>    * returns one of the following errors:
>    *	-EINVAL if the ID is not a number
>    *	-ENODEV if the ID exceeds the maximum value configured for the system
> @@ -937,17 +930,15 @@ done:
>   static DEVICE_ATTR_WO(assign_control_domain);
>   
>   /**
> - * unassign_control_domain_store
> + * unassign_control_domain_store - parses the domain ID from @buf and
> + * clears the corresponding bit in the mediated matrix device's ADM
>    *
>    * @dev:	the matrix device
>    * @attr:	the mediated matrix device's unassign_control_domain attribute
>    * @buf:	a buffer containing the domain ID to be unassigned
>    * @count:	the number of bytes in @buf
>    *
> - * Parses the domain ID from @buf and clears the corresponding bit in the
> - * mediated matrix device's ADM.
> - *
> - * Returns the number of bytes processed if the domain ID is valid; otherwise,
> + * Return: the number of bytes processed if the domain ID is valid; otherwise,
>    * returns one of the following errors:
>    *	-EINVAL if the ID is not a number
>    *	-ENODEV if the ID exceeds the maximum value configured for the system
> @@ -1085,14 +1076,12 @@ static const struct attribute_group *vfi
>   };
>   
>   /**
> - * vfio_ap_mdev_set_kvm
> + * vfio_ap_mdev_set_kvm - sets all data for @matrix_mdev that are needed
> + * to manage AP resources for the guest whose state is represented by @kvm
>    *
>    * @matrix_mdev: a mediated matrix device
>    * @kvm: reference to KVM instance
>    *
> - * Sets all data for @matrix_mdev that are needed to manage AP resources
> - * for the guest whose state is represented by @kvm.
> - *
>    * Note: The matrix_dev->lock must be taken prior to calling
>    * this function; however, the lock will be temporarily released while the
>    * guest's AP configuration is set to avoid a potential lockdep splat.
> @@ -1100,7 +1089,7 @@ static const struct attribute_group *vfi
>    * certain circumstances, will result in a circular lock dependency if this is
>    * done under the @matrix_mdev->lock.
>    *
> - * Return 0 if no other mediated matrix device has a reference to @kvm;
> + * Return: 0 if no other mediated matrix device has a reference to @kvm;
>    * otherwise, returns an -EPERM.
>    */
>   static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
> @@ -1131,8 +1120,8 @@ static int vfio_ap_mdev_set_kvm(struct a
>   	return 0;
>   }
>   
> -/*
> - * vfio_ap_mdev_iommu_notifier: IOMMU notifier callback
> +/**
> + * vfio_ap_mdev_iommu_notifier - IOMMU notifier callback
>    *
>    * @nb: The notifier block
>    * @action: Action to be taken
> @@ -1141,6 +1130,7 @@ static int vfio_ap_mdev_set_kvm(struct a
>    * For an UNMAP request, unpin the guest IOVA (the NIB guest address we
>    * pinned before). Other requests are ignored.
>    *
> + * Return: for an UNMAP request, NOFITY_OK; otherwise NOTIFY_DONE.
>    */
>   static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
>   				       unsigned long action, void *data)
> @@ -1161,19 +1151,17 @@ static int vfio_ap_mdev_iommu_notifier(s
>   }
>   
>   /**
> - * vfio_ap_mdev_unset_kvm
> + * vfio_ap_mdev_unset_kvm - performs clean-up of resources no longer needed
> + * by @matrix_mdev.
>    *
>    * @matrix_mdev: a matrix mediated device
>    *
> - * Performs clean-up of resources no longer needed by @matrix_mdev.
> - *
>    * Note: The matrix_dev->lock must be taken prior to calling
>    * this function; however, the lock will be temporarily released while the
>    * guest's AP configuration is cleared to avoid a potential lockdep splat.
>    * The kvm->lock is taken to clear the guest's AP configuration which, under
>    * certain circumstances, will result in a circular lock dependency if this is
>    * done under the @matrix_mdev->lock.
> - *
>    */
>   static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
>   {

