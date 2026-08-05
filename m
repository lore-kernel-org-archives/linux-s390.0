Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31DF3D954F
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 08:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785919683; cv=none; b=pg7xcd/CJmBL9xzqkSHLRyT+0aAH32AckaQ+u/63qYXlQEs4IS2F7bLfOc2D57Mj9Fdj6NoC+Pu5FEXwH/BmmLU9m+uKBU3K5WyT/romjC4wnIml1EDWJrJwgOM3YpM+D9/W/ZvTLmL6jTFjCLJnAhCAj2ffGvdPHj0pjbp7q7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785919683; c=relaxed/simple;
	bh=Oxg+LdUvBdY7n0b7KylSd/LYzFZB8MEgmOLlW9OZweM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=fv9TnS0kbc0le50D3j1gxhR4qb/PxP3hqpiT6YUS4+KZZrMHpkMmLxoyYF/h3Iz4tz3anXVXU5Iw+QPVahRu5VmhqrtDoWXz8MaRJP1p+zjnh89oeAT/unHOXY7hf6i4pQ9uImGLdQE3XxR4yLPHzTebKm5C6LfOyniFm+xPWuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T2VyMWzO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T2VyMWzO"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758lgfD3288631
	for <linux-s390@vger.kernel.org>; Wed, 5 Aug 2026 08:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=8MRP1tsthj3phXQBIh4XQ9pWOEIRUpdSEAlQM2+hFFU=; b=T2VyMWzOcqSS
	XFiIwSWbBGCjm5XE87nOHKdDMHorecJCAhsaKa8tvF9na44Fh/dq8V5JtgyRlCtj
	YC2sPN+ZBbdicksgKsE/7sntx+dYKARZySDdinlks0eOd8cDeujTWs2oWM0JMnf+
	M653delk1ZkSjv8wio3InA6UE18R1UoD+sDFTX099EoYQdnQOX00jYqKmp3A6qU0
	D7u7lqzVDOfJC+fYadcKPDybczVF8c8EUtmH8TuSIwH3dd2cJBdV95y0la4R3+x2
	17b9xwqgjsS+Yv4T9YX4evexHzMqnKJTd6Q5RSNDZ7T0mtxW3/bsONomwM3oQNx6
	yDRzlVVBCQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hsyfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 05 Aug 2026 08:48:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6758fdZE000604
	for <linux-s390@vger.kernel.org>; Wed, 5 Aug 2026 08:47:59 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtynhpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 05 Aug 2026 08:47:59 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6758lwVc4194934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 08:47:58 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CFF758068;
	Wed,  5 Aug 2026 08:47:58 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AAE655803F;
	Wed,  5 Aug 2026 08:47:57 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 08:47:57 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 05 Aug 2026 10:47:57 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Holger Dengler <dengler@linux.ibm.com>, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>
Subject: Re: [PATCH 2/3] s390/crypto: Rework ctr_paes_do_crypt() to remove
 conditional locking
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260804124705.12261Cbe-hca@linux.ibm.com>
References: <20260804113736.1423667-1-hca@linux.ibm.com>
 <20260804113736.1423667-3-hca@linux.ibm.com>
 <20260804114701.54ADE1F000E9@smtp.kernel.org>
 <20260804124705.12261Cbe-hca@linux.ibm.com>
Message-ID: <2f695c986662ceb6d21a4e2fc6f366c4@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA2OSBTYWx0ZWRfX+c7CVkQItPWI
 2Up13fqye1KyOZw7CB6YtvyJ71q/hos6lQZwOx9Q8v8OaVujaMWDq/P4/RHrDV2wxpB28rZzfFc
 lrMSbrSyf0pP9RNBFZk/nXra1YfTFUo=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a72f8c0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=KqfbkvOK9UCTJDOARgUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA2OSBTYWx0ZWRfXzhOLLNdwlsSq
 h0Oatsrl6cxdBWPA8WdSAoIWY71YGNYNSv/7xPTakSyw4I09moAOT8AAgRKouYaTnEpMTw68oQq
 7BKfzxe02zioZGqRiH6X3vgjxto5eQLTZdrOWCDhiibzeIwWgWneFCrRO/JrVkkbo55j4+XjDxZ
 Xe0ehWLULhCncFWunlQJSETeecNHX8KgkTnjHGO1VKGikimdfDv+zPqNe2FZsRrxzWAeCQ6AY5D
 cyvuQW+howOHC1d+qFRmE8isVV6HPrncIOv1KjoksjF/6Hcm/H3iupG4UVdef7WoDNroTYz1htB
 DtFpQ0FSp8V4bc+pr3jJOLA8OytepX+yBcQawSTzl+pdWjiDyWlWzVJLTxoriY/OYsfscNeA/JD
 XJvKMgOdzIyAJIXLWA5YU+8jAmyF9nsmqyiiTvGzjcZiSxCnvKlSfoq/Q+ACuIlEjHpHOp4lJR0
 MbKnQX375wixrEI7HhA==
X-Proofpoint-ORIG-GUID: JKxi-tmiKWrZHBZXWyEYWkBbtDsHTT5S
X-Proofpoint-GUID: JKxi-tmiKWrZHBZXWyEYWkBbtDsHTT5S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050069

On 2026-08-04 14:47, Heiko Carstens wrote:
> Harald, Holger,
> 
>> Pre-existing issues:
>> - [High] Silent data corruption when skcipher_walk_done() mapping 
>> errors are overwritten by paes_convert_key() false success.
>> --
>> 
>> --- Patch [2]: [PATCH 2/3] s390/crypto: Rework ctr_paes_do_crypt() to 
>> remove conditional locking ---
>> commit fd135aacfa5dd1086ab5711e4513f6e0edede1dc
>> Author: Heiko Carstens <hca@linux.ibm.com>
>> 
>> s390/crypto: Rework ctr_paes_do_crypt() to remove conditional locking
>> 
>> This commit extracts the core loop of ctr_paes_do_crypt() into a new
>> helper function, __ctr_paes_do_crypt(), to avoid conditionally taken 
>> locks
>> that trip up Clang's static analysis.
>> 
>> > diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
>> > index 8cfe6166c193c..d4a9108d39f5f 100644
>> > --- a/arch/s390/crypto/paes_s390.c
>> > +++ b/arch/s390/crypto/paes_s390.c
>> 
>> [ ... ]
>> 
>> > @@ -981,34 +955,76 @@ static int ctr_paes_do_crypt(struct s390_paes_ctx *ctx,
>> >  		k = cpacf_kmctr(ctx->fc, param, walk->dst.virt.addr,
>> >  				walk->src.virt.addr, n, ctrptr);
>> >  		if (k) {
>> > -			if (ctrptr == ctrblk)
>> > +			if (ctrptr == ctrblk) {
>> >  				memcpy(walk->iv, ctrptr + k - AES_BLOCK_SIZE,
>> >  				       AES_BLOCK_SIZE);
>> > +			}
>> >  			crypto_inc(walk->iv, AES_BLOCK_SIZE);
>> >  			rc = skcipher_walk_done(walk, nbytes - k);
>> >  		}
>> >  		if (k < n) {
>> >  			if (!maysleep) {
>> > -				if (locked)
>> > -					mutex_unlock(&ctrblk_lock);
>> >  				rc = -EKEYEXPIRED;
>> >  				goto out;
>> >  			}
>> >  			rc = paes_convert_key(ctx, tested);
>> 
>> [Severity: High]
>> This is a pre-existing issue, but does this sequence overwrite an 
>> error
>> from skcipher_walk_done()?
> 
> What should happen with this? Can this be ignored? Or should this be
> fixed like
> 
>   			rc = skcipher_walk_done(walk, nbytes - k);
> 			if (rc) {
> 				if (locked)
> 					mutex_unlock(&ctrblk_lock);
>  				goto out;
> 			}
> 
> before the conversion?
> 
> Even though I said I don't want to fix pre-existing issues, I broke a
> similar code path with the first patch, so...

I'll take care of this and let you know within 1 day. I opened up 
bugzilla
https://bugzilla.linux.ibm.com/show_bug.cgi?id=220960 for tracking.
