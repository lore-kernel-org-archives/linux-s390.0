Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45891D8DEA;
	Tue, 15 Oct 2024 12:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993750; cv=none; b=BF7kR2eKnSVHDf53fxvsXK/mJs94ogJNE1ukj/yUUIkmko/4Loyl0HDRz86I8Jzr+r0wQPXwHLVg20f/LNgDePnGpCS2VuYiuq1k26vNdAfsI5qpfXAtLxY2nBapnp+DbGg78FzbnF7Mo/xE7P658VlxXLvZ5oY4PXOJ2gUGmdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993750; c=relaxed/simple;
	bh=Mb2jMIhgPn95C310AjLjdOHybGQPmJhBSETFECJjd7A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aPUPIUHhd+qMTCit4h8im6pBExE2PUXwj/JPBUAGTtUVVCMCueIpbSkSAd/MZiy7NZDflHC3yekdZLfc+915BNdFi6ORBSqfTSoliSdBCK7VpXyj1Irx8n4z7X2wMtwF/k3Q/Xjj6B7zbIceSMkTvIcwU2Cy5LNLLNwFIp14U0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sf0WAxmg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sf0WAxmg"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FBsoCX000968;
	Tue, 15 Oct 2024 12:02:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=zr/zrrWXTvhTWxhtih01DT725ChHcY
	Ut7x8P1H+ErnU=; b=sf0WAxmgUYeiUPYg9G6M1xZaaSEFYKOgmf+xedBVHTitag
	/KMzx7kVzRzWtXcuIXL2uiFc/nPJCKW9EzzAdODparpS749PimFWFzplcJZv4pzG
	scnLGhEbfCXz1Gi8AxwTJlOUzUdy8qhLM5qKcJK0MnUW28eTOzVeG93yQHr/3jte
	z+/ygvkkXNvcE6hCAcKU0oxn+/nlXQtfdQaUXkFNyYmCLEBMKQwIikLJ4AmKs5lQ
	GliTNdyr97+wtmETffLrisJEKcXmBF0D1aOiR3Ukf1oRmFL6FL0lPB8jI0lI4IPo
	wvYe1bgBo64I44xxBSu2+Y46AYHqI0aDPLA+gjxw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429qxf81u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 12:02:22 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49FC0OFx015624;
	Tue, 15 Oct 2024 12:02:22 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429qxf81u4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 12:02:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49F8jtuN005215;
	Tue, 15 Oct 2024 12:02:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4285nj3cxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 12:02:20 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49FC2Hrm16843084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 12:02:17 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B5152004D;
	Tue, 15 Oct 2024 12:02:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47B8220043;
	Tue, 15 Oct 2024 12:02:17 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 15 Oct 2024 12:02:17 +0000 (GMT)
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
In-Reply-To: <2024101532-batboy-twentieth-75c4@gregkh> (Greg Kroah-Hartman's
	message of "Tue, 15 Oct 2024 12:59:10 +0200")
References: <20241015105414.2825635-1-svens@linux.ibm.com>
	<20241015105414.2825635-3-svens@linux.ibm.com>
	<2024101532-batboy-twentieth-75c4@gregkh>
Date: Tue, 15 Oct 2024 14:02:17 +0200
Message-ID: <yt9dmsj5r2uu.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: C5MxkPI-lNzpY37PKc_4CQ7i5Q9PFrJ4
X-Proofpoint-GUID: EhLHQRuyEm3Gn599LIfAKyUbfl87nRQ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=723 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150081

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Tue, Oct 15, 2024 at 12:54:13PM +0200, Sven Schnelle wrote:
>> To allow users to have stable device names with the help of udev,
>> add the name to the udev event that is sent when a new PtP clock
>> is available. The key is called 'PTP_CLOCK_NAME'.
>
> Where are you documenting this new user/kernel api you are adding?
>
>> 
>> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
>> ---
>>  drivers/ptp/ptp_clock.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
>> index c56cd0f63909..15937acb79c6 100644
>> --- a/drivers/ptp/ptp_clock.c
>> +++ b/drivers/ptp/ptp_clock.c
>> @@ -25,9 +25,11 @@
>>  #define PTP_PPS_EVENT PPS_CAPTUREASSERT
>>  #define PTP_PPS_MODE (PTP_PPS_DEFAULTS | PPS_CANWAIT | PPS_TSFMT_TSPEC)
>>  
>> +static int ptp_udev_uevent(const struct device *dev, struct kobj_uevent_env *env);
>>  const struct class ptp_class = {
>>  	.name = "ptp",
>> -	.dev_groups = ptp_groups
>> +	.dev_groups = ptp_groups,
>> +	.dev_uevent = ptp_udev_uevent
>>  };
>>  
>>  /* private globals */
>> @@ -514,6 +516,13 @@ EXPORT_SYMBOL(ptp_cancel_worker_sync);
>>  
>>  /* module operations */
>>  
>> +static int ptp_udev_uevent(const struct device *dev, struct kobj_uevent_env *env)
>> +{
>> +	struct ptp_clock *ptp = container_of(dev, struct ptp_clock, dev);
>> +
>> +	return add_uevent_var(env, "PTP_CLOCK_NAME=%s", ptp->info->name);
>
> Why is this needed?  Can't you get the name from the sysfs paths, the
> symlink should be there already.

You mean the 'clock_name' attribute in sysfs? That would require to
write some script to iterate over all ptp devices and check the name,
or is there a way to match that in udev?
