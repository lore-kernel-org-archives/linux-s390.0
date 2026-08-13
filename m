Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B9A406812;
	Thu, 13 Aug 2026 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786620462; cv=none; b=RH1+O8SlhG20jJXvsSEQiv5xOb4sOeHL724S+UrPAAmqqH8r4Y96uBm+prUw+phAiy4wSYlwd9SJ5Pa1PtqRGv/m8gX2YjMWne6edy98CtU0byzZH2dBjTURId5UdvaZkIBWgdgnLl5aySpWmuoSvdQxApvBXglFcdjCSSO453Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786620462; c=relaxed/simple;
	bh=yIhTiVPOEsFKPiF9j5r6DfdLRuGaVIzdqOE++OvgUaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yxi33FaD2jn7WAVCdAOwp+jq14gSl5omYgFT1L4usJWSUffavTlxa/r1ILXPMpMv3z1KN+5ZCSghq9pVaIN8KJBcQaB8BnmQuASOnaq20AUTZ4JYbkNVw86ckC44lyiwy0HtKXLoWZkn0kEg5ueaqMO/mOa+aqOLVqr8t0XoGUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ss2wDRbK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ss2wDRbK"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D992U71820708;
	Thu, 13 Aug 2026 11:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mg7P5W
	sXCOzHmfh+hsg5xbi6IkMZi823F1yoqXSLszw=; b=ss2wDRbKe6cAcWjKlykf/Z
	9Z7+52ixIM5YdF4DX8vFilB5rIeU7XihBeaCICQN/QSWvUXlZWPWcWWN7DZffdMm
	gn7JkSegJjUttRW4dTVuuLPEupSdCnsJiZ9DcTNjvpUaKOEGoeiSS6vg4VJmV9W8
	N/V4FQleydb4KXEqwSI+JQnjzZ5OVy4EHaFlb/2Oci9HGUfDfuim505+stjEzWXt
	oAeoBziF4Lfh7px/HSn/j753BX+3mVb6ddmsMIMS0JtW3X6cIGny0kmuOzh3uxG7
	2MT5K93XVNfnUARxSx3D/T3NzsoH9RVBi+GOT5bhnTAHOAGQ5yoy+6y7RElaLdjA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp36mct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 11:27:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DBQmae014472;
	Thu, 13 Aug 2026 11:27:19 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gjne0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 11:27:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67DBRFpA51380728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 11:27:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1B4F20043;
	Thu, 13 Aug 2026 11:27:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 381A720040;
	Thu, 13 Aug 2026 11:27:15 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Aug 2026 11:27:15 +0000 (GMT)
Message-ID: <b91acaef-f82c-455e-8b02-6eaea7e1f4f9@linux.ibm.com>
Date: Thu, 13 Aug 2026 13:27:14 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/33] KVM: s390: Introduce arm64 KVM
To: Marc Zyngier <maz@kernel.org>, Steffen Eiden <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter
 <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <867blu1ecv.wl-maz@kernel.org>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <867blu1ecv.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7daa19 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=b1A7PHJKwOOjf_JuNJkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zMBoPD5SC923-_QfaxeXCs-q1IKN7f7z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA3NyBTYWx0ZWRfXyMGgs+XRx/8e
 UwEsRJlppKGx0euHj10QxfLn55x6nwDbFXqKAQ14XSRFuZoCehEM8DCe4d5F+KJ2+hJn1xUqep0
 PS11MeDzBzauI4vKyR2c4cgmrvxAHU/8IpiHQJ2BytWyyzPGKjCrjfsU1Az2TOrurU+ed1Fg1ha
 K9sTWE0haH6eLD2dQie3TrY4vdO7XAVJfBcYjnHF4NncqmwXSOwh3QFSj6t47IHTQ+Kw763YLY3
 fSi9E1ZMV7urHwyo/GH21hlZmsvu0yfpH66ZA0s2vLzwyKNDnEvhplDucbDyvqkQl5y1CvzcIxX
 TEPezRVsXvhHQPs9+AqCShe7ZtUKba/mBqN1Pnwzh54lpN3JRwy519DYhrqEjtHrJJhoO3v7hL6
 fCXZWlnaCYASdeYlNHOAShmDJ3CLrJFS1vOrO0XgNi44m0K3XduMq5DI5QibyRIsIP6fgVMSc9k
 jYfd+CyB9J6NRjWsbzA==
X-Proofpoint-ORIG-GUID: YBJx0nVdiloQFoRHZEOu5X1RtnVPgUG3
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA3NyBTYWx0ZWRfX4j0qn2/Z+1Co
 sJUJn7YLl413mGTOREkg+qaF8kL0krJU3HcrLtV8HxFYwwHGfurRhSplNrwMYN1/Rti4jlZTsop
 g8JNIcFQ3eesXN+9XjVonNwHZ1OxUTk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130077



Am 13.08.26 um 12:53 schrieb Marc Zyngier:
> On Wed, 12 Aug 2026 16:35:56 +0100,
> Steffen Eiden <seiden@linux.ibm.com> wrote:
>>
>> Introduce arm-on-s390. Enable KVM-accelerated ARM CPU virtualisation on s390.
> 
> [...]
> 
>> Based on next-20260811.
> 
> Please don't do that. -next isn't a reliable base for *anything*. For
> all I know, half of what's in -next is broken and will never be
> merged. This makes the whole thing untestable.

that was my fault since I asked Steffen for that as I wanted to have the s390
move clean on top of kvms390/next + s390/next.
We will switch to -rc release tags in the future.

Sorry for the trouble.
