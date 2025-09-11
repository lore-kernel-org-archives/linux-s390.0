Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C416B27F018;
	Thu, 11 Sep 2025 07:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757576663; cv=none; b=i434IWSihpRtJVny5/pjb5OfAdX5xQIQMy2yYwmRzjMA9yS+MoF0rDDaKxprBy05UwZZSeCYrhQkK9O/mNlrl3kRdZPRFR5f36dLYyRh5ZRSYWky9XGuF4jxlCEVwDh3db7btt2JeBSCm6QHszaod62F3FCZ3JMkU1JGgtN3uhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757576663; c=relaxed/simple;
	bh=tHy8/5haGilV0VRcRMRJASwjv/bqGLx4KS9qubUUoiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIuJtV+l33TDkfrfkTdXKF9JP44gAwtWlRFsIfXaBA7L0dT5lIUcWOhZL6gFuYt/mIrAAl9lMhpSgDcA49tgcSEwjyLml6sBQbQ+YH31Mlvyt0rv9VD2mpXwyRE6k6JoWz35fktjQ+4GFhAlzc8ZYlZIV3BBXUB8RINjxiWzvh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qJrbXbuR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qJrbXbuR"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B2PFKj028539;
	Thu, 11 Sep 2025 07:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=SF9UyLlCqgFg6Q+kKvlcJIKzRNTFyy
	249wIDKgX/LU4=; b=qJrbXbuRLLmPRDbFZ6OQX24CKaH+Z0bWYwaM3/evY5oWU8
	aunGdthjetxcz3IOHhkArjZ7Otbu+Ag68YyTYHUxRQcT5NWXdVEz9N0mR9FKExyo
	Aylc30/C5HqyXyhFpN6u2OjtArLA7UeGYOxlSEDVTBW9oZOrrfOogRISbLzpm1u5
	VUZM10mcd1l1Ues4p/UNGeKK1C8U+anAhSlYAUj59amdEDW0VzZXm8lvoJin3Qvu
	0Yh3bCC9CMKU+NSMhHEf4rSv1wgqXP36Ldu5w1wywxcVQhvnnaYDVx0vwwCYui2s
	K1cudhXo99Tr6dn1yZXd7fZB8kYVMjw3A8zOEGGg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490ukeqw7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 07:44:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58B60CwY010618;
	Thu, 11 Sep 2025 07:44:11 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4910sn4keu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 07:44:11 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58B7i7Fu31523122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 07:44:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8030E2004E;
	Thu, 11 Sep 2025 07:44:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20E022004B;
	Thu, 11 Sep 2025 07:44:07 +0000 (GMT)
Received: from li-3a824ecc-34fe-11b2-a85c-eae455c7d911.ibm.com (unknown [9.87.156.46])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 11 Sep 2025 07:44:07 +0000 (GMT)
Date: Thu, 11 Sep 2025 09:44:05 +0200
From: Juergen Christ <jchrist@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH 2/3] s390/bitops: Limit return value range of __flogr()
Message-ID: <4f3557f5-d8e0-4948-a653-ad48cd08331a-jchrist@linux.ibm.com>
References: <20250910151216.646600-1-hca@linux.ibm.com>
 <20250910151216.646600-3-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910151216.646600-3-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDE5NSBTYWx0ZWRfX0jmqSXJdaG8s
 ZlgVka/qBIste/JCh/nr1SNVM/3iobX7FOEO5iWbUaNopEZU4kgBR6ZkS+lpgcF6At5whrSqgSa
 jQLGiZMTXhQ4G9LfNYbf3+AtNfZR6l6O6S4t7HPBJEz/71D+GLYAifMhnceR0dVArwoE/uOKKaP
 oKUNIhUlOqwBlPTTFNuLWHkPASBNVN2RFptKkYzT1S4fPF+yPKOJFSZPW0aWp5cyhTaqn0x4GmC
 45bejWbSpRMRizFI8DauEbGdcQXyWTHyuFdbKKUejHskwLgd9jw/xGTsDJ8VTIJSlF1WB/BsVX0
 XSIuDAGQMe3yZiQ+brLyI45oPrQOzQuIM9uy+l5vIuewETIEJVxuHlxyLRPyZMgoUSTPn3wcj+r
 7D8LzqHz
X-Proofpoint-ORIG-GUID: hyqIYSe8nLjM-kZofKZKXt08J27pI2KY
X-Proofpoint-GUID: hyqIYSe8nLjM-kZofKZKXt08J27pI2KY
X-Authority-Analysis: v=2.4 cv=StCQ6OO0 c=1 sm=1 tr=0 ts=68c27dcc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=VnNF1IyMAAAA:8 a=2cfC6cEr_CBPIm7wQiMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1011 adultscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060195

> With the recent ffs() and ffs64() optimization a logical and operation was
> removed, which allows the compiler to tell that the return value range of
> both functions. This may lead to compile warnings as reported by the kernel
> test robot.
> 
> Instead of only adding the not needed mask again, also add an __assume()
> statement to tell newer compilers that they can assume a specific value
> range. This allows newer compilers to optimize the not-needed logical and
> operation away.
> 
> Also change the return type of flogr() to unsigned long and add the const
> attribute to the function.
> 
> With this the reported warning is away, and in addition the kernel image
> size is reduced by ~4kb.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508211859.UoYsJbLN-lkp@intel.com/
> Fixes: de88e74889a3 ("s390/bitops: Slightly optimize ffs() and fls64()")
> Suggested-by: Juergen Christ <jchrist@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Reviewed-by: Juergen Christ <jchrist@linux.ibm.com>
