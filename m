Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3FC2080E0;
	Thu, 13 Feb 2025 07:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739432238; cv=none; b=lDtKTeOcwKwZ3UUZHe+XjBKelnoXEokrLuFhOlcjT5E/LXZFCRhadNan29HBBItATMmxlYzPFoJEbKyo2DF28VLxWQWdSr8Ixbod75o4eBNHM9A1ZW6fgrwQ9YQAHxbg3n2jwTSvFvquH7Tt4dO5MJAUagXRi1ZzOgDjIo+lGWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739432238; c=relaxed/simple;
	bh=Kk9E2Aw4aKdaVrLUFj8iF5eXQIQAQDKMc1UPai+7jzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iGHTWKyJTy/9xZ637ikOwqadYbx7NBjDCMWtHauVLCIMHXYQhQ7d0t5++Y6B/bGdI7IxHnDvcokcp4mpi6TMt9XBIMuWlyn8n3r4nAdicyUoyz71ZekWUQBlht1HrQXtYa/LbNPAE2k3cfbuT89MBoodggvBegW7uMGYeTekJcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EXjCDkj8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EXjCDkj8"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D7X1jv014894;
	Thu, 13 Feb 2025 07:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dtdXfs
	aTQY2dSp16b5HtCHbSWFjl0Gs64MpCFtjy0hA=; b=EXjCDkj8M8xjpvlLG5uOPr
	xm9PGj3Ntfgi2sDSsrWCmrKGrmplqU7t+v1Sr24rPxtg/1WjvZCt5jpuenSPqyvr
	4Nxyo9TBv0LQGoOEM5a/ZvnABZPh9af/r6hD4sCN0Ranumb2/rzv/95qHUobXUG+
	h3TwJnrOfC49wAA9uw2x6LbrJNdDN6vgWCtVbD0ItYmx43nOAR4otkIieHqeDpJS
	YUPZkNybVyJCe0iCsBCY6Nd6jAyz7rAuk/ufdiRdgIxK67hfoQN6FFhsFJ9+xWpV
	DQukeGTWeRVodIXgjZ7YTziz9/qg2yuHuDTL+fJ+CfiZBH1HORRg5ffCvdioyxtQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44sceq00h3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 07:37:07 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51D7b6e1021622;
	Thu, 13 Feb 2025 07:37:06 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44sceq00h0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 07:37:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51D6cpiQ021713;
	Thu, 13 Feb 2025 07:37:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44phksw8fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 07:37:05 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51D7b2mM35979654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 07:37:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 307AD20043;
	Thu, 13 Feb 2025 07:37:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E723E2004B;
	Thu, 13 Feb 2025 07:37:01 +0000 (GMT)
Received: from [9.152.224.153] (unknown [9.152.224.153])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Feb 2025 07:37:01 +0000 (GMT)
Message-ID: <7ea4bc1b-96d8-47a3-8ca2-2baa862d8888@linux.ibm.com>
Date: Thu, 13 Feb 2025 08:37:01 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] s390/qeth: move netif_napi_add_tx() and napi_enable()
 from under BH
To: Joe Damato <jdamato@fastly.com>, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>
References: <20250212163659.2287292-1-wintera@linux.ibm.com>
 <Z6z4CMhLo0aj5YEN@LQ3V64L9R2>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <Z6z4CMhLo0aj5YEN@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Nanqoqv8MSkkL_8wp_5a25A2rkQJ5mZt
X-Proofpoint-ORIG-GUID: w9RXf_3TGi50qFznUVFogO5zBpQBP9Ve
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_02,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 mlxlogscore=689
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130056



On 12.02.25 20:35, Joe Damato wrote:
> On Wed, Feb 12, 2025 at 05:36:59PM +0100, Alexandra Winter wrote:
>> Like other drivers qeth is calling local_bh_enable() after napi_schedule()
>> to kick-start softirqs [0].
>> Since netif_napi_add_tx() and napi_enable() now take the netdev_lock()
>> mutex [1], move them out from under the BH protection. Same solution as in
>> commit a60558644e20 ("wifi: mt76: move napi_enable() from under BH")
>>
>> Fixes: 1b23cdbd2bbc ("net: protect netdev->napi_list with netdev_lock()")
> Hm, I wonder if the fixes should be for commit 413f0271f396 ("net:
> protect NAPI enablement with netdev_lock()") instead ?


I was wondering about that too. netif_napi_add_tx() got  the lock in
1b23cdbd2bbc and napi_enable() got the lock in 413f0271f396.
I don't think I can have 2 Fixes tags, can I?
(And I don't think it makes sense to split these few lines up into 2 commits)
I chose 1b23cdbd2bbc because it is the earlier one.

