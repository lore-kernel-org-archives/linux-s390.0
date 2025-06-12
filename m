Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECACC225776;
	Thu, 12 Jun 2025 09:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749719461; cv=none; b=LmsCpFuw20AZa1tpYnp7V3ZBv5CV7joZU99Ay5/smV8H8ql5O7pIhCJkO9yka4/PkX27sZNRrpJn5PBdtUcdf7FmhQpwu7lFzKN6lBG4tXXL00EdvpBHEHvcvuErmnnIjw3KfpexwgsfOjRdnVaypMhNzPMPZN/lqNsCn+5f7ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749719461; c=relaxed/simple;
	bh=ZWYeba2zZ7ChIyDDTSkC7MQyX5T2sDGqVkjBejupkLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c7xYXN9uRFV5zq02kOV5kkaOQZW4Df5jvGSiNCuzH9T9FTuglUncBZJVEouCs4kxK4fPlksSEH0Eef2qdwuCrNYCDqEofBVMDqt8C63f+UHasgAa5Ml3kcROxak7PixSgGwS4tli+jut/cy0VcYMAiJLjOy4ZmgOwQyQQ7M0FuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g1ucIhaD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g1ucIhaD"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C82w8a015375;
	Thu, 12 Jun 2025 09:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XYGRjJ
	tEHhDxVAinrefAhKHqilLkU7+u5nAeD1irmrQ=; b=g1ucIhaDprsnIVmkAAiiAL
	TXABqCFO2MqAcXTHF0nKpniGj1ZXQggSq/ki+JVmgeuBtea+BHQaGtBKK2Wojcdk
	KwOlKx/jxj0pno2eNr2hXiJGd2WtB9Xbo1i8VLvHJe4TTOmTTNcjBANN1p4M7EA5
	H73HRVQZ1h+jabc1HTuj6+uWTBSbYfvFvkODyY20JDlpfhcvZr0DoZ+/wGagNJgs
	H1qvsSJRKfTDLMrKGmDT0Qe0j0HLViByhtNrgxPhsLaUdbWs6h9EDTWFBiuOGHLl
	lKOmiZHGj2jmi4BSVtI87BHXdpbeK/IpFcnT2cV00KX8phzVjx7qWOQlNHnMQFmQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474hgurt4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 09:10:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55C97bwT015184;
	Thu, 12 Jun 2025 09:10:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 474yrtm84v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 09:10:53 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55C9An2Z55837044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 09:10:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DCC72004E;
	Thu, 12 Jun 2025 09:10:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F88420040;
	Thu, 12 Jun 2025 09:10:49 +0000 (GMT)
Received: from [9.155.197.140] (unknown [9.155.197.140])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Jun 2025 09:10:49 +0000 (GMT)
Message-ID: <af8efb80-a886-4fdb-80a9-e889cfbefe74@linux.ibm.com>
Date: Thu, 12 Jun 2025 11:10:48 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390/pkey: prevent overflow in size calculation for
 memdup_user()
To: Fedor Pchelkin <pchelkin@ispras.ru>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        stable@vger.kernel.org
References: <20250611192011.206057-1-pchelkin@ispras.ru>
Content-Language: en-US
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250611192011.206057-1-pchelkin@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Pfr/hjhd c=1 sm=1 tr=0 ts=684a999e cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=HH5vDtPzAAAA:8 a=VwQbUJbxAAAA:8 a=xjQjg--fAAAA:8 a=VnNF1IyMAAAA:8
 a=w46-cfdy0MOtRbFV-QQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=QM_-zKB-Ew0MsOlNKMB5:22 a=L4vkcYpMSA5nFlNZ2tk3:22
X-Proofpoint-GUID: 4rrcPsQjz9vjCMtmHooarVt2G0I__1Bd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA2NyBTYWx0ZWRfX9ldU1FAP1eTg eiy8W86qOzT3w5fRz4UEVFX8yqk+0oLwQyzGti9rvVoWfPwZLOaEKv51SLkKvi1YMmPnGhyrtN3 IWZtNKTOO1393kP346QI7wY/VD+BkI2JbLOteBVmZzz4g5LAkPgjMjMyfhrkH9JVeQhlHCHV5jJ
 cc1DuxbDt7ZUaxNV5RL58ER2dkhQ3rdnIDFyDyBEyRTEHMk2oEzhcUaEXsaWiX8Eo3A19Xkqths QXdLKRWY64cagBqmo5XhGE+epb5IEPdINDm4K1d0x4kp/ru16avC7kLEt6bSe5qjpPGUiqxF1W7 YrzLBMeszDsb8Muwvi0Otmp9CXeJdUKolBO44a1DLTr4Hbp8umVLVt0n3umHHeKoPikJbDZ9nk0
 KW2ijSx1QmRgzI3mZaNfp4twMhInD0ShH0ovp3TLWcZHwPU8GxcbknyJLRi1BBDtgly37Stp
X-Proofpoint-ORIG-GUID: 4rrcPsQjz9vjCMtmHooarVt2G0I__1Bd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_06,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0
 clxscore=1011 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=518
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506120067

On 11/06/2025 21:20, Fedor Pchelkin wrote:
> Number of apqn target list entries contained in 'nr_apqns' variable is
> determined by userspace via an ioctl call so the result of the product in
> calculation of size passed to memdup_user() may overflow.
> 
> In this case the actual size of the allocated area and the value
> describing it won't be in sync leading to various types of unpredictable
> behaviour later.
> 
> Use a proper memdup_array_user() helper which returns an error if an
> overflow is detected. Note that it is different from when nr_apqns is
> initially zero - that case is considered valid and should be handled in
> subsequent pkey_handler implementations.
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: f2bbc96e7cfa ("s390/pkey: add CCA AES cipher key support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

