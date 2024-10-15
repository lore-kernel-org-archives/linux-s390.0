Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970611EF93D;
	Tue, 15 Oct 2024 12:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728994772; cv=none; b=dLZPgJ9TBEfTPA4SL9920nEncB67iqIfsc7VBtTSbFElHWBMDaRUKs1oym0INMs5tbf9t2zzvY/8EOGD+z87kGLam2cw65L+xV+/OKNIQMFLMlAiL9NO4dkheA2E5t15pzoz+P71ewOAgNxtToscPPmpyNZ8CoSI1aKwKcR/qA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728994772; c=relaxed/simple;
	bh=f0vsXbS+eCTWMd5gTn0VhvzvtLvzjNeYu9XWGYWeEX4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kxG4hUx3e3qO6mrIo+bq593ZdqLP5np+8/JIEcDKDbr93fQX/mnm7rM/A8tBvjb6LS/QMR3QnDiz8JMxMlj93+J1BkUDSVuvku7vLnbNSE8uxgnLNQhdW9uZQArFDlaMjvzbNL50ScHDEbyP9R+ceUwQI+SFIe9fqUiU09bqFxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tBDRHKX1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tBDRHKX1"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FBsoED000968;
	Tue, 15 Oct 2024 12:19:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=YssuYZ0nRAUB3Z2Rq8KYSCgBC47axU
	+r68rV9JkZAHw=; b=tBDRHKX1gz8djXkj0Q9TuP/sFerTAbyawnrMbFGk5HlEC3
	0NKKpuXNeLx+i2ikxHYUlAjlFjIWJMyqpRURpFD9EElGBYLJgSalDqur2nap43n1
	1LF/vZzM2lyGow7xAjMqRQnQWvlVVSx/YRU+xhw5B6XA3qykrXmscBHiB9FrJBqA
	EftekBwK99m/7Ex/+IJMVFZHV2/eAHdnVcgBcXEwdV3+WVBYeHazWLTzhJnN/gM7
	dG4mhBuZt0z6gfNMSylM0UDOxwWzRfPrANKWd1OBeQTd7O16H3P/WBh+9klbP9hW
	YHdGb4mbZbaujxNNO6P+4bWUiP6ak2YlkDocNF4g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429qxf84x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 12:19:27 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49FCF40d020644;
	Tue, 15 Oct 2024 12:19:26 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429qxf84x5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 12:19:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49FAUggc006663;
	Tue, 15 Oct 2024 12:19:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4283eruxv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 12:19:25 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49FCJMZu51773836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 12:19:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5819820043;
	Tue, 15 Oct 2024 12:19:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1357B20040;
	Tue, 15 Oct 2024 12:19:22 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 15 Oct 2024 12:19:22 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        "Ricardo B. Marliere" <ricardo@marliere.net>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 2/3] ptp: Add clock name to uevent
In-Reply-To: <2024101549-bungee-dodge-057d@gregkh> (Greg Kroah-Hartman's
	message of "Tue, 15 Oct 2024 14:16:09 +0200")
References: <20241015105414.2825635-1-svens@linux.ibm.com>
	<20241015105414.2825635-3-svens@linux.ibm.com>
	<2024101532-batboy-twentieth-75c4@gregkh>
	<yt9dmsj5r2uu.fsf@linux.ibm.com> <2024101549-bungee-dodge-057d@gregkh>
Date: Tue, 15 Oct 2024 14:19:21 +0200
Message-ID: <yt9dv7xtftiu.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Y792RBPkwAaS7AY0BKJr_5A2cPHXB8BJ
X-Proofpoint-GUID: xJG33KtQUl72DAjbYZnW3L35S0P_V0pK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=697 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150081

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Tue, Oct 15, 2024 at 02:02:17PM +0200, Sven Schnelle wrote:
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> 
>> > On Tue, Oct 15, 2024 at 12:54:13PM +0200, Sven Schnelle wrote:
>> >> To allow users to have stable device names with the help of udev,
>> >> add the name to the udev event that is sent when a new PtP clock
>> >> is available. The key is called 'PTP_CLOCK_NAME'.
>> >
>> > Where are you documenting this new user/kernel api you are adding?
>> >
>> >> 
>> >> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
>> >> ---
>> >>  drivers/ptp/ptp_clock.c | 11 ++++++++++-
>> >>  1 file changed, 10 insertions(+), 1 deletion(-)
>> >> 
>> >> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
>> >> index c56cd0f63909..15937acb79c6 100644
>> >> --- a/drivers/ptp/ptp_clock.c
>> >> +++ b/drivers/ptp/ptp_clock.c
>> >> @@ -25,9 +25,11 @@
>> >>  #define PTP_PPS_EVENT PPS_CAPTUREASSERT
>> >>  #define PTP_PPS_MODE (PTP_PPS_DEFAULTS | PPS_CANWAIT | PPS_TSFMT_TSPEC)
>> >>  
>> >> +static int ptp_udev_uevent(const struct device *dev, struct kobj_uevent_env *env);
>> >>  const struct class ptp_class = {
>> >>  	.name = "ptp",
>> >> -	.dev_groups = ptp_groups
>> >> +	.dev_groups = ptp_groups,
>> >> +	.dev_uevent = ptp_udev_uevent
>> >>  };
>> >>  
>> >>  /* private globals */
>> >> @@ -514,6 +516,13 @@ EXPORT_SYMBOL(ptp_cancel_worker_sync);
>> >>  
>> >>  /* module operations */
>> >>  
>> >> +static int ptp_udev_uevent(const struct device *dev, struct kobj_uevent_env *env)
>> >> +{
>> >> +	struct ptp_clock *ptp = container_of(dev, struct ptp_clock, dev);
>> >> +
>> >> +	return add_uevent_var(env, "PTP_CLOCK_NAME=%s", ptp->info->name);
>> >
>> > Why is this needed?  Can't you get the name from the sysfs paths, the
>> > symlink should be there already.
>> 
>> You mean the 'clock_name' attribute in sysfs?
>
> Great, yes, it's right there.
>
>> That would require to
>> write some script to iterate over all ptp devices and check the name,
>> or is there a way to match that in udev?
>
> Yes there is.  Please use that :)

Indeed. Sorry, will drop the patch.
