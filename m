Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921C243F8CB;
	Thu, 30 Jul 2026 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785422591; cv=none; b=sisbqUWY9eC7vwRql0/7FOHJdzOVGdebphWMCej0G/5NQeZTxjcLNWCM+2vSRBdHCPO4dS1CmNyp4tJlaMrrP8viMO/i/eHOKqa+b4rUdOIM2aQ+98NZ7rpJe8s3KFxED3824o14Pb1mgA6+ZLRBNypmNpPNTavZwQvZnOz6cqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785422591; c=relaxed/simple;
	bh=PTTUxKsiuxea3fANnVqnBYqgmrH5GqnF5L7e9sLY/7o=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Trs+as+pNDWZVpxUQyHPWPdndOV/JvFJyd2yXU8KzIkXkoGWBxvWx/69kIVinmoTUsXlCdpfcovcDhrTiOt8ri+agg3Fwx1IfHGStXfxw4IX0BABK4h8UQJuC6UWmBbV3lP/6Nc/3tuED5nr3prKEL9qqFwfr2Fe5Og2SPjmXVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i95A5MLS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i95A5MLS"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UDHgIr3020666;
	Thu, 30 Jul 2026 14:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=jMMPX7QFxw0buSGJXTlqdwLrRdhnXh0nNcMapzYpfMc=; b=i95A5MLSve4h
	illN0R/wTfiJxik+5F0T28yO6QOXeKAzj2vFcxZYsxUlFivgzYXgn3xvOIKZhcvZ
	L/uaJC+K9v7M6k7ZpLtXuJS0rpx72qi/VxQ/B+BuJg+/qe5PRy8Ur3jMjNpm0pXA
	qbH//bGfztBa567J8BHedlkZSzx+UvpKnO3QeKDX2Tqi7LmBbZt1X+rF5f5ly/fZ
	ClY77ybqh+MKSADm/uqYQoceuNXFsIjIkrkTPYGFLcB/riRrW67rJ1zv64QzZfLs
	oqlWbXORovqS6OVPlIebRIw2F+4FOH40h1RtPEmaQhylcR+5jJa3CloAqc3m2ftq
	rGcMMDDcCA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0nycxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 14:43:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UEfHxh025305;
	Thu, 30 Jul 2026 14:43:02 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgkkrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 14:43:02 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UEh0cp64749936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 14:43:01 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D99655805E;
	Thu, 30 Jul 2026 14:43:00 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 652255805C;
	Thu, 30 Jul 2026 14:43:00 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 14:43:00 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Jul 2026 16:43:00 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v10 4/5] s390/zcrypt: Improve EP11 CPRB domain handling
 with ASN.1 parsing
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260730142912.C6A361F000E9@smtp.kernel.org>
References: <20260730141509.205970-1-freude@linux.ibm.com>
 <20260730141509.205970-5-freude@linux.ibm.com>
 <20260730142912.C6A361F000E9@smtp.kernel.org>
Message-ID: <236dcb471a95b7b976b42df74c39c45d@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwOSBTYWx0ZWRfXwR0DybqvZ7PF
 RBclr7RLI0DKmLEQExnAhS1GrTbVPkPO1cT2cAij8AtCnhKPIt8/H+UhGUqiXXbwQNEIjwCytru
 vohlGbJCg0iSI4W6b4IItQXLY16kj+c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwOSBTYWx0ZWRfX8ovblMGR9+cu
 8HzPkGOF96PB7RzA8AmPxAn36lnSRI7OhGryunnfzXiK9cUAE/TFg0Rje0kYFTxzw4DNa7L0dYE
 CkLbiUNjuzjLTOOGJUUeXJTC4xCqo412bEKlZcnKVs1qafAoZZE6ML6Owrjsm+TafSCHQ+hh84U
 khqjC9KEn9hNOnAUhAT0lTRBYZ12JyFTp/uH9Q/OHULMGs9vjYpRYW6UYXxIGgHagpKocEpVlWQ
 fWnATni29CwXkH1BlLPoRy8bF2bZHq9ZXk016QJKcwoqu9VUp7M/XNQB1wP2r6O2osUnQyYQEPR
 HxjYDBT3yZJDGGQCZaAe1H7XQchVtuc+9c2lFcra4O5ZTLtipzrI2HRslQyGH4mVK2X9BLgqBfx
 pQj+XR6/j8CF0Ir7EcfZmXZORnjy+rXBKgV/FrbM4jSBwvyEdViqRtkbj1VfQhYanuINwd5TdQM
 Q2jFWYVuOsI6v4kH9KA==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6b62f7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=lVzC0DFA1pneV_on3xIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 1JUahxh0F2hLXuI7PSRh-Pz9O1hcp2pX
X-Proofpoint-ORIG-GUID: 1JUahxh0F2hLXuI7PSRh-Pz9O1hcp2pX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300109

On 2026-07-30 16:29, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> - [High] An off-by-one error in bounds checking allows a 1-byte
> out-of-bounds read when parsing the ASN.1 function tag.
> --
> 
> --- Patch [4]: [PATCH v10 4/5] s390/zcrypt: Improve EP11 CPRB domain
> handling with ASN.1 parsing ---
> commit 195849014f55379e7fe6dcd2f7156dd9744b4047
> Author: Harald Freudenberger <freude@linux.ibm.com>
> 
> s390/zcrypt: Improve EP11 CPRB domain handling with ASN.1 parsing
> 
> This commit replaces struct overlays in EP11 CPRB domain handling with
> explicit ASN.1 parsing to improve security and maintainability. It adds
> bounds checking and a new helper function for safe integer encoding.
> 
>> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c 
>> b/drivers/s390/crypto/zcrypt_msgtype6.c
>> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
>> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
> 
> [ ... ]
> 
>> @@ -1239,51 +1261,94 @@ static long 
>> zcrypt_msgtype6_send_ep11_cprb(bool userspace, struct zcrypt_queue *
> 
> [ ... ]
> 
>> +		/* payload tag */
>> +		if (pld[offs++] != 0x30)
>> +			return -EINVAL;
>> +		/* payload length field */
>> +		i = asn1_length_decode(pld + offs, pld_len - offs, &u);
>> +		if (i < 0)
>> +			return -EINVAL;
>> +		offs += i;
>> +		if (offs > pld_len || u > pld_len - offs)
>> +			return -EINVAL;
> 
> [Severity: High]
> Does this allow a 1-byte out-of-bounds read of the pld buffer if the 
> ASN.1
> payload length field uses a multi-byte encoding that exactly consumes 
> the
> remaining pld_len bytes?
> 
> If offs exactly equals pld_len, the bounds check offs > pld_len will 
> evaluate
> to false. If u is 0, u > pld_len - offs becomes 0 > 0, which is also 
> false.
> 
>> +		/* function tag */
>> +		if (pld[offs++] != 0x04)
> 
> The code would then proceed to read pld[offs++], reading one byte past 
> the
> end of the pld buffer.
> 
> Should this bounds check use >= instead?
> 
> if (offs >= pld_len || u > pld_len - offs)

This sounds sane to me. However, will deep check this. But ...why the 
hell tells
me Bob that all my code is good and secure and does not find any 
misaligned memory
access possibilities !?!?

> 
> Additionally, looking at xcrb_msg_to_type6_ep11cprb_msgx() in the same 
> file:
> 
> 	/* payload length field */
> 	i = asn1_length_decode(pld + offs, pld_len - offs, &u);
> 	if (i < 0)
> 		return -EINVAL;
> 	offs += i;
> 	if (offs > pld_len || u > pld_len - offs)
> 		return -EINVAL;
> 	/* function tag */
> 	if (pld[offs++] != 0x04)
> 
> This is a pre-existing issue, but does it suffer from the identical 
> bounds
> checking flaw?
> 
>> +			return -EINVAL;
