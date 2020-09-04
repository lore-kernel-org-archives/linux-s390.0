Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19106 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726655AbgIDIPs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 4 Sep 2020 04:15:48 -0400
Subject: Re: [PATCH v10 03/16] s390/vfio-ap: manage link between queue struct
 and matrix mdev
References: <20200821195616.13554-1-akrowiak@linux.ibm.com>
 <20200821195616.13554-4-akrowiak@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <99581cee-65fd-a622-ddc9-1a30e4638668@de.ibm.com>
Date: Fri, 4 Sep 2020 10:15:38 +0200
MIME-Version: 1.0
In-Reply-To: <20200821195616.13554-4-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com


On 21.08.20 21:56, Tony Krowiak wrote:
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index a2aa05bec718..57da703b549a 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -87,6 +87,7 @@ struct ap_matrix_mdev {
>  	struct kvm *kvm;
>  	struct kvm_s390_module_hook pqap_hook;
>  	struct mdev_device *mdev;
> +	DECLARE_HASHTABLE(qtable, 8);
>  };

Ah I think the include should go into this patch. But then you should revisit the patch description
of 2 as it talks about hashtables (but doesnt do anything about it). 
