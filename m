Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA611148FF9;
	Tue, 25 Jun 2024 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719306571; cv=none; b=RGTylgKwlLsuoUlB4rCzh2osXDw8W4aL/R7LXO6FigHuxWHm/a2GLI9Onj+lKYK9TIenhrEeZkF+xpJSBW8RsTo8iKdzry/GWuEP93AadlT8HrTKWDbuGKRWw96dlkdETN0cGcRg03/FQaGN5qgQitLcaUNXz2uyit4MpdRIkNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719306571; c=relaxed/simple;
	bh=+B9dTFZIaW4cQW42WV0VccjrhsA/xnVkExPPQav3t2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FFuHtBSCyH29xj77RTFjfV1O9V5zD6Gp2o6VaOfCsoLZGYx5okd3TbEncE9dq8/QrSCysRjWFWZ0u/1ksybFpgDC1I3QdAG2BBXEE2SZzlxC9r3oMdpMcW/0EJNFRT4RIgLF13KH0jxA4+9fL81oMVRcfie3N2z0V0ytVouaJ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ocyt5oyU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ocyt5oyU"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45P8uuSV005270;
	Tue, 25 Jun 2024 09:09:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=x
	gTJcC1NoV0QP1ImKxECWxCuCu3EOkToc4qJdOQGxjc=; b=ocyt5oyUF0rqU+Q8R
	x+zroPfvPPput0xLTZvW7kl5/5HuaLoaEwx+neApb3ex2laQy+4dArkcFpj3vLKX
	fSw/EmaY1XAy6bZvlK9V2C4FbGEnm+4vDIW/PS/RPuDoUD1ypOa4sz5aLHUKbJaA
	H7SQRqJfKP+HsUBUQSWYYbPlKQORplFKkMSq0zs+FCmR4Fp7NdvwjdvrpSQTc4C3
	ZIXpJpc1iJystFxlAohVDwSF2URAwOn8zVHrJD9sv4/q/ZdL1D1IhdyeWhDeGX4D
	7rlYUYRASWutCy4GKWLUlqZHcB7W3ckmOct/LGwC1xMFSU4JNVquW5LgGt9ybpxC
	xrymQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yytdm035h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 09:09:28 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45P99SJ2026727;
	Tue, 25 Jun 2024 09:09:28 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yytdm035f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 09:09:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45P7lBYn000564;
	Tue, 25 Jun 2024 09:09:27 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yxaemweyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 09:09:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45P99LKY50201076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 09:09:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6428E2004D;
	Tue, 25 Jun 2024 09:09:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 218B320043;
	Tue, 25 Jun 2024 09:09:21 +0000 (GMT)
Received: from [9.152.224.141] (unknown [9.152.224.141])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Jun 2024 09:09:21 +0000 (GMT)
Message-ID: <beac131a-6c8c-4ed7-8714-416c57ea0fbb@linux.ibm.com>
Date: Tue, 25 Jun 2024 11:09:20 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390/netiucv: handle memory allocation failure in
 conn_action_start()
To: yskelg@gmail.com, Thorsten Winkler <twinkler@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Markus Elfring <Markus.Elfring@web.de>
Cc: MichelleJin <shjy180909@gmail.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240625024819.26299-2-yskelg@gmail.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20240625024819.26299-2-yskelg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hN4so40EoBdfJmWpzv3LNbD5J88xwPs8
X-Proofpoint-ORIG-GUID: 5GTyUk6TyUfGCh_iUl8LLOm46BM_EQsn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_04,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=686 spamscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406250064



On 25.06.24 04:48, yskelg@gmail.com wrote:
> From: Yunseong Kim <yskelg@gmail.com>

Thank you very much Yunseong, for finding and reporting this potential 
null-pointer dereference.
And thank you Markus Elfring for your valuable comments.

> 
> A null pointer is stored in the data structure member "path" after a call
> of the function "iucv_path_alloc" failed. This pointer was passed to
> a subsequent call of the function "iucv_path_connect" where an undesirable
> dereference will be performed then. Thus add a corresponding return value
> check. This prevent null pointer dereferenced kernel panic when memory
> exhausted situation with the netiucv driver operating as an FSM state
> in "conn_action_start".

I would prefer an even shorter commit message. Allocating memory
without checking for failure is a common error pattern, I think.

> 
> Fixes: eebce3856737 ("[S390]: Adapt netiucv driver to new IUCV API")
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Yunseong Kim <yskelg@gmail.com>
> ---
>  drivers/s390/net/netiucv.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/s390/net/netiucv.c b/drivers/s390/net/netiucv.c
> index 039e18d46f76..d3ae78c0240f 100644
> --- a/drivers/s390/net/netiucv.c
> +++ b/drivers/s390/net/netiucv.c
> @@ -855,6 +855,9 @@ static void conn_action_start(fsm_instance *fi, int event, void *arg)
>  
>  	fsm_newstate(fi, CONN_STATE_SETUPWAIT);
>  	conn->path = iucv_path_alloc(NETIUCV_QUEUELEN_DEFAULT, 0, GFP_KERNEL);
> +	if (!conn->path)
> +		return;
> +


On 25.06.24 09:24, Markus Elfring wrote:
> 
> Would the following statement variant become more appropriate here?
> 
> +		return -ENOMEM;

conn_action_start(), like the other fsm functions, does not have a return value.
But simply returning will not prevent the next fsm function from trying to use
conn->path.

So I think you need to do
fsm_newstate(fi, CONN_STATE_CONNERR);
before you return.

You could use rc = -ENOMEM and a goto to the IUCV_DBF_TEXT_ debug message,
if you want to. But I am not too concerned about the details of error handling:
If your memory is so scarce that you cannot even allocate a handful of bytes,
then you should be seeing warnings all over the place.














