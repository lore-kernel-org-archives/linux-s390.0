Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD93470EA2;
	Wed, 12 Aug 2026 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549604; cv=none; b=Xc5KN+O9I2S+dcwXmQFmOz1IIwZVkxMQ4TQj0nhh2+YCb87qmmengUzdSRIZ6OAdvfgpBIfzX0+07exZ5RG6TtCH7OBI61DeHYk0jqrgUzsG2cBM5utFD4QYpIduk4FaUHayfvvtS69OXq74Um+bHnsAiWO1kKV4OkTZu0vWPZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549604; c=relaxed/simple;
	bh=EAIgo068nx2Af9IhjogZOEWv6J0Ri4a4u9gmhaELMhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AasXupK3/oay8FRgL//rVbmNpQT+Zg642f8U/m2QMYbzem4zyDXy+KsvcRon1oxkIbekdHO0VHX73FiiebWXjHJGZ3MPHKzEA1xy5Q3+cLzLWBknjlTME4akVr71nix7wZIY4GmkgoSEZcD5xhwCptOOU85rPbM58Vg3S02e1ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SBEQdbd6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SBEQdbd6"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CE1wvu3594490;
	Wed, 12 Aug 2026 15:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5TakiB
	gIv/9Y2pTffufnssy0hB/x/4f5M/BrMJL8gL0=; b=SBEQdbd6qlCCMjvvaGmH7j
	2BFBV50JA2V0KAZ3+zR5T80gid7CD6CuRiq4b5Ywi2U//Z9RP1guWPv2FIVZjibs
	FVj+cm+Khqq9CK2CXxnfl4PRFVCPsNhkRbIfd80Lf7hKaPLQq0WWqFM8vwSn/uo9
	Yc/fvkQoUOcG0wrwW2IK7a8xNpKwiuX73oSXW3Po4toAw0w+8yiBPvljmD2Wb3DP
	I5VXhOOgebHtqE1NQUi770NPf2Jj6p+0lsdQqL8/dxtyAodB0M/gKu369n4EMJam
	I7/TyocC2T8BYnRsLwics9kl3Scm8IYzRkuF11cmw8qzqFwYBDW8suATQ/mN7cjQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp32fkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:46:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CFfLZ7008454;
	Wed, 12 Aug 2026 15:46:37 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy6hkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:46:37 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CFkaHk15860392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 15:46:36 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72E8158061;
	Wed, 12 Aug 2026 15:46:36 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7395D5805A;
	Wed, 12 Aug 2026 15:46:35 +0000 (GMT)
Received: from [9.61.74.89] (unknown [9.61.74.89])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 15:46:35 +0000 (GMT)
Message-ID: <2aa33f7a-f158-4fcd-8f8e-acd405dd2cbf@linux.ibm.com>
Date: Wed, 12 Aug 2026 11:46:35 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/9] s390/vfio-ap: Fix missing lock required to access
 list of ap_matrix_mdev objects
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        stable@vger.kernel.org
References: <20260812115139.576303-1-akrowiak@linux.ibm.com>
 <20260812115139.576303-4-akrowiak@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260812115139.576303-4-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7c955e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=q8U9BxYzi0_zxtdpY7wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mhfg0uiVIsCWfiIjxgGT20hl89u-1USg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX4eaJjXXhxWp4
 mMQv0aGbwVOn98tzjKPo0Dl4Ot/lpnRCyb3rya+qOjObdSZW6kbKIcJejM3m8WuiBjbFPjWi9+k
 jsgvaJffQhH5GpSy/oDwYR7H8bcicPf+D5ZUAj1xiHW+5+jx2sPzdYxwhs9yJyaaQXBMb4lBReC
 Bf4Bj2X12ys1oD3/cwoNz6Z5TZKo7iNdzaNa1VnjmGFzbO0f0l7SqmSHJSEQzmuaUf3vXNzu6BH
 M/RAC3+bgwRy2OktR/FXZlSsf8+G76GNggu4huhhrN87aCzXGRVqKsvoGt+8sihmutP3+IQSpzk
 776Y9FjoFN8gztp8Jv563lVqFXEisZjiV2GMs05CntJLHb1O4zEp4B9c50UOScJm4bL+VGold6l
 alwHHUlGRo0av1ehYJZ4rlY8tFyKMRfD6WWGJ+NqPUIAvT3m5I+gR3VLhx1F2r3efVdG97ke4bW
 f1+Ny1Imtkvw89OrTmA==
X-Proofpoint-ORIG-GUID: mhfg0uiVIsCWfiIjxgGT20hl89u-1USg
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX3Ww8BIYGsSol
 m3lg78zv9Rh4GDMxzkqBdSPgXnTUGPMmKSO+NCLXHy2HXSrIK70rrrj/Za6AXBUIC4g0Z6ERYYw
 DHJGQqCEjpAf0Zslq+Y+kvQwkt6ra5A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120126

On 8/12/26 7:51 AM, Anthony Krowiak wrote:
> In order to traverse or add/remove ap_matrix_mdev objects in the
> matrix_dev->mdev_list, the matrix_dev->guests_lock mutex must be held.
> There are two functions that access the list without holding the mutex:
> 
> vfio_ap_mdev_probe function
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> The vfio_ap_mdev_probe function uses the matrix_dev->mdevs_lock
> mutex to guard the add of a newly created ap_matrix_mdev object to the
> matrix_dev->mdev_list. This mutex does not protect list access; its purpose
> is to guard against concurrent access to fields contained in an
> ap_matrix_mdev object. This could lead to kernel memory corruption or
> use-after-free if another mdev is created or removed concurrently.
> 
> The adding of an ap_matrix_mdev object to matrix_dev->mdev_list
> is now guarded by the matrix_dev->guests_lock which is the correct
> way to protect against concurrent mdev_list access.
> 
> vfio_ap_mdev_for_queue function
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> The status_show function that supports display of the status attribute of
> the devices in /sys/bus/ap/devices calls the vfio_ap_mdev_for_queue
> function which iterates the matrix_dev->mdev_list to find the object
> representing the queue device whose status is to be displayed. In order to
> traverse this list, the matrix_dev->guests_lock mutex must be held.
> 
> To fix this, the guests_lock mutex is taken prior to taking the
> matrix_dev->mdevs_lock mutex in the status_show function. It is taken
> there rather than the vfio_ap_mdev_for_queue function - where it is
> needed - because it must be taken prior to the mdevs_lock mutex in order to
> adhere to the proper locking order and prevent a lockdep splat; also
> because the mdevs_lock is needed there to access fields within
> the matrix_mdev object in that function.
> 
> See the vfio-ap-locking.rst in the linux kernel tree.
> 
> Fixes: 2c1ee8983aa3 ("s390/vfio-ap: prepare for dynamic update of guest's APCB on queue probe/remove")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



