Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795438980;
	b=3H4QY1JsZtwH5YIDQEcVhkvRZFw+wKd8fHzxBl+x8sRgJsPqacHBFBlAn1oOl2MlMN5I
	 URTTAYghpn6oSavCetXiz8G87fHtPKQkUWFRaN/VHUfgh20SnCkOTqvYkXHVqgHZWeaIp
	 OvtLFqLw4WHES1u+oi9mbY/wgry7ntzGaDHNoBhNukpJpl/yEQLw7cTYvQJZMjHbFoXF1
	 cU6QJpuTaL510haAu54P9jeuLMnRUpL1Njharq1hsM1F39qMeSoyxsE+m3uCvjPkwKcsk
	 iyYLgWuxGAWOdSdRxa4vs+zErOeuOXLssS+VumdOFikpVVFhf7J5973vRZhgde0i5Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438980;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=sd6mG3Bx/nhwPBMmF+KUQNMT5XN0aCjqv/klBzEyo8I=;
	b=Kq2MH06Tp3hVtWhK9fhflr/r8UTK0DayqUes/CX2B9xGdj+f6hjOQ5bf8GCwA3eInli2
	 RfKb9RceIcZY5jOItwS4O3wxAWylBITmesp9TygGfKVjPIh/lBE8vlH4oLcl3MO1ej5mn
	 GzgtzaFJ53ywRz0/HDcuisoih9BKykuTmj3VSgxeW5g1qLM9HtHdhRh5sA+s/hrU4yCxE
	 edZ8ZXTkYw9mHmZVXGEiJhfijRWliF3COVmmp/+d9ud5CLGrJFtv8WiWP/j9GN7HgcwGl
	 b0ePqg12eo8Nmg+rkNeShtAvq39ZCX20fJd8/Gm1fULKm5rMqkuSqNAuTR0QCZl9fcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JjbEU848;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BB1606A31A;
	Mon, 23 Nov 2026 13:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63BB1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JjbEU848
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANCZ57C1981609;
	Mon, 23 Nov 2026 13:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sd6mG3
	Bx/nhwPBMmF+KUQNMT5XN0aCjqv/klBzEyo8I=; b=JjbEU848XKHwXgE655cL4z
	aLv5wrCEyPTY5m/krZKfG0zAZpje36SbiMCNkiT2XrKw7Y1edrBz0EGKS0L9C52Y
	lvcxgLSLvFkzjCiWVLVBVZCgpy9nhY+igqj1HPEGHptePaUEvW1sNxSyVNgSkJnn
	yMa1fpJZ33b3AUwd4o+kkf2qCKo9uHA0J8K11kYWT4l0fXVo2evEARrWcEqg7xNI
	RbTEGLQmj+RtJOERE4+iofxDcvZzYlYn6K5egBFXaejswxH8Xca/WmXmrAZWmaj7
	wWxEAafb7LslT17MSsdh90ks9qEnAYsl+15gjX69nu2zYOzWXhkBIC5X3kRr8BbA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g338kq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 13:02:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANCJRtr1819064;
	Mon, 23 Nov 2026 13:02:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3nmqf23w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 13:02:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AND2leD31392464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 13:02:47 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3553D2004E;
	Mon, 23 Nov 2026 13:02:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC3EE20043;
	Mon, 23 Nov 2026 13:02:46 +0000 (GMT)
Received: from [9.68.16.159] (unknown [9.68.16.159])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 13:02:46 +0000 (GMT)
Message-ID: <88ed21d7-deee-4be7-ae83-a3eec9da3e6e@linux.ibm.com>
Date: Mon, 23 Nov 2026 14:02:46 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] KVM: s390: fix migration mode teardown in memslot
 handling
To: Gautam Gala <ggala@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Steffen Eiden <seiden@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Marc Zyngier <maz@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20261120075345.116521-1-ggala@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20261120075345.116521-1-ggala@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b04397b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=LV0xR08TYvLYdXShQnMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1MCBTYWx0ZWRfX0BFX6BCOJLNN
 0B94/Z+Ymhe/dEjyexfY9OQh9YbmAqTm8LoWRgn9tQVG9vW5K0g+HDOfiGuUVfeoHU4r8jvhDAe
 Aganm3yHyDV641SiyJ8pIulsNAXdsdU=
X-Proofpoint-ORIG-GUID: 4JmKci6gwdefVd5US6YZG9z-msgTQKnv
X-Proofpoint-GUID: 4JmKci6gwdefVd5US6YZG9z-msgTQKnv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1MCBTYWx0ZWRfX7/4uWZj7RNoh
 BhsCblQyUJtOjTeS6eQpoG6dgszHTqiG/bXlU0wmi7cCrXZmsR/8O6EBOCgPyxa+UVniV1JRdNP
 SW3CdfhmMArNe87pvYWW4ACykEcsZKj+RveRgPrNbEDhihoa5m1yCMiRPp/xXcKcFBh0IxoK9hT
 ejnU4xus/rnirbe/NwwLj23nJPdgp/wonxAKtWkCFAAosbRTmrRK4oVZnedERXAZqDKWpTW4mGO
 1o1qrinmyXWdi7OZM65BmO3/Bc32CM9sKK1In87pYkLuqSRwhxMT4uLImLga9NbAdz8oo3LkUEN
 KIrI1zfvyNzdxS0saI+u5zI1MBF3yTouldJjT7G0DRsUkqCpFj46YzJ7G5wuhOd2uE/rXPLYWPf
 mRg9OHezh35mkcVKYhi2fTJgngtft4wafaFMHYu1dloQbuTQDsklQUujIZqxdVv/xwVFJzxWsDY
 YIM/fn0z7MWCha1xNDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230050

Am 20.11.26 um 08:53 schrieb Gautam Gala:
> Two small fixes for migration mode handling in
> s390_kvm_mmu_prepare_memory_region().
> 
> Patch 1 fixes an error-path bug: if the mmu cache reservation fails
> after migration mode was already stopped, the ioctl fails but the CMMA
> state cleared by kvm_s390_vm_stop_migration() cannot be restored, so an
> in-flight migration aborts over an unrelated allocation failure.
> Reserving the cache first keeps both memslots and migration state
> untouched on failure.
> 
> Patch 2 is a cleanup on top: kvm_s390_vm_stop_migration() cannot fail,
> so it returns void and the always-false WARN() at its call site is
> dropped.
> 
> Gautam Gala (2):
>    KVM: s390: reserve mmu cache before stopping migration mode
>    KVM: s390: make kvm_s390_vm_stop_migration() void
> 
>   arch/s390/kvm/arm64/arm.h    |  3 +--
>   arch/s390/kvm/gmap/kvm_mmu.c | 18 ++++++++++--------
>   arch/s390/kvm/s390/s390.c    | 10 +++++-----
>   arch/s390/kvm/s390/s390.h    |  2 +-
>   4 files changed, 17 insertions(+), 16 deletions(-)

Thanks applied. 

