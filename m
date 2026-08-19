Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756FC427FA8;
	Wed, 19 Aug 2026 08:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787128930; cv=none; b=rIDSrLvm3pcOYwU4PLQPgPV4rmb16jJAb8q2QKFj9ub2UEFDBOpecz1mk8ikPQDW8ZHSmBzbN/7ZiJMum5nj6kAIfNyYD3LB9B3k4Hvj8ebOm0BtXFqK8psu4TKCb02a6hyay7tHCwPzB+LxUkOsADD4R6YPypmmmSEaYAF7q/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787128930; c=relaxed/simple;
	bh=TWLtTb8jRScNf+y1G90YtjWpB28XymlvuAIHkwmXSwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N5xpndJGM6RwpJpyhPVSixDhWoEV1vV4Tp45L6cZphW2DolERify8e4BPSJYWKOfF6pXYkcpG8LBgpWDitxlgPlU7T/5n9Fg+ly++ERBEvcjMPTyZAqKE5WkaEFcRPlENBMwEJ23QmGoCuXDaY8DuBz4/j0pGGMUwcYKQkt/wSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Pc/l0HRZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Pc/l0HRZ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J6Vt3v2666949;
	Wed, 19 Aug 2026 08:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7+1LgX
	zLC0du4jC2lHT7AfmJCchjHYHe18U44h+4bZI=; b=Pc/l0HRZ5U3OXa5926HgsI
	QZISQcgbMAttQ5kas91WA7x7V0Ce5deiXy8lJ8uK8pZD2UlkCA50Wuqh5PcLfU2t
	sId3hVIsGmRyDoNteWvY73m+HzkaZ0yOYaGw83u2ADDP7zHQdjiKC+UNZcR4mEAc
	k+tLUrlREhQrMoAAXQ8qYsHKVBaUJ2/ENKTaN0If4xR+APOilJbQDWoDAlK6BTt/
	0NdYpa0vBOLmn63BESXx4iwA1+KKPj+nw5wCkZ6wWkmKb0gJz+LD+duVSh5i0pcx
	aZltbTQcmoGa8FBPgS0Faq6OQDcvQxkcMncKXRQZs1TX5puTQFJoYs2EWXmpqsHA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0ak3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 08:41:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67J8fMuV028863;
	Wed, 19 Aug 2026 08:41:54 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32tw83tc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 08:41:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67J8fn2j41746894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 08:41:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDEA620049;
	Wed, 19 Aug 2026 08:41:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3094520040;
	Wed, 19 Aug 2026 08:41:49 +0000 (GMT)
Received: from [9.111.16.238] (unknown [9.111.16.238])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 08:41:49 +0000 (GMT)
Message-ID: <bfd4751e-8ed6-41fd-9141-e841d594e4fa@de.ibm.com>
Date: Wed, 19 Aug 2026 10:41:48 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/1] Fix leak of KVM GISC resources
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
References: <20260818193349.1877940-1-akrowiak@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260818193349.1877940-1-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a856c53 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=FMayTVvSb3CAZEfDvYIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: vpR5yzKatNyjbQBOrvSWZOgSbWSURA80
X-Proofpoint-GUID: vpR5yzKatNyjbQBOrvSWZOgSbWSURA80
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA2MyBTYWx0ZWRfXwNLYrw96+xo+
 EwNY/Uir/tfFxaFdpNRu7j0dv/pWEyRowL/WFtXg5AyOpmYPnqNXyLJRdi32VpB9uqFxbaBtOBy
 puSHygTFFRoZ70+hmTH8S4MzDTPIy9E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA2MyBTYWx0ZWRfX7urdkWcWFW6q
 2mCvdARQabkNCXlmbhQr5Wd0+HTtA3SHrIBTZnufzyupv8iBimrMGtP84j+8i5WgPjrOJAvNhkF
 kknUPUvcrT//T9S+8eexMwo4LK+wCrvWIZ1xSqhRVHL5nCUnrym7XCjEwOnEnyKDkeqic7l8zNZ
 e7b6ibe9dMYocqWpN1diUTvVA9I+df6asVVY88Em/cyEmObw1TyCa7b4Vh3/mJJHb1Gr8xpqDdu
 fF7uZg9Hyt67VhmBrzCm3Nl5soSz1nRsVrP+ulhHtdsJSX3uY26cvTBhjnYs7lS/3gFsPGtqpVv
 nNU/2kcjrqfnoip61eg3ns+bC9SPcxVES5rmryMnQ0DYMqUt5O1246/hKLv8p5hX/J7ugqtaBD/
 ZFnLqJ/p490waiPTV7XU5Vr3DSvabqCI3p2JioJYi4rOnRA5MxWnLDUeJZ/vKq1QfywEy0NJXqF
 PUQZmcZCti6osbAOLmw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190063

Am 18.08.26 um 21:33 schrieb Anthony Krowiak:
> This is a continuation of the following patch:
> [PATCH v5 9/9] s390/vfio-ap: Fix memory leak when queue removed from host
>                 AP config
> 
> https://lore.kernel.org/linux-s390/20260812200240.818004-10-akrowiak@linux.ibm.com/
> 
> That patch was posted with a series of patches, but was no part of the pull
> request for the series due to some code review comments that needed to be
> addressed. The first 8/9 patches were part of a pull request to make the
> merge window which was about to close; so the referenced patch is posted on
> its own for review.
> 
> Anthony Krowiak (1):
>    s390/vfio-ap: fix KVM GISC and page leak when queue removed from host
>      config
> 
>   drivers/s390/crypto/vfio_ap_ops.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
> 

Thanks, applied
