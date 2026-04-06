Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05DAC8EB;
	Mon,  6 Apr 2026 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775499872; cv=none; b=feP06JBqL91V+lCXrjgJSgS+kV269XLIRm1DnFzX1QoCmZ5EFajxq2ST5lolZlXXacDdZQANjENY51C+AqkYzO/1DcliGNkwcfLCmrHQWMwV1Hn8dWmkrFJrXmD2Ov9KNGITo9hH7rLvqvWFYTc1N1Msc0HGQ2apHQC9qAbGhvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775499872; c=relaxed/simple;
	bh=1/Zblc5efXwHMCKKa+kFcdEekZ+kpKn0jAYf50iiRKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XV2/yd0pWlMXswxsvi5H6RzGsX+WE6Goy1o3AR6haqPukqeYQhYfgMt3kYYBnB+Y0GESv1SZro5RIxfPWNu6tPuiEQCbHBgKqzk5arJzhphdluFl6LkbjYqe23cKXby9edjHp7Boqfq+NkO/+9fmJ2OSrpfxrMLCox+1LhfOPvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CLgP7GpE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CLgP7GpE"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6362tbG64143886;
	Mon, 6 Apr 2026 18:24:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EswHya
	loRJc5ViJVdEKJfq174Jji60jPGk9L6YZq2wo=; b=CLgP7GpELO+em+DTkAAi81
	WhFIcqMyNQ0dMVnpzpCU9bY3EyhNOVb4ajMKg5b7pWDqzn8iyL+rwYQekbpEvAmC
	WASHlrRJoRaqbBFK5HklSmbwLPKmBvzVdiA90UATKZbyyWnU6mlXSK5PdLWNCzy4
	/O8LFx8OPGDLYqJe5d6cPENgK/M/VK4wK7j42i9tH4RTukBV6pwHC1ak+NLrOhvo
	2vp8dFxLJkcyuGpAzbzBeEdhsvI+k/iikWLpaZt2WZUjbWQsDbPRstIp+2IIIcew
	405xBpIxQx6tTWWfjna9qAyoqADm/DpMyYqqxVv/keiWrX7BZa13gFah4EdVRONA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4das2bycax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 18:24:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 636FDdVw018517;
	Mon, 6 Apr 2026 18:24:25 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dbcyswubs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 18:24:25 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 636IOOVk28181026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Apr 2026 18:24:24 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CE0458058;
	Mon,  6 Apr 2026 18:24:24 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 795FF58057;
	Mon,  6 Apr 2026 18:24:23 +0000 (GMT)
Received: from [9.61.9.165] (unknown [9.61.9.165])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Apr 2026 18:24:23 +0000 (GMT)
Message-ID: <20708f8c-546d-44bf-ab3a-b9bd59614031@linux.ibm.com>
Date: Mon, 6 Apr 2026 14:24:23 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] KVM: s390: Introducing kvm_arch_set_irq_inatomic
 fast inject
To: Sean Christopherson <seanjc@google.com>
Cc: Douglas Freimuth <freimuth@linux.ibm.com>, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260406064419.14384-1-freimuth@linux.ibm.com>
 <20260406064419.14384-4-freimuth@linux.ibm.com>
 <0b9c451f-0167-4f1b-a38e-6413cf089c18@linux.ibm.com>
 <adP0eA7dBlS4B6gl@google.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <adP0eA7dBlS4B6gl@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: ay5hpSrBLkPLAdA4ftpOybxlk2k3k-ok
X-Proofpoint-GUID: 7eTo9i71uvBZk6hUU6FuuhGHyR5QCI5l
X-Authority-Analysis: v=2.4 cv=U9qfzOru c=1 sm=1 tr=0 ts=69d3fa5a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=a9-v2Dun1yPnsuJwnBcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDE3OSBTYWx0ZWRfX5RrI0qIhe1/R
 Rb/iSbPt2j8w9HTGFGu2ylS+PSOXAkfcbQnhDxko4j2f5bzJENGIXIlLroVOG3Gf+xqF7JAU5Vk
 MFUNRFVmOU5qqXvPHBf6aBUUdjBwTd7haDhowrjZWwF/CMJTzxI8JF2rPbp4zcPn3DXm5QyRtP/
 c81wP3ZQ7NegJSYvbQ11mee7cUd6nECl/G32jXwxfUo3AXnv6ELo5t+U4lFIVu0i7FSSmJXrUoq
 ORnTLs8mx4l200C/ErGyPShSiClY3aE3c04zIwK9i3IBcqCQTcwMiTI7IFZXyfqCPu/JyxDqxA8
 zlqvpf2o4eayG58apqTqGFtT59DoW4piVTRL3yzwJwoOnWInGzdLWSZwhpWxTNEenFSu+I44Nnk
 iSrL/2ihdhv3zwuw58hTCEUF9XuXs5Yd2XXUl3h7dVeYhYzjFMTu6LMKDA6bEwu/802LhXpQfJu
 ufVd8u8pliU5f8yuX7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604060179


>>
>> Sashiko complains about PREEMPT_RT kernels and spinlocks being sleepable
>> in this case which would break the whole point of kvm_arch_set_irq_inatomic.
> 
> Just make it a raw spinlock so that it stays an actual spinlock.

[...]

> 
> s390 should use a raw spinlock, same as arm64 and RISC-V.


Ahh, I missed that subtlety.

Thanks for the explanation!


