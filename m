Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DC130B521;
	Tue,  3 Feb 2026 09:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770111578; cv=none; b=UJNxh4cQQwuiiI+zCAvK5KYX8fGqhuCHCUfDbX833C5YJ/fuol11JJc3PkaHGh69Ut092IOzRmTAXhI/O5N4zGqDoQudqgCgTmJq6iWGhOS2KIwD0a2dDzKrjrY451iOl5ZJzTiyX57nvWknJBQW8/ZpJ2fuboLe22kMLoRY1zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770111578; c=relaxed/simple;
	bh=1nfHEPjLlMLjdBUR13J5tgA0Jm+YEV5ggos+4VxspUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JORvRApnSICPF19mIsm51GqFPo6iXHKKCWxy+I05r/sXsrMCw8xjXdYRNvqJ7htZQjI2UjP7MVPchdty3NMjeGHTnyRZ8fJtCCavlTu0sNaOSRNhJewR0EEyyIC80GYpK7N8rFuy0sZikRsCjisrosGoJDKQIZPtpn674pC/JGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kInOLDdg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kInOLDdg"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6138kqYO006454;
	Tue, 3 Feb 2026 09:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1nfHEP
	jLlMLjdBUR13J5tgA0Jm+YEV5ggos+4VxspUw=; b=kInOLDdgtnu9CwZyWtESuK
	rgQpDPDJM049kgVaJoks5AFxL5r0kFXmmhzcMy1s4jsbuHyEvdEe29G4kRb1VrrU
	YLo1KUPr5ZYlWUpTRo6LAEAImen6HuBgRcdkZigYtvwKlmPqYMol2axGpNA17Jia
	cSa9mayglJp9VqgVAgCEV3A91gEcGc28ay2DCGflYSpCkBx9mUc1FRb9Ctto+CJo
	nobqrlSY5iawmgQxZ9FU9KjTtdDejjDD01RsA377EuV3brOry1RiRQUrylkPM+qb
	okfAtYWh/60nfaof0qdNVwvrwCMeLdys2meeJl/AMJiQxZBDogIi4VfB4vMV6MOQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19cw2dm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Feb 2026 09:39:26 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 6139dQ5s024535;
	Tue, 3 Feb 2026 09:39:26 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19cw2dm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Feb 2026 09:39:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 613755Ep027425;
	Tue, 3 Feb 2026 09:39:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c1xs188rq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Feb 2026 09:39:25 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6139dNO023265960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Feb 2026 09:39:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2B8520043;
	Tue,  3 Feb 2026 09:39:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CE5F20040;
	Tue,  3 Feb 2026 09:39:23 +0000 (GMT)
Received: from [9.52.217.119] (unknown [9.52.217.119])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Feb 2026 09:39:23 +0000 (GMT)
Message-ID: <823b3697-d806-47f6-8815-fe17a616bf97@linux.ibm.com>
Date: Tue, 3 Feb 2026 10:39:23 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] net/iucv: clean up iucv kernel-doc warnings
To: Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org
Cc: Thorsten Winkler <twinkler@linux.ibm.com>, linux-s390@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
References: <20260201072309.222155-1-rdunlap@infradead.org>
 <2ddf6abd-d10c-4d75-8f84-0fd1ccb5435c@linux.ibm.com>
 <136674a3-cf8d-4da9-a82d-d0edea6aca03@infradead.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <136674a3-cf8d-4da9-a82d-d0edea6aca03@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA3NCBTYWx0ZWRfXwSgCKv6b/D/n
 os/b7mrxbNk9EcYG7AO0fqpsIY00uiUrZK/ZKXizqZeVVH5rch5P4PvB04MkMU52oolw9Ts8OVB
 kz+lNpuUGWCkymQjvowcH/sgUsmhDsdYv2TtjWcRXcdAhIJNugyc0JQaE6WrvGqKpxXowU/ITvI
 LXYofNusmhiXPhI3e0DGVxb3JpRugOYOVS1NxAFQN5KzCZfko+6+gtlwPYfuhLj2S19hxiD5BnT
 qx/eUjwDlbq/9DHllvOWs2Lz8VFEoNF59a0bCnePXpsqHFQrsvdOm5L/MvrVK93504PYwhFFbyb
 VdPVdzmTAFKejnBysoYlAur5QJGl027swlRg5lcAl1NwEgqiKpUexJCyhMIsPr2DWa/aakgSksE
 GuN0bKH845pp+aWgMrMBvIQJ+yPkVYKaJ67R//0uI83+lArZA2TpUikWE4VZ+imfThmZLVGfTOn
 ottnqUcFKofgNvWax/w==
X-Authority-Analysis: v=2.4 cv=UuRu9uwB c=1 sm=1 tr=0 ts=6981c24e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=9u7_UYV75-LdL4F_DmAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: S4gJwDnjB9kL7onhuOhNr3wcrLHnwT5e
X-Proofpoint-GUID: ans6Yl_Qr_5Hy_jAQtr-kqfrcXFGxItr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_03,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602030074



On 02.02.26 23:07, Randy Dunlap wrote:
>> All the fixes look good to me. And they get rid of the mentioned warnings.
>> I appreciate your approach to use the existing wording, though it may not
>> be according to the latest style guidelines.
> Is that IBM style guidelines or kernel?

I was referring to kernel style. I'm not saying that any rules are broken, but
some of the 'short descriptions' are a bit verbose. Mix of imperative and present mood,
Periods at the end of descriptions, etc
I don't think it's worth polishing that, I'd rather keep the original wording of the authors.
I highly appreciate getting rid of the warnings.
