Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9173D36D;
	Mon, 20 Jan 2025 09:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737365534; cv=none; b=grDMh3uR1rU3I6OBbNaPPQxrelenWxJQdAexwwyKS+W/7P9+QewJwr3HIN3XkvuknHcNnpPCCXusRdtyI2pPQtPuV18bMcZ4Ix28kqkaT0Fvv1636WNUq+WyFV2XQlfE1xNDjTHVBgC8ebkW5e/jUd893gDcQlghWNIUczVBaeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737365534; c=relaxed/simple;
	bh=gpYNc8wX6fxxpp+SMo/fzqnIXb6FeEfoocoG6lCWFwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jAbNg5jjriHN3PrmWHcGeyUAXFyilTZZU+Yo8CxRPCHhpv6/dR620ADNwEgZp+R0pPBhTBVos2ukDHrTVgZd94Ulm2jNJYtE0MV+fNF7zP21TDeQTl3mgAwO4QmN4BCCIcOw2+J/11a2URPWuBjhlcQojkoERwflN4ur0Wr5XKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ifkJpezi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ifkJpezi"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50K7X6Qq010912;
	Mon, 20 Jan 2025 09:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Y5WEfG
	M5l8Wno9r+sCU2qSH8ae7U7MdFrW+2nIORBjU=; b=ifkJpeziFI3F7pmVloqdI6
	DggnP18KalCgNaCfYRlUxYAdMQjYTrzgKbcFH6Zpe51Sq/ghOUkJOnlxWLL/YH8F
	2sJFEd6yTv8l4iqGfQW/lTWTLIHhTyjU1CFtacgmS2euAkPtPcq5YgJJQio4GDHN
	Ffd8gEg2TwC/7qPW7eXqqSFBbXunjQMebkcU8V9vST7ETJiam9sCaA3juSVfIyfn
	dI3G4HYO9xIYZvQssPrRsAwkygB4Snu07OkAWvGOCvYnr8aM4m9lhfyN6v2loMnv
	uWzoJ/YqgDnDZ37kfSEafowOh07xSz54C5O368fKJal0Z9BCOmhg+IGUPQzkXi6w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 449j6n8j8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 09:32:04 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50K9UoQb025663;
	Mon, 20 Jan 2025 09:32:03 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 449j6n8j8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 09:32:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50K90UHX020986;
	Mon, 20 Jan 2025 09:32:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 448sb15bqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 09:32:02 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50K9Vx8D51052980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2025 09:31:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A7612004B;
	Mon, 20 Jan 2025 09:31:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0702E20043;
	Mon, 20 Jan 2025 09:31:59 +0000 (GMT)
Received: from [9.152.224.153] (unknown [9.152.224.153])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jan 2025 09:31:58 +0000 (GMT)
Message-ID: <707590a7-9b3c-4940-86a0-95f70dbe7c9d@linux.ibm.com>
Date: Mon, 20 Jan 2025 10:31:58 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 5/7] net/ism: Move ism_loopback to net/ism
To: dust.li@linux.alibaba.com, Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Julian Ruess <julianr@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
References: <20250115195527.2094320-1-wintera@linux.ibm.com>
 <20250115195527.2094320-6-wintera@linux.ibm.com>
 <20250120035525.GK89233@linux.alibaba.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20250120035525.GK89233@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NfYoGU5lOyAktJqfHln_hghalyOtsisi
X-Proofpoint-ORIG-GUID: P8e7xMDCmSqVI_P_11JEsykckN0hbFZS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_01,2025-01-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=833 adultscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501200079



On 20.01.25 04:55, Dust Li wrote:
>> +static int ism_lo_move_data(struct ism_dev *ism, u64 dmb_tok,
>> +			    unsigned int idx, bool sf, unsigned int offset,
>> +			    void *data, unsigned int size)
>> +{
>> +	struct ism_lo_dmb_node *rmb_node = NULL, *tmp_node;
>> +	struct ism_lo_dev *ldev;
>> +	u16 s_mask;
>> +	u8 client_id;
>> +	u32 sba_idx;
>> +
>> +	ldev = container_of(ism, struct ism_lo_dev, ism);
>> +
>> +	if (!sf)
>> +		/* since sndbuf is merged with peer DMB, there is
>> +		 * no need to copy data from sndbuf to peer DMB.
>> +		 */
>> +		return 0;
>> +
>> +	read_lock_bh(&ldev->dmb_ht_lock);
>> +	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_tok) {
>> +		if (tmp_node->token == dmb_tok) {
>> +			rmb_node = tmp_node;
>> +			break;
>> +		}
>> +	}
>> +	if (!rmb_node) {
>> +		read_unlock_bh(&ldev->dmb_ht_lock);
>> +		return -EINVAL;
>> +	}
>> +	// So why copy the data now?? SMC usecase? Data buffer is attached,
>> +	// rw-pointer are not attached?
> I understand the confusion here. I have the same confusion the first time
> I saw this.
> 
> This is actually the tricky part: it assumes the CDC will signal, while
> the data will not. We need to copy the CDC, so the copy here only to the
> CDC.
> 
> I think we should refine the move_data() API to make this clearer.
> 
> Best regards,
> Dust

I agree. Will be refined in next version.
