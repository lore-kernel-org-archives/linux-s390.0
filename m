Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B249A364042;
	Wed, 12 Aug 2026 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550751; cv=none; b=sssTmEehD3hBQrT2O5taHqnoq4ESgWayDS4TSng+zXW1HUCX4ghnVqiRXq0xtsF1n7yRarClkdUh4Ixw7Ly+ekdOkNw+mlpp7CFearv3YFba0OoM1relFKJSJGy2q3yyDtH4M2pPMq5TX8w9yUOqZewP2aVCT1F6CUMulzCSY2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550751; c=relaxed/simple;
	bh=zsVfuH+XopEA7fntzxMJSZ7UxtuPBb8OpvTggewejxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uPshdAau2gfFNEYsFbVGnh1ed8zPXgBV5lPI6iAGd1lb5kOwjfym1n78ATK0jyC+0bPjtssVG87pPlIUVCrsIwlTXvzY/CbJ1H8HLWJEnzn5hzQIC3/M93L5/9LsgBYscgSTX/oUMcIkN9RVuktk+N6XF9z7Q6e2Sp2ZhpYDi0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kaHdDJ4c; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kaHdDJ4c"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CE1oHr3640578;
	Wed, 12 Aug 2026 16:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EaTi9W
	uD890My2q5ivgqs0PDsW9S32YRbq0YLCdUeL0=; b=kaHdDJ4cWNi1i0Gy4CR1vC
	PI3tiM+1U0yNI78Dn58sGrNYXRMmZYX1/t9VSUAmtW6sJ+cE8mkADOGE/tSUtY9f
	OV1PS1KxPCBK6xDmjIhVBscb4NvS8Hf5OxO4FvlLbnWCHni+DMh8JCaznmCkryec
	BCCJL9I3oqht7QDPAmeK6yGRxL3jwmd2RyKMvrPfSnpIV9Dw9uFIIAd5iXTHpM4y
	QWAbwE869jL900552gOENcvu0eZklGhlTDDuZkq8Hf6BELLiE/Gdjt3TJoppCQzl
	PD4fC7NBNMzs0LJe0qSlfPgXBqlvKEFxetpLuR1BQOcTW5vGBOFtspzmsnQ59SNw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9kc80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 16:05:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CFuLmB030334;
	Wed, 12 Aug 2026 16:05:42 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0geq7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 16:05:42 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CG5fwP1901274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 16:05:41 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60B0958056;
	Wed, 12 Aug 2026 16:05:41 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5365A5803F;
	Wed, 12 Aug 2026 16:05:40 +0000 (GMT)
Received: from [9.61.74.89] (unknown [9.61.74.89])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 16:05:40 +0000 (GMT)
Message-ID: <e8edfcb2-0bc9-4d0a-abaf-0c5b9fba1e83@linux.ibm.com>
Date: Wed, 12 Aug 2026 12:05:39 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] s390/vfio-ap: Fix memory leak when queue removed
 from host AP config
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        stable@vger.kernel.org
References: <20260812115139.576303-1-akrowiak@linux.ibm.com>
 <20260812115139.576303-10-akrowiak@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260812115139.576303-10-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: e2aWmmAWYJ7rBgkH4TEVPqZRLVCJcqnh
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7c99d7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=aQWKK2KQ0X-UDO9gmigA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzMCBTYWx0ZWRfX57Y8pr60J5EZ
 P0f23FORjFNmrqDYHhxTdjPaYeaEoVdNcQCbQxatjqh3itzsh0sJgaUmRRj2XExziCvOVE15qnX
 xkFsYsHcY5zY/2yO1Mh+mkPmBLi/LqKFwHzvoWS1lBu30pUVKuwEPe70EsKhtj+loX44V8pwNdF
 9arYAxCwyp5TawK35OGYYXU8j8KJHXyKgR2kdS1001Q2e2Ar3lntBu2rji3tDYE1hTNi5OKIoLN
 2cHrAphDtfnY9jB/BhJilbm8e52gCK1Wdjq/5o7RtOqDqe8VmHBEIkXLZMCeVt7vZqe/IKqtJAG
 uGOsjZXn8W+VgPMMb895mfHe1QyhUWJwpeUC+vxnXttAR8UG/TpEQaILupQHdAmq6xdk6q34Mv0
 rDjKDfuqXIt4mTp3igPJpXcGqcNCgSZDtQmatEQFNuXSt46IK6u6T6Hw8spLjQMNuWVvL9zHTQ9
 6N1UtJUPwwrFDMOC+5Q==
X-Proofpoint-ORIG-GUID: e2aWmmAWYJ7rBgkH4TEVPqZRLVCJcqnh
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzMCBTYWx0ZWRfX3wilkj/e3JeZ
 /ZJbTp0Xi2GUdQokQFGhNshqjYjraEZpNZBoBQWPyjsPq9sxnMtr5jfBFj7XLg7ZeBXFPE/2hF7
 RSzUZF3w0LhqfebHiedlHry29ofjNTM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120130

On 8/12/26 7:51 AM, Anthony Krowiak wrote:
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

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>


