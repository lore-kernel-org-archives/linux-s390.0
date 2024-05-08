Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6649B15E88;
	Wed,  8 May 2024 05:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715147619; cv=none; b=UP/Z/WUrGjgHxri8v06bb92Bwp3gwq1yeBghnnlC8jJMJNMPw6tB1whv4K5BpgZBm86mEBDFfxE1mFbhNzdPH+CVFgYgIR17kwSFa1w+FZRIJzB2Fev5rJ9+1tF6JYjnX8NVzlK0EQybGzPinrUmEMs3BMVCelCEShqyITsWAoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715147619; c=relaxed/simple;
	bh=jWiLLJBc/mgajnfih97ncmuyLaufqMb/jcnVSUk0xOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=COCuZC+U09I/0Q5Q0dwRFPqi320Pkz9bCJA4ZyUFA4bHNugqAH9EJqLK96g8zl/akIVGMOuNq6GUff/+z5T2xXY+qlhKSSgxExhys9nVAK3z81PqmM7xM0tu8b90IM54dK/C/ueH1IFd655ZNEcnbSBlREtS3JKhTuof68s8M1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JPNrT7Iw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JPNrT7Iw"
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4485lqds012873;
	Wed, 8 May 2024 05:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XU1VmAiv+RAYHCdCH+dFAsY0tjPeqSQGeY5B6WR91e4=;
 b=JPNrT7IwB3W/ayFCWK3DUd8g8PHAVfMBNq/ujjFD+JRL/2Z7obSQX3y4Rak6HQx4gKXY
 3vBOdrzROjqHF5dGUwxxRWgXgwbCveVbsgFyPyrvCwpDhuLf/JWr22xNPsiQWFp4Uwr1
 Wp+oWafS2kCdwhQCpPMNlAIHF9nTsFvN5J6xDe+4H3WLVur0c3j84ZXfSxuNQVB5ldcF
 xDwl5DnvfvQJ3bbZztU9OFMXWCHocCL5+td/t64d3gjefephp6V7huEf+M1r7EyTtaFR
 uWMXpHByvydZ1Mr5a78LMx3YtT/BlDJJQhu+vEDlF5vPiT0VgkNXUwp7+o3NQ5Gfym+3 tw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y03jbr092-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 05:53:35 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4485rZ6a020862;
	Wed, 8 May 2024 05:53:35 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y03jbr08w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 05:53:35 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4484UNw0003990;
	Wed, 8 May 2024 05:53:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xysgsaxxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 05:53:34 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4485rTFC22086118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 May 2024 05:53:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0838F2004D;
	Wed,  8 May 2024 05:53:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CD0E20040;
	Wed,  8 May 2024 05:53:28 +0000 (GMT)
Received: from [9.171.75.172] (unknown [9.171.75.172])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 May 2024 05:53:28 +0000 (GMT)
Message-ID: <5eea6875-e106-47f5-bee6-ce089b1213df@linux.ibm.com>
Date: Wed, 8 May 2024 07:53:28 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] s390/pkey: use kfree_sensitive() to fix Coccinelle
 warnings
To: Jules Irenge <jbi.octave@gmail.com>, svens@linux.ibm.com
Cc: borntraeger@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        freude@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <ZjqZkNi_JUJu73Rg@octinomon.home>
Content-Language: de-DE
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <ZjqZkNi_JUJu73Rg@octinomon.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aAV32HOUNRz1rHDdevC_WpPawFixgfBY
X-Proofpoint-GUID: Mii9njsZl1S-U79SLrh2r8xTh8pogUsx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_02,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 mlxlogscore=654 lowpriorityscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405080042

On 07/05/2024 23:13, Jules Irenge wrote:
> Replace memzero_explicit() and kfree() with kfree_sentive() to fix
> warnings reported by Coccinelle
> 
> WARNING opportunity for kfree_sensitive/kvfree_sensitive (line 1506)
> WARNING opportunity for kfree_sensitive/kvfree_sensitive (line 1643)
> WARNING opportunity for kfree_sensitive/kvfree_sensitive (line 1770)
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>

Thanks, looks good to me.
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com
