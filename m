Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A76438014;
	Wed, 12 Aug 2026 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786557503; cv=none; b=CHDYu+lvRwWd8e3gorX7A4+AGJEbIb5+KIwLoVqZjXFezYJi0o3riR1PxQggACv1he1gzZGeoU00s3rmfTusEAIDNXwi3Hbj/r4q5UHTy7C4iUSOfGRBFNtCXxDv/8KFWL19dEmJ812oFohH8fW8wCZcmRGz/8kTduh+jcQocMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786557503; c=relaxed/simple;
	bh=CS8f456XcTsEc8HiAc0cl4WvdVJh99a6wY9zSBLtLRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=txKpPwkmqgfoPwdi3A1qUAVFoIPX9fkEe3J0EuDYCGzegjYnm2trORM/RnZZz8cJZmJ9WloeEFehZhp7zceSnLsPWejXt6Cy/vOuXvhEKG8P0YxqyVGHopAndcjkBAOdMbV70ghEd2vGtKe2sFxd0s24IAiSVEu7tck66RlLerQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gp7SpOzu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gp7SpOzu"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CH1nFW2985647;
	Wed, 12 Aug 2026 17:58:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3JVjrH
	jY8YwZhfTaDPuid+4Nv88JlEt8UQuiRwWih8g=; b=gp7SpOzuJizbJPuIxCiiF+
	4mpXdEbmr6lye/dEIXb15WJ9zPiZQB1kIEeRkyupDWxjSQBoCUA/0ECmDyqMBXwg
	q3hbMRsvzVC7SBwBD39P/EJAGK6pDutG4JiQe4GFAWne2h26UOijK9ntnY+oS6Jl
	iZIAPVpwCm3DpB6q095lCQigzD/vwPPMnn0N7DkVpdQNnHB8zftfZRyyzM+AKXs1
	mHfiLyujD1MtJ68KP/URCOguEelnu7WIl/Ja9NPwWIRxa+zLfVDoe0MXlncyJpPj
	22BbcLitdtgJkxem0Mh8LNaNKni/xAjrQQmliEW+52mOgdwQOxneySRwuVN6MiOQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23vd5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 17:58:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CHuMM8015720;
	Wed, 12 Aug 2026 17:58:08 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy735f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 17:58:08 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CHw7k924248944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 17:58:07 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6A0E58061;
	Wed, 12 Aug 2026 17:58:07 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93AB158056;
	Wed, 12 Aug 2026 17:58:06 +0000 (GMT)
Received: from [9.61.74.89] (unknown [9.61.74.89])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 17:58:06 +0000 (GMT)
Message-ID: <ee819372-edee-445a-8373-138040c51a28@linux.ibm.com>
Date: Wed, 12 Aug 2026 13:58:06 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9] s390/vfio-ap: Fix NULL deref in status_show()
 during queue probe
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        stable@vger.kernel.org
References: <20260812170945.738351-1-akrowiak@linux.ibm.com>
 <20260812170945.738351-9-akrowiak@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260812170945.738351-9-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7cb431 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=bFAEpDOKK8sSTV94CGcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE0MiBTYWx0ZWRfX5QMcnOopf4Gb
 SIpoNzdhEMy0nUdnFXLfjESnoQKThS1VxzyVCyFPXygaVc4GxvPgnLYY9dA5694yUWW2OLYIhzN
 tNC6wbyibPlAi0uncWdIsihugWVKNb8+YkjEQDCajbs8CXxmUx9pJV2HSKZfbUBo8+Rzf54PLZU
 qoqKX8ORALF0pERytPZPTUqI/IHxor95D1oOQBGNfSo6lZ30c702SOuiK+qNKYONKpwXVcUaWV/
 poZHGWs/IjyNRA6wY0YYtVoLoPEz8mLYEg0eelWUkqL5XQc0SeaVx+J/171IaY9a47T24M4gf5c
 nu+B2Xw3/R0L7enNhO9ZLntZcRbiK42hxOWzqizea580MTD1IMBAjiF/+g0tD7FgHGV5oJGub7a
 Dkd7ufT9wsTiViN2Ib6x3sPU6bSJO+v7l/IqwIlYeLJMomIo/urNyiK84UPZk2EmNr0gWy4w7JG
 7VVeUHRHEQbrBNEicSw==
X-Proofpoint-ORIG-GUID: M-G0qlt-YSFuzhp-Ue06Z62Vg3rVhhhW
X-Proofpoint-GUID: M-G0qlt-YSFuzhp-Ue06Z62Vg3rVhhhW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE0MiBTYWx0ZWRfX0wSCFs4IVWyN
 VUNxMk1lz68c3uIiQfEI8nZlBkkVqCphyjt+n3aDKfTnBMWGL9xw9B8yWpmUSps4NwAjTnhXrcI
 x0BsWbQv4xrPgYLsJEFw3Ic7Xi67H0Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120142

On 8/12/26 1:09 PM, Anthony Krowiak wrote:
> When vfio_ap_mdev_probe_queue() creates the sysfs attribute group,
> the queue's driver data has not yet been set. A concurrent read of
> the 'status' attribute can therefore call dev_get_drvdata() and
> get NULL, which is then passed directly to
> vfio_ap_mdev_for_queue() where q->apqn is unconditionally
> dereferenced, causing a NULL pointer dereference.
> 
> Fix this by acquiring the update locks before calling
> sysfs_create_group(). The status_show() function acquires
> guests_lock before reading the driver data, so any concurrent
> read will block until after dev_set_drvdata() has been called
> and the update locks are released.
> 
> As a bonus, the APQN no longer needs to be read from the queue
> struct after allocation — it can be read directly from apdev
> before allocation and stored in a local variable, which is then
> assigned to q->apqn once the allocation succeeds.
> 
> Fixes: 260f3ea141382 ("s390/vfio-ap: move probe and remove callbacks to vfio_ap_ops.c")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 16779cfc64e8..b0454a296c67 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -2424,14 +2424,17 @@ void vfio_ap_mdev_unregister(void)
>  
>  int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
>  {
> -	int ret;
> +	int ret, apqn;
>  	struct vfio_ap_queue *q;
>  	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
>  	struct ap_matrix_mdev *matrix_mdev;
>  
> +	apqn = to_ap_queue(&apdev->device)->qid;
> +	matrix_mdev = get_update_locks_by_apqn(apqn);
> +
>  	ret = sysfs_create_group(&apdev->device.kobj, &vfio_queue_attr_group);
>  	if (ret)
> -		return ret;
> +		goto err_release_locks;
>  
>  	q = kzalloc_obj(*q);
>  	if (!q) {
> @@ -2439,11 +2442,10 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
>  		goto err_remove_group;
>  	}
>  
> -	q->apqn = to_ap_queue(&apdev->device)->qid;
> +	q->apqn = apqn;
>  	q->saved_isc = VFIO_AP_ISC_INVALID;
>  	memset(&q->reset_status, 0, sizeof(q->reset_status));
>  	INIT_WORK(&q->reset_work, apq_reset_check);
> -	matrix_mdev = get_update_locks_by_apqn(q->apqn);
>  
>  	if (matrix_mdev) {
>  		vfio_ap_mdev_link_queue(matrix_mdev, q);
> @@ -2472,8 +2474,13 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
>  	return ret;
>  
>  err_remove_group:
> +	release_update_locks_for_mdev(matrix_mdev);

I think now you've just shrunk the window instead of totally closed it?

Can't sysfs still be accessed between this release and the remove_group?

Do you think adding an additional NULL check against dev_get_drvdata()
in status_show() and treating the NULL case like the other error
conditions would be enough to cover that window? 


