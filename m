Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE02157E9F;
	Mon, 16 Sep 2024 12:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489483; cv=none; b=Y8KHoovseQ4G2WwrCsGT1iwzQ7JVFMq6xGD3zfrLE7PxI0mggJegxYHGjGR3RMUVYPcswdXs4Nfp3+hNZKvWAlR9bvEaP3lPVe9ClLioSH0Xrk4MNJjQ6z72JQFLJ/9B4elmDrjaR6ysBISsRv/HIzW4Qi8UCJUbcflzdGwDJ6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489483; c=relaxed/simple;
	bh=s4Jnygxo1kk2vkxv9gdBlOVwmBGwWmyXKspjhMrqHpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qSUbD1nTARax6Hwju2yhMoWJNdcsarilLclHFUBmlwu7zi3N38Yt8+5i/T5JzeTHY9/ccBYIqpWtLFV9tjAF+J4afgQqo1OrG5aFS8BfjtlSc3HARb+zsj6v+Eb/O7ApjJMsFs1SvVmRBdLg0+65kH5GBVDaQq/yR2zUQoXMCaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Sa1eoe5U; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Sa1eoe5U"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GAFgCA025501;
	Mon, 16 Sep 2024 12:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=s
	4Jnygxo1kk2vkxv9gdBlOVwmBGwWmyXKspjhMrqHpg=; b=Sa1eoe5UrBCLeDq4X
	oNFygXKO1qxvnPyfRGZ9ArUbnIZLEvqpBxg1pzVLp5Q8fiGOJFSi/QFGC9/NVqsU
	dj0kPQlwc1osSyV7dg10i4ELHiS+2v/bmMVnG0a0bBF2gUJJaJLlEOH4ZLMqhzLW
	WRLlnFLorVJOnUdkQVB+k/VH8YFX7JxWtDWwKTdzWDeX/xhHh8U3ZGua7aA7zsDX
	lXMnPHgfnIYYKdKmLM22rsWmllFCUjKrSAc3Q/u0zTAWhw/lUGcAI/vHFr/BCh0k
	lTwt4P2++mnPQWxH9mx8u7WKgE9JAotE6hGSAOSTYV1eOwnYXdqy7IU7D7sh6MAs
	1v6NA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3uj1uh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 12:24:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48GBDxFf000723;
	Mon, 16 Sep 2024 12:24:37 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41nntpyads-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 12:24:37 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48GCOatV48234832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 12:24:36 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40AA75805C;
	Mon, 16 Sep 2024 12:24:36 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EE9658054;
	Mon, 16 Sep 2024 12:24:34 +0000 (GMT)
Received: from [9.171.5.142] (unknown [9.171.5.142])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Sep 2024 12:24:34 +0000 (GMT)
Message-ID: <27aa2d1b-985f-41b0-9e2e-566e17aeb620@linux.ibm.com>
Date: Mon, 16 Sep 2024 14:24:33 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] s390/dasd: Fix typo in comment
To: Yu Jiaoliang <yujiaoliang@vivo.com>,
        Jan Hoeppner
 <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
References: <20240911064213.3891052-1-yujiaoliang@vivo.com>
Content-Language: en-US
From: Stefan Haberland <sth@linux.ibm.com>
In-Reply-To: <20240911064213.3891052-1-yujiaoliang@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tmhWMX5ZGjEe2psZAfV4YQlY5s-w1EKF
X-Proofpoint-GUID: tmhWMX5ZGjEe2psZAfV4YQlY5s-w1EKF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-16_08,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=335 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1011 bulkscore=0 suspectscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409160077

Am 11.09.24 um 08:42 schrieb Yu Jiaoliang:
> Fix typo in comment:
> requeust->request,
> Removve->Remove,
> notthing->nothing.
>
> Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
> ---
>

applied, thanks.
