Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EDA448BB6;
	Wed, 12 Aug 2026 21:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786569186; cv=none; b=ZRTd/dwYHjgJhBpH1xYCSzMnUDcRIkHgoQN8iOKLZmDPJz7gbuKYheZGKk0SaGYDPXGq2Lpd/dov8KM0Q9xMF1Xefn4YhdzgcyxAVqXXNbDRQHCNdJox9l5LqaIM82MeFYwL7Hy3gaBDt0LCTvTyXMnJqgi+B5pDeilZg2qWGoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786569186; c=relaxed/simple;
	bh=t2hipdhLAqrx2U/m7pKxsE3fCwds5gHPAbFOOeM0fEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YxKb0X1BwQ0BKOHKAiwUTTzrLy0jGTOQlotq0eGTp5VRCbyI+0O8fRHn3krQRYSEWrOqxpd3rSDF9LKz9/EF4wsYyPpAVBaA3Zf/73t35nDeeoKU+YCon6dwObJoRZAeGIBN7lhGfZscpEC3wfc7VzeMe+c4NvLHbj7vMuIuH90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OgqNNFOU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OgqNNFOU"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CK2fhc291853;
	Wed, 12 Aug 2026 21:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KZ6tVz
	cuFE6nUFMd/cTSJ3moUlVxh67EAVpRoeEwIN4=; b=OgqNNFOUqu4IJmenePlAas
	5p8Qq6HPKRQp9+GAzSqFbEOAMlKfEkJY651lOgOnlk/zKBwHfzCYdtUEEPh5V9Y6
	Qf8EPoOdSh+prpJIdrq/UsZKICbjAVJBT/Q+B+AAAypipNcYmqHazxA+4C6nf6/+
	FVHwelPCkciqxiEAOFldmDmLHbiJ55J42HDOF8eoEEl1gm4wh2eXGKWdmiP9Pb7a
	Y6h3jeknHuUbb922bkbWBL6Fj8I/vJZoU0tpjX11BiVbjrkIrrbo/vL7pXeMHUW5
	82mI9+YJOvxtFtINfarQJMajRq+k8OyZV6qIgAjxkRkUHKQ48bJPeZAO2qZwsAbA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9vuj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 21:12:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CLBLOs004991;
	Wed, 12 Aug 2026 21:12:54 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy7w3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 21:12:54 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CLCqnR18743974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 21:12:52 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AB7E58056;
	Wed, 12 Aug 2026 21:12:52 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45F165803F;
	Wed, 12 Aug 2026 21:12:51 +0000 (GMT)
Received: from [9.61.74.89] (unknown [9.61.74.89])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 21:12:51 +0000 (GMT)
Message-ID: <3f1e1e96-fa32-407a-816a-d884b97b9961@linux.ibm.com>
Date: Wed, 12 Aug 2026 17:12:50 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 9/9] s390/vfio-ap: Fix memory leak when queue removed
 from host AP config
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        stable@vger.kernel.org
References: <20260812200240.818004-1-akrowiak@linux.ibm.com>
 <20260812200240.818004-10-akrowiak@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260812200240.818004-10-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE2OSBTYWx0ZWRfX+UHXDWb1ZI5b
 ttkobz5oJeVnumZgo7tRSbiWJSrCpN4TLshByGJ7lFrXmUqhBCAThNsAaxDfOnAy4NiUr4Q1cen
 wdZcihwyzoKPOsJt6qSVbr66VIB1yKC0PlGBORnwWEnKHxfdk5zdbOFem9Z/ApBrxZsRwe2C+Ds
 rb13PSb7VjeZEZ7npkNCoVpgD5pip17doj1OslesJue9RNsJZGBhWyW0wZYtcVMLw81nGTTx9Fm
 SFU7hqFRAofxMjiNF+3Y8ufZXjQq6j5AOBtJw+sH4tmRu70cN4/b8eu6311Muw25gekH6ucmo6p
 r9XMwaPAo10D/wXxoQuybgpG73qUagMh5yfRteY5GvoIihBIEpJunFJ82yhg/jypQIykbaePw6A
 OKo7KefOLvBZ88fEFg0caUjNkwYiaZQccWZ2Nf2zd41JMPOlWCS6gXy0s9vN8p7U40Ze8erDohb
 69ieVyVZ2lKijFpm3aA==
X-Proofpoint-ORIG-GUID: 53vqnzjyGVjwhHyVf14DTv-a4sesPcQM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE2OSBTYWx0ZWRfX+MnxW1akEH6E
 EYf2pEC5keNrXpwjIrsR/J/7DRdsDxgP2WSITOX+o5d0HfkcH8DPCY0EnhIdIr2skZAj3vIHG9O
 5EDNdjHtuTYOl3it5T2TKy/HsFhk+dg=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7ce1d7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=yDRlaAsJfaUpi4EBaoEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 53vqnzjyGVjwhHyVf14DTv-a4sesPcQM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120169

On 8/12/26 4:02 PM, Anthony Krowiak wrote:
> When an adapter or domain is removed from the host's AP configuration, the
> AP bus invokes vfio_ap_on_cfg_changed() to notify the vfio_ap device
> driver. For each ap_matrix_mdev object to which the adapter or domain
> is assigned, vfio_ap_mdev_hot_unplug_cfg() is called and removes the
> adapter or domain from the matrix_mdev->shadow_apcb (i.e., the guest's AP
> configuration) and hot unplugs it if a guest is using it. The new host
> AP configuration (sans adapter or domain) is then stored in
> matrix_dev->info.
> 
> When the AP bus subsequently unbinds the physical queue devices associated
> with the adapter or domain that has been removed, it invokes
> vfio_ap_mdev_remove_queue() for each queue removed. At this point, the
> adapter or domain will no longer be assigned to the
> matrix_mdev->shadow_apcb or the matrix_dev->info object because they would
> have been removed by vfio_ap_on_cfg_changed(). Consequently,
> vfio_ap_mdev_reset_queue(q) is bypassed and kfree(q) is called
> without executing vfio_ap_free_aqic_resources(). This indefinitely pins
> guest memory (q->saved_iova) and leaks KVM GISC resources (q->saved_isc).
> 
> Note that resetting the queue would fail with an invalid APQN error due to
> the fact the queue is not longer in the host's AP configuration; however,
> it is still necessary to free the AQIC resources. The fix here is to call
> vfio_ap_free_aqic_resources if the adapter or domain is neither in
> matrix_mdev->shadow_apcb or matrix_dev->info.
> 
> Fixes: b9bd10c43456d ("s390/vfio-ap: do not reset queue removed from host config")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 1edd0b7a3cce..bd9d239caeba 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -2533,12 +2533,15 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
>  	/*
>  	 * If the queue is not in the host's AP configuration, then resetting
>  	 * it will fail with response code 01, (APQN not valid); so, let's make
> -	 * sure it is in the host's config.
> +	 * sure it is in the host's config. If it is not, then free the KVM GISC
> +	 * resources.
>  	 */
>  	if (test_bit_inv(apid, (unsigned long *)matrix_dev->info.apm) &&
>  	    test_bit_inv(apqi, (unsigned long *)matrix_dev->info.aqm)) {
>  		vfio_ap_mdev_reset_queue(q);
>  		flush_work(&q->reset_work);
> +	} else {
> +		vfio_ap_free_aqic_resources(q);

Re: the Sashiko finding for this one:

[Severity: High]
Can this still trigger a WARN_ON and leak KVM GISC and pinned memory if
a guest shuts down or the mdev is removed before the physical queue is
unbound?

I think Sashiko has a point here...  At first I thought it was a
pre-existing issue (just another path that fails to free resources) but
I think this patch actually makes the described thread of execution a
bit worse:

Before this patch you would leak resources on the described path.

After this patch, you will leak the resources on that path, then reach
this new else statement and could potentially now WARN about the null
pointer(s) in vfio_ap_free_aqic_resources() and still not unregister the
gisc and/or unpin the saved_iova due to the null pointers.

