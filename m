Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1841951A751;
	Fri,  4 Sep 2026 18:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788546629; cv=none; b=tpKRpk6NFlMrKC167G2Zvnai7grYt0Gt/NGyGf+/d4j+f2Qvb8MF8D2xhmtHsrBoqiHg2CTE9ARgM6azoAs+ChemaoKxRji1NuIswcrdbuxYVjX9aAlnDAwRCFQPZvJMHzRyiRn//682i4mr3Nt0bwHIOZJGqZhnrUrPpCHCZD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788546629; c=relaxed/simple;
	bh=M2vlvbqRWV+Xw+3jTt9UAjlcZl7+IruDbCiA5qjhmKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GtY3tg+nptbdnYpPnNuYnip147ptac90RS8CBxUm/0ERKsUnioEs8WWodmqYF9aR3bRKe49K/A5AMOc2tYSdBKRwFADrptzeFExWdiizs3kP97pG4GfshaGIOa2ciOKZy+5ljBXhIy3IYlTbfubV3wkCyUEsJ8qf2asisREpD7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bvATyraG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bvATyraG"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684HWEVA1236999;
	Fri, 4 Sep 2026 18:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Cuu3MZ
	daGvzuxmWskN/PqNsPVmmgkPsY77OJwg3BoiI=; b=bvATyraGfJj4p5w1iT7dbW
	vsYCUL1y9tP9SHmO8ydRSStirU10l+naDNDmSE02Q0sqYN9AFnJGPAQ+0rhCZXlJ
	ybZ7/1TG/qb8GBNN9+gnM/1vC/dgsuittmPXAfPwGLf6HrEYHwbKfpyY5H/19DuT
	s+VkaNRiqT+aWazOapfdSHmU/jxhTpfQNSX5rSbWskmWlf5BoewdKvlGFRohUp+i
	O2sGkKeDn1EjhUBt4/qy0qDmQVp0Kp0XMVyePncwxVfo9MsM83MJ+ULK/35JPXh8
	WjqiZ0tgRMrrRp2FtuLeA7eSJQlD6Rk3kq12gw9iqHGmTRYL5cL7yedkR9our6aQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnuec1ph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 18:30:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 684IQGwc014499;
	Fri, 4 Sep 2026 18:30:23 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarkpmd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 18:30:23 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 684IUML432178796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 18:30:22 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7623458056;
	Fri,  4 Sep 2026 18:30:22 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E192758062;
	Fri,  4 Sep 2026 18:30:21 +0000 (GMT)
Received: from [9.61.80.215] (unknown [9.61.80.215])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Sep 2026 18:30:21 +0000 (GMT)
Message-ID: <386bc4c0-6693-4612-8103-11f919fed342@linux.ibm.com>
Date: Fri, 4 Sep 2026 14:30:21 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] s390/vfio-ap: Fix unbounded loop in
 apq_reset_check()
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>, kvm@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org
References: <20260904093435.1161402-1-akrowiak@linux.ibm.com>
 <20260904093435.1161402-4-akrowiak@linux.ibm.com>
 <20260904094839.1E72F1F00A3D@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260904094839.1E72F1F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -WFZ2K9iVmQYT9WoxtusHiwsKpvPAMwS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE2NCBTYWx0ZWRfX3FCg3gvLoG8B
 1N65VbvmneLwlFZNHH9LK4AbpAFD4l5r+V8GmjQv6bICf57r3wzzptp8JijKcg7vTY718/b6/A9
 J6vgibXowTG2S1xz2J1ijNYGl65fTmJMUkLhTy7YoEsFLpHOjB5jqmHC5F5qJFlu+cdwZFcEYFf
 hz7L5xhsRVjXpKBgeIgpneeW5Bx39e/vyf9AS5PYWL+IkpE4k3L5uuxXQzInR9BlmWXnrJJMjBd
 YvuXBOvD0Huhf2qpgHyP8KtN2SOt1/ccJgrn7b71tqTu9al9sDMHtR58K2ewFWDwmFwyhfI3hTI
 D9hBKjEci0Ih+NfjATbI1tLmTjDoFOi9xM8yPg7+pNBoBl+2vZPoFngMjq3hgQopP6iBysdX07L
 r3vaAkaTO+nwYbY5NRFfuhccEumGzIGTSAkNnxKhgjfHKArygFlvHApwy8a9WLZb49tXKHXmsNc
 uafFfT+2raluioj/yIw==
X-Proofpoint-ORIG-GUID: -WFZ2K9iVmQYT9WoxtusHiwsKpvPAMwS
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE2NCBTYWx0ZWRfX6ODom1UYE6Rm
 ss8UKx3eJjrvkmaRV8FCOkJNU0PR1wDuq0CwEk4d0OD7PlAdMC3lcbAY3jOQtEzjY9vucbbKai5
 R3DddPHrB/x06sR65uiH2DZZDQuhmcI=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a9b0e41 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=l8z-qHihChIYEk0EtGUA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040164



On 9/4/26 5:48 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> New issues:
> - [High] Dangling AQIC resources after a reset timeout cause arbitrary IOVA unpinning in a subsequent guest's VFIO container.
>
> Pre-existing issues:
> - [High] Early return on an unknown hardware response code (-EIO) silently leaks AQIC resources and fails to update the queue's reset status.
> --
>
> commit fec86a42ae1833abad22bf816bcbaaa29965a88e
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
> s390/vfio-ap: Fix unbounded loop in apq_reset_check()
>
> This commit fixes an unbounded loop in the queue reset worker by introducing a
> maximum wait time of 2000ms. It also adds logic to verify the asynchronous
> completion of queue zeroization and intentionally leaks AQIC resources on
> timeout to avoid a potential host crash from wild DMA writes.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index ea0625f10c7e8..32b80d91a6431 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> [ ... ]
>
>> @@ -2050,6 +2113,54 @@ static void apq_reset_check(struct work_struct *reset_work)
>>   		ret = apq_status_check(q->apqn, &status);
>>   		if (ret == -EIO)
>>   			return;
> [Severity: High]
> This is a pre-existing issue, but does this early return on an unknown
> hardware response code (-EIO) silently leak AQIC resources?

This will be fixed in patch 1 of the next (v6) of the patch series.

>
> By returning immediately, this path bypasses the resource cleanup in
> vfio_ap_free_aqic_resources(). This leaves q->saved_iova dangling and fails
> to update q->reset_status.response_code.
>
> Since the status remains 0 (AP_RESPONSE_NORMAL), callers might incorrectly
> believe the queue is securely zeroed. If the queue is then reassigned to a
> new guest, could the next successful reset unpin the old IOVA from the new
> guest's IOMMU domain and corrupt memory?
>
>> +		if (elapsed >= AP_RESET_MAX_WAIT) {
>> +			/*
>> +			 * Zeroization confirmed (ret == 0): the TAPQ status bits
>> +			 * indicate the async portion of the ZAPQ completed
>> +			 * successfully. Free AQIC resources and return.
>> +			 *
>> +			 * Queue non-operational (ret == -ENODEV): the queue is
>> +			 * deconfigured or checkstopped; interrupts are not
>> +			 * possible so AQIC resources can be safely freed.
>> +			 * Zeroization cannot be confirmed in this state, but the
>> +			 * queue cannot generate interrupts, so the NIB page is
>> +			 * no longer a DMA target and it is safe to free it.
>> +			 */
>> +			if (!ret || ret == -ENODEV)
>> +				goto done;
>> +			/*
>> +			 * Timed out without being able to verify zapq completed.
>> +			 *
>> +			 * The AQIC resources associated with this queue - the pinned
>> +			 * page containing the NIB and the registered guest ISC -
>> +			 * cannot be freed here. The NIB is the active DMA target
>> +			 * for AP interrupt delivery until the reset completes;
>> +			 * freeing the pinned page while the hardware may still
>> +			 * write to it would result in a wild DMA write that could
>> +			 * corrupt host memory.
>> +			 *
>> +			 * If the reset eventually completes, interrupts will be
>> +			 * terminated and the pinned NIB page and ISC registration
>> +			 * will be leaked. This is preferable to either a wild DMA
>> +			 * write or waiting indefinitely: flush_work() callers hold
>> +			 * the matrix_dev->mdevs_lock mutex which serializes access
>> +			 * to all mdev objects system-wide, so blocking here would
>> +			 * hang all guests to which those mdevs are attached.
>> +			 */
>> +			report_aqic_resource_leak(q);
>> +			/*
>> +			 * Report the actual non-zero hardware response code, or
>> +			 * synthesize AP_RESPONSE_RESET_IN_PROGRESS if TAPQ
>> +			 * completed normally but the status bits failed to
>> +			 * transition to their post-reset states.
>> +			 */
>> +			if (status.response_code == AP_RESPONSE_NORMAL)
>> +				q->reset_status.response_code = AP_RESPONSE_RESET_IN_PROGRESS;
>> +			else
>> +				q->reset_status.response_code = status.response_code;
>> +
>> +			return;
>> +		}
> [Severity: High]
> Does this early return on timeout leave dangling AQIC resources that could
> cause arbitrary IOVA unpinning in a subsequent guest's VFIO container?
>
> When the worker exits on timeout without clearing the dangling q->saved_iova
> field, and the adapter is unassigned from the current guest and hot-plugged
> into a new guest, q->matrix_mdev is updated to the new guest.
>
> When the new guest successfully resets the queue, vfio_ap_free_aqic_resources()
> will be called. Because q->matrix_mdev is now the new guest's mdev and
> q->saved_iova is still the old guest's IOVA, it seems this would erroneously
> unpin an arbitrary IOVA from the new guest's VFIO container:

The scenario described cannot occur. When the adapter is
unassigned from the mdev, unassign_adapter_store() calls
vfio_ap_mdev_hot_unplug_adapter() which calls
vfio_ap_mdev_hot_unplug_adapters(). That function calls
vfio_ap_mdev_unlink_adapter(), which removes the queue from
the mdev's hash table, but q->matrix_mdev is not set to NULL
until vfio_ap_unlink_mdev_fr_queue() is called later. Before
that, vfio_ap_mdev_reset_qlist() is called, which issues a
fresh ZAPQ for the queue while q->matrix_mdev is still valid.
If that ZAPQ completes successfully, vfio_ap_free_aqic_resources()
will correctly unpin the old NIB page and unregister the ISC
using the still-valid q->matrix_mdev. So while the reviewer
is correct that the AQIC resources are leaked by the timeout
path, they will be cleaned up by the ZAPQ issued during the
unassign, provided the reset succeeds at that point.

>
> vfio_ap_free_aqic_resources() {
>      ...
>      if (q->saved_iova && !WARN_ON(!q->matrix_mdev)) {
>          vfio_unpin_pages(&q->matrix_mdev->vdev, q->saved_iova, 1);
>          q->saved_iova = 0;
>      }
> }
>
> [ ... ]
>

