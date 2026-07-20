Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCB83E6396;
	Mon, 20 Jul 2026 20:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784580821; cv=none; b=EqRJm06pUZ2S18v4fWTSvFsfxfeAzEfHWS/ij/BwAU5IPxX1/nyUHA9hX3Qo+S4mvRhDhptfkWA3aT1pbTwwoAmU1d6EUlzAduGJLiNtb9vi5LwN6xqAfNmVSjoKUinT18dEy6sjGoLHHNZwyYyjZP5H4Ihm8jqagSa1BlGzpVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784580821; c=relaxed/simple;
	bh=/itpWUY0XWAahQcAUUDJsN1J9gpjZ/2cfB/WaS1K4zw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IxsZ+hlwt9JSk/R9DxcnBnPUEAbGVsvHnHLueSOqszE0bCTXYeCO3X3czlKvjK8NFBa88eCWixBv2H6zQOfaIw7jo420GadGvDbFHMddJCRmsPqSx6Hqt5IY4GxfkPVdaMFzBk4+KkS91ZJ8C8Ub1kP9TuAMjzBDPrh1E/ch0s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mhg1mIqN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mhg1mIqN"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KJfgV03124603;
	Mon, 20 Jul 2026 20:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wpRjGt
	ggHe34I15uToI2j1nOP3Lpgm2nVRkP/fJLgRQ=; b=Mhg1mIqN/FHQIDxTFTiXvJ
	P9KEMioNkpfq5SbPJe+Y/3XQU72xeQ/elrL2KF0BekRGhxJb/d4mXHz17iT/x2E8
	syG09tDzjyp7Nf7N/nXGvghbK+cPdjGwMQKaaudOHEAUfucjAAfNI/K4bhGVu/X4
	xEDTCFN67KlUIZ/9YZrz9LeSk4xXcODNKNnizn3pyMb1zk39JaGiZQaZJb2DRMOC
	x/pdBuI8V0RxT/HEJOkLwHsdbbliAAPPju24pPn/uH3dMif0tx04dVkbYzYgW5YG
	oi5dfBOm52o9XGFQru7tIFeaQhpYH/fgAofVjN+cSYno20JT6rZsfvjiQnzA/1Cw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ab9fvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 20:53:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KKnmVO014091;
	Mon, 20 Jul 2026 20:53:38 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1g74h8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 20:53:38 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KKraRb29033142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 20:53:36 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07F7F5803F;
	Mon, 20 Jul 2026 20:53:36 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FB385805A;
	Mon, 20 Jul 2026 20:53:35 +0000 (GMT)
Received: from [9.61.41.22] (unknown [9.61.41.22])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 20:53:35 +0000 (GMT)
Message-ID: <72dc420f-2542-40cf-8231-6ee146cfb58e@linux.ibm.com>
Date: Mon, 20 Jul 2026 16:53:35 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] s390/vfio_ccw: limit the number of channel program
 segments
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390@vger.kernel.org
References: <20260720201931.976660-1-farman@linux.ibm.com>
 <20260720201931.976660-3-farman@linux.ibm.com>
 <20260720203054.07C041F000E9@smtp.kernel.org>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <20260720203054.07C041F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIyNiBTYWx0ZWRfX5Hi8Am20mF6g
 V/6UcacWCJBgTrqdY7i5P2mkeqT2Hpy+iSYC6cx1cgK04JFTAu5imUTMN9inYePWlpzm7n2L6i5
 1srLtnO0JkFgAvGCjDjC2E7yK/afCNnm7IcqMxA1I1YhWbMIclb3cIGfCnyLF1D7mnWPNTHpWvp
 GD/hDXa4Ot9jaLnsyCXS8b99lqCMdZ+dXt14PT+NLBqO0XZp0WmoN7BGqNoPWdsrzClPK74NIV4
 XHvY5JX5ExQSWH6w1LPTGaUmshHkbmJnXsz/W7XClE3FAMh8LV3FKuShye7iYSFDp0hQj8J0sBW
 NbxGvg1BDYjSApYj/lHHEq9cRmaek3S8E1JjnkjTka6wqb3FSB8Dcf0o7+nlEle9ziLzYu58nn0
 BAJJF5s9+YrVt1eO4XZF50eArtL9YdJy1iyXlXf2EffzhlJcSFipAWfbpMQhjk29W34qBJd15nQ
 +NNTpWiPkzk19xlsk2Q==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a5e8ad3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=g2rSR9GVBAcme75R0PwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: AV1rEJXRFL-6RkeazlGWJ491Tsvzm438
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIyNiBTYWx0ZWRfX3o6VoFQGBhuA
 k+kfDjv17s0dSvf2TlA3i2GOWQbUlXZPpLYvi11gX7PasSk/WmaUOKwz3vtPtMDf16QPBxi7WmZ
 ZGUDqFrIVvL0ZxZd7LLrxvoVZA8iKBA=
X-Proofpoint-GUID: AV1rEJXRFL-6RkeazlGWJ491Tsvzm438
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1011 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200226



On 7/20/26 4:30 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [Low] Returning a pointer (`ERR_PTR`) from a function that returns an `int`.
> 
> Pre-existing issues:
> - [High] Concurrent unprotected access to channel program structures via ioctl reset and write paths.
> - [High] Out-of-bounds read on `cp->guest_cp` when calculating the CCW chain length.
> --
> 
> --- Patch [2]: [PATCH v2 2/7] s390/vfio_ccw: limit the number of channel program segments ---
> commit 55497ee3c2db8e265add0b6679cc5ddd751ba7ce
> Author: Eric Farman <farman@linux.ibm.com>
> 
> s390/vfio_ccw: limit the number of channel program segments
> 
> This commit imposes a limit on the number of channel program segments to
> prevent excessive recursive processing. It tracks the count in the
> channel_program structure and fails if it exceeds CCWCHAIN_COUNT_MAX.
> 
>> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
>> index 086d1b54bdb05..7abdebd8f7c3d 100644
>> --- a/drivers/s390/cio/vfio_ccw_cp.c
>> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> 
> [ ... ]
> 
>> @@ -441,6 +442,10 @@ static int ccwchain_handle_ccw(dma32_t cda, struct channel_program *cp)
>>   	if (len < 0)
>>   		return len;
>>   
>> +	/* Limit number of chains in a single channel program */
>> +	if (cp->ccwchain_count >= CCWCHAIN_COUNT_MAX)
>> +		return ERR_PTR(-EINVAL);
> 
> [Severity: Low]
> Does this return a pointer from a function that returns an int?

Bah, I'd pulled this hunk out of another branch where I changed what the 
function returned, and neglected to update this return. This should 
simply be "return -EINVAL" and not the ERR_PTR() wrapper.

> ccwchain_handle_ccw() returns an int, but ERR_PTR(-EINVAL) returns a void
> pointer, which could cause a type mismatch or compilation warning.
> 
> [ ... ]
> 
> [Severity: High]
> This is a pre-existing issue, but can concurrent unprotected access to
> channel program structures occur via the ioctl reset and write paths?
> 
> If a user-space process concurrently invokes ioctl(VFIO_DEVICE_RESET) and
> write() on the VFIO device file descriptor:
> 
> drivers/s390/cio/vfio_ccw_ops.c:vfio_ccw_mdev_reset() {
>      ...
>      vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_CLOSE);
>      ...
> }
> 
> This calls into the state machine to close and free the channel program
> without acquiring private->io_mutex:
> 
> drivers/s390/cio/vfio_ccw_fsm.c:fsm_close() {
>      ...
>      cp_free(&private->cp);
>      ...
> }
> 
> Concurrently, vfio_ccw_mdev_write_io_region() acquires io_mutex and processes
> IO, allocating and using private->cp. Could this data race lead to a
> use-after-free?
> 
> [Severity: High]
> This is a pre-existing issue, but is there an out-of-bounds read on
> cp->guest_cp when calculating the CCW chain length?
> 
> If an unprivileged user provides a channel program filled with exactly 256
> command-chained CCWs:
> 
> drivers/s390/cio/vfio_ccw_cp.c:ccwchain_calc_length() {
>      ...
>      if (!ccw_is_chain(ccw) && !is_tic_within_range(ccw, iova, cnt))
>          break;
> 
>      ccw++;
> } while (cnt < CCWCHAIN_LEN_MAX + 1);
> 
> The loop executes a 257th iteration when cnt == 257, evaluating
> !ccw_is_chain(ccw) on guest_cp[256], which points past the 256-element
> guest_cp array.
> 

