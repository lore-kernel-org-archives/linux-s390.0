Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D30C433FE
	for <linux-s390@archiver.kernel.org>; Mon, 18 Oct 2021 11:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C97160F9D
	for <linux-s390@archiver.kernel.org>; Mon, 18 Oct 2021 11:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhJRLxA (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 18 Oct 2021 07:53:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9240 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229833AbhJRLw7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 Oct 2021 07:52:59 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19IAGKKV013038;
        Mon, 18 Oct 2021 07:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=/6Se+8alm5DRdVYFv0+a6sGcNoBzLrKaSW2p5tdIo9w=;
 b=M3Jv77QORoOonJ0MBXf1zH+5IwYdceJ2AqTKDpnsL+8Kec2zyX2iiL3LmWn/bptrWTT6
 Nxb6w33cPnBG9IxAgkA++/bMTH63IdndWuY6vSpkbcOh/gZCJ+66eBSOnUVLo9HJWi4y
 uIIM+QMJYOVaGq/nq8FbxNCFOhq3u0avuikzhXy4w2uQxoqbAt+UQop7VjiYs+qFn0gZ
 HRrLaJRnMyJsKQPYeAP/VmA2QcAIpqTWniZWSZz6My3M/R6TFBYgUaJZQglzoT5CX6iA
 apB2uYt1Yw2sXVCFsSLCzocCR0N6ZQ3imhRqLPQIrIc18iY+qmi5uWODOTfp8pmVFxeB 8Q== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bs4f1we3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Oct 2021 07:50:47 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19IBm54K028251;
        Mon, 18 Oct 2021 11:50:46 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3bqpc9mhs5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Oct 2021 11:50:46 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19IBog5b60162498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Oct 2021 11:50:42 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69C29A406D;
        Mon, 18 Oct 2021 11:50:42 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0555EA406B;
        Mon, 18 Oct 2021 11:50:42 +0000 (GMT)
Received: from li-748c07cc-28e5-11b2-a85c-e3822d7eceb3.ibm.com (unknown [9.171.41.253])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 18 Oct 2021 11:50:41 +0000 (GMT)
Message-ID: <2b1b939e1ea960c2268791f3007305955a70a90f.camel@linux.ibm.com>
Subject: Re: [PATCH] s390: replace snprintf in show functions with sysfs_emit
From:   Vineeth Vijayan <vneethv@linux.ibm.com>
To:     Qing Wang <wangqing@vivo.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Oct 2021 13:50:41 +0200
In-Reply-To: <1634280655-4908-1-git-send-email-wangqing@vivo.com>
References: <1634280655-4908-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PIuZuRuDfp2gXBuhMaTSNhhJ-2DYTXRQ
X-Proofpoint-ORIG-GUID: PIuZuRuDfp2gXBuhMaTSNhhJ-2DYTXRQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-18_03,2021-10-14_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 phishscore=0 bulkscore=0 impostorscore=0
 clxscore=1011 spamscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110180071
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Thanks.
Acked-by: Vineeth Vijayan <vneethv@linux.ibm.com>  

(For the CIO part.)


On Thu, 2021-10-14 at 23:50 -0700, Qing Wang wrote:
> show() must not use snprintf() when formatting the value to be
> returned to user space.
> 
> Fix the coccicheck warnings:
> WARNING: use scnprintf or sprintf.
> 
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
> 
> Signed-off-by: Qing Wang <wangqing@vivo.com>
> ---
>  drivers/s390/block/dasd_devmap.c | 74 ++++++++++++++++++++--------
> ------------
>  drivers/s390/char/raw3270.c      |  6 ++--
>  drivers/s390/cio/chp.c           |  2 +-
>  3 files changed, 41 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/s390/block/dasd_devmap.c
> b/drivers/s390/block/dasd_devmap.c
> index 2c40fe1..78eb479 100644
> --- a/drivers/s390/block/dasd_devmap.c
> +++ b/drivers/s390/block/dasd_devmap.c
> @@ -731,7 +731,7 @@ static ssize_t dasd_ff_show(struct device *dev,
> struct device_attribute *attr,
>  		ff_flag = (devmap->features & DASD_FEATURE_FAILFAST) !=
> 0;
>  	else
>  		ff_flag = (DASD_FEATURE_DEFAULT &
> DASD_FEATURE_FAILFAST) != 0;
> -	return snprintf(buf, PAGE_SIZE, ff_flag ? "1\n" : "0\n");
> +	return sysfs_emit(buf, ff_flag ? "1\n" : "0\n");
>  }
>  
>  static ssize_t dasd_ff_store(struct device *dev, struct
> device_attribute *attr,
> @@ -773,7 +773,7 @@ dasd_ro_show(struct device *dev, struct
> device_attribute *attr, char *buf)
>  	spin_unlock(&dasd_devmap_lock);
>  
>  out:
> -	return snprintf(buf, PAGE_SIZE, ro_flag ? "1\n" : "0\n");
> +	return sysfs_emit(buf, ro_flag ? "1\n" : "0\n");
>  }
>  
>  static ssize_t
> @@ -834,7 +834,7 @@ dasd_erplog_show(struct device *dev, struct
> device_attribute *attr, char *buf)
>  		erplog = (devmap->features & DASD_FEATURE_ERPLOG) != 0;
>  	else
>  		erplog = (DASD_FEATURE_DEFAULT & DASD_FEATURE_ERPLOG)
> != 0;
> -	return snprintf(buf, PAGE_SIZE, erplog ? "1\n" : "0\n");
> +	return sysfs_emit(buf, erplog ? "1\n" : "0\n");
>  }
>  
>  static ssize_t
> @@ -1033,13 +1033,13 @@ dasd_discipline_show(struct device *dev,
> struct device_attribute *attr,
>  		dasd_put_device(device);
>  		goto out;
>  	} else {
> -		len = snprintf(buf, PAGE_SIZE, "%s\n",
> +		len = sysfs_emit(buf, "%s\n",
>  			       device->discipline->name);
>  		dasd_put_device(device);
>  		return len;
>  	}
>  out:
> -	len = snprintf(buf, PAGE_SIZE, "none\n");
> +	len = sysfs_emit(buf, "none\n");
>  	return len;
>  }
>  
> @@ -1056,30 +1056,30 @@ dasd_device_status_show(struct device *dev,
> struct device_attribute *attr,
>  	if (!IS_ERR(device)) {
>  		switch (device->state) {
>  		case DASD_STATE_NEW:
> -			len = snprintf(buf, PAGE_SIZE, "new\n");
> +			len = sysfs_emit(buf, "new\n");
>  			break;
>  		case DASD_STATE_KNOWN:
> -			len = snprintf(buf, PAGE_SIZE, "detected\n");
> +			len = sysfs_emit(buf, "detected\n");
>  			break;
>  		case DASD_STATE_BASIC:
> -			len = snprintf(buf, PAGE_SIZE, "basic\n");
> +			len = sysfs_emit(buf, "basic\n");
>  			break;
>  		case DASD_STATE_UNFMT:
> -			len = snprintf(buf, PAGE_SIZE,
> "unformatted\n");
> +			len = sysfs_emit(buf, "unformatted\n");
>  			break;
>  		case DASD_STATE_READY:
> -			len = snprintf(buf, PAGE_SIZE, "ready\n");
> +			len = sysfs_emit(buf, "ready\n");
>  			break;
>  		case DASD_STATE_ONLINE:
> -			len = snprintf(buf, PAGE_SIZE, "online\n");
> +			len = sysfs_emit(buf, "online\n");
>  			break;
>  		default:
> -			len = snprintf(buf, PAGE_SIZE, "no stat\n");
> +			len = sysfs_emit(buf, "no stat\n");
>  			break;
>  		}
>  		dasd_put_device(device);
>  	} else
> -		len = snprintf(buf, PAGE_SIZE, "unknown\n");
> +		len = sysfs_emit(buf, "unknown\n");
>  	return len;
>  }
>  
> @@ -1120,7 +1120,7 @@ static ssize_t dasd_vendor_show(struct device
> *dev,
>  	device = dasd_device_from_cdev(to_ccwdev(dev));
>  	vendor = "";
>  	if (IS_ERR(device))
> -		return snprintf(buf, PAGE_SIZE, "%s\n", vendor);
> +		return sysfs_emit(buf, "%s\n", vendor);
>  
>  	if (device->discipline && device->discipline->get_uid &&
>  	    !device->discipline->get_uid(device, &uid))
> @@ -1128,7 +1128,7 @@ static ssize_t dasd_vendor_show(struct device
> *dev,
>  
>  	dasd_put_device(device);
>  
> -	return snprintf(buf, PAGE_SIZE, "%s\n", vendor);
> +	return sysfs_emit(buf, "%s\n", vendor);
>  }
>  
>  static DEVICE_ATTR(vendor, 0444, dasd_vendor_show, NULL);
> @@ -1148,7 +1148,7 @@ dasd_uid_show(struct device *dev, struct
> device_attribute *attr, char *buf)
>  	device = dasd_device_from_cdev(to_ccwdev(dev));
>  	uid_string[0] = 0;
>  	if (IS_ERR(device))
> -		return snprintf(buf, PAGE_SIZE, "%s\n", uid_string);
> +		return sysfs_emit(buf, "%s\n", uid_string);
>  
>  	if (device->discipline && device->discipline->get_uid &&
>  	    !device->discipline->get_uid(device, &uid)) {
> @@ -1183,7 +1183,7 @@ dasd_uid_show(struct device *dev, struct
> device_attribute *attr, char *buf)
>  	}
>  	dasd_put_device(device);
>  
> -	return snprintf(buf, PAGE_SIZE, "%s\n", uid_string);
> +	return sysfs_emit(buf, "%s\n", uid_string);
>  }
>  static DEVICE_ATTR(uid, 0444, dasd_uid_show, NULL);
>  
> @@ -1201,7 +1201,7 @@ dasd_eer_show(struct device *dev, struct
> device_attribute *attr, char *buf)
>  		eer_flag = dasd_eer_enabled(devmap->device);
>  	else
>  		eer_flag = 0;
> -	return snprintf(buf, PAGE_SIZE, eer_flag ? "1\n" : "0\n");
> +	return sysfs_emit(buf, eer_flag ? "1\n" : "0\n");
>  }
>  
>  static ssize_t
> @@ -1243,7 +1243,7 @@ dasd_expires_show(struct device *dev, struct
> device_attribute *attr, char *buf)
>  	device = dasd_device_from_cdev(to_ccwdev(dev));
>  	if (IS_ERR(device))
>  		return -ENODEV;
> -	len = snprintf(buf, PAGE_SIZE, "%lu\n", device-
> >default_expires);
> +	len = sysfs_emit(buf, "%lu\n", device->default_expires);
>  	dasd_put_device(device);
>  	return len;
>  }
> @@ -1283,7 +1283,7 @@ dasd_retries_show(struct device *dev, struct
> device_attribute *attr, char *buf)
>  	device = dasd_device_from_cdev(to_ccwdev(dev));
>  	if (IS_ERR(device))
>  		return -ENODEV;
> -	len = snprintf(buf, PAGE_SIZE, "%lu\n", device-
> >default_retries);
> +	len = sysfs_emit(buf, "%lu\n", device->default_retries);
>  	dasd_put_device(device);
>  	return len;
>  }
> @@ -1324,7 +1324,7 @@ dasd_timeout_show(struct device *dev, struct
> device_attribute *attr,
>  	device = dasd_device_from_cdev(to_ccwdev(dev));
>  	if (IS_ERR(device))
>  		return -ENODEV;
> -	len = snprintf(buf, PAGE_SIZE, "%lu\n", device->blk_timeout);
> +	len = sysfs_emit(buf, "%lu\n", device->blk_timeout);
>  	dasd_put_device(device);
>  	return len;
>  }
> @@ -1398,11 +1398,11 @@ static ssize_t dasd_hpf_show(struct device
> *dev, struct device_attribute *attr,
>  		return -ENODEV;
>  	if (!device->discipline || !device->discipline->hpf_enabled) {
>  		dasd_put_device(device);
> -		return snprintf(buf, PAGE_SIZE, "%d\n", dasd_nofcx);
> +		return sysfs_emit(buf, "%d\n", dasd_nofcx);
>  	}
>  	hpf = device->discipline->hpf_enabled(device);
>  	dasd_put_device(device);
> -	return snprintf(buf, PAGE_SIZE, "%d\n", hpf);
> +	return sysfs_emit(buf, "%d\n", hpf);
>  }
>  
>  static DEVICE_ATTR(hpf, 0444, dasd_hpf_show, NULL);
> @@ -1416,13 +1416,13 @@ static ssize_t
> dasd_reservation_policy_show(struct device *dev,
>  
>  	devmap = dasd_find_busid(dev_name(dev));
>  	if (IS_ERR(devmap)) {
> -		rc = snprintf(buf, PAGE_SIZE, "ignore\n");
> +		rc = sysfs_emit(buf, "ignore\n");
>  	} else {
>  		spin_lock(&dasd_devmap_lock);
>  		if (devmap->features & DASD_FEATURE_FAILONSLCK)
> -			rc = snprintf(buf, PAGE_SIZE, "fail\n");
> +			rc = sysfs_emit(buf, "fail\n");
>  		else
> -			rc = snprintf(buf, PAGE_SIZE, "ignore\n");
> +			rc = sysfs_emit(buf, "ignore\n");
>  		spin_unlock(&dasd_devmap_lock);
>  	}
>  	return rc;
> @@ -1457,14 +1457,14 @@ static ssize_t
> dasd_reservation_state_show(struct device *dev,
>  
>  	device = dasd_device_from_cdev(to_ccwdev(dev));
>  	if (IS_ERR(device))
> -		return snprintf(buf, PAGE_SIZE, "none\n");
> +		return sysfs_emit(buf, "none\n");
>  
>  	if (test_bit(DASD_FLAG_IS_RESERVED, &device->flags))
> -		rc = snprintf(buf, PAGE_SIZE, "reserved\n");
> +		rc = sysfs_emit(buf, "reserved\n");
>  	else if (test_bit(DASD_FLAG_LOCK_STOLEN, &device->flags))
> -		rc = snprintf(buf, PAGE_SIZE, "lost\n");
> +		rc = sysfs_emit(buf, "lost\n");
>  	else
> -		rc = snprintf(buf, PAGE_SIZE, "none\n");
> +		rc = sysfs_emit(buf, "none\n");
>  	dasd_put_device(device);
>  	return rc;
>  }
> @@ -1531,7 +1531,7 @@ dasd_path_threshold_show(struct device *dev,
>  	device = dasd_device_from_cdev(to_ccwdev(dev));
>  	if (IS_ERR(device))
>  		return -ENODEV;
> -	len = snprintf(buf, PAGE_SIZE, "%lu\n", device->path_thrhld);
> +	len = sysfs_emit(buf, "%lu\n", device->path_thrhld);
>  	dasd_put_device(device);
>  	return len;
>  }
> @@ -1578,7 +1578,7 @@ dasd_path_autodisable_show(struct device *dev,
>  	else
>  		flag = (DASD_FEATURE_DEFAULT &
>  			DASD_FEATURE_PATH_AUTODISABLE) != 0;
> -	return snprintf(buf, PAGE_SIZE, flag ? "1\n" : "0\n");
> +	return sysfs_emit(buf, flag ? "1\n" : "0\n");
>  }
>  
>  static ssize_t
> @@ -1616,7 +1616,7 @@ dasd_path_interval_show(struct device *dev,
>  	device = dasd_device_from_cdev(to_ccwdev(dev));
>  	if (IS_ERR(device))
>  		return -ENODEV;
> -	len = snprintf(buf, PAGE_SIZE, "%lu\n", device->path_interval);
> +	len = sysfs_emit(buf, "%lu\n", device->path_interval);
>  	dasd_put_device(device);
>  	return len;
>  }
> @@ -1662,9 +1662,9 @@ dasd_device_fcs_show(struct device *dev, struct
> device_attribute *attr,
>  		return -ENODEV;
>  	fc_sec = dasd_path_get_fcs_device(device);
>  	if (fc_sec == -EINVAL)
> -		rc = snprintf(buf, PAGE_SIZE, "Inconsistent\n");
> +		rc = sysfs_emit(buf, "Inconsistent\n");
>  	else
> -		rc = snprintf(buf, PAGE_SIZE, "%s\n",
> dasd_path_get_fcs_str(fc_sec));
> +		rc = sysfs_emit(buf, "%s\n",
> dasd_path_get_fcs_str(fc_sec));
>  	dasd_put_device(device);
>  
>  	return rc;
> @@ -1677,7 +1677,7 @@ dasd_path_fcs_show(struct kobject *kobj, struct
> kobj_attribute *attr, char *buf)
>  	struct dasd_path *path = to_dasd_path(kobj);
>  	unsigned int fc_sec = path->fc_security;
>  
> -	return snprintf(buf, PAGE_SIZE, "%s\n",
> dasd_path_get_fcs_str(fc_sec));
> +	return sysfs_emit(buf, "%s\n", dasd_path_get_fcs_str(fc_sec));
>  }
>  
>  static struct kobj_attribute path_fcs_attribute =
> @@ -1698,7 +1698,7 @@ static ssize_t dasd_##_name##_show(struct
> device *dev,			\
>  		val = _func(device);					
> \
>  	dasd_put_device(device);					\
>  									
> \
> -	return snprintf(buf, PAGE_SIZE, "%d\n", val);			
> \
> +	return sysfs_emit(buf, "%d\n", val);			\
>  }									
> \
>  static DEVICE_ATTR(_name, 0444, dasd_##_name##_show, NULL);		
> \
>  
> diff --git a/drivers/s390/char/raw3270.c
> b/drivers/s390/char/raw3270.c
> index 646ec796..be8529f 100644
> --- a/drivers/s390/char/raw3270.c
> +++ b/drivers/s390/char/raw3270.c
> @@ -1047,7 +1047,7 @@ raw3270_probe (struct ccw_device *cdev)
>  static ssize_t
>  raw3270_model_show(struct device *dev, struct device_attribute
> *attr, char *buf)
>  {
> -	return snprintf(buf, PAGE_SIZE, "%i\n",
> +	return sysfs_emit(buf, "%i\n",
>  			((struct raw3270 *) dev_get_drvdata(dev))-
> >model);
>  }
>  static DEVICE_ATTR(model, 0444, raw3270_model_show, NULL);
> @@ -1055,7 +1055,7 @@ static DEVICE_ATTR(model, 0444,
> raw3270_model_show, NULL);
>  static ssize_t
>  raw3270_rows_show(struct device *dev, struct device_attribute *attr,
> char *buf)
>  {
> -	return snprintf(buf, PAGE_SIZE, "%i\n",
> +	return sysfs_emit(buf, "%i\n",
>  			((struct raw3270 *) dev_get_drvdata(dev))-
> >rows);
>  }
>  static DEVICE_ATTR(rows, 0444, raw3270_rows_show, NULL);
> @@ -1063,7 +1063,7 @@ static DEVICE_ATTR(rows, 0444,
> raw3270_rows_show, NULL);
>  static ssize_t
>  raw3270_columns_show(struct device *dev, struct device_attribute
> *attr, char *buf)
>  {
> -	return snprintf(buf, PAGE_SIZE, "%i\n",
> +	return sysfs_emit(buf, "%i\n",
>  			((struct raw3270 *) dev_get_drvdata(dev))-
> >cols);
>  }
>  static DEVICE_ATTR(columns, 0444, raw3270_columns_show, NULL);
> diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
> index 1097e76..5440f28 100644
> --- a/drivers/s390/cio/chp.c
> +++ b/drivers/s390/cio/chp.c
> @@ -285,7 +285,7 @@ static ssize_t chp_configure_show(struct device
> *dev,
>  	if (status < 0)
>  		return status;
>  
> -	return snprintf(buf, PAGE_SIZE, "%d\n", status);
> +	return sysfs_emit(buf, "%d\n", status);
>  }
>  
>  static int cfg_wait_idle(void);

