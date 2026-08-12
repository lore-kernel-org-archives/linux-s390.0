Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454EB336886;
	Wed, 12 Aug 2026 19:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786561706; cv=none; b=ReILAwUNlTsmMaTZGCYX/TGVyeS2+EXrXyVQfDOwipXpwlI8BK4tioQwONN8aRi/gUmmw5lAM3uTNzKAgmqnK7RzJsh0T5Iwp695E1iz3DIrJBoBo8OZtR0zv6gPIJ7zTHGX6vjFuJEWWNO+XFZjqB/6CbXno660lmywDD70D64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786561706; c=relaxed/simple;
	bh=6ELfPf5mbqig1GlJHbn3hZQXGvlgU7cLuiXfXMNty38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lzx8YmQOL377h8kK4AdynqC0O39faRU7XUJmThEXLMlrQ4kaQ4Wbodun+aOjUOFgDqyUL9fpWZAy1A1WtVHo3DrIBBIgfQU5wR4mfJaxoV11CKjqgVFKeC0XgZnCHuCr7jj6CxcagnRBi7VUtPhv3y3RfbrOpDBZyITEbg1DoMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JZyquEat; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JZyquEat"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CH1enG3994427;
	Wed, 12 Aug 2026 19:08:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iECwq4
	o9lCptjjYrX4krYdoKFeXFhTMp8ljSphMqyCw=; b=JZyquEatClu+3kcFUxgYjG
	Zn5iI+tF5/kBvYI6HY5fL5gJUaTyzuTVp8SeknTsEPMkC7rjEDf9GwtIKLD6QxL8
	pBeUIJUMKlnFM1TsLEEZaeuxEk3CDbH5N8KBzgPfsfqnypFEoplLQMabn1b92UgC
	Jg4C+kE4yakDG80k/lURi7xfpoQ0GN9PviduncSTF6/trvIqRkuThf4UtMiGqDyT
	rwL5HiWAhL15+VG9FLnER3JleBdywzN4LPlSIzesvdT6S2iVBUewIZEsVufMK4PA
	B5ViwTw7UG/2WHnH6RuwTzLLgFTLvytTN4Ap4KFsV2fwDjhSrztUqDD1rM+VNiKg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp33c1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 19:08:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CIuS6n020097;
	Wed, 12 Aug 2026 19:08:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq7r7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 19:08:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CJ819v35586364
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 19:08:01 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E669B2004B;
	Wed, 12 Aug 2026 19:08:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C35DA20040;
	Wed, 12 Aug 2026 19:07:59 +0000 (GMT)
Received: from [9.87.128.143] (unknown [9.87.128.143])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 19:07:59 +0000 (GMT)
Message-ID: <acd309b0-164f-4051-85af-38d569469131@linux.ibm.com>
Date: Wed, 12 Aug 2026 21:07:59 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 20/33] KVM: s390: gmap: Make CMMA optional
To: Steffen Eiden <seiden@linux.ibm.com>, kvm@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
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
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
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
 <20260812153631.3376090-21-seiden@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260812153631.3376090-21-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7cc496 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=1cI6C-Gj8dI5Zpl3tX8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lIBylJEy1EUnvzPXQEiS1SxJWfmCeqhR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE1MyBTYWx0ZWRfXysar7f7Dhnf6
 hrfCN6DRMCYlT5OJ2j1L2K7E4+qRLa8z17iU7xp/m70CO6jYrcoqPShrRsyLfLxinJv1gX9k8r0
 tDb+qgFtC6Ehy0wF60g0FYuYUnPM6Nn0Ad0CE2KBrbYvrsgDqiNEqjk9HN57UR9yEjkX9nT9a2j
 wcDUlB+RD2hc4adeZa8NSYFFo+IqNX/3yRfunRd97TWYKUSa4rdocTuzW+gYhCMER1eV9UUwjnv
 H9zv7CLjlrnY9X4XAyYz7zCFMzRMLnEDUVquFAdcHo4dXOPPeVwqRLIQHp8YolDQA59//xV+UuV
 2HYARoX3SY2tEEoc8DiIoUISx838xDD2nWYPX0Ld9N1+7r60YERryZ0d9EbxHav9USCPoXnBFiU
 Ze5n51xSfox6Ft52eed/fsZlhZx90OTWqrNNM6ZxLCMjkgZwhY0hZtDW2YEf9j+s+JO/q/5JyIj
 wCPzwbPkWgHGk5emmug==
X-Proofpoint-ORIG-GUID: FW7IWMGQdA2C46ZRfGmSAllX2Sly1M_X
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE1MyBTYWx0ZWRfX/tVSkLuNfHXH
 0swdNiBbqyVhlRfHdbxUcwavYxmxD9nA8/QbjmrNW0quY170KeQkSHE02ZUW8HGjkqdRljA0obK
 WKYSeGkT8/+5AtXzPFaN4LgC1ysEdaM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120153



Am 12.08.26 um 17:36 schrieb Steffen Eiden:
> Guard guest CMMA behind `KVM_S390_MANAGES_S390_GUEST`. This enables
> other KVM implementations to use gmap without implementing CMMA.
> 
> No functional changes.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

