Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384514252D6;
	Fri, 10 Jul 2026 12:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783686623; cv=none; b=AmK4AQalrx3hPAg9PM+bL3VFSoI3zOWVjyj3JpJpWEppMaDlZKiP/j9np418n+wOdeD/btDQ02yOUL+2aCdT2RK9Pb0N7AH+erpPTFgO8AeCo2k1kmNepgVJTBZhpwi1zonaSbo80KSWvYrE0XPRdKC0/PDMNMuoX8buUJaCvaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783686623; c=relaxed/simple;
	bh=PhZSgwAPnlBoDop9grNwQcAY2o3W3MitfJlKv3etYC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HG3AN/OjOE3UH793+5IRmzuWWBNMI5kgV2iZLSnG5XgRf43jTeafMvjqEJorK/4vHqkUf8mgEetPVpnpzemAnvL+Sl3aHpCb5u1dpQJVGebZCazQ8iIdoespDmwNK/qPqsbtAdy8zKb0ykrE4uWPK4ruHRC/iEEoqju1cpVLH4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hBVVi5ls; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hBVVi5ls"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AAmbw51390328;
	Fri, 10 Jul 2026 12:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ZRq5FiKmtof79rOTnqeYURDNi5Ipfk
	crSYA8lFnk7Co=; b=hBVVi5lspoV25JGFxf7RAN36P/ezaNfopHsvQ1Mmlj5q4x
	WEdA0RH6BORMvK9KeFOCled90OqtgnhWUBv3atvndAPrI5D1gXjS7H4U8V35c/PZ
	zWqNt8duWDxr9WtWMxzi+/FOhr7xxgLRLufHPIsxDrgtVkNqIDrDYvwLB1Lno2SS
	JNq5AKs9L1oGph2s3dSAu+1ukmSe+n3zVsz2cZtInJLKdDDQyjUJPTjz1mA5zXfi
	yesCPP6a9qlsbO70hTZ1lLzEnjiIglbnE/40l/fHEMMQwn4cmFgW0PtiDxAM4172
	P8qzc+SJK6Btv+0aLcgNi51Z+ihNs6tBaF96Qf3g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sur6e7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 12:29:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ACJcNR032025;
	Fri, 10 Jul 2026 12:29:57 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0hsv3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 12:29:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66ACToeK30999012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 12:29:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4307120040;
	Fri, 10 Jul 2026 12:29:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 693C020043;
	Fri, 10 Jul 2026 12:29:49 +0000 (GMT)
Received: from osiris (unknown [9.87.147.219])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 10 Jul 2026 12:29:49 +0000 (GMT)
Date: Fri, 10 Jul 2026 14:29:48 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>,
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
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v4 15/27] KVM: S390: Prepare gmap for a second KVM
 implementation
Message-ID: <20260710122948.984749-I-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
 <20260706085229.979525-16-seiden@linux.ibm.com>
 <363e1fc0-e816-4fc3-8bdd-e42c7ba17c71@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <363e1fc0-e816-4fc3-8bdd-e42c7ba17c71@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEyMiBTYWx0ZWRfX7WS8eNGobFcg
 p76ityUvWlUX/FP+onJKVqMwQL5PVdcbvEmQcz91+n6KaGuiyUj1MlZm1e9aUc+Ic+ZpsSWPhBF
 +RTs17HRHutmXQllqpCpLv8tJGJL6a0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEyMiBTYWx0ZWRfX498DWpDFLDkd
 BNbezHuUL1Dhf/NN6+mZ+oaH2ZvPbJUSIYDlMWczbqGNvrBY5YaXNIhx8ZZfgNLLTzq0rayIECT
 0TZ+o0g4tWTomI1DXMm9EsH4sQIqi8/b/h3Mq2kRGnTp//BNU36hZ4HwZ36FbVdO2HlXy4B/JA+
 Jr5TBYux9FIVeKcLYx+Hl1/hRGxkGVjzPKE3kQS0mMbi2GnQ5r0fy55jSuG5iF43Egwp6U3dsHv
 5jkkpjIFbIdsuWExTrGCBkzH/pzIjVV7q2PPlbs1RAakU16ES1F6ZrxKtM0bWHXxYUXlEUhpq6w
 8VAF3Cm2nr0pow66ze6zGiRCGxDty1Ab688Jlr7OQQu4bynluMHxfCJtVwjFP7Mngi4X1rpnmot
 1QE8i8nGH2y7pXKF5VS1bODL/J38u6GjWWUT6T/TKZwj/+bs5CCh//abQffPgxVEkctQJpmrXIv
 F/53u1sTG7LG4Vueqjg==
X-Proofpoint-GUID: f438JKkFMXBaTFK33hUMooQphFcuOKdz
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a50e5c6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=Ly9xp4i0NRlZACsuZJYA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: f438JKkFMXBaTFK33hUMooQphFcuOKdz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100122

On Fri, Jul 10, 2026 at 11:29:39AM +0200, Christian Borntraeger wrote:
> 
> 
> Am 06.07.26 um 10:52 schrieb Steffen Eiden:
> [...]
> 
> > --- a/arch/s390/include/asm/kvm_host.h
> > +++ b/arch/s390/include/asm/kvm_host.h
> > @@ -5,4 +5,13 @@
> >   #include <asm/kvm_host_s390.h>
> > +#define PGM_PROTECTION			0x04
> > +#define PGM_ADDRESSING			0x05
> > +#define PGM_SEGMENT_TRANSLATION		0x10
> > +#define PGM_PAGE_TRANSLATION		0x11
> > +#define PGM_ASCE_TYPE			0x38
> > +#define PGM_REGION_FIRST_TRANS		0x39
> > +#define PGM_REGION_SECOND_TRANS		0x3a
> > +#define PGM_REGION_THIRD_TRANS		0x3b
> > +
> >   #endif /* ASM_KVM_HOST_H */
> > diff --git a/arch/s390/include/asm/kvm_host_s390.h b/arch/s390/include/asm/kvm_host_s390.h
> > index 5293b0067422..7b7aa166cff7 100644
> > --- a/arch/s390/include/asm/kvm_host_s390.h
> > +++ b/arch/s390/include/asm/kvm_host_s390.h
> > @@ -153,8 +153,7 @@ struct kvm_vcpu_stat {
> >   #define PGM_OPERATION			0x01
> >   #define PGM_PRIVILEGED_OP		0x02
> >   #define PGM_EXECUTE			0x03
> > -#define PGM_PROTECTION			0x04
> > -#define PGM_ADDRESSING			0x05
> > +/* 0x04 & 0x05 defined in kvm_host.h */
> 
> I think I would move ALL PGM defines into kvm_host.h. Those are certainly valid from a host
> point of view, even for the arm64 kvm module. Yes, its unused but it will be much cleaner
> than having everything in one place and doing these cross-reference comments.
> 
> [...]

Malkes sense. I'll move all.

	Steffen
