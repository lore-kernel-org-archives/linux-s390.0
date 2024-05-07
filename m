Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C04315EFAE;
	Tue,  7 May 2024 13:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090023; cv=none; b=CjBEEdw2YKzJ6kbPm9YmVidBeMtnT7r4u74oqn4LIQPumtFFr9h8TeraKNlm1qQkxw467LQrekn57Qx/Ft2lswAPTbTiGEb1NeyBOCJtPQavBXPh/dF+2pyFwjPCtpOPgYpCGUiBYSsnQVQl/eVANtTNupmrp+94gEb81Z/d1+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090023; c=relaxed/simple;
	bh=QSB7S/LhI6JWUqm9lJDQdaIp2gPu/DOcCrLhezWQFN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EcqWfrvTRivf87cCt3YZ62ltYbkhbcFK71TDa7awhkXoykZlJs0Ciln6d89eKbbxHKF+ipH2QWLUDpLqajnTVQvcHsRsz/lVh72fbJm0TaPtm9+bwA1whkKnV6Nhuzk74A3+FtS81/A52HddqCt2ftlS0ZAPUTVcIIYxV40pkNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lKiwXRgo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lKiwXRgo"
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 447DgAWK027989;
	Tue, 7 May 2024 13:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5Cllnt0584C2d9JWXBonYHexJ7Kt7quU4B5rCiNuDu4=;
 b=lKiwXRgoC38gQkjgwSLux11Ivt5uzNtzAGnhwzeyq3tIY/tNbTya041ia3bALWUanSq/
 8rdrTJKGXyoDRZYAF/xZnvnOB/tv7G4SZg5VFn1K8Y4eGGhuFWeAhRJ0vnR0r7IzR/EF
 w/Vjyt3zOqY/W0JPwe/U8qhELx3fhIilUr0Igfrc4sj2AllfLGTIlj39S3/iM/guGx2n
 x5N4LAq5RLHd8RuOhRnGDaAejy2+A/B9SaaTABz/wdH68l9BqApPUchehPOLGY4QUoKq
 6Mx4t/krvpJF6Sw4Duhs22GBS0suJVo0kp5U7589/DS5ykLvKnOWV8gYlPdDq+Yb5quI uw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xyndn011x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 13:53:40 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 447DrdtA015788;
	Tue, 7 May 2024 13:53:39 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xyndn011t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 13:53:39 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 447ClfdS010584;
	Tue, 7 May 2024 13:53:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xx0bp6f86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 13:53:38 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 447DrXUG56754622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 May 2024 13:53:35 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFBF020043;
	Tue,  7 May 2024 13:53:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CCC220040;
	Tue,  7 May 2024 13:53:32 +0000 (GMT)
Received: from [9.171.75.172] (unknown [9.171.75.172])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 May 2024 13:53:32 +0000 (GMT)
Message-ID: <f121b42b-bde5-4a40-a61b-5c8a97a25827@linux.ibm.com>
Date: Tue, 7 May 2024 15:53:32 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390/pkey: use kvfree_sensitive() to fix Coccinelle
 warning
To: Jules Irenge <jbi.octave@gmail.com>, svens@linux.ibm.com
Cc: borntraeger@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com, freude@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <ZjkRlmoCtpsR-bBC@octinomon.home>
Content-Language: de-DE
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <ZjkRlmoCtpsR-bBC@octinomon.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jISLAJNWvulb0UUZFACxiJDomZXIgCFj
X-Proofpoint-ORIG-GUID: aqUcxu8K29swAtnzzdbpRUSbrsi2gEUv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_07,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405070095

On 06/05/2024 19:21, Jules Irenge wrote:
> Replace memzero_expliocit() and kfree() with kvfree_sensitive() to fix
> warnings reported by Coccinelle

Thanks Jules for pointing that out. But instead of using kvfree_sensitive() I would recommend kfree_sensitive() here. We're not on a performance critical path so kfree_sensitive() would be in my opinion the better choice, because we don't need to take care about the right size.

> WARNING opportunity for kfree_sensitive/kvfree_sensitive (line 1506)
> WARNING opportunity for kfree_sensitive/kvfree_sensitive (line 1643)
> WARNING opportunity for kfree_sensitive/kvfree_sensitive (line 1770)
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
> Changes in v2:
>  - merges all patches that fixe same problem into one
> 
>  drivers/s390/crypto/pkey_api.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
> index dccf664a3d95..e1dd7e0bdfd4 100644
> --- a/drivers/s390/crypto/pkey_api.c
> +++ b/drivers/s390/crypto/pkey_api.c
> @@ -1503,8 +1503,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
>  		rc = pkey_keyblob2pkey(kkey, ktp.keylen, ktp.protkey.protkey,
>  				       &ktp.protkey.len, &ktp.protkey.type);
>  		pr_debug("%s pkey_keyblob2pkey()=%d\n", __func__, rc);
> -		memzero_explicit(kkey, ktp.keylen);
> -		kfree(kkey);
> +		kvfree_sensitive(kkey, ktp.keylen);

kfree_sensitive(kkey);

>  		if (rc)
>  			break;
>  		if (copy_to_user(utp, &ktp, sizeof(ktp)))
> @@ -1640,8 +1639,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
>  					&ktp.protkey.type);
>  		pr_debug("%s pkey_keyblob2pkey2()=%d\n", __func__, rc);
>  		kfree(apqns);
> -		memzero_explicit(kkey, ktp.keylen);
> -		kfree(kkey);
> +		kvfree_sensitive(kkey, ktp.keylen);

kfree_sensitive(kkey);

>  		if (rc)
>  			break;
>  		if (copy_to_user(utp, &ktp, sizeof(ktp)))
> @@ -1767,8 +1765,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
>  					protkey, &protkeylen, &ktp.pkeytype);
>  		pr_debug("%s pkey_keyblob2pkey3()=%d\n", __func__, rc);
>  		kfree(apqns);
> -		memzero_explicit(kkey, ktp.keylen);
> -		kfree(kkey);
> +		kvfree_sensitive(kkey, ktp.keylen);

kfree_sensitive(kkey);

>  		if (rc) {
>  			kfree(protkey);
>  			break;

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com
