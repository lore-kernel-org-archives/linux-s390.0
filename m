Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793963581;
	b=wDW+yiRNix8oWLzABxJVB7HEG56i6Gcto5RsVIdSD4hMzBYycvLi4nUpmO/+a27CDw6K
	 PoTP/uvpsNCnu8vpn4FxBYw5kuTLHae4d1GDKsWf5Fu/0J1lCN0rp0I5sMWccF+Fy1Aax
	 U9hTGvReCT3IvOBzYEIwTnXYSZZFtODTQHZLi3p2tFkHtxSc2vcN+YZeJBFq7uI6iOdK0
	 +xgSoUemPGIcrrP3FvyHYK3KzCkxzmPQwGx4cdzxIjvmSTyiXeGI97rg6QDQYBPTJw75j
	 17rxDUrC66FysY7VssAe3v2cDX0tde5i9YD9/ucNMEtA7Wt2jNB5mhYpS7a4ukwjqRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793963581;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=m5q5ofI+ll85+3zMUcaYPn2oo09ua4JomN9gsXIUP1c=;
	b=MEBoN/M6FrUEyvOz4pxnw/nrE4t8AA6TSGi3r9NEd/7XamXt+udYCW6U2p9lIr40detv
	 uO5d98fsUi8IBYBBZ+C3G0ymX2coll5elu+YaBt2YUHsas5XgEOS1iSynIoc8o5ds/Mnu
	 mgpOPWYSex0BzpikvtACAftWO9LOsLubg/eCHVA/PpkYwjR3SJeUDmYmBEKlXdTT6L41e
	 sy0mo8XaMKyEcU2Xmvx2NR2TeFtdTqK+sT2LOAoCaczdQyHG+fxV5cEWNcHPjmlgTEu3N
	 PTW+tkWuviVnDKpWEjVOcnUN/+5rxwqYLoDr5mdsAsWxt7FWPuQ/zlvPJkasmaea0sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YmlJMYK5;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691B1606A337
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 11:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 691B1606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YmlJMYK5
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AiZe22143981
	for <linux-s390@vger.kernel.org>; Fri, 6 Nov 2026 11:13:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=m5q5of
	I+ll85+3zMUcaYPn2oo09ua4JomN9gsXIUP1c=; b=YmlJMYK5XDowvRNExEMwCg
	abNzU+9MRxXu64uQMS9ikwkGxECA8VkVQQv1AJKdo3MCrX6C1CBribTYWBA3WWbg
	JyI9XfsyCQ/dGs5J400HmfcnMT4NJ3PdqaX8RVNxNiCE6YKYOoI8kch4epbO8cBD
	vvPwrKoViODKa57rxMPNh9mbNpdlvNuVnRoTg0BTYTFW/xapV+teHopqHTRWHaM7
	+rkEVavsEbkGgTXjMyuEB/zmlsW7CFB3/7hmX66ouIODZ/QnbkE852Bi5V92f/Pz
	GX+XcVO4mDB69O0S3X5jW14vAXQFDJ/wCoGziQnPkNGQnAHvRVhFo4T4nuU0cfQQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3r93uyq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 06 Nov 2026 11:13:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AZ18M3302189
	for <linux-s390@vger.kernel.org>; Fri, 6 Nov 2026 11:12:59 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrdd7t68t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 06 Nov 2026 11:12:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6BCtmu43254222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 11:12:55 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1331720040;
	Fri,  6 Nov 2026 11:12:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD2912004B;
	Fri,  6 Nov 2026 11:12:54 +0000 (GMT)
Received: from [9.111.64.1] (unknown [9.111.64.1])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 11:12:54 +0000 (GMT)
Message-ID: <6345f71e-8532-4a58-b991-8f2a0efe1fea@linux.ibm.com>
Date: Fri, 6 Nov 2026 12:12:54 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] s390/diag204: Add common diag204 interface with
 caching
To: Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
References: <20261104-diag204ioctl-v5-1-87a96638d58a@linux.ibm.com>
 <97ebb3cb-ce2f-4695-b4bd-8da2dcecf873@linux.ibm.com>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <97ebb3cb-ce2f-4695-b4bd-8da2dcecf873@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=O86sLx9W c=1 sm=1 tr=0 ts=6aedb63c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=Y-efnqSGSXkPl0J74LMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _WOQmFu_y7nssSeZbMe70mJ3tLsc64xm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA0MiBTYWx0ZWRfX5anzB9LCfN0V
 j+z4JsHJkS65v5nJGvBpX3f7OYfPhLsMA4O2c08VXZEuC7VicCksEanZQdvDKhPychReMrqjMoq
 2yFhqy0SQoU4ycxpYABZK7pK0BMakciDiYu6RLfd4/WRmsjRKlkJsiGT8kL3KkkUuw4pW+KxW8E
 P/nNVQeDY+Vn2MhOL7Rm8OsV6g1jjmNpZJ0gMtPkpFKejj0q38V+/a1KkPCcK8xs2+0arQXMsw/
 1GGM7+ymrOpSBv9EhvmJvEKIloycDdBolp5q5ibZqVPjZJhGh5TwFWWYKJcAx6jySW06LShzxqE
 4w2DcbSJ8gAFTiNWu20inhvQe156BmYTbxBOwrieb+jvrP+2GOViKHbwvD9Fj0OhRWkS9fkSA83
 tAn4Q4T5TwJiTJfA9wy3NkRYfmszVz47Ec6jrv1nRSAsmbi3q42lpHfkZ/fjJTJoLY9NcfK2xz8
 t0i7f3r8vvKbVRv7QVA==
X-Proofpoint-GUID: _WOQmFu_y7nssSeZbMe70mJ3tLsc64xm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA0MiBTYWx0ZWRfX3M4WxhBkoFRh
 weJyPjuXseh8cqaaRHCyw9ZL4cr4sNy1TsU/wAxZ+1Vx3A137NojYtmfYRA6+7lknxRPseej0nX
 UyPO6sdz3PlcpDCre9y1aOi30PxtHfo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060042

On 06/11/2026 00:06, Ilya Leoshkevich wrote:

Hi Ilya,

> 
> [...]
> 
>> +static void diag204_work_fn(struct work_struct *work)
>> +{
>> +    mutex_lock(&diag204_mutex);
> 
> Consider using guard(mutex)(&diag204_mutex).

Right, that would make the work_fn much simpler;

{
         guard(mutex)(&diag204_mutex);
         if (diag204_is_cache_valid()) {
                 mod_delayed_work(system_dfl_wq, &diag204_work, 
DIAG204_WORK_DELAY);
                 return;
         }
         diag204_free_buffer(diag204_cache_info.buf);
         diag204_cache_info.expires = 0;
         diag204_cache_info.buf = NULL;
}

I'll incorporate that!
> [...]
> 
>> +/**
>> + * diag204_store() - Store diag204 data
>> + * @buf:             Diag204 data buffer allocated using
>> + *                   diag204_allocate_buffer() or a page aligned, 
>> zeroed buffer
>> + *                   with a size acquired from diag204_get_buf_size().
>> + * @allow_busy:      Allow diag204 to return -EBUSY instead of 
>> blocking and
>> + *                   return early when there is a concurrent updater.
>> + *
>> + * Diag204 queries CPU utilization data from the hypervisor. Per CPU
>> + * utilization information is returned either only for the current guest
>> + * or, with authorization for all guests configured.
>> + *
>> + * Context: diag204_store() can sleep and holds diag204_mutex to 
>> serialize
>> + *          diag204 cache access.
>> + *
>> + * Return:
>> + * * 0 on success
>> + * * -EOPNOTSUPP diag204 is not supported
>> + * * -EINVAL if @buf is NULL
>> + * * -ENOMEM if the temporary buffer could not be allocated
>> + * * -EBUSY if @allow_busy is set and diag204 or a concurrent cache 
>> update
>> + *    is busy
>> + * * -EINTR if interrupted by a signal
>> + */
>> +int diag204_store(void *buf, bool allow_busy)
>> +{
>> +    int rc;
>> +
>> +    if (!diag204_is_available())
>> +        return -EOPNOTSUPP;
>> +    if (!buf)
>> +        return -EINVAL;
>> +    rc = 0;
>> +    if (allow_busy) {
>> +        if (!mutex_trylock(&diag204_mutex))
>> +            return -EBUSY;
>> +    } else {
>> +        if (mutex_lock_killable(&diag204_mutex))
>> +            return -EINTR;
>> +    }
>> +    if (diag204_is_cache_valid())
>> +        goto copy;
>> +    rc = diag204_update_cache(allow_busy);
>> +    if (rc)
>> +        goto out;
>> +copy:
>> +    memcpy(buf, diag204_cache_info.buf, diag204_get_buf_size());
> 
> I wonder if it would make sense to return the buffer address and keep
> the lock. Most callers should not take more time than memcpy() and would
> benefit from simplified buffer management. Others can do memcpy()
> themselves. __acquires() and __releases() annotations should help with
> keeping such solution maintainable.

IMO keeping this self contained would keep the lock management
burden away from the callers while also preventing duplicate
lock release chunks and logic.
__acquires() and __releases() should help indicate any misuse
but I am not sure if it's worth it.
One objective of this patch series is to simplify the diag204
interface, so I would like to keep moving forward with the current
approach if there is no big reason against it.

Thanks!

