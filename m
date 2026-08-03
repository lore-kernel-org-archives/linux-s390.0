Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FAB386C3E;
	Mon,  3 Aug 2026 09:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785748122; cv=none; b=u2tbsvzhZS+Ay7UlfNT4TPnyJVWOnNCqWr20gikUld1OzBUFerCXs9TLyAm9WRyBjIyjSboAmJTU0sQgBtLEAmsNcSIFDaGO/a0cnsXnD40nQ8plwPs+pCl1tZD24ebdd13Uj4LN9Gf++1KozCe9vFctxPlNAEh2xgy49p93Dbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785748122; c=relaxed/simple;
	bh=F489Igwh/DWduFC2ll+3/yC4yhAOHvfCB4gRVFjDlic=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=sPdt+RX4BNl90QVOlc0zniMVkxpb9kKPLz6e45a2HNmZ+v08/1pU+AwjMOgGTqPa5R8c9Jz1RuuHYyk7S4fKzcBBDQEFXIiX+yxfHa4riJwGJR6tjj2dnRL1x+0QctaVU3wCa0K8rDCDZ40gDdq8F1KcoaCNwb47fh2QJaTgdgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hbU6Dnxw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hbU6Dnxw"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LlgTS243685;
	Mon, 3 Aug 2026 09:08:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=uRmA8xNWJh+7T9v0zRg/umN3ESUveadlhwJnKsVH6B0=; b=hbU6DnxwuAVh
	WaOw1MIkoMuUhkKfqfGDXndCp+7tF5JzljWoqzbZf7IoI9ybQePAJx6mMAQyyso0
	CXfI/vqjpv2gC1Sh0kBR/sL/mgcT69h6F2qmDX9jVB9BAm+MbVg9POOr3NsXPTER
	YFkzRh28F0EaCa/vVeJamBpUdFiG/iXhNSFn4gFksbkpjUz+DUfgfdykhg1USf0i
	9m9boVR7i7vbe2g+xUnCMGpwS4ub8ZRtA2XqI/xMSBBv0uG1Be19UwxvfcuS/Lbf
	PGHHHMZ4/hxqlY0DhP9Ed0HJaYE4VfIme004nJOkJLp4Ekh0vknBZYZiqN8N8ip6
	XlHn7ULgXg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4qvr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 09:08:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6738uGIw013174;
	Mon, 3 Aug 2026 09:08:38 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugvvr5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 09:08:38 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67398bYK15991386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 09:08:37 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C25058062;
	Mon,  3 Aug 2026 09:08:37 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0325058057;
	Mon,  3 Aug 2026 09:08:37 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 09:08:36 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 03 Aug 2026 11:08:36 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, Vasily Gorbik
 <gor@linux.ibm.com>
Subject: Re: [PATCH v11 5/5] s390/zcrypt: Pad trailing CCA or EP11 message
 with zeros
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260803084925.617881F000E9@smtp.kernel.org>
References: <20260803083339.212885-1-freude@linux.ibm.com>
 <20260803083339.212885-6-freude@linux.ibm.com>
 <20260803084925.617881F000E9@smtp.kernel.org>
Message-ID: <68406f4891093fa940b04e51ec4dbe35@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA3NyBTYWx0ZWRfXyVFBB3mozrMp
 rQI3ntfkpvqlKz0wwkSc9Xxcv6wPvXKuJga1322vN+VYcH2YngPSdLAnkc8yu0Srnya0ophJOHp
 tlPqDjvmABI8Rwef8qAjLw2t53JGMPQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA3NyBTYWx0ZWRfXxQ5xQmYbah7y
 DI/bZW+6PyDHYFjxiuD+PTQLYT88gFn6d/IWDDUORUpSGkgZVaT5oLhSFcqTiYg27GrggqybPM7
 6LQqLsWRiGVdXsLV9DXDF3HK/ZGUoSQCywU9r7pKXy7F67MZexDpI0D3WtTT3ZkEkAyeNQjwTvR
 NuVf+zt/E3l5Ieie/hLtSiFL6NS9kyWH3HIEwyKnsheGsY6yWWs1DfZA5UYti0EypQFCETus7dP
 DxOEhZimPuqR8vd483jmthVZmLlfMrrKRYdK+y2ehE0s6Ns6gFYdiaTBJVmfiwpqJuwJgh3UARb
 v0vBbV1WvlWu9IquzMFcmFQ8fLwWMazkOdtH/HRAAEU+a3lUEF1b13oLEyggGLferCtkjpcUKKG
 9RSur6BlGpCqVRyqj7o6GNwynba0pGY3rOKIH8+VxocaF3e8UI8qECUN2pLm+B65F63Q3RZOjdT
 iPMvbzXnWmR2CJQcoGQ==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a705a98 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=q4dMmv0AQhq5Zt8pHVQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: qRjqQure6UI7zhtDrNGlOXgX8SP5Devg
X-Proofpoint-GUID: qRjqQure6UI7zhtDrNGlOXgX8SP5Devg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030077

On 2026-08-03 10:49, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Pre-existing issues:
> - [Medium] The function `zcrypt_type6_crt_key()` leaves up to 7 bytes
> of padding uninitialized before sending the key token to the crypto
> card, leaking kernel memory.
> --
> 
> --- Patch [5]: [PATCH v11 5/5] s390/zcrypt: Pad trailing CCA or EP11
> message with zeros ---
> commit a6bb8fce2d346e386b1306d838ac36f1853d13f8
> Author: Harald Freudenberger <freude@linux.ibm.com>
> 
> s390/zcrypt: Pad trailing CCA or EP11 message with zeros
> 
> This commit pads the gap between the message copied from userspace and
> the message buffer sent to the CCA/EP11 hardware. This prevents
> uninitialized kernel memory from being forwarded to the crypto card.
> 
>> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c 
>> b/drivers/s390/crypto/zcrypt_msgtype6.c
>> index e79e68b4dd41d..3df1d676de5d8 100644
>> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
>> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
>> @@ -398,6 +398,10 @@ static int xcrb_msg_to_type6cprb_msgx(bool 
>> userspace, struct ap_message *ap_msg,
>>  			     xcrb->request_control_blk_addr,
>>  			     xcrb->request_control_blk_length))
>>  		return -EFAULT;
>> +	/* pad tail with 0 up to req_cblen */
>> +	if (xcrb->request_control_blk_length < req_cblen)
>> +		memset(msg->userdata + xcrb->request_control_blk_length,
>> +		       0, req_cblen - xcrb->request_control_blk_length);
> 
> [Severity: Medium]
> This is a pre-existing issue, but while reviewing this fix for 
> uninitialized
> memory leaks, I noticed a similar issue in zcrypt_type6_crt_key() where
> pad_len bytes appear to be left uninitialized:
> 
> drivers/s390/crypto/zcrypt_cca_key.h:zcrypt_type6_crt_key() {
>     ...
>     memset(key, 0, sizeof(*key));
>     ...
>     if (copy_from_user(key->key_parts, crt->np_prime, long_len) ||
>         copy_from_user(key->key_parts + long_len,
>                        crt->nq_prime, short_len) ||
>         copy_from_user(key->key_parts + long_len + short_len,
>                        crt->bp_key, long_len) ||
>         copy_from_user(key->key_parts + 2 * long_len + short_len,
>                        crt->bq_key, short_len) ||
>         copy_from_user(key->key_parts + 2 * long_len + 2 * short_len,
>                        crt->u_mult_inv, long_len))
>         return -EFAULT;
>     memset(key->key_parts + 3 * long_len + 2 * short_len + pad_len,
>            0xff, crt->inputdatalength);
>     ...
> }
> 
> Because sizeof(*key) doesn't include the flexible array member 
> key_parts[],
> the memory inside key_parts is uninitialized before the copies.
> 
> Does the final memset() skip over pad_len bytes by adding it to the 
> offset,
> leaving those padding bytes uninitialized before being sent to the 
> firmware?

Different issue - will be addressed with another patch.
