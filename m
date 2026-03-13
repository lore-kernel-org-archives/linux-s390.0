Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65DC387356
	for <linux-s390@vger.kernel.org>; Fri, 13 Mar 2026 09:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773392811; cv=none; b=EFfoMY8RK/HYTT+uyTXjEk6K3M+VzkQyfbx5cAiqOcraE9uEHZzxQgxVT9OzxKEbG2qvfeRJH6f5L0GInUUgQcEAHh3UsuTavxW8RU+z+/7LnoGnY944o5vVz+vWIcBsO6MPMNTz2KossoMRuVaJkb+VgG44i7M6TItHKNaExUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773392811; c=relaxed/simple;
	bh=ta6eHrArHO3GJYCrKSKCHHlu19z8tz1u2DSy6DpPOLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neTIECHxU71Q3l0nEIB92tdrf8yDsAuoex8VunCjylwmFzMJ72KL43Z1Fib97+K6VIJy6I6hJNSFLhUKqeWgtZa13XuvTgaCzqlJOqNnowD61eONB05t9WflFXn+gNBR4Vqb9zwomK2AZTlBZhz1rpQ3Um3i40u2tE22qX8pi8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=taKggpPl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="taKggpPl"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D27PLG2258820;
	Fri, 13 Mar 2026 09:06:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=UDfFy0445DGwzRuiG+n45+4dV8ne2z
	7StYgEZHpX7r8=; b=taKggpPlQjpJW8JcNjtsytoWR2u7/FWUC3xut9szfs/pJF
	r0w9Z2SDcX7EEYX4Ms8lfchAntS3HNKnxkXGkNFcisP3NFAiRKw7dIcqdA1OrycK
	wipfM9XOgljgD2Jp6jGYpYedxD0tKwmLc0rpRCfBhbIbnGV2rKtXHTWxX+fhI4Ss
	RHgvDXLYTQ//BQrA/4OBxxxPBeToNOI1ZMKS3ANWXPomnGxrYgIN1P+qoSY+qU0X
	eODS/epqEdc993TdUu9Z6xsIEOjZ1ODLQDM7nAuj5757HvKenM0GxZOF79HjrCdL
	4sizZDxIECkmCbo0VlXINSZGnCjpooFNi0VF4APQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh92ey82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 09:06:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62D53AK4014667;
	Fri, 13 Mar 2026 09:06:47 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha8e013-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 09:06:47 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62D96hwe58458506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 09:06:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C4622005A;
	Fri, 13 Mar 2026 09:06:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C09FF2004E;
	Fri, 13 Mar 2026 09:06:42 +0000 (GMT)
Received: from osiris (unknown [9.111.5.66])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 13 Mar 2026 09:06:42 +0000 (GMT)
Date: Fri, 13 Mar 2026 10:06:41 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: lirongqing <lirongqing@baidu.com>, Holger Dengler <dengler@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/pkey: Remove synchronize_rcu from
 pkey_handler_register
Message-ID: <20260313090641.13729Aae-hca@linux.ibm.com>
References: <20260313052312.2389-1-lirongqing@baidu.com>
 <058c161c4e82d2d78ddb9c52cfc8ee50@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <058c161c4e82d2d78ddb9c52cfc8ee50@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RccSYkCGrQqFYCFugMZzYZbhqU_ginuk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA2OSBTYWx0ZWRfX1BGLLMmzRXzm
 R9xg5BU6LdA3zf5WdbRoqDATxZ54LoZsrLZZQCh6MiEQNS4r34DYT3e/5xSgNHVx+dvD//+m34L
 Mdfent01wWmzYK4/0Tuem0C6MB/pvUoYv/pAGofpEc80lURwi5cjV0+ZPeHId6epEBOQBbOzBOY
 3VFPfpZZAK+NOrsreAxn7M+Lw/oLMP/AakmDiH1FYKZedFiQjpZTe7DiATZUWZdTNB9JLbfzfE3
 02cD5OENdE5fUPxV7aegeN9OLSW49vdN6tU1TL+viBXVAuPy87PrMMJWYbi0gudVHqWYyYBu+xZ
 VEN5r05kQpPbgmRjec5uyIRlWAVHGK4rBGzUmGkwuha2iCFw4Q2sf0s6NuaDwGVv/Ci0v8IHY+u
 scGdxuNg7XiykUKOD6Yxc9Ee9rGyXwc7ObKlOLFjrMRPtFPGO+KBbKN8Jo46zitF14abkxp2Ehm
 lg+eziRHnrMFAmeDwEg==
X-Proofpoint-GUID: RccSYkCGrQqFYCFugMZzYZbhqU_ginuk
X-Authority-Analysis: v=2.4 cv=XNk9iAhE c=1 sm=1 tr=0 ts=69b3d3a8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=zuLzuavZAAAA:8
 a=VnNF1IyMAAAA:8 a=k6490w7z2KT0A4n5li8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130069

On Fri, Mar 13, 2026 at 09:32:39AM +0100, Harald Freudenberger wrote:
> On 2026-03-13 06:23, lirongqing wrote:
> > From: Li RongQing <lirongqing@baidu.com>
> > 
> > The synchronize_rcu() call after adding a handler to the handler_list
> > is redundant because RCU readers will either see the old list or the
> > new list. Removing this synchronization point reduces the blocking
> > time during handler registration.
> > 
> > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > ---
> >  drivers/s390/crypto/pkey_base.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/s390/crypto/pkey_base.c
> > b/drivers/s390/crypto/pkey_base.c
> > index d60cd98..c2e29d6 100644
> > --- a/drivers/s390/crypto/pkey_base.c
> > +++ b/drivers/s390/crypto/pkey_base.c
> > @@ -60,7 +60,6 @@ int pkey_handler_register(struct pkey_handler
> > *handler)
> > 
> >  	list_add_rcu(&handler->list, &handler_list);
> >  	spin_unlock(&handler_list_write_lock);
> > -	synchronize_rcu();
> > 
> >  	module_put(handler->module);
> 
> Thanks Li RongQing
> 
> Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>

With synchronize_rcu() you do know that other CPUs will see the new
list after this function returned, without not. Is that ok?
