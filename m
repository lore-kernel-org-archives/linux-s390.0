Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA141A239D;
	Wed, 18 Dec 2024 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734524805; cv=none; b=dwWHuw9Nwi/sbayzzuf4NNBSyWQLGDgZTnX53OK75XaEg1ecY8IBIEo58MHwx+rnipa2Z/2tob8lAFzeH2gfp/n+kvbdgD4Trv1gN98Qu3X0Sq1/GQnzqcr2y7WdwW5oFTLtlwMt2hgGtEe8G5j/rPjbIUuAZlD5Yj07TbQQW54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734524805; c=relaxed/simple;
	bh=JI+TcQRUzFQtEBVzclbiRV6gysvK9wFPfR+PDn1FOhM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:Cc:
	 In-Reply-To:Content-Type; b=jF99RsyYI/f6PpGwaA14zoGOlH4EVgjbTblBqi81dpSogRHtnQW0Exr8/XN2kPavF5SRJAeSlZ5XkYafYkwniUpBRLa2Jf2FkGqHcjOZUhBvGhtalqm40FyMmPA46RYkEU1aSivIEQAsReh6ZyxjE+C7HykgEaxhY1xrb4tLJ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WYRER3lc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WYRER3lc"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHNwFSV032381;
	Wed, 18 Dec 2024 12:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eFrsQc
	TBIx3s7uS9Y7bfcZKk8X3P8e0tLJokQz2DKjg=; b=WYRER3lcvrXiAchm26jxBm
	rm9RUFxcdBVf50tzDV/IsOHxHruyRtOBSZr+Dz5AKR5//zgkzWTBbtg2fqo+4hlA
	8Hs2szE58lTI5FzT2u1HLOvRFQRrXAkZskIi45lFzLRq6HtDTCdvtdrWPVP/Ec+p
	cVHqVcFN+ltrg9S4sYyTPX01djFWgdVIYP2pcUCYFJn7Z8b9ncMcNlmDtrK5XZK5
	/akKoT38rMmg8OZOV1PXKOPfrWSpX8fENzy9mmhEc85WZC9SxTmmtR1vxa/TGH5M
	g9vhWIwf8sqOBMrEwayMHPCk5ebybaAEg9LfzY8sd7xqVa31SnCeVN12XFqEmkSA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43kkehaupb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 12:26:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI8VdhO005549;
	Wed, 18 Dec 2024 12:26:40 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnbn7t1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 12:26:40 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BICQcdO18874858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 12:26:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7496220043;
	Wed, 18 Dec 2024 12:26:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FD8820040;
	Wed, 18 Dec 2024 12:26:38 +0000 (GMT)
Received: from [9.171.87.168] (unknown [9.171.87.168])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Dec 2024 12:26:38 +0000 (GMT)
Message-ID: <aa6c671d-f4f4-446d-b024-923555c3f041@linux.ibm.com>
Date: Wed, 18 Dec 2024 13:26:37 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Alexandra Winter <wintera@linux.ibm.com>
Subject: Re: [PATCH] net: Convert proto_ops::getname to sockaddr_storage
To: Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>
References: <20241217023417.work.145-kees@kernel.org>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org,
        ", linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        ", netdev" <netdev@vger.kernel.org>
In-Reply-To: <20241217023417.work.145-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2EFyKPV8DDG2Kq17gfWxx8slnK4VXWGo
X-Proofpoint-ORIG-GUID: 2EFyKPV8DDG2Kq17gfWxx8slnK4VXWGo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 spamscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412180096


I had to shorten the CC-List to get this message through our mailserver, sorry about that.

On 17.12.24 03:34, Kees Cook wrote:
> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index 7929df08d4e0..2612382e1a48 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -848,14 +848,14 @@ static int iucv_sock_accept(struct socket *sock, struct socket *newsock,
>  	return err;
>  }
>  
> -static int iucv_sock_getname(struct socket *sock, struct sockaddr *addr,
> -			     int peer)
> +static int iucv_sock_getname(struct socket *sock,
> +			     struct sockaddr_storage *addr, int peer)
>  {
>  	DECLARE_SOCKADDR(struct sockaddr_iucv *, siucv, addr);
>  	struct sock *sk = sock->sk;
>  	struct iucv_sock *iucv = iucv_sk(sk);
>  
> -	addr->sa_family = AF_IUCV;
> +	siucv->sa_family = AF_IUCV;


This does not compile, it needs to be:
siucv->siucv_family = AF_IUCV;

>  
>  	if (peer) {
>  		memcpy(siucv->siucv_user_id, iucv->dst_user_id, 8);


With this change feel free to add my 
Acked-by: Alexandra Winter <wintera@linux.ibm.com>
