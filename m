Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E649F39BFFA;
	Mon,  3 Aug 2026 08:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785744875; cv=none; b=Ha3TGt9rgmOWW+gPrXSGKnuZEbUOJ3W/XzB2hDcjyARBi0O+rNi++LY1VRJIwLZ9VqUKVHjRvHS5Nw8cpEsvzDHctN0CO+FU6L91igDAoWtpbRK3OY/XKlHpXA9ZWoAojnkBwubrj9Oa13IXxRtj/5SKZViyJu/Ua4vWtNNrDdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785744875; c=relaxed/simple;
	bh=6qc+33s9f83CSEwVmaONo+G8XS+KA2zRe0t9i1NJPwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LT6M4Le7XeRhCbhMeFpy+kgFZTEwrRiYkw3VXcdIrFxQKOMGxeRrtyzTDGHmx2S8Sbx84QYa2cjixfpfPJaYdspD88/2mPhxT7uxd4v2eKaMlOq7HJAHSe5n0GFy5SJdbS1rbmb26FaIFMZr4OW9zXSFlAEl1/JdYzY1JNcrevI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lQpdWURw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lQpdWURw"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672Mpp8I281400;
	Mon, 3 Aug 2026 08:14:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=10XOIX
	OWNp9y4DxsjXyZqT4Kv+AKJ+NZ2FXRcTGwml0=; b=lQpdWURwyc0brA61CmD1FD
	LvZnLOmHPmjN3k6IKI8uQEQIXdn+ZvoQAiWfvtzqM6anDxn0QRYe2cDZKq/igqKm
	KMFryQ1H0GSrQAWq++wLRWdCsbwrojPAYlzHYB4WoR8P8hBpzOQc2cBgDsOSJatI
	F3s77Cj1B8qJ6LfBUA5PPxWPn3xkO5UbP+NN0VsZ3uftyatIiobFWBxrhg2xTrkC
	HV+rQjl43FzYatTK95qqbmu1oE50JxvXTRVCXaxcM0vv9Lsa48yWNqw8F8rKOLu0
	6GnBO6SRTkHpad1QpogVg/847n7sYHGpBNOBQQn/vwcCQYqV9K4aWsdLa+aFoS4A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hfmk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 08:14:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6738BOAd013898;
	Mon, 3 Aug 2026 08:14:09 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qck0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 08:14:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6738E5bb27591148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 08:14:05 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8757120040;
	Mon,  3 Aug 2026 08:14:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DE6F20043;
	Mon,  3 Aug 2026 08:14:05 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 08:14:04 +0000 (GMT)
Message-ID: <143e8639-9936-4925-ad23-4e9a0aac9629@linux.ibm.com>
Date: Mon, 3 Aug 2026 10:14:04 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/31] KVM: s390: Prepare moving KVM/s390 to
 arch/s390/kvm/s390
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
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
 <20260731130902.654679-14-seiden@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260731130902.654679-14-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA2OCBTYWx0ZWRfX30hDQTpH8BzN
 Mz7ZiHbo5J6caYaBQ4SFjdDXZ4T1C6Tylc8FsYeJvSYQF7AIrV0N8QGjVPy/ggzyqQA2uZ9QNgB
 WQBXGqIIE0CYJUVQnWqFvdy05z3A+Ec=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a704dd2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=DErWZNkAGuNjIuNGA6IA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA2OCBTYWx0ZWRfXzdAhX5kEZcaZ
 O5+yZV3p8eVBFZ58IKEGh8MaO1J9apG1jTFEQbMJHeq40RfacAwGTqRteUJWP9224HxJrGAdNt6
 SCy3tCWqN2kisaSIwKJd3MVLLx90YJHqww6TuT+5DV0S6GFMsNm5gWmR6kI5hs3625LaQI7ujfO
 VAVXrPg9Fr6pH8VgjadrwWOtVVTmGvOcXPu9d9e1IHt++kfBpRUtplLmcV4uyZ4fgGsk18meTvM
 FbLM0KmyiKOmomJDNRkvUggKD9JPoCHPVz/7rGHpe/r9CxrcGNWN1MIDL0aEBsKe0Dmo/NEM22A
 Ja/g9VkZbxW9r6s+eAoM5Em3XsMW90IpNE0on3eQaTF7WyO5n5RzzYNAjZWcIeKBVMRI62LEsEr
 vGu+BgUGr9xnoHSd3OUQLf3ONWu3+Eut2udo4npnSG58bXhgVN1E8D7mTadcp1ZGmO70taFV92R
 CnXZMA1kcUlbTl6eSJQ==
X-Proofpoint-ORIG-GUID: QMk5RO98HClPNqqpLrqibkj0W0rVBisV
X-Proofpoint-GUID: Y1q7vD3lGqq1y6v7WS7yp9zeGfAx617K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030068

Am 31.07.26 um 15:08 schrieb Steffen Eiden:
> Lay the groundwork for moving the native KVM/s390 to s390/kvm/s390 to
> allow for a second KVM module. Move all the kvm_host definitions to
> _s390 postfixed headers. Prepare local header include guards for a new
> location. Move gamp related tracing into a separate file. While at it,
> rename the main KVM/s390 files from s390-kvm.{c,h} to just s390.{c,h} to
> match the naming scheme of other architectures. Cleanup the KVM/s390
> makefile.
> 
> No functional change.

Would it be possible to split every single semantic change into one a separate patch?

1. kvm-s390.[ch] -> s390.[ch]
2. kvm_host definitions

maybe also
3. gmap-trace change

That would make the patch easier to consume.
We can also handle that in a separate patch series (with the other s390only changes).

