Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBD0211287;
	Wed, 22 Jan 2025 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737561684; cv=none; b=HFSWCPDcTCPe28HqLAKbEjymQwzjb89sscGB0cLhAs/2BBD9GOt9krVGvFvm41r08eJv7q8I1mHguOAl7RsOxUkyB+5ShNmiPN8pnCjpPpp3iP8A4Km0Lr8U+oU2ip09CNfzqHmQVK2gCCerGFbFZSfiQdKC4JGByHiyLGJzEwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737561684; c=relaxed/simple;
	bh=e8KJ7L8z+Xf7GP0K4PTyN/ifRd7iUNh70Fvo3UGOCYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IFYhZ2E49cBw0m+yzWiDYbcNTBenz/LPrNIqRD1+bZKgklsrQSaaB2RFE00221uTsnt9w4X3SFVQ6/fWyDP45TVC33sORri+skEJagEcDr+KRqnkiOr2x/iyd/yKQhSZbxb2v3erb1nEVs3kDGMOPlr6/w5b39COu59SRVXDcs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CAit0cn+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CAit0cn+"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MCPHXU013713;
	Wed, 22 Jan 2025 14:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=f+OQIE
	QKsjPJaq/H92kYav0p4h1QhbDXTKlscMHn6AI=; b=CAit0cn+lJi3IVIKB/B0Jl
	J7F2FpFiAovDvXrT8Of6lMmaKQb6uGAMQhgUAH+rjaPlp4rIjsa0u4cwQCE1CTZB
	13oIN7UjQxCv/uq6xfFqREdU+OhjyfMWMptpvxHat8i0qFd7gmerciTWtjloNXqW
	oBOAMSh6riKEvdelFyHoM2qkyKshxIZeXCRXoszUr/YNv28jgirhbZVX3qJcaaOv
	UNo+LjKJqXbNGk2ofEf4TNJLDHykkO4JGLq1zczUw+G1MHNDJSFycawwpNYnh8+c
	jNADNhH+tMg90Wtk0OblCQCqEsYyPgfhyWqsYxY+wRkh6UIiEUgVOJL4oKYz0f0w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44apr9bbcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 14:46:23 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50MEe8ZL003819;
	Wed, 22 Jan 2025 14:46:22 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44apr9bbck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 14:46:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50MBerdH021080;
	Wed, 22 Jan 2025 14:46:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 448sb1ggdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 14:46:21 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50MEkIAk32375116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 14:46:18 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEF3620040;
	Wed, 22 Jan 2025 14:46:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8A8C20043;
	Wed, 22 Jan 2025 14:46:16 +0000 (GMT)
Received: from [9.171.82.13] (unknown [9.171.82.13])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jan 2025 14:46:16 +0000 (GMT)
Message-ID: <8c4ef401-9777-4a00-9b1f-0c66650a826d@linux.ibm.com>
Date: Wed, 22 Jan 2025 15:46:16 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 3/7] net/ism: Use uuid_t for ISM GID
To: Simon Horman <horms@kernel.org>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Peter Oberparleiter
 <oberpar@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Julian Ruess <julianr@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20250115195527.2094320-1-wintera@linux.ibm.com>
 <20250115195527.2094320-4-wintera@linux.ibm.com>
 <20250120171820.GC6206@kernel.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20250120171820.GC6206@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9iHLN6_9EVQNvi39JaMn8IUOy96Ozs9n
X-Proofpoint-ORIG-GUID: JlVzvFPDl7QM20ixpCvq5t5ta9abVVYe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_06,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 mlxscore=0
 spamscore=0 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0
 mlxlogscore=926 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501220107



On 20.01.25 18:18, Simon Horman wrote:
>> +static inline void copy_to_smcdgid(struct smcd_gid *sgid, uuid_t *igid)
>> +{
>> +	__be64 temp;
>> +
>> +	memcpy(&temp, igid, sizeof(sgid->gid));
>> +	sgid->gid = ntohll(temp);
>> +	memcpy(&temp, igid + sizeof(sgid->gid), sizeof(sgid->gid_ext));
> Hi Alexandra,
> 
> The stride of the pointer arithmetic is the width of igid
> so this write will be at an offset of:
> 
>    sizeof(igid) + sizeof(sgid->gid) = 128 bytes
> 
> Which is beyond the end of *igid.


Duh, what a stupid mistake. Thank you.


> I think the desired operation is to write at an offset of 8 bytes, so
> perhaps this is a way to achieve that, as the bi field is a
> 16 byte array of u8:
> 
> 	memcpy(&temp, igid->b + sizeof(sgid->gid), sizeof(sgid->gid_ext));

I propose to keep the
memcpy(&temp, (u8 *)igid + sizeof(sgid->gid), sizeof(sgid->gid_ext));
like in the orginal net/smc/smc_loopback.c


> Flagged by W=1 builds with gcc-14 and clang-19, and by Smatch.
> 
>> +	sgid->gid_ext = ntohll(temp);
>> +}

I actually overlooked it in my smatch run (too many old warnings), but I
cannot get W=1 to flag it. I'll try to improve my setup.


