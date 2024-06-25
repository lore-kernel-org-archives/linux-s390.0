Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8701494C9;
	Tue, 25 Jun 2024 09:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719306540; cv=none; b=W3K1X/K1iOOdQ8qYhdOYXW8HZ+Ym76zS9EmOSMLuz1o2Mc+dMEyMDOQMVH1g9V0SU/V5QBGNwI+klryg1UGJVv1DK0L7+mWubpXaTZxLw2tgaN1pMuKBp50vU8Jqr20ayC5dJJV3RTgcTPCqlqveMR+YzpXGYlqD62663Xlnk6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719306540; c=relaxed/simple;
	bh=J1CQ04JXkTjDdKV5EQmr1jYFf3jCx7BovP2+gRZXa+s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vDy3u2oYnc5EVOvEq3w8uqcoT6EnEeOhSPb9wtJjiDrNByv73IKdevYHJ9JvwvJmwbOoDIsMsl2QSPpZ+rAQXGw/5Kg9GMNReRcskjVUDHeatS63MCdqQPQw4a8mveUSMI21bXfl3kA/DYof11qzl4F8HbcDYR9ihX5gnHaDXXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G51EA6FE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G51EA6FE"
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45P8uqHC029970;
	Tue, 25 Jun 2024 09:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	p5H2MXzLdwRZQhyQI5zvK4voD55ZA3DbPa6NdRqopAE=; b=G51EA6FEYWSrIAs1
	4mDrBjh88TNzxhZvFYWRKU+tIc58LRbfnR/7TQsZuQosp4d7mvNMZv1kZ77NfqS0
	XR2yf/2DAauWnh1k5Pi1K30NhwnQAhFkbrxqiT/OJTOeEhJm0fkK6aUv7HVzlrz1
	erc7obLkqpChOS8i+CjEdHZ2webrxrIwAI9BwrrR3cIC2ytyXJZtVCg8p4eN9lF3
	Sae37u80fLK0Z7+QZq6ATEgV+KCfBeG+mX4TXeCkXQG7YAu+xZPie0i8S5kz6tsm
	be9QfpbQkAxGuZhsa+rFBjNB+3bo+Ecuqf16/D2gXRbErQ5mdPu+kUKYxzkNf6I5
	O8b7Pg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yyqg8rk0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 09:08:57 +0000 (GMT)
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45P98uEg018166;
	Tue, 25 Jun 2024 09:08:56 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yyqg8rk0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 09:08:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45P6kf3P008196;
	Tue, 25 Jun 2024 09:08:55 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yx9b0nqeh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 09:08:55 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45P98nZ953477862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 09:08:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F11D2004B;
	Tue, 25 Jun 2024 09:08:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6241620043;
	Tue, 25 Jun 2024 09:08:49 +0000 (GMT)
Received: from [9.152.224.141] (unknown [9.152.224.141])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Jun 2024 09:08:49 +0000 (GMT)
Message-ID: <6a4b95aa-f3d1-4da1-9017-976420af988b@linux.ibm.com>
Date: Tue, 25 Jun 2024 11:08:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/netiucv: handle memory allocation failure in
 conn_action_start()
Content-Language: en-US
To: Yunseong Kim <yskelg@gmail.com>, Markus Elfring <Markus.Elfring@web.de>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        =?UTF-8?Q?Christian_Borntr=C3=A4ger?= <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, MichelleJin <shjy180909@gmail.com>
References: <20240623131154.36458-2-yskelg@gmail.com>
 <bb03a384-b2c4-438f-b36b-a4af33a95b60@web.de>
 <880a70f0-89d6-4094-8a71-a9c331bab1ee@gmail.com>
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <880a70f0-89d6-4094-8a71-a9c331bab1ee@gmail.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4q3LhkXKYnOblU2uwBXfY9zww4XqU8o6
X-Proofpoint-GUID: 5g2k-TDirpq0BMpEIfJ6bDX8LPhDlNic
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_04,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 phishscore=0 mlxlogscore=809 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406250064



On 24.06.24 20:00, Yunseong Kim wrote:
>> 5. Under which circumstances will development interests grow for increasing
>>    the application of scope-based resource management?
>>    https://elixir.bootlin.com/linux/v6.10-rc4/source/include/linux/cleanup.h#L8
> I am considering the environment in which the micro Virtual Machine
> operates and testing the s390 architecture with QEMU on my Mac M2 PC.
> I have been reviewing the code under the assumption of using a lot of
> memory and having many micro Virtual Machines loaded simultaneously.
> 
>> Regards,
>> Markus
> I really appreciate code review Markus!
> 
> 
> Best regards,
> 
> Yunseong Kim

(answering the V1 thread first. Content related comments will follow in V2 thread)

s390/netiucv is more or less in maintenance mode and we are not aware of any users.
The enterprise distros do not provide this module. Other iucv modules are more popular.
But afaiu we cannot remove the source code, unless we can prove that nobody is using it.
(Community advice is welcome).

Yunseong, I'd be interested in why you are running this module with QEMU on your
Mac PC?

Alexandra

BTW, your full name is shown in this reply, but not when you send
the patches. See:
https://lore.kernel.org/lkml/?q=s390%2Fnetiucv%3A+handle+memory+allocation+failure+in+conn_action_start%28%29
You may want to check your settings.
