Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E164746B4;
	Thu, 13 Aug 2026 11:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786622121; cv=none; b=Wf9rGbtm37xijxsi6RR/hJ2sDgALmVENt3h2tR6vWoa9Y/bgTv0G8fsywha4uQ1DycSqtQ2A8kPzt+hbs8uVtPoc/Fv3S1QFxiRnOnX5DloFxWeorKktjiVyvvfyCVSTaAMEx1LSPVSlb6+//8lZF07aWQSMkndtymQlkLTQ9mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786622121; c=relaxed/simple;
	bh=8PcfYA86wvaPg8JqagrWUJ5kfbN2MMl7H4Axli79LNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TzFk7FBo0blGJbT94o3HGn2JtVaH50bw+xmOssRX1WWWddTVC1Uy4STmpUsSlucwCQaheaQ6EZKuR42e/AyuhWi5aVHwuQI4MocwTqyGe43Vnm5Af+l6vkFhGGsA3v9/eVk8leCQGr0TBa7pGh/R18o6nI/6UU8ObiM5BK5CjLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rApxB09L; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rApxB09L"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D98pp11916162;
	Thu, 13 Aug 2026 11:55:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JipJWS
	7cDeW1jAsDd4aDo4sm9o9IaQKPZ2SdhaQPZq8=; b=rApxB09LhnRoFHHe83dgir
	o42WsFcoqLfHNee+7mDansbVD7FQouYkfcMMCDBVWkkJNMBVoUGWYsKRe+QHiPgW
	wwE6R1jgfqogA4X5t3OhYT8NFhF1crcaX7mD2KvTSOSCLTAkjf8kUiSKZxVcZm3m
	rRPCwpwoCaj3UFZby2rJp1Hc2jkCDF2FWLH8/joNym7KMscqiPm42/UvenVTAuuD
	+LxDFqVPBw7ggktxO3V90bnz3zgD/YKJf4cmCzkkFmcvGy7np7iaC+JYCaYP2V/g
	y/+UKvSQ4uFvdNZYKdXKKESukV41pYLQ0UwO3qux5FLwSg+EGKvqSD0cNDSuhnYg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9yrmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 11:55:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DBfL2e017670;
	Thu, 13 Aug 2026 11:55:13 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9hat22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 11:55:13 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67DBtBmL23659186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 11:55:12 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A6BA58045;
	Thu, 13 Aug 2026 11:55:11 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F13BB58050;
	Thu, 13 Aug 2026 11:55:09 +0000 (GMT)
Received: from [9.61.3.203] (unknown [9.61.3.203])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Aug 2026 11:55:09 +0000 (GMT)
Message-ID: <e94dfa4a-e2b3-4cda-904a-ef571d2277db@linux.ibm.com>
Date: Wed, 12 Aug 2026 12:04:25 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/15] s390/vfio-ap: Callback to get/set vfio device
 mig state during guest migration
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-6-akrowiak@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20260807221834.562851-6-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA4MSBTYWx0ZWRfX2w2RoOsNRsJO
 zy4SQsNBjxTHcBv2EqXAwzF1BWfhfSv5EvoabZT2RDFSIqEkUixmC7rEzILCN1iB6cRuax4h6Gq
 IPqpUgmOtzZr/iNRblopZS9LH14xOMZ4/w68CJv/UFKEvQwrLkiKc2P6eY+pbqFUAjPEVlk/17W
 /+cis75XLIpRp5XRkeZrUgw0iPeLSl+FmLSiMbG00ge5EaAxK4OBgYTis+oz6UTv+Bqo1gP58OP
 alfY1KUy9gc7OAgG4vK9l16TnUorFuN5PDUOGLWTGV5+QrWEnT+u0E6YOU3aPGKYAdMUqT3/EsK
 YnzY8d3Hno3uYyXrewwvtvIBXpDmK/nbYUxteBDyGxPnULOYiWEy8OAX1tjBBubwsRRjdeP9aXe
 93u1Yxn1O6ZFKl7G0eh07UliSwXS0em1UXtxiO7h2S1selNPNPoCaD7fjHjz7MShPWy5zz/PEnU
 odfuqtHUI0dtBer9b1Q==
X-Proofpoint-ORIG-GUID: VnxFgVyCPhP2q2xF0VXf7bnsoTknamym
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA4MSBTYWx0ZWRfX+90hGFRshwFa
 IFy4E5GSufiwTLTwEWk2fdm4n3tz34Au1GcMOpyNPVwg5bI8NmQwnxvtV7m7tvPCU6gfACmhmdA
 ePiXgDjhulRy5sFinXyxfPzTcQnXobc=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7db0a2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=nxkqimRYtrKaij7qo54A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: VnxFgVyCPhP2q2xF0VXf7bnsoTknamym
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130081



On 8/7/26 6:18 PM, Anthony Krowiak wrote:
> Implements two callbacks related to the current state of a vfio-ap device:
> * The callback that sets a new migration state of a vfio-ap device during
>    live migration of guests with pass-through access to AP devices. This
>    callback is mandatory for VFIO_DEVICE_FEATURE_MIGRATION support.
> 
>    The function pointer for this callback is specified via the
>    'migration_set_state' field of the 'vfio_migration_ops' structure
>    which is stored with the VFIO device when the 'vfio_device'
>    structure representing the mediated device is initialized.
> 
> * The callback that returns the current vfio device migration state during
>    live migration of guests with pass-through access to AP devices.
> 
>    The function pointer for this callback is specified via the
>    'migration_get_state' field of the 'vfio_migration_ops' structure
>    which is stored with the VFIO device when the 'vfio_device'
>    structure representing the mediated device is initialized.
> 
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_migration.c | 130 +++++++++++++++++++++++-
>   1 file changed, 128 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
> index 1613813124b6..af740b177c97 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> @@ -128,16 +128,141 @@ static void vfio_ap_release_resuming_file(struct vfio_ap_migration_data *mig_dat
>   	 */
>   }
>   
> +static struct file *
> +vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
> +			    enum vfio_device_mig_state new_state)
> +{
> +	struct vfio_ap_migration_data *mig_data;
> +	enum vfio_device_mig_state cur_state;
> +
> +	lockdep_assert_held(&matrix_dev->mdevs_lock);
> +	mig_data = matrix_mdev->mig_data;
> +	cur_state = mig_data->mig_state;
> +	dev_dbg(matrix_mdev->vdev.dev, "%s: %d -> %d\n", __func__, cur_state,
> +		new_state);
> +
> +	if (cur_state == VFIO_DEVICE_STATE_STOP &&
> +	    new_state == VFIO_DEVICE_STATE_STOP_COPY) {
> +		/* TODO */
> +		return ERR_PTR(-EOPNOTSUPP);
> +	}
> +
> +	if (cur_state == VFIO_DEVICE_STATE_STOP &&
> +	    new_state == VFIO_DEVICE_STATE_RESUMING) {
> +		/* TODO */
> +		return ERR_PTR(-EOPNOTSUPP);
> +	}
> +
> +	if ((cur_state == VFIO_DEVICE_STATE_RESUMING &&
> +	     new_state == VFIO_DEVICE_STATE_STOP) ||
> +	    (cur_state == VFIO_DEVICE_STATE_STOP_COPY &&
> +	     new_state == VFIO_DEVICE_STATE_STOP)) {
> +		/* TODO */
> +		return ERR_PTR(-EOPNOTSUPP);
> +	}
> +
> +	if ((cur_state == VFIO_DEVICE_STATE_STOP &&
> +	     new_state == VFIO_DEVICE_STATE_RUNNING) ||
> +	    (cur_state == VFIO_DEVICE_STATE_RUNNING &&
> +	     new_state == VFIO_DEVICE_STATE_STOP)) {
> +		/* TODO */
> +		return ERR_PTR(-EOPNOTSUPP);
> +	}
> +
> +	/* vfio_mig_get_next_state() does not use arcs other than the above */
> +	WARN_ON(true);
> +
> +	return ERR_PTR(-EINVAL);
> +}
> +
>   static struct file *vfio_ap_set_state(struct vfio_device *vdev,
>   				      enum vfio_device_mig_state  new_state)
>   {
> -	return NULL;
> +	int ret;
> +	struct file *filp = NULL;
> +	struct ap_matrix_mdev *matrix_mdev;
> +	enum vfio_device_mig_state next_state;
> +	struct vfio_ap_migration_data *mig_data;
> +
> +	matrix_mdev = container_of(vdev, struct ap_matrix_mdev, vdev);

The container_of() pointer swizzle is done under lock in 
vfio_ap_get_state, but not here. Why? They should probably be handled 
consistently.

> +
> +	mutex_lock(&matrix_dev->mdevs_lock);
> +	if (ap_is_se_guest()) {
> +		dev_err_once(matrix_mdev->vdev.dev,
> +			     "Migration not allowed from or to a Secure Execution guest\n");
> +		mutex_unlock(&matrix_dev->mdevs_lock);
> +		return ERR_PTR(-EPERM);
> +	}
> +
> +	mig_data = matrix_mdev->mig_data;
> +
> +	/*
> +	 * The mig_data pointer is set in the vfio_ap_init_migration_data
> +	 * function which is called when the vfio-ap device fd is opened.
> +	 * Since the implicit pre-open state is RUNNING, a request to set
> +	 * RUNNING is a no-op. Any other state transition is invalid before
> +	 * open_device.
> +	 */
> +	if (!mig_data) {
> +		mutex_unlock(&matrix_dev->mdevs_lock);
> +		if (new_state == VFIO_DEVICE_STATE_RUNNING)
> +			return NULL;
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	dev_dbg(vdev->dev, "%s -> %d\n", __func__, new_state);
> +
> +	while (mig_data->mig_state != VFIO_DEVICE_STATE_ERROR &&
> +	       mig_data->mig_state != new_state) {
> +		ret = vfio_mig_get_next_state(vdev, mig_data->mig_state,
> +					      new_state, &next_state);
> +		if (ret) {
> +			filp = ERR_PTR(ret);
> +			break;
> +		}
> +
> +		filp = vfio_ap_transition_to_state(matrix_mdev, next_state);
> +		if (IS_ERR(filp))
> +			break;
> +
> +		mig_data->mig_state = next_state;
> +
> +		if (WARN_ON(filp && new_state != next_state)) {
> +			fput(filp);
> +			filp = ERR_PTR(-EINVAL);
> +			break;
> +		}
> +	}
> +
> +	mutex_unlock(&matrix_dev->mdevs_lock);
> +
> +	return filp;
>   }
>   
>   static int vfio_ap_get_state(struct vfio_device *vdev,
>   			     enum vfio_device_mig_state  *current_state)
>   {
> -	return -EOPNOTSUPP;
> +	struct ap_matrix_mdev *matrix_mdev;
> +	struct vfio_ap_migration_data *mig_data;
> +
> +	mutex_lock(&matrix_dev->mdevs_lock);
> +
> +	matrix_mdev = container_of(vdev, struct ap_matrix_mdev, vdev);
> +	mig_data =  matrix_mdev->mig_data;

Why bother with temp variable? You could just access 
matrix_mdev->mig_data directly.

> +
> +	/*
> +	 * The mig_data pointer is set in the vfio_ap_init_migration_data
> +	 * function which is called when the vfio-ap device fd is opened.
> +	 * If mig_data is NULL, report RUNNING as the implicit pre-open state
> +	 * so userspace doesn't need to perform any state transition before the
> +	 * device becomes active.
> +	 */
> +	*current_state = (mig_data) ? mig_data->mig_state :
> +				      VFIO_DEVICE_STATE_RUNNING;
> +
> +	mutex_unlock(&matrix_dev->mdevs_lock);
> +
> +	return 0;
>   }
>   
>   static int vfio_ap_get_data_size(struct vfio_device *vdev,
> @@ -159,6 +284,7 @@ static const struct vfio_migration_ops vfio_ap_migration_ops = {
>    */
>   void vfio_ap_init_migration_capabilities(struct ap_matrix_mdev *matrix_mdev)
>   {
> +	/* Live guest migration is not supported for SE guests */
>   	if (ap_is_se_guest())
>   		return;
>   

Comment is unrelated to the rest of the patch.

