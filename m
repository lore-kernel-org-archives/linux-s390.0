Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F25199E82;
	Tue, 13 Aug 2024 13:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723556163; cv=none; b=K2N1rHLjNujCjgGt1wZRPKGclmDkvS0omSJFZMGahLhVgJYKN5Nrp7PKdYh64a4nuAPrDfPROKUXK56eGQKd3mb8FrCiKLRt/Xv9nw1lo/WTnKHw/H0fXQlQmAvjMN1Kmy0WdWZysMCMYx7YjisBAXi5yD26zR78lc4UG1nhoYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723556163; c=relaxed/simple;
	bh=Gkg0BwLnMk3aPALRTPUQuNCSk3s0d/bldCGAaKSAMOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NzH40i3UAAZMn3PRATLXQzB7mLaFLEK0VddujYIteVX80X+QaYkncGLGj1JqNfkj9QliqQT1bWDQxQMV7F4NHXAhjiWa14ll/LQQXwbpHZT6qPwyhfTgNcHeOoA1Z3n2KsUG0qbd+tK435FESZij/J9ODqFBmbvkQNSjbpHW97M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XLlAF8HK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XLlAF8HK"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D3wN7K015926;
	Tue, 13 Aug 2024 13:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=3
	lJ7ufApJ3WrBKr2+j4OA0WfYzY72XZhoVhPSoAYrm8=; b=XLlAF8HKz5jfRPG14
	yQq5GzUUTDuua0V6C5yKyyFH556RsBne2j2ZL0UXq7qsjXtxnQUwrAz4msgqO1IK
	UFRg++dNQFV4QM+ilcIoD9CQZCqP5TMMmnW6gKrVnAPdpiUi5Glqpth3lWAiaKmB
	jXWjzidFNmGXKP5TC1amx7xyI57Kzm8sV2/uhTtuNtMq1mXhlVzd8VZtWNWb2JHI
	Vm2EkNErZutWtJiD1DD+cSAgdCzYgmgiwwzxMNEFQ65zCtf4FsWQnLr2WJz1XFDQ
	BhTd/VKdMaBRtw/uYiGwk4ggqaelr4fcauKyqyRzqrAZOE2fKrgu192RImna6Giy
	bhqGA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40xr5de7qr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 13:35:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47DBukL4016309;
	Tue, 13 Aug 2024 13:35:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40xkhpksqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 13:35:54 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47DDZn3B55443766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 13:35:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF93A20043;
	Tue, 13 Aug 2024 13:35:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A309720040;
	Tue, 13 Aug 2024 13:35:48 +0000 (GMT)
Received: from [9.171.22.151] (unknown [9.171.22.151])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Aug 2024 13:35:48 +0000 (GMT)
Message-ID: <221ba279-e48b-4002-9530-c6186e3e8042@linux.ibm.com>
Date: Tue, 13 Aug 2024 15:35:48 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] s390/iucv: Fix vargs handling in iucv_alloc_device()
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        linux-s390@vger.kernel.org
References: <cover.thread-d8267b.your-ad-here.call-01723545029-ext-2515@work.hours>
 <patch-2.thread-d8267b.git-d8267bded9e9.your-ad-here.call-01723545029-ext-2515@work.hours>
 <2024081331-bonnet-fiftieth-9a14@gregkh>
 <your-ad-here.call-01723549827-ext-8444@work.hours>
 <2024081319-patriarch-brutishly-653f@gregkh>
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <2024081319-patriarch-brutishly-653f@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jGnAHsZNFOB64koH2_Q4V5dsY3Bu2YNu
X-Proofpoint-GUID: jGnAHsZNFOB64koH2_Q4V5dsY3Bu2YNu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_05,2024-08-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408130098



On 13.08.24 14:43, Greg Kroah-Hartman wrote:
>>> I don't understand, why can't dev_set_name() be called here?
>>>
[...]
> 
> But step back, why is this needed at all anyway?  No other subsystem or
> driver needs/wants this, what makes this api so special?  Why not figure
> out your name beforehand?
> 
> thanks,


Vasily, the following update to Heiko's patch does not touch lib/kobject.c
According to a quick test it still solves the original issue and does compile
with W=1 and iucv as a module.

diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index 64102a31b569..6a819ba4ccab 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -86,13 +86,17 @@ struct device *iucv_alloc_device(const struct attribute_group **attrs,
 {
        struct device *dev;
        va_list vargs;
+       char buf[20];
        int rc;

        dev = kzalloc(sizeof(*dev), GFP_KERNEL);
        if (!dev)
                goto out_error;
        va_start(vargs, fmt);
-       rc = kobject_set_name_vargs(&dev->kobj, fmt, vargs);
+       rc = vsnprintf(buf, 20, fmt, vargs);
+       if (!rc)
+               rc = dev_set_name(dev, buf);
        va_end(vargs);
        if (rc)
                goto out_error;



Maybe Greg has somethign like this in mind?
