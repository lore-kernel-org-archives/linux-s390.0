Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F8917F7
	for <linux-s390@vger.kernel.org>; Fri, 28 Mar 2025 12:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743166272; cv=none; b=u9u/shsZxnt8X6aMVeTaxI+H05RASf+Can30cmRG47GrrJYTqxnLWg7+3epCP3k8aY5w4iPOM7xFjNpkP21C/xCJCThngPrZFkFyLlzswZ9dFwqjRXtjj2m+RtCdqlElwozajUwHR82qqq7wvjyMCfYOlPkxhPXNuou4tAvoU7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743166272; c=relaxed/simple;
	bh=e509h75Syztf9jDzJMpoFPETswoaDxkkVs/IXanEVto=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=SyPe45EMbrDty0tdUBAW9CtoiREG5mBntVuNmFIh8fIUseL3zMZPSmMkWs6akyOVdvZB0kEFiCTkHRNdns9lgQEa00TBKMDanqb6K6BUaX6bSyn2d0l6zLKPNeHZcRGqjbe6uZSPETGDU6w0rfkm/I/Uh3Ht2VcjMna1CBsd/kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DaDO2U1p; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DaDO2U1p"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52S9ZcvI017967
	for <linux-s390@vger.kernel.org>; Fri, 28 Mar 2025 12:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=ftIPHJ7uO3NavwhK1kSfM2Ho+AtDXfQsRGAOG0yslVQ=; b=DaDO2U1pd92K
	N6yuxvn2Dk8/VGVVViHlRaY6sEDkcrGnE7LdDSM02qERUtK5BsjZ1q67+OKnLy7O
	hmaO6PhJSOZZ5MVbYWfLDvbUFrayQZKh5x77rC8sfa0btacqTlZInAohm8iJWYnw
	8epuKPEQB5bdpl9BZgMPKpJmHkfAqLVSno/bWo25hQFssvzfUo9UPBu/SbH/iao+
	bR+5Xn/sPfunLM1HzDSIp4heS78BaOTVvNou+mWnUi8PZWImGzqFOqJlRJXl5sdL
	K0jVvecV2Ka9/AODMSp/V/1sOnxNVNuplV+QUixLGj2Vt1dyK9OPLhY/GPFNNsZX
	7hjhFwlm8Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ndw0btq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 28 Mar 2025 12:51:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52SBVuoG030325
	for <linux-s390@vger.kernel.org>; Fri, 28 Mar 2025 12:51:08 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j7httkqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 28 Mar 2025 12:51:08 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52SCp74g28902110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Mar 2025 12:51:07 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3092F5804B;
	Fri, 28 Mar 2025 12:51:07 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A219358055;
	Fri, 28 Mar 2025 12:51:06 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Mar 2025 12:51:06 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 28 Mar 2025 13:51:06 +0100
From: Harald Freudenberger <freude@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank
 <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, seiden@linux.ibm.com,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v1 1/1] s390/uv: Prealloc and use one work page
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20250328103434.11717A53-hca@linux.ibm.com>
References: <20250327153824.61600-1-freude@linux.ibm.com>
 <20250327153824.61600-2-freude@linux.ibm.com>
 <20250328103434.11717A53-hca@linux.ibm.com>
Message-ID: <f70f6f9c93a8dfb5e0f0f52da882caf7@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v9KC1ouzANkD2dWuD6nBcX5yzTiJXLk3
X-Proofpoint-ORIG-GUID: v9KC1ouzANkD2dWuD6nBcX5yzTiJXLk3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_06,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503280086

On 2025-03-28 11:34, Heiko Carstens wrote:
> On Thu, Mar 27, 2025 at 04:38:24PM +0100, Harald Freudenberger wrote:
>> The pkey handler is calling the uv in some circumstances
>> where no memory allocation is acceptable. As of now only
>> the uv_get_secret_metadata() function allocates memory.
>> As this is exactly one page, lets introduce a pre-allocated
>> work page and protect the concurrent use with a mutex to
>> remove dynamic memory allocation and free. This page may be
>> also used with future extension to the uv code.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> ---
>>  arch/s390/kernel/uv.c | 22 ++++++++++++++++++----
>>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> [adding maintainers, according to get_maintainer.pl]
> 
> 
>>  static int __init uv_init(phys_addr_t stor_base, unsigned long 
>> stor_len)
>>  {
>>  	struct uv_cb_init uvcb = {
>> @@ -61,6 +68,12 @@ void __init setup_uv(void)
>>  	if (!is_prot_virt_host())
>>  		return;
>> 
>> +	work_page = (u8 *)__get_free_page(GFP_KERNEL);
>> +	if (!work_page) {
>> +		pr_warn("Failed to alloc a working memory page\n");
>> +		return;
>> +	}
>> +
>>  	uv_stor_base = memblock_alloc_try_nid(
> 
> Did you test this? I think this cannot work. When setup_uv() is called
> the buddy allocator is not yet initialized.
> Please use memblock_alloc_or_panic() instead.
> 

I only compiled this and I wanted to test this today in my
SEL environment. The patch is a suggestion and should trigger
maybe some feedback.

>> -	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
>> -	if (!buf)
>> -		return -ENOMEM;
>> +	mutex_lock(&work_page_lock);
>> +	buf = (struct uv_secret_list *)work_page;
>>  	rc = find_secret(secret_id, buf, secret);
>> -	kfree(buf);
>> +	mutex_unlock(&work_page_lock);
> 
> The commit message does not explain why memory allocation is not
> acceptable. Usually this translates to non-sleepable context. If that
> is the case, then using a mutex would be wrong. This needs to be
> clarified.
> 
>> +
>>  	return rc;
> 
> Unrelated whitespace change.
> 
> It is up to the kvm folks to decide if the whole approach is ok.
