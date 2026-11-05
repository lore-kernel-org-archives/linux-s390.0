Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892222;
	b=qj75g6L2o4QenHzW+wfVaYV0a/rWvx0sNM6ORiLLLOFiCQGUwYOt6h50sWyFM620UYjS
	 75RFrR5qwG8oHDkB9B+xRJ197RWZTenzNGniGU9Ym8HeIMbXBcFz7bpZRh6uT4J4axa6E
	 8k1ZaktXPDIYQgws4E/69F3Nd8F+xdyqZ7vt4lKidSO3kxV0/O+yK43qbx0tFfVJh9nrS
	 2qXBY9BhtxgBl98vwXMJXbcONFmKXHtqLixiPCU8slhERQ2kETRNLOhr4k8zU14OKJJ3J
	 4pa3GdYebcqnN8fKcKi/X5HrMsLeTdEkg5QC4Y3UiXDAz1nqLRd+0xfViKnToVhUA/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892222;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=DT1BsS1jyuPyNRrdkSexz5S4IsBfNSt7ax5gSpAirZ4=;
	b=qJVL6LXesUwD2yni4lBtJmbrIQ+0lK6DGMELAxuNEX3AkquQvnHN6Y/CbgqwCpgKyIkW
	 +IUDrriBJ9yICk6GKhGs0f+nO/R9peekQSG3KDTVdKlHSAZCjynTcW7Gh06U+RsloA15k
	 3JQRk2RwX9eNKzfYowhXT/I37THp3c4DthByDBWN++EHNsIvtnX7i6DIsI9EzihjfkzxH
	 dfHMUcgUwJweQVkvVI+DLBJ2LrcjIxd79uyOXpf5hIAdxIMOXuEwsGtoKtpembQ5lID77
	 FiV5NvWjBjJT3k78gs4Lq84RkI/S36giXTqzB9UbrB67QkDfqxb6Juq73hxsSRIowmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ARGr01Vs;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0D2606A329;
	Thu,  5 Nov 2026 15:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F0D2606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ARGr01Vs
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EiRFX3788136;
	Thu, 5 Nov 2026 15:23:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DT1BsS
	1jyuPyNRrdkSexz5S4IsBfNSt7ax5gSpAirZ4=; b=ARGr01VsOnOimr7DXByzSz
	zyj5BE6I9JzdvMJytjZgAXqIUsOrnDCqTgawDKs9iwUziwTeA/VGxh2KLIdH966a
	JUMe5oHARm6uegOKdD1jSZGl0Rs2IA1/3YRGVb4vykesoFxPgEoVF2QRoZ6HZtCN
	7u8JXdjkFe1CFNraCbmF9BTEwYQZEmaarNwlhqc/uJ/eh8AAvBlVfdAhxV3fc6QJ
	SCLYLKm0tERwhV4a1XnfyyviDJUVJ4XBrcsWaHg9Vd0zoS5gUXRBf7YcXBtABjUB
	7vhkmf+R/lSRE128SWrbhvIVNDKDkfmT0jMHb/z5fzgqb3cA095811gXrwJBG4Qw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn827342t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 15:23:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EYxQv1685712;
	Thu, 5 Nov 2026 15:23:39 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrmrejbag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 15:23:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A5FNZBn13894036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Nov 2026 15:23:35 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3782C20043;
	Thu,  5 Nov 2026 15:23:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F16AF20040;
	Thu,  5 Nov 2026 15:23:34 +0000 (GMT)
Received: from [9.68.16.159] (unknown [9.68.16.159])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Nov 2026 15:23:34 +0000 (GMT)
Message-ID: <fa1128de-56c5-438e-8350-1eb4b0bb96a8@linux.ibm.com>
Date: Thu, 5 Nov 2026 16:23:34 +0100
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
Subject: Re: [PATCH v1] KVM: s390: pv: remove misleading gaddr output from
 KVM_PV_DUMP_CONFIG_STOR_STATE
To: Gautam Gala <ggala@linux.ibm.com>, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc: david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261028111651.66917-1-ggala@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20261028111651.66917-1-ggala@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iATJZcgaTipyR8iQA9cjapTOFVADjqR3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA2MCBTYWx0ZWRfX9EgdyNufDIPK
 85qUoPAUgyUXLimPw3KwxA8RA7uAK9ZPEQ/RUM0dghKoJggTzcgQDjwW5gFgV5hgUuR9ZLTiGzc
 tpTgK4HH8q5AIemleZPIAdbkGiFIxIy1PYHuNSLTJqSDWfT47rIP7qZy090RgloGGSB1pht27wh
 6abdNP8HR34X7sw3ea4c7RxL9umYjobBlKauJ7iy/gIqvIqpa+E+qUakmbSa7Xc6vc0cV3VKgft
 CEa5dk4Bm1ZpM3UGOA8IoLVfAz/Rcju0FYT7/s+dWXRjJJwJz6+1sCkCm1ftlpfp/lQe0FTOVI1
 7ytzoAA5q1vmmbAuxuT+xMLD5mDAz0WzHuvN3JrtnfPZY2FC01XZeNqbpJct/pBtReAdUHKolLV
 TcwPE4N18zpqyZjWry6dJp9LJeATmr8WpZDE4xgiPWxB7FHMQf+khicYqNFRp/oRQ90e+wxxio1
 K9xhgdHWMS/ANIpUcqg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA2MCBTYWx0ZWRfX98LVJZXfh/x4
 PILoHaROGMmliHoZP/vqX89Z3AVPF/wJggdYEuLoGQpTsiR6n32aL2Avq2CsJBAGa3OX9RLiVPv
 YhiC4p8pjj2chOPvPaC06Vqm/eFluCg=
X-Proofpoint-GUID: iATJZcgaTipyR8iQA9cjapTOFVADjqR3
X-Authority-Analysis: v=2.4 cv=EsJHPicA c=1 sm=1 tr=0 ts=6aec9f7c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=HnjXUhQ4soRVsTnYCPEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050060

Am 28.10.26 um 12:16 schrieb Gautam Gala:
> A comment in kvm_s390_pv_dmp() suggested gaddr is an output parameter
> for KVM_PV_DUMP_CONFIG_STOR_STATE, and kvm_s390_pv_dump_stor_state()
> wrote back uvcb.gaddr through the pointer accordingly.
> 
> However, api.rst does not document that KVM_PV_DUMP_CONFIG_STOR_STATE
> writes back dump.gaddr and QEMU does not use it. Furthermore, the
> write-back would not have reached userspace in any case: dmp was passed
> by value to kvm_s390_pv_dmp() so copy_to_user() in the caller always
> copied the unmodified input gaddr, not the updated one.
> 
> Drop the write-back and the misleading comment, and change the gaddr
> parameter of kvm_s390_pv_dump_stor_state() to u64 to reflect its
> input-only role.
> 
> Fixes: 0460eb35b443 ("KVM: s390: Add configuration dump functionality")

I will remove this, no need to backport.

> Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>



Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>


thanks applied.
> ---
>   arch/s390/kvm/s390/pv.c   | 16 ++++++----------
>   arch/s390/kvm/s390/s390.c |  7 +------
>   arch/s390/kvm/s390/s390.h |  2 +-
>   3 files changed, 8 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/s390/kvm/s390/pv.c b/arch/s390/kvm/s390/pv.c
> index b18abd0e29ef..a9bc32d5be6f 100644
> --- a/arch/s390/kvm/s390/pv.c
> +++ b/arch/s390/kvm/s390/pv.c
> @@ -901,10 +901,9 @@ int kvm_s390_pv_dump_cpu(struct kvm_vcpu *vcpu, void *buff, u16 *rc, u16 *rrc)
>    *
>    * Stores buff_len bytes of tweak component values to buff_user
>    * starting with the 1MB block specified by the absolute guest address
> - * (gaddr). The gaddr pointer will be updated with the last address
> - * for which data was written when returning to userspace. buff_user
> - * might be written to even if an error rc is returned. For instance
> - * if we encounter a fault after writing the first page of data.
> + * (gaddr). buff_user might be written to even if an error rc is
> + * returned. For instance if we encounter a fault after writing the
> + * first page of data.
>    *
>    * Context: kvm->lock needs to be held
>    *
> @@ -917,13 +916,13 @@ int kvm_s390_pv_dump_cpu(struct kvm_vcpu *vcpu, void *buff, u16 *rc, u16 *rrc)
>    *  -EFAULT if copying the result to buff_user failed
>    */
>   int kvm_s390_pv_dump_stor_state(struct kvm *kvm, void __user *buff_user,
> -				u64 *gaddr, u64 buff_user_len, u16 *rc, u16 *rrc)
> +				u64 gaddr, u64 buff_user_len, u16 *rc, u16 *rrc)
>   {
>   	struct uv_cb_dump_stor_state uvcb = {
>   		.header.cmd = UVC_CMD_DUMP_CONF_STOR_STATE,
>   		.header.len = sizeof(uvcb),
>   		.config_handle = kvm->arch.pv.handle,
> -		.gaddr = *gaddr,
> +		.gaddr = gaddr,
>   		.dump_area_origin = 0,
>   	};
>   	const u64 increment_len = uv_info.conf_dump_storage_state_len;
> @@ -934,7 +933,7 @@ int kvm_s390_pv_dump_stor_state(struct kvm *kvm, void __user *buff_user,
>   
>   	ret = -EINVAL;
>   	/* UV call processes 1MB guest storage chunks at a time */
> -	if (!IS_ALIGNED(*gaddr, HPAGE_SIZE))
> +	if (!IS_ALIGNED(gaddr, HPAGE_SIZE))
>   		goto out;
>   
>   	/*
> @@ -989,9 +988,6 @@ int kvm_s390_pv_dump_stor_state(struct kvm *kvm, void __user *buff_user,
>   		}
>   	} while (buff_user_len);
>   
> -	/* Report back where we ended dumping */
> -	*gaddr = uvcb.gaddr;
> -
>   	/* Lets only log errors, we don't want to spam */
>   out:
>   	if (ret)
> diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
> index e4912db67adc..1f975ebeca82 100644
> --- a/arch/s390/kvm/s390/s390.c
> +++ b/arch/s390/kvm/s390/s390.c
> @@ -2522,12 +2522,7 @@ static int kvm_s390_pv_dmp(struct kvm *kvm, struct kvm_pv_cmd *cmd,
>   		if (!kvm->arch.pv.dumping)
>   			break;
>   
> -		/*
> -		 * gaddr is an output parameter since we might stop
> -		 * early. As dmp will be copied back in our caller, we
> -		 * don't need to do it ourselves.
> -		 */
> -		r = kvm_s390_pv_dump_stor_state(kvm, result_buff, &dmp.gaddr, dmp.buff_len,
> +		r = kvm_s390_pv_dump_stor_state(kvm, result_buff, dmp.gaddr, dmp.buff_len,
>   						&cmd->rc, &cmd->rrc);
>   		break;
>   	}
> diff --git a/arch/s390/kvm/s390/s390.h b/arch/s390/kvm/s390/s390.h
> index aa0d1d062f8d..5d6c36c6ba34 100644
> --- a/arch/s390/kvm/s390/s390.h
> +++ b/arch/s390/kvm/s390/s390.h
> @@ -316,7 +316,7 @@ int kvm_s390_pv_unpack(struct kvm *kvm, unsigned long addr, unsigned long size,
>   int kvm_s390_pv_set_cpu_state(struct kvm_vcpu *vcpu, u8 state);
>   int kvm_s390_pv_dump_cpu(struct kvm_vcpu *vcpu, void *buff, u16 *rc, u16 *rrc);
>   int kvm_s390_pv_dump_stor_state(struct kvm *kvm, void __user *buff_user,
> -				u64 *gaddr, u64 buff_user_len, u16 *rc, u16 *rrc);
> +				u64 gaddr, u64 buff_user_len, u16 *rc, u16 *rrc);
>   int kvm_s390_pv_dump_complete(struct kvm *kvm, void __user *buff_user,
>   			      u16 *rc, u16 *rrc);
>   int kvm_s390_pv_destroy_page(struct kvm *kvm, unsigned long gaddr);

