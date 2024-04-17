Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B63146A78;
	Wed, 17 Apr 2024 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367420; cv=none; b=iBSystczLJEeGBlhz8sG2BwxJRY76TaYL+3ixV4AnaozNBtbdtXuuNd3ebFieQUpqIN7xkK3h7KhImpNuw9fot6BTRGvT2dIS6ucLPFElwd/uTR3X32DH8+a2/vkknQxuvUnKSaEeTCP+JDBSm5dfuwuw8qqe3K9lunLME73cUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367420; c=relaxed/simple;
	bh=t72LWSu3Jjej3w7YCiGbfwV/JlbBQKGaW+A+qqCQCTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YtYvngiKhJ0ulYjAymBv7V92oetbKRFmU8mDE11DegqUcZrvNFN6fswSvsau14heZ4gHv8a3D7VMgdNXe1a9el/ESjMJgDX6UE4tODGebvf5VdvCB1Vim/4ugLkQF4UkPZDj2AGrCdlwIjXAnhgBXz5kWKBlXPnr4VxwIo5JrKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rm53sb2S; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rm53sb2S"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43HEsjLj024799;
	Wed, 17 Apr 2024 15:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=gb55ckXREFJBB0DenpnyRRo6IHMQlPCq0DXKj1EMzqY=;
 b=rm53sb2SYIBCPQodFZkcT/9HQDcMa4pLT+5N4xiOKge1ycHDRh59uTO3k72ee+yN1MMg
 I0f1on2H24uu53i+CJi1cV0lhu/Uq4qQfet8jrxbaUka6m57B1wI9w4UQd1k6wnN33iv
 iDp0aqHuH1tzVvnYWVE7o6lqoHMfMeuka10retSi1pOS1/kRMZbi5yJ/Cg92oe6m2jCX
 UCRhIsPx/VcXNUma6eVj+LBNWV4nwokcw8C+h1Pce+2/g9FLWhE7EYMSwMT9xnY1BhTP
 2BRA3A4KsXZwhteWD5pAYX9OX43efwgzuW7EWYhFaw/7Zs//M5fMScX1UiBrfRNYZp4t /g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xjg6vg4tr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 15:23:29 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43HFNS7a011192;
	Wed, 17 Apr 2024 15:23:28 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xjg6vg4tk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 15:23:28 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43HExNHJ023582;
	Wed, 17 Apr 2024 15:23:27 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg5cp57g7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 15:23:27 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43HFNOwx21889688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 15:23:26 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B337258055;
	Wed, 17 Apr 2024 15:23:24 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA0895804E;
	Wed, 17 Apr 2024 15:23:21 +0000 (GMT)
Received: from [9.171.10.59] (unknown [9.171.10.59])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Apr 2024 15:23:21 +0000 (GMT)
Message-ID: <c6deb857-2236-4ec0-b4c7-25a160f1bcfb@linux.ibm.com>
Date: Wed, 17 Apr 2024 17:23:21 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: fix potential sleeping issue in
 smc_switch_conns
Content-Language: en-GB
To: shaozhengchao <shaozhengchao@huawei.com>,
        Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc: jaka@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, weiyongjun1@huawei.com, yuehaibing@huawei.com,
        tangchengchang@huawei.com
References: <20240413035150.3338977-1-shaozhengchao@huawei.com>
 <6520c574-e1c6-49e0-8bb1-760032faaf7a@linux.alibaba.com>
 <ed5f3665-43ae-cbab-b397-c97c922d26eb@huawei.com>
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <ed5f3665-43ae-cbab-b397-c97c922d26eb@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aE95vdaohLbVd6VI6kpCcFw28kP0BiFH
X-Proofpoint-GUID: iwSlbio5-4En3iCFFMLJgiYrnYrNGVRh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_12,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 phishscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2404010000 definitions=main-2404170106



On 17.04.24 10:29, shaozhengchao wrote:
> 
> Hi Guangguan:
>    Thank you for your review. When I used the hns driver, I ran into the
> problem of "scheduling while atomic". But the problem was tested on the
> 5.10 kernel branch, and I'm still trying to reproduce it using the
> mainline.
> 
> Zhengchao Shao
> 

Could you please try to reproduce the bug with the latest kernel? And 
show more details (e.g. kernel log) on this bug?

Thanks,
Wenjia
