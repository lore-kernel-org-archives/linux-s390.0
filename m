Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40B438B12E;
	Mon, 15 Jun 2026 20:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553726; cv=none; b=DIbz+VvZkYDFmzwvIXEa69h+DPa2KU0rDBBVLHALZGfjrsVkoRaZ7fKn7sF4gEHG8LYOXE8XIvtKnfKHUvJyyjNwjQre5Y2GUBOkBo1vlgpkOwk6f1+nyeBD5Ij6GOkSnPQXZEbEybNBRKUUPENaFAagNOUOlYI+TvP0jKSQ+Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553726; c=relaxed/simple;
	bh=hFawhCsNPty7fevrSntR9guSB7PDRflv6YAjEEf87N8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=um71xYu0g2OL0ffZ3LkebqAsLJMyTMYBjYWzGZNxLo/US/uv70c6B1xiLsIIA89xHkZ8QeCf4azkcS1ISy9YH0lsRIFY3P9VZ9Xh0wBtwE8rz3N7X2dVpXNUGJ6uBpj54sgihTcOJJxIDM/tDl9PBS2G7GMBWnxjTrvOHH+jp2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DpvhXJu2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DpvhXJu2"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FJILEg3289731;
	Mon, 15 Jun 2026 20:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QuQb2L
	VUENz2tci2/j7hR8YtaJnI7ON1FlkxUDqXzZM=; b=DpvhXJu20nQPyvIz7nwx2D
	sPE/gKsaYJj6pKb0lsjk12P+Pto5UbKmAxTgYaCB8oow/RxjVzZV691vpr09fbbG
	fBuBwLu8tsIm+jonVoTy5kUXaYnG3niuTWJqUL1bgCv6svgGI358/UqeOFIv4urk
	CWRRdPg42EaVZ1O3LtLqx3+8A6dmYE3xH67hduffbrY9Q4Jc4t05oF/Ak8vwW74z
	jgR+uIEx6oFs6CZoNdrMqdAt3tCQw8JY+WgO1HNigEKO+gqvJPzXe4Ndputnx8Nu
	GYVCRh+LA85kGPHp1g/wiQI8IuUVfr+rZ2ncziSR+UCFyL/wlvduYk/IhiyyZP9A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es23njcpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 20:02:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FJnfI3008314;
	Mon, 15 Jun 2026 20:01:59 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esk1h0402-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 20:01:59 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FK1wJd30409052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 20:01:58 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D67558053;
	Mon, 15 Jun 2026 20:01:58 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2076958043;
	Mon, 15 Jun 2026 20:01:57 +0000 (GMT)
Received: from [9.61.248.38] (unknown [9.61.248.38])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 15 Jun 2026 20:01:57 +0000 (GMT)
Message-ID: <4d7fc371-4357-496f-9774-1f7a7c1a3091@linux.ibm.com>
Date: Mon, 15 Jun 2026 16:01:55 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] s390/virtio_ccw: Also suppress -EINVAL on device
 detach
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, farman@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, mjrosato@linux.ibm.com, vneethv@linux.ibm.com,
        oberpar@linux.ibm.com, virtualization@lists.linux.dev,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260612155407.199218-1-wbezenah@linux.ibm.com>
 <20260615002309.052e0614.pasic@linux.ibm.com> <875x3jn94r.fsf@redhat.com>
Content-Language: en-US
From: William Bezenah <wbezenah@linux.ibm.com>
In-Reply-To: <875x3jn94r.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a305a39 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=PMLYZQeYH2tpQPL_-REA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwOSBTYWx0ZWRfX4PZbuGXSKZf5
 l/1pR7lsN0bgLCOWkCTdC69/5HkvfrFDOL0PLQtAPYJN195Qhwm/KGT/p7FWM2gs9d6gUgo3rVt
 Gj/Q5Sbnr7gWqEdTe3vj+EI0JNv3EtX4Qm6bjjVNfMiJiti7/cCRirh7bEXA9yGLyGcT64JBqJy
 wYNbmj6xyVKN5ByyuB4xs8MR+ca2OkUXxdCcg4Va4Pa4XEd8Ql3qtTqXw4GyZwgdsNDVhXxBInq
 bFyn3239NL3laq3Pg56cekAvWq4Ho0t96aDm+eKCxkl+mOjuFLRxKk81b1Yj89hUJMfRVTZux9O
 YUdGC97yxo9KFT/5/d2ej3IvJLQS7nT4XDZrlxddFXX8LJW4kr1XrOcFpgxFgm2DqwLpW3c61+6
 IkRzZgFt6rUaDbyOQAscU8nYganYyrRINHwQCYmPwThpu1OFypkkyYuBNtqcA3ysCP8p65mmtJ7
 RcoZK1FKORsd6GzFUbA==
X-Proofpoint-GUID: 6s_Jph1OiLimsgDJtGiL8lZFruvvkctt
X-Proofpoint-ORIG-GUID: 6s_Jph1OiLimsgDJtGiL8lZFruvvkctt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwOSBTYWx0ZWRfX7vW91poRXSnr
 99MSBYK7MoH5tMA0Y8BIApus79JCsAeDf0BxPMy9+6DA4BLYXlXmJFf6l/7x723kuNwOb9P9pW3
 XWX+UvtFfKLy3NRiGULTfLSMGJ/HoeI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150209


On 6/15/2026 10:58 AM, Cornelia Huck wrote:
> On Mon, Jun 15 2026, Halil Pasic <pasic@linux.ibm.com> wrote:
>
>> On Fri, 12 Jun 2026 17:54:07 +0200
>> William Bezenah <wbezenah@linux.ibm.com> wrote:
>>
>>> Since commit 8c58a229688c ("s390/cio: Do not unregister the
>>> subchannel based on DNV"), subchannel behavior following a device
>>> detach has been updated and results in -EINVAL being propagated
>>> rather than -ENODEV, originating from ccw_device_start_timeout_key()
>>> in cio/device_ops. In the end, the virtio driver has no ability to
>>> react to the difference between device and subchannel states here,
>>> and during detach, both -ENODEV and -EINVAL indicate the device
>>> cannot be used and should not be treated as errors requiring
>>> attention. Update error handling in virtio_ccw_del_vq() and
>>> virtio_ccw_drop_indicator() to suppress -EINVAL in addition to
>>> -ENODEV.
>> Hi William!
>>
>> Are you saying that ccw_device_start() started returning -EINVAL
>> since 8c58a229688c ("s390/cio: Do not unregister the subchannel based on
>> DNV")? Or did I somehow read the paragraph wrong?
>>
>> The funcition ccw_device_start is documented to return:
>>  * Returns:                                                                     
>>  *  %0, if the operation was successful;                                        
>>  *  -%EBUSY, if the device is busy, or status pending;                          
>>  *  -%EACCES, if no path specified in @lpm is operational;                      
>>  *  -%ENODEV, if the device is not operational. 
>> and the commit message does not say a thing about introducing -EINVAL to
>> the mix.
> The function may return -EINVAL for non-enabled subchannels
> (i.e. pmcw.ena == 0), maybe we get an all-zeroes schib with dnv == 0?
> I'd expect it not to be enabled in that case anyway.

Yep, that's at least how I've come to understand what changed. The
function ccw_device_start_timeout_key() has always returned -EINVAL
for non-enabled subchannels (pmcw.ena == 0), though it's not
documented in the header.

What changed with commit 8c58a229688c is that cio_update_schib() now
updates the schib even when DNV=0, rather than returning early as it
did previously. Somehow this update results in pmcw.ena == 0 in
ccw_device_start_timeout_key(). Previously, it saw pmcw.ena == 1 and
moved to the condition (cdev->private->state == DEV_STATE_NOT_OPER)
where it returned -ENODEV.

So the commit didn't introduce -EINVAL as a new return value, rather,
it changed the subchannel lifecycle such that existing paths now
propagate -EINVAL rather than -ENODEV during the device detach
scenario.

