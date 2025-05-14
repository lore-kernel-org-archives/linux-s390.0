Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440C1270571
	for <linux-s390@vger.kernel.org>; Wed, 14 May 2025 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747219200; cv=none; b=dn7rm98kyUWhDTo1pPA/XDLInDQhpzqaphWH+4d9/bnsL2GmwjvwNDKojPC0SBwzdwNDRHUm3vcP7qM189EPp0MWi18qlOxBqZoLMQDU6YeTCALmzBeJ1/kN5WRAXYW7nSLkvi7jzD8qcApJRAMRVrgODaDABAyv1wXZ8fjrETg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747219200; c=relaxed/simple;
	bh=M+r/sXnGBLkwxL4io3yO0T9gm2Rr/cnSm7pZQbUY12M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNsfhkPLwwtexSpFTJ/ATKu/iK3zghoHPqyISMXI0INWncxNwFdCGq52rxkWTB/lw/7BANyRJ3Ft5vSjjEi+i8Pzv8rVDL5MPvRovkPE6wTL3vwLGbES1ql8DEdYUub7lhmHtkusZpMDZMGjLWDh4LcGAdu9bHJcDijhk7l59/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QJPKkllx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QJPKkllx"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E6PoG5002482;
	Wed, 14 May 2025 10:39:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=unDsqyPlFr1KTJgttSPnCgs9K7GMg4
	i/QE0MYoWU06k=; b=QJPKkllxugS0p9n0S+Itmnw74dJ7MsiSvMCJx83SckuPqE
	hL8UfVBsSf/RzxyrZ0ABFCuAixPHZLEDP0kxkHvBVHtXCBWRUrfaMIXlF7+Cy+Ly
	0mV2E/A5wrLwM9F3zLCJOjGsme7acfex7Qa6vmW8eckbMeiakE3wuRZmT6L7uSaW
	TRdIQ+VINBpLEXwss4lzST26oQvf+nu6TlKU5SDLrwwxQdzHjsLS2XOcOWpDrq4V
	gjVfdVko959q8tmniZ8qlQ7a0UeiJZ41OB9REB3GO4NZCn0Dh4/vfDtM5HKC4gWA
	PZtRLXXIa+MXFMwXfzTJUxwI9vCOoughEkBIWMtw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mbh13npq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 10:39:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54E9o7Rs015354;
	Wed, 14 May 2025 10:39:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfpupn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 10:39:55 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54EAdpKC58327496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 10:39:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8BD720215;
	Wed, 14 May 2025 10:39:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EF8C20210;
	Wed, 14 May 2025 10:39:51 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 14 May 2025 10:39:51 +0000 (GMT)
Date: Wed, 14 May 2025 12:39:49 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: gor@linux.ibm.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v5 0/2] Rework protected key AES for true asynch support
Message-ID: <20250514103949.22307Ac7-hca@linux.ibm.com>
References: <20250514090955.72370-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514090955.72370-1-freude@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RpTFLDmK c=1 sm=1 tr=0 ts=682472fc cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=srGfekgxjPcEHOBi6i8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 5brjNZqkOGApXja7EezVD5wObK4VzVRz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDA5MyBTYWx0ZWRfX4QceATM3qRMg 2E6VWWpvrR7G8JPuroilojWOS4R2Ll4msWIQsFsnv21uoQnVkY0gKzIiWuGcbi9aq/HcUTj5tuW 4KMptoym9+p2xy5gakYg3kwLB+UKrFuDfq0X97JDcFpDzmLs60iUS6eupKCA0BOJduvvtA7ujV7
 k9J0vhVwzbiPv16T1H880WbPGyFgYuT8qHSFKjx/K9kqrHSDAMmGvyVq1dUJ+eEUDkJYQQnK5FJ uXku6UwGHc5u5nJLg67xUit3oJSG4CrXIiZhnbiV/eTgQep99ky3vIRPpUYkrKCAxL27XlKQJsT FhQmVqvJ9WPtr3K6NN5zixUFLatX7REiIIHgZeYH3JdSzwXvxLUrlbtwY45leohzEGNWtAi1sfq
 6bW71Sfijpf3SLcMiJShdPXqaCM4ccNtKO6y+WHHJ5WhlcWN8/xReVAxA4uU0o/rafHLc/sB
X-Proofpoint-ORIG-GUID: 5brjNZqkOGApXja7EezVD5wObK4VzVRz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_03,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=443 mlxscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140093

On Wed, May 14, 2025 at 11:09:53AM +0200, Harald Freudenberger wrote:
> This is a complete rework of the protected key AES (PAES) implementation.
> The goal of this rework is to implement the 4 modes (ecb, cbc, ctr, xts)
> in a real asynchronous fashion:

...

> v5 - Fixed two typos and 1 too long line in the commit message found
>      by Holger. Added Acked-by and Reviewed-by.
>      Removed patch #3 which updates the crypto engine docu - this
>      will go separate. All prepared for picking in the s390 subsystem.
> 
> Harald Freudenberger (2):
>   s390/cpacf: Rework cpacf_pcc() to return condition code
>   s390/crypto: Rework protected key AES for true asynch support
> 
>  arch/s390/crypto/paes_s390.c  | 1812 +++++++++++++++++++++++----------
>  arch/s390/include/asm/cpacf.h |   18 +-
>  2 files changed, 1285 insertions(+), 545 deletions(-)

Applied, thanks!
