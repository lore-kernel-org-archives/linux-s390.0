Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF273F0A87;
	Fri, 10 Jul 2026 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783675808; cv=none; b=fWIC6vUxfYVEIfo6JfKXDrwWuNdH/yLpd5OjmtMTOhN3vkrDBdNKkTd8+7WV2TbHc1xjXkbAu9+JrVPaWcrWUqT365gashb4Cs74313GFJGF8tSYiHdGWDLD8ECv0DIkuRAIHATm/N3KyEOH8gH4nuc4eSpcdmrEQXR7GkPu1X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783675808; c=relaxed/simple;
	bh=doz8Hlwj/veh2HW/ezg3oJBnVMyzVx17R5wG7Zcx2q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WtwZuwnxmkz31P3/PYqjprjyls+vYp4XRZIG61iO5+sv40spcqcnnJNDO6H9UHPOOize+X2WMFaTJGLKK4CrE0L1YwucFt+IqJ2DnWvWVyKk6LIQljMf2P8jZb2rEKbKJOxdgrMB6my6NRthsOyIT7uDYSLK6GT01X1uNt0pDo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M8LzFAk0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M8LzFAk0"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7mfaH966548;
	Fri, 10 Jul 2026 09:29:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VpQyt/
	ioFF8izlDeV1i5cYki+TjVmMgcphsaZLLkrzk=; b=M8LzFAk00yu1oS0f9AiaSt
	QrNrrofEHFHdc3aLFBpAHm1Q2f2/9g0QkBwITiUceWjlxPawwXO/j7dtXwJ3FuC8
	2u4viusICijgg3Vkr3FNTknWQc79at3boN3B5PXPapBRYIKBW2Tu+4gi/gf04fF1
	9GrEF/YEq7e+oqZBe9tAUW/nAo9Ua/UH7gfrHKiSOMi4JOXdn+IFpVz5/cTm66yZ
	c/vHZIRFXhmnwf8QfalYPReBqUUXEsEd/5mMtkghsBhjFwrX6Z7FHpB2qLp68JuU
	s1CVYqRTh+qKAi6XuBrqi42j/iJTN7XGbyFnz2mD0YDnQBbnLWkaGydtnQ2LGmgQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sur5qff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 09:29:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66A9Jjja025850;
	Fri, 10 Jul 2026 09:29:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgqhhq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 09:29:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66A9Te8w8192426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 09:29:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B68020043;
	Fri, 10 Jul 2026 09:29:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04F9520040;
	Fri, 10 Jul 2026 09:29:40 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jul 2026 09:29:39 +0000 (GMT)
Message-ID: <363e1fc0-e816-4fc3-8bdd-e42c7ba17c71@linux.ibm.com>
Date: Fri, 10 Jul 2026 11:29:39 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/27] KVM: S390: Prepare gmap for a second KVM
 implementation
To: Steffen Eiden <seiden@linux.ibm.com>, kvm@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter
 <fritz@linux.ibm.com>,
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
References: <20260706085229.979525-1-seiden@linux.ibm.com>
 <20260706085229.979525-16-seiden@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260706085229.979525-16-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5MSBTYWx0ZWRfX2VHv4X4FUhIq
 VDo/KfWUHFBWn0FlGGy1vzHRpdiMJAzGRrd6e7RK6beTstHnn7j265YEW+xB4HtF3iXPcsddUOE
 9QNapz9GRr44rgLSzbhVQzAOBsJl/ds=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5MSBTYWx0ZWRfX/TvJkmZ0V4Y8
 WqSUIvghe9jyZOv71ylUOXWuxLii9zS6bnLDgKeWWh6N8XGxuiDWDOXTQopBS0bbS6euPL4ySQl
 sHu2+AwETExG/uxP/7LN8Au6uilKYfxnIM1ygbe6g414wlqcStJpOxT0fK6+AiDxLK5WW4kknGg
 hVAukojNpT0/1ZSelUkxw5b4e6ATYHhrIzITHzCFxGRY2nTOfKTjSWEKusVEQHX7CaWp7V72Jjn
 7rqTj7ShU1iN3KCsQyGJy7GAn1Ca9PfiailBaK/RXbX0GSqntX/Zfa8aacJJ2s3C77pJUVeO5hB
 467xCPqnxCAN5/8UgTcSe3SBmgdMMRbDwrbQGPM2LW0JJysEELGm1Zd/Z/MKUPcMVIPeJGjp5K5
 rdBurPKueP87BOClMfrKbEFtXC/9REvsYxbSv/lPAlXax1YV0G+bIm/mHmE8u+vrtT/OgBQDx/A
 5sSfVmf+aidBwgUma0Q==
X-Proofpoint-GUID: 1W4Ei7EJiJdcySjk5xom8oxAZ3U17INo
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a50bb8b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=HhLQQuxqeRpKPWH3EMQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 1W4Ei7EJiJdcySjk5xom8oxAZ3U17INo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100091



Am 06.07.26 um 10:52 schrieb Steffen Eiden:
[...]

> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -5,4 +5,13 @@
>   
>   #include <asm/kvm_host_s390.h>
>   
> +#define PGM_PROTECTION			0x04
> +#define PGM_ADDRESSING			0x05
> +#define PGM_SEGMENT_TRANSLATION		0x10
> +#define PGM_PAGE_TRANSLATION		0x11
> +#define PGM_ASCE_TYPE			0x38
> +#define PGM_REGION_FIRST_TRANS		0x39
> +#define PGM_REGION_SECOND_TRANS		0x3a
> +#define PGM_REGION_THIRD_TRANS		0x3b
> +
>   #endif /* ASM_KVM_HOST_H */
> diff --git a/arch/s390/include/asm/kvm_host_s390.h b/arch/s390/include/asm/kvm_host_s390.h
> index 5293b0067422..7b7aa166cff7 100644
> --- a/arch/s390/include/asm/kvm_host_s390.h
> +++ b/arch/s390/include/asm/kvm_host_s390.h
> @@ -153,8 +153,7 @@ struct kvm_vcpu_stat {
>   #define PGM_OPERATION			0x01
>   #define PGM_PRIVILEGED_OP		0x02
>   #define PGM_EXECUTE			0x03
> -#define PGM_PROTECTION			0x04
> -#define PGM_ADDRESSING			0x05
> +/* 0x04 & 0x05 defined in kvm_host.h */

I think I would move ALL PGM defines into kvm_host.h. Those are certainly valid from a host
point of view, even for the arm64 kvm module. Yes, its unused but it will be much cleaner
than having everything in one place and doing these cross-reference comments.

[...]
