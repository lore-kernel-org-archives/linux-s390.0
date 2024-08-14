Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF40C1AC43B;
	Wed, 14 Aug 2024 13:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723641738; cv=none; b=aKGKEUlm1JrK29NMMqVm8CI1o0y6g3vSQ3JpbzYfWjvmDNX4ViPErVFPEpaf6JKMipI3k6jZRE+odTLEZaMM/d2gdAvs31sgnYUIMON0L9/L1nJ9EiLucUxwW9EOWA8+z6wx6/jj5UDCuQuBA7JB4d4kfKZvS6cGN07uy7cTbcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723641738; c=relaxed/simple;
	bh=52woe/DhP6yxVtoJ7+/JjkpqgmOTnHaYBvNtOBgqJ9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ltFInKF7oCOAVMTWyOeXUDxSv04AJ4muL4nq1ktQpDu7vq94Pb0Ls/jqx8p46v8X/g5uG19qXWSb6m+kNcX3KdxlhIwVMos6XbN8A4wxJgnIboGo7Uv9G/eIZOn8CN5+OpnwavAa+6HvxDdFvLXUlJhiMgJU2Y921tYoGdLkeaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LeermY8z; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LeermY8z"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EBnJoU032754;
	Wed, 14 Aug 2024 13:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=5
	2woe/DhP6yxVtoJ7+/JjkpqgmOTnHaYBvNtOBgqJ9Y=; b=LeermY8zHzSZhQJ2s
	rRYUW2uDhXMXxrOV6Ie/s6OW2Euuqd6PG6eENANPgn6Sa5gc3XqJM++JBt9M+/Sf
	vez1J/ndQ37EcsBGnERJdDSHW/zLy9Riugf2CFSlh28maRbIMgtyffFqMDQMpmlU
	GRb6WiCPHzZClygtnmMAcPLtZKCkn32L0eIE1xAbU/Iv80F7/j6luIt1eNF58fhs
	RmazMSCJFCweF3rWDL2CkH83KtLbw7NukREKSgVJlzepORtMzyzOu0D4Kq0UQr3K
	rXvfybw5HPbau7DRjwYQiFgAcgW0ucTrRekMKIILBgJMzxZFLysWAxveRrvprEoy
	tyx0Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 410v1vrcta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 13:22:06 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47EDM5bo024245;
	Wed, 14 Aug 2024 13:22:06 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 410v1vrct3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 13:22:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47ECnG69011511;
	Wed, 14 Aug 2024 13:22:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40xjhu9puu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 13:22:04 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47EDLxks51380600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 13:22:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DA312004F;
	Wed, 14 Aug 2024 13:21:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0984E2004D;
	Wed, 14 Aug 2024 13:21:59 +0000 (GMT)
Received: from [9.152.224.208] (unknown [9.152.224.208])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Aug 2024 13:21:58 +0000 (GMT)
Message-ID: <64c2d755-eb4b-42fa-befb-c4afd7e95f03@linux.ibm.com>
Date: Wed, 14 Aug 2024 15:21:58 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net,v4] net/smc: prevent NULL pointer dereference in
 txopt_get
To: "D. Wythe" <alibuda@linux.alibaba.com>,
        Jeongjun Park <aha310510@gmail.com>, wenjia@linux.ibm.com,
        jaka@linux.ibm.com, tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
        gbayer@linux.ibm.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, dust.li@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240814104910.243859-1-aha310510@gmail.com>
 <e2d56814-0664-4c3a-9d5f-3f32dc15ccd4@linux.alibaba.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <e2d56814-0664-4c3a-9d5f-3f32dc15ccd4@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0y2k-9VOra7wgj4QZyRJI0DyzkO0nLHd
X-Proofpoint-GUID: OfSvat6veq4dpmJSbr2dUiDsrpezpumY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_09,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=748 clxscore=1015 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408140092



On 14.08.24 15:11, D. Wythe wrote:
>     struct smc_sock {                /* smc sock container */
> -    struct sock        sk;
> +    union {
> +        struct sock        sk;
> +        struct inet_sock    inet;
> +    };


I don't see a path where this breaks, but it looks risky to me.
Is an smc_sock always an inet_sock as well? Then can't you go with smc_sock->inet_sock->sk ?
Or only in the IPPROTO SMC case, and in the AF_SMC case it is not an inet_sock?
