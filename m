Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766CB3DDDA0;
	Thu, 23 Jul 2026 20:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784838427; cv=none; b=L31ESX8QFXhbeaZO22UltHyXIZFKXenGYsjDeEIz4MOron8fnY2rZswhiyrGbcbzEj5Mk0JVGNycU3ANbu36p/WU2+x/KXfrhQ7yJ6gaB68jqGHcxDEtFvMULwcD/g9REy8/RqumVRCmOjnbi7WML2DVp3yCEONGxFWPk3FwpE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784838427; c=relaxed/simple;
	bh=HSWwdwkhQoyS+fttqzVs2MDo1v5tNR7d/8LqHqcJZLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xdd9VPnxVqj9Cx0PM32P+lKrdPqI6qRjB/mA9OiMgU7suQVPFrqYbNBmR3bVEJLWGQMMWmRPSWlpVfSCn7TgbEl3mOQo4WsCd9vtRSiBJUoTM0jFEbFlQrKd+qCjCv90Dj2cKSmAyi+yPCnNx7fRchsbvJS6FTUVliqV0+ru3QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Yk6eDYF7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Yk6eDYF7"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NKHC093935165;
	Thu, 23 Jul 2026 20:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FcZYsk
	zym7UlmpJ6/MuoFFe/jaPzLd3aU6PHiDagyic=; b=Yk6eDYF7IxlFJFJLSafW+0
	qEZg8nk+y9ROMkGdQBD+o8Pb2P6W/fRXhe8+XwPaYZutifnq6xFrELUKo7H485Bj
	W/EjjglqFWFgF8KT7xQiByOMShy5r+mHghmhOFeBnCHdxSqc+1S5781c4no+osFZ
	gdIvJbF5lcFADBoLPDAnER33OdpELhkPvrpFepDkDVj9NXTRKMrHd+MM1tKrtz5w
	58bgjd9Nhfd5i0uawEf+5UAeXoIe66fBlosMV5llJEZi8HgGZfQBowgaF/6CEY26
	a64/2sQWmlwevJF9FS/UF83poETbcMbDQ2inKZ8tF3IRf+dlfE3dgci/xa/Nj9cQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kgx70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 20:27:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NKJmp0030876;
	Thu, 23 Jul 2026 20:27:01 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnahdw5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 20:27:01 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NKR0tk57016578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 20:27:00 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3527358053;
	Thu, 23 Jul 2026 20:27:00 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7656458043;
	Thu, 23 Jul 2026 20:26:59 +0000 (GMT)
Received: from [9.61.177.4] (unknown [9.61.177.4])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 20:26:59 +0000 (GMT)
Message-ID: <c86044cd-6567-41d7-a77c-23b3b34037ac@linux.ibm.com>
Date: Thu, 23 Jul 2026 16:26:58 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] KVM: s390: pci: Fix memory accounting for
 pinned/unpinned pages
To: Farhan Ali <alifm@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@linux.ibm.com, stable@vger.kernel.org
References: <20260723183440.3271-1-alifm@linux.ibm.com>
 <20260723183440.3271-3-alifm@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260723183440.3271-3-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a627916 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=dZF8wcNXC5Xnrk5fIEsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE5NiBTYWx0ZWRfX+ISCLSB200Rp
 u1z91C0aLmXzsABbs1E0uoIpcfGyxHubQNCz112+OHa2FOqCkaExevg+fgDAlGwttsgSyBNP91c
 I931Z/b6mWlfPha7lTXqbP5qeavibbLaNJ1VvcLCcrgY+d8fW9BDmmRfsbRI0Ohpj8zKnPALBh5
 dmuz+6DKAY/1I7mNc0D4SD8tLBNJNW/WxZfg2j2lhkixGZBIP/kaA5l+XKvswA/ElY2YOUnjA/p
 DPsgyBmlW4FmZurGDnQvS+UZ0JcJ63EueXR30MYnEZWIcIVVbNDgN3yaLwlXfTMSbhqyU1mgZF5
 DX4Op5ZBNmPKh/Vshgczn7sbNM4RGgUO/iOh4rYQBi9k3ewwafNHmJmHjo/Z1GSNruo5luEd8Ke
 F//+acT29ozkcex/CTfl6LcApF31M0Bv1pTyb9GGBHFnuQUCiHbKYP+NJIfhHF78F+3041uC2YC
 67dGu+OkzgvfEGfoYbg==
X-Proofpoint-ORIG-GUID: CczX-uMrp-dds-067Rgzk7Blr8JT1kyO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE5NiBTYWx0ZWRfXzYHUnPVd9x1u
 ChqpUImshHTzAfxnXlBCXe+eZo+/4WOSVLgVL4qq7O+VnWke6dq0n4lvz+aLnv1ibTOfbL/Sb9P
 KD0tGqLcIhnrib2cg4TVO+5AmnJJe+E=
X-Proofpoint-GUID: CczX-uMrp-dds-067Rgzk7Blr8JT1kyO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_06,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230196

On 7/23/26 2:34 PM, Farhan Ali wrote:
> The account_mem() and unaccount_mem() functions call get_uid() which
> increments the reference count of struct user_struct on every invocation.
> But we don't decrement the count by calling free_uid(). It also
> accounted/unaccounted the pages against the current->mm. But its possible
> the unaccount_mem() can be called from a different process context than the
> one that originally pinned the pages.
> 
> Let's fix this by storing the pinning process user_struct and mm_struct
> when accounting for pinned pages, and subsequently free these resources
> when the pages are unpinned.
> 
> Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
> Cc: stable@vger.kernel.org
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

With one note below:


>  
>  static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
> @@ -279,7 +300,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
>  	}
>  
>  	/* Account for pinned pages, roll back on failure */
> -	if (account_mem(pcount))
> +	if (account_mem(zdev->kzdev, pcount))
>  		goto unpin2;
>  

Sashiko marked a failure to unaccount on error paths after this point as
a regression, but it's a pre-existing issue AND resolved with patch 3 of
this series.

>  	/* AISB must be allocated before we can fill in GAITE */
> @@ -400,7 +421,7 @@ static int kvm_s390_pci_aif_disable(struct zpci_dev *zdev, bool force)
>  		pcount++;
>  	}
>  	if (pcount > 0)
> -		unaccount_mem(pcount);
> +		unaccount_mem(kzdev, pcount);
>  out:
>  	mutex_unlock(&aift->aift_lock);
>  
> diff --git a/arch/s390/kvm/pci.h b/arch/s390/kvm/pci.h
> index ff0972dd5e71..fdf8c7bf4ed0 100644
> --- a/arch/s390/kvm/pci.h
> +++ b/arch/s390/kvm/pci.h
> @@ -22,6 +22,8 @@ struct kvm_zdev {
>  	struct kvm *kvm;
>  	struct zpci_fib fib;
>  	struct list_head entry;
> +	struct user_struct *user_account;
> +	struct mm_struct *mm_account;
>  };
>  
>  struct zpci_gaite {

