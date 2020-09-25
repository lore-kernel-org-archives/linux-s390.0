Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14994 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726255AbgIYJ3u (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 25 Sep 2020 05:29:50 -0400
Date: Fri, 25 Sep 2020 11:29:41 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v10 05/16] s390/vfio-ap: implement in-use callback for
 vfio_ap driver
Message-ID: <20200925112941.71589591.pasic@linux.ibm.com>
In-Reply-To: <20200821195616.13554-6-akrowiak@linux.ibm.com>
References: <20200821195616.13554-1-akrowiak@linux.ibm.com>
        <20200821195616.13554-6-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com

On Fri, 21 Aug 2020 15:56:05 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> +
> +bool vfio_ap_mdev_resource_in_use(unsigned long *apm, unsigned long *aqm)
> +{
> +	bool in_use;
> +
> +	mutex_lock(&matrix_dev->lock);
> +	in_use = !!vfio_ap_mdev_verify_no_sharing(NULL, apm, aqm);
> +	mutex_unlock(&matrix_dev->lock);

See also my comment for patch 4. AFAIU as soon as you release the lock
the in_use may become outdated in any moment.

> +
> +	return in_use;
> +}
