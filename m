Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C303EC69C;
	Thu, 30 Jul 2026 08:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785401946; cv=none; b=LWr+rAvvq2OtCIkQx5QKIQL4JWDmr1kp15dZadDqie6nkBtuP+KiKf+uEJ0dUx6j9LNEfeMBR9cQecQwQNhJF7Ug+nJKfC9KCtYZpeQevQMsqdeN41WW/NXFpFVEpscz7v6otZh3WDCYMeAmgNu+zAoqPlukN3F7UXcjjVBbjOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785401946; c=relaxed/simple;
	bh=k7G6O5pohxpDEVzUzkihtFYFZ5WAbaFjJXjjifxC+ec=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=L+Wa4DM9UsPF65SrjxvYdN3HkwKQKK/honndfn3zWsvB2gEXYnAbdTYhvwKG0oH77jZA+Vttte+MJ38MMIbfC7EWcH+0sAobpMQH1KN3bCDJXuA965h/d4iXggiF5bIzgdoPSoTX54+PIWGTT3NafgwVs6iO/fzWv3ANkn1c+ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nNTw/sI2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nNTw/sI2"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U6mAi82316917;
	Thu, 30 Jul 2026 08:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=NxHqtfXhPiGuLBYt1/KAoh9JBeatsd6W0tLD1yfVrsk=; b=nNTw/sI2WUaV
	dxqu/h0VLhRT6eqRgQ6ZY5ldRal+EVLQXAEt4CtvmDCA9QRMsXM+MCBFjNgsza6B
	ZpOBpip8PN0sZmZ1/uqoRmNdtfvUfLWCeFYohwI8K9HUzFIQd9yvAO4gmwpq5JIU
	CjZFuESAVIaIsb//ETa6bD2VZn4243Pr0EnNflxHnJy9AIkNf4JBYEuSUCVaxBK4
	Pcl2zz6jqEUl4ZEGAnXq58kfqVLvO4QM2yZIR92paPgR573rVDvSsLksgsuXkdS8
	1R9dvoQQ8r3fCVTy6Lu6ndGqGb+b6PGTGRtDwFgF6mqEJgOOpt9JC/laNZbWwS8K
	qwGh0iUQ5A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwd6289-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 08:59:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66U8uXBJ003833;
	Thu, 30 Jul 2026 08:59:00 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgjde6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 08:59:00 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66U8wxMg20906530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 08:58:59 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED70458055;
	Thu, 30 Jul 2026 08:58:58 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CC575804E;
	Thu, 30 Jul 2026 08:58:58 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 08:58:58 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Jul 2026 10:58:57 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v9 3/5] s390/zcrypt: Improve EP11 CPRB length and overflow
 checks
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260729163556.F272B1F000E9@smtp.kernel.org>
References: <20260729154458.195135-1-freude@linux.ibm.com>
 <20260729154458.195135-4-freude@linux.ibm.com>
 <20260729163556.F272B1F000E9@smtp.kernel.org>
Message-ID: <e490a59774eee9337bd13ae7c00448a4@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lAjcq3-ggclsXAUH59u5Tr1VmHMmhwxc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA2MyBTYWx0ZWRfXxAdXg9DUn5e+
 0q6Ij/2y1bO595FMgz/den25NJJzhbk6dZtHOFYwnVqfQ1YPujsbPcVpN2tUXmQl3Ed3RTmuryz
 FJFzgBv7GogSPRDjAoUnm1xlVYV3hck=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6b1255 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=HNJEsDsedD291cwwshcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA2MyBTYWx0ZWRfXwIasaNF/aaKJ
 3CQyZtXWZg8Xo3P+JP10Zubmf/t5nTe80ustMHa9qS2VwhDiP6NIQxmMG2d4uGFWdu48rhaJpVV
 DfRgVuFJjYDZawPePmWqMOjTXsZyTt7OP+yCPV+FDFmUj5F9UJJLi55u1kQhOfob0pcozLn2vMi
 PRKzhqMzkgbiT5B1Yw7xMHqMXcCTbJm2O/kCxR+1WiVVY7u3PVa/Cj64ijWG1gcNpqKN+BkFyCk
 SBwMsuzO24bFai4x73YpfKlY9tEy+mgBCTrAufVwAsA/lmw46TRfZM/bLbsqEC57xvh4XPA10cJ
 UorW37WfO1amqkmwkOH+Hi5JqvR9rYnGIbfnTUJG/VubmWFNUeUNOsPUOjJZYecG9EUf9vB07BO
 wRN3+ef9Ksnx6bT0naSMOKgkTXctqbI1xVcJ+Am6cd4Sbg5YFcDR7PEk9bJyZWY6heC8IjoVSvv
 hd75fi5H+ddd71cdZ5A==
X-Proofpoint-GUID: lAjcq3-ggclsXAUH59u5Tr1VmHMmhwxc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_02,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300063

On 2026-07-29 18:35, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
> 
> New issues:
> - [High] The `asn1_int_decode` function casts potentially unaligned
> byte pointers to `u16 *` and `u32 *`, invoking undefined behavior.
> 
> Pre-existing issues:
> - [Critical] The patch updates `xcrb_msg_to_type6_ep11cprb_msgx()` to
> flexibly parse ASN.1 payloads but leaves the legacy fixed C-struct
> overlay (`struct pld_hdr`) in `zcrypt_msgtype6_send_ep11_cprb()`
> untouched, allowing domain isolation to be bypassed.
> --
> 
> --- Patch [3]: [PATCH v9 3/5] s390/zcrypt: Improve EP11 CPRB length
> and overflow checks ---
> commit ea4312469ba49e7cc43bf68e3a1d383e305d99b5
> Author: Harald Freudenberger <freude@linux.ibm.com>
> 
> s390/zcrypt: Improve EP11 CPRB length and overflow checks
> 
> The xcrb_msg_to_type6_ep11cprb_msgx() function lacks proper input
> validation, creating security vulnerabilities:
> 1. Missing minimum size validation: The ep11_cprb structure and
>    subsequent payload fields (pld_tag, pld_lenfmt) are copied from
>    userspace without verifying sufficient buffer length.
> 2. Arithmetic overflow in length calculations: CEIL4 alignment could
>    overflow, bypassing size checks and enabling buffer overflows.
> 3. The payload is asn1 encoded but the function just uses a simple c
>    struct overlay to access some fields of the payload.
> 
> Fix by using size_t for length calculations, adding U32_MAX boundary
> checks after alignment, and validating minimum request size and
> minimum reply size before copying from userspace. Do a very simple
> asn1 parsing of the payload up to the function value field.
> 
>> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c 
>> b/drivers/s390/crypto/zcrypt_msgtype6.c
>> index fb37e28c82424..c4b5d9b85f7a9 100644
>> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
>> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
>> @@ -439,12 +439,61 @@ static int xcrb_msg_to_type6cprb_msgx(bool 
>> userspace, struct ap_message *ap_msg,
>>  	return 0;
>>  }
>> 
>> +/*
>> + * Simple asn1 int reader/decoder helper function
>> + * Returns number of bytes processed or < 0 on failure
>> + * Only accepts int length values of 1, 2 or 4.
>> + */
>> +static inline int asn1_int_decode(const u8 *buf, size_t intlen, u32 
>> *u)
>> +{
>> +	switch (intlen) {
>> +	case 1:
>> +		*u = (u32)(*((u8 *)buf));
>> +		return 1;
>> +	case 2:
>> +		*u = (u32)be16_to_cpup((u16 *)buf);
> 
> [Severity: High]
> Does this code trigger undefined behavior?
> 
> The buf parameter points to an arbitrary offset within an ASN.1 encoded
> payload in xcrb_msg_to_type6_ep11cprb_msgx(), which is not guaranteed 
> to
> be 2-byte aligned. Casting this unaligned u8 * to u16 * and passing it 
> to
> be16_to_cpup() violates C strict alignment rules.
> 
> While s390 hardware generally supports scalar unaligned accesses, the
> compiler may assume u16 * is properly aligned and emit instructions 
> that
> strictly require alignment, potentially causing a kernel panic when 
> parsing
> untrusted payloads.
> 

ok, will be covered with v10.

>> +		return 2;
>> +	case 4:
>> +		*u = (u32)be32_to_cpup((u32 *)buf);
> 
> [Severity: High]
> Does this code also trigger undefined behavior for 4-byte values?
> 
> Similar to the 2-byte case above, this casts a potentially unaligned 
> byte
> pointer to a u32 *, which could cause an Oops if the compiler emits
> alignment-strict instructions.
> 
>> +		return 4;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
> 
> [ ... ]
> 

ok, will be covered with v10.

>> -	struct pld_hdr {
>> -		unsigned char	func_tag;	/* fixed value 0x4 */
>> -		unsigned char	func_len;	/* fixed value 0x4 */
>> -		unsigned int	func_val;	/* function ID	   */
>> -		unsigned char	dom_tag;	/* fixed value 0x4 */
>> -		unsigned char	dom_len;	/* fixed value 0x4 */
>> -		unsigned int	dom_val;	/* domain id	   */
>> -	} __packed * payload_hdr = NULL;
>> -
> 
> [Severity: Critical]
> This is a pre-existing issue, but this patch updates
> xcrb_msg_to_type6_ep11cprb_msgx() to parse ASN.1 payloads dynamically,
> while leaving the legacy fixed C-struct overlay (struct pld_hdr) 
> untouched
> in zcrypt_msgtype6_send_ep11_cprb().
> 
> Does this allow the cryptographic domain isolation to be bypassed?
> 
> The kernel enforces crypto domain isolation by overwriting the dom_val 
> field
> in the user-provided EP11 payload with the queue's domain:
> 
> drivers/s390/crypto/zcrypt_msgtype6.c:zcrypt_msgtype6_send_ep11_cprb() 
> {
>     ...
>     payload_hdr = (struct pld_hdr *)((&msg->pld_lenfmt) + lfmt);
>     payload_hdr->dom_val = AP_QID_QUEUE(zq->queue->qid);
>     ...
> }
> 
> Because this still uses the hardcoded C-struct which assumes func_val 
> is
> exactly 4 bytes, what happens if an unprivileged user crafts an ASN.1
> payload where the function ID is encoded in 1 or 2 bytes?
> 
> It appears the actual dom_val would be shifted earlier in the payload, 
> and
> the kernel would overwrite the wrong bytes at a fixed offset, leaving 
> the
> user-controlled domain ID unmodified. This seems to allow an attacker 
> to
> execute crypto commands against unauthorized domains.

and patch #4 in this series addresses exactly this
