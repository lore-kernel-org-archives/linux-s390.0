Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3823D3008
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 11:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782213191; cv=none; b=UC4AbctUVs5syVJVr0nDK9v7Q+xsDnu/fCSFguGU5IcnIetk6NBy8Ia7lqP3bqHLQD4p+e9FzE8ExFJ6GGE1iw8plcy7ASok1y8J5pCkAj37p+yNCJogqqHcoPcb3X0y9JNRz4KYoMLxB8Jkyl2nFg3qXNBRuqqH4K7J+ZXL7vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782213191; c=relaxed/simple;
	bh=z1fIKigyP/LEGzjzGDKaqUbQPdErSzjx0TzU+k/ahW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inZIRyluIZJ+O+1ObBV6kVxs4Lb4D5iPka9ViQuIEHEUQWZeg+3LL2eocxBMfmYHRcliFV/C2Xc4eQCm+3yZ5mpmOvSuxc2Pj9+aMQFfuKWhbcg8W3eg2u1JW9jx7Qh0lGZbX7WgNeVxy/cdo6ZVEvsTzyjsgWKlpmHjPJYs59E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fCVwffDq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fCVwffDq"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N6mP511350652
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 11:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=2g2z9aUziST7vJQm0KhmCbK8gOp5p5
	5yaX12AwyKcRg=; b=fCVwffDqY0W+Sd2O9F8VyRJ+VbJO+wBJ0CNyWHX3ZZq2d5
	fHvi6fjiz07rUa0w8lYpkFPG3aBrYXHzPcRCY1pQXPtSTBOBvXm7eLaY3VkUOXzS
	03I/OvbZRQx+GhCQPu3B4FOvGEJZ91I9dAZ1gPQJI944rZ76G1UjONJluYVFbKYO
	kGdTnGjPpGq/MfYhVuNgDt8UutxjJuSgNMtagoQIuhyZuBBem8b212/yQgPJ83UJ
	dVVvCfBHHRl8Tz2gmoS+bCN64jF76g5T9NXcitpsN4/B7npgLRWbBXmW/QQBRjVG
	GTh7wGcrTaWA045fCeCiPbbnHP9C7icrH4z18zhg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhqp1uf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 11:13:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NB50j0029101
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 11:13:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66k2weq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 11:13:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NBD4cs39256530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 11:13:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A00ED20043;
	Tue, 23 Jun 2026 11:13:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 831A220040;
	Tue, 23 Jun 2026 11:13:04 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.224.92.206])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 23 Jun 2026 11:13:04 +0000 (GMT)
Date: Tue, 23 Jun 2026 13:13:03 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] pkey: Fix for PKEY_VERIFYPROTK iotl
Message-ID: <05c89f53-760a-4014-bdba-6aa58d86c7cf-agordeev@linux.ibm.com>
References: <20260623102016.3930343-1-dengler@linux.ibm.com>
 <20260623102016.3930343-2-dengler@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623102016.3930343-2-dengler@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3a6a45 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=F7KASwOF8UQbQQfWccoA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA4OCBTYWx0ZWRfX/+wWPRfQpCB6
 1tLaErkRpMH+D0p2RTs6mwFLa100Ail/RgGDHgYCTEGjjA/k5MDyvKur5GoBfNzIVriXiBYgqw3
 9fOBPb4FJ2KO0HYrBaPo3aOKCetxdB8oehpSuYGMrslGPUZQj1M677oYgG1Nk3ItIDFFLDYJKax
 d0PUopSFTcBkclCyKCmxYE3I+DwM5MP6qpGBvCn5NVnGzyqHnzl3OKvOClduVYDfLvIb8JarqgU
 EwQMRJ1dTNRXMlMuEmwHAAE8dVNXXeh1CV3rkUXvX/s5H8Xt/1bWWs1qbba2/aM6zbeKeMf3smN
 TeHnUYvNUQml+fc7iG589XFF6EVagQ5nahM++KjeFLR3+IcR5jDUUU2x6tOB69r1iheMCXZu0tC
 AbwQUO6loQ85WiCGCg/eDSeeKdB80YSxrxf+RRawkkaJTD1EEfqJN5mnflLQj3/bTIlLlvuVxBs
 2lq4QRm6hLgXsZD/zsQ==
X-Proofpoint-GUID: TuoGVqy4jvrUiKuRKAP9fAx0i29Wa97a
X-Proofpoint-ORIG-GUID: TuoGVqy4jvrUiKuRKAP9fAx0i29Wa97a
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA4OCBTYWx0ZWRfX/s0fsdXkFAxN
 /KlR02f3VZH3Emg8pAEvrncBpNMJe73kEQXNPn+AT1lMKs62e6bFvcOdzjNj3jQjtWo/+dew1mP
 KLAnoJcfUZhNPfJoDPOIB2hGQf6LS8Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230088

On Tue, Jun 23, 2026 at 12:20:16PM +0200, Holger Dengler wrote:
> Remove the keytype calculation based on key length. The verification,
> including the keytype check, is the responsibility of the pkey
> handler.
> 
> The removal also fixes a bug in the key-length calculation, which is
> now no longer required.
> 
> Cc: stable@kernel.org # 6.12+
> Fixes: 8fcc231ce3be ("s390/pkey: Introduce pkey base with handler registry and handler modules")
> Signed-off-by: Holger Dengler <dengler@linux.ibm.com>
> ---
>  drivers/s390/crypto/pkey_api.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)

The patch description is too indescriptive.
Could you please suggest a more specific one?

Thanks!
