Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24370 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728785AbgFPRu4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 16 Jun 2020 13:50:56 -0400
Subject: Re: [PATCH v8 03/16] s390/vfio-ap: manage link between queue struct
 and matrix mdev
References: <20200605214004.14270-1-akrowiak@linux.ibm.com>
 <20200605214004.14270-4-akrowiak@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <6ae77590-8401-a06b-eec5-713319c21017@de.ibm.com>
Date: Tue, 16 Jun 2020 19:50:44 +0200
MIME-Version: 1.0
In-Reply-To: <20200605214004.14270-4-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com



On 05.06.20 23:39, Tony Krowiak wrote:
[...]
> +static void vfio_ap_mdev_link_queues(struct ap_matrix_mdev *matrix_mdev,
> +				     enum qlink_type type,
> +				     unsigned long qlink_id)
> +{
> +	unsigned long id;
> +	struct vfio_ap_queue *q;
> +
> +	switch (type) {
> +	case LINK_APID:
> +	case UNLINK_APID:
> +		for_each_set_bit_inv(id, matrix_mdev->matrix.aqm,
> +				     matrix_mdev->matrix.aqm_max + 1) {
> +			q = vfio_ap_get_queue(AP_MKQID(qlink_id, id));
> +			if (q) {
> +				if (type == LINK_APID)
> +					q->matrix_mdev = matrix_mdev;
> +				else
> +					q->matrix_mdev = NULL;> +			}
> +		}
> +		break;
> +	default:

Can you rather use
	case LINK_APQI:
	case UNLINK_APQI:

and add a default case with a WARN_ON_ONCE?

> +		for_each_set_bit_inv(id, matrix_mdev->matrix.apm,
> +				     matrix_mdev->matrix.apm_max + 1) {
> +			q = vfio_ap_get_queue(AP_MKQID(id, qlink_id));
> +			if (q) {
> +				if (type == LINK_APQI)
> +					q->matrix_mdev = matrix_mdev;
> +				else
> +					q->matrix_mdev = NULL;
> +			}
> +		}
> +		break;
> +	}
> +}
> +
