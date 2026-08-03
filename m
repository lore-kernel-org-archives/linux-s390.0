Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F647320A00;
	Mon,  3 Aug 2026 08:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785747010; cv=none; b=eBNFK74mlvNptx50hMybLvcePeTvaMQngeNSJRhCAUOSmz6kJZe+Y77sDGyimEy9E/c5IQIhgoqL8Rt2QaxRzWlOMAdJ7dcPM5E6lvt8PdraP/4O3UygaAmWMiH0feu+p28BFPSYlXUZoj0IYYugXMFPV0rmuUm4rPChiQzaG9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785747010; c=relaxed/simple;
	bh=yo+KNtLsXN56GDtrALfd4X3jxkow6S+ejmYDfaOV+LI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mg16VCUl7TIoX3u3187IxLSWkFDY3Gi0GDSvuCwVvUqhoskPIGx4Fbbl9jYgLAZ8oYuTWhWpCf4lBkVqLnjVVXQ2G5dn/CLyXCBJwQQZkHSQ+SEeDdtgDgKLSoshUldHzEFYu6vXD/aPdMf/kwQZ/IDpU8ttx6qxAYo585/dAX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qpw+8qZ9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qpw+8qZ9"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LmWK5161470;
	Mon, 3 Aug 2026 08:49:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SYHuIF
	K87+5bUM6LOB0nDq7a01LeHhJww1yZ5580vMY=; b=qpw+8qZ94BQ54RmmX28ywc
	vS8xD2zuxNbdn7SLzcfB25iZRoOStEakFKLmxVv+zrRIRTJCr29XnedrNTCaK7oc
	Z0qjhIg/FZGB6ujCIsCkPMQdavZOMcM5Ebj/7ILL8PKZ+/GZ/17DVE3gTtTqBgiz
	Es+p8XdhXTKLUhiU77aUkiAoa3eJWnwk2OpyMDOnYYTwElBCOMz7RosnlCXrMAjD
	KLmUgEwLfjKsRc1oOnDoimG9we5vMu1ECnKOOlCjgWFoXxOQgOT/EhSL7TdJ4hXi
	SdfakQ3kS6n/nxvdXZcaZJ1ICFWbobm3w7yAdERFNUrtisGv0WZqO+CC4Egr52jA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hft10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 08:49:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6738fFXc016246;
	Mon, 3 Aug 2026 08:49:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg4c9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 08:49:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6738ngie31392058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 08:49:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45AEF2004B;
	Mon,  3 Aug 2026 08:49:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D06C520040;
	Mon,  3 Aug 2026 08:49:41 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 08:49:41 +0000 (GMT)
Message-ID: <7a19835d-a493-40cf-8416-5436f344611d@linux.ibm.com>
Date: Mon, 3 Aug 2026 10:49:41 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/31] KVM: s390: Guard KVM/s390 behind CONFIG_KVM_S390
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
 <20260731130902.654679-16-seiden@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260731130902.654679-16-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA3NyBTYWx0ZWRfX57tLYQgkkRWz
 12Qy8y/Zt+mGZCkOzyBt20mrcj3AUlW3Oli7EEWKt6KlniS/ggjum+tcvjWkjP5RaYQq5LGeWyN
 AMKWppKIWkRdRkTa5fiGrSRun++/0E4=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a70562b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=czFjW9aI7Efqtg61VzAA:9
 a=QEXdDO2ut3YA:10 a=xqTU_8yi0XoA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA3NyBTYWx0ZWRfX3zTZnnv9Pywa
 pTRb9OSMR6XFttCaXYmJop98LNY4CHAAUqoQImhYds8HEvUt+S8v3eG4g56MYe2YYjtq5OG4+e2
 FFmNBF6WrWy/83MdFbjWVzRtFeketRAnoxJ2KjlMJ4IyS8rudDrB4XSJXic0+6QyXDBOnsE/icz
 Bl9nhJk9yv1HQQ+EE09788/fYMNIhsjuYFbrHLF/7tSS0dyZsnnmD1r7716nqR9LL2FO/+ugYGU
 HqfSKUvUzrXdWFCh5iw9uHF559QUioOFWSuuuEBeaeYGlSWKm8UpNdwg/WYt7iDFT/q0bQX/hyL
 v9EdXypJls8c8awkzO7bRfqDSEDXPp5uAO8VPM+G55wEr2NiVmbimgww9tVSzrxIStoUi3X3Wej
 aX6lNMDhCiW84dazzy73mWkaD+j+4WVM+8/XSx3c0EQUwmBYCofxY6guuOnlTAq6533H1BbZq0q
 Ujl+1FeKlVV6w2KZ49w==
X-Proofpoint-ORIG-GUID: 9rChTfUTMl7LT4kLYAZmQbOv70rgDKS5
X-Proofpoint-GUID: Oi2AAZRr1QF0MT55QSloMY7zhTc9OsKF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030077

> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1541,7 +1541,7 @@ void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu);
>   void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu);
>   bool kvm_vcpu_wake_up(struct kvm_vcpu *vcpu);
>   
> -#ifndef CONFIG_S390
> +#ifndef CONFIG_KVM_S390

CONFIG_KVM_S390 is a tristate, ifndef is wrong.

