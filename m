Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C00456292;
	Wed, 12 Aug 2026 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549179; cv=none; b=tQYeVJzzgRsjrjUiU5bhMzO4vYHdAMdfnkCGsaJqwXtta0fgWFmlaAjE14NL49nOEqdYZE5cubYnq8sLCxzb2p3jKncNNPV8FztxCTRgU6imYiXqdP7ImXD8mR2mquc2va/plD37A/KjSSZYyDG6xftztTUs1JghNYXsBxdBis8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549179; c=relaxed/simple;
	bh=8+isy6edP85tiX0/NU+/PFx7K0CLTVYLjvK94xLtH5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a4UeelyAxmtaEuvj0E/PSZ6dkM2ovBMtHUoDQjKZi/P8EWFG9IoG+UUVMsYRxM5xcPHVwDjhei1unFWr8KuOMTvYvSDqIR+vQ2VOAy9Z2XPLCcNrpskLmRRq6rUlV3hdCIFeI0PRXK4muHSiEhVXZuOprljkCGbUMw/Jbkt2YPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D4ZnrwjK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D4ZnrwjK"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CE1mUQ3640493;
	Wed, 12 Aug 2026 15:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=A9utfb
	4hExUByVc1JgFMopoM1HCj1cYlWsPRmqaumBQ=; b=D4ZnrwjK0rP72R/jlwxZf5
	kdqAVRsNlGG333aMJwyD1QHZrlKcX8skP8Q+ye34NoQl3ViAoTy6bJSYYQdfBc7t
	D6B9PlOXKQ0rRQrkBPpXYVJlqhgNP+dstKeVHoirVAiIxPOhLHhIPyksNFLuGnk9
	QsuLKyuekYy87j8A7GSjHcif2XTHwMB4Xuy6oN9dAHRK0EB1OaGBA7ayBOrVr04m
	mvEPzQ6nryxSVwWM4vsUpju1UTsba/1nlTkRhooOJRkgb3SYn/exf9Nwpdl1+Rvx
	XBBpAbXRVWyxSX735lRQWixR5zoj4lxqBs+Bb1H00DTz1XAz0Xg6D6vDI79yR28w
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9k7us-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:39:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CFQIGs012224;
	Wed, 12 Aug 2026 15:39:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq6v8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:39:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CFdLOZ37618008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 15:39:21 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4020520043;
	Wed, 12 Aug 2026 15:39:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93C3520040;
	Wed, 12 Aug 2026 15:39:20 +0000 (GMT)
Received: from [9.111.47.51] (unknown [9.111.47.51])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 15:39:20 +0000 (GMT)
Message-ID: <4f92bf25-a612-459c-93a5-15b1c002f3bf@de.ibm.com>
Date: Wed, 12 Aug 2026 17:39:20 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] s390/vfio-ap: Fix bugs in vfio_ap device driver
 callback functions
To: Matthew Rosato <mjrosato@linux.ibm.com>,
        Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, alex@shazbot.org,
        kwankhede@nvidia.com, fiuczy@linux.ibm.com, pbonzini@redhat.com,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com, agordeev@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com
References: <20260812115139.576303-1-akrowiak@linux.ibm.com>
 <14e82371-8e39-4af6-b220-6f0d1bdf25d4@de.ibm.com>
 <4edf514c-9044-4530-ad47-4fb468160835@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <4edf514c-9044-4530-ad47-4fb468160835@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SDaPMHLgl7RmQJAXeM_dcN8sTcAqGOsW
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7c93ad cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=d3c-8EuKqj4r41_r3OYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX/RA7OTMy66wm
 H7B1kPwkxVFjiwZn769PzbiTaX+vRfRpFpkQyt56U42lOAp4bAUNm9u+vGriusJoRvrdbSkNAUd
 kU6sFs4d/BvcGcVLePvCyPu8Cekl3EkE9o7ZbQ6eFxJhsA0IWKdkUXpDoVf6Q0xoPhc2nimzQiN
 g/8w0k+bNNhGbBHx4KorP4xr6nkxEVCt4Eyzt47KefORjKwSKoGEuIzFOa5C42DDQ44cAA8Ga3Y
 nF1LAlq63KAEJZCO9sNWjiJ/zIN6LKHjLMCsVUe7SQNNYhPqSbLmrubbs7d2ltA0MFeeJglikMA
 H0hth+461gCnrHjDdf2+YKAhzHqzYD1b4XsaNrHGzp75K0tSPs0nqAksOAqtO4vltiqpetz+/WX
 woFU2s1dqDOzAo8GORBEBB3E6Q4iyjAGyxYnJ7jzuTGmq0JAZVoLcKer3X/WtFx13VnyDTpwaoG
 qVJJNHMELUDVV+aZIaQ==
X-Proofpoint-ORIG-GUID: SDaPMHLgl7RmQJAXeM_dcN8sTcAqGOsW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX87ZZdTcbmyT0
 xsS6yQp1GrNw1O4zjEiNB5IEqrarR7aimN03NPROx/igBXH3qdJKej2DZqD5d7h65mSqxGCH52z
 GMjJSvDnRYG66m3pQoG0hj8TSfwjizo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120126



Am 12.08.26 um 17:36 schrieb Matthew Rosato:
> On 8/12/26 11:30 AM, Christian Borntraeger wrote:
>>
>> Am 12.08.26 um 13:51 schrieb Anthony Krowiak:
>>> During review of patches by the Sashiko AI, several pre-existing bugs
>>> were
>>> discovered. This 9-patch series fixes those bugs
>>>
>>> Change log v2 => v3:
>>> ~~~~~~~~~~~~~~~~~~~
>>> Patch 3: Fix use of wrong lock in mdev probe function
>>> Patch 7: Fix required lock not held during display of sysfs status
>>> attribute
>>> * Squashed these two patches into a new patch entitled "Fix missing lock
>>>     required to access list of ap_matrix_mdev objects"
>>> * Added two new patches that fix pre-existing bugs:
>>>     ~ s390/vfio-ap: Fix NULL deref in status_show() during queue probe
>>>     ~ s390/vfio-ap: Fix memory leak when queue removed from host AP config
>>>
>>> Anthony Krowiak (9):
>>>     s390/vfio-ap: Fix stale do_remove flag across iterations in
>>>       vfio_ap_mdev_cfg_remove
>>>     s390/vfio-ap: Fix dereference matrix_mdev->kvm without checking for
>>>       NULL
>>>     s390/vfio-ap: Fix missing lock required to access list of
>>>       ap_matrix_mdev objects
>>>     s390/vfio-ap: Fix required lock not held during update of
>>>       ap_matrix_mdev object
>>>     s390/vfio-ap: Fix control domain removal in vfio_ap_mdev_cfg_remove
>>>     s390/vfio-ap: fix potential use of uninitialized apm_filtered bitmap
>>>     s390/vfio-ap: Fix hot-unplug skipped when last AP adapter or domain
>>>       removed
>>>     s390/vfio-ap: Fix NULL deref in status_show() during queue probe
>>>     s390/vfio-ap: Fix memory leak when queue removed from host AP config
>>>
>>>    drivers/s390/crypto/vfio_ap_ops.c | 110 ++++++++++++++++++++----------
>>>    1 file changed, 75 insertions(+), 35 deletions(-)
>>>
>>
>>
>> Sashiko has one new finding for patch8. Everything else is unrelated.
>> Will you do a respin for this?
> 
> I am going thru this version now but yes I would like a respin that
> fixes patch 8.
> 
>> I plan to take this for the next merge window.
> 
> I am also going thru all of the Sashiko reports, most are already
> resolved by this series.  But I will send Tony a pruned list to
> investigate after this series vs adding more fixes to this one.

Let me know when this is ready. Apart from patch 8 I am happy.
