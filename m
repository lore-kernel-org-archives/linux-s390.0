Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5F52253B0;
	Mon,  3 Aug 2026 13:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764010; cv=none; b=FAospJArcIMc0a9xVVJgWKJCo4dYkCU8D64k4h1gzoPrvPP7yIOqDMwi/MXG5OgLI/A09uO2tMD8YXlDwmootZfiy+8T6LD9R8tM+EgmmYucd2bD+driF2LRVz3i1BWLPkyKCHXPjfLXGSY9oMPENk+fewdiAor+M0Z3Lxs4c90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764010; c=relaxed/simple;
	bh=q5mneNeamB2J+C8EVoJLnrjp8hDOhwN7vv4k2AICaBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tq5N94fd/F6ncJQZt4KkcFz7oi0I81V38rR/clZuveF67d+Nha/QjVfiDmTG6EN4vSXuyONtB7HCROpW65yPEx8FyOxwkr0G/b7YU7JRm3ELZh0gxD3v7qRsJDDnPFDI5G9p5A0nLVk9icjjnE8Nkb/Er45grRiFmlsOdCL1op4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q48/7xCh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q48/7xCh"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673CHvFT1938136;
	Mon, 3 Aug 2026 13:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vBVOCs
	zs17sNVvCWerYuN3XW9+QBWp+ZW7e+3XNz5rA=; b=Q48/7xChOjDiNXTHxlyc/R
	qUBvznBL8zi89tmvxBjUH6u9UH1m9HcJVm+usk96T8e1L03J3oXbjsQsz8C5Q99B
	p+OjgakZUAMODnxCgYcLf1Ezv98ae7qAWjc9Lj3JqMTRulFc/kkWC9YgPYxpnhaV
	yF9ap1tmP/AljjgCgd/LnpJYQDGvYZCn2k0VEMJaMMltDpUMTCFDfuG2Ivbbrguo
	kY0BNygyKVHqwaE5CX8ZOIgQUdrJhqYUkTA3OOyCXow7NoNS/QD6lHYgHVzGBryL
	8G2W2vh02ZvvM8eEt7sPRtogrVKe+cX6bkMHgr2pL2C+tkt/ncPTOYv/3ZkutkIg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hgy19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 13:32:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673DT3gO013018;
	Mon, 3 Aug 2026 13:32:40 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugvwmue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 13:32:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673DWZ4R15860118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 13:32:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB50F2004F;
	Mon,  3 Aug 2026 13:32:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 649C42005A;
	Mon,  3 Aug 2026 13:32:35 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 13:32:35 +0000 (GMT)
Message-ID: <4a86eeaa-d98e-49f5-ba73-e9e5ce08537a@linux.ibm.com>
Date: Mon, 3 Aug 2026 15:32:34 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/31] KVM: s390: Move s390 kvm code into a
 subdirectory
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
 <20260731130902.654679-15-seiden@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260731130902.654679-15-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDExOSBTYWx0ZWRfX+j8qegV4qjMM
 xYlyTIqzaIO6x78iHrlsCuWTKvHWXnZS/rJYU6YBC3QovDbOC1kiCRCvukSRiVb4QMeaT+auK3i
 yK69FddGaiXru2oxiQYx64Nempa2TYg=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a709879 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=hThuo8U3hQNg24NIM8QA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDExOSBTYWx0ZWRfX4Pf/ru7Kw2VP
 xz/RTDct+UwFZXBCTkYE48VrSgQ3SEcm6VHMbPEPnySQTQOzvVCaas7YoGSI0FwOaEFyb/h6Cl6
 LiFI4RatQutAJSDemR+eig6/thkWDWyf1TZURRpcfzKNGCIDWx1s3mIVOuPamjvQNzUXLxoSQ1O
 a0vI3tMGZfS3wluwxO1efa3zFUQZnz7pTOZHqXN0Aqex5WxeoU/Bc36wPlmq7akvVr3jtEN+Xyc
 amMazytRDZD5ZUvJICkj8rydFPiXzdwvFKZ69qLj1L7a3eV/FkyvsfhL1PkW3xcA0ofjl83/Tgc
 LwNu8Dy57atacSv2b+bim218QUpGUF8c8Rx8MVH+dXhIwMmXE8i7xdOnJXO1uc8AMyAx4lN09zg
 Ois7cabgH794RmCejhzDitDeW6Y52D/9z7i4mofvak8s7DPKY4bEM7QRj0ALAimoen1beKuOJ0w
 vowYTmk7vWLxuygOjzw==
X-Proofpoint-ORIG-GUID: q8AI2RP4HgIDMmjG9eGtYT2Bg22EPBXZ
X-Proofpoint-GUID: M1SibF4bDBtMrIF7hzWznmxtKgmi1OQ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030119


> --- a/arch/s390/kvm/Makefile
> +++ b/arch/s390/kvm/s390/Makefile
> @@ -1,15 +1,14 @@
>   # SPDX-License-Identifier: GPL-2.0
> -# Makefile for kernel virtual machines on s390
> -#
> -# Copyright IBM Corp. 2008
>   
> +KVM := ../../../../virt/kvm
>   include $(srctree)/virt/kvm/Makefile.kvm
> +include $(srctree)/arch/s390/kvm/gmap/Makefile
>   
> -ccflags-y := -I$(src)
> +ccflags-y := -I$(src) -I$(srctree)/arch/s390/kvm/gmap
>   
>   kvm-y += s390.o intercept.o interrupt.o priv.o sigp.o
>   kvm-y += diag.o gaccess.o guestdbg.o vsie.o pv.o
> -kvm-y += dat.o gmap.o faultin.o
>   
>   kvm-$(CONFIG_VFIO_PCI_ZDEV_KVM) += pci.o
> +
unrelated whitespace change.
>   obj-$(CONFIG_KVM) += kvm.o

