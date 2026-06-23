Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDA632B11E
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 14:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224961; cv=none; b=g5M74Kxo7gX9b482FaBbtDFhw7+XYtvsYYCt0OqL0TZZcdYABnzP7m3BsUDCkRHDFmL8G0YQEQk68wCoyH7cbIqp33niXGqprhHewPGWPKmfhT8TqiApKrd077ksAMRE3hffT8tjPpse5gihxSodklSOfnguqGjo6lJc/72VEv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224961; c=relaxed/simple;
	bh=UAaL1JngLFg9GQ/roSFHDgB2Q/NNLY6u9j4Tbu0QLpk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=LPqEyungS++9CE+TjzDJN8F80C0xEPT50wOi33ZObeiwmwaRr0TaBLj+wJMQ1G9mk2TaiMyYFtbamVs9/Ik4j3Yp9rI3mpU1R4M7Ntt4DX1Forwjm9fJV4l1oacH+5RfQVBioOGX8bhD+g6RWlGi3xnn7AX2ULv1RmBBdsL5KFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o9U90NT/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o9U90NT/"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmih22136755
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 14:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=B3AV/LI3eu33JTu9RKUYQLoP2nQB7g7Iwb/osoczyyY=; b=o9U90NT/NIvx
	L5WCWbJWxUPKbqi2qt9jE1gKphAR45xnzlmO9JeHV7l6JwhVFiZ1i93+Gq/5fqB0
	+opDa5IrP+GtFuPUt5EqqPc75CjbQdFCWUVrS79y6Vqh4T5Z4kFsdZcBw9n4zvef
	mSMyVG7hz5emShFMXI8254N2Cn90V1SqaLuJNc4biuBlup5Ts8F7M0t+LJseMLnA
	KeEJa0MFisGX4IElzVH8SmB8C7ngWAOg0QhFYcSkbLf6CY/TG+rY9kIqox5IDZZX
	WtLwJastdlZRm0SZiQyRxSxdtR0NCR50WiGh/tmmcbL6gBc8FfcEft0Xp8m1nYM7
	4KDqe+SbVg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhqq06c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 14:29:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NEPUCv006686
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 14:29:18 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6phbmr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 14:29:18 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NETH8327984416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 14:29:17 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A0BA58055;
	Tue, 23 Jun 2026 14:29:17 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A4335805D;
	Tue, 23 Jun 2026 14:29:16 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 14:29:16 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Jun 2026 16:29:16 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: Ingo Franzki <ifranzki@linux.ibm.com>, linux-s390@vger.kernel.org,
        Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander
 Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] pkey: Move keytype check from pkey api to handler
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260623142031.4053768-2-dengler@linux.ibm.com>
References: <20260623142031.4053768-1-dengler@linux.ibm.com>
 <20260623142031.4053768-2-dengler@linux.ibm.com>
Message-ID: <f6f9e5f8aeefb23d259ad77b874bc768@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3a983f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=WdmtL9VPQa79YndLzNMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDExNyBTYWx0ZWRfX9scaI6RSrEMC
 bVBswbMmI0YsyD4hWwTwEh8Jda2vghR2ikcshJuLCf4wwWfOdt/LBXv6YpRWcSTZ9Cqqrk1ifaM
 L95CwngXusotzWHjALHEVxoNn6R//1KtrfogSDHj6DJpV3vxvezeAi3SRQGKaoYenPMEJ0H+h5i
 ftV77FDoQRafLUdIH0EjfVCpUFx+h9sIlpAo2B0hQ9dBHnzXEUS9k7BiKm2Qpzku2g5aQh+QoMs
 YVJzZmKKKPFrnwHs53va6yypCOsGzpbvLUtShA0kKvFsMWL2nAYpWsvR+p4Jj18sokIvH33umSC
 bUpNv4E3QwF43pxqH43fKYLfPmjxMbU8p7WVNt8G8Hf10bwS8fGVr5N+kzdiZG4rmzgPPVK5yVl
 wvxDeWGIOlSZR+atkKEuKWFbHTUldeXHVuzRDA6f4AKJLy+zoW60QFNpQMRZjpbYIRJCGce1Fag
 gk7JpZWWDL5O8fMRm2g==
X-Proofpoint-GUID: EK6lWXD0nNDdSy2Kt6k0raqNeUsUEI44
X-Proofpoint-ORIG-GUID: EK6lWXD0nNDdSy2Kt6k0raqNeUsUEI44
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDExNyBTYWx0ZWRfXxM5d/X2gccH6
 zxv2X/SKwLoTfT1B30VCV9ePO8VJI1qKAJMG7vkphmu+VRuJkyGQY4Wr43q7QhEGqn3kbDTXW/u
 1rN88+q3fxEYBCpsrc0Ha9MGxnrj0/M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230117

On 2026-06-23 16:20, Holger Dengler wrote:
> The PKEY_VERIFYPROTK ioctl takes data from user-space and verifies the
> contained protected key. While checking the integrity of the ioctl
> request structure is the responsibility of the generic pkey_api code,
> the verification of the contained protected key is the responsibility
> of the pkey handler.
> 
> The keytype verification (based on the calculated bitsize of the key)
> is part of the protected key verification and therefore the
> responsibility of the pkey handler (which already verifies
> it). Therefore the keytype verification is removed from the generic
> pkey_api code.
> 
> As the calculation of the key bitsize is currently wrong, the removal
> of the keytype check in pkey_api also removes this wrong
> calculation. For this reason, the commit is flagged with the Fixes:
> tag.
> 
> Cc: stable@kernel.org # 6.12+
> Fixes: 8fcc231ce3be ("s390/pkey: Introduce pkey base with handler
> registry and handler modules")
> Reviewed-by: Ingo Franzki <ifranzki@linux.ibm.com>
> Signed-off-by: Holger Dengler <dengler@linux.ibm.com>
> ---
>  drivers/s390/crypto/pkey_api.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/s390/crypto/pkey_api.c 
> b/drivers/s390/crypto/pkey_api.c
> index 28e1007005f2..5d8f63f390a8 100644
> --- a/drivers/s390/crypto/pkey_api.c
> +++ b/drivers/s390/crypto/pkey_api.c
> @@ -327,7 +327,6 @@ static int pkey_ioctl_verifyprotk(struct
> pkey_verifyprotk __user *uvp)
>  {
>  	struct pkey_verifyprotk kvp;
>  	struct protaeskeytoken *t;
> -	u32 keytype;
>  	u8 *tmpbuf;
>  	int rc;
> 
> @@ -341,14 +340,6 @@ static int pkey_ioctl_verifyprotk(struct
> pkey_verifyprotk __user *uvp)
>  		return -EINVAL;
>  	}
> 
> -	keytype = pkey_aes_bitsize_to_keytype(8 * kvp.protkey.len);
> -	if (!keytype) {
> -		PKEY_DBF_ERR("%s unknown/unsupported protkey length %u\n",
> -			     __func__, kvp.protkey.len);
> -		memzero_explicit(&kvp, sizeof(kvp));
> -		return -EINVAL;
> -	}
> -
>  	/* build a 'protected key token' from the raw protected key */
>  	tmpbuf = kzalloc(sizeof(*t), GFP_KERNEL);
>  	if (!tmpbuf) {
> @@ -358,7 +349,7 @@ static int pkey_ioctl_verifyprotk(struct
> pkey_verifyprotk __user *uvp)
>  	t = (struct protaeskeytoken *)tmpbuf;
>  	t->type = TOKTYPE_NON_CCA;
>  	t->version = TOKVER_PROTECTED_KEY;
> -	t->keytype = keytype;
> +	t->keytype = kvp.protkey.type;
>  	t->len = kvp.protkey.len;
>  	memcpy(t->protkey, kvp.protkey.protkey, kvp.protkey.len);

Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
