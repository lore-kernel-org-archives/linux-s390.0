Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EB9148312;
	Tue, 25 Jun 2024 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719304034; cv=none; b=EDDkx2f721p5Z/oWm0m1m1GcoRKiC+hKggdMFgaajbDGWsCRQX/3qY2TLVxF+env2OBvHJIFiNhi5TwiRgNVWNZOYSKTNe/zBKohMepN78V9JPTZK8MrYTlOZG5fV5bPvLxHR95v7rv8JCoDrHsiPhWOfiPvWeJTajeDeh+u6u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719304034; c=relaxed/simple;
	bh=CI8xjJvXy8hgVQFzdZcF+2OFw2kjrIbBgLTXhA1PMaA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:MIME-Version; b=iCQ2sNruw+uNhOz2rxx96lSXza0RWj0tELRzcfPhE3NTABWK1eB7UbQJlffTUHLOmYx227jmx5rtCHD4Mgv2uRfPcO5fHNObS2+nsAM6VX8yYr68t2Vo4VJykyqx8NOsE49zxuDJBo/uM8QytAkZjJTINU1jysIlPgBGPfBmlpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CAHH7sn6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CAHH7sn6"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45P80sbK005626;
	Tue, 25 Jun 2024 08:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:reply-to:in-reply-to:references:message-id
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	Q1jkVkCjue3ICdr3KThRqn2LIbaga3SmjPLdfxIRJeU=; b=CAHH7sn6tom2iGem
	H/YBeX/iZQfW+D5Fc5mxzNNuArM+j9vozuU5OytOwNWtVT68LAkrs/+nOaW+8nFa
	NJskLpS4QxVu09bOkjXltR9MS8YUM2ZvPnbX7hj51VmwsDvxQZaCbtDODlXt38m+
	ZDHD+5lQtLwQCOgGYNb+pgCJz+Let8z1GKJk8UHyjazMjKOq52OIakzCarJeLH2A
	HJNsrtiD4FDGuXFSkMOKfqIt7TJ5b5A+8ZPYW1j7aMPdv9XaJcbMLp0jvXGv+gV4
	sc+xNaP6NsjR3ZPURKZWPGfQJ5hCDT9WglokepDZDq6aQOjopDzgfu8RW/zeuU2m
	h1En+g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yyshvg5hc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 08:27:10 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45P8O8ck007095;
	Tue, 25 Jun 2024 08:27:10 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yyshvg5h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 08:27:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45P6vOq8018132;
	Tue, 25 Jun 2024 08:27:09 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yx8xu5ktq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 08:27:09 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45P8R5np29229636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 25 Jun 2024 08:27:08 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADC875806F;
	Tue, 25 Jun 2024 08:27:05 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A42458064;
	Tue, 25 Jun 2024 08:27:05 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Jun 2024 08:27:05 +0000 (GMT)
Date: Tue, 25 Jun 2024 10:27:05 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: yskelg@gmail.com
Cc: Markus Elfring <Markus.Elfring@web.de>,
        Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        MichelleJin <shjy180909@gmail.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Holger Dengler
 <dengler@linux.ibm.com>
Subject: Re: [PATCH v2] s390/zcrypt: optimizes memory allocation in
 online_show()
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20240624222933.81363-2-yskelg@gmail.com>
References: <20240624222933.81363-2-yskelg@gmail.com>
Message-ID: <eefcf6fb6c66979c5b4c0a4572d64df6@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: n3dKMYpfbwhRsdh6ZxEPSGoT6EJyszxE
X-Proofpoint-GUID: qpruAK0kC173yVf-jKLm5orctywjdfb3
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=711 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406250061

On 2024-06-25 00:29, yskelg@gmail.com wrote:
> From: Yunseong Kim <yskelg@gmail.com>
> 
> Make memory allocation more precise (based on maxzqs) by allocating
> memory only for the queues that are truly affected by the online state
> changes.
> 
> Fixes: df6f508c68db ("s390/ap/zcrypt: notify userspace with online,
> config and mode info")
> Link:
> https://lore.kernel.org/linux-s390/your-ad-here.call-01625406648-ext-2488@work.hours/

What is this Link here? It is pointing to a PR for a 5.14 kernel and has 
no relation to this patch.

> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Yunseong Kim <yskelg@gmail.com>
> ---
>  drivers/s390/crypto/zcrypt_card.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/s390/crypto/zcrypt_card.c
> b/drivers/s390/crypto/zcrypt_card.c
> index 050462d95222..2c80be3f2a00 100644
> --- a/drivers/s390/crypto/zcrypt_card.c
> +++ b/drivers/s390/crypto/zcrypt_card.c
> @@ -88,9 +88,10 @@ static ssize_t online_store(struct device *dev,
>  	 * the zqueue objects, we make sure they exist after lock release.
>  	 */
>  	list_for_each_entry(zq, &zc->zqueues, list)
> -		maxzqs++;
> +		if (!!zq->online != !!online)

I don't like this line. It is code duplication from the zcrypt_queue.c 
file
and uses knowledge about the internals of the zqueue which is not 
appropriate
here in zcrypt_card.c. Please note also that usually the total number of
queues attached to a card is in a one digit range. As kcalloc() anyway 
uses
the kmalloc pool which is ordered in powers of two it is unlikely to 
really
spare some memory by only allocating a pointer space for the online 
queues.

> +			maxzqs++;
>  	if (maxzqs > 0)
> -		zq_uelist = kcalloc(maxzqs + 1, sizeof(*zq_uelist), GFP_ATOMIC);
> +		zq_uelist = kcalloc(maxzqs, sizeof(*zq_uelist), GFP_ATOMIC);

Your improvement about removal of the +1 and use the i value later 
instead
of my implementation which uses a NULL as end of list is valid and makes 
sense
to me.

>  	list_for_each_entry(zq, &zc->zqueues, list)
>  		if (zcrypt_queue_force_online(zq, online))
>  			if (zq_uelist) {
> @@ -98,14 +99,11 @@ static ssize_t online_store(struct device *dev,
>  				zq_uelist[i++] = zq;
>  			}
>  	spin_unlock(&zcrypt_list_lock);
> -	if (zq_uelist) {
> -		for (i = 0; zq_uelist[i]; i++) {
> -			zq = zq_uelist[i];
> -			ap_send_online_uevent(&zq->queue->ap_dev, online);
> -			zcrypt_queue_put(zq);
> -		}
> -		kfree(zq_uelist);
> +	while (i--) {
> +		ap_send_online_uevent(&zq->queue->ap_dev, online);
> +		zcrypt_queue_put(zq_uelist[i]);

The content of this while loop is NOT covering the old code. zq is not
set any more and thus the ap_sen_online_uevent() uses a random zq which
is a left over from the list_for_each() loop.

>  	}
> +	kfree(zq_uelist);
> 
>  	return count;
>  }

You sent another patch for the online_store() function with exactly the
same code changes. I would see these changes as one patch and don't want
to have more or less equal changes spread over two patches.

I am sorry, I will not pick this and the online_store() patch.

regards Harald Freudenberger
