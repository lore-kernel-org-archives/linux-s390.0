Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E944112CDA5;
	Wed,  1 Apr 2026 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775056684; cv=none; b=j9iz8VoOBG4rx3zVVgNnFS2EFEF9+ScCZ+Xd5S8TXYxe/CR/+n/a87Eu7p6EWRmWM0Tbe/NKF+xtMRtwndSExLZN/SGY7/D/JK7TL+6lmrAhl8UN9c6bGlh3arZA+4u/QSUrN0AZZ9mDGmmveDxsNrQfgH/zPWX+q1l981lUzho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775056684; c=relaxed/simple;
	bh=lorOsbFaPnPhmV4aMIzlHO2a/Sim/TZXouBG2Ivw7Lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iT2VjEvFskCCUaqBUJ7oFzqiBgf1J1/X4RqpLl5wNgK3xxgMeOMrOIX1u3ZyQRbkV7xaXASGgC0cIbPZMEifo8iC3Q1FVJpnc+6UzJqgqVvY4lyrTfYJuB3YUG5BnTvNKBKpgfaevUM/RMXGlofN6nql1E4tSuYWALBMovScZqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l97ak1LR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l97ak1LR"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631F1uts2571895;
	Wed, 1 Apr 2026 15:17:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Nchw1m
	K/93Q4bIwTBaD/Y72ZiaKGVLWrAn1jEqNcvjY=; b=l97ak1LRnDjqk6OJma6rkN
	LvfUkzpjYTEQu7vwth7txQGi9nbusf+EHC/EerN1nCDTL5ik0UhK3MM+wJfo/H+Y
	i1enOwm/EH1pbFPgHG5gOd8eqye4NOUf116mXJilklKMT+KiYnul/SEUKfxTeF6/
	2QI4JtXE22XVYv4cx1dfm9Vk8qsXY3Yv4DmOA+adBGpI9/LImialvRTlXWAfOGPW
	YGsQE967uMrubdfntPiQaKXdy9/T+vwTUCRt0p287mCb/PFXZIvk4JuiIXNz86AV
	dBYUhSWg8T9Lagqs901u3w8qkV+trl/PyBqTh5NP0Fd0sxlvlU+1KskyIZGra4tA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66nnrtf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 15:17:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631F1jub005952;
	Wed, 1 Apr 2026 15:17:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spy68j9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 15:17:52 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631FHmwZ51184040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 15:17:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D0802004D;
	Wed,  1 Apr 2026 15:17:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 424AF20043;
	Wed,  1 Apr 2026 15:17:48 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 15:17:48 +0000 (GMT)
Message-ID: <48cc299f-bbf0-494a-af21-5584bd96e0d2@linux.ibm.com>
Date: Wed, 1 Apr 2026 17:17:47 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] KVM: s390: vsie: Allow non-zarch guests
To: Eric Farman <farman@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20260401151221.2272408-1-farman@linux.ibm.com>
 <20260401151221.2272408-2-farman@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260401151221.2272408-2-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: n18e6J7Kcilxm5Ala3dGHjmODHdDaL8a
X-Authority-Analysis: v=2.4 cv=KslAGGWN c=1 sm=1 tr=0 ts=69cd3721 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=iwh2BbymMtlSOG_77RAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE0MyBTYWx0ZWRfXw65Ltpkxi/6t
 vr2xHRWmcqgWu5uJgPXTz4kpJi+Iet8Y0tsfwtIHjw9vY5HqxD+xtwpcB2PyVc8c6g1BTQx8aGV
 zEAqOzKHQnEhI2oUcvucwwUWysfR200SJsKd6yUBxI/Z/TfFAkRlrcMbLZyCGzANVHgrUv0YC5I
 SCHoi0ihmdseqlghNov71+f/46jnOAYWuSMhx7cktcSRwNhoCPnzOQ2YC+Pm8jMGCMTFP22UKXL
 ks7nL71jXNbdcHxDh+eMESTBJhvbAxN8/Jf8UIWxG/0NoF3y+TUCKFPkOoLTGz95Opyqh6KKcIy
 jjTKIqsZD6FXlUdRL3c1HpW494mes9VoXvF/aPV1Oau/jX71koTqxzhQ9/UFXKbWoRRCffrN1A+
 9d7NlFiY75iQagJKU5JcZSYD3OpVnzdABOPfl8+vaLOkZ11wQ9NBGNZ/zuny/aPO+U3cN1kiGdK
 xK4D12IJB6snnHoMUAA==
X-Proofpoint-ORIG-GUID: n18e6J7Kcilxm5Ala3dGHjmODHdDaL8a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010143

Am 01.04.26 um 17:12 schrieb Eric Farman:
> Linux/KVM runs in z/Architecture-only mode. Although z/Architecture
> is built upon a long history of hardware refinements, any other
> CPU mode is not permitted.
> 
> Allow a userspace to explicitly enable the use of ESA mode for
> nested guests, otherwise usage will be rejected.
> 
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

