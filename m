Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1981862;
	Wed, 26 Aug 2026 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787753835; cv=none; b=H0IvC9PrkhU5mtqXttqbNkR0fC3rBWmNpyG6e235mpjXOIIZePtNYvDdWNn+BJ9zJAxbIbUIRszRmu60qJBeu+CJGWhUEP/mgO5n2wHlFHPl5TIGcTqHrnPxYWrCm3LEnNZFmj4t6m7VSSNGKEmGE0CNygB2kfotBD+O+sQZsqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787753835; c=relaxed/simple;
	bh=IaEb10TQ5OWYQYAU3mIUhp0bBZ57wG1p8VomUDVxNfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S4mEb/1aNQGk50JBKw+kY4Mk+Rz9qkNNpscbCsJvY8SWyjiiDQQoLWG6tzryLZPK73FmWksFJcbAwQGanK8B1VwpklbrIR23Go0tUJvKlMai36k+Z6EEcd9XkRiqxYu6i6l9me5eqmDUdNV7kbJ38CQrhPhlUqIp0VuQ4d+txAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R5JA68Cc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R5JA68Cc"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QE1geJ4099748;
	Wed, 26 Aug 2026 14:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BHCyza
	+e6EhJNQpRwxXX/D7csOEUvRFkDlHPfbyEHn8=; b=R5JA68CcwasJmK5+70ohBn
	yDSU6OeGHyGUhHQHbRM35JuAVfHwGV78BCc+5qTH0RZxqRbjzmhWON5OFYnxrjxH
	EJzqxyZ06AWIcIjQJZmHTwcsNQzdGj+dl2pwrtcIBYeVUF1aDtr885m8EUTTjATh
	H5rcOtSGkjF1cNtthfFr43TyzZ0bZKM60ZGUZV++Hlv0l7hfu+tSUsITvv+iHRXQ
	c24JSthS6hzUDPncBb520dSntmepb6wp1gcfvZ/RH19xTQzz1v6f9WRKbGWHYPLT
	nYx2HNBXarKweyrybNkzyh9OqFfbkgTePT/vDOS8nQAVOBbw7tTxjtyQt5LznCHQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hy99b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 14:17:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QEBKGD007597;
	Wed, 26 Aug 2026 14:17:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragj7d2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 14:17:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QEH71715991128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 14:17:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7649C20043;
	Wed, 26 Aug 2026 14:17:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4102F20040;
	Wed, 26 Aug 2026 14:17:07 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.55.210])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 14:17:07 +0000 (GMT)
Message-ID: <485c5bb3-ca8a-4591-827c-09d23f4280a2@linux.ibm.com>
Date: Wed, 26 Aug 2026 16:17:07 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390: Warn if kernel command line contains non-printable
 EBCDIC characters
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260825150840.537653-1-iii@linux.ibm.com>
 <20260826092916.21444Ab3-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260826092916.21444Ab3-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDExNiBTYWx0ZWRfX98hEewjzWKAA
 1Ngr2T/sqRgKewhWz3eaRcDkwt0oTab2fSnxYYiAOvTIccOESYiH6UB1ZN7LGTdXecefa4vOCI6
 Ie1OjZ16prRo30h/t8EGVk/juqR2oBQ=
X-Proofpoint-GUID: PituprqXM9O2sbPkbuU6m5FcJLYbinxb
X-Proofpoint-ORIG-GUID: PituprqXM9O2sbPkbuU6m5FcJLYbinxb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDExNiBTYWx0ZWRfX+BbX7J7+jmh3
 ZSZ3TTEzYLhPIHFTrrj+44gDfDmvFCRZO4+omq1CvKKz9JRZYKiOzs6bgTUscB5iy793Y7hEzCD
 s0rOB2MltY94MpmiW5P1FIFimZBUORDgD/Se7Q63TKIb2eEkhXbwXjlCuZpY7RLK8oQiZ+tcPn/
 1hCMGPBHLiaE6K/ykjetKOqII4tD3t97cYGC+Gnj5eQwkr12AWjrRzaERO2/iL+LMTetuZ4nxA5
 C020a7rbokgNkJGF3QqJUaVeg+cDJCyez84v0V6bRbcL9ZYS/2qr73lxhsj4v0a67aCvhiHAJkd
 A/QKQYXP/J/G+9yRrLwJuFoTejhOXaqkKr5UUFwBDAvG4rX4P3zrbnUCGGRCitRZrCoBOYrHf5V
 jnQzztRArbu0H3qYRB7FdCjWwiQV+GILdOV/vMW7kJtBVkyi9vQf6gLuuYr5mOJpN5onuA4rkr4
 k/EDzxHkoRkddlhsARQ==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8ef568 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=A3Q8tPC8mmVFCRH0wo0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260116



On 8/26/26 11:29, Heiko Carstens wrote:
> On Tue, Aug 25, 2026 at 05:08:08PM +0200, Ilya Leoshkevich wrote:
>> Users may accidentally add multi-byte UTF-8 characters to zipl.conf
>> parmline, for example, by copying snippets containing non-breaking
>> spaces (\xC2\xA0) from web pages.
>>
>> The kernel will then interpret the entire command line as EBCDIC,
>> making it unusable. Distinguish this situation from the legitimate
>> EBCDIC conversion by looking for non-printable characters and issue
>> a warning.
>>
>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>> ---
>>   arch/s390/boot/ipl_parm.c | 19 ++++++++++++++++++-
>>   1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/boot/ipl_parm.c b/arch/s390/boot/ipl_parm.c
>> index 6bc950b92be76..71c0c26d56bba 100644
>> --- a/arch/s390/boot/ipl_parm.c
>> +++ b/arch/s390/boot/ipl_parm.c
>> @@ -173,12 +173,29 @@ static inline int has_ebcdic_char(const char *str)
>>   	return 0;
>>   }
>>   
>> +static inline int has_nonprintable_char(const char *str)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; str[i]; i++) {
>> +		unsigned char c = (unsigned char)str[i];
>> +
>> +		/* isprint() is Latin-1, and we need ASCII here */
>> +		if (c < 0x20 || c > 0x7e)
>> +			return 1;
> 
> Hm, I guess the comment refers to a different implementation than the
> kernel internal one? Since isprint() (see include/linux/ctype.h) is
> true for exactly the range you open-coded, as far as I can tell.

Unfortunately isprint() matches some extra ASCII upper-half characters,
e.g.:

   const unsigned char _ctype[] = {
   [...]
   _P,_P,_P,_P,_P,_P,_P,_P,_P,_P,_P,_P,_P,_P,_P,_P,        /* 176-191 */

> Furthermore kernel command line parsing also allows for all sorts of
> spaces, tabs, and line feeds (see e.g. next_arg()). So I guess the
> above should be changed (and shortened :) ) to something like:

I completely forgot about newlines, thanks!

> static inline int has_nonprintable_char(const char *str)
> {
> 	for (int i = 0; str[i]; i++) {
> 		if (isprint(str[i]) || isspace(str[i]))
> 			return 1;
> 	}
> 	return 0;
> }
