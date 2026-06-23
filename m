Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC902C0F7F
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782221305; cv=none; b=KQX/mN4SmdYnsmLoMxbycE3id0kJY87W2VtKw40k7HOl5ZG83FBNeE6Jw/bjAagMnAbtxu9l1oQ/979X0knK2hkXPnhiRkuyJxEZ5+0lUrSe3tzZWO4aO17icWRO5lAvpx4iP7zumW9HObEZrc6Kfl4leOVpoCSXq5EHGVitMLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782221305; c=relaxed/simple;
	bh=yTWXNUVzHexYZDD2vmaeP510/j4hEwcfnr+BNfvyTic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DToD4AipPr+CEV5uUw6e9P0sW0xCri8MKYXNUMnTnCzO4JB/lZijA26t0fuQgz8Pdvyj2T2QfuLBb5S62Btok2n1dhCmbYhHf9EuNT8Un08lwOOFdBKn+MRbDtRmS39oHut0GWsHgERYTq0KTp62OdWWogBPxQMbpJQxysFoAEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FjRp4hva; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FjRp4hva"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmR4o1914629
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 13:28:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JDun8o
	9VJfoQ6vJr2L0Jc6GjMnl1cmK9JzKldfRAPis=; b=FjRp4hvaaO/i6s0Nlk6JCI
	wKMYYCKIj3NxqAqgzWwnInBq960qNaRQQXQPjpYiWbBjikzSmGhrtVc/u4ruN/Zn
	NEx1qz8wG0WrfzHneqkrCh7uQOmi5lA2A4WYm5Rcf7Fmhlpa3UKWow2nkV9wQ5kv
	3UMJHMq+ZYVRng6shzyj8GxGEVRiVnfpXwdhsNDAIDsuyYY98Q8KbPeokQGyglzG
	4L6FDXn1TtqvmExDNF9Lu/W8FXVOZzX44alzz3tVulADYf1FL21vzcQNmv2y9zah
	SIKGwRAb6tdrS68kcotbRpI1On3y+yEMvPBHgygSHioMttwKdQPJtCBbkMbZjK7Q
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4eqf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 13:28:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NDJwj5011425
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 13:28:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dg37tg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 13:28:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NDSJ9p16646602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 13:28:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E2492004F;
	Tue, 23 Jun 2026 13:28:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D543F20043;
	Tue, 23 Jun 2026 13:28:18 +0000 (GMT)
Received: from [9.111.220.225] (unknown [9.111.220.225])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 13:28:18 +0000 (GMT)
Message-ID: <2cea3b77-89e5-4c4b-ae03-0b7914c39fbb@linux.ibm.com>
Date: Tue, 23 Jun 2026 15:28:19 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] pkey: Fix for PKEY_VERIFYPROTK iotl
To: Holger Dengler <dengler@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260623102016.3930343-1-dengler@linux.ibm.com>
 <20260623102016.3930343-2-dengler@linux.ibm.com>
Content-Language: en-US, de-DE
From: Ingo Franzki <ifranzki@linux.ibm.com>
In-Reply-To: <20260623102016.3930343-2-dengler@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEwOSBTYWx0ZWRfX089cm2KNk+td
 SXZ8lFr03HrinqoappxD98Vx3Bm5tf2vi60fRmPPMw25NuvSD0XTEkVhuCs5lFxPVzR/7OUmzIS
 qZbVJHijKQ2QdXDvXsUmz9VQeA2+nHQ=
X-Proofpoint-ORIG-GUID: WhBEMQTL9frPiCua00z_dg8rda83xzFW
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3a89f7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=ZRd1Ymhj6U6YcsvFa_wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEwOSBTYWx0ZWRfX6wPa3tTE2LOE
 sbBxpTZDm4sta0RkDi6lM8jKnZr9GWbBaVVkb9l3m+CrOGrP5vmnwCF+gge7n466Nm533XI66h2
 lPX2n8jaGdFFavmyknf+l9KeTyCcMbyVWpeM+mwOtyGagdrPggty2/fNo3rRpYj8IrVUI23shXc
 KYLHW28+L6jwfmHgHBbcFZHqkU+bllNcFF1o1MreSRHgCE9XQ6KGeH1psZ1osYOOpV3uio8Rww2
 JkzMjjgi9jfkZGnoZZe73s05uJtPiCeKPfuDV3E2j7Azo8AM371BFJ5dT8Jgu9n63VaCLnW3a/6
 mQfZOXUlFod8B7IPbEOA32Rdcw03OEwrkOiUHhhRXjsg1EBzX9IFx6jRItGigysXzW5/mYlM8w3
 6ZnV5/O3tW52TnY5AHH/x5I8Y55ZvtgWpRDIICK1EGGOIh8Jj7gsLSko2uAhGiuBI4ECF1Mlj+6
 4G0nc29giQObXMo7VSg==
X-Proofpoint-GUID: WhBEMQTL9frPiCua00z_dg8rda83xzFW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230109

On 23.06.2026 12:20, Holger Dengler wrote:
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
> 
> diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
> index 28e1007005f2..5d8f63f390a8 100644
> --- a/drivers/s390/crypto/pkey_api.c
> +++ b/drivers/s390/crypto/pkey_api.c
> @@ -327,7 +327,6 @@ static int pkey_ioctl_verifyprotk(struct pkey_verifyprotk __user *uvp)
>  {
>  	struct pkey_verifyprotk kvp;
>  	struct protaeskeytoken *t;
> -	u32 keytype;
>  	u8 *tmpbuf;
>  	int rc;
>  
> @@ -341,14 +340,6 @@ static int pkey_ioctl_verifyprotk(struct pkey_verifyprotk __user *uvp)
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
> @@ -358,7 +349,7 @@ static int pkey_ioctl_verifyprotk(struct pkey_verifyprotk __user *uvp)
>  	t = (struct protaeskeytoken *)tmpbuf;
>  	t->type = TOKTYPE_NON_CCA;
>  	t->version = TOKVER_PROTECTED_KEY;
> -	t->keytype = keytype;
> +	t->keytype = kvp.protkey.type;
>  	t->len = kvp.protkey.len;
>  	memcpy(t->protkey, kvp.protkey.protkey, kvp.protkey.len);
>  

Reviewed-by: Ingo Franzki <ifranzki@linux.ibm.com>

I like your new commit description proposal! 

-- 
Ingo Franzki
eMail: ifranzki@linux.ibm.com  
Linux on IBM Z Development
IBM Campus 1, 71139 Ehningen, Germany

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Geschäftsführung: David Faller
Sitz der Gesellschaft: Ehningen / Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM DATA Privacy Statement: https://www.ibm.com/privacy/us/en/
