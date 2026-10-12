Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB2B49AA4D;
	Mon, 12 Oct 2026 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819482; cv=none; b=uCmu46TpGR78ZxdmuwRQtfGLh5FN6pA7nD60STXCkn4A3JzWBEkBvwf32YKIAK+MztiV4obIq28Lsb6J4IQORWh84dvi9kPOLqXvFs/zbOcypdw43jSYOQF85k6IY1TB0wFa/G0dXIfibW8dpqMb7vOCdsdGwu+IoAPFtnoVOHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819482; c=relaxed/simple;
	bh=Ip9EcLwn9AnLCohk0IE5h8J9hrf66a/qf9ZYcXjJmaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Psxm0lYwe0ePEjwDi9/Nn7vPq1L617BrRl00SWv65OW9bs+7QPE8Zjz1f5MF4yZrwfdYUQMmuU8uO5FmEPy077UnHC+z0qB175UO2t3ClS9wIIAC3ZjVvU6Gte8yPLhOx5ruCQAEQhDpxx2FGaNGLoNfP95XH5BqqLH2R6DPWeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bv2ywgIm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bv2ywgIm"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEUDB073762;
	Mon, 12 Oct 2026 15:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ws4d+i
	f3DFcWAsJU6ufp5Y9Z786ZFBz7zNMpagpLtH0=; b=bv2ywgImkfXT5t38t/X10Z
	LGepyIP38dCFzgWbOaf+uO7uAkIOnDAutREMK3JgWVLdnBiqOcAyjTFm7NpspH1K
	0QZbtfAzgl7zbp1xxNZ5XlwMK9Ui3aX/dc4oT7Z4KA18um4j4uRBY5DIcAkn7eYQ
	WqGOdO52qIwgEz3JX/1vouKoUZ70ySPQZyh6I3JwOwOxtwh9CbNSxOvfkomRdB+M
	gnnpbE//9/rkk6EqYUTQoXIRJAsY1LZ8EYGbwZsaU+J8xm1Rn69XseO8YCI6l4og
	rAKRWmGPoU3aiC3isSyjZV9ebN0OYt4KaaAxaPtxQkWJLzqLaGa5jD8M0K2WhNYw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhscsc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 15:37:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC4rGJ1286228;
	Mon, 12 Oct 2026 15:37:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h82cydj19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 15:37:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CFbt9g33096092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 15:37:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EC5320043;
	Mon, 12 Oct 2026 15:37:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D915320040;
	Mon, 12 Oct 2026 15:37:54 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.157.242])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 15:37:54 +0000 (GMT)
Message-ID: <0acb76c7-33e3-460e-ae89-e42f678a9c54@linux.ibm.com>
Date: Mon, 12 Oct 2026 17:37:54 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/32] s390/bug: Indicate modified PSW in disassembly
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Stefan Haberland
 <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-5-hca@linux.ibm.com>
 <b85d6175-5587-4bca-9851-30241bc96158@linux.ibm.com>
 <20261012152912.19350H7e-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261012152912.19350H7e-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2MCBTYWx0ZWRfX4NW46cFlJMAe
 Edz8DFdIb/y7FNbdwAD0qJB45Z5enzWXXRoYcwf52DfcKa+Dtx4CFvzdtdjhbBRAYZ99GuBFOih
 BCaYobunZVfCX6byBIBBgx65+cU41PgGShrCS72B1ddlPMo1fJc+S0H8fTVEUsV5447uc8xj8oP
 IskFzbO7BmvuM54FZpUwgjOGplrqMWZU5sG4s2zW/gs2+HPUjbGBOZGE28LiqxBSfmcwXcfU4R0
 kAD2XnZVhtldB3fCiYPdxH8FaESJqOEZDse4kCTmydnmMVUQa8CoBOj0S/xRlEusVNbHJ4wMNAg
 laVdL3QAOl7kL9XcPHsehK49+VZlKqT+gfqVOK/yAx6Fadpcad9CxubJtuepXBjWhv4PdhauYNf
 TjpjyZnPzGpNA2hWknMiGUJTWY/fntzs+icXbjCQT+6ZKPRqXHjfPaAZ0Jgx9SbnESuW0Wy6Eef
 pTZWp3DzNtluSuqa7OA==
X-Proofpoint-GUID: vyLNB5kSHMmXV3KySZBkHhknYDWzf6bT
X-Proofpoint-ORIG-GUID: vyLNB5kSHMmXV3KySZBkHhknYDWzf6bT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2MCBTYWx0ZWRfX8qEd9hjmhClj
 ozh3aflPnWWBoKroT3cmzvMInqSyhYXwUeh6QcRKuPvI/qEy8s0zgd745FiQrfUtUJMhZC9+11l
 x/NHNuiXjAyF0lEmVXof+iM54xkVcXs=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6accfed7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=DD0QA6KuiZxyyUaebIQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120060



On 10/12/26 17:29, Heiko Carstens wrote:
> On Mon, Oct 12, 2026 at 05:07:52PM +0200, Ilya Leoshkevich wrote:
>>> -		pr_cont("%s", buffer);
>>> -		ptr = buffer;
>>> -		ptr += sprintf(ptr, "\n          ");
>>> +		pr_cont("%s\n", buffer);
>>
>> Should this really be pr_cont() and not printk()?
>> The KERN_CONT doc says:
>>
>>      only done after a line that had no enclosing \n
>>
>> and the new code prints everything line-by-line.
> 
> I guess it doesn't matter too much. The old code worked around that (by
> accident, not intentionally) by printing the new line the beginning.
> Which is most likely also not correct.
> So yes, I can change it to printk().

Thanks! Since it doesn't matter (I didn't read the code to see what the
punishment for ignoring the doc would be), with our without the change:

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
